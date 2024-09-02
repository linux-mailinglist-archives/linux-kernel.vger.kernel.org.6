Return-Path: <linux-kernel+bounces-311750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB12968D06
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 19:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272D61C21C26
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBC31AB6E0;
	Mon,  2 Sep 2024 17:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zhr9b0i0"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9515A1CB52F
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725299805; cv=none; b=rYAzsYqkSsikej+pKUXoOI9Qous/GMUdOfEM5u+z5HyEpGbpFVSz+LcHoRaFg1sYLsjpJFaESstM0ygMqsTmrw1AQTSRUaH4Z7WExjzAB5kTzEKU8NZr3yaaSJGCmuggLGLhW4GXog9WaZsdMo2RHK5rNXDbaFnvPPPJfPmif4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725299805; c=relaxed/simple;
	bh=KVqXYT6sv7h0hcImcQS/lublPQ4qLsuhwmLsrrcSRYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8/bBPjpMlzWxgVbNAfZcldx18+FFMkmdQX+mHBRV6f0ivBSp1vWFcvqZz4yys6lmwziDCLbUPtogoY+kgwUU3nsl93X8S1HKatnGjWp1z5yyN6wPQ9DXpa2azye2OhZ2E6+pOkux0gLbxgPjqQDxmcc9o/OqcjJXI0GKaWmpDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zhr9b0i0; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20260346ca1so408855ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 10:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725299804; x=1725904604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mMLk2qq5yHIMeKoKu1RC0AVIs097uaes9bylwXlqxbo=;
        b=zhr9b0i0dWUXrnluy5L528NyljGf6pjzBnWL7itdD7ZDFgOHQFixWP9U4yX1uZ6SV9
         JTLX0md4+dD+tuR3TN6ZJ1OWDX1oH7jLoiLGXdmKRSocrEZtfJQmLFbuXmDMj0sNTb5o
         SalR6SfG73wNaCw/2IlcNPqM2mggVuCJmCtUu4U+ymw643SblT4fAZLqiqqdqk6BXTek
         6NM5WU8MAnfq27KmEU7n+ghRHgAcTjydgeaPMqxpRbL/PGomWVVMfl9dE7WtUZK98Q9x
         Gs2biV2DUyc8vbgEC6hGa0jt/S+TKt/ps8tqWhRg9MNSBks/ipORL8xGBbmwY7FueV9c
         iuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725299804; x=1725904604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMLk2qq5yHIMeKoKu1RC0AVIs097uaes9bylwXlqxbo=;
        b=B+M9oX605GiwcgO3gNsls4rGGBTT++BWsxJUzPh/YSeOj9DmSpluprsAscLZYah7gO
         oM04Lmmg9PGnYpS3gTQjX9UPal9MNqDVYZ3oFzV5twV6qv1m/r1CmnPlM8fD0kl0T+/h
         yadM3iC8XJe6S3VJekzLrAzBgmUJBhyFjfMmxeE69/IC6uGyyxe3I9BB3XY9oMpnbku8
         cbS1UBMOP0iGBcff8wbzl1j5Ds1VYET7yltdYm3L98rGRp6zO062dfDkZcWr59jIPWyg
         qS8slMDTlreWHpQ34JZBfve4H+BVCcRPI1W2/tu7eDldOb5oBao7HlnxHXY3iRtdQyCY
         7aaA==
X-Forwarded-Encrypted: i=1; AJvYcCV9rjsKzHloSxXFzrAs3aWeJPFmaVVjDsb5fB1xghky9coqTdVQT6idmVlhbd1U0G6+6ix0Khkenom9QNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7r00GJ+bgaGV05UWYr0vtAAMloY9UhpwkebTaitk8cPMEB3Cd
	7Uqe/69t8/fwwiS6uke4yysEf1imOyhieSEq/2j7bdxg2jEA7BJwelT4RCkRqA==
X-Google-Smtp-Source: AGHT+IGONItXMSH4ou1rNjpVsbGnCCSH83/cy85Qem+LtE2CiiMxqwEvPuIQOw2C8+Suou/UZO+P7w==
X-Received: by 2002:a17:902:f548:b0:205:8610:3e39 with SMTP id d9443c01a7336-205861040f4mr2119625ad.23.1725299803450;
        Mon, 02 Sep 2024 10:56:43 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205682d8323sm24378625ad.267.2024.09.02.10.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 10:56:42 -0700 (PDT)
Date: Mon, 2 Sep 2024 17:56:38 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Ruffalo Lavoisier <ruffalolavoisier@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binder: fix typo in comment
Message-ID: <ZtX8VkZ6sFRH1VwV@google.com>
References: <20240902130732.46698-1-RuffaloLavoisier@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902130732.46698-1-RuffaloLavoisier@gmail.com>

On Mon, Sep 02, 2024 at 10:07:32PM +0900, Ruffalo Lavoisier wrote:
> Correct spelling on 'currently' in comment
> 
> Signed-off-by: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>
> ---
>  drivers/android/binder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 905290c98c3c..52c30a699b0c 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -1546,7 +1546,7 @@ static void binder_thread_dec_tmpref(struct binder_thread *thread)
>   * by threads that are being released. When done with the binder_proc,
>   * this function is called to decrement the counter and free the
>   * proc if appropriate (proc has been released, all threads have
> - * been released and not currenly in-use to process a transaction).
> + * been released and not currently in-use to process a transaction).
>   */
>  static void binder_proc_dec_tmpref(struct binder_proc *proc)
>  {
> -- 

Acked-by: Carlos Llamas <cmllamas@google.com>

Thanks,
Carlos Llamas

