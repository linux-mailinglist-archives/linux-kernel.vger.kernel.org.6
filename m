Return-Path: <linux-kernel+bounces-280475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB77A94CB1C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D9FB2849A3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B331741D9;
	Fri,  9 Aug 2024 07:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Qq5mQAtp"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A71170A02
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 07:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188029; cv=none; b=bb0q+5R0n1HvsAZMxSPLyOKQsls5GFoPKmo1oyAU+/Yv6Ayo4I3JGMlmwoTR/bLeqqJhhQ8V1yxcmw8wFj8y4tRHEcnmuS/4AQARzWpgIpCX7wLGdfVsmxnDQf/rGXUkeAL0+fMMy/Y35Qs5MA9Cb4GuQLL1FMcuR7iTEgY+4bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188029; c=relaxed/simple;
	bh=LCQjMCGu/NtAGIDdzcexTOBsi+0vUqa7B0DD5sAYYr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IBYFPnxKA4v+iTjNVZTaG8xSRyfemH2fyQHQLIRPhlb/gsKR4mnKWw6kW5Z0y3OC1iWQX6WXUaX2YkPoR3L90LcH9CdZ6Pj2K668qfRDLMKcvPJpxQToSO8yGaDsbHEo1gtTfD3Q0i/UpZaeoCEPZh+McgRf/sz5WRXiRKNE+2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Qq5mQAtp; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3685b9c8998so785451f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 00:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1723188026; x=1723792826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d47CUelTnreJC+PfHZ3JAzMPsN6JTZHLt6cE64vISVI=;
        b=Qq5mQAtpdNfdlpCpGTDIgXHwpVnmlrHcRvxkgzwNFdab415YIUsJ/3bt8p40r8ouv9
         bfhwROBKcRqosR/s07FQxqsXDAG/24KJnLLJ2n8lGBvNyOQrjgYIdwVOiJ2KY7ZpdIht
         T+epW2u7VXPH1wyUIMaUrv1jGYkdlIczyBOljkitz7so5p5pw1kjqiERqLugvu6KGYz/
         Kyscj3dcLhUye38X8VYdiPw7PgFz0I9weMLHXNILjlz17nPBRP66Dj4i/K2ngjcYDP3h
         3fy0KAixMuYcjEIKzv+xGjP7W7gOZEzl+WhT+JNHOAA5SfyRLkbU4NcvYB+JPZERJKvd
         JzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723188026; x=1723792826;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d47CUelTnreJC+PfHZ3JAzMPsN6JTZHLt6cE64vISVI=;
        b=qOZ+jCTuA7Svz0LSm59gZ5QUDQLGlo+uY2yhWsAL6+zmb1/Y0EGA8UvNhWP81wiWzF
         PdM9CAkMw/Zr3NnLxdwL7Fj4RGNTlEwedw4/+z0S19ZKSasSPPFWzd1aJ3HlaPpjEXCP
         HbVDVfFG4XH7Z8J1eLVbZnTiweJlF22jIw7mBfxhRwC58z2AZepIPsmEG6lUd/2w/ICD
         jYS8ruR3+ERIXs8r1KjL7kcyc3Sb8YSTDq4GU6KaAbaQ8v6NvQ7J9yK6BVjZuky5N8Z3
         ExYOtHEgSj0X8yz3VivyLU8pMWUa2sOsk5EM1icCD5ftckEefFfZM5+BV0XjhDZvNBAA
         UaHw==
X-Forwarded-Encrypted: i=1; AJvYcCWNpkK3MM8pEjp2wrxIM9TYqKYbr6tGKA8VOl839+nZgh8VHpLx3dQRpsNIj5yMAGQOrgCyFH4Hm6gamRDKs64NfeMW7tZNFhpEQjvN
X-Gm-Message-State: AOJu0YzfpgMe/WI94IlYx9HAblT1QJUNwTPqqogW/xWs323KvsyUaXbR
	zdCvQ5MAjDMsaEK314lxC2DMazcDJ+sqlBvblyw1jNMZryV3xXEt2T3/yecZ6XY=
X-Google-Smtp-Source: AGHT+IFHpW92jqjIYi2miDOsQE5JPxAd01QY2fBqHylu2JwNHdLR7v5WkJ4KHtbzJ9eJlICDWlTF1Q==
X-Received: by 2002:adf:fc12:0:b0:36b:d3bc:af03 with SMTP id ffacd0b85a97d-36d5e3c30acmr376684f8f.15.1723188026393;
        Fri, 09 Aug 2024 00:20:26 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d2718bfb9sm4360112f8f.54.2024.08.09.00.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 00:20:25 -0700 (PDT)
Message-ID: <e39ab10e-8e95-4fce-b75f-10fe918e81a5@tuxon.dev>
Date: Fri, 9 Aug 2024 10:20:23 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/11] dt-bindings: i2c: renesas,riic: Document the
 R9A08G045 support
Content-Language: en-US
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 chris.brandt@renesas.com, andi.shyti@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, geert+renesas@glider.be,
 magnus.damm@gmail.com, p.zabel@pengutronix.de,
 linux-renesas-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Conor Dooley <conor.dooley@microchip.com>
References: <20240711115207.2843133-1-claudiu.beznea.uj@bp.renesas.com>
 <20240711115207.2843133-8-claudiu.beznea.uj@bp.renesas.com>
 <ZrTiZtD9U4I2LYZj@shikoro>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <ZrTiZtD9U4I2LYZj@shikoro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 08.08.2024 18:21, Wolfram Sang wrote:
> 
>> +          - const: renesas,riic-r9a08g045   # RZ/G3S
>> +          - const: renesas,riic-r9a09g057
> 
> Why no comment after the latter one?
> 

I kept it like this to avoid confusion b/w RZ/G3S and RZ/V2H(P) documented
below, as the RZ/G3S falls back to renesas,riic-r9a09g057 (RZ/V2H(P)).

I can add a comment here, too, if you still consider necessary. Please let
me know.

Thank you,
Claudiu Beznea

