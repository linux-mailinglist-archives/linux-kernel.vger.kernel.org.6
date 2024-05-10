Return-Path: <linux-kernel+bounces-176030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 596788C28F1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 18:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4FA528302D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C666182BD;
	Fri, 10 May 2024 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="05Z1B4AP"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89CF1803E
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 16:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715359697; cv=none; b=dmawzuxSrhCTZdeKg5KEiCwhPn0qPZ6QiNnIjMpiSLY4ClDx0l7gYgUJiefcHBNZ1sXHB/j4FYDEz4v9wdiA8FivRtngtJF+UK3a0Xlc9a9jycQ6pjc2tB3qjMfpDgHTtmZfAZC7c8WDGxH0ngrECnUHZv+kRifbXfDipYmOR1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715359697; c=relaxed/simple;
	bh=yiO8jNHTFF7kcqKCs/YMpfc8mqHK/FjdakUlobc2/nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kU+jMPdjd8wlxYbNb7r1B0QtSx6HiFq7gq/Cx6+KiDBy3+QYI90JjO8mCtN651WKNtgr9EkeTCff1Y+6vLHPXO5a6Awu+sdcNQyqMJrFMISLD6zU0Ets5nRFg6xwetRwIATjmltyXHJ3LiKx6hIW8j7ulV0a0rM+5V79Aia65X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=05Z1B4AP; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f472d550cbso1768301b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 09:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715359695; x=1715964495; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ihZ3Sx8fPzZPf9ilujyNOqj+8UZFSphqaqNUKaRIkto=;
        b=05Z1B4AP5BWGZagONAoMCJZrbOtH8WiagbA10K7SzmA19O+KOVsGB+ezzfXR2EVzDt
         zYS5gOG13UzQ/k5D4QU9TCPEr19VmOmAL3q2yrnA1ddZGCLPSZF4l/Vb0TOEGEf20jyn
         7tTvKPTdR4XsSVxjlMfs/ZAduwCH8KtwjU++UgRv0zxU39lRMdYdQUeqhxUp0/4QkZL9
         b5e7JUnRfgFgpq1ft5BVmY9RBZ8E2EFEPcGycvn8AxyvhDzRz7ES338FG5hJcpa6VPny
         JsWZam5jtIxdNSRKygBn1wcvulxt5oJ7v9VU7+/uLjhzfOh/to7a3zifBWT6S4xvsHcy
         FCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715359695; x=1715964495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihZ3Sx8fPzZPf9ilujyNOqj+8UZFSphqaqNUKaRIkto=;
        b=rG4ihmfr48wwEWrELRhdVVjDrjZae6r4qL6DfwBkCXhgsqRbgys4Lap9FXfBCCKVuD
         CkKCJ6AVGGTeF9GP7V1QwomlDHg8tM1etw5X8fiIVJ8KTAx1pwQ4Neh+Hlo1QDzH7phQ
         f413k7nCbqFlo5OaF0BS7pVaQgP95GNTiaVijgvVgLqYo3/9eCepVqZWtvrx1dBdll5B
         3K8EN1n8ZhKq721JN1ifkao1q+bcmJ3nn3sSlah3USlMYVygNOF+Myq1lxYR+agyWvh3
         gayvmlveCwexE+ZkIwfYLHdOiOF5f7rIL/66Bqb0R4ZXw2cgToeVq2drLb46k0+6Mem+
         1BuA==
X-Forwarded-Encrypted: i=1; AJvYcCVy3o9KtZRFTf9AR6O51sGv40uAs/zRXgK/DZPSaF+FD2Il6bwYI8qYNjDvs0W7o+adq5j++hdQUyrCp5ZWxWG2orCL2UNjbxwRMbFT
X-Gm-Message-State: AOJu0YzbVsPvFhGjSFHLkL+GO8LPzdNOTqCd7mF1SZ4qzPflvksWqe12
	nIvVdSg9bLUYnsurYffyefgpkWPBWn5lDRVNZ9xFgDT7s9iBd/iAuY1N+Fi5DWY=
