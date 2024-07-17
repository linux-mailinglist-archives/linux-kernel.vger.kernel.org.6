Return-Path: <linux-kernel+bounces-254781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF8F933786
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910A41F23511
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94748182B5;
	Wed, 17 Jul 2024 07:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVAf+0XX"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04D718C3D;
	Wed, 17 Jul 2024 07:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721199668; cv=none; b=Q4EmqMWGzNM8xMpcGB1Iz6MDaNvx33om8kqLRlli2695va1Pg8BlVpPGEdeblrend10YQg/2Vc9elCu7/JbZ1ZJbW77ffxAqoNnQC2aSMk7cs8QRzq5y6pvttwrkfI7Yg140S4VHWz2iQinIobJvF/VpTodk7pK6rBpzTccOO/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721199668; c=relaxed/simple;
	bh=wPGh9hJ8L6n603K4RwjKOCoJ+c13U2nvAWtRYtfi6t4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=unhjgCfedmvmSmZJee+qRAgvRzJsbQRNjabTTvg5cdrDj3sA5ZI+sK37Tz0Vibs2UUfNkWxb8+Eu8c+R3Ekjrw1SKRBE5K+jo6e5G4bG3rwqux6Ka51Fpts4cEye+G77QlYNcCQR6yYWZFCodYfaLehtzOqplVCBBKoHyhi5NgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVAf+0XX; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70af3d9169bso4410019b3a.1;
        Wed, 17 Jul 2024 00:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721199667; x=1721804467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BIqvVG1aJAwtJPezD7HsgM4ZWhFFBG5im4HLCUicOoA=;
        b=HVAf+0XXPyy+0Mh0W4xl17hgi0shosm2GUN2xOBUvTmQciGJmPsLN0V11SGHOWucEI
         uDvT2PSV0COn8Xvihm2D7JmQxLpAjcPYpfCtWbD/KeDhdlQLSSpF26rHvkbOQKsMKxqC
         0IlcXjr5jwEqYOEo6ykhIPXWUZH6nRS6b68IFyqCf7Pk2R9nK/IfV/UyKpTA6R+lQz6s
         a1g2fMp2pa6JQxAFNLwqyKR16obruNP1pb+s7B/SzbnmKg1qZ/C/nbrcs/01p0SFBORw
         ClaOFDcICVJkUP3kCQ5FRu9j+tI9HfLA38Dz6wyFuoMK5rNd8s52IiB8TlFMrjKbIb7N
         bKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721199667; x=1721804467;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BIqvVG1aJAwtJPezD7HsgM4ZWhFFBG5im4HLCUicOoA=;
        b=knxDfvjTiaBXJwDHAOTRzbTz4NJkH8E5h4iqWG6jgGW8CJCEyRSqLK0AlsDO9sJJHz
         03bmYV5gO7fczErCdQpenNst18EhoaiCYsk7DDMsiqZQlHDSaOZ1AAO1OqGrEDMyXXp1
         FJjOpcW19iJv1Zbp/lMAq7N6Z6u4XO1BfT96puELymPhCOgM8H5vBeXnaGr0fI4M/b+S
         i27FrDvH3u0xPosqYUDt+CmgUjRK2ojmAzxK64ukPX3/ho1WBK1TzgMzsXM9t27bkwz7
         MEIPDU1AYv0Zc+HS2uTnwDbqBX46jC79NmC1bOdrVBWAwDpVUYWH9AS4uXEXtaBNiSLL
         iGcA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ72u46js9a3+yHqno4VPDIWjqsaFE1Zm5ZDtai+JBuGii+EFVTKgfHjTfTXZGvSKnzBxtTf60VBu/T152ssBtD9gf/beOMnBRxrhZImzdBn/C9IVT3oJDwy+SrEPxOTCjcDDXCqw=
X-Gm-Message-State: AOJu0Yx8nbYnsHkO+ccrmOMkteCJpQg9W5yei/BlKfjbmmhtJKZXDkkv
	ysD/CFXMvsgal4UL126TZix6l21XsMZ3I++pXoIZF7XUYrtSNhvF
X-Google-Smtp-Source: AGHT+IHeC7UoR6Xe/1y11RPhs3xLhOgqwGTrjo3HScfLmJhEpAjYaBUYzHDOGtnSHPWasj2S3Hzveg==
X-Received: by 2002:a05:6a00:3a0f:b0:706:b10c:548a with SMTP id d2e1a72fcca58-70ce507da1emr886883b3a.22.1721199666651;
        Wed, 17 Jul 2024 00:01:06 -0700 (PDT)
Received: from [198.18.0.1] ([2401:d9c0:2902::c2eb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ec7d2b1sm7461162b3a.108.2024.07.17.00.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 00:01:06 -0700 (PDT)
From: Cryolitia PukNgae <cryolitia@gmail.com>
X-Google-Original-From: Cryolitia PukNgae <Cryolitia@gmail.com>
Message-ID: <fd9423c0-8c2b-4aef-9d76-cb7def3e2344@gmail.com>
Date: Wed, 17 Jul 2024 15:01:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hwmon: add GPD devices sensor driver
To: Krzysztof Kozlowski <krzk@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>,
 =?UTF-8?Q?Marcin_Str=C4=85gowski?= <marcin@stragowski.com>
References: <20240717-gpd_fan-v2-0-f7b7e6b9f21b@gmail.com>
 <20240717-gpd_fan-v2-1-f7b7e6b9f21b@gmail.com>
 <7e4e45e1-9a77-4780-a5bd-ac44cd7c6cdd@kernel.org>
Content-Language: en-US
In-Reply-To: <7e4e45e1-9a77-4780-a5bd-ac44cd7c6cdd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024/7/17 03:28, Krzysztof Kozlowski wrote:
> Why would you add here untested models?
The manufacturer GPD  sent me these quirks and reg addresses, and they 
used them to write their Windows user space driver. They are unlikely to 
have problems. It was fully tested by several people on WIn Max 2 2023 
and Win 4, and there's only little address difference with other model.
> static, so how do you support more than one device?

The device will have and only have one EC controller, I use 
platform_device just for easier alloc and release resources.

Sincerely thank you for your guidance, v3 has been sent: 
https://lore.kernel.org/r/20240717-gpd_fan-v3-0-8d7efb1263b7@gmail.com



