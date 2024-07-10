Return-Path: <linux-kernel+bounces-247225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6300C92CCC4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190E91F21422
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546DF85626;
	Wed, 10 Jul 2024 08:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cfw7Gvys"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1B542076
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720599651; cv=none; b=XlhH7VsxdCy/Gn5M5UEJ5TrwihMP3hc4bxodImsOk9Zf7m0W6n0xGEkUydLz/BqAT+712BwsEx1XcVVqVhOT0UkoWnL25wrE13ZdZkGglzPoP2i0DtKJpMyJ/xf/CZzJpNLbL6oYqqEY7Uu6HTAu9ylpSGfZqaCfhKyWB9TKubs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720599651; c=relaxed/simple;
	bh=Je+DDEL0VG5/HOJTUCWPS+iS7ACCfjrKKm0Py8oNDUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vayi+rH1D43JoizDf4gRbIxR2eKlh67EJfhXDYqShTyo1dtmh3r9cWlzrHAjTx70rrH78PiNe1UWf6rPGNfZ39DWLvNgZnSG0enC7TSoe5PoujRHMHb9aVDLZvbrdpmPvVeA45DKor+d+LxyXfao7vZSWkgtDGqfBiy9A0f5Cnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cfw7Gvys; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4266fd395eeso13274975e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 01:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720599648; x=1721204448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E/fps9xeeLcadyxt/ePU2yFN+BHi7qw/s7VlkwnIe8E=;
        b=Cfw7GvysuHVPKtCCzATWNqNUHSerAMeJ6+mlJqe6Jz9z/mCDXnfyaPKrjVm7e3w9hh
         eZ0uTWabfrLeLbBMmi4i27CGWYdmkIM2FlsSf/SeyqGCfBn0eyiafpM7xsFVRcyerVEh
         EB7T4SzmJUoDLHYXsQJH9d4ezLRx5B3wnY0siGIwkitVSpq92y9qX7LBphdwObEWPotn
         6280S6n2Wh9PY1JnEX+a1woQxTKrFflZ690xbXX0I7GtEPeeGY/A7fFt1oDpknviDiHH
         j+BsuG1dFdcSq0926Gqr5Btc3Eg5WrKOIldNsx15mH3uzKbD2/gQxUBMCcAar6ZxUV2v
         c1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720599648; x=1721204448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/fps9xeeLcadyxt/ePU2yFN+BHi7qw/s7VlkwnIe8E=;
        b=k57IiS2s5czG8Gi7dKv0ANK0uoJbUHUrs59X1C9iTpOWMDoGR+h/7pwUO8WTgfHgxV
         sc7YgRyw2QvQ5C++RT5UYwSP0Hg83jKO1BBlZAJANbK14Nw9EciMMWre4Ya50RcFg3ZJ
         fv9ARE0CWTkS+Ijd49Ey1JgNMqfunYwgJmw72qve2f4uSLedwQ+1txGYUVOBQ6GTxgZK
         8PHdk+5P8s7tcVDFsjQpMOdDI3UE0GUW3O9EPjAmGw8hLJn53S4pWe6eb+49BDtgRFU6
         fd4p9D8/jeoNlsl7rKdc5bozNxuXcxWHa14AwhNwjs7TiXbBwmWtMK8zSUKkH5juNAI3
         JrEA==
X-Gm-Message-State: AOJu0YzQaNJOo6hB7N5e32YM/uAPSglKVjyEnWQ4FQ2XNOfV01UDrweO
	CVeItA5qJ8BEqLFyJeQ/fb4s3NMF003i1BEFYQA6/GUhpvLVrac8WeOktBFg4Ks=
X-Google-Smtp-Source: AGHT+IGNEmgQqVrXMH6GciGHOfhLlylIQOsKl1v5RdniUOzNY9s/KvFekBc78QGlsR1LyqnjL5Ma0g==
X-Received: by 2002:a05:600c:2e52:b0:426:6a84:208f with SMTP id 5b1f17b1804b1-426705cf5f9mr31980795e9.7.1720599648356;
        Wed, 10 Jul 2024 01:20:48 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:6932:abde:fac8:217d? ([2a05:6e02:1041:c10:6932:abde:fac8:217d])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4266d0185d9sm95900845e9.3.2024.07.10.01.20.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 01:20:47 -0700 (PDT)
Message-ID: <db16f1e1-f874-4630-b8c2-3778441fe569@linaro.org>
Date: Wed, 10 Jul 2024 10:20:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/10] dt-bindings: timer: Add schema for
 realtek,otto-timer
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, tglx@linutronix.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 tsbogend@alpha.franken.de, paulburton@kernel.org, peterz@infradead.org,
 mail@birger-koblitz.de, bert@biot.com, john@phrozen.org, sander@svanheule.net
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org, kabel@kernel.org, ericwouds@gmail.com
References: <20240710043524.1535151-1-chris.packham@alliedtelesis.co.nz>
 <20240710043524.1535151-6-chris.packham@alliedtelesis.co.nz>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240710043524.1535151-6-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/07/2024 06:35, Chris Packham wrote:
> Add the devicetree schema for the realtek,otto-timer present on a number
> of Realtek SoCs.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


