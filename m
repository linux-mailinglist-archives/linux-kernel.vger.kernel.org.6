Return-Path: <linux-kernel+bounces-551394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C039A56BE5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E087167807
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E79D21CC56;
	Fri,  7 Mar 2025 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ieGIXdj5"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285FF21A92F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741361042; cv=none; b=brHsWa5V4Su6HRnbYurMenZ1brKRjxPfqbi18C1Pz8oD+VcZGI1pBwbwQL6secYOpV/evhAqBm85mgfQ0Q5J2w81nHolawSkeuupPbKtawEItEpRNnTkTCXthx0gqQfh42/u0Qwn2CGThnWNXxVjMd/vYW+MyIjw1SlA0/QJoGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741361042; c=relaxed/simple;
	bh=5Ddx+q/c8SbHR5ZT9xmJ6bE9u8Ymk7ZsCh7+4xJviHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sp9iJP+04peoKEn/2wrVu5HkvmeH8/YeGAp1clZ/VYZr909WNoDPtgVmvKLlSBRHR8ero+xFVIhCK5d1pxdRLl2ymZO/PIuVZDWtd1DVGfIO56ZXgUb6YltMwJOLkQQEs6XHLZfhX7fzY6eIKxSKW/+0ugelvLe1unAe1ELpMD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ieGIXdj5; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e8fc176825so12005376d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 07:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741361040; x=1741965840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bQDpIx1LDvx0gmjHl2Xaz7imPvceKHnW6AENwjXSx4c=;
        b=ieGIXdj51gCe/pxJ48hZUboCeQrIJ8vJDBp7Bc52ENUyD0CayeSVkl40lUYLjibZou
         nGqhHYUHFziGL16GuhKEld7GXGF2V4LyZAq70idH3UyNb64RndbEovjC75iEkXSWeMfz
         M+Ksk7sGGKtLVvv9fsktX75bz9ygqba3XUPijXkQ6Ao9FmNtpUnlfJ0dDCLitpV2KX/G
         X+uzKEP0AVYeT13RE1ve2tXilVktPH9LAOHNW5/A/T6iMCgpH9WJBvzSZ0XQsNw+7Yt3
         SEE/Qom0BCHiiHTxKjNQTC3skjEYdeJZKxIrr+waIpikdqo9sSlYBe62BLexPs4C8CHj
         WVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741361040; x=1741965840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQDpIx1LDvx0gmjHl2Xaz7imPvceKHnW6AENwjXSx4c=;
        b=GyqBN2GwEGIE7JIKmnYFLqYf3tS3FT+1QTJ+AFxzoQoWb382V6OkjgFkVGF2JWvGuK
         xJrqHvGliev3R33cQrC+1/qeTcNJj+l6gVBFgwQv9eXF/mI0ySOMpqXe6AOFmAZ+HfFM
         WiXPF/j1P1gvEduRHx/FIbx+Nk0F7o12SRNSiNme0tmxiTQjkpEUHgv2yE/N72yEXMRO
         eoUt8pXyWr3awcRZmM+f1V0jq8lltSfifPhhfx1LE02HrUN5DLA1wQ9yrNYEh7/z96xU
         RUznIjqdgbhJ7mZGjJgAG87Uoysw5lgRUB0BpuA9OS3tOdQq5mnrmf3thAxO5c/Trma+
         CV9A==
X-Forwarded-Encrypted: i=1; AJvYcCUdrsinaFIKl0J8NfkjIuj+xL2BMyPha5chV7BQq/ggHSwKoP7kDXWLdj1u70rIqoSQCk73o/aMm3vKNEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ZK3VDy+07nubyEa+KiEq90ryedP0gyHP6ln9rn/EhulXtTOe
	gI3dlpsMfm9T0lB9VXJUH3DOfR8gN/z5F9E8XyAFrMziHvDeGvOKk6d/qCTsQyc=
X-Gm-Gg: ASbGncsE2DZ1iX7BvxxVs8CksWEDsROBpiMOYtHMq9H8DqCx0saGrEl2W3E8oXyRNdH
	38ST1QQe5FiTQPuPmannJdWuKc545sMeUJhEcigrFFyC/BcMyDWW+3+JBJ6fRkm9zLgX4td+aC5
	Vt4kKyIDCJ89fMI2+mjP2WO+rWzF9s2oZwiFpYyV+ZEdP43ahqSTcA1lE7Cy/5u9j979fCHuiTT
	Vt++ylyIOJ5NL7q6XBscyKjm5JUY8cgS09EDPQqjhztPvQMjQTSj9fhoBB/QRDwJmbjJe5cDVhx
	GY/VShXX+ork3KpZtR95Z/+8O1aD+8vDeVtg91sFyfDGAclXbCXFDd4uN5caRApXSofPlKA2iRF
	oCZR3dhduW36aVC3Z9DibGO48q4w=
X-Google-Smtp-Source: AGHT+IH76rdNmbl5bYxxi2Ntlx+Q9KC5d6ItHMqrKmo47yrPqKQ+dtsj3ZlBapDNCUyzNnFJZtFvHA==
X-Received: by 2002:ad4:5aaf:0:b0:6e8:ea29:fdd1 with SMTP id 6a1803df08f44-6e9005d4500mr51843746d6.3.1741361040000;
        Fri, 07 Mar 2025 07:24:00 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f707bf64sm20530746d6.2.2025.03.07.07.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:23:59 -0800 (PST)
Date: Fri, 7 Mar 2025 10:23:57 -0500
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH 4/4] mm/mempolicy: Fix memory leaks in
 mempolicy_sysfs_init()
Message-ID: <Z8sPjdXmFGO9-y7D@gourry-fedora-PF4VCD3F>
References: <20250307063534.540-1-rakie.kim@sk.com>
 <20250307063534.540-5-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307063534.540-5-rakie.kim@sk.com>

On Fri, Mar 07, 2025 at 03:35:33PM +0900, Rakie Kim wrote:
> Improper cleanup of sysfs attributes caused kobject and memory leaks when
> initialization failed or nodes were removed.
>

Is this fixing something in your patch set or fixing something in the
current upstream code?  If in the current patch set, roll this into the
patch that causes it.

If this is fixing something upstream, I recommend submitting this
separately to stable and rebasing on top of it.

~Gregory

