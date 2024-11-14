Return-Path: <linux-kernel+bounces-408949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5929C857A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90E31B281FA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A80194A67;
	Thu, 14 Nov 2024 09:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b+kBQhft"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47AE1304B0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731574912; cv=none; b=CYWU8FuFyTPBd8UkZRPaRv65KKULLq7moTvQxcM7pu3RRc84UA3mzYM23Xl832b5iOPijXKZUYqlDhKD+z9TCzd1A8+RJgpqkAEnKbgdf4snQzdJNddx/hkmcuHef1y8hrHu2Svrw+HyDO1v7jTYJSsA2XemNo+x7g6cuTCkS6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731574912; c=relaxed/simple;
	bh=T23aK4kK/C7dpLAMu+Q5zpcRbeqquxUX93S7n31g8ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oh0BSloAwCTf/PCiwYxqVX9bgKlDgmIUzM15SovADs1aKla0jQTWB7FBvK3V0/0b03E8gvXA2g55/HprbuCnlbETtP/cW8LSeIV8X7ZvkFoQCngsV9qcGByjAk0gBajXHTmYMTaA1emLvsVZfLxavq1HAicO4qRbz614T1//Tlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b+kBQhft; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7ea8c4ce232so306100a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 01:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731574909; x=1732179709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m8XEUri7CoZTq5vq/DzmBb1WzLljf7ctCSh1CJnt7ts=;
        b=b+kBQhftYmsxFXZm1amTCaUYdKx4UBAq4dk6v3YnoUbcLk3+qwyhOFo4MZyTRjCHOC
         DbFSJfft4aWvh2XjEBUDuY2zezZX3w7+3eRQRCTcI0s1jcd4I9JCGxC0CxcIPU5YNlYm
         mGD9bemwdUtY/38XQiPWDSF4XUnczz4GAp8cKnhn5sfd6BZGC5hz2yQ6iWmY6zFN3bV0
         I7+OEvcR3fSDPjEyHvePiMrB8lAr/9QuLUiKZKIpikckvIAl+yMFWiuurY+YcTpVFGFu
         hfClWyL0kbJ4xpD+VQ2bJ+12T62gT2PeSHOBIqqsxleJUF00ArboeX5Y4kDw317PP+NU
         XoUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731574909; x=1732179709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8XEUri7CoZTq5vq/DzmBb1WzLljf7ctCSh1CJnt7ts=;
        b=QtCsu6d5YZhbRxsW5g8Ma9RkoQIDtcJ4T7oUM7jazlHUzC4cT2xIVq/2HH4b3qZWmC
         Ryo4FmFeGx30vPcMX5degn5XW1r8AasYdFwP8vyDv8JzZcj9kZ7IfZjqrjr19xVC0UQM
         Z1a23fZybn7eYR7Z2fV8/UQJFb3t4dZ6QpdFKrhzhP/nKTyJUqehCdT5TrQYOF7EiSJB
         PWKJXhLmX9j6P5oakOoc23HDqkLg+2y5JRiGvszBL4/7GKwqkwTjS8TKqtaQpk1S8QHj
         ombL01IUTW3H/wZtFeTCfzq9PKK3e1HnbNfFTe21frElyiUXRlvq+TpjxcYJ0Hsa9tbH
         ZvTg==
X-Forwarded-Encrypted: i=1; AJvYcCVRGuXfvd4gsOKsymCKfdKkRwwKkeGGaXO0X3plXq3cpORb18k60rJ10I9CYvLbtPlzFVC19A3ueKfQu00=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVVbjjy5P94IN7SGeuIhhKrfoyZf6sr5qdSnGzJljank0yimms
	ecCjzdoXSOLZE9IW2TNeDQpIOj7cbIOrbs5KBXmrjNSGnydTN3IUuJ4xlPe61sg=
X-Google-Smtp-Source: AGHT+IF9ICqS2lyMmRBik5cNw7m35MJ5Mn9ZVdXEESxz2vH6U+lU1+8C4M51kQ1zPlNSPGNFGx7RWw==
X-Received: by 2002:a05:6a20:e347:b0:1db:f00e:2dfe with SMTP id adf61e73a8af0-1dc8348c820mr1817985637.39.1731574908948;
        Thu, 14 Nov 2024 01:01:48 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8b36da8basm635461a12.3.2024.11.14.01.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 01:01:48 -0800 (PST)
Date: Thu, 14 Nov 2024 14:31:46 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mailbox: arm_mhuv2: clean up loop in get_irq_chan_comb()
Message-ID: <20241114090146.u2cyg6fmykw57mei@vireshk-i7>
References: <40fd7f80-26d6-4cfc-8bc5-f8572eae94d4@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40fd7f80-26d6-4cfc-8bc5-f8572eae94d4@stanley.mountain>

On 14-11-24, 12:00, Dan Carpenter wrote:
> Both the inner and outer loops in this code use the "i" iterator.
> The inner loop should really use a different iterator.
> 
> It doesn't affect things in practice because the data comes from the
> device tree.  The "protocol" and "windows" variables are going to be
> zero.  That means we're always going to hit the "return &chans[channel];"
> statement and we're not going to want to iterate through the outer
> loop again.
> 
> Still it's worth fixing this for future use cases.
> 
> Fixes: 5a6338cce9f4 ("mailbox: arm_mhuv2: Add driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/mailbox/arm_mhuv2.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mailbox/arm_mhuv2.c b/drivers/mailbox/arm_mhuv2.c
> index 0ec21dcdbde7..cff7c343ee08 100644
> --- a/drivers/mailbox/arm_mhuv2.c
> +++ b/drivers/mailbox/arm_mhuv2.c
> @@ -500,7 +500,7 @@ static const struct mhuv2_protocol_ops mhuv2_data_transfer_ops = {
>  static struct mbox_chan *get_irq_chan_comb(struct mhuv2 *mhu, u32 __iomem *reg)
>  {
>  	struct mbox_chan *chans = mhu->mbox.chans;
> -	int channel = 0, i, offset = 0, windows, protocol, ch_wn;
> +	int channel = 0, i, j, offset = 0, windows, protocol, ch_wn;
>  	u32 stat;
>  
>  	for (i = 0; i < MHUV2_CMB_INT_ST_REG_CNT; i++) {
> @@ -510,9 +510,9 @@ static struct mbox_chan *get_irq_chan_comb(struct mhuv2 *mhu, u32 __iomem *reg)
>  
>  		ch_wn = i * MHUV2_STAT_BITS + __builtin_ctz(stat);
>  
> -		for (i = 0; i < mhu->length; i += 2) {
> -			protocol = mhu->protocols[i];
> -			windows = mhu->protocols[i + 1];
> +		for (j = 0; j < mhu->length; j += 2) {
> +			protocol = mhu->protocols[j];
> +			windows = mhu->protocols[j + 1];
>  
>  			if (ch_wn >= offset + windows) {
>  				if (protocol == DOORBELL)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

