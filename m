Return-Path: <linux-kernel+bounces-529331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9043A42308
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 452101887BB6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0D9248869;
	Mon, 24 Feb 2025 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NIDdInz1"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FC818892D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407322; cv=none; b=Z1mezvb9ZWTP4ET3NjijJcL/p2aBD2vp25cCzORXXBvNThmzJnn/AlJy6pc9dxOdqHCHKtgUS1yyAwPMib7gMKFMZ2xt+JioUvHSjqWXsQvvfGJrOFvqsgb1eVdG7kkOAuACFvwn46qHX+obuHAEbkb/tM3WUT49uDcAATwKSZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407322; c=relaxed/simple;
	bh=fi/ou784DQNSO56UkdVWMsq5LgKy3w3Myno9NribxME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PI3baF9gi2sm0Yk8haGqMAQqYgaJeH4pfis0vyl2ojEIdpnFi5X9wpLPb5Wf5taH7VxZtgMiIQPez2+tMwIqkNlaYUCw2YxW5+VAaqmf69cwvUA3mypUqGPV1HqSEXgD/CQZzOQKmERsAF4oHNoARwlApRESK4YCMBsuEPa5hAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NIDdInz1; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38f286b5281so2200598f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 06:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740407318; x=1741012118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+7myiS5YDjg48/Ag8fwVJzAPYwjPP2oihtGPggfyt3U=;
        b=NIDdInz1gySZ1Peryoh6lvdI8W996Kezrv9/7HCTbwKmSstoUQr68X4wrRHBJJpJcs
         plB36mCAiTPd1Alt3WP0piTZ3J8JX10Fx7o6t13HyAfWrBBpZdTyMzy6C5ruHljTI/1U
         vo69mLrkkPbfexYJQ1BQd0CwkdpFZbj0Ds30e5AeBQwoZLjRg7uf5YWPi+TutGPjTR6D
         dt3PKthzCl4CLiC5UovTZjmJ8SYmFD7z/rIwu3dEf0f8heMmCC2H0uoONOMvzvECD6yk
         J2aJWTUXbK7Ysa9sCh0HyagbBuIjIcuQ+GBGKfaSdxmwEyZFMt1pw/3quFS7lvX+jXTM
         rPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740407318; x=1741012118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+7myiS5YDjg48/Ag8fwVJzAPYwjPP2oihtGPggfyt3U=;
        b=f761YWKgF4rFgbIhRs/i0a/Ko+wkeZoCu2f3yDPGfM9guAm3YnRq2CNG6g4vdcEBpE
         c6ioKuu617rB1tHL3+kkw0htYgiwhBNrG6p+k1fy4N3Y/MCliTy//BvL7SoknsrEzjq/
         Ne4REO9Ikn+W+AxkcdJKYSVUfU+MW/1gbsAT6nen1ss6sKOaqjkzRiQ9me0s3EObaSb7
         TJshM81uqA2gFsIGYlgKlv227hxjthAInCEsg3vTxPqkn/4dzg/R160jEbNHkiKHdqBh
         hhY6qzHulDLmfHjuOA+InF6hU5CWiNDB8cQjaceDyRzHaRzJpRP+j2xgHShMOfCGXlps
         iXig==
X-Forwarded-Encrypted: i=1; AJvYcCXdEQLcVwlqGytwbnt3e5e/0NWs9ZRCsYPktCpowltUCyJbBphPSglkj1w8/HJHBX/NVUs4tGZxwQUZJQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr7rnxNA/FthgR5vM7Bvy1iRXMJpmnN7Y+qF4ZAgyhKtw54m2j
	66UyYF+IYQTajwIyifA+zX63uOPL8EWS0tlUiqaBQfLpNcIVoB+P4lNLrla4GCsUnaaS2EE/3F4
	mVzg=
X-Gm-Gg: ASbGncvv2HHjzbCv6TLLOXqEudte9BoEkSh1ZFsLpqZpsYN8cwE1cxHNU8NjjSNxJf1
	Ev1vwHq66DzwU4hLAbB4J4zPnuhTz5ecNXvPhBEBzTHsN7YhC2Pa5RyEIhiIHB6Ax/FtGzRVPHW
	b8e0yhukhJkmwBWsRpUXSiTNurQxj+0W4HnHOn+mMPMcWciICn195riCxwAeZUoE80tebniqIQX
	4gfRo959vCVqrdg7vtqy4HcuuYr0SrlTyVxhC5S+t7Ywv8MloYXS9zb8mOmRdrylqbUTFGCjOVK
	oC+NL0ZFqZVtYYCLg/2WVfesTsIZ128mraRevpeXYXFhsZKxX7gcsJTmjHJidl9lgu2K67aPxA=
	=
X-Google-Smtp-Source: AGHT+IFgTjY0B9Q+EBdWo53fKYf0MGWnVrcQoJfE4mJdhQbgBfmM6+4xRs286ajDlhlvB8MLPAk/3g==
X-Received: by 2002:a05:6000:4014:b0:38f:28a1:501e with SMTP id ffacd0b85a97d-38f70772b46mr10667747f8f.8.1740407317886;
        Mon, 24 Feb 2025 06:28:37 -0800 (PST)
Received: from ?IPV6:2a01:e0a:5ee:79d0:ce53:5813:dc8a:b123? ([2a01:e0a:5ee:79d0:ce53:5813:dc8a:b123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d9be9sm32217076f8f.79.2025.02.24.06.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 06:28:37 -0800 (PST)
Message-ID: <43d23c40-09bd-46ca-840f-4724a42946a6@baylibre.com>
Date: Mon, 24 Feb 2025 15:28:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] arm64: dts: mediatek: mt8395-genio-1200-evk: add
 support for TCPC port
To: Macpaul Lin <macpaul.lin@mediatek.com>,
 ChiYuan Huang <cy_huang@richtek.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
 Macpaul Lin <macpaul@gmail.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 linux-usb@vger.kernel.org, Chris-qj chen <chris-qj.chen@mediatek.com>,
 Fabien Parent <fparent@baylibre.com>,
 Yow-Shin Liou <yow-shin.liou@mediatek.com>,
 Simon Sun <simon.sun@yunjingtech.com>
References: <20250224114934.3583191-1-macpaul.lin@mediatek.com>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20250224114934.3583191-1-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 24/02/2025 12:49, Macpaul Lin wrote:
> From: Fabien Parent<fparent@baylibre.com>
> 
> Enable USB Type-C support on MediaTek MT8395 Genio 1200 EVK by adding
> configuration for TCPC Port, USB-C connector, MUX IT5205 and related
> settings.
> 
> Configure dual role switch capability, set up PD (Power Delivery) profiles,
> and establish endpoints for SS (SuperSpeed) and HS (HighSpeed) USB.
> 
> Update pinctrl configurations for U3 P0 VBus default pins and set dr_mode
> to "otg" for OTG (On-The-Go) mode operation.
> 
> Add ITE IT5205 (TYPEC MUX) under I2C2 bus and configure its properties;
> also add references and configurations to 'typec-mux' node.

-- 
Regards,
Alexandre

