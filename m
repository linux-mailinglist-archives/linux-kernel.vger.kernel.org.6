Return-Path: <linux-kernel+bounces-373297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 027509A54CC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 17:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95B0AB21152
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 15:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C1A19343F;
	Sun, 20 Oct 2024 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="pNDq0dJt"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE03C19343E
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 15:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729438771; cv=none; b=KnvOJZVxc7vpUaibojVzjmv6nBzl/ARsu2zvUnSLfujdAE/NTdQeVfjF2HOafjwPL0YPntcFG0Um0kbvmMh0nP8o9pukYo4DMVLuwBsieNZduEo/mPbA1PUBi/tzaoZUfMg2EeH05ZHi3qolaZmAvTJDOJUz55FgmtqQgNtLsUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729438771; c=relaxed/simple;
	bh=oh7rhB/4cQ0vZjQlOAp+6Sk98Va72mmT7J7DoldCnOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R/XSxFYGL6zdA0/E5BBW7LKZ+iK4XszRKrFWFedKQUUNwlmcFy9eHZwBtOvAr/5Lq0TvUYibmwSxsPftRebszoNOjZbS8ulIfkcg9Q2AJ5L9/kX6x77ljyNYRFPAHXX0YYyRvBH6jPdnfyKCuMV/VxCCI8m6JLONGtUH42FQF/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=pNDq0dJt; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d6a2aa748so2379504f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 08:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1729438768; x=1730043568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QTfu8x6uKuXBMf4pSuPyv5OmBQv74/q8muUU6L+EfSI=;
        b=pNDq0dJttm2wBMhxxivVYK7j8VdMu6iMAD7tVQcy+rC9eWjNMxafIvYBdkJOQMC0JU
         vEPyg9D7KqWqUNR9O/RI6Dm/lIgrQDaRj1ugElsxyiFHXPjzjbnSVn+PpM/EpcUxQBD0
         UBT7mKQnfAQpVZEh5sErNKu45Ezr1KzapW3YwIM+6sC6dzsXkNsQZH7zWcknbouKpCFG
         VRSa/d/oPQGwxXFL7X/kjiONFPwFCrjDc5jgsVlmzOtuMfWxs2RtUbRf5YThUQVP6n4O
         hTQbVYTCINlMgmED+Qmx4AncXwl43pd+YxGHO3h4+EdmckpKFqX4QpeaQENRxfZG5CUk
         w53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729438768; x=1730043568;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QTfu8x6uKuXBMf4pSuPyv5OmBQv74/q8muUU6L+EfSI=;
        b=Ra2vVG7dSp1tfYwX3FqqF9aSROmCAnFWLWEDS775DQcstmbOgjAx1KpWzKNVrzBHdg
         EOViL+etWInuvxMOSyP1MUR5MROiubImvmhOLNHC9oEAm8Uel5r1rqyefaFVtNTAcLcf
         xDvG6yfIPE6OpoieZNfvWxIZkHyUaaWkiM3/+V9SaCnz8C/sUkSKQXfv/PyeXePiAgL7
         tV6/v5QNsYfnG2GmFBMSfQEX8v5DQyrghfXaZ/W3c+jWOo7qbaEa3f35x6+9XH/Vljen
         V9/o/Zc6nSLMe/kM32ZyD2/Kpyk9JSlo66zCuc45stEOWJEYWaYYfG11WB08VG/ulfrH
         DIsA==
X-Forwarded-Encrypted: i=1; AJvYcCVM54lC0d2d7vQiuewIq4uKZOgprCmgeoMjNypdhGFxSsjx2dfOiSQ8qqDh+MMvHQuk4zGx1YZK59G1WeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhCojvSOAym/ZPKRYVdo2Q8Pio87H2RzQcAsC2bJ5RbVdyYpR7
	cs60FvIvIhjyAevImZFTB/XDI/Gq1zQ8pS9KKOxoDHl35V2EfpUWOAUdopArgSw=
X-Google-Smtp-Source: AGHT+IHFx3PRdDtbVUn5kPKTsjG6UXE2U6eeJtsRm5EYGJmiBxmhBHsDIkmuWmrT497fYr4RM75eAA==
X-Received: by 2002:a5d:4e49:0:b0:37d:3301:9891 with SMTP id ffacd0b85a97d-37ea2164d8bmr5663873f8f.17.1729438768085;
        Sun, 20 Oct 2024 08:39:28 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5c2fa7sm26897165e9.34.2024.10.20.08.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 08:39:27 -0700 (PDT)
Message-ID: <0143a3bf-a912-4ea6-b57c-5b7af79fe5ed@tuxon.dev>
Date: Sun, 20 Oct 2024 18:39:26 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] clk: lan966x: add support for lan969x SoC clock
 driver
Content-Language: en-US
To: Daniel Machon <daniel.machon@microchip.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kavyasree Kotagiri
 <kavyasree.kotagiri@microchip.com>,
 Steen Hegelund <Steen.Hegelund@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240916-lan969x-clock-v1-0-0e150336074d@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240916-lan969x-clock-v1-0-0e150336074d@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16.09.2024 12:49, Daniel Machon wrote:
> Daniel Machon (4):
>       dt-bindings: clock: add support for lan969x
>       clk: lan966x: make clk_names const char * const
>       clk: lan966x: prepare driver for lan969x support
>       clk: lan966x: add support for lan969x SoC clock driver

Applied to clk-microchip, thanks!

