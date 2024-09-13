Return-Path: <linux-kernel+bounces-328336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E77978233
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF0D71C21015
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2318F1DB555;
	Fri, 13 Sep 2024 14:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="FoJ7BDpx"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECE743144
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726236275; cv=none; b=qYCOHM6kzImPFKYJw7o4GgpxPOprsuqVJ1Ji4HRmgV2XTI0t9/g0QAqKu5+RWUrzixw+67BZfUBZV9c4dQdupbZr0vmfY016UQanFXCda+uv8FJ/ZoQkqR3aGVm4do1cGtbp74fw2Xbv6b6Vw4PC2Y+t+8cWWsMxDNxsEFkLEZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726236275; c=relaxed/simple;
	bh=lRAFs8AFzw/PpSoN4wy5HoNo5gRes9DuFwQpRAs/ZQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/IwWqPdZ1acbZC2SY3MJuba0UwDmVAuQXZUF7FmtnKABW0CzANegI6fmJXm6SexD35jQn9t+2bScu91WkzlBOAbjl4R2ENjOJS7h+qNBSRLoX9lVIQ77Zvfx6JFw8zmkqeACp5oy2oeRmmU7QsCkTkip/XRxiL0yBnEMLwjMhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=FoJ7BDpx; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a9ab721058so288633185a.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 07:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1726236273; x=1726841073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SLksJP/rhb8eqI+HK9T7IjB9aZnFUbuXu6ZyAADYNVg=;
        b=FoJ7BDpxdim40YVUJxAmrb9RDGqP5jp1AVt5LscfcHM69DlCddJArGdxJw5vd3efTq
         Owqexb2wdc5SdkbDUGq3wjKT4LzD0Kuwc/bjqKFIjDwMZJq/3Rjc8aAB18zZ1EjTM8+j
         9LZ4dIa+pBZ/WFGeoINeywNwnVXpbf6ZbaGT1k6yRTQ8F/j5Ew416NxhreWfjuCjGtzB
         9SATmE3GPEaDN8d2uAjx0Ue0GJ1AOSPhT1n6IwiWA4Yait/InvOfZ5wEydQvEyZyAeor
         gdGs/yMZiFCsjPgW69+/XVlHJtTkuT2D8wjBi8K9++rEqUi/AMPtD35/CUbnvlsrnw+q
         cpGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726236273; x=1726841073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLksJP/rhb8eqI+HK9T7IjB9aZnFUbuXu6ZyAADYNVg=;
        b=FirK4RhZxXkzNOi6VDeeXElZ7ZogLKKN1xrtcLNPUjnMo6gJXgj2P8z5F77X4/wvfL
         SQCT9XYiPows3e7kV3TEJ3sgPRxwP5TfrBWGLm9GPTiaOTrtnUJQU52pR8mR1IK/PIiA
         V+k6F9W4u5oUlBATNwvt++1RiuahDjOVK1jdVY4y67Lc0U9EHCDMIRE1RHIMrW8Q0wfl
         Ei1ZUPFvOVP5Bez8Ab/KL8T4r4Yr+DNWCT1MZp41lx8zM4reVH9Fh6G2JhaOHHV5G1wN
         UXSiJMNnlEsZYxZkUtlVnZzcHktbIfJbzKr/7cPFWJ65WgKpzLHCJDilP4DYb+2DSvPw
         qYQw==
X-Forwarded-Encrypted: i=1; AJvYcCXW3YqDbIZvPXJSmK20Mij48Xm/owttyJp0BJkrZZuaGGyogULnk9/GdiP6JBJzJiT5GOwCqdUVZ41SqMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrDDbSE8TBbUT1EqVqQyBabJZbzFUhSnsfGBsO9B6OyKcY0fEx
	foTv/XAvXQQ8WNeh4uuTJNrf5gplLoiZKNXxjkyxRs6px4SoUwWZ32P3XGeXFNE=
X-Google-Smtp-Source: AGHT+IH4NCvGaNE+Es+iBNh83ffGpuZef2D03EDpMqVLxAngpEsawFYZLw/f5SZOMq/7k2BuNz6o+A==
X-Received: by 2002:a05:620a:4145:b0:7a9:a690:caf7 with SMTP id af79cd13be357-7a9e60bbaacmr1049715385a.18.1726236272630;
        Fri, 13 Sep 2024 07:04:32 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a799119fsm660409085a.57.2024.09.13.07.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 07:04:32 -0700 (PDT)
Date: Fri, 13 Sep 2024 10:03:47 -0400
From: Gregory Price <gourry@gourry.net>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	leitao@debian.org, usamaarif642@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH 4/6] tpm: sanity check the log version before using it
Message-ID: <ZuRGQzirtUfih7sO@PC2K9PVX.TheFacebook.com>
References: <20240906202745.11159-1-gourry@gourry.net>
 <20240906202745.11159-5-gourry@gourry.net>
 <CAC_iWjJizjQWucDbrqKGdZTcj7FFxiPN97=p1zwfnPE=sAC6RQ@mail.gmail.com>
 <ZuQ2c7XOptYMJEtD@PC2K9PVX.TheFacebook.com>
 <CAC_iWjKoptBngCj-W6axZ9bmJmhT11JMctn1m4maVvO4mzcENg@mail.gmail.com>
 <CAMj1kXF9rpKJV5Df34F_oYZ1ZVbQ8Lumiw0ZOUnpVH6Dffq-Pg@mail.gmail.com>
 <CAMj1kXGnqact9B+=uhbGCV=2zaNQQBGsTk=a-NejUjWCoWDutg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGnqact9B+=uhbGCV=2zaNQQBGsTk=a-NejUjWCoWDutg@mail.gmail.com>

On Fri, Sep 13, 2024 at 03:47:03PM +0200, Ard Biesheuvel wrote:
> > > If we agree that this needs to go in btw, I think you should refactor
> > > it a bit. That function already defines an out: label, which unmaps
> > > memory. So you can rewrite the above as
> > >
> > > If(....) {
> > >     ret = -EINVAL;
> > >     efi.tpm_log = EFI_INVALID_TABLE_ADDR;
> > >    goto out;
> > > }
> > >
> >
> > Validating a table that was created by the EFI stub seems redundant.
> > If the version check needs to be tightened, please do so in
> > efi_retrieve_tcg2_eventlog() (in the stub).
> 
> ... and actually, this version is set by the EFI stub based on which
> flavor of the TCG protocols it found.
> 
> So i don't think we need this check to begin with.
> 
> If we need to detect corruption of these tables, I'd prefer to add a
> checksum or something like that. But I don't think we should bother.

Will drop, east enough.  Will send v2 later today.

~Gregory

