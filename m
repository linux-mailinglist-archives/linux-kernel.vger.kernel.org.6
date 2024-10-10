Return-Path: <linux-kernel+bounces-359723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C09A1998F8B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83367282F0D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDAB198831;
	Thu, 10 Oct 2024 18:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="kRa9Act8"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940A51C9ECA
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584033; cv=none; b=ZCrkpRaeUpc1GPpqC2wAmWy1SdH1zYfmGct1uhdxzaY/aseAuX36yfKpgG49W9Ax4+zfverm56hQ+OIL5zGi4E+N/Gp2zUohyzUsBF1lvq4QYvJs4xFODZS27Je2fKXeKf8T6oP1aHuODeYjGDpA6V7yguuzrXE2FzJKseJc5eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584033; c=relaxed/simple;
	bh=LcHcKl9/XI+oyPfjeeNaHZ4YLGnjbUE+QCQI11FraFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iPVjJ1PBeY2rQTad83YGGkwWlNr361Bm5/MQrEmWsuACjkyEo5LCn7wdmzhxjFiUoSBx3F71Kr5kgmxw+7EaV6XeiHC8TXfIxqNkG0r8RLl/ZNPsKjx1i5p7RkTpMk6nVIlM97ub+IbqRLo3ZxITBvNirbnNobG9Bf3mZZ4ZDMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=kRa9Act8; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c91d0eadbfso1649160a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1728584030; x=1729188830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l5b5bg6IlMCHuKDsr7EMlIZJHlhDd4v49aBt5FIXHaM=;
        b=kRa9Act8dw3REk5x0EsfK/zNomXUqcffChu1BHuD29WcbtZfENrG5ZDkMeWdGr2Rqq
         vzwjMy7nt00GoFBpqaGmgEI0HtEsp/6/PzV6PLJqsep02T42qoLLepNjsb+pw5UjdZ1i
         8/ops5KUxjlR2OvfFI51vu4FE7fBeP0wO7XQOmwgpPDHHL8HDom2MuoIry24Emvcll+i
         tlXbQrd0ixxs48mnmG+uX70GnN7Q1Q7Tfe9tCjRvkx7TrgqtOr3kI5JaekuoroV71KKi
         PiZPvNR8mDfyeEa/PUNTU0q1s2ka5hwNGtHyTwsKJrmsikoOslQNG2UXtTAR0oABJ7ke
         7j/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728584030; x=1729188830;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l5b5bg6IlMCHuKDsr7EMlIZJHlhDd4v49aBt5FIXHaM=;
        b=npvyhFxtgEVzBCKHI+92nzEjo1n5ryoKmi5xqGhVPYxdBCOuuOBsX/3rp4sKbWMYu5
         UgqIr93RrkdlPV+AXMBTs3eogzrdF1MrkYFzw1lD08u/pTL5liipDN0KQV4ukJH4DbL4
         538AwQKUQtifrvCRslXUsZgGMJkJDBhoYyTJTmdGRhpDESt52YdFSaHSW4OXqN6GgAkD
         tUAvKgHkbmWIrBWRkyaCst+Vus8hoL8EmPO5O8t2ANtA358wVWdS+id3SnlMGKa0PNlN
         x7L0eN+8+kTygSj6EFS8oxlkuW0PwTVD1zHqCW0F+IxBT3jL/cnZEzbZr16ez/X6y9m0
         g5Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXUDSJdwLpksqUXFxNe3wypvsKnJCFS94tnzyL9SMGn/YKu8G+Eig+ARkEcbcMh0peHi2FWgSjLWYnBwrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfkXq5I7U5iT03tL55C/nAX18NmEnbyZEnhTryOEPAXYF/uHm0
	oG1YLR1+nGCMYbeUud/eBaOA32EbbMuXCtmiko7s+Z+jujivXtAk7JIVg+rjXtU=
X-Google-Smtp-Source: AGHT+IHiJ9c9JsX6LkKAoH4kfF4CrwnhY2DrXX7mxd45mrnLUHEdoXVQPSxTSWMwcAQVhYbRULPSAQ==
X-Received: by 2002:a05:6402:13c1:b0:5c7:927:6a5e with SMTP id 4fb4d7f45d1cf-5c91d63dad5mr5342327a12.21.1728584029793;
        Thu, 10 Oct 2024 11:13:49 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.23])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c9372608f4sm1075771a12.70.2024.10.10.11.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 11:13:48 -0700 (PDT)
Message-ID: <d970e158-db74-4ffe-9fb4-57026ac0a947@tuxon.dev>
Date: Thu, 10 Oct 2024 21:13:46 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3]clk: at91: add sama7d65 clock support
Content-Language: en-US
To: Ryan.Wanner@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
Cc: varshini.rajendran@microchip.com, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1725392645.git.Ryan.Wanner@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <cover.1725392645.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

Can you, please, re-submit this series and include also the dt-binding
patch, to follow the process highlighted in [1] ?

Thank you,
Claudiu Beznea

[1]
https://lore.kernel.org/lkml/20240829-sama7d65-next-v1-1-53d4e50b550d@microchip.com/

On 04.09.2024 18:54, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Hello,
> 
> This series adds clock support for the SAMA7D65 SoC. There are also
> changes to the master clock driver and PLL driver in order to account for
> the increased amount of clocks being supported in this new SoC.
> 
> Trying to account for all the updates happening in this system, this
> patch set is based off of the most recent updates to at91-next branch.
> 
> Changes in v2:
> - Correct PLL ID from PLL_ID_IMG to PLL_ID_GPU in the description.
> - Adjust master clock description to match amount of master clocks 0-9.
> - Correct bad spacing and bad alignment.
> - Remove double variable definition.
> - Add missing kfree() at end of function.
> - Reorganize clk and pll driver changes in patch set.
> 
> 
> Ryan Wanner (3):
>   clk: at91: clk-master: increase maximum number of clocks
>   clk: at91: clk-sam9x60-pll: increase maximum amount of plls
>   clk: at91: sama7d65: add sama7d65 pmc driver
> 
>  drivers/clk/at91/Makefile          |    1 +
>  drivers/clk/at91/clk-master.c      |    2 +-
>  drivers/clk/at91/clk-sam9x60-pll.c |    2 +-
>  drivers/clk/at91/pmc.c             |    1 +
>  drivers/clk/at91/sama7d65.c        | 1373 ++++++++++++++++++++++++++++
>  5 files changed, 1377 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/clk/at91/sama7d65.c
> 

