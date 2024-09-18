Return-Path: <linux-kernel+bounces-332537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C866C97BAF3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED2C81C21656
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6504817E013;
	Wed, 18 Sep 2024 10:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="edEZOw66"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BBD17B4E5
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 10:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726655739; cv=none; b=tNO3yv3rnWp70mhOmUrpzZBR9qMzI8j6cyuEwheyWLZSUiQyUbeY0TKIG8fTQzX8vM3cuUi5sPa6s9wqJoStmKPJB0kRnMX6P1dTPvpHqUCfkUfmxgy6vfX9fODzQFlcu7ccRvjEPF0j62tP1oMY7IEb9lRa+SsIf7G5Ey3uWRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726655739; c=relaxed/simple;
	bh=MKojkMtdMLX6s0iPGFzxqvrccWjr566N4dfG+CDfRxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqHhH6TmLz1bl3/MAHFtmCPoEKmYYqJo+3m6BxNxXQ1mohFPIPdF2PyXdpLN5chTxBMtwO+RrgZ3pnp+A6P8/jcJo94LtgtJZxwuf1WmMRMPPeI0pl9Aw3V3IRJvX4aIFlmcv85U1YH77b7MCdSLjaHTggwj5/qd1p3aH98XI1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=edEZOw66; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cb7a2e4d6so55688045e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 03:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726655736; x=1727260536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YJ6iSOFRFIXilBHat53kTfPhBju9nzHneKyM/B5MJoM=;
        b=edEZOw66m2yRETeqPBfuRq5DVE07OfvplXu9AcYfRlRJG/nVjYGS4GG7BClmgqGOR+
         FQimoObVAPQkTiwk6FYXtxvRXd7gypBKJhENlcEDFvOsbFg9GGlcM+OtOQWCcCDiHglP
         9DHiqCqsSdAXdIpvSX8D81jMp+OBy2fYcfuFx2Ae1T6QuSs1a523d9qlPDnlQ3OqsUa0
         3bsAcXTvhOP7jvsTRMHf8Hk0Z2IRkYn5Z3hj4Xx8/2hbJFaOJ+dPJ7Qc0D3Psv+cLPjD
         ehuPbFdprhgZ3nAlrxLHsVsr+WJRNZV0JFHXCdNQ/vcLdhExmLooRwbXMc1tj6cFjXZR
         Vmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726655736; x=1727260536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJ6iSOFRFIXilBHat53kTfPhBju9nzHneKyM/B5MJoM=;
        b=BeQ/OPGlaqbc6if8Sb4osaSahmRHxQSehFm4v5g+OY+DjCU7EU8Na5H4BqyQUC0DCA
         Ng2cHGH6iAnfFT5hX8QS4KzyftSjmiqvsGaKNgLRmwiZQfXFu1Q4RMillc1A5mMf63fT
         pqj0AqTpDJT/Xqb3yC6CgEVXvF5Bz0IREfNnkVhxPGZwE2//Cn/VlgNGx+YDulq0t352
         2w0ExQjgBJR0h4DSH1FQFryNfdDZIvf/mbJapskz9MxqpkSqXdKnDrBaYOVTG9GjMvdX
         0Y95IHSf+Gs4cioQzVRJu3hFzeiO74Iyf7ITpsB6y30KVgNZNjHcYt/fc7TN01cbtL5x
         Xs6A==
X-Forwarded-Encrypted: i=1; AJvYcCV/wf2w+IPYoJDcrFVB91flDGEE/F8lvszdgLROD8alCjYqXC06ATMqk3aODeLWcu/7ZSuM2Wo18dc719M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJq2Gc/81kp1DN8mbdHqpze4tNfT4M2O1EEJlPoI/1TGdqFGq7
	X2tp/ICT0QTyqlccyRZbVDbq+wbZnOBL5g0dBK+Ojh8bM4huoBBRUVRZ/1Eo7Yw=
X-Google-Smtp-Source: AGHT+IE1q6TLLgJdFrxZskiywIgmSX47WLYAFvIvk6rTFMK/4V4rT4AgiNgb5t4ooDomK9lfcGqoxw==
X-Received: by 2002:a05:600c:35d4:b0:42c:af06:718 with SMTP id 5b1f17b1804b1-42cdb57c0d1mr177198965e9.28.1726655736155;
        Wed, 18 Sep 2024 03:35:36 -0700 (PDT)
Received: from localhost ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e704f2ee4sm13314365e9.28.2024.09.18.03.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 03:35:35 -0700 (PDT)
Date: Wed, 18 Sep 2024 13:35:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: philipp hortmann <philipp.g.hortmann@gmail.com>
Cc: Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org,
	anjan@momi.ca, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/18] Staging: rtl8192e: Rename variable nDataRate
Message-ID: <0a8303bc-0c11-4355-87d1-1e4dbe10f376@suswa.mountain>
References: <20240917053152.575553-1-tdavies@darkphysics.net>
 <20240917053152.575553-2-tdavies@darkphysics.net>
 <ZunfwVt2f5DsAqlb@kernel-710>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZunfwVt2f5DsAqlb@kernel-710>

On Tue, Sep 17, 2024 at 10:00:01PM +0200, philipp hortmann wrote:
> On Mon, Sep 16, 2024 at 10:31:35PM -0700, Tree Davies wrote:
> > Rename variable nDataRate to data_rate
> > to fix checkpatch warning Avoid CamelCase.
> > 
> > Signed-off-by: Tree Davies <tdavies@darkphysics.net>
> > ---
> >  drivers/staging/rtl8192e/rtllib.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
> > index d6615f787d53..21d8ea153368 100644
> > --- a/drivers/staging/rtl8192e/rtllib.h
> > +++ b/drivers/staging/rtl8192e/rtllib.h
> > @@ -1743,7 +1743,7 @@ extern u16 MCS_DATA_RATE[2][2][77];
> >  u8 ht_c_check(struct rtllib_device *ieee, u8 *frame);
> >  void ht_reset_iot_setting(struct rt_hi_throughput *ht_info);
> >  bool is_ht_half_nmode_aps(struct rtllib_device *ieee);
> > -u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate);
> > +u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 data_rate);
> >  int rtllib_rx_add_ba_req(struct rtllib_device *ieee, struct sk_buff *skb);
> >  int rtllib_rx_add_ba_rsp(struct rtllib_device *ieee, struct sk_buff *skb);
> >  int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb);
> > -- 
> > 2.30.2
> >
> Hi Tree,
> 
> forget the former email.
> 
> so in this commit:
> commit ad96610acc0eb81f0342fa688e6d42fd530c328b
> Author: Gary Rookard <garyrookard@fastmail.org>
> Date:   Tue Nov 28 13:17:27 2023 -0500
> the variable was changed. But he missed to change the declaration of the function tx_count_to_data_rate().
> 
> So you change the variable accordingly in the declaration of the functiont tx_count_to_data_rate()
> 
> I assume that Greg would want you to use a fixes tag.
> 

No, no need to a Fixes tag for this sort of thing.

regards,
dan carpenter


