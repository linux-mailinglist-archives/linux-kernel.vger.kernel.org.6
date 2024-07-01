Return-Path: <linux-kernel+bounces-235612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE5791D771
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 634762868E4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 05:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F28381CC;
	Mon,  1 Jul 2024 05:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DyVrE9jK"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E382B9BF
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 05:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719811703; cv=none; b=aYCK7wruJ8bnR5hebNVFtlN+uhDLkiLzb/+iK/TQYmz8BvYv/YUjRUcrvMaDlzAKAvQhWl12fXNzEwErYrvWRFrmEquYHheL/zQEKx4tR0j3iJ24RMa9e3i/AKPEN/Kc9iQBjPf7RvD6dUdmwo3sQ5PPNfkXB0rmM1GjjgGyZDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719811703; c=relaxed/simple;
	bh=YZWSzpNEaDa+eXDQ28HrPkHrPJlHNHw3DS1+bUPdeA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AHHIHL72Z+J0ulESeuDSr4GPpRgQvXlzlMw2MQjKSjE+yi19cUY0AHmDYzFfvQ8LQNU/OCWuVoJ39v2mW9lWFCq2Cug14XgLHESauIfxoienzcUhkMSsD1SiHq3ffAAEmAaKtjgYrBnl8EHjBCbPp6VW+2C5Ua5tieOwY5/3PFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DyVrE9jK; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42564316479so16264485e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719811700; x=1720416500; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fkdA8KN8A8I2bA11uvZt9695FtnthrYQMH+V0MW6YEE=;
        b=DyVrE9jKDwWXYYBx1F7ArOxreZprCXIr81b6YSddmouJbhDbjMFizewJ8nuINfsSqP
         8Ur10ajNxQsz2m587YvmtBlT10uoV80L0IfiDUoeYvJwQMC54i6yVcsl89DvZbMu23t4
         GQFWo1htajrGRtXUJlSwgfWpFRfRS6hsSQqh0Qvhu4r6m3s20Q69x+SCS7b31nrFNggL
         El7TIV8JWUwDg4IVApQWZ6EG7MvGShIVB43WAT/psN/Unezo9Iy3WVtGDNiIde7QElsO
         e2oRKoeIGGr9s/L5p7HiiAVonp+wWgUpb+iN/49I5V1nw3wlZsKctGgWoJhD1NN/4oHl
         3U0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719811700; x=1720416500;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fkdA8KN8A8I2bA11uvZt9695FtnthrYQMH+V0MW6YEE=;
        b=eN4jl/2TeFG2hZGLG23ztFnTSXy9eVqfU8JKuXJlmgzAtnm8dy5IfnTWbnnJ+idSwH
         +lCCLP4XIqYFZfae1WqE0AF5v9TaX03vcd9+WH4ByU0JrAfyeQQKokuAnnK6N0yfNED3
         WLtMdNhcZvHKBXYqlvPygm/l+i74xRQj5PT1WsjlhbKM5euInM6Zg9tY+4CMMPuZzRcA
         GM8hmWIiVfL/TpzSc4+i0F4Q5z6IxqkOVHxkL41Jkb9gT3m4GL+TOEJfKfvpLjS+8fe4
         qqm5zUhtTf2lQxu1MOJ/MFS4oWZn5FMk1AxcAAP0ODY/V6HUuXTu8waBc3tRhHAG6o9W
         CAWg==
X-Gm-Message-State: AOJu0YykbTb+Rz9u3DQugXG9fNWBLCeruEN/ppiFj+y39dxixauc27wi
	28Sb+xSFpzNqxIv3ZaMWDLTH+YAnpdy3rBRjbVrlhP0ku2MBXZm5475ZrwYtBVg=
X-Google-Smtp-Source: AGHT+IGz4rqWrl3DoLsQ45HTpFY0wCleTeXmKARmX6Tlg1QN5PVLZXxtG1F706x/BHg79dLe19Q0Zw==
X-Received: by 2002:a05:600c:4ed3:b0:424:7992:c21f with SMTP id 5b1f17b1804b1-4257a021800mr32315315e9.3.1719811699661;
        Sun, 30 Jun 2024 22:28:19 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0e16a8sm8962338f8f.64.2024.06.30.22.28.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jun 2024 22:28:19 -0700 (PDT)
Message-ID: <93a088d6-8092-43d7-953a-5374a22ac6eb@linaro.org>
Date: Mon, 1 Jul 2024 06:28:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] Add generic functions for accessing the SPI-NOR
 chip.
To: Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>
Cc: linux-kernel@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Erez Geva <ErezGeva2@gmail.com>
References: <20240629103914.161530-1-erezgeva@nwtime.org>
 <20240629103914.161530-2-erezgeva@nwtime.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240629103914.161530-2-erezgeva@nwtime.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/29/24 11:39 AM, Erez Geva wrote:
> From: Erez Geva <ErezGeva2@gmail.com>
> 
> Functions:
> 
>  - Send an opcode
> 
>  - Read a register
> 
>  - Write a register


Don't use the commit message as a continuation of the subject. Describe
your changes. Convince the reviewer why you need to change core methods
and that it makes sense for them to read past the first paragraph.

You ignored the feedback from v1, I'm marking this as changes requested
and ignore the rest.

