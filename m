Return-Path: <linux-kernel+bounces-317939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2519896E5BE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 434F81C2357F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9838A1AAE16;
	Thu,  5 Sep 2024 22:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pz6ehap5"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF83E56E;
	Thu,  5 Sep 2024 22:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725575314; cv=none; b=lUpZGDtDus1d7W/HopfLbWbTEHaNtg64bcube20dQrzZHd0Xqwaq5Z2XEqWtgbtYcMAHgH8b9NWFgoV02V+3vAx8jzcrUa4Wdt/VAkoc6rRX4yym5CoP97IyM7yxgZX1mAyHmPNCMn75bLVa2kEOPytomqWXuNanKnuOwi9bm+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725575314; c=relaxed/simple;
	bh=3vtuWZAHpgMJNojpVqTgyfgmxFPOj4/J7AKpfH9Iv+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BVIr/05MQwG1jPVXHKuWh5+FrOeLQJLCZaOmZxNKYH04cdOg1sNEwH7Zq5tUazpbrta2EnDppgXq8NgIz9BXz1p17doUrX2+gwl6gCZEgDPX5S74UWelO2pV6ut4/07xqUFtQss7TV683WFcK8D45QrxnOtNBu3uLdk/lvJ+nno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pz6ehap5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42bbd0a40faso11446095e9.1;
        Thu, 05 Sep 2024 15:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725575311; x=1726180111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J8bsFvi274Z1/0//LbJLrnJX6Kj0fdqJNvlLX9twL68=;
        b=Pz6ehap5d2QUV7aq5yicMwWA78JO+peEO/c6xkly6DDJaTn0fNAgrzCx+o8ATZR9iz
         jel9ru//od5Tr2QCYg2WEjYgyx23LIJSrksq8/BAD9o+WwRa4JR4oKaZdMdmmcYFNEDE
         3U5Xbgt94QJ6hqAltcIYK98Y1JvHaCmJPGswShafHoyr2o31l2+HGtXTLowmV37oYqFp
         JwE6wvRCJ8sy9/WQMfRhynNMjnJBuKCTeEuugr73Fez72fVHwC1WDlm5csnhtWuoMJwh
         buvu9JbULGUefKdmI3OZEyaDHVv2QyT/LNugZOMPvh8dIXptYj4S0V/UaGbmLauR+xXJ
         Jvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725575311; x=1726180111;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8bsFvi274Z1/0//LbJLrnJX6Kj0fdqJNvlLX9twL68=;
        b=YrU4uKw163SXVvc1FmzJpUxn74ML5IM9e0lRAIWKe65OVXxeGSJAt6TcWqDlOso8S4
         c0nwUp27TCjYsCqloYjUuyBsuCHAZSYL/I7VQWgGwvGwLntG2/+bwe1d84onNfPPVLyN
         2zWjuLORcPAPAfqJUCXSWzHiSQC7B9kiKwXVQpDbN/qtsncMowpzYbn66isFmn78/FI3
         kLTpdgCYAkphfTB5yVju2ok/p+O1MOJOcbaBWBAbGsgwuDdu4islItzoYf2lTucmysBx
         NciB8iYYt6GInJ7qGtuMEVBGoybk5iu9Yu8AAzjbniZgcpUmoj2WS8c/9/x/pJAGcKxT
         BPCw==
X-Forwarded-Encrypted: i=1; AJvYcCVLPbERlhfum5FzTwKqsGd/xNB0UTKpe3qwkiyLVV4TWWmK8eiVK1f+++HXunUWlh/5S3wIA8rHplp9gLoK@vger.kernel.org, AJvYcCW+qzxL4OO5epM6M43eNip/Cd7rWlxnSpLIRbb3e9AmyamMtg6Gys4gGPtzVgQwKn9WbBWZJ8ODYhZO@vger.kernel.org
X-Gm-Message-State: AOJu0YzaTA0z3EAH0VsHqucyLP1DhMxgfE3CbH9BTGzd35enGNvXJRLO
	l8fghUqLSp5RwnsQK15dXJ10mOwPcbI/+xXvfxdAHzzk3AMwgqvx
X-Google-Smtp-Source: AGHT+IG76TGZrQuFkLyAWbX5VvJXhIHiBLmreTJqK6O6LTzwG4AxcmxhJGyEUvCTmRyQUMq0pOX0MQ==
X-Received: by 2002:a5d:6743:0:b0:374:93c4:2f61 with SMTP id ffacd0b85a97d-378895c4851mr335843f8f.5.1725575310703;
        Thu, 05 Sep 2024 15:28:30 -0700 (PDT)
Received: from [192.168.2.177] ([81.0.7.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374ba30d5b8sm16525567f8f.15.2024.09.05.15.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 15:28:29 -0700 (PDT)
Message-ID: <3d85b40b-bcb1-430f-89d5-739ad6f907d4@gmail.com>
Date: Fri, 6 Sep 2024 00:28:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] arm64: dts: mediatek: Add MT8186 Ponyta
To: Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>,
 angelogioacchino.delregno@collabora.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, knoxchiou@google.com,
 hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "moderated list:ARM/Mediatek SoC support"
 <linux-mediatek@lists.infradead.org>
References: <20240904081501.2060933-1-cengjianeng@huaqin.corp-partner.google.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20240904081501.2060933-1-cengjianeng@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/09/2024 10:14, Jianeng Ceng wrote:
> This is v3 of the MT8186 Chromebook device tree series.

Please send this kind of patches also to the mediatek mailinglist:
moderated list:ARM/Mediatek SoC support <linux-mediatek@lists.infradead.org>

Thanks
Matthias

> ---
> Changes in v3:
> - PATCH 0/2: Add the modify records.
> - PATCH 1/2: Modify lable to label.
> - Link to v2:https://lore.kernel.org/all/20240903061603.3007289-1-cengjianeng@huaqin.corp-partner.google.com/
> 
> Changes in v2:
> - PATCH 2/2: Modify the dtb name without rev2.
> - Link to v1:https://lore.kernel.org/all/20240902125502.1844374-1-cengjianeng@huaqin.corp-partner.google.com/
> 
> Jianeng Ceng (2):
>    dt-bindings: arm: mediatek: Add MT8186 Ponyta Chromebook
>    arm64: dts: mediatek: Add MT8186 Ponyta Chromebooks
> 
>   .../devicetree/bindings/arm/mediatek.yaml     | 11 +++++
>   arch/arm64/boot/dts/mediatek/Makefile         |  2 +
>   .../mediatek/mt8186-corsola-ponyta-sku0.dts   | 24 ++++++++++
>   .../mediatek/mt8186-corsola-ponyta-sku1.dts   | 27 ++++++++++++
>   .../dts/mediatek/mt8186-corsola-ponyta.dtsi   | 44 +++++++++++++++++++
>   5 files changed, 108 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta.dtsi
> 

