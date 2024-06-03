Return-Path: <linux-kernel+bounces-199231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0DF8D842C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33C1D2857D3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C35512D767;
	Mon,  3 Jun 2024 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYi1Rj3g"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B615612BF3A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422013; cv=none; b=SUIL3YnrlKshVIs9ZtsqA8gDd4tVw5GWb8AvYYFQD41n65Po2ImEi86WGmM+LKcWA4r7GFPph5UuU1ySiJgVWE4nhURhvTauktQ20zN1qj6Sc9kFjZ58JCKRUpb77KLGj0/ggmxDwC7VI5jfIw6L+/paoCkKwes90qnzfSEcRWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422013; c=relaxed/simple;
	bh=W2GVBPMqiSQyhG8W8PIaFIc/aN3PASl8BbXqJqq6muY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tlqImhLp0uNhf8ocLtLeH3iLIy1W0QUndtRO4+LOqcOUjJjhLfcM9U4dRR1pwjfy4bi0IHzGZC2o4ltnBkKD98tnWoBMWbT9CPSh/wBie2xYdqmboleeR6Wd9PMDIGGm87ijKJ2Nz0lqhuweYrYvhNvRkLRM5f51BHyhWatpkxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYi1Rj3g; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52b82d57963so4454756e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 06:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717422010; x=1718026810; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A5GgDZ5WUBC3nTc2sLPQ5jCC60M5+GkkN5UTe3tmXis=;
        b=VYi1Rj3gtTNM1UKfdmjdI4/vGqHCauX+lUbrOXu4IG8FhQmmRr1C45R4kKsS4OnadU
         J6gWkDFltkZg7t8VZqWVVFUj1j53mcGirIlnep5U639RcEhVwSG4ztMbb5QVLXbQpY10
         igm9w6WHnZwAxLKUlvMQBWJmXVdbGgSMdyqnzRfufqQ9B1SjD9nKSEPhbBldGecx/O0V
         MYPg+/j5tzXdoXG35X5eibocBa3edT7zKTUlYFs/VhihcLZgn05ZW8WmPouTydmIrfFw
         9/TTY+MbmRANz1P2Uopq7hV4yJtEyxDRWNUlqof9LnkA0a5ygSURS620xcnJt9AZ4R7b
         KMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717422010; x=1718026810;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5GgDZ5WUBC3nTc2sLPQ5jCC60M5+GkkN5UTe3tmXis=;
        b=GOJ2INGIc+X7+6PI/2v+FhYsxWYrTtV6W4sOGd0vwbT/5/cbvZYxCdfJmWi6/JSEc4
         iGOG9bMvC8K+i/P9I2fcAT9lHzb+OMmI6txADOapmmhtqnoiCWJ02zFD1IIJJfukAO8l
         JRdCrlow/pVOACok/8zGtQAYXKwddMdYLNOwwPa9OA1CZKgLE7q/pMCU4peCO9wzFVxI
         TCkDB14O8GIHxGBXjhNtxiU410EPYDiEKbXtOJE1OPZiL2iLlI/YNHD7NugVuXMA4ekw
         UM1MijKEpTfZRHGM1NaxKAcVqFUOVbkXo9RnfaEY43pZAnO3QTvw25HyrIspzikMRz+T
         Wueg==
X-Forwarded-Encrypted: i=1; AJvYcCXLvILhnqYfvuovt/RBieFpqSsnpzTLtsigyM1e0yqyipvlq1tlP9CiCc+bvoOGnu5oX7Bwe4ofDVpbfkTUaoLnUQV85pFiJ9lkxcYY
X-Gm-Message-State: AOJu0YxjNWfg1IOXhJr8ga55XaCAlgDcQOxzbcte5rPgnZhIk4i9sEnY
	WBWVZBDRvuefpwjIHpIKuChVwWRXzO79CmC4/89wV4KzQO6ob4BKNDMn0w==
X-Google-Smtp-Source: AGHT+IFc6qkRqYO2T3R0mqqH2If+PlXgVkB99IpmilHjOpNWm39TLqGrttu8HAXvLurwUjr8u5ctPg==
X-Received: by 2002:ac2:4296:0:b0:52b:c9a:148 with SMTP id 2adb3069b0e04-52b89581d8amr5427183e87.14.1717422009562;
        Mon, 03 Jun 2024 06:40:09 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b9f1fa9a7sm61733e87.249.2024.06.03.06.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 06:40:08 -0700 (PDT)
Message-ID: <8085c2b9-f824-4404-9adf-fb8be09e5a86@gmail.com>
Date: Mon, 3 Jun 2024 16:40:07 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] irqdomain: Allow giving name suffix for domain
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
 linux-kernel@vger.kernel.org
References: <cover.1716533790.git.mazziesaccount@gmail.com>
 <2ea1749587d9e5a74a80a8eee7caf58c3e954a6e.1716533790.git.mazziesaccount@gmail.com>
 <87h6ea72f9.ffs@tglx> <77c64d75-43fa-47bf-bb3a-e0e49d51189d@gmail.com>
Content-Language: en-US, en-GB
In-Reply-To: <77c64d75-43fa-47bf-bb3a-e0e49d51189d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/3/24 15:19, Matti Vaittinen wrote:

> Here, when talking about 'parent IRQ', I was referring to ERRB or INTB 
> as 'parent IRQ'. My thinking was that, the regmap IRQ instance uses INTB 
> or ERRB as it's parent IRQ, which it splits (demuxes) to separate "child 
> IRQs" for the rest of the PMIC drivers to use. I'd be grateful if better 
> terms were suggested so that readers can stay on same page with me.
> 
> After talking with Mark:

Sorry, I forgot the link:
https://lore.kernel.org/all/Zjzt8mOW6dO_7XNV@finisterre.sirena.org.uk/

> 
> we both thought it'd be cleaner to have separate regmap IRQ instances 
> for the ERRB and INTB lines. This makes sense (to me) because a lot of 
> (almost all of?) the regmap IRQ internal data describe the IRQ line 
> related things like registers related to the IRQ line, IRQ line polarity 
> etc. Hence, making single regmap-IRQ instance to support more than one 
> <please, add what is the correct term for INTB / ERRB like line> would 
> require duplicating a plenty of the regmap data. This would make 
> registering an regmap-IRQ entity much more complex and additionally it'd 
> also complicate the internals of the regmap-IRQ. It'd be a bit like 
> trying to fill and drink a six-pack of lemonade at once, instead of 
> going a bottle by bottle :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


