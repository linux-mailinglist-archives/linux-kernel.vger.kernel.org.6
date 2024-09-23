Return-Path: <linux-kernel+bounces-335447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C10DB97E5D6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80786281160
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 06:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F541803D;
	Mon, 23 Sep 2024 06:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hX9IKgGt"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC5517996
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 06:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727071469; cv=none; b=aoVwa3eDugzYEwqJEPwP+NcC3Cmrn4K0xTYQ+RXbWh9yHpjDoGowsFFiMKRN4D6ea89Fz4TNBF01jpOZsDsH4YEM+aIALpD0gGmhEmIBev/UuDTVF7BKN7fEdpk4b+C0j4WmXfb6LzOdpLZs2pmOgfcXjAf7IoAxtHQPba+3ZYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727071469; c=relaxed/simple;
	bh=qI9/SPhx3uEKmNkq9N9RFTaqrDhjhy+lHvk3IFtoLnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FfQhWnhoVHf3qunaR3WCilZNAjdnYoMFx+mKQ4oJjzfNyX+N942rvmN245hKMUhEzhwvjPtZBH9XwR++ZZtGl7IlQqRLGyOoTdYoxbxVIrl7zJrntAmoKX4nzINgdj+O89wNJtR8JAiUnmJzN9HasEYjXdXqQqgDcnK++D0Qbyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hX9IKgGt; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-374b25263a3so2269599f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 23:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727071466; x=1727676266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0RNmrHmblvHO2guL4VXF8jdLa/bnTwxzeoY4QaRaHx8=;
        b=hX9IKgGtuI/1pJzcfpxue6YuEOEiSOy4NLe61xaHUGmTYGMQhW6vZvsQcm1TVhFBd5
         w1cWjXDDKRfSDoJ5g4rPQ+oPptccvConBAmEFYpl5iFR5ZdG61KTOtBRUDD+R1vPuW3l
         VgTTseOF6jqQBB3uFQRH/yLYc+pjHphCHTuxDWFL1dCiJxcICpmlBEz0Wzi5ivR42+eR
         zMB6+2Biv8cxBRoJgxQCz4k+uSxsfklTEnKRMQhv/KFIckvDF+pNlhhg0pJaNq6WbjAT
         QJsvLhFoBNQKQcCfFJO8M3auSK/mtQHgc+pFyZwbwVpPf7zrsCfDkno4mGtPr4Qd6Ojh
         m8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727071466; x=1727676266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0RNmrHmblvHO2guL4VXF8jdLa/bnTwxzeoY4QaRaHx8=;
        b=bgEtqsVoKN19rwoL9zP5V13XzuHCXHLbGksJfjTAq8LIupP6t1iO/IteV7ZfC/QGSI
         10u/L1HsBQOjGujLQg2MXyUdhYQj14UiEs9ASChgSQMgbDdZBovwLiEwykVsxMVnnjfA
         WLiariqftcRAh4HP0kzgFZG52YgxXHAf1sBeoRbxLT/PsOtvfbZ2YF/kZJuA6VokfFsb
         HgVxpHaRitUcXDsAPF0O9qI2nQ/fQ3eFmZ6H7e7s6fbpdp8cpyr03OI9c3UNK52KKR6J
         lelcwt/bQDfXz1sRouyL4KAMHN/5ue/D/+fG3qMt7estKktpnQd3KmrEKX/8oQFdL3Qi
         Zsug==
X-Gm-Message-State: AOJu0YzttD04yHfyKrQI2ApT2HoW9XBHL7BvwyyYgMrX7ao0n/hD17Sl
	U1c/Xonmp+5jVHM7JUK9xMp4MEs9lbyzLiYVhoYMPbzNPFuJapMsSqGF8fUJzl4=
X-Google-Smtp-Source: AGHT+IH1eCn5MZAMQDZuDWL0pLjlXPrn6Z677C5pwlLNhKPM9d7744cqjDFZzGFS65Nkq1OxkrDYuQ==
X-Received: by 2002:a5d:58d9:0:b0:374:bd48:fae9 with SMTP id ffacd0b85a97d-37a422658aamr4808393f8f.20.1727071465802;
        Sun, 22 Sep 2024 23:04:25 -0700 (PDT)
Received: from [10.11.12.107] ([79.115.63.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e71f060bsm23742088f8f.1.2024.09.22.23.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 23:04:25 -0700 (PDT)
Message-ID: <4e0cf43c-4843-451c-ac6f-86775dbccb2b@linaro.org>
Date: Mon, 23 Sep 2024 07:04:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] mtd: spi-nor: core: add manufacturer flags
To: Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>
Cc: linux-kernel@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Esben Haabendal <esben@geanix.com>,
 Erez Geva <ErezGeva2@gmail.com>
References: <20240920181231.20542-1-erezgeva@nwtime.org>
 <20240920181231.20542-2-erezgeva@nwtime.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240920181231.20542-2-erezgeva@nwtime.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/20/24 7:12 PM, Erez Geva wrote:
> From: Erez Geva <ErezGeva2@gmail.com>
> 
> Add flag for always trying reading SFDP:
> Some vendors reuse all JEDEC IDs on manufacture table
>  with new chips that support SFDP.
> 
> Add flag for reading OTP parameters from device tree.
> Some vendors reuse JEDEC IDs
>  with several chips with different OTP parameters.
> Alternatively we read parameters from SFDP.
> But the OTP parameters are absent from the SFDP.

Do you have some specific flashes that you try to identify? Why can't
they be differentiated at runtime?

> So there is not other way but to add the OTP parameters in the device tree.
> 

If there isn't any way to distinguish the flashes at runtime (which I
doubt/challenge btw), then as a last resort we introduce a dedicated
compatible for the flash in cause and specify all needed parameters in a
dedicated flash entry. This shall be more generic as further flash
parameters can be statically specified in the dedicated flash entry,
less invasive for dt, and less confusing for people when they decide
whether to use OTP or not. OTP params in device tree is a no-go.

But again, you have to prove why you can't distinguish the flash at
runtime before introducing a new flash compatible. So don't go this path
before sharing with us what you're trying to achieve.

Cheers,
ta

