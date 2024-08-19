Return-Path: <linux-kernel+bounces-292535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD738957094
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5C4CB27F5E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC87177982;
	Mon, 19 Aug 2024 16:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NacPuJGz"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7377716C867
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724085608; cv=none; b=auxOzz2r1MQRsM22k1eTHaqupQhbMO12r4VzLw6lJqGo1zinB8BXabSFcpctloN5vTjT39O+1grI8DjUaPSa5wkyVdxhztEECKfMpRT6R2TYzkVJNpHVd/mDGHAabAVMujv3/i5XGTnJNVnSsHXRMs8NQfbq34Qths8tnmvnMs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724085608; c=relaxed/simple;
	bh=+C/OxPV9HRCUwr7CvveR0sYY1XMqQ/b6denDFBJPH9Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GR4uN0pJOxN6p0MIQT0KdgMSg4rfrI4L46O0yplLh/daD47UaJ38tto4S3dE+FUz+gcuMVCpa1K9JIg5nIeGMN5FdmkV2yc+SK8cca+eCKB+JqETma2x8oHWfwY6EX+OUj9wr9OejmkO/h64r6jg9R94gveOCWGi37mM/5sJRus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NacPuJGz; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7a9e25008aso569270966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724085604; x=1724690404; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CLh1ABOmACJjGeaQQwCrzHZzMijH1c87qN+hdOaSDkU=;
        b=NacPuJGzBrzlHYQjj/Tqf5JIfnXhNggaeRn1NgcoR80JLNw0T5CItbQWXnQIh4MATi
         1TF6onjiT45helPPWhRSq8cHcpFXj/VDLRTFCcUL/foAQYJVKbW7qj6J+l7zem0UsWYH
         QVjLQeKfZIqJxp3A5/gKTx/fiA1WNBAhjEj/Tew6PzeoM3AJQ4yKiL6qo1wf53ObGmql
         gWKdpl9DDmMjAAh+/fwWoz6yhWOTiMNlN40V+XMzNmZqZLqyW4n5mMY1y27fmUyl93+T
         LxLtu0CfDvv4hjo95gsvz5C7vezgVJuNGCc47YO/dJymGdEsBgTREq6nbeMoZqLiwoAz
         FS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724085604; x=1724690404;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CLh1ABOmACJjGeaQQwCrzHZzMijH1c87qN+hdOaSDkU=;
        b=IyLXWpgKQtcsetK6P67hlqQX6YISuGBkFUlX0KOYJHWD/69WKfnO6P2WDrwQ+MkBWX
         GuiFNQewJhmY8KG3QvAk1mDDtJFlCOLtSD9Jf3cXb9sTQhURGp1k03v3cSktGCNnvGLY
         fkwV71KMdoUQx4VD/20EmjeeJrJUACkR2xJThyZc9wtjDOurIT8Ru2IbD/p2u4/qu09g
         mgY6MOT5JiLQdumrSUOJg4B9QwVJp53kZ4nJuekFTvcYnbivREvTqzrnTwHE4T7erTGs
         ceeErUfs8Go4i47JaUC0lkszhwpDPaImTnntIJrow9JQ0+4sXuACRmn5hhTds8mej4g1
         mXMg==
X-Forwarded-Encrypted: i=1; AJvYcCXKkTNiiwOtHHznXZbq8DT0UGcCWdFKjjpkVzwmXazBo4rxpUFPfR3G6qqcobRARLxc01KJJ6g5dh/2aVBYXh4nQJunmQmZkwBDRxyy
X-Gm-Message-State: AOJu0Yyv1ADK8/Zkn8j/0DwXyawakfMY70qdoZNuyzMODkxY3DWlou55
	5qNlJ1AcidroEpFtWIchPVV21NPEgw6eBVFbvsAtNCTOhMYRUV+FjV+B89hgAc0=
X-Google-Smtp-Source: AGHT+IEjMWa9M79IVLPR6gN4l2c9n59ko9vG22U11vCzOjCnsgrlvCivJJKeqjCLstcFqGUGSASwdQ==
X-Received: by 2002:a17:907:6d02:b0:a80:f747:30c4 with SMTP id a640c23a62f3a-a83928a6336mr732337866b.1.1724085603415;
        Mon, 19 Aug 2024 09:40:03 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:db8f:43f4:9b2e:fb1d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383946a7dsm655387366b.181.2024.08.19.09.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:40:02 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,  Stephen Boyd
 <sboyd@kernel.org>,  linux-kernel@vger.kernel.org,
  linux-amlogic@lists.infradead.org,  linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 4/9] reset: amlogic: add driver parameters
In-Reply-To: <614de1b0-fcaf-457c-9183-1f3cd7f91b38@linaro.org> (Neil
	Armstrong's message of "Mon, 19 Aug 2024 17:57:40 +0200")
References: <20240808102742.4095904-1-jbrunet@baylibre.com>
	<20240808102742.4095904-5-jbrunet@baylibre.com>
	<614de1b0-fcaf-457c-9183-1f3cd7f91b38@linaro.org>
Date: Mon, 19 Aug 2024 18:40:02 +0200
Message-ID: <1jzfp8wjod.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon 19 Aug 2024 at 17:57, Neil Armstrong <neil.armstrong@linaro.org> wrote:

>> +	assert ^= data->param->level_low_reset;
>>     	return regmap_update_bits(data->map, offset,
>> -				  BIT(bit), assert ? 0 : BIT(bit));
>> +				  BIT(bit), assert ? BIT(bit) : 0);
>>   }
>>     static int meson_reset_assert(struct reset_controller_dev *rcdev,
>> @@ -84,17 +88,23 @@ static const struct reset_control_ops meson_reset_ops = {
>>     static const struct meson_reset_param meson8b_param = {
>>   	.reg_count	= 8,
>> +	.reset_offset	= 0x0,
>>   	.level_offset	= 0x7c,
>> +	.level_low_reset = true,
>>   };
>>     static const struct meson_reset_param meson_a1_param = {
>>   	.reg_count	= 3,
>> +	.reset_offset	= 0x0,
>>   	.level_offset	= 0x40,
>> +	.level_low_reset = true,
>>   };
>>     static const struct meson_reset_param meson_s4_param = {
>>   	.reg_count	= 6,
>> +	.reset_offset	= 0x0,
>>   	.level_offset	= 0x40,
>> +	.level_low_reset = true,
>
> Just a comment, I would rather leave the "default" users of this driver with the default value
> and use level_high_reset = true for the clock ones

In every other place in the kernel, we specify that kind of thing if it
is acitve low. Your request make things up-side-down and harder to
follow IMO.

There is no 'default' user, there is the platform ones and auxiliary ones.
Platform ones tend to active low reset line. It is clearly shown above
and hard to miss when adding new platforms.

>
> Neil
>
>>   };
>>     static const struct of_device_id meson_reset_dt_ids[] = {

-- 
Jerome

