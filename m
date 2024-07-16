Return-Path: <linux-kernel+bounces-254110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B45D3932EFE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E1532839E1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E823D19FA75;
	Tue, 16 Jul 2024 17:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEg63/zK"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0076FC19;
	Tue, 16 Jul 2024 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721150543; cv=none; b=AxExqfZ6Kkok2pFP2RIzINEgCf2jcWFQXfytI6F4rC/2Qkl8t5jvjTQEHKWoBJraiGpnYnRE5Nt1TEUl7XcILAlraAAIcUf7ZqUAzR2vSaZ+ASvml9rmMNVdMGrjXvSg6Cm0pGMC1uXITAbKwHMMt5UgZ1k0Ix2+F4epFBdlvPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721150543; c=relaxed/simple;
	bh=BFaNgVBOpWMp4MgWoO+rfbTPXHDvPLmxBQRxoluZ9PU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZ7PoP80JprVjeSRwOngSo+PoDhYwOmEgoOMZ5dPHtNdZDhq/HiyaVFN4bau6wZnrUIHVK+qxw8W4raq+HNkovtWlaaQ0wWnIeXuGeklgIRgdwNfRJUtfjjrYHm6EivewXa7u0aBZRDcmpIKw0/k0adFjmW6zVa3H6u51UVmIYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEg63/zK; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d92d1a5222so3532941b6e.1;
        Tue, 16 Jul 2024 10:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721150541; x=1721755341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bwfcgG3x9YOu+7xDuN1e5i+SYJNNR7DxvLeQpbNA888=;
        b=mEg63/zK9zX0451XKq2F1IUpnh4CyF62ejP4D2m9wQwU3eCiyFnOaM7mQ+mbqeF3rw
         UFCx0KkjC0b9/+mm4+er2fJ7whOfxXmVOsBu7NF5jJs41lXqbYd+8LgBdbrHA7BFS3Zw
         ug5rk+OjZ4B1wZ5YcAKYJuan/2icbTGIR1c4ne+z/+3R+HlRoW85hrQL1mHlXy3upI1K
         /BEJZFbbuP+9pLjPzWLLZKbd1wb9NV2/memme5Rzj1CFVLVKxxEQs+nu35V3T+DE2IAj
         JjJ66omy6k+xEPpXH91JqwkENNYATYfyZUXV1nUe9RaTNQmwCwa/oTSwX6JxXv/d7sLD
         +Fnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721150541; x=1721755341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bwfcgG3x9YOu+7xDuN1e5i+SYJNNR7DxvLeQpbNA888=;
        b=M5xP91aeRggfK2vkQuJXStxbCK9OxzZYdSlaIuHKDvXRuhedb1uwfgkYOrlD8vZ51w
         4feFubL/vRhyw3B3wNkJWOcNomiCLOd2MPn+UHbMmg24d36kpXR/00a39e/JbFQC24H9
         9vreqXwDMQrgqp3m8jgrSNsYJXyVlGGchNN3m+XZMstf+ClOs2/VHsMHEmmuc3MV4UvH
         v4XUnxt/85Ly2JaAGW00xxkaEGqLKlAiRRVV8Hj7gBMgzrR6ru+kdBXXpbdrWjpPjSz0
         pmbcezk9kQrZqY8ZX7K6qWl+7en8MkEGXG8+BzAEpf8wh6lOGeg1RPwFgACsQwTzItX+
         58RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS8FrfXgw7UTmb+2OJ9jOfM97BVGDkr1kWz4wMmjdFczpNhvkIH8boQwXxYHRwNtW4XAZKijBsoxEBTV1WKz9VdjTvYPQ6DAaS84vJQFBO/qBBckzgzTNTuYdqqg/Gp13HnDXEFdh8NQ==
X-Gm-Message-State: AOJu0Yx3Vi/ctfrjaU66p66T6wY0q2hDla77dJbyPg0qbkOATWeFwp/T
	u2Y3znUhRguDh5HYOR0yxkJGmB/mSYwm5sSpkWEe4lK/L8EjtzeC
X-Google-Smtp-Source: AGHT+IHZY8ss+7sAQRJyyl88FiII7Jt/xGsSMkvWTchHh4EOKU9aZsGVCxy66j0OhmaTKGX9xymjXw==
X-Received: by 2002:a05:6808:2220:b0:3da:3207:edc3 with SMTP id 5614622812f47-3dac7b5d29bmr3798035b6e.2.1721150540867;
        Tue, 16 Jul 2024 10:22:20 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7a160c73616sm311662885a.102.2024.07.16.10.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 10:22:19 -0700 (PDT)
Message-ID: <6f33ee6b-ac64-4b20-a9a2-dfbcac20813f@gmail.com>
Date: Tue, 16 Jul 2024 10:22:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: bcm283x: Fix hdmi hpd-gpio pin
To: Florian Klink <flokli@flokli.de>, Stefan Wahren <wahrenst@gmx.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240715230311.685641-1-flokli@flokli.de>
 <f178aa92-d91c-406d-9fea-1021bfb99f55@gmail.com>
 <e3872f3a-9736-4507-bbd3-2ad7698562b4@gmx.net>
 <5pgipwi7ckrjxec7yzqxnvnoggjsnvhb2mtcq5hcwanhp6t5tt@z4s6ouppd2vz>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <5pgipwi7ckrjxec7yzqxnvnoggjsnvhb2mtcq5hcwanhp6t5tt@z4s6ouppd2vz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/24 10:08, Florian Klink wrote:
> Hey,
> 
> fine with the subject change too :-)
> 
> @Florian: Let me know if you want me to roll all in a v2 or are happy to
> apply that subject change too.

Will fix it up while applying, no need for a v2, thanks!
-- 
Florian


