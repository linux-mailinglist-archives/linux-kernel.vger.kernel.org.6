Return-Path: <linux-kernel+bounces-414232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C7F9D2502
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18B5AB23389
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6B71C9EB0;
	Tue, 19 Nov 2024 11:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MXyLf6mN"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD9C1C82FB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 11:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732016317; cv=none; b=pFQtA+0WRyrhfckERfH2sGFSSPWghDnZLoPwA+j8BXK5klur/w+stXzP+wvTwE0U3Dwhcchybz5raWY/8cNL7p72f9fJtEu2RAwLhxMFkhPszyGvMqs6qiCk+ZwgaaNf/L7XMBRbq7be2H5HHnD4dc63vm76dc9fYf2QJVZ6JAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732016317; c=relaxed/simple;
	bh=rsETccfWPnzhzl8mFgNQA7rKYy+id/bn9+tToSWxWsw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JTNUf/CyUqGYpLI/wanQe7tbl+Qz1rt8OGPRKA52sFm5cnLB+LzVSLopNOPbDKMhLKgKAsWgHRFENs6j7zChAZDNL7leehDSLPk7+igk6jaAS6zjJxYZNExmLuyHqIfIWDgYlJpPHeNptS8mxJYR6gIzQnCMHGQHn9jxI02JNRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MXyLf6mN; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-432d796a57eso3581915e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 03:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732016314; x=1732621114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/K++AUGfiOju5I7xoub4vBe8Bp33OIr9UnlWEqSXyzI=;
        b=MXyLf6mN1V3rgA+FT523u2R/UYg0rDg22plPXdJZU6Rfm1FUijoE+C1il4WZtzHrke
         HL8uXvhn+kP2siNdYtMN5oe1dQhszXFWzqo9De/ZCN60U3WTR4GduRDQivLRY3No6OY5
         H8P5WuKH7yHkIofXUSBXuRBGTKEzRHewrr6d/+924KcxtuIYHdp53XhtYFBFgLfxc9Th
         K2opOmajuQgpTj5maUSKyUWAYVv1qupE5bah0IoH2vkxaNwItFZzYR4V9LGEaOJ4dOdM
         HM//4G8fAYqEu6yHI7RpOS1XYf84VFPuKGXhGZxDHLsnIoDvdaVWBwAGAqL8/wlSU1Wl
         xgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732016314; x=1732621114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/K++AUGfiOju5I7xoub4vBe8Bp33OIr9UnlWEqSXyzI=;
        b=NdrFiYiz4lmeboPjNGZ2qyY9rcWZBkYSQHt99h4SPf7zQAa7qMit/6Znlb/SL9rPSW
         1FOdMYq9UTZGgLVetmedVBag7MY5J/Fg8SSo0MDh+HNTe4x9SVYi/IRJgis5P0vkiyki
         v1d9M40O0f0mVendiE1ULTJqtKpw31baHJLZal5IePQ+Kf7mXlpIMLzU5iDGCzT5+4L2
         YKwizHuqZPsgiIJPeezLgA72EUNWDPbkIYvMNzmIBBHDsaPCjirjb54aZj3uoNaqVEMC
         Rg2VwxIImS7/LX2dOlzzubz/Gf/L4gkZkP9lEF7xO3l9ypsc53nB/MkLASFBQd+O6aBV
         U/eg==
X-Forwarded-Encrypted: i=1; AJvYcCUp6H67YvB4qJtQrwaZcIoE00AoLvwsj0KCuqyLbiQi/WqZLK82eFHmGJyVeJZhuDtIFFIOCq3jxYQJTAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7dUmauMAz5mbD5zh5AzJaJE0RGEdOcw8zv3WGj6d/hNbz8WIr
	M6ovTUfYylL7uCUuRPV0J4MrohSyC4XnO7JL4nuhncVXcMhiMdHhN8k7+BsbAxw=
X-Google-Smtp-Source: AGHT+IFktYyZ/8h7IEekJtLbttjAswkGy9GG76oFQMw+rKvK9ZsE9aVx+p+KmTk5jCnq4hlA8IV7hw==
X-Received: by 2002:a05:600c:19cb:b0:42c:aeee:e603 with SMTP id 5b1f17b1804b1-432df78fd8dmr58404075e9.7.1732016312314;
        Tue, 19 Nov 2024 03:38:32 -0800 (PST)
Received: from mordecai.tesarici.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da2982fasm197399985e9.36.2024.11.19.03.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 03:38:32 -0800 (PST)
Date: Tue, 19 Nov 2024 12:38:30 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
 Jinbum Park <jinb.park7@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/rodata_test: Use READ_ONCE() to read const
 variable
Message-ID: <20241119123830.7573897a@mordecai.tesarici.cz>
In-Reply-To: <20241119112009.1286675-1-ptesarik@suse.com>
References: <20241119112009.1286675-1-ptesarik@suse.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Oops, this should have been a two-patch series. Will resend in a
minute. Sorry.

Petr T

On Tue, 19 Nov 2024 12:20:09 +0100
Petr Tesarik <ptesarik@suse.com> wrote:

> The C compiler may optimize away the memory read of a const variable if its
> value is known at compile time.
> 
> In particular, GCC14 with -O2 generates no code at all for test 1, and it
> generates the following x86_64 instructions for test 3:
> 
> 	cmpl	$195, 4(%rsp)
> 	je	.L14
> 
> That is, it replaces the read of rodata_test_data with an immediate value
> and compares it to the value of the local variable "zero".
> 
> Use READ_ONCE() to undo any such compiler optimizations and enforce a
> memory read.
> 
> Fixes: 2959a5f726f6 ("mm: add arch-independent testcases for RODATA")
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> ---
>  mm/rodata_test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/rodata_test.c b/mm/rodata_test.c
> index 6d783436951f..3b60425d80fe 100644
> --- a/mm/rodata_test.c
> +++ b/mm/rodata_test.c
> @@ -20,7 +20,7 @@ void rodata_test(void)
>  
>  	/* test 1: read the value */
>  	/* If this test fails, some previous testrun has clobbered the state */
> -	if (!rodata_test_data) {
> +	if (!READ_ONCE(rodata_test_data)) {
>  		pr_err("test 1 fails (start data)\n");
>  		return;
>  	}
> @@ -33,7 +33,7 @@ void rodata_test(void)
>  	}
>  
>  	/* test 3: check the value hasn't changed */
> -	if (rodata_test_data == zero) {
> +	if (READ_ONCE(rodata_test_data) == zero) {
>  		pr_err("test data was changed\n");
>  		return;
>  	}


