Return-Path: <linux-kernel+bounces-548717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 497B1A54890
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02E431895A07
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EE3204C19;
	Thu,  6 Mar 2025 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FfL9Aqwb"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDEB1946C3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258746; cv=none; b=Axoq+wnNt/eVyuX0X4DZfsF3tQ9j+gBJbBQjuVUrxM29DbHOhfAsEYM3hAM765bbQjvj7XpNQW17erl9mx1sJRkUhLlFZfOll5niO57GC9Pz+s3yJ6Fmyc9k/nN6VE06s96t5v+J8ERwSlGV1PeaVZCYh4LLx5WZk7iu7DpAREM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258746; c=relaxed/simple;
	bh=5C4QvBoLeZikw6Ba3FtTxQ35mEOL0q6BZ1Y7nYSxoZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NoMH41v3haGxZ0Hopq2bOIuu46ZOgWOMzEPkt+wfzMM6iutlg2+uQN+n7kH8ZGABQ+mgnJ6Gr6BLGSlu4LT1YRBnqRy/SOXP3xicYx5bmErlBTf2oe6ngS7DSNm2Emx6+ov41lsaC76bsnfTUcCKOvDZURGe4WGqJAzYuNo2rv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FfL9Aqwb; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abf5358984bso81926366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 02:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741258743; x=1741863543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5C4QvBoLeZikw6Ba3FtTxQ35mEOL0q6BZ1Y7nYSxoZs=;
        b=FfL9AqwbIbXa7ZjnghOzJDD+5atp/XztzOAt7Lm0FFnR+TjHdYwuqqL+Effsb5te23
         jyUg8Xouf0AJR3rPaUAv4Tu7dyIXrfUIHOJ3skogWJBW9Tc8D997nTivaUKgjVB5zHYm
         cnnHSfItgLQdLLMtvHt99SMnfJp2auJtiNhEdCcX3ZL1cMU07S226p0guyL9INtYMhYf
         CHPLKnRdC/FkkYkiOicDf6JzndXkZ9giaFbmTII38DAEMQquUm2rTfFyNjY3A92vskYg
         Pb7Dg05aRVBpVize5Hv/y1AArgYInBhnXluhkOfVYyrpEGC32V1mpbfOk1LlF/J8Ly5y
         pvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741258743; x=1741863543;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5C4QvBoLeZikw6Ba3FtTxQ35mEOL0q6BZ1Y7nYSxoZs=;
        b=P2S2I3tRn0YVeTWRI661clFXssXNBBsi5Gg5A6lIl6LfWIhmk88F4wUgn9SEMPTKF0
         yeqYqFk1hHS7rjRs0fpYEVmoIYE12U3L3xer/psSyQ3+ruugjEMbn4vqgBL4zgTI6G3Q
         aKSgzGNewr/rPncDSVzDeyKGgLBRAVXZDtSYMCvEUmxeUg92S3gtS2dF1wG3GMG1aV1a
         WHJ3aJKhCToXr4/zYBS78I+84T5ccbVEcXTw4QTwMtqj81jgIOFb06TqSiGZc+eQNRYU
         9U/TnPc9rbQZ3CtzJgEdepMrowpbp7lHeWFveJ5YffEqnh3Wmgh0wIkHqBlZFj/E70R/
         m3lw==
X-Forwarded-Encrypted: i=1; AJvYcCVvpTIaxC2bGFexxfLSPLarK70uX2Wvjr8KKOdu6VEHT8AmqDixAa917i8DJgrjcowvc0XHB+Xg6C5Ir08=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHCeGd7aUFKfqdl03Hp0HB5GZoUy/PVLQQnfVmsObfk2bGiiHU
	LbDIVgvTsYhmuU+eILwHzx3NMZuc7kBRc1LDNjsOJJMKMytXUhxIFGiTCoSJupQ=
X-Gm-Gg: ASbGncvOw8bbU5Y9yUeP3rzwclatF8NHzo7RUN5jtFOoZtvnHssrvMS/tlAcjPKcAR4
	PKTFFRRzmYKqqR4d9dDf5RkQ8lA2NqIMlkjn8vo68OPyLnLPy9R6ibhdk97LCYyAoBuVMln4i/e
	kFohnGit8CKOAbzqh/PmsZD4A3aOWXY17w5HVm+9ELCRVvzmjesBues45f8MW3B0VNb/IwHDxJL
	PtpGa+i+BNVBPP9u9APuVl1L9l0o6YSLYK06I68JASaOYA9JoeAMumxr+GV5fX7zfULKFx/RyTG
	WlJAivsRcOjFEAdRTWsS8ZZxu20zoakM6c0xFsx4GPK1WCjWrm7pow==
X-Google-Smtp-Source: AGHT+IG3/CY7InOwwMBI/hfcDuQEgBl4AqRr2kCLu+MvY8UuxbbqY8rrrCYNac5oXeHpEKekKLqWoA==
X-Received: by 2002:a17:907:97d1:b0:ac0:527c:9cd5 with SMTP id a640c23a62f3a-ac20da97be0mr585758766b.42.1741258743166;
        Thu, 06 Mar 2025 02:59:03 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239483628sm77212966b.53.2025.03.06.02.59.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 02:59:01 -0800 (PST)
Message-ID: <e19e9d0d-ed70-45a5-917d-0142c4107fe8@linaro.org>
Date: Thu, 6 Mar 2025 10:59:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: spi-nor: add support for MRAM Everspin EM008LX
To: Claus Fabig <claus.fabig@emerson.com>, mwalle@kernel.org,
 pratyush@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240809132246.3395-1-claus.fabig@emerson.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240809132246.3395-1-claus.fabig@emerson.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Please consider moving this flash to the at25 EEPROM driver:
https://lore.kernel.org/linux-mtd/20240604074231.1874972-1-mwalle@kernel.org/

Cheers,
ta

