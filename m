Return-Path: <linux-kernel+bounces-255610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 285309342E3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C601A1F21052
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88611836F3;
	Wed, 17 Jul 2024 20:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZsLq11Z"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834A51CF90;
	Wed, 17 Jul 2024 20:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246555; cv=none; b=WURubKe/1xygIO4C4fv0unbOeZ4I5b3rg+23OxFKAsVdb7zAsPZ+RC1pYAEqxXR3QfZ8CpKxuraL4DFnaqs5Pxv4QJ62tdsOKzjTfMxM4s2yjHoKyS1Vok+Gvi5E66adJMUGchmIQOUf5sesOlNZD/iOU7qTvT7jwOJ+6GIimqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246555; c=relaxed/simple;
	bh=IKZ60C2VE228hnXPBngEx2ONPoazuy9XS+om018+pRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h0x4SyMzkGXZ734x32Refdb44mWB7JChDLh8Ppybx0GyAdmrgUSR8331jN3VMADNyki3+colGGNKcvtC9etpAERtAVHnJ9u66xR/NwYLODV7WKaUXzXR0HnSokESTF5B6nX8nYXc0QsRiGPY+4B99J+DOJEqZ33JOfmzDF9tyRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZsLq11Z; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a77c9c5d68bso2463466b.2;
        Wed, 17 Jul 2024 13:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721246552; x=1721851352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l3VwJWSOS22OLw1Rd95XcEdcYfDTK1SmF5DPuo6J8kI=;
        b=HZsLq11ZQmlJfNGhh5ywnzyPPHKbxq+mtKao9DB+A1NQF4pV3iuxD2SBFitUcP7D/P
         6zFRAvtnAbf80fL6L+Eax+1XF5Xwt8tOpvP5J+nWAuubfleC3kGDnIdFN//izGhG/FLC
         9shSndzkibNM/a1xpw0+KVm4lgdxmmfppXZML8fYhuz9Yi8qWbBat6KLyci++3+v1pp1
         ppSSIyTsI86XHivSqlJWzNAIgfDfLJJrXQfBCOqjQDsSiWIt9ar1g9JAvXiINAh/vR4e
         UEDOBERIap22C7BGV8D4dzPr2wiTm5Fy87xckhkZLsnauv+ZBy4FQeKULpSOzwBTbmWx
         HRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721246552; x=1721851352;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l3VwJWSOS22OLw1Rd95XcEdcYfDTK1SmF5DPuo6J8kI=;
        b=OnQ3xuNSASifsA0LYFkY/oaDlqKiSX8PLClQxAAgmvCPT1w9betjdM3R7MZwZz57u8
         CyA9MI3ORmXBJIZINFEuwFiQqBHesDSjUIJBkt4yYly5kB6s9UX5BSRYq2/E4IMCcPeW
         +oV/JhjiMmHs7Re6b+vY4xL1sEk92L6iCYAYkTQ7mcU0tbq7zAWOSN2JCFtN6CTVHm/p
         XeRuNQ3/QM6cyHIU7h2JZzkzjwW5F1terGGZOx+AWtcCfKiD6L6/95rLP5ejkTT0SpBg
         Glo0JFam5ppIOY7Bttrq/2AY+FLeHsjuyyCgeqi5TX1IFfT5YuaNkhj/WQeZQEp+HIuW
         Eiow==
X-Forwarded-Encrypted: i=1; AJvYcCWMDFthQXP4LfQVZoMTfxqj5ED2PEHw6cT0KH4kxFQsON4dcdW37ET5aNghNA+MTjJA557LlxLAyR1zM4W/xDw8IOUDbq0r4kM7FWas/90TrQgL57PI/34LQVYPLc2s3wdgffZsi27fhA==
X-Gm-Message-State: AOJu0YzWHsaCDTxWxhKYj6SmgWnoV55E/RktDE3diUkOs2gwRSHR3nf2
	I39qJ+qlGtnl2Lc4ggNSSWz1QLnEJDfH4zgugu8PAM2jShEp4gr5
X-Google-Smtp-Source: AGHT+IGUxr7sog/F/OdrZRM8MY0OeurMFSB1lRz0s4H55+eJy+SVONsy8cQSsORza+1w87I8ieOqmQ==
X-Received: by 2002:a17:906:5f8b:b0:a77:f2c5:84a9 with SMTP id a640c23a62f3a-a7a0114a5d1mr167150566b.18.1721246551584;
        Wed, 17 Jul 2024 13:02:31 -0700 (PDT)
Received: from [192.168.50.244] (83.25.184.148.ipv4.supernova.orange.pl. [83.25.184.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7ff6aesm474959466b.153.2024.07.17.13.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 13:02:31 -0700 (PDT)
Message-ID: <1296ff07-61bd-438e-bae8-568485866119@gmail.com>
Date: Wed, 17 Jul 2024 22:02:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] ARM: dts: bcm-mobile: Split out nodes used by both
 BCM21664 and BCM23550
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Stanislav Jakubek <stano.jakubek@gmail.com>,
 ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240717-bcm21664-common-v2-0-e9bd6cf435e4@gmail.com>
Content-Language: en-US
From: Artur Weber <aweber.kernel@gmail.com>
In-Reply-To: <20240717-bcm21664-common-v2-0-e9bd6cf435e4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.07.2024 17:27, Artur Weber wrote:
> To make development for both platforms easier, split out the common
> nodes into a separate DTSI, bcm21664-common.dtsi. 

My bad, forgot to update the cover letter; the common DTSI is called
bcm2166x-common.dtsi now.

Best regards
Artur

