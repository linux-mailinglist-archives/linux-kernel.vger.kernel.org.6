Return-Path: <linux-kernel+bounces-556156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A98A5C193
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D3CB7A4BCD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F48253F3B;
	Tue, 11 Mar 2025 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmPFYSKF"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5F0214A9A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741697059; cv=none; b=aR92Fukiss7mBGLQTZOpGa9UqxJK8TLVcBILwM+nPkNo5XMsc2y6CuFEhTWCRh/XFUFm2tgu7wGr1Y3dZbMYuzArbWBq5b+Se6xqYezWxlBI8EznH7ngffPxyxiD2ybps6WWMWABJdgTyj1RbjOI3YTqemZrJC3EyEdkCAjumxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741697059; c=relaxed/simple;
	bh=gTYyejWsFNlkaOkOvzvafCWEzbM9F8F/DqOTjyHLBRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2W75M3d9Lxe+uXYJTXfjHMFYjrOC4v9mBk9vYkMbEUhbiXvLjrFvtjrYaud88OCZqvMYuCEoFpguSgijX6sw8MGSm8K69LyQxQsouhadL/dRRIA+MBlWGU+XyDueRl7YjzxQwhtpkZHcx+68yrHZLJY+WYlM6vuewKVd4PkZFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmPFYSKF; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5b572e45cso9829895a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 05:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741697057; x=1742301857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KAxTVq2MkmffpCsIoG9Vx8XOOm1e2JNRTwJ0699I4wM=;
        b=BmPFYSKFJ7WM1gkm5okzuCA5jGbjbpqqqNp3lq4ZD4u+U6UUNrkg4yYHOObNpPXGDL
         X7CcfwTC8G0eCTIGYiJaGgeAuAc/LbUMazwtdaWMaoMfY3tq2OUoDZmyHUXjGDxXUtsj
         /mCvRBtoqUk5sBHfsYr9toDs+4eeBQupivpOYntVIVHrzQ6uwI9avACV2D25DKT0qPT4
         urLy7kG9hr/D4/erxRDLBibWGwYtfrk1bMUmXN+lCfkXLSuEjoWJIxs2Gs+hSMPTx6Yy
         TYNsjenqRm0RG4DpmuiMFWBxJlwPqKvixxs1N/N97KSdK7STDDF6uOpjFs1Q92BQP6/i
         U6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741697057; x=1742301857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAxTVq2MkmffpCsIoG9Vx8XOOm1e2JNRTwJ0699I4wM=;
        b=B1XJX855/bhxCgzgAMTolic2UktuS1FEiczXJYpHutmF6+oyUwN3zWqK0y+jRmqxrk
         4/+/mP6UsPgYelsNFsK7XTooZtc/KgohcRUm72CWf4bihEyNYlYKmNZyyJK+cXK4yXaV
         Ut+H3PFmEQytR20dYYeqwJLG1WV7Fh7N5B2aqzmf8KMpQ6YkoJ5Qmg7xg+EaF8o7I3TV
         vhrSsrh/R3qdoKvx3dnVPa3Ll4hcSGNQusw4ehQbepaFZoqnBL18cmmIEWcKFIiG/sW8
         hKqiX99LqtqlenBjGAbSUG5jdz0uPsug3wUVi/ZBzbSTcGdLs9VfmwBmayBXyI3XH/pV
         d8wA==
X-Forwarded-Encrypted: i=1; AJvYcCXFwReFYKx4TDABORVyTvmm7bAaY1eGdqs7e6CUffVQjbKM/CnxqMQ/jL6ghorFtePLBjRLKjhvCkkxfVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOUz6ZwNVXB8B63druKmReIcvaZ4TusCsSyR1ERRIChhiA8QMN
	8HKfCdlE26suMente8D7JGBfrQYRPiqJY7gDSQDIEc3ALJYTbbwo
X-Gm-Gg: ASbGncvEEbAnFTl3UubJnllh9O3hk80J93LA/vGVW6Y949B/xXVAdD2gdY9M/XbMr1c
	FzBpgPaGI+rK/yNc2oKolMOccXKbcTUvKerN+IdpsiKQYD0T0jcTNSX5HKKm5quJk2XfgDnAXvD
	pPt107ENWgfZswhzsHLYDRJrGJ8For/huOVdofBy/FhoCSLoI4JrtPWR45PzatGak4Id5O+k0oP
	Aox/1kPCZgdzinZWG7Juupjvm0CmsQJ5q5DJAiQZT6Cg0WcjwzFiCymws609P/RlX4/GyFlXkJ8
	IQttaaCCMlgRMOV0C0y0Cs2h7TWop6UZGjGAq+Yl
X-Google-Smtp-Source: AGHT+IEO56Nb9J2khSBHRHHVBhO30LQsgobeKL8CBisjIMZ6nYRRy/fBVYFBaFBes9nMuhIvDJu9uw==
X-Received: by 2002:a05:6402:3581:b0:5e5:b7d2:d425 with SMTP id 4fb4d7f45d1cf-5e5e22db495mr18901947a12.8.1741697056272;
        Tue, 11 Mar 2025 05:44:16 -0700 (PDT)
Received: from andrea ([31.189.82.201])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c768ef30sm8283422a12.69.2025.03.11.05.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:44:15 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:44:07 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: Andy Chiu <andybnac@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, bjorn@rivosinc.com,
	puranjay12@gmail.com, alexghiti@rivosinc.com,
	yongxuan.wang@sifive.com, greentime.hu@sifive.com,
	nick.hu@sifive.com, nylon.chen@sifive.com, tommy.wu@sifive.com,
	eric.lin@sifive.com, viccent.chen@sifive.com, zong.li@sifive.com,
	samuel.holland@sifive.com
Subject: Re: [PATCH v3 6/7] riscv: add a data fence for CMODX in the kernel
 mode
Message-ID: <Z9AwF5hwF0ES9Grl@andrea>
References: <20241127172908.17149-1-andybnac@gmail.com>
 <20241127172908.17149-7-andybnac@gmail.com>
 <87ldtck8k0.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldtck8k0.fsf@all.your.base.are.belong.to.us>

> FWIW, the for S-IMSIC the write is already writel(), so we'll have the
> text patching and IPI ordered. Regardless, there's more than one flavor
> of IPI on RISC-V!

AFAIU, this writel() is intended to order the insertion (and the initialization)
of the CSD object before the MMIO writes; so, the "right fix" seems to turn the
"other flavors" into using a writel() or providing a similar ordering guarantee.

As a bonus, such change should address/fix all current and future occurrences of
the message-passing scenario in question (the patch addressed the occurrence in
flush_icache_all(), but there appears to be a similar one in flush_icache_mm()).

Or am I misunderstanding your previous comment?

  Andrea

