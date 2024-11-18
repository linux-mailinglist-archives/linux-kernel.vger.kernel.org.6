Return-Path: <linux-kernel+bounces-412790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C57D79D0F07
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BE461F222C4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FE1194C96;
	Mon, 18 Nov 2024 10:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hb5Rnlwh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F25194A53
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731927344; cv=none; b=muLDdIy4TX2oKwkioOhTqm39tjElLOPwc7mAF+1VhrGicJumRtncG1FfNW6f/yI+kFaph8gDuJKK/iTX5PhhpXRym2Z1bRvKCzbKFfOXgSa/O7JyUbZkyA8r6zSUKuWr625uXPTzxiP/rljF7cOMXiZeBZvnTdjm8sXRQbl9v+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731927344; c=relaxed/simple;
	bh=ZcFDjxCikiIDehFzhPFoKi4SBUA/t82ryu7kG31flDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dgFs+LKFyw5m+eeW14shZ2+146CqBq4IoY8izQvxurcxwIL+0tUmPEIA6HrBCrC5dPCq07RguwxXInW4v/wUMRu+QKFZPyw6ISaARpup+ShHbXxJCMRIkyvUC9ku81kYlp76KNMJLeEVB3ikvttkIyMZexyCPbnGjaCjt4B4w6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hb5Rnlwh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731927341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AnKB6OxF/nzSNsYCRUDY/ZZFnQ2D348/yl+VsYaNxvk=;
	b=hb5RnlwhJZd9uYV7dmkpNuh5s7ne3bbgbiK45l/c8SiESei5uuOP+Q+4zYt4mJ/zkN/1Nl
	YoFv/8UgEnIlOiSBL+Ha3xdwvuKckOgE4XOjyCeuB+osdwuhYBCnFc2gJ9OBmXElLKgS6L
	DztIC0i/X9akmep/Wdwe2o9FYlqHao0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-0ETeO1n6OoOaRxzJex9qcg-1; Mon, 18 Nov 2024 05:55:40 -0500
X-MC-Unique: 0ETeO1n6OoOaRxzJex9qcg-1
X-Mimecast-MFC-AGG-ID: 0ETeO1n6OoOaRxzJex9qcg
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a9a1e429a8fso136384966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:55:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731927339; x=1732532139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AnKB6OxF/nzSNsYCRUDY/ZZFnQ2D348/yl+VsYaNxvk=;
        b=wgy5vky5W18GMJeMVF3S+amH0y7zR90aED+fX5ycvZGzVBinj5bWfzTo8e2btosU0K
         UtLeqNHwtONzRIQ6ehuyrSp3xjU+GrCvhP/2mQv9pEJYZvsG4FKdBoIX8rrX6LIGFSfA
         JKQWvhyxcGvRFjypU9GQvJV830TlDG/jMAP9aIxNhVLY2zo2WLva8IU26wUfFNoGf4fK
         xsu2L7FBa/ln3P1eLxiiOS4ZCoB1pt2sQeUSy6mg68YVY5UHjYyKwanJVt1uIBFlkEUK
         uG4A9D0mf6dpr0CjFkU1g+RkusER7elPevU28sPCsEOIHJhK1D18arJGjW9ZqZENswPw
         lXIg==
X-Forwarded-Encrypted: i=1; AJvYcCWyn4IQQAkBgjc3GkzmTvqR6BajlTJBIAklrQUSCYw+DB0UwmZE9J5ZGz4Jph8IZjaKIKtNfzpFDB8iu64=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOrarLRYsCXxJ3XBybroNCoZVv3FPKkEm+ISuDLDWwCR22I+NZ
	A6C7Ni6St8G38iIX4fgUeiDwjswHN6tFEhgnLXvQBb3HOV9O5zbrDhbq/1SPx6uAxyuRQ6dB2sq
	7KsM5Bcn6IbYi+YC5sGHqLoDhqpuPd5X9Y+zjLThX4sdstYjhLul6fP+Ga40tvA==
X-Received: by 2002:a17:907:d24:b0:a87:31c:c6c4 with SMTP id a640c23a62f3a-aa483420c9dmr1098522866b.24.1731927339056;
        Mon, 18 Nov 2024 02:55:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2vTdiBnn4PitIg3NGPzUBSRlMyCFj1MIDShUo/ICNJU5eRSVBn7pak/o015A12IJGuEwz+g==
X-Received: by 2002:a17:907:d24:b0:a87:31c:c6c4 with SMTP id a640c23a62f3a-aa483420c9dmr1098518766b.24.1731927338635;
        Mon, 18 Nov 2024 02:55:38 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dffd721sm536956766b.107.2024.11.18.02.55.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 02:55:38 -0800 (PST)
Message-ID: <322acf33-4569-4e57-a4b5-af60cb0091b7@redhat.com>
Date: Mon, 18 Nov 2024 11:55:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] power: supply: max17042: make interrupt shared
To: Dzmitry Sankouski <dsankouski@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
 Purism Kernel Team <kernel@puri.sm>, Sebastian Reichel <sre@kernel.org>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-msm@vger.kernel.org
References: <20241118-b4-max17042-v3-0-9bcaeda42a06@gmail.com>
 <20241118-b4-max17042-v3-1-9bcaeda42a06@gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241118-b4-max17042-v3-1-9bcaeda42a06@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dzmitry,

On 18-Nov-24 11:09 AM, Dzmitry Sankouski wrote:
> Fuelgauge blocks often are incorporated in bigger chip,
> which may use only 1 line for interrupts. Make interrupt
> shared.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/power/supply/max17042_battery.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
> index 496c3e1f2ee6..99bf6915aa23 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -1103,14 +1103,7 @@ static int max17042_probe(struct i2c_client *client)
>  	}
>  
>  	if (client->irq) {
> -		unsigned int flags = IRQF_ONESHOT;
> -
> -		/*
> -		 * On ACPI systems the IRQ may be handled by ACPI-event code,
> -		 * so we need to share (if the ACPI code is willing to share).
> -		 */
> -		if (acpi_id)
> -			flags |= IRQF_SHARED | IRQF_PROBE_SHARED;
> +		unsigned int flags = IRQF_ONESHOT | IRQF_SHARED | IRQF_PROBE_SHARED;
>  
>  		ret = devm_request_threaded_irq(&client->dev, client->irq,
>  						NULL,
> 


