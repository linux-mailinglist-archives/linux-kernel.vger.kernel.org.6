Return-Path: <linux-kernel+bounces-525535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8858A3F0F6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8446419C111A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83111204F79;
	Fri, 21 Feb 2025 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zx6c1AIL"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05E61FF7D7
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131300; cv=none; b=XApaM0uMbVYFYmi6Wc0kBf0RfjPXVHAdHuCz/UMvX6pIZJJIzPmukZDcgWKuKUuvGD6W4QUIZW1IpYszki0fkvwRcc1xmweeCY79eeB6tfXbLTrWmnXSal+4PyM3HfTzXycmkLdo9UvKKCpMNC/HlSh/gM9ANfrKQK4cyj6ZXfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131300; c=relaxed/simple;
	bh=YQ4B87MLUsD0Ex7xuUwKJHzAgodX1CRjqci7MjxRUgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7GFuOCH+VBi+/BNn+gEtEhnwNBXEKvISkOCtSKJmWC89tQfwzJbQzUUuIxspgR55oJGQa256PdaN8agR+IegJQJkzOGoH+tnTb5eXwoYlsN16IpgxXXJpWsQpNrytZKL5nn69KEvnqumupc0WNJd5Qmt9zyNa2jjhXT00je6Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zx6c1AIL; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abbec6a0bfeso305173466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740131297; x=1740736097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DgHGvk60j/Vl/qcMIezfAgYt2qHmXNlKzysLNMFxcw8=;
        b=zx6c1AILDMcR3XuwvIBLxYqj89lEiwxdY0aYkxxMrqUbOjpr7xFtSlC19IO1w8KnnZ
         abxBAxZL/k4mOAKNG40lnR+gmwER92K2ZLt/2M4DfjoJ1UBc2Nnsc1qXoAdpBPZ8gK22
         4Fyipbgi3xyw9b4sQymkn85sWSMO8d9WKzQD2vcDOSC9B30VvHLfwb4wASTozsefaZK7
         Tk5oKAr4Ze6DdWi4NnWRDB1eEpNPXL1wJg9gz3gEYkFEC3DxMFgX/hMot87S3ZXoELNs
         tZpMS7YeP7YkJcuSlC/tXEaewVs45oD33hdLgl3JF6RkIKk0lg5QRr+GFpAy0enX8vGj
         zaiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740131297; x=1740736097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgHGvk60j/Vl/qcMIezfAgYt2qHmXNlKzysLNMFxcw8=;
        b=Ml+YzsU7vy9BI9pSYgMzlQnoeRzBT0u8zmifNZ8oENvL5Gsg8fMv86kzcNokcZpJ0L
         Lgs6QTey7qOgUU9PEnpxzrQDolV6BxUDBwV0+3aUBff+/99JO56Pbbi9HxSrMZ6Gmafz
         /QkCG5xXvHlucQ1inAo7T0Uw6IuaLXBdvfbrvybroA0RuKk7a6qbLqbt/beAUdLg7FR0
         tfvQZHP2IG+J4XNCvGg2YYcmUFXyun1CAR1dpDv7/7zVjqJWNqn+gDu10n4hgKXRLohY
         V4hPwfSkVbVQwxg3T+YvnlXvs3fEkeMCY/6hF2yTLTGpTlcB6ZcPuqHVBVnbKznyEENL
         DUEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkskRme0/I/DXxTCeAmN8P81nNVwGFgImhfiG/iTGG/3JrqmtPDdmTua3NO6cJs2GxrYrtv2VBqgfaOI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVN5593PwN5ci1FbNL+wpSVDGhZBTWxSu5BNAtr2y1+oRFGIoi
	RiTxEmHrVv7Srej1xWdk6630Y+6t8HEWOQtaVQIzHFgvA4BHgpGTKrIKWDazIWY=
