Return-Path: <linux-kernel+bounces-546211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B7AA4F7CB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08531889698
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0C71EA7F7;
	Wed,  5 Mar 2025 07:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P/q8Ntel"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D35C84D08
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 07:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741159293; cv=none; b=JtB5f0SGvlb5rXWtW2sFfvwqwdqhvle4YUfU+qAkvB/s0+UUTyM3Dj6eIwvj/hlr3TO+lsB8evoxiCq/0fR+U9Tbi/7xNdfCyUd7LSgd4SuaItbCDWxO9Dtj+4kXWcrzWAO1hdoouq0C3ruPFU2X6Ex+IZgTqEd4ziBGw6sRlxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741159293; c=relaxed/simple;
	bh=FWiVbgrVSDx7efTDRnApyDcSfeAwaYu37v9yc/EX6jI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUP0QeragrtoVXukxbpxb9t2KQWVK2qYThN+esQjta+Fg1cchE9s/lHq5LUsBlqnRZJShRmsgHUuaehPCsISskXHX4SsrLyYTx/UUArNtxBALOz+3AdJw3wMIXFY5GeBGMHFOoAPhdBSK6eIZeNQlhKhzkPp6DjYx6K1bjllBhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P/q8Ntel; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac21c5d0ea0so13033066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 23:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741159289; x=1741764089; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n7E2iIxbquV5DEhVAqL/jOB6AynE5bJgRlahEKaSwEo=;
        b=P/q8NtelURS2Zi3uRe8BgP3C0gYZXu/mb1udx8hPpRQ/VLRSEMrTKmwjd+W+Jtnz2M
         wLV/9oVDrcc8DNjdsNOLHo4L26Y2y2UQrroGIEPX3bP0ijznzilLOP8KmHn4UR1vdaTZ
         ODkcTTM5OnpUky2F1acXTLYb4yxiDAy2lGC96KUauPQEwk6YVImf29B0VRq99f8M8olt
         5KMSL8PW5ddxsVI+PllEd7GoTAVUL2XYJ4PSIw7LRcykMC+jJbwI2uiaW6SrfsDnG/0N
         1jcBQk+NFK3X5cOZ50JDCVDqYoGv2ben3873F6aVLyMuCpJerSKwEGa/7QJ/pHKmJrQ1
         ArSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741159289; x=1741764089;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n7E2iIxbquV5DEhVAqL/jOB6AynE5bJgRlahEKaSwEo=;
        b=JXSHf0g93sUzhbwK0NV7JtC5w9qzrhgQW0ZQwxQ2A2Ry//rZ8lkWpy8rtQY7BjB6oF
         Ln1RlMmQxzEKu9917X68Nxnc7zIrxaehuWuGyjlJjFa41TsxRxsuCFRE0eWwjLqQhnGg
         BqX09mzB9+g576fRC7jg3a+eYfJpi6QJ2IXyT7lCpIbvvUM7NGong5Pt6GHKrgWdioPt
         P8iPzfZLZ9l416eA8lIm0JQiXYozL49GE7X/6f6qxt1sA3BMOKkaJuP/VaYOkQh+2HYN
         sdN10Ys2Wof3pe7tzZLeuVNd6o6vPmyi79P2hSKv/euNuYJY7+HzCUYZawgD3UCZY27R
         qiwA==
X-Forwarded-Encrypted: i=1; AJvYcCXlcbFRb/gf1Ru1uk/lMCEJglu1b2SiYhaYb4w2SsD7jdefOVtVL7+nOgk5OpZ/Q7a+JW6Ghe7KQ+6bFNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+P00cXS/gPABhUVyB/5IfIaBTVgrDX1jZS7z4QcqLRIiV2c+1
	Cjj+KWGDTEvBUcgum1owFC3TgT9o4ZSLhtubMItegZCU8YontSGINni07Rf9XVmyWbd0N0QfDJL
	8NTg90/ErvJbJf5353o6SQIHSllU6SQn7XPfFmw==
X-Gm-Gg: ASbGnctOSXEHjDeiqhwR7jDRbEX6N93deViEPFleskJAMckimDvvdSwcwJKIgHOtW45
	nXTpFWlM6NmikW8TbY7j6VsYJvw9ibYBurUbgMaFu8Bb7NQ3PAurLi6cnuf7hp/30iX7DNoTlwP
	Tr+wqdtMge6/whGwQFK8ndoy0Q
X-Google-Smtp-Source: AGHT+IHuApDPVDRFRbrTPuLSdVBnC7FHJHTSc8gozyAwKc2e8pXdXmijruollANCPFDROEIL6rBLbccCqt4VOclfcG0=
X-Received: by 2002:a05:6402:2351:b0:5e4:af36:2315 with SMTP id
 4fb4d7f45d1cf-5e59f3d4a3dmr5029582a12.12.1741159289212; Tue, 04 Mar 2025
 23:21:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304171403.571335-1-neelx@suse.com> <bc3446ce-347f-41da-9255-233e2e08f91c@gmx.com>
 <CAPjX3FcZ6TJZnHNf3sm00F49BVsDzQaZr5fJHMXRUXne3gLZ2w@mail.gmail.com> <20250305070521.GZ5777@suse.cz>
In-Reply-To: <20250305070521.GZ5777@suse.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 5 Mar 2025 08:21:18 +0100
X-Gm-Features: AQ5f1Jrjsdd5CDdoZsEd_DpUb66xQjOsH_XPes7FPtkCWeHTerUTjPR-8XsLj1M
Message-ID: <CAPjX3Fe-_vcVvkMvmgaVCoVU3kAXVH84rN=_77NpMUMSYw3G7A@mail.gmail.com>
Subject: Re: [PATCH] btrfs/defrag: implement compression levels
To: dsterba@suse.cz
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Mar 2025 at 08:05, David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, Mar 05, 2025 at 08:02:28AM +0100, Daniel Vacek wrote:
> > > > @@ -1376,10 +1377,19 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
> > > >               return -EINVAL;
> > > >
> > > >       if (do_compress) {
> > > > -             if (range->compress_type >= BTRFS_NR_COMPRESS_TYPES)
> > > > -                     return -EINVAL;
> > > > -             if (range->compress_type)
> > > > -                     compress_type = range->compress_type;
> > > > +             if (range->flags & BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL) {
> > > > +                     if (range->compress.type >= BTRFS_NR_COMPRESS_TYPES)
> > > > +                             return -EINVAL;
> > > > +                     if (range->compress.type) {
> > > > +                             compress_type = range->compress.type;
> > > > +                             compress_level= range->compress.level;
> > > > +                     }
> > >
> > > I am not familiar with the compress level, but
> > > btrfs_compress_set_level() does extra clamping, maybe we also want to do
> > > that too?
> >
> > This is intentionally left to be limited later. There's no need to do
> > it at this point and the code is simpler. It's also compression
> > type/method agnostic.
>
> This is input parameter validation so we should not postpone it until
> the whole process starts. The complexity can be wrapped in helpers, we
> already have that for various purposes like
> compression_decompress_bio().

OK, that makes sense. I'll add the check in v2.

Thaks guys.

