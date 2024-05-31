Return-Path: <linux-kernel+bounces-196503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5438D5D1C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9034287B61
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E30155741;
	Fri, 31 May 2024 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OSYOp1hY"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CC64E1C8
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717145351; cv=none; b=O/IZju4caAVlhVcrfI9ez14+6uHEQWCbeb6+QPZEpZZfnL20GknioiqG0PMulvQLdif91lC7tOq6hPmc/jTZBGrdIydCsE3/RhSiq1/yyQjj2iEjzYKoijSoPkg/y3ypWDteIjWSdySCNmb82gErQ06E2LRopDnY/XkoSuzj/co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717145351; c=relaxed/simple;
	bh=62KanOcE+O72wCSIMUaUZhgk+diKcA24R90LuEcsMtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ep9LmSRmDfBCgsmrktXwFWSxCRCfjcz9h09pHmnTBmA4OZ5ckhvsY9+U7VaB6eqv/LqneDqbI8kJxsgc+uJlEyA7enuZeV1alDELTj6+nSmKDM6NmHenIH4vOn/Alxali9qYpFLfuTheCctgzf1kSaZzA0Ae5ABKyg4Cl2gWrDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OSYOp1hY; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6266ffdba8so140903666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 01:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717145347; x=1717750147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R61gLvoZpfbTvEYlGXcR/R+p1iPV6UeVskki/bZyKX8=;
        b=OSYOp1hYQ+TyrVz/MoyceClTljks3A6YmxqcJkbaiv535QaKtBrjiLbczxLJTXTvlJ
         wyGoPxJy1OcrRkofU/KbNU5FUVPplRkRLD3IjPUB1l20TMp5ku+Kr3FU5+cICYeYQCvw
         vkOzqNcia1ySBIXd1HMx4QIm1JzyvD5nhViveU8zif5ZqVQv7hzIlW+DWnld782CQf4b
         NLLBtY2FgZER4fVPfGl/PqTzbwfWeH2eguQA4HK8zipXRFYPbScBDPevBTnnOcvGEeXV
         f4TW6oYhjbsryb8sKxUmsyDMMfhc99at+191vx2iTPAd+mNvO3cL/acX8W392zUL0TX3
         C/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717145347; x=1717750147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R61gLvoZpfbTvEYlGXcR/R+p1iPV6UeVskki/bZyKX8=;
        b=Zjjo13UNJ/nIhfMe0jLH7wYaXs2+jAbAo0YcS96COoQfmrAWtQBOPocdxF8+8jif0w
         Yc4iVmKIDyVVLqPiPGD141F/7b/Cx1MCymWGfDEfJTvpxM+zy5S5Pei7IFiwFAJjRK5P
         1Q49K0hzGe7HTqhl/4USZ3Zuz2jfRSW97tZHC20qn9jFYD6ZlsPKx0UbhAX9Sc1rP3Ax
         G7Pcc5ZJXTEmZgjgc9fc9IjjTpX/MWS8VZgA9F255z3DPY7Tp3ttfQ2zPnK198ona2hJ
         N0TseaGr12fkdzU0Uqd+Bw0as+Ba8d/1qymHKUELJQMeIyi7KLJqHk4G8P19OtbBURe4
         80gg==
X-Forwarded-Encrypted: i=1; AJvYcCVKQK/CHhzuRp+M/mc0UZyKORfC18zmnhHRESd2Jr4UIb1jmXuh2KA/84zxHL45TZ7YF8PMuMCdMHLKT7h/eCN37EgRSNbwongNUJ2q
X-Gm-Message-State: AOJu0Yzn3BmXQ1k/265mdCA4wHybr8RIsrBFK9cItfNnKyi8t54mqT3V
	4g2Wt+R0kpsy/plUr7lOE4EK5JQHwvvJL0+Nyw1WcdYgejtjyMPpA9X6bNA4E7I=
X-Google-Smtp-Source: AGHT+IE/s4y6yeK+KRr8+VE0KOHDm1VB0SqNoRh4/tUk+yZ+wawe+e3sUvtp5Rq4vsY1itIjopnQog==
X-Received: by 2002:a17:906:234f:b0:a61:c730:ac57 with SMTP id a640c23a62f3a-a6822447511mr78590866b.74.1717145347187;
        Fri, 31 May 2024 01:49:07 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67e6f02d4asm63613866b.31.2024.05.31.01.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 01:49:06 -0700 (PDT)
Date: Fri, 31 May 2024 10:49:05 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sreenath Vijayan <sreenath.vijayan@sony.com>
Cc: john.ogness@linutronix.de, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, rdunlap@infradead.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	taichi.shimoyashiki@sony.com, daniel.palmer@sony.com,
	anandakumar.balasubramaniam@sony.com
Subject: Re: [PATCH] printk: Rename console_replay_all() and update context
Message-ID: <ZlmPAZUeKIDFKLdf@pathway.suse.cz>
References: <66582edb.650a0220.8de7.c591SMTPIN_ADDED_BROKEN@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66582edb.650a0220.8de7.c591SMTPIN_ADDED_BROKEN@mx.google.com>

On Thu 2024-05-30 13:15:47, Sreenath Vijayan wrote:
> Rename console_replay_all() to console_try_replay_all() to make
> clear that the implementation is best effort. Also, the function
> should not be called in NMI context as it takes locks, so update
> the comment in code.
> 
> Fixes: 693f75b91a91 ("printk: Add function to replay kernel log on consoles")
> Fixes: 1b743485e27f ("tty/sysrq: Replay kernel log messages on consoles via sysrq")
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>
> Signed-off-by: Sreenath Vijayan <sreenath.vijayan@sony.com>

Thanks for the fix.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

PS: I am going to queue it for 6.11. It is not critical
    to hurry it into 6.10-rcX.

