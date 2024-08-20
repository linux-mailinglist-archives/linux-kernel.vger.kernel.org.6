Return-Path: <linux-kernel+bounces-293945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CD79586CA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13D02287BA0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B4718FC67;
	Tue, 20 Aug 2024 12:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cOMwevp2"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D1F18F2F9
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 12:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724156332; cv=none; b=RNLVClaiepW/I+ESGjylfNEb24pup18NxXgV5gngtu6WtHQ0iqTacAEtANIn2zD0lY4zILlTOZ+95BywMu2EGSiFlfx9Gn00jfMTIoMSkvUo3S8AfVPSmzVYv9RhVioRIawvTxLgVazv/VY/9gNynQ6CDTcSyEgtJ8OH7PVJafA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724156332; c=relaxed/simple;
	bh=AZy5Vfz/A7HN0F7XrqwbYiq01vG/lO3OkKWKGk1orDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nCc1MVCjDwxDVNdGT0jNjD6DI6Fs2IYNJSJ5FKAXk3ZRfZKsdua8XP43VsY7MdC2f3ZADxwJOJjv83kEi3oBbIVs1YpUpZVIJ4jh8UNcVW3N9WxSOZFvpTV4VB/Ckpy3BY2ii5CkyqhTFpMfmmr57yu9fVSCdRmKCB7eaYk+u4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cOMwevp2; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-710bdddb95cso3144259b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 05:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724156330; x=1724761130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dxAcxGclIuOwfMb41R48bF4I8HWomP5VfYX9t0ZCnsA=;
        b=cOMwevp2R0hE/SWYrElMYw9VMOv+/z+eUq1+hFTVxrGKrdOJ545iSdl7aFPcRKgBup
         E548TnGgfUD87Cv5G1IZc7a2179f7yHHau+//93g2e3Ml1Yh6qlOqBdmsI+KFI+n4MP4
         4n32Od6HW+IIs6Qhagps0MyvjyggTrOkerSCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724156330; x=1724761130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dxAcxGclIuOwfMb41R48bF4I8HWomP5VfYX9t0ZCnsA=;
        b=G14WJL/wINejZRW07P/nKcw0Z7/mbk2SXNqLMxUb0T5/lNo/yNxzSnucWj2luPfdFw
         9kKN+gahQ9YpgQKefjHxH6yiHWG1+bykbr/43tkDG36sGZ0EP6Xj7cqA+ZoHB3o8v4C7
         lYGB5QNBiVxfZi+2D5mMCAK9gS6Ge8TDElOAPyK3Ls9rmSBr5U73jiVfeeuNBsNWLVRW
         pICZSXEn64qwanJkky3csUw3BvIhdaP5EKZDrfCDr1G/5U7NhHhaX6izAdBDkUkabTUG
         TbiQbCkMd/+SZuT1/RgrRl1NP/EemrPf6WCY7Jl6ZSD7USGwNRXPlMgX4vY5m/Uy/ZZW
         pHMg==
X-Forwarded-Encrypted: i=1; AJvYcCWYk0u4T5bQOZlMUgQg+fW+AM0DRpKPByDf3YUV7qsJ5lnPP8Y8+gLqbYbWZHWXfSg2kDb5H3G/gmQhK3sUx1dLtm3Oe79ixtTTMvMP
X-Gm-Message-State: AOJu0YyLcfvoS84dMc/rkJ39X9CY0yk5U6dD+tR4bA4epS5vfSDajOG3
	zd3MjoqH9YxNxgOcoDqPgrzYfc0Y5EVrlWBJkLY0Dfb3DRUVEUwQjlMU9f+MBQ==
X-Google-Smtp-Source: AGHT+IEaftbPHnk5gj6LEhcatbaYAbzJyPyHa/VXh1Qov58HvRrDUW/6ESy2CXTKfuohmz6Oo+xhoQ==
X-Received: by 2002:a05:6a20:6f8a:b0:1c0:eba5:e192 with SMTP id adf61e73a8af0-1c904fb8e21mr14179130637.27.1724156330370;
        Tue, 20 Aug 2024 05:18:50 -0700 (PDT)
Received: from ?IPV6:2401:4900:5611:cde:9119:bcc9:db94:3510? ([2401:4900:5611:cde:9119:bcc9:db94:3510])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b6365998sm9309672a12.80.2024.08.20.05.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 05:18:49 -0700 (PDT)
Message-ID: <1899ea6f-b734-4748-aa00-d7049d553994@chromium.org>
Date: Tue, 20 Aug 2024 17:48:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: display: mediatek: dpi: Add power
 domains
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, ck.hu@mediatek.com,
 jitao.shi@mediatek.com, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240820080659.2136906-1-rohiagar@chromium.org>
 <20240820080659.2136906-2-rohiagar@chromium.org>
 <b5wtwpkwgg3tbwya6zllmymaaf2qvnyfbspkynr2ruzncej2ql@qloslxfinvos>
Content-Language: en-US
From: Rohit Agarwal <rohiagar@chromium.org>
In-Reply-To: <b5wtwpkwgg3tbwya6zllmymaaf2qvnyfbspkynr2ruzncej2ql@qloslxfinvos>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 20/08/24 4:40 PM, Krzysztof Kozlowski wrote:
> On Tue, Aug 20, 2024 at 08:06:57AM +0000, Rohit Agarwal wrote:
>> Add power domain binding to the mediatek DPI controller.
> Why? Who needs it? Why all devices suddenly have it (IOW, why is it not
> constrained anyhow per variant)?
>
Ok, my intent was to introduce only for this particular variant.
Let me constrain it to this particular compatible.

Thanks,
Rohit.
>> Signed-off-by: Rohit Agarwal <rohiagar@chromium.org>
>> ---
>>   .../devicetree/bindings/display/mediatek/mediatek,dpi.yaml     | 3 +++
>>   1 file changed, 3 insertions(+)
> Best regards,
> Krzysztof
>