X-Google-Smtp-Source: AGHT+IHpLEI/3ePZ5JdKRtx4wdWEQJ1myHQJQ3vtQl1flGWHwP5k0zJUfUFc7+OdJI6VS+bLHZLVKw==
X-Received: by 2002:a05:6a00:4b04:b0:6ea:749c:7849 with SMTP id d2e1a72fcca58-6f4e02addcfmr3859246b3a.13.1715359693460;
        Fri, 10 May 2024 09:48:13 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:629e:3f2:f321:6c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6341134705dsm3256924a12.85.2024.05.10.09.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 09:48:12 -0700 (PDT)
Date: Fri, 10 May 2024 09:48:10 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Song Liu <song@kernel.org>, Xi Wang <xi.wang@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jessica Clarke <jrtc27@jrtc27.com>,
	Andy Chiu <andy.chiu@sifive.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] riscv: Support compiling the kernel with more
 extensions
Message-ID: <Zj5PykF18T1+RMKr@ghost>
References: <20240507-compile_kernel_with_extensions-v2-0-722c21c328c6@rivosinc.com>
 <20240509-uptown-aging-5bdec4730d70@spud>
 <Zj09IUE5k1EJL08X@ghost>
 <20240509-google-passing-3e7577235c44@spud>
 <Zj1UUIY8RYV1kJLM@ghost>
 <20240510-okay-trade-8826cb134979@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510-okay-trade-8826cb134979@spud>

On Fri, May 10, 2024 at 09:25:37AM +0100, Conor Dooley wrote:
> On Thu, May 09, 2024 at 03:55:12PM -0700, Charlie Jenkins wrote:
> > On Thu, May 09, 2024 at 11:08:34PM +0100, Conor Dooley wrote:
> 
> > > Maybe if you read what I wrote you'd see what I was getting at, or maybe
> > > not as I might not have been sufficiently clear. I'm not saying that this
> > > particular optimisation is not worth having, but rather than I wanted to
> > 
> > I seem to frequently give you the impression that I don't read what you
> > say before responding.
> 
> Does it happen frequently? I don't really recall it annoying me before.
> 
> > What we each view as "important" in the kernel is
> > different so we come from different places when approaching a problem. I
> > respond in the way that I do not because I am not listening to you, but
> > simply because I have a different opinion and I am not explaining that
> > properly.
> 
> If you're trying to describe a different opinion, responding to the bit
> I was talking about, as you do below in your latest response is ideal.
> Responding inline but not actually addressing the points I was making
> did make me think you were [un]intentionally ignoring what I was trying
> to say.
> 
> > > see why this particular optimisation was worth maintaining 3 code paths
> > 
> > I interpreted the "3 code paths" as with Zbb + 64 bit, with Zbb + 32
> > bit, and without Zbb. I directly responded to that by saying that we
> > could eliminate all of the code paths that are not Zbb + 64 bit could be
> > eliminated. I should have given performance numbers for these alternate
> > cases too, and somebody should have asked. I agree that performance
> > needs justification, and I understand that I did not provide ample
> > justification in this patch. All other architectures optimized these
> > code paths so I figured that was sufficient justification for riscv to
> > do the same, but I understand that it is not.
> 
> And hey, if you look at the commit in question, who acked it? I'm just
> saying that I think we should have a higher standard going forwards.
> 
> > > for but the commit message does not detail any of the benefits, and
> > > looking at the cover I discovered that it was not tested in hardware nor
> > > seemingly with a real test case.
> > 
> > It's hard when riscv currently is very focused on microcontrollers.
> 
> Zbb is actually implemented in hardware, so testing it in the real world
> is not a barrier. Palmer probably has a JH7110 board that someone gave
> to him is not using...
> 
> > These changes are in order to help future hardware that is more focused
> > about performance.
> 
> I'm not replying to most of your response rn, got other stuff to do, but
> what I was trying to say is that I think the point at which optimisations
> for future hardware/extensions should be merged is the point at which
> those extensions are no longer future.
> 
> > That's why I contribute this upstream with the hope
> > that other people, like me, care about performance.
> 
> Heh, that could be read to mean that I do not care about performance,
> which wouldn't be true.
> 
> Cheers,
> Conor.


This is all a good perspective for me to keep in mind when I look into
performance improvements. I will try to get my hands on some hardware
that I can use to test so I can have some real numbers!

- Charlie



