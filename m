Return-Path: <linux-kernel+bounces-418366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9409D60DE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619252814C8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 14:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F6D13959D;
	Fri, 22 Nov 2024 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="XvSO/s0E"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7025E182D2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732287152; cv=none; b=GqkwT6Acywd2P88AIECAVZDLtnGgPflI7/KhTIfbM4ISQl2rQPkDkAoz8eJLlks6TuTrI7Gm0BLnUg48XNB+QGUry1woqNHnWW1EUtN9Kj3Ta2E8f6EEXAa91SEU6NeLiN/kJE/jFQex52QQAzeS5sLNHcZSEdF+zOyDVxkaojM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732287152; c=relaxed/simple;
	bh=H4ZH4hse3qfhm3J5KjDY1bc57PZTgGnGOXIlR6oGR3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j6Zt0YnJ38COZrXfql1yiTcmNfXzWGrWvCMeCSUzb3CqNXPSBBfAHWusQRdPA3LppFYID46JxHtdLiO1azKZv3DIDCdBG1e9uQrIVh1i2KIDVwYE+BeP0p4ZqOMzDoA6bvrm/Z+XqRlz0Jtjvqlxq6QZtauior/uPc0llZyZGxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=XvSO/s0E; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-431688d5127so18096485e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 06:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1732287148; x=1732891948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H4ZH4hse3qfhm3J5KjDY1bc57PZTgGnGOXIlR6oGR3g=;
        b=XvSO/s0EPlECsMWkGQ016IS5liDiLHjDijux0bhHXPlmYfoT48u70KTid1ylKav4fD
         ZTeV9ycSog/w8X3wsx/DVPVL+f7/FDzGZXopb5GCt1AdB/CTDvNYhpnwTWcNnc8V97QH
         cEhwWoaBCs6OZ0/SRFM1wvuEXxTux+tqlArjN+Fpfw3Z3q1RCBMXrexGlW8eIrCT7juN
         8O4Ae7fV0Re6BMaVoTPQZl/Hc6U5Hl37W0D0lEK5kDvjQkxOsq4qOdkASUpnE+2ZactS
         jWpSNfZbL8QfnPhg7EXVYF/cqlAFcDcJjL+wt9jm9taXMtw9+Tb8zZ9jt9gVC5immPQp
         XXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732287148; x=1732891948;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4ZH4hse3qfhm3J5KjDY1bc57PZTgGnGOXIlR6oGR3g=;
        b=hq6NUl02dHFpkFB1o98BytYuNErFLNLjBFnh++rIWv1BQxX65Ach5Og7KJUameEh35
         EwEp0VX3e1vjPcGDrOnfeQN7HS8W1wGpvTcCw4JYwJb0SyFbVRWEBu56hD5BRyuzQVWy
         DyXZKBe9iyS291DdsgfTX5nncm7DP421ZekhSCqriBQVYyRUkAd0xA/JnhxmOGQE/yIt
         3PSvoM0PHQXyfd2lnAf0DVHRWDQPeILNHVv/2CHwTQ0LAbCqqtCdqsmrNNxFNVh+dTpK
         0zZ7uLO4RdsCiMzU/xLRT0VXeWd4/0m/Ph9CpGcSP2PPxHtUiUfHu+GLtNphE3g9b6Tk
         FQSA==
X-Forwarded-Encrypted: i=1; AJvYcCXeZUJE7RG7Q4gFW5gSo8Y9EruAToWG6QRPMIEKuQ7AGthV3c3IdoIwP/S+EFrbbukAiJKvA856xcwoo18=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfmW/XjPthN3b19HC3EfjsC3YXm6vIYoU2mdaGidnkUsnKVeMf
	Ib9J19325TNuTkB39hnv+GDVLb3T/aG+MtNP2La28yy5LDp5S7Df9dTea1FESN0=
X-Gm-Gg: ASbGncvSW7fJG9MOO7Djr7zjPplnmIlx50+5oUqqdAEtya92OxejGnG/WzY0j3qBzXj
	l/Ip9tYVxwcLsJTJ0pAkJYgDhEz+n4O8ET8ewI9YhY7QJw1O9kmyRh9BzoUpQQsi4pxCFZp8HXb
	fH4OcC9mrHp2jfTJSEH3Udsb8PSj1uK4tHhQ7FloNnJ4ZmBEeGHAa3Zfpm+q2eVcpUd6682qD0A
	h6zdZ14Z9HrK7dQToGlv85Kcr+iJ36/tFMPelAIID/w6N+wOV9v4YQvLQ==
X-Google-Smtp-Source: AGHT+IHsjxLFgEV15mKQiBicElXEUDVmwQhGml7xxTkNfAnsEvktBECCBV9Of39mNkEwnuKWhKEvsw==
X-Received: by 2002:a05:600c:34d2:b0:431:4f29:4a98 with SMTP id 5b1f17b1804b1-433ce4c2319mr24740675e9.20.1732287148506;
        Fri, 22 Nov 2024 06:52:28 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432f642f15esm117534725e9.0.2024.11.22.06.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 06:52:27 -0800 (PST)
Message-ID: <a326f5ab-f36a-4210-83ff-0f2ae9fa830d@tuxon.dev>
Date: Fri, 22 Nov 2024 16:52:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: atmel-quadspi: Fix register name in verbose logging
 function
Content-Language: en-US
To: =?UTF-8?B?Q3PDs2vDoXMsIEJlbmNl?= <csokas.bence@prolan.hu>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
References: <20241122141302.2599636-1-csokas.bence@prolan.hu>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20241122141302.2599636-1-csokas.bence@prolan.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 22.11.2024 16:13, Csókás, Bence wrote:
> `atmel_qspi_reg_name()` is used for pretty-printing register offsets
> for verbose logging of register accesses. However, due to a typo
> (likely a copy-paste error), QSPI_RD's offset prnts as "MR", the

s/prnts/prints ?

> name of the previous register. Fix this typo.

