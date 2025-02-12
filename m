Return-Path: <linux-kernel+bounces-511886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0545DA33106
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6753AA976
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86CD202C2B;
	Wed, 12 Feb 2025 20:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D2YauDTr"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C05A1FFC51
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 20:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739393403; cv=none; b=NTJpzlz2hWUzZkF3mq5f7aRy86sCvP6mxD4TD/f2gXVVmxgKqLj0MAcWA99/dbKYIcd6IxNz3Guv25OIEm0dACAtjjrpBc88VQVsT28TJNPG5SOuCJdIQCtpwjGofdfTRWGCHpiuqPQdlNL87XOw7BV5PEKWKxD8zW+x7YlCmUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739393403; c=relaxed/simple;
	bh=TQy6MBVOb9u55vCzrWhe1w7LxXmV0gslemT6zUDv00Y=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SCSdJqsVc6ml/BI9k61ktRfG/wUutF4/tKGNPZ5C4SJewdwtjXjFuHmdCTJ10CwMha30Kyh2GFh5FjetaZteAMTUJZ05OvnXq1UcyrwcjTffkVDQbseOeWs92mAP0aChj3nMDbOFft+uBPmlIgIICy8jhTWJqParLtTFM13nKG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D2YauDTr; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38dfeb84a39so18363f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739393400; x=1739998200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u9Q6IpOb73y1eWE4uJt9PH7CT4fpxSco1fxVBO1qUus=;
        b=D2YauDTrfP3y8k4Mjn/luRPc61OiUjfHTRB3eVLV8tEoyqZo8/DA2dyF9xqdHK7tf7
         j3ioGMymACXh4oSWV7XMBFGZTLW11dqqaKt9TqDJ3A0/vAP3vg7FqjhjfnKrmErLfYff
         mwCugwGYiZfvU5JjMvUKKf0763AqqHH72wxGQGK9ayfJ3tax54KoO0hMIh+NMhpJLt7l
         ElsBY/KlwEfRcOhP5nnkTefTBALQmeto171RTm0bUkx+xakY2Yuo4G/YqiyfveeaXGFq
         uy1VmY+/pMUjg81Kx3GsuKH7Oe4g+5JmZ29sG4xsw5KzYXnEoaUTMmj8FVSmrImcjtgq
         5BgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739393400; x=1739998200;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9Q6IpOb73y1eWE4uJt9PH7CT4fpxSco1fxVBO1qUus=;
        b=gJUB2dDBXrJDBL3vANh+7m6+qSrSnU5pxyvfz2NW8eouBIWVJ2BgD6lxKId+Cp+3lv
         09pLeOJZwduG2mHc4sYLm+fm3q4xpBMKFOTroCfBxfj5fNecbrsuprlHhQvKmkm7p/xd
         SD9ZerFITPa3O2oApXDbDgcSsM/YcXLp4SztrO6p05rt2qPfgAly3EqYkUioauP9iA/W
         JqmL0RxZZWM42wjx9WYv9j3c/jAMuC1A5yq7jpQyEpcoZZTSvjEGRIKzttNHp252JzaP
         dw0llKgWccDqDcigiJo+Vl+j5wHvX1Y5oL/OGuNc+TFk/LhoH70KcVEY+5mSjMvwQ2ie
         qgHg==
X-Forwarded-Encrypted: i=1; AJvYcCVslXmnrL85KnLKETOlgn6DFe0T1+2i1rK+VG48s9j+DeznDnWiMNOZK1MWOUjMHGTnPp1LmiiGhPtS8lQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIguQmnXiKft38pQNXr7SbX87uMZp+oQfiJR8oK8nmpw07T3uD
	3l32saz+ICMBDamA0mbS/Cjp+isQzA85lGc5nc5itzrX4TNWeRiHj0SIBaB8GK4=
X-Gm-Gg: ASbGncvr3mkml7EzKrYFuSTmKB2UJ1iSDJ5jdAgbfDpJ+Ma4g9tLteL0SByBqjcdFR1
	bNtt/JtZXAoZXericsKwtNqSvhExV6GMtTGK0YWfRrwlYxQbQXa3S+ZrbeHvbmZvQC/KsHk4Ido
	uUzIQHd/e8R41qP6OIUjqDbC8MV9RfGiap+zz3h8hZEc3U0yfx4A5JDNHWhwnr8wwKR/WNXtvwB
	/HkFOWMGhDOIf28FXPT27YYpY50fwxLFWDGMPyHWgMlLmULfg//ZsmoL/sGpKjxkBRCUH+Mq5ey
	6uXcFcbrAn4FeI3U4e2vIly+kGqXgPk=
X-Google-Smtp-Source: AGHT+IGQgROpzQmu5Pec0W38CXloplfJn0/crXLM41iuPQgsFev9fKPKnskaDjdS5VJ3FEEolSApBg==
X-Received: by 2002:a5d:64a6:0:b0:385:de67:229e with SMTP id ffacd0b85a97d-38dea2e0d93mr1631306f8f.11.1739393399872;
        Wed, 12 Feb 2025 12:49:59 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a056151sm30461495e9.16.2025.02.12.12.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 12:49:59 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250115211747.194191-1-krzysztof.kozlowski@linaro.org>
References: <20250115211747.194191-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ARM: dts: cirrus: ep7211: Align GPIO hog name with
 bindings
Message-Id: <173939339863.59416.7752699077412217408.b4-ty@linaro.org>
Date: Wed, 12 Feb 2025 21:49:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 15 Jan 2025 22:17:47 +0100, Krzysztof Kozlowski wrote:
> Bindings expect GPIO hog names to end with 'hog' suffix, so correct it
> to fix dtbs_check warning:
> 
>   ep7211-edb7211.dtb: lcden: $nodename:0: 'lcden' does not match '^.+-hog(-[0-9]+)?$'
> 
> 

Applied, thanks!

[1/1] ARM: dts: cirrus: ep7211: Align GPIO hog name with bindings
      https://git.kernel.org/krzk/linux-dt/c/3f6e319a236de93774080b163aebcaa99482358f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


