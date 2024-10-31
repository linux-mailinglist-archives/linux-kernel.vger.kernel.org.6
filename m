Return-Path: <linux-kernel+bounces-390483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD979B7A7B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2415B1F24A24
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795FE19CC0A;
	Thu, 31 Oct 2024 12:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYSXaC/2"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2B114831D
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730377632; cv=none; b=W88eyHdsu4QyBftLk4c+w4Fpe7FCeX+7muUT60JDhFq5C9TBw4daYcqZ7izvvLsH0o2roY2Al7HtmdaQrUqikR9uoD+pWVHRbcMoCJeOdLMOB6Yq54EDrU/kskH5k/p2TKdN82GtjLmkNqsPdeCd7n0SpOFeaMyDQ/NNJXJiVNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730377632; c=relaxed/simple;
	bh=ulHUz41ekiuYm+IKpp2M13Se4z0twxCfs+fcpHc3TGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nG48f1OYgg5ZxuI6YZ2jfKNz4Z44rzo7a7RADcnMBBeuymNnGTSg+ESMCeSCPsSqk/1qnfJM72/nQTi4wFwoQ7mWdekFS/gXVk7Ktua9myxS5iV9swYblyESAazpy5jt8PiV8aKPbjTDkyo3A46VgUOwOQ19I2Y1ufFO6g4EOSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYSXaC/2; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d4ba20075so668089f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 05:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730377629; x=1730982429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ByTCYd14UYri5hhBpfCXYZOyOvDgKqhahBNXgoUgOVc=;
        b=OYSXaC/2yj21HOg84+lDh7OVL75liHAqsBFYFAqOGUPr5yCwrW2BcwmHeTX5IvjJ00
         rzM5C1Kd8QmI59Lx6CYAMSG9vNbk8MeVFVxpGf+BqHpTQDsft4ywSkKuCJiIPKANYrha
         2Wrur5A2urdFiCT44rzc7e+mrOWNLofkdqR/S1Znj15FgOEcDhgBPmrdziOe06GgtZJx
         ahDxPaidygVfdYfISt517ar8nJLFWy+RPyd0g4bFm9IcGPSoOt/7JI/Cc5udLxdKnU6i
         1SRBF2T0qAS8YUtrislR60L3l4/Z2mI3Bs0WYLLZ0zOHBLIj7F3eafWCeXwgsp+qx1OO
         aa8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730377629; x=1730982429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ByTCYd14UYri5hhBpfCXYZOyOvDgKqhahBNXgoUgOVc=;
        b=cwkYta8c0+aouVyny4McddNZhgfQOi2Mzlsl7BPNBpOGUBAIxjMZaM1aoEKI6feZes
         nkb3YTNPC1mRQQAfs7688yDxHF02Y6RZPjMg/DQIUVMgeBVrE/aG3ytZlXUVILkXo603
         fb99IZZuMh2UP2L/Dh0PmFYSUQ9DkZh3rbjjb7GCFTs2o/O3U7qJBu6iiXzkyBMSId5H
         HkHMeWIP3+Q7XpJytgq6eNVKpIDI8gXzhm47fVIWhBQLVlBcUskYhYOQuf+FvmjMAv0D
         C/iBah2Q7yiUmsM54Z81WBx3OFfqHLajTAyPBdnJRj6m5Ls98EQ9gaqCq4mmlD7YBdSb
         k8Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUU5+GGdM/Ei5FQHigF2dS6fHNKd1MnY85YsJUmxqM1gm2f3V1DGhB0QoGOJtewXrje5aBg1Hj3tcq4UeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YypQui/oHl809vpfoz15rKCZCBNuyS3e32Eu4Kl7FUtYx0aYzM1
	Pxtyv4rn9ZNuut+ucDGF1RW2AXuNFYVywsMBi3PH+QaNrBXvrp5k
X-Google-Smtp-Source: AGHT+IGNej0joknwPsbYKOTEUixvGOjU0e5Z1XjBTjKkSw6IjWk9zeeBnOp4KqqlhyMlQQW7srqsDQ==
X-Received: by 2002:a5d:5847:0:b0:37d:4e74:67f with SMTP id ffacd0b85a97d-381be907c52mr2539991f8f.37.1730377628990;
        Thu, 31 Oct 2024 05:27:08 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:d7b9:afdb:c541:d023? (2a02-8389-41cf-e200-d7b9-afdb-c541-d023.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d7b9:afdb:c541:d023])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10eaafdsm1977568f8f.63.2024.10.31.05.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 05:27:08 -0700 (PDT)
Message-ID: <984e5b55-edf6-4f1b-910f-8064b30d1c72@gmail.com>
Date: Thu, 31 Oct 2024 13:27:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drivers: soc: atmel: use automatic cleanup for
 device_node in atmel_soc_device_init()
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241030-soc-atmel-soc-cleanup-v1-0-32b9e0773b14@gmail.com>
 <20241030-soc-atmel-soc-cleanup-v1-2-32b9e0773b14@gmail.com>
 <dfa83464-4632-45cf-a257-b9d9739d37e2@kernel.org>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <dfa83464-4632-45cf-a257-b9d9739d37e2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/10/2024 12:07, Krzysztof Kozlowski wrote:
> On 30/10/2024 18:10, Javier Carrasco wrote:
>> Switch to a more robust approach to automatically release the node when
>> it goes out of scope, dropping the need for explicit calls to
>> of_node_put().
> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
> 
> There is never a "drivers" prefix. Especially not first (because as
> middle appears for FEW subsystems, not for SoC though).
> 

Interestingly, 10 out of 20 patches for this file use the "drivers"
prefix first, so I guess it was an error that propagated for some time.
I will stick to soc: atmel: for v2.

> 
> Best regards,
> Krzysztof
> 


