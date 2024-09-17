Return-Path: <linux-kernel+bounces-332025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C4597B470
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 22:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C1F7286739
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 20:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C113185941;
	Tue, 17 Sep 2024 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxkNViAt"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6725618BC2A
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 20:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726603207; cv=none; b=RZZiH58Q20Mam6cjwN8uqbtLeNyUDwe6WOsK7/ZPwLYj4AX8IKXO5/ZZRPhmhOqTgLKq8H0iNe9FIzWPmTJp9wyeBXjinMQBpeC1N+5z9zIER0Lj1GkShBlEAe9vWjzm6dbI1mrEef578eT5qsERh7pEpm9yQg9twE7Tw/jKd64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726603207; c=relaxed/simple;
	bh=T6+ksvjJAgEfbOT1MxSkSrCK6wQ8i5k62TxE2B1lUYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOAzMajEWDfQARCWI/Nw/g20nO4QjHWLqDDeHs3M20xXo+JuROaL+7oy3M9PVcm11K98dSBTlikZk5V329WPJ66OBJ5KdxvTJcukMhtFf3LU9eaB6reYxx3p7yCeH7PBikVsY1mRzB7KiLfv1gqQA0xEPx4v9AxrDtAeFSqa/LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxkNViAt; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c42e7adbddso4951023a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 13:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726603204; x=1727208004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CWRkmkcHV6T5Y2PauQSOh2UO3ThXb5nvn/hPmxzMqMo=;
        b=mxkNViAtduBC0bM6jozkilBEkXN9eFsq0GjUo4NoHjyEjW7lJWFzZwuHSjVWoB7SYg
         FJItY4AAooo9qH1dYDDiEP7MV7GUhloxXnzwR4XKvri628sVd4hSQqoSLrCx0KzxGN6n
         XrfjMi+rK4tOXdCe6RPvwT2BQAWZE7a3I6x/cXe6WxkN0lypslEh8pERWFFMtY85bv0Q
         jk7Qa9CqohoiuW+90zknkGq141hCo7A+JFwCV01A+qRvwuy/bDQVBrMhEGgYpWspXWFA
         1k+bTCkrdWKHX6e0md/rKbHrQUFfM4Y1n2b5elC2/X6PrTO3NVgZnlVaEv8CpwE03FRw
         Wapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726603204; x=1727208004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWRkmkcHV6T5Y2PauQSOh2UO3ThXb5nvn/hPmxzMqMo=;
        b=YiwaiQpURW54U6eRiWCnvXQKScY6in5ps9kL6dG0krWJxewpb5XbnrMXVVa7sfPx5F
         U1Ix6NG48DnBeK5Q3+rbG0sRf7tS7hp1X/8Im8vNTqviUl4ituF1Y8iz8JsNHSreiO2K
         ddKo01aKNtWt8np+1PbJPk0W1Vfi/M6E+nV4ESg/9WwbuhGwJk8E+VvwxNFefgXg0uOo
         p+yoryq7vDKIsMagt23QviUcICidVKHHycHj3pboePCTHRHy5VbGica2dBm5tgR5p9nG
         jjh8I30INZwVKu6AR3VtaN0L/KJTJYG4hItoPor+wp2TS4mrEHytwTYva8p20P7ozWwu
         6fAg==
X-Forwarded-Encrypted: i=1; AJvYcCWHXpoROvF3aEpNe/Op5fOij3yscixTOYldo/6rwI9A9lfk/Seqp3LLpL+ilb24l1bmYvMzLGI81fl1W1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcLhBkBEHUAUSEo7Hpx+onCkzf0fjBJqceTxctUNiwKi0WZW9f
	jOuutW4SieLOKaMJvmuclvW3Kbd6bD6Oh7wXnoV3X+Su11IUpGCX
X-Google-Smtp-Source: AGHT+IFOZOPB7iZrytCgA62IbvBoZ3+/IRT6fleNN+BEzgikPjA4c7Vevoz7sU3Qm2/ApHMVHr7nnw==
X-Received: by 2002:a05:6402:34ca:b0:5c2:439e:d6cb with SMTP id 4fb4d7f45d1cf-5c41e18e466mr13907513a12.12.1726603203398;
        Tue, 17 Sep 2024 13:00:03 -0700 (PDT)
Received: from kernel-710 (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb94a0csm4019629a12.79.2024.09.17.13.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 13:00:02 -0700 (PDT)
Date: Tue, 17 Sep 2024 22:00:01 +0200
From: philipp hortmann <philipp.g.hortmann@gmail.com>
To: Tree Davies <tdavies@darkphysics.net>
Cc: gregkh@linuxfoundation.org, anjan@momi.ca,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/18] Staging: rtl8192e: Rename variable nDataRate
Message-ID: <ZunfwVt2f5DsAqlb@kernel-710>
References: <20240917053152.575553-1-tdavies@darkphysics.net>
 <20240917053152.575553-2-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917053152.575553-2-tdavies@darkphysics.net>

On Mon, Sep 16, 2024 at 10:31:35PM -0700, Tree Davies wrote:
> Rename variable nDataRate to data_rate
> to fix checkpatch warning Avoid CamelCase.
> 
> Signed-off-by: Tree Davies <tdavies@darkphysics.net>
> ---
>  drivers/staging/rtl8192e/rtllib.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
> index d6615f787d53..21d8ea153368 100644
> --- a/drivers/staging/rtl8192e/rtllib.h
> +++ b/drivers/staging/rtl8192e/rtllib.h
> @@ -1743,7 +1743,7 @@ extern u16 MCS_DATA_RATE[2][2][77];
>  u8 ht_c_check(struct rtllib_device *ieee, u8 *frame);
>  void ht_reset_iot_setting(struct rt_hi_throughput *ht_info);
>  bool is_ht_half_nmode_aps(struct rtllib_device *ieee);
> -u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate);
> +u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 data_rate);
>  int rtllib_rx_add_ba_req(struct rtllib_device *ieee, struct sk_buff *skb);
>  int rtllib_rx_add_ba_rsp(struct rtllib_device *ieee, struct sk_buff *skb);
>  int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb);
> -- 
> 2.30.2
>
Hi Tree,

forget the former email.

so in this commit:
commit ad96610acc0eb81f0342fa688e6d42fd530c328b
Author: Gary Rookard <garyrookard@fastmail.org>
Date:   Tue Nov 28 13:17:27 2023 -0500
the variable was changed. But he missed to change the declaration of the function tx_count_to_data_rate().

So you change the variable accordingly in the declaration of the functiont tx_count_to_data_rate()

I assume that Greg would want you to use a fixes tag.

Thanks.

Bye Philipp

