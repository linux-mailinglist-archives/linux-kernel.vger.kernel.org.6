Return-Path: <linux-kernel+bounces-377051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E499AB948
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 00:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5178284B6B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101B11CDA02;
	Tue, 22 Oct 2024 22:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ajZFuwUz"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AB119D075
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 22:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729634498; cv=none; b=uuJuq4t0BSgBfhu++hVWhm89/1CVeibB7ePuqrwYLKVLpHnOYp+Aan56nL1qr+cTUC9FWbNeFzttrdQ4nV4+zmRm/FdbIXuW/y0Sghkho7UKsfxDi9pvcFnj82T9XzaPwNErINGgPmrkC4ed7fyQSpVT8qzgW5C2RLvyFRsbfgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729634498; c=relaxed/simple;
	bh=n5fqThXXJENu009fRQP21i339L8tBhoZxtEg1OsM9T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VxmgisfIR+ALFEBJUluSRWGVd5U8gNrAbdFZIeEQjAiTlqbow9y1WEis+VDQiYbiEfWNurB5k5jh5gXcpp+M+NPmX6Ez1ZwH/dZKgPETGegRu2ME7H/YuuMeJffHw3Au8cBFYQG8aNzHSeYq7YFl71KRHoPx+3aympae21dZc9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ajZFuwUz; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso84767731fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 15:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729634495; x=1730239295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U2VtMMWcy7426eVZmr4BVetTtNhYNhFvcWhVUE67Vw4=;
        b=ajZFuwUzVYPXEuXqlxIq5EF3+MR1j04NAKdkhZB8AXYMo8IIZ2obwPD2L/URS941Xg
         pSmyt9itghvzF2HDxYTK4pbFY/4t8cjPrqA7wMBXN5hULe0N8yG2l4iSj0dRj9IMeTBV
         kq6wplJLDOnO2bLoj9njm6QTtTGNUdZebpIlgZBtt1hMV+XdeQkcVeFEPNqE5B2Lw0bY
         wH8zIZ5jps6csOa2VGCRamPniIAQJ9Ti7XKBLU9vPuzTrTPIYwl8tS70CQzcVxaCwX0p
         mOIgZ+k9flsR5ij37yLFUZRf+3+51BIpMFjVtXIByO7gHfttEWzWfwcTAjWFXJRxnHd1
         J00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729634495; x=1730239295;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2VtMMWcy7426eVZmr4BVetTtNhYNhFvcWhVUE67Vw4=;
        b=AfX9LnsyV8K7Cn17X+M+4c4ixUdNEx26OAUo9Fn7A0sd70uHnAsLlJ+RyVLZTzfmA0
         j8lERLrBYBGe4LbLX4a10JMSWb4849lu7mGcOgAdhrl/1v42wI1FUJbNZBOzV/KA8fKx
         9HoeTaxoRCITuuf1w+y6vMF/1IeSlg7zc/dzWwbLJENO7lCuQTSI2FIt+u7leyqmJ7z1
         ObNzv9PhKyaOS+pzHKmbXOG6uJsA8mHORkZyZ2rXQnPw5rsLJECYtG/JZlyfooFvJAbw
         P8j8w/lSmCqX2W2suv1A+kfY5C9I8wYUQcA/s7+SY4E4tzGefPz7YHwjqAWVmlrg6ktU
         Xq6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQ5zKCX97a1GeaiWKCWr2UXc9PAz1AlTHivwjCQliPa0TN8aWlb5qAbL9yXLEjwkiwB2hjTJjTW5yNZlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgUF20T3RslyeScT5M+vZbTVBry5mGalAEmFi1Yf0wripVqZGB
	3/pBix3H3jyt3Cot8+50B5KX1V3nNekkQLgp7LtHe8L8UDQcYWB9UaxvLxCIQeA=
X-Google-Smtp-Source: AGHT+IHe+jPn+U0mKZMGjgXacHcxcDaAHcifzv4VrSOnLxj0lpXay4saqXfqbEzlsGB1tvD/50HFgw==
X-Received: by 2002:a2e:b88a:0:b0:2fb:5bd:8ff2 with SMTP id 38308e7fff4ca-2fc9d31d25amr2945211fa.16.1729634494735;
        Tue, 22 Oct 2024 15:01:34 -0700 (PDT)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91571f2bsm387981166b.163.2024.10.22.15.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 15:01:34 -0700 (PDT)
Message-ID: <99bbb067-868c-4ec8-90a3-2c3bf6df3690@linaro.org>
Date: Tue, 22 Oct 2024 23:01:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] usb: typec: ucsi: Set orientation as none when
 connector is unplugged
To: Abel Vesa <abel.vesa@linaro.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20241017-usb-typec-ucsi-glink-add-orientation-none-v1-1-0fdc7e49a7e7@linaro.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241017-usb-typec-ucsi-glink-add-orientation-none-v1-1-0fdc7e49a7e7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/10/2024 17:01, Abel Vesa wrote:
> Currently, the ucsi glink client is only reporting orientation normal or
> reversed, based on the level of the gpio. On unplug, it defaults to
> orientation normal instead of none. This confuses some of the orientation
> switches drivers as they might rely on orientation none in order to
> configure the HW in some sort of safe mode. So propagate the orientation
> none instead when the connector status flags says cable is disconnected.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>   drivers/usb/typec/ucsi/ucsi_glink.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> index 3e4d88ab338e50d4265df15fc960907c36675282..b3bc02e4b0427a894c5b5df470af47433145243e 100644
> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -185,6 +185,11 @@ static void pmic_glink_ucsi_connector_status(struct ucsi_connector *con)
>   	struct pmic_glink_ucsi *ucsi = ucsi_get_drvdata(con->ucsi);
>   	int orientation;
>   
> +	if (!(con->status.flags & UCSI_CONSTAT_CONNECTED)) {
> +		typec_set_orientation(con->port, TYPEC_ORIENTATION_NONE);
> +		return;
> +	}
> +
>   	if (con->num >= PMIC_GLINK_MAX_PORTS ||
>   	    !ucsi->port_orientation[con->num - 1])
>   		return;
> 
> ---
> base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
> change-id: 20241017-usb-typec-ucsi-glink-add-orientation-none-73f1f2522999
> 
> Best regards,

We discussed this on a meeting and the logic makes perfect sense i.e. 
when the cable gets yanked the orientation shouldn't be assumed to be 
anything => orientation is none.

Re Johan's comments needs a Fixes tag though, assuming that's applied.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

