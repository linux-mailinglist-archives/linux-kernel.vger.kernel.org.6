Return-Path: <linux-kernel+bounces-571424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D170A6BCF5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C6C189CEDA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86F4191484;
	Fri, 21 Mar 2025 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHUlG41r"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCF1BA34;
	Fri, 21 Mar 2025 14:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567509; cv=none; b=ovQ1VxWHT3j/+a/OCjeal77z3R+4M7fYqFu0WrhFO1+vw3eO8kVTTaz/9yev4ToK2GAJM0x4i0PxICo8uvEQXIjTpPhgM/vR3b5rus0e55qTmV/z7sxGXN8igttb+d47/Pbkk1TkWFI8OPWRmBhyvBIoLeopKcBy0MkK5gWCLdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567509; c=relaxed/simple;
	bh=RTQefJqTAzYLfZppY+wZsfkXVzM9bfIBw2SW56kizqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gew5QINE2FRoKEMc8Kn/dXslerqMD6iMTdqteiINbXkkbDbFn3gPkICj7a2xaTJWpnEe06Aw9+Gv2cfsKV5hElmyCQun8TxYjTTQfh3ptRvIjCPLQfU6iJpnwvPd8VXfplN8KuDut4IrcyoH3ZpvwfYU2OIsfePTd2sXXN6n8O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHUlG41r; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22435603572so38640325ad.1;
        Fri, 21 Mar 2025 07:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742567507; x=1743172307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G/qMB4nk8UO6FCZc0IM6h+rgFVIvLZFIGvxML74AIHw=;
        b=bHUlG41rJPmR2UpCcesppL8DoWMabBLQBkn3d2bgwFpozWk0Ex9XTIyXgVW866QvAN
         R1I9fPDwKQI3Obsea+1hbggctM76VIE4ZZ8cdWIoFgHBfwoVqW6+7rqv7hfh+lL6dh5p
         67zJTnfd4B/WDc3O/Bd+MidTKWh7ecCIUhap+DYET5JFKHyPE6HTfsMXFB20wMSVyIZj
         luYYfuTHfuUJ8KW5dj/AhYSjoEgL2sUSJtvwfFbA6QYrwdZcvK/rL1335TqapCDrDJ/F
         zPGAJFK5onlM1npCt+dyUnXkdQpy2Yf73KwmiGQk5PEVqL+CLYsPGDNgBynpP1ewpnfA
         CHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567507; x=1743172307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/qMB4nk8UO6FCZc0IM6h+rgFVIvLZFIGvxML74AIHw=;
        b=UPIc/j18DsZ0Nqh7eOpvIP9pMCOC7zSBx1HlZinwlUu11ON+git2p11pKBXTxiKKzN
         F5MVwo/srRNWsVDtojjidyAQmLhnFTlfq2gTdyigalWI56zvME0v7x2mIBocQ0qOVHkh
         XfyCW/qWeBob7lCc+2qNLnKkakbrqGpGl8QMazJn9jC5Qislu+5C25M82RNhMBzxIi9D
         GEvp4d0EDOHcj5dYSGr7R6cmmOBxYor29Zv6H5GO3Mn90IQSLGfv6ZDVC2XCrJ8jkiex
         V1wOyTJI2/umucfm1W+CgpERgxT6fAeYpaJitsrTolDdBTT6Jw2vdtPGBMgdNdxnQH4m
         ZOXA==
X-Forwarded-Encrypted: i=1; AJvYcCUNUcYI2AziDX8+gaSN+JE0FlYl5i6nsqvFbq7gdS2ZMau7oLYJWQY8qsEYvDlAwAYKQzd5yN+kcpoJfPg=@vger.kernel.org, AJvYcCWuCvUGmB3YEt5AuUpA9njAjzYsto8EtgnVL4nwU3j1CNfgU1cadATN2DobV9u+D/kMrmz6zieFsJ4WIYDf1o0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6DI+4FTqikJ8zODS2wWpD/bWKn5ErXRQBmyCwqQEvaymsIZD4
	VyOKkCTE88zpTDQgvruUA8yor+pOuu571CRG6c4N85FxM9AvdVxB
