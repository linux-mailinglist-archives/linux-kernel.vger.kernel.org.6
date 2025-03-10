Return-Path: <linux-kernel+bounces-554862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5163EA5A256
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA0EE7A1CFB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C176230BF9;
	Mon, 10 Mar 2025 18:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfjXrx1f"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A741BBBFD;
	Mon, 10 Mar 2025 18:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630738; cv=none; b=OQYfU0eGmofbhiDdhEz7Dah5e3sCX5hDTdfpJzLTDAPIim7RMzVh7ga1qVZhUrrr999XARvQU1Qwi+J4F3AO0zQNhK5+2sXvu53l30xbv4eEHikRVBnJaOETOs1cuMRrD5IfB/LbuAt0XCYtCMqtpHPCcajTnZCP3B6ctyV3VUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630738; c=relaxed/simple;
	bh=slArCZ/GMFS7B2yyKMcmeJft+cv1s4R49pw6mGPkuEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIFJv9X3MIP8ovfRKuSS7iFlhr72BlKC5zW7QsTuQ9XHETjoa7sXL545gNdW+tqoP35Zt/RhYM/kt9+nMR7dkbvxCdZ881AQ9Iv53Q+bBaInrqznQnwJV4zo8cIzew5FkRDt9USRfJzS+jYbfCc19hZF+PUdetLl6q7yyPct8ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfjXrx1f; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6ff07872097so4435367b3.3;
        Mon, 10 Mar 2025 11:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741630736; x=1742235536; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vaOxkDi2mh9+zqddJox7L+8/6WfF4QJrC2BHbjJV4fo=;
        b=PfjXrx1f+1ZyY5mFG74oBJmnGn8XaAZa0nVrCc5uHpva+yzwm23W0He3NGSulQswiV
         sNT9T4dHjOPdNQQ0eZdvwD8pi2AsIrir4nWpHO8VUhs8PPMDjxiRpiCcc8HOMmlluCTh
         7uD9jfYRdhhXlWVMs7SpkhLLTn3hdopMt67ND8hlJ7AvfacD7t21fJtISwhCmR7bT+qS
         1dQfDP2MDNJcNlI8aoJN0r+Y5euYF0xwe5LvxUMHGhHmEYWvn8Epv57MX5ap8eQjVrKl
         z1pdLmpgx6inTrndnSn2kU9l+zPiTm2c9rK3OOn8pu2sA290plev3cq+5WlPzty3h/2i
         8DFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741630736; x=1742235536;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vaOxkDi2mh9+zqddJox7L+8/6WfF4QJrC2BHbjJV4fo=;
        b=LxHgFXL8+EVLXKviVOvqlybaE2DjASMciB8w9x1uwrKfLEnrBRmUe7EhKyELK4gQ9h
         ExnBol0NgIXESfel9oi48fdzUJm6vs+ygTxrn9uQpClxcXVHloYcsMg4ZovqkUh5HSv0
         nGfuOS6zTs2bjhUjxLoZNLDFQBVJLJuci3aEN3iQ9AAA9FN4HVonk2Vbu19p3oAcJRs1
         9maZKKLHOeMGGdIOq1uiTQPAyLY+Cr3IRrYF/5IWVo/fFdB40SH5lddobMipwnbDtUJD
         Yk3Wegjy48z1/e36+qMKiJxZkDNdieHJtDAlhie3MwGfFKHXCgeaZyW/eQ9000kkwILx
         6ERQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO02FTfu24rtvu01kHiF047iYLIka5UG7HLxanJV/NR4ItlS26s7olbedFGbI0dSTGSIU8ozOD2nJafoi9ZLQ=@vger.kernel.org, AJvYcCXeg4vEvAMi0lO/zOT2M+GE1ky+kA2jAr4KvfldztT2X+q4q4/12BHQPmaqBtpk+fyUJp1Mx0CNbbzVSvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3GvUf8XlQiiMvahdy9P5xsiIDJFfcGiKr11TQXBzv9b3hDMb0
	b4VtJe+3ZDYcYmqjUJLq/3AydkBrxdrU5BefCX+KLSOzLUMc3/nj
X-Gm-Gg: ASbGnctniCG4WZ+e3w0VRLQ0T88gwAWeGA/qweVstJ2BZgaCtgkm5ksQ+CfzpJd5Pv0
	KHeiWpxvxkc+0UG4w3aRx+GYh6sOPUbt4d4I82ym70rKb+XkPNxBYmaGu1CR3ltaAmWi6NRgQZ+
	4Or5LIZQAotiNmDkzWmD03ly/7zdnO+kh53py4cRUm9GV9AD9ZUtZaTS6mriJJ42WLW0srKNH/n
	vSZQPUaRlbRGAZwZGwWUOZzkFkfxLcqY0W4y0mxHN6afQiGtuTcQh6pHzTTgzxf6Vr3h7UIonIQ
	LIYECc+k9z0V+fCjG9bsTqab99Fw1Hd25C3get/vRIyBSFAHjSFTVMXXwbpwcQ7tpJlthrO6oBn
	JBfxz
X-Google-Smtp-Source: AGHT+IFRcYl/U3R8PjTMdFr07SWEY10DKLdQ3ZHL9FB/Nz1XCVEovSDP78NZT7/HwtMyfetbluBHdg==
X-Received: by 2002:a05:690c:d19:b0:6f6:ca9a:e9da with SMTP id 00721157ae682-6febf2a98femr202443847b3.4.1741630735997;
        Mon, 10 Mar 2025 11:18:55 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6feb2c2e885sm22323547b3.70.2025.03.10.11.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 11:18:55 -0700 (PDT)
Date: Mon, 10 Mar 2025 14:18:53 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rust: add bindings and API for bitmap.h and bitops.h.
Message-ID: <Z88tDeoZ8lyI14w2@thinkpad>
References: <20250310161947.1767855-2-bqe@google.com>
 <CANiq72=uBYDBn2CS9OW-+S0=rCZEJFdrcBAk8yBQdNB+0Yjq=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=uBYDBn2CS9OW-+S0=rCZEJFdrcBAk8yBQdNB+0Yjq=A@mail.gmail.com>

On Mon, Mar 10, 2025 at 05:53:10PM +0100, Miguel Ojeda wrote:
> Hi Burak,
> 
> Some quick notes...
> 
> On Mon, Mar 10, 2025 at 5:20 PM Burak Emir <bqe@google.com> wrote:
> >
> > +void rust_helper_bitmap_copy_and_extend(unsigned long *dst, const unsigned long *src, unsigned int count, unsigned int size)
> > +{
> > +       bitmap_copy_and_extend(dst, src, count, size);
> > +}
> 
> Please use the same parameter names as the real one, i.e. `to` and `from`.
> 
> > +/// Wraps underlying C bitmap structure.
> 
> I am not sure I would say it "structure" here, i.e. it seems like it
> actually wraps a C `struct bitmap`.

There's no such a thing like 'struct bitmap'. It's internally an array
of unsigned longs. I'd rather say it like:

        Wraps underlying C bitmap API.
 

