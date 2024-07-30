Return-Path: <linux-kernel+bounces-267038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B550F940BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5EB71C224C8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBDB193074;
	Tue, 30 Jul 2024 08:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSXGbL6k"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E35C1A0AE4;
	Tue, 30 Jul 2024 08:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722327913; cv=none; b=nqiASktuGeHaJdIsJTAaNfozUilbTAIviYwi/EKorUXMQntbZoy0a18UAT2bbuwJNGV3d+M7NVu6noylFu0PzCOxM0ElCu19D97nJVV45KzoIzhkY0JN4F7vLqAJTsa3oRrKB7IC1sAKvLAfl4Ms5mLs7o+bzTp5pRzFSxmqngA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722327913; c=relaxed/simple;
	bh=ApivWpQ8lJa7q8tRCfLIi3TzpUOrX4hB8kE9HItG9ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q47AJpRwOFLJFNxNKtUXUFlfMU36ypHBaGML/5HoZ9staRQlQpPvqlwJ+0SO3JJqeMmZmwpY4I9fsNyVQlbBs2hyiacphxZnnnFmesTOmLRd1O0lQDg5ptOMB9Ci++NL8c59bhDP7lCWB2mCpgbSe9vn3khXFpQPhHAaG2IPEVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSXGbL6k; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc569440e1so37188725ad.3;
        Tue, 30 Jul 2024 01:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722327911; x=1722932711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qckIi2AoZEXP83GJ4r7RDX66S9uWuMwxkLH/PVxFmgg=;
        b=DSXGbL6kZEuzT/VeLW7TIK1X71P/QeUiFeS/5x1t+O2+CiQG5FRzwqsp8YDe7Xg9Qg
         QCJO1VyJi8TBZMvIh/2IhG2izLlUBwvSzOqV/Zn4tuyiUbYfI18vVTggki+Qdo7BpeQL
         FLQwhQFnAGf+Fz3gTsuTOM197Kj1mdvVdjTHYspfHSHZtf/WSujeL/HEd1Dz8XpOnZtr
         dK8dPh+qwXa9ZLb3W58HvVoi28rrlnjec20/2wvNv7E4ubQ9yZuggsOU/EX1YDBVHS69
         6Uj1DmqfHCSMDNhE62D0zBGeJSDnmXr80rtJ+DcfyP2pr1t7AHjzwYFfhxdi6IdVrOI9
         K5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722327911; x=1722932711;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qckIi2AoZEXP83GJ4r7RDX66S9uWuMwxkLH/PVxFmgg=;
        b=j/59aakdG+ONGCHZkb6D43S7kKwN36fKXy3EPuX32zBok7n6r3Vsel2HmgB83uxo4+
         MtvDnK+QJ7yx2IBjeWG91Oz5Fy/D5pwH6d4JoYL7NIAf6pbt1hahlhjCuMR1iU0xbqhb
         conamXwef+gui9wNWMjKfSwqm5rklAkxwYfTqJ8sEV02D1Y7QCfO0ruvOLlFswpObABS
         aKeaP4CWjo9pXbZRAOO++jGt5wYcUbeVjQqf9rVL7DWPTQ7rTVnA4oBEAR0drU9c85Pl
         MohimW2VHpA2hMn8wX0tq+JauNP0J3ywvlJVVWInXuPlFUCwv0X0ZEPOchryseGT3YrI
         4d+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKhNpY6lOHtH0sopgqddhI5x7A9HgUuydpIviWz5ze2XSHM4+KqU9SS9a4cxDvr++mWTfHo73++KTIEqxJUfs5w8cc7s6fwjoFU4B4ZZeAWhi5nejPWxphIjhvyhuCKyZbplKbmIcaLg==
X-Gm-Message-State: AOJu0YytFWKiH9R2lQUgibk3W0JO8moF5Vuk9GyIK9Je4hGcMLmEDnQB
	/oJCx3lqTEL4dyZn6WXYOaHwjZCw+7vCxo3fA7hTIwfBk5i97cFq
X-Google-Smtp-Source: AGHT+IGSXVT2EcIrf/DG6e2iDLAmk7jt5supjJuhp1uB2Uz5k5Nt71PCi2lOzcchFy6FE+586xfuYg==
X-Received: by 2002:a17:902:fd08:b0:1fd:6d6d:68e7 with SMTP id d9443c01a7336-1ff048b07b9mr110591895ad.43.1722327911278;
        Tue, 30 Jul 2024 01:25:11 -0700 (PDT)
Received: from [172.19.1.53] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee1234sm96172415ad.165.2024.07.30.01.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 01:25:11 -0700 (PDT)
Message-ID: <19898579-972a-4193-8b4e-1d7de931e151@gmail.com>
Date: Tue, 30 Jul 2024 16:25:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: phy: nuvoton,ma35-usb2-phy: add new
 bindings
To: Krzysztof Kozlowski <krzk@kernel.org>, vkoul@kernel.org,
 kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240729061509.83828-1-hpchen0nvt@gmail.com>
 <20240729061509.83828-2-hpchen0nvt@gmail.com>
 <c4c2b30a-8ff9-4fc4-a1ed-adcd366d15a7@kernel.org>
 <37f1ecdc-9d98-4681-803a-75442fe04ab3@gmail.com>
 <e82d746a-5881-43c1-8439-44a53fda107a@kernel.org>
Content-Language: en-US
From: Hui-Ping Chen <hpchen0nvt@gmail.com>
In-Reply-To: <e82d746a-5881-43c1-8439-44a53fda107a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Krzysztof,

Thank you for your reply.



On 2024/7/30 下午 04:10, Krzysztof Kozlowski wrote:
> On 30/07/2024 09:44, Hui-Ping Chen wrote:
>>>> +
>>>> +  nuvoton,sys:
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>> +    description:
>>>> +      phandle of the system-management node.
>>> Describe what is it for.
>> Because this driver has some status bits located in the sys, it is
>> necessary to reference the sys link.
> Describe it in the binding - what usb2 phy needs to do in sysmgmt node.
>
Okay. I will add this description to the binding.


>
> Best regards,
> Krzysztof


Best regards,

Hui-Ping Chen



