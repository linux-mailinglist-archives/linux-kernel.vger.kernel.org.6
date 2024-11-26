Return-Path: <linux-kernel+bounces-422713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84FA9D9D55
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 19:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 825E31642A0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344A11DDC03;
	Tue, 26 Nov 2024 18:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlUhaB8o"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5458E1DD884;
	Tue, 26 Nov 2024 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732645558; cv=none; b=FTrBKtcGYq7/8c6GGyoIbkr/sVdlorklvWSlapaZ7/Sh9PaJWbRFUzdFSoaVuSyy5efoZ0p+VfkDhqQ8tcKiPUBMdegCCZ3b2yPUyvOydHMDGX9Aw8r9d9i/nAanMILrX3vbPWFwJiDvz9v4EEwK4lvDdoy34UwU5lCjP+U5uEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732645558; c=relaxed/simple;
	bh=aoBiFqPehAaj5iMKLKw4nSGmmuIy/JR8WRaPdR+Q9nA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LaathjJMKsa9WoZWt8E0xUkty0JdHsqZ3BO2747oQ41x0uNig3L3cdO8yWY+JqFswL8nTK9LlVEz4qBDJx+Vj1A0lSBq7DGlDOlF6778wNC7rJ24N2nxATHs7MDvBQ0aeDOsOQCFBPeeoyYvBWc4jNEViOPA9+hX/RsPKMuRXN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlUhaB8o; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-724fee568aaso3048647b3a.1;
        Tue, 26 Nov 2024 10:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732645555; x=1733250355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pGO4VEjmMCTpy6yKK70GikOB6XhW54AbxXkx7kdm35k=;
        b=nlUhaB8ohq7292S1nmqPLp/O0+1uK9GVwOl5Jvh2u6+RJ1sR3AFo2R2VLltC+6HBLa
         qIgTao0ENP4ninGW+zCygxoTThu0rhj3AzoWFzYh3X5pPBzm7WE/rlFvsvedarA6G+/y
         8UxKnjO4pSD40sL5Oxe4SI9QpnjyfXu/YUkdm3Kpfw+W55/19n6u3o73uQwdhjw7aElm
         C5+zWNZ7cC4pnxUy1Pzpyyya80PL6BO0Ywgkz3OAtdDcNAZ+mxCciNXiUPzRt9N5e6w7
         QJ0daZU0GK3/Q07Zyig1AjF2gw2LTgXmgyYHPBQAW413b24XRiA1ECMeNYrSO11zsMQ7
         m48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732645555; x=1733250355;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pGO4VEjmMCTpy6yKK70GikOB6XhW54AbxXkx7kdm35k=;
        b=BB2SPkBMIWWQPze6o7+jd34SUO8jEU8VgkS5DTm6oIAKwg6wKGmelnOQKYbjE/Z8ax
         SQ8n5EQvaj38IzrGM9fVwQonve3+dRcmRUTwUSxa01GuRrOKypduYcG1rYQX2zY5Ny28
         GO4LJDGQNZB6dbcFaG7mZQXPxBJa+AFDzGQ1XCKJCJyTMz4RZGV4RJKl+rgal87mzOZM
         F7N+BTmjULpXWiSG0NhyNiurMXOKoQ4+9syyIg+C6ogTr6bf6lRsq3GjeExVpfeZhm8r
         tGmo+lf2w/OufoPZgjES8wMeCUYG51a4Ck+KWa1f5uDS0T8HDES+2fQkKf1mMdwQ8Et1
         twRw==
X-Forwarded-Encrypted: i=1; AJvYcCUY70pjhieHi3mUCn82fzG7xaoSaGD9oAFrMs1dFt+PdleMnLNz8q3M4/1r65oCwD8cdTDdHS0Xn1tliVBr@vger.kernel.org, AJvYcCXU+/DQzw36Qf5Lvrbjcu5SB8BB5OQea02szvnQseXf77iHt4zUciTMesoMKofxkJCs9pAMotprn3qE@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3kmHyxFdMq+uLdd9W+ob/LcB2cWQifG5Wqg3n0gkbh1FbKzT+
	fx+nBbEgATSJclWuMuEFCZ3rYzN8EhlrTuHuLM92RSHoHCAtivHe
X-Gm-Gg: ASbGnctnjbmshRVmJOm/ChXhLCvf2i0evAu8ddLtT2TAIMybclMrx/gAAeFbsmKrIHP
	PKbZ+yMcP9DfohEwzWqYDxOKL0H8AYHJ+Jkxwr2zAHFzPdzuH7LabmPK+K4YxpWumbXD3cEmnI2
	cNWaudKgYqBdKt4R/jZC6BoY7bqrKfT016gjVCdj9/j/AQiIXou/2CgK11IPxDTKw2NeSzjy7jX
	6S+122my2K0GgK6dGpcFN3qLYqff9OsblrlZJmnMKXSuPj5YR0DhfuuVQ==
X-Google-Smtp-Source: AGHT+IGIW8YWKhxplj7PnOWubg8KaT/VQiw22cMgLmX8nunNS6CMBCZlxtxFLFqpa21jqQ2K9VRpzA==
X-Received: by 2002:a05:6a00:3d52:b0:71e:cb5:2219 with SMTP id d2e1a72fcca58-7253004b06bmr165886b3a.9.1732645555470;
        Tue, 26 Nov 2024 10:25:55 -0800 (PST)
Received: from [192.168.0.122] ([59.188.211.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de531b50sm8971221b3a.101.2024.11.26.10.25.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 10:25:55 -0800 (PST)
Message-ID: <e0f78e42-6454-4855-9004-05d90ba6895f@gmail.com>
Date: Wed, 27 Nov 2024 02:25:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dt-bindings: display: Add Apple pre-DCP display
 controller bindings
To: fnkl.kernel@gmail.com, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, asahi@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241126-adpdrm-v2-0-c90485336c09@gmail.com>
 <20241126-adpdrm-v2-1-c90485336c09@gmail.com>
Content-Language: en-MW
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20241126-adpdrm-v2-1-c90485336c09@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 27/11/2024 00:34, Sasha Finkelstein via B4 Relay wrote:

[...]
> diff --git a/Documentation/devicetree/bindings/display/apple,h7-display-pipe-mipi.yaml b/Documentation/devicetree/bindings/display/apple,h7-display-pipe-mipi.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..2cf2f50e9fc7329a5b424d5ddf8c34cad2ebb6be
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/apple,h7-display-pipe-mipi.yaml
[...]
> +
> +  reg:
> +    maxItems: 1
> +
> +  reg-names:
> +    const: mipi
> +
Drop. Not needed as there is only one reg now.

[...]

Nick Chan

