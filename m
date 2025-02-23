Return-Path: <linux-kernel+bounces-527751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4835A40F08
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 13:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A98E316F86C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 12:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664EB205E3C;
	Sun, 23 Feb 2025 12:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bjkXXRUY"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B788460
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740314761; cv=none; b=jAIEirby/z0C4etYemxlG4bcWGVx+bz05lbROxQP1KZajcQdvhu2mvika0yleKjY+JySMYoyQ9XbxZ4EYGrZ7J6/nfXo2p2dakNFIStmPX6uuezN3y6Ub3vQjMnErFzttjkZWXBcXR3TWWQhng3uPg4c+oSCkhSQT0yTiX+tw28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740314761; c=relaxed/simple;
	bh=nIBKRUzzjXYm6l1jxa2y3dJvsdqoRKYeUA//1G94xVA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n2X9xiKTkNbQjxhPBzBz20/YzFDEhUnnAcohzo7kyXCiyJN6D/5G9n5HyVs6ZYDex//3rFFNmUGAjEWDou8QeixStfw4umAANdE3HT8CHH7CAwvqQ7aikb2LmibFzwn2773drzRX4mNkwFGduktx7SZ2PvlCMEiYefrTa/zI9zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bjkXXRUY; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abb76cc6108so45498366b.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 04:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740314758; x=1740919558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxGLmwDwexFMvF+5G+z3vtNFg+fHiCX2FbyV66dEnmY=;
        b=bjkXXRUYF0BrSWWKQ9Nd2+DK1fvW7dpxbW84tpoQ6Euf1TCldHx+dbeKi8sDlAYzL/
         G99jD6vEwl61zG0033/WL8m3KjPEiftXxvdU64/SJIPYgf4TTgVmNWW4PAWZjMr5i1Tw
         3Vl23ls6R8b8vHJf7znCWhat0+B/ytq/rtmSmjwZexiWYkzDwdw1Tq4igYFEmpQjI3BK
         HyBKaFNRqMWxJeNCDaV7Y/BcKKp7WLkls5pb+ctdslHFGUK6w0L4ofWa9c4nOBxZiR6o
         vk/BDZLB6hsUMokhv4ctSI2hfLKDoNCw8cnNQB5NVxCX26zcSVfxXokjYI5wqiVHrvwB
         LDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740314758; x=1740919558;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxGLmwDwexFMvF+5G+z3vtNFg+fHiCX2FbyV66dEnmY=;
        b=mziMlngRQYGjchox+TdTMSrH8n+z87p99ljOpKGhMKtwMl7DJHu6IhsWlWG0KKyCiC
         vhLkn1c6fE2j0S1lbuIA5MW5h8bfSH6tCHRDtJJkeWeoM8Ruo4Gy1EcVn9KbSSFylDsG
         JFm9q0EUjg5lVSDa6mhYDCZ8hdFP9x1tvX1tarcno/rauHJ5JgZqnBvjbRp023MExWkl
         j0PMfJ+WxHeI0RLYQ5OeXLBo22kqsdzgf5C8eOltYFy93r2cMe2jSoMAVviXdhvv5beW
         zi36wdXE05yBABAU89KBpYG7ZNl23lmd6yEZbeWsdZLs182AVGkWVUumHJAQ/EH/Ipvz
         UffA==
X-Forwarded-Encrypted: i=1; AJvYcCWFa67jJWhV69OsWlgIRVoqce9f2hqeHghWggGeoGr4i6LJujWmdnhhTcKHcVlL/N//nB4RJ7UZCNxX/tQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF+Lw4UEroJbk3/8dlUEZqcl2848vFAcurjs6AUUtLm0voXHIE
	UkHVamCCEONcfsjO/4LS9tTnCprU4txAUB2kGsCvLexF96n/RuFoG4/r0yyfBZU=
X-Gm-Gg: ASbGncuQGxWDcTZ8MJw8KsCXPwDPUIxWqvgLRzg/vQAeGegmWaEEjve2OdzODoCIQJl
	MWEKAETYdU4+VhwsRYUEvd5S6IRcdxjRynQYUvCQ8KCOdILWaocKJk/QGGlYRxiQlPgrRXMTL1H
	n0xnoJWnV7/h2AMKhN5Y7gk6ih0VGJEF5kyYo1UOvgEFd8TizupEjgnpJ8gh09ed6N0xlrYiSrd
	gzKdpl5DC7q79DkOkdXe3r3MmaXThN14TMDK/9h3mthzlmLeuxNALkrCg+3bWR0WUWVfAQGW2Et
	2EK9G1DfZIGNwFL7NOFKJljWwTx/X9DUTfSA6ZK1mCkuKAe8RC4V6LmASwPtwfTCpLKrOHn+V0F
	i
X-Google-Smtp-Source: AGHT+IFKCmAEZUKM6icp+w8U5a2oBjpzNrfLBOKKdYNrGEY1U63jOVDcOQc/BfZTE5gPTEiU2BqapQ==
X-Received: by 2002:a17:907:c2a:b0:abb:444b:8472 with SMTP id a640c23a62f3a-abc09bed469mr355018266b.8.1740314758257;
        Sun, 23 Feb 2025 04:45:58 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8209a2cbsm1555460566b.133.2025.02.23.04.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 04:45:57 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: krzk@kernel.org, alim.akhtar@samsung.com, 
 Sowon Na <sowon.na@samsung.com>
Cc: krzk+dt@kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org
In-Reply-To: <20250219073731.853120-1-sowon.na@samsung.com>
References: <CGME20250219073733epcas2p1537d9cecdfad313077aa4cc4bff8a6f0@epcas2p1.samsung.com>
 <20250219073731.853120-1-sowon.na@samsung.com>
Subject: Re: [PATCH v5 1/1] arm64: dts: exynosautov920: add ufs phy for
 ExynosAutov920 SoC
Message-Id: <174031475590.40795.1242033938168164812.b4-ty@linaro.org>
Date: Sun, 23 Feb 2025 13:45:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 19 Feb 2025 16:37:28 +0900, Sowon Na wrote:
> Add UFS Phy for ExynosAutov920
> 
> Like ExynosAutov9, this also uses fixed-rate clock nodes until clock driver
> has been supported. The clock nodes are initialized on bootloader stage
> thus we don't need to control them so far.
> 
> Changes from v4:
> - Place entry in correct order instead of appending to the end.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: exynosautov920: add ufs phy for ExynosAutov920 SoC
      https://git.kernel.org/krzk/linux/c/5893f538e331609fbea244ed14732291edd6ab22

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


