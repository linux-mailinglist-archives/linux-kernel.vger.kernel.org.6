Return-Path: <linux-kernel+bounces-404508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 516CB9C44D3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 117CEB32CF1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0B91AAE24;
	Mon, 11 Nov 2024 18:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="1EabeQik"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501FE1AA79E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731348523; cv=none; b=XEbT4ENrchD5cUXr41P+IRgkj5iFz0X/B9mGcO56WvDpPUlc43/bCiLpgnQ5c9uwVHh/VBV6YlDJW7g2QQqde2JvzEsJXjaiYki/nOWQWpVZdT9ukAKGlugz11bAq4cm/4yxP7fZleCScOFxnXE9VL7Eh61GTTdp8aXfy8mFmRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731348523; c=relaxed/simple;
	bh=7r78WBjtJG+lstyITe5Wl3M9woNyZBPqN7y8qQ3UJTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1cTcnk5psvOPB5M5ILbBMulprFDQp427vETkHcfWz+RzzO+vF6W9Hw2XLQ3IayGCVcYFZFPpdxkfgc/M1wJnAnMmaG0tGJRUkxqvtQ5HZTEqTfJBKoArd0ZrcW5/ESMu9P+TyURXOGUgynsTh71ldYbzv2q5j7ATPQbTB86dh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=1EabeQik; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e2b720a0bbso729404a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 10:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1731348521; x=1731953321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QOmy7ijgjFLLlMuZ8IKU0I/D+R7VNI4abiMd6iGq1Sw=;
        b=1EabeQikQ6z5tFmySRM6Gpq81ZaC4q1sMhMtuMSuy0oPxBiWkr5IxVYFKzVQ0kHF4Q
         6TPLLGQTt5UXc1c+P8/jBfYpprR925qK7ilJ611+xcFeNop/OHlBkGwNUYLmKgIKw+7A
         wtiKxsktvfbH4Pr0nowsrNWDEbOyptqIeIi9s4+715ewv5+xvEoMKOcd9L/cp1AviXF3
         Bgpbsc9+vEFNzZU2hMnvznRYJ5KiuH7neF737b3hJBRUYAKM2+u6KOwEh6s7ZkUR7oiq
         0FnQD8YbEfQnqiQA6ZUGs8lJmicDeGfZm5mJBJhr9mfwq4wdqdX7zYIGMWAw1LJQT1vK
         nYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731348521; x=1731953321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOmy7ijgjFLLlMuZ8IKU0I/D+R7VNI4abiMd6iGq1Sw=;
        b=jd1DMgpN4+RvcX0iEwJnqneGLbuY4BY54+U0Ki3u0UcCbTdmm/PP0uBqB1pAcp90ZO
         8C79SkYwn8wclnQxjUePq1oBxusmMGVFk1awu89NAVzY4cDL8I5raUfnxvfgUel0nxpE
         T9k7pKVspbh3uhW+/1rw1UiRBT+mMoO/skUF9rwK0Zp7LjTk7dVtiRTaPXMb4WQ2FXYZ
         hyV1kUctfO6KTkNysGBMpW9DKJQNIaE/5VtmN2hdWAohwvaiJhmm3uBZIlR9DkEVXJZl
         TUn+kNzx3GNxblq0F2swO7Wj8h783w49G/Ed+aALLLhj9dH0DRbtM+R6nN/8NQjf9mWa
         kpkg==
X-Forwarded-Encrypted: i=1; AJvYcCWpC0vbjo+LQ679h4xHeVscsXq3EhTNQoHF2ebj8mwokzKaxYbQkb7wqA1gsNQMVS7bDvKxzbEq2FtCuMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDkyqrEGAHxMG6rzMrXkpgm4ETx+fnuJngN3AHSv1ACz4Ev57Z
	GmMC/1UlOGVOdFAI1j7cFYnVOUVkA5zmCxRLL5ST7qzcDMekxDK1sJhoxAVI7Dpk6ftj4vPH91c
	E
X-Google-Smtp-Source: AGHT+IGPE2ZKsQeru0sZQhpul+kuXrvcms0uqLpRKvd07nytD1t72XT94XLjmkSYsRpWJq6hcWAeBw==
X-Received: by 2002:a17:90b:3a82:b0:2e9:5e1d:3375 with SMTP id 98e67ed59e1d1-2e9b1655972mr7528248a91.5.1731348521593;
        Mon, 11 Nov 2024 10:08:41 -0800 (PST)
Received: from telecaster ([2620:10d:c090:500::6:29c6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5f90cf1sm8802851a91.30.2024.11.11.10.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 10:08:40 -0800 (PST)
Date: Mon, 11 Nov 2024 10:08:39 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Christian Brauner <brauner@kernel.org>
Cc: kernel-team@fb.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 0/4] proc/kcore: performance optimizations
Message-ID: <ZzJIJ4QFNj_KPPHK@telecaster>
References: <cover.1731115587.git.osandov@fb.com>
 <20241111-umgebaut-freifahrt-cb0882051b88@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111-umgebaut-freifahrt-cb0882051b88@brauner>

On Mon, Nov 11, 2024 at 10:00:54AM +0100, Christian Brauner wrote:
> On Fri, 08 Nov 2024 17:28:38 -0800, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > Hi,
> > 
> > The performance of /proc/kcore reads has been showing up as a bottleneck
> > for drgn. drgn scripts often spend ~25% of their time in the kernel
> > reading from /proc/kcore.
> > 
> > [...]
> 
> A bit too late for v6.13, I think but certainly something we can look at
> for v6.14. And great that your stepping up to maintain it!

Thanks, v6.14 is totally fine!

I have a quick question on logistics. /proc/kcore typically only gets a
handful of patches per cycle, if any, so should we add fsdevel to the
MAINTAINERS entry so I can ask you to queue up patches in the vfs tree
once I've reviewed them? Or should I send pull requests somewhere?

Thanks,
Omar

