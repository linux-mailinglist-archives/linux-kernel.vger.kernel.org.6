Return-Path: <linux-kernel+bounces-281329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 746DF94D596
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3881F2246D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816E680054;
	Fri,  9 Aug 2024 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wE66LET6"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345AA5A4D5
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723225333; cv=none; b=n+dXQ3VhPi2OoumCJbXCxOUmeTW8bKMzaeMuWDZIXEmyXqFon7CIpqx5UOSy4G3ByL5Psjt/79U7BARRYxI9UuOjsflWFmpRv76bNTyzrDPRanrEYfzG6dV0+mKwQf4NAca2TWCH81K15R38ganOkFynlFxmXoZqNV9IV2zQi/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723225333; c=relaxed/simple;
	bh=unOikXZ8Y81JsN0FVzHGpewC+1L1DF3RT3WmstAS/AA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W2P+3nKkyH5HR239qPmgj8WxwgWGmF9iO9og2L3IbrEwQ6IIG1pcp1sCfbHoHG58biPVEdImRHDUAOOukrmMWKL/zoo61vk0pR91z8JSoyFnu5AyAsyyDan9Yw5jxWG/5F1Tr7Yz/nsTgPMBAKBZlCetaX9xaiB9eo9Puk7IeJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wE66LET6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42817bee9e8so16915755e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 10:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723225330; x=1723830130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VamUtaKsdnMO3Xj/IeNiDDarpPSNzAwlcfOY5Y0XulA=;
        b=wE66LET6/50JNqszRjQfaMtJ0PlmAyIcogyMHm9CesLet211WZIgIBpxPflq9NH4rU
         4ms6Snn8FVKJ6hklIuZ/RspKm6oJHO14qWrLz197sArdLv8ANAUK24s9ZIHiJj+oJFl9
         IFb7CwI1ZY4KIa6mtmmpz4SuFaxiIT5INr59oHQv+e9t80K09GsTMabmjmX/1j4OeIee
         Sh6jLA/KG5gHkJ9Hfz1/ghizgPOyDUf1qKurd4oyKCX8WCEinyJbzZDEdDiTGnKMQzkP
         qSQQvdHhdcihEmo1wnwZNOIT2uUUXAcJW1gHWFRy+OINXL+KDdjzhPSGZoB6SBeo8CP5
         GP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723225330; x=1723830130;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VamUtaKsdnMO3Xj/IeNiDDarpPSNzAwlcfOY5Y0XulA=;
        b=W4gpvFFCFrgEZ6o6dSfB1F74VDyX1QEA+5wzI7ZwxSsmSUcJ8T13KbzMiwn1YbaV7h
         XcqU+60YWJyjZP3WWmvL+R7NO8lh6OugXKYoB0jm3PEP2hu8/MpNaMssGYFUjToN/gvV
         isiG1Rmdi0HaWRMY/56dK2fDKjA1r9zijJtbNRSt+8daa2dDi4fY54S2kXCusT7zzytL
         d5T9qwLLbkt9X4VmKCW9MWK/eJC3P+bOsoE0tnkNOeLgvRQGBvnY6nm/eMSsIc1Puasf
         /XzLYwzzBb7IM4+FX5dB3UuP9/CEMTfAmGCgcFIXp2QYFaWg4LUie92IoF1gOCjlXmbg
         1BlA==
X-Forwarded-Encrypted: i=1; AJvYcCWVtO8nYHA3M11NNGiWtQijjPVK9V/8RGnCLx4UVbcBGNdfwiEP4lygWdh5SV+BgLg/c/I0V+6L229jqI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnt8/52n8yzMRyTRoIP0NcpbI/AK4AWThQpx+u7XzMEFt5OQKu
	D2DqUNX8sM6PWrqita3vBVMdqh6P8C65nc+hw0D1VeVoV+Bh4VTqMbpJtCTrxXo=
X-Google-Smtp-Source: AGHT+IGx9DDT4b4iSnts3ZE5LnnsizuK3egrq2q0nfjCRLIg7gJH+YoQ/HeD8f5UDBhmZse6UJatjQ==
X-Received: by 2002:a05:600c:3b89:b0:426:62c5:4741 with SMTP id 5b1f17b1804b1-429c3a18df4mr16561655e9.2.1723225330233;
        Fri, 09 Aug 2024 10:42:10 -0700 (PDT)
Received: from [192.168.68.116] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c750ec0bsm1080765e9.15.2024.08.09.10.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 10:42:09 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Michael Walle <michael@walle.cc>, Miquel Raynal <miquel.raynal@bootlin.com>, 
 devicetree@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, u-boot@lists.denx.de, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
In-Reply-To: <20240808055710.19292-1-zajec5@gmail.com>
References: <20240808055710.19292-1-zajec5@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update path for U-Boot environment
 variables YAML
Message-Id: <172322532687.402259.7753078917073034445.b4-ty@linaro.org>
Date: Fri, 09 Aug 2024 18:42:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2


On Thu, 08 Aug 2024 07:57:10 +0200, Rafał Miłecki wrote:
> This file was moved to the layouts/ subdirectory.
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: Update path for U-Boot environment variables YAML
      commit: f6d1cddd76b2da190462d84546e5202d3b2aa92b

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


