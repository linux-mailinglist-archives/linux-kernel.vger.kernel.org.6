Return-Path: <linux-kernel+bounces-332021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C09A697B45E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 21:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 601D6286375
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 19:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F46185956;
	Tue, 17 Sep 2024 19:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCsYhFQr"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581FD56B8C
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 19:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726601535; cv=none; b=XJQ82vtFBXhu6ZkKu/xp7dCFHgEbm6ZotY7tZyjk5ZP3kboKLvCrLL7RWan4zbZoWHspglkEVd0tI8D5p1DPq6RcjpdsdFnwbye5XErsVoGwqknM7y7gmV+44oimISv++pZ794O14oDWwaHZs9saap10ZESMD0yxMCUH9LdrpNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726601535; c=relaxed/simple;
	bh=fh0reOq4EMpswxJsKKqpsiw6Czuf9g0WTzNlxS7UO+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4uCqYIQTrj0UYa+q0S0HR5qHCMukdIgwz+XaD3ppByTCnmwQdCmm4rwx8m/a7LP4m075FNwPtz0wuY0v9uucZPixhtzdYgKLIYA1ktRESd0u9uPytEpBxkI6uygmODHAV2zjOfUBEnYyYIqUvBirsCcvUzDAMCfb9lg+VX64MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCsYhFQr; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c40942358eso96272a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 12:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726601533; x=1727206333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hkmmdj8+A5vEF10W6axwToELtCxiF54w4XBSo8dtkiI=;
        b=jCsYhFQrSOC83ZEvLFXE/VMCfhUdX8LrbSS0cFvUD6k2pBaT10RG8rUKCr106mCuEW
         DGCrmF9cr6CIK30pljo43ca/k0bGIIPlqFnTuN+islgmelB+1+4hrKNJ99RmMu4j2Mh2
         tu1AVRA/vp0iJUthH/H0oxOpg4OTcG+ZRg8y2/akjrGpun3/oUF789F1hKr+EN/an85g
         V8/2yoYhGT1yCpRq/j0XchDl7+o843Bmoy1vpSf8Sa5VhqzKJIQmx/mwhr5mnbplQveH
         +fQYnhNM9V1ZY5tcCmOMmMEupbUPN0dJ6kNI1YOBDf5h91rbg9b8aP07oqNLe3gwElOz
         SX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726601533; x=1727206333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkmmdj8+A5vEF10W6axwToELtCxiF54w4XBSo8dtkiI=;
        b=owcNG1teP+SPgQz8OChfbSMBIWvbcRcR1yCRuMe8T1e9xZl5RkdXRzedtJOp9Hh1ot
         f6zPbepA+MhqK8bu3Mq7Dl8dajnjdgmRT6a0vic/LVThhf0tT+QgoTAsSKfW+sWkLiC0
         Q+tR8f1vdiPpLKH5F2BUQwA4gAErxjdpCSWKksZFe6s5U9GH6DHCmbXYzBoO1BhSey0p
         TcCbn+OXcon/9JFuAqgj/I0WSCMweaa76rbfI2TOAv9lBHq/SHnD6h0gcT6wHHaJf1sw
         V2aJ1VSu18LOEk6wDzGI0USXkc5VAapTFu05Zmoi59Enag7u8gmFA9l2tiE5IMxeoGE7
         SBJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFErwsUQGDTQQfcO78G218utyAdeoAnM1O3vubY5pecKtnS5Wp6jdQl8HSWqg74yvVolYHkCP820+C7xE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKqEJiBDhPYg8I6Io0+c/fV2I/w5eDw23Tl4j94fnwSx9a35oQ
	o1/ed6bB4+8OTuzmGx4/uP5ZDCwGBKY43yQaDf7OGmvLRL9yZKq7
X-Google-Smtp-Source: AGHT+IHjViEgRqChvdDDupCbfhMxeWHkVe8bOAjS1ZJMdYIRVrgzeYd+dQEAUUKVjV5exB5Ga0t1lA==
X-Received: by 2002:a05:6402:d06:b0:5c3:d8fb:df6a with SMTP id 4fb4d7f45d1cf-5c414383763mr22757109a12.14.1726601532369;
        Tue, 17 Sep 2024 12:32:12 -0700 (PDT)
Received: from kernel-710 (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bc88d02sm3989780a12.80.2024.09.17.12.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 12:32:11 -0700 (PDT)
Date: Tue, 17 Sep 2024 21:32:10 +0200
From: philipp hortmann <philipp.g.hortmann@gmail.com>
To: Tree Davies <tdavies@darkphysics.net>
Cc: gregkh@linuxfoundation.org, anjan@momi.ca,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/18] Staging: rtl8192e: Rename variable nDataRate
Message-ID: <ZunZOjL0E3bU7Oht@kernel-710>
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

we also need to change the following line:
u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate);

Thanks for your support.

Bye Philipp