X-Gm-Gg: ASbGnctsmpR5sbwpyjrmUb9H/KRGjMTwlPgHR0sgDsAd5739sAWI8mnxB+Fj0GCsEFC
	KfdePqB7XU9WyzkgWOPM9l+XqdCykosMSPkkmb+m6SkeHqoM5lKV1TbC4pnBVa4K5XgwDM5p1JO
	1iwuxrhRULkFKe3CYbWafv/a7GQKv+U55AgauEKTM9TXd2re/tW8D/3fP52C3hE02s6vRrk6jW2
	hC69nr1qKyr8Z4ieXWEamQmdHLwzdRDfYvshXWY5qwa9fWnNJUeuhdGUe9Ws1WYJW/TiZ7W1lM5
	4Z/XLUKjRlntYuaO3rh39eINKI77uts=
X-Google-Smtp-Source: AGHT+IEsyGrDlEQ3AVOyj1FyijrnT25YFiKbhs7K9ixu3igzvsVEz5e1kryk9Tyhp/G005H/Mx7cbg==
X-Received: by 2002:a17:907:9c05:b0:ab7:bf2f:422e with SMTP id a640c23a62f3a-abc09a80912mr280845366b.27.1740131297105;
        Fri, 21 Feb 2025 01:48:17 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-aba532802a1sm1616457366b.76.2025.02.21.01.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 01:48:16 -0800 (PST)
Date: Fri, 21 Feb 2025 12:48:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Martin Uecker <uecker@tugraz.at>
Cc: Greg KH <gregkh@linuxfoundation.org>, Boqun Feng <boqun.feng@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <caea3e79-78e6-4d98-9f3b-f8e7f6f00196@stanley.mountain>
References: <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
 <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com>
 <Z7VKW3eul-kGaIT2@Mac.home>
 <2025021954-flaccid-pucker-f7d9@gregkh>
 <4e316b01634642cf4fbb087ec8809d93c4b7822c.camel@tugraz.at>
 <2025022024-blooper-rippling-2667@gregkh>
 <1d43700546b82cf035e24d192e1f301c930432a3.camel@tugraz.at>
 <2025022042-jot-favored-e755@gregkh>
 <b9a5de64fe1ded2ad3111763f35af9901bd81cc4.camel@tugraz.at>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9a5de64fe1ded2ad3111763f35af9901bd81cc4.camel@tugraz.at>

On Thu, Feb 20, 2025 at 04:40:02PM +0100, Martin Uecker wrote:
> I mean "memory safe" in the sense that you can not have an OOB access
> or use-after-free or any other UB.  The idea would be to mark certain
> code regions as safe, e.g.
> 
> #pragma MEMORY_SAFETY STATIC

Could we tie this type of thing to a scope instead?  Maybe there
would be a compiler parameter to default on/off and then functions
and scopes could be on/off if we need more fine control.

This kind of #pragma is basically banned in the kernel.  It's used
in drivers/gpu/drm but it disables the Sparse static checker.

> unsigned int foo(unsigned int a, unsigned int b)
> {
>   return a * b;
> }
> 
> static int foo(const int a[static 2])
> {
>   int r = 0;
>   if (ckd_mul(&r, a[0], a[1]))
>     return -1;
>   return r;
> }
> 
> static int bar(int x)
> {
>   int a[2] = { x, x };
>   return foo(a);
> }
> 
> 
> and the compiler would be required to emit a diagnostic when there
> is any operation that could potentially cause UB.

I'm less convinced by the static analysis parts of this...  The kernel
disables checking for unsigned less than zero by default because there
are too many places which do:

	if (x < 0 || x >= 10) {

That code is perfectly fine so why is the compiler complaining?  But at
the same time, being super strict is the whole point of Rust and people
love Rust so maybe I have misread the room.

> 
> I would also have a DYNAMIC mode that traps for UB detected at
> run-time (but I understand that this is not useful for the kernel). 

No, this absolutely is useful.  This is what UBSan does now.  You're
basically talking about exception handling.  How could that not be
the most useful thing ever?

regards,
dan carpenter


