Return-Path: <linux-kernel+bounces-220862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A3090E855
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C5452831AA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1210B12BE91;
	Wed, 19 Jun 2024 10:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qOK7hK+Z"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B316F2F8
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 10:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718792876; cv=none; b=r1fVD1mBj6XVG7K8o5SM61T7BE4r/46QAwGMyyME2pQm7iX+B2ia+ZikdDVKHLLs/lAhlA2o/mc/iQrjzxCaLSJRdfKeU4yx/mBD1hEed5H0K7+k8DGYUmkBjL3lEL1GOIFY0JqgFMTGHdFkJmtu2nhGRmQXBdN7yW5Ro3saUfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718792876; c=relaxed/simple;
	bh=i+Vh5IEf6ap5Zu7o39yGmTLNUILpgLoegwAAulUElVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uyO5kamb5tfdxOnkoUvbQW9rp4s4cSKLMcdHO8rwZMma3LuJ3F7rTPGHCr4YwH/+c2An3wytYTTmCGvVCPkP2NqwYC/5/O6J3seGTojWdK1dGQ2E4M4B5N0Jo/b2WP5F+tik9TpxMkcbU0oikLfVf4mTa4lcG58tiX4OnD2BK/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qOK7hK+Z; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-361b376236fso1354149f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 03:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718792873; x=1719397673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2CyUIVE4d7f/WSt+yhhaSrSEXlrd5/Sf0m/XuQDZqM4=;
        b=qOK7hK+Z/n9BG+FhA9S7J9Nn5Ec5Xp/JGVLpHoaQBM/ON9Zwv5t4FCLSQAcqsFaQHM
         Rg6aXYLcbf+15slquCy78vFpW9QkpX7w+ItkpUvevvB1p1bfe8twJv58CtHzWkZG9sLu
         LMWAaiQsuWaEjfeU4AtbZm+D2lOvIO0YTVMiA1TjHL11S0zYUYE9l0WJ1ewKvhYXIxXD
         D90OUX+35n32uWzNNqGqYdpUUH2DJhJl+f4XgSeT8x7h1Cqi1TMEaMaXCYAQh8RZG4YA
         FkzExkJonU0RDQz8AGmCJ8UJP5k/tC8hNIF8bliPbhGLl5zYVrVbIlmjSOiJh2SM7cT3
         ToZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718792873; x=1719397673;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2CyUIVE4d7f/WSt+yhhaSrSEXlrd5/Sf0m/XuQDZqM4=;
        b=CenMBrfR+0pQ0LJVJoKUWhm1RJYLMkInCf6vY9VK1HybApPUDEp/vCyFEbz4JE0m9T
         Fjua4SEKQXFFh4d3NtHBIXjI39RxLV4230sENL/58JxTyfZhxQWMF3wlgm1n7n71YS/s
         X2svdiv5NCpw9+QSEVYknweVk/nxDUoQGIci8Wstt+vKHgeL6oLrK1rHix5y2s+VMAJc
         fWQWm/LmQ6PHdeQhR2L1xMKAtxtw7KwtJkkhjxyy7Ldm4+QHTrrye5F7GSwjcli178QF
         K3KF01898qT8T6wmoa+5ITC1RUVpIqMvjuRs63Bab0i4qF4UokGvAa37JcNNlU9KtQXh
         PFTg==
X-Forwarded-Encrypted: i=1; AJvYcCVjy6PuWf+H0wMiBkGR5Xpbgemzn8U5r0ncGYE0dJR/xmzVnAEVGGOSNPO0WDgP39UlI6IwRcvKM8iB7X/N6DUlOBCetcuk+4ykXyQ9
X-Gm-Message-State: AOJu0YyePKOI7GpgidNJ+mcaLMRpurNJoU7/sfA9caOY5rmAix0W/QSG
	ugg1ukGtJrvOutYpZbqL220/hOntqnHVPXWLJxeB7FykFP5Iz/Lp6b5pohpTbAE=
X-Google-Smtp-Source: AGHT+IGtec/lgCxyi9AgTK89DVz1wHvGWI1ABFZYclqKo/M9rdfeDf4DrnxhbsWhUsYeH8EB8I5HaQ==
X-Received: by 2002:a05:6000:d41:b0:360:73f4:7937 with SMTP id ffacd0b85a97d-363171e2cffmr1500634f8f.6.1718792873117;
        Wed, 19 Jun 2024 03:27:53 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:a784:959b:8c69:567e? ([2a05:6e02:1041:c10:a784:959b:8c69:567e])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-36076515a80sm16634591f8f.76.2024.06.19.03.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 03:27:52 -0700 (PDT)
Message-ID: <5f894bbd-3301-4305-ac8d-10dad1e6939d@linaro.org>
Date: Wed, 19 Jun 2024 12:27:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dt-bindings: thermal: convert hisilicon-thermal.txt to
 dt-schema
To: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240618-hisilicon-thermal-dt-bindings-conversion-v4-1-7eba97fbe6d0@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240618-hisilicon-thermal-dt-bindings-conversion-v4-1-7eba97fbe6d0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/06/2024 04:31, Abdulrasaq Lawani wrote:
> Convert the hisilicon SoCs tsensor txt bindings to dt-schema
> 
> Signed-off-by: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


