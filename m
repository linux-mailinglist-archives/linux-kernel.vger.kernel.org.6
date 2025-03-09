Return-Path: <linux-kernel+bounces-553393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 479E1A588A1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 22:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A75D1188DA14
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 21:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBCC21D5BD;
	Sun,  9 Mar 2025 21:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="mZJxB7us"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518221F5827
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 21:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741557074; cv=none; b=Kl+mRnX7VVGqd3kZO7OO/0O7PM76fVy4vys9R+83Xr+bSG+/B5v6I0GpMqH21wL/nZSFtLKhii1c3kCcc8boG2nI29xLu16KrAOhoAwRSGt7mEZ3Kg/w4AO0whTgkMhuxsbhDeJIph7I1Rm356yOroPV05rCFIbHOg9McDZU8Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741557074; c=relaxed/simple;
	bh=F1FrAhqe1gDWi8xlo4HpXF2wBOUM+KcW2zALRt2drk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pok1pSDMGougSVJUVM2RLLDlP0zBHjpOEo5h6mfXytTB5OlcMaSUGj90LlJ6Ce8bfhxN/nQY65tqQ1XaDr+V4MZrna78D5yiWDgsdMxt2XOGFimHwfrzWegrDAwEJSG9utqnxP7m0lNbvX6XXnb8oG60e8ThpdTakGvVEm1QVzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=mZJxB7us; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-224171d6826so45863145ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 14:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1741557072; x=1742161872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wtQlZm6zttB+fiTHsUvomrcaKMWy8CxBSny2Xz7D1/k=;
        b=mZJxB7usCFOpdhMxPogYwsPajD+HSuIwxBZZ264YG/qFwEE4TDPUEDhCO0A6O8g6uC
         b8Nv/cmIOLpi5rs6ASLdBg/ZxEkcNZ75+NwIB5cltgpCgtco1X7VJR2u0rfSi8G48Baj
         S/SYev6baCCr2KQz9WsNsa9U5I61qijAKqyMXLfbYm+FW8PEBPlj8gzgj1WbF/cI0S3E
         Kk88vPHJUehFKpNANCYW2Xznb8IB3eBAT4S62UYoTSCETVAqYQYWFR2vPpLDpdFkd8Mw
         obz/4PxFBRptgHlVgngNgyt9VntWKnsq8iD12ixEyvlGUyuaWzV5vcwr7ABhhiJPyNC5
         xVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741557072; x=1742161872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtQlZm6zttB+fiTHsUvomrcaKMWy8CxBSny2Xz7D1/k=;
        b=bSKFRiJtZDpmis5KEsiDZsSG5TqWzflaCBUII/1522jd3j+iIUw6bBAU1gIDeCfjiU
         /9/DGr6qjDax16peT7OEQM9l1lu23GapHP4gVpRhXrBn+Cuh2hxmNwORp9nyhaJZNWha
         /8vrhWWawM7T1U1WrREZCJo4cqzbG+vMESyjAvsbfvQvfL8Nx/SGJJVwD+pKAV86XyhA
         9YGiOKrJk8bv4R3FoD5EYOFnQdGiV9D8L7MloPZnEHe5uSBUl8xxbyOHfyjvhWDnDV8b
         Ua5KBgCY6qplnVttfiqRoA6UhMQh4yU0WIh888SnObJ2Ul3/SAj2dnSWuKO1Ha0AocbP
         6l/w==
X-Forwarded-Encrypted: i=1; AJvYcCUnbutJ4kOg5dUmvF68nKgZkBR5zdKjzk/wl6Dh5tFKKJUhdGVWleK7rSFD9KZb7oWBrYwdewG26JOjUrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEcOv2Hy5VdPAPGGbLoTKJqccOAsT2OV8iw5LW9gzIkddtUwzG
	G2e/MBsneb5b0YoaYkdUFH6FZV9nsR/n9pvO5Hz0afXg3qFNyIe/vJfzhj8G16flMZoGWj6glh2
	K
X-Gm-Gg: ASbGncuaVssg5XhmKWGGfzCi6jyPAS3o1mD1UJP+q99HwZ7jkTFjOL9IptnRUKOAXGs
	bWn5VeAjI/SdQgQBVWpMYIUy1en/tW7ZrktQkvAdPmL6m0CfbQqS+spCeprf6wmRg3F1ON8AFfw
	MyyTpCOu08mXHExIB66XpdZPrJtPDOqmSWmFwhfr/xvFw1NrsMoqG+KsM68/Oe66p74gYGK6DgS
	o28lFGj4lBHjH870UJ1sdrbmRDgh0B0E/Ysnc6hBVn/GDiqTgFuFTmiF1UibY9hNCU9EnKEDx3Y
	jcI+a3Dhq54RtuiOcnKR/ldIEqc7Kr2nQ+lhhypapQh6r2Hd11tpp/rM7sid3gpaaanHyLR/BNp
	NC9OtqV+GuX1OJLko5KOT
X-Google-Smtp-Source: AGHT+IFmE/y2ukJ1h6orczK3sejJrk1ZhdcmorRtk38tGOzGDUfVjo6i5W3u8DPicjhnFh7GQsAsuA==
X-Received: by 2002:a05:6a20:4393:b0:1f5:7873:304b with SMTP id adf61e73a8af0-1f57873325amr2358526637.26.1741557072470;
        Sun, 09 Mar 2025 14:51:12 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af50b2d4c9fsm4345121a12.76.2025.03.09.14.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 14:51:11 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1trOY8-0000000B2Ns-3N8c;
	Mon, 10 Mar 2025 08:51:08 +1100
Date: Mon, 10 Mar 2025 08:51:08 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 05/12] iomap: Support SW-based atomic writes
Message-ID: <Z84NTP5tyHEVLNbA@dread.disaster.area>
References: <20250303171120.2837067-1-john.g.garry@oracle.com>
 <20250303171120.2837067-6-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303171120.2837067-6-john.g.garry@oracle.com>

On Mon, Mar 03, 2025 at 05:11:13PM +0000, John Garry wrote:
> Currently atomic write support requires dedicated HW support. This imposes
> a restriction on the filesystem that disk blocks need to be aligned and
> contiguously mapped to FS blocks to issue atomic writes.
> 
> XFS has no method to guarantee FS block alignment for regular,
> non-RT files. As such, atomic writes are currently limited to 1x FS block
> there.
> 
> To deal with the scenario that we are issuing an atomic write over
> misaligned or discontiguous data blocks - and raise the atomic write size
> limit - support a SW-based software emulated atomic write mode. For XFS,
> this SW-based atomic writes would use CoW support to issue emulated untorn
> writes.
> 
> It is the responsibility of the FS to detect discontiguous atomic writes
> and switch to IOMAP_DIO_ATOMIC_SW mode and retry the write. Indeed,
> SW-based atomic writes could be used always when the mounted bdev does
> not support HW offload, but this strategy is not initially expected to be
> used.

So now seeing how these are are to be used, these aren't "hardware"
and "software" atomic IOs. They are block layer vs filesystem atomic
IOs.

We can do atomic IOs in software in the block layer drivers (think
loop or dm-thinp) rather than off-loading to storage hardware.

Hence I think these really need to be named after the layer that
will provide the atomic IO guarantees, because "hw" and "sw" as they
are currently used are not correct. e.g something like
IOMAP_FS_ATOMIC and IOMAP_BDEV_ATOMIC which indicates which layer
should be providing the atomic IO constraints and guarantees.

-Dave.

-- 
Dave Chinner
david@fromorbit.com