X-Gm-Gg: ASbGncugIY0C97NSPw41tf75jg742SrGM0vblJhoWvZgzj1X+Qt5TCOS+MBDthtDXZ3
	qaSWSk6Jw8Fy7woFm5H7cmv3zugwJ/xvabEKAdB7hJ0nfuJ1tIUutX45Q9TbVL7i+llW9Sih0XG
	KLGvtzgOD/JQIQ2Z4yUnaAt1kGfCMsS7X6wq3tM9wLt/DZKzRe2+Jx/7XqXhEJgQkVegqIuDYn3
	vC+H3n4+yRorALnQc5C7mNG8XNgGQwUmHg9bD7ItESfzwlyBZo6+pD/LAR5IQELKqLtJoNdKSIn
	+VQ5O18zSfSzppyk/6MTd+9fU1WuqC/KGDLQfDDcCMzp
X-Google-Smtp-Source: AGHT+IHA3SF38DceXUmvzTjbMwYvElk1EQpFK8FGNzT+iiLoZDAZeCHZ190P7REZ8AZ4jp/a/gcz5Q==
X-Received: by 2002:aa7:8892:0:b0:728:e2cc:bfd6 with SMTP id d2e1a72fcca58-73905a3b9d0mr6169792b3a.18.1742567506741;
        Fri, 21 Mar 2025 07:31:46 -0700 (PDT)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a28059e8sm1781581a12.20.2025.03.21.07.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:31:45 -0700 (PDT)
Date: Fri, 21 Mar 2025 10:31:43 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Burak Emir <bqe@google.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/4] rust: adds Bitmap API, ID pool and bindings
Message-ID: <Z914T_oYHvV_Zk74@thinkpad>
References: <20250321111535.3740332-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321111535.3740332-1-bqe@google.com>

On Fri, Mar 21, 2025 at 11:15:28AM +0000, Burak Emir wrote:
> This series adds a Rust bitmap API for porting the approach from 
> commit 15d9da3f818c ("binder: use bitmap for faster descriptor lookup")
> to Rust. The functionality in dbitmap.h makes use of bitmap and bitops.
> 
> The Rust bitmap API provides a safe abstraction to underlying bitmap
> and bitops operations. For now, only includes method necessary for 
> dbitmap.h, more can be added later. We perform bounds checks for 
> hardening, violations are programmer errors that result in panics.
> 
> This version includes an optimization to represent the bitmap inline,
> as suggested by Yury.

We have a tag for it:

Suggested-by: Yury Norov <yury.norov@gmail.com>
 
> The Rust equivalent of dbitmap.h is included as id_pool.rs, which is
> tightly coupled to the bitmap API. Includes an example of usage
> that requires releasing a spinlock, as expected in Binder driver.

I don't think it's worth to refer the existing dbitmap.h, because:

1. It's buggy;
2. You limit yourself with committing to provide an 'equivalent' API.
3. If you want to bring the existing dbitmaps.h, you'd just bring
   bindings for them, not a re-implementation.

Can you just say that you're adding dynamic bit arrays in rust?

> This is v5 of a patch introducing Rust bitmap API [v4]. Thanks
> for all the helpful comments, this series has improved significantly
> as a result of your work.
> 
> Changes v4 --> v5: (suggested by Yury and Alice)
> - rebased on next-20250318
> - split MAINTAINERS changes
> - no dependencies on [1] and [2] anymore - Viresh,
>   please do add a separate section if you want to maintain cpumask.rs
>   separately.
> - imports atomic and non-atomic variants, introduces a naming convention
>   set_bit and set_bit_atomic on the Rust side.
> - changed naming and comments. Keeping `new`.
> - change dynamic_id_pool to id_pool
> - represent bitmap inline when possible
> - add some more tests
> - add bqe@google.com as M: for the Rust abstractions

Instead of 'bqe@google.com' just say: myself.

Thanks,
Yury

