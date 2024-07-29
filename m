Return-Path: <linux-kernel+bounces-264991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6494393EAF1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 943C61C215F5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 02:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652A3762D7;
	Mon, 29 Jul 2024 02:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="PQj/+y+K"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CD92AD22
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 02:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722218898; cv=none; b=bNfC2RcS6zDMMJlXHFrz+kRAkcJfm3ibW7y2a22gBAv7Eq39jlPgE9jPJPily8oczG/zCEDKEBsYcdE9gChjNhNkpOM3UYcLGlRq4Gd5ZpHWe91PwjzFbIWTtQgYUUcsCFfh4LhBj+V1GqdXYATY/lE+4kgcmamXwv1TOePfSWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722218898; c=relaxed/simple;
	bh=9JOKAbnl0he8b04+PyQhqeEJtTfE1qRPZji4NpwpJow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FItWlTohDzqaDL3bAzkZDXk0LDymkMmYksR1bsZQ/vxv6DtW3jyhGKMtNxpTymFOYXZ+R/aK9a4nChwg1qr4TMIUbF8scUgd+Ogpij7Zm8G/VQaxZBF+DYtkFJRqG7ehl/DhXwpvLlqGj0Zg8Xen13TlW0dZnQrCLEBxnXmEbb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=PQj/+y+K; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc4fccdd78so14108715ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 19:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1722218896; x=1722823696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrRqd+Oyrhy0EcKorCAT5ptkkJ3G4DrFf/cFl1MzfjE=;
        b=PQj/+y+K/Z4bBLl3UQRrs5x1AIWPzgQ22IvKve5sI+Idn0CPmIi6GxeYa8rlc+2e7K
         BCauDAGKnUtPHeZAV0W+4Wrf410M+iiTphF+REpkZLMeOFPy68yfRfeUuNEzM3/G1C+q
         kKOwL+QQ1ehzSuO3HVa6y4O3oCl8uPMI/fviSlckENVrUbfc8XVwAL2DFbu5BEhkHmxC
         m9C3YezQ57GU5hikPSEFIk5wiJu1eG5VR9LcB/CVIZBbt3EHf8FBlpSUAfjpE7vHz5e9
         KCNngv5EzQg2GrZ0GIzLOg1nvA7MfnhH4Q4XwIl/V65Wm+VJIGVgWIsZgNyTSLsAiYhu
         +jFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722218896; x=1722823696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrRqd+Oyrhy0EcKorCAT5ptkkJ3G4DrFf/cFl1MzfjE=;
        b=isRB9f41xNL51M0vt+EXbHxYK8Kxsi68k4XCQEwQihg1AOVcjphA6OPnYSJOXnRgA/
         74v3ADHeD2c9HoCo7lIzRz/d7Y2KPob/BAyPIoE90xFHkikipeyK+qX6WRXKx1Bj9wb1
         gDB+ascUqeN09vHanMS75l2NKxMJy3LHGKwtME/U/oN2otJWUmSpMleaSNkT0vS+A1lV
         LciqAZBgFDEOWrh7MG4ex5R1V4/2UC2lmz/Cl9ddF3OtboiXynop1bGmSbtwfwaqlDHt
         +5yvoh6k8fZ2YM+aKbQkku0ZbCMCpofkYaHeLMOpWttXuf3mXrdJBgMVRnxNsXKOFbzc
         SejA==
X-Forwarded-Encrypted: i=1; AJvYcCW9eRwsKPHHQEmFcZL98Es5rDZFhQCiFqPl5D6Jg8zhIIzzUZI8gSN59P5VLSpP0TR/DMnL80TuSoIJcCrDurtTjOJ6rI5bSVmZVTUk
X-Gm-Message-State: AOJu0Yx/mt6tXO9dEjwYubq3cKtt8GYds/rNHQtMipTRbWfr8ZZyAfiC
	t3gKGOEImlkVKuSX01cUvV7CMDYUK/P4m97bZILe5FVJbb/GDWS/uM76tscdaKs=
X-Google-Smtp-Source: AGHT+IHE6N32jo7B+5CO9hmp5Hk//VDlZfgBDeCgG6qwXbJpv8aDF1ERfGwz0woylJk68oJiTwbl3A==
X-Received: by 2002:a17:902:e891:b0:1fd:6c5b:afcc with SMTP id d9443c01a7336-1ff04808951mr54804875ad.8.1722218896598;
        Sun, 28 Jul 2024 19:08:16 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7cc161csm72855175ad.71.2024.07.28.19.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 19:08:16 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sYFo4-00F29b-1y;
	Mon, 29 Jul 2024 12:08:12 +1000
Date: Mon, 29 Jul 2024 12:08:12 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: willy@infradead.org, chandan.babu@oracle.com, djwong@kernel.org,
	brauner@kernel.org, akpm@linux-foundation.org,
	yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, ryan.roberts@arm.com, hch@lst.de,
	Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v11 10/10] xfs: enable block size larger than page size
 support
Message-ID: <Zqb5jNP0WEdHX9JK@dread.disaster.area>
References: <20240726115956.643538-1-kernel@pankajraghav.com>
 <20240726115956.643538-11-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726115956.643538-11-kernel@pankajraghav.com>

On Fri, Jul 26, 2024 at 01:59:56PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Page cache now has the ability to have a minimum order when allocating
> a folio which is a prerequisite to add support for block size > page
> size.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Looks good.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com

