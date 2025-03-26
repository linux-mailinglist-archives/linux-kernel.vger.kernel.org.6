Return-Path: <linux-kernel+bounces-577411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9772AA71CB3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169F7189562D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE08C1F891C;
	Wed, 26 Mar 2025 17:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qR2sTKIn"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E1B1F791C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 17:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009003; cv=none; b=m9xgPOuH1bIF5YdV9uXKj3CU9nA88bUGIv43NGNtdgLDvwGz858U7Zt5MILz3yiAFnBKAUZ9O2200nkND+ucUtj9MLDqJauR53mk4+4ENbQoKuW6cNpVhsGQhiMwE/94eTrXQvxOFMeMgTYd/iU48eTTPx1z+uwUHh5/iPjnaao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009003; c=relaxed/simple;
	bh=s9hN7Yb2FDLvip8w32MVrFLFzpBsY05WU4O19Z4Nkz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uBlTYjPJlDe5/Tpg9vDlWb9GmC16+I6JO+fU3cmt1QyAMekBxWeh96yHjr5UI4cHgES5Ga0sULL9sMP6dTOOHmAK/ClCstaRZVPvFQEDLEzieQIwtzBTLrZiXCUQ64iCbpkufri6heUhNaREQMrZlyrunmK7w8CHPGPM1OCuTUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qR2sTKIn; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso1025235e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743008999; x=1743613799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3wp2aYV7Lf882bB2x9wggl6yd0pKTlalba7I61amZfg=;
        b=qR2sTKInVEi9i10XSbjDLQhiZptNt9O3zqFML/mYYTq1Y3P0ej4KsEuz/MohTYHfhJ
         rDawGswDJzqWxEUbJ04IrukQcCaXCGP/2sS2TAIt8nzQv/pWx0/sk6pOHwIyiwVnVaBb
         yMfuRnxBBQDRfePfYiAbKzC3ZpO7b7Jpd8Ulyn/Ae8uJ9DlJ6EJ8SxLqTh+jHKYAgZzj
         pHgbSFvang9MRfiCH28KjqdVIz6Hbiu/Cx/bBk9dxRC5C7bFosZBo7+ATWbwFw7TdQ91
         W7DIFVE1I35+b4oTy3ruB7/ZWuPgyy5ivcWhWnMZDEr9rzozejyBx1sIZPPAdryt+DBh
         xx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743008999; x=1743613799;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3wp2aYV7Lf882bB2x9wggl6yd0pKTlalba7I61amZfg=;
        b=ZctGfJnlMv/ZtphX3aSINQO1drClPl+TVKc0YHEHNyOJFls4iLvJ4bpeYBVXxkZHq5
         qKqbyfjwwnvwS8hsBZmIqJ91FvSADzQUzgg0RH6lJjwSvmYA2+qal4axpJNMggIdraVY
         tELrP8i0dtJOpvnHttpSQN7REB+jxaYc3jLodO5P63ydEKk8XaeUPuJ7D6Baf3s6CByo
         q5qkkiTtVvumccENVnvSazuaRqJUN1Dc30knBcrMt/IUfho3BQyJ8HIxqxXBkdsF8O1d
         8cbsqTHkJiMJgNNT3+hPEJ3SPMQfEFQ4/dsZY5PKXMBpIkIgbJ3Lqps+j9eiCfMu8VNB
         4f2w==
X-Forwarded-Encrypted: i=1; AJvYcCWJ2Y95gsfTo1Xqwwk22XAJqNSkPnxcbRUqyVnkZlVLj7R3mLxGyVD6ddhM2TMtCtXWDkC63xCqJ/c92fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQywlxUmux0ZjC3GgSocXSSHEfFu0M/MOp/sM1dNg3P8wfRQtD
	HG0O3t0AA+4TrDYaHepduD1QNxnRop3QlcG0sbDiBFtcNqewgi0wBh84Z0xeLxE=
X-Gm-Gg: ASbGncsefNw7l/raUSZyTVtKL0001yuq/2YXBeZbLlQL+znelcBkmfq2KSINmJCwXpC
	I29hQqwDtNrUwHp2VoWDhJ8L6/B7gKtPBH9ZNuWWUOdSXUwV5VgAoQg8t0AV1OILGpexn8U1GR1
	ifEiJgv4weAdfPqywaZiYdP7LaF0RPXjXhAS2q7sNAOP27wvkZmuVzEOr4qQ5RF29UKwaj5db/1
	m75fX8oWrlftPNVJF0GwWme6vV5Spm1REiAnC8c6G8xUKHswHWIs0mnMNTKwZkAix2xiAd14OAa
	49/72ECqjxs9yB31tMLQRR32VzE/nnmjjQn/dc01gSzEFUZ0szqc/2KKWJ86IyrSEpfegb7I7fG
	t2PZHZSHQ5w==
X-Google-Smtp-Source: AGHT+IEaYcMyM2J73jN2KiJCnMVfuWrigIIuNN4q+hixY4NKk9003rs6CwEym3avXQ9u768D6WfaBg==
X-Received: by 2002:a05:600c:1549:b0:43d:2313:7b54 with SMTP id 5b1f17b1804b1-43d84f5dfa7mr2331165e9.3.1743008999500;
        Wed, 26 Mar 2025 10:09:59 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82dede2csm8298775e9.5.2025.03.26.10.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 10:09:59 -0700 (PDT)
Message-ID: <0de575dc-5afb-40fb-be30-99906d0e493b@linaro.org>
Date: Wed, 26 Mar 2025 17:09:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: dt-bindings: Add OmniVision OV02C10
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, robh@kernel.org,
 hdegoede@redhat.com, mchehab@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, sakari.ailus@linux.intel.com, hverkuil@xs4all.nl
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, bod@kernel.org
References: <20250324171508.GA668235-robh@kernel.org>
 <20250326150114.71401-1-bryan.odonoghue@linaro.org>
 <W8_0Ch2J0PWJ5pKHojZjFbM8huvxWlaWajtl_uhQF3UszGH_O8WTRZdQxh_eHs2JzLOx7CCxx01UZDHPQqAyCA==@protonmail.internalid>
 <1dd46a9e-e97d-415a-9e33-67ee234c4bac@kernel.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <1dd46a9e-e97d-415a-9e33-67ee234c4bac@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/03/2025 15:40, Krzysztof Kozlowski wrote:
> On 26/03/2025 16:01, Bryan O'Donoghue wrote:
>> Add bindings for OVO2C10 a two megapixel 1080p RGB sensor.
>>
> You already sent this and got some review. What's more, it's exactly the
> same as OV02E10, so just put it to that file.
> 
> Best regards,
> Krzysztof

They aren't exactly the same.

The i2c address of the sensors is different 0x10 for one and 0x36 the other.

Also different data-rates for each chip.

Seems simpler to me to have two separate files ?

---
bod

