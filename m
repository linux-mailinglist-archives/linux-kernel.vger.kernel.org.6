Return-Path: <linux-kernel+bounces-428800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D78E49E139B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 07:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CBF7282951
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 06:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52F11862BD;
	Tue,  3 Dec 2024 06:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z2AaZCMF"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D83186E5F
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 06:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733209064; cv=none; b=cgDPNkWpayu5L3YFm4ac57sNrjRFCbBVqcoB5ZFUh4j19GbxJuH9yzbu9Oy05fwq73GtHS9nD5c8Nbvf4wOcZs03b/ATXclW+40YfwLJLt5WArnsHZPFMDcshbP7gQsj+6atgYh/6mdj8bl1DngO8wIgH9ADkkmhHLEsjAaIu3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733209064; c=relaxed/simple;
	bh=eVFLB+6OBC9CZT606g/sbUfLAfNYRu7/+f5lWtBw8fY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LyI4/GgLP+x+WSGToDTNT7kxKjA8kbhxG+Vhov7Wbe+2MAs1wV5rsnmBXWYUhX9dNLDSpKAWcA7Lc3a7OVNuoM0Q29YuD0dwa/ZJ9sFTi9i8VThIVokunc8r02/oBzRVnFOVbGA5Kb+fQ8Fnb5D4bRjEKZsC3MDTvzHBup6sa7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z2AaZCMF; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434a8640763so43837105e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 22:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733209061; x=1733813861; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eVFLB+6OBC9CZT606g/sbUfLAfNYRu7/+f5lWtBw8fY=;
        b=z2AaZCMFOpm1sERIubzv4dZxQM7d8dJN2yZ0s+uAFPaLYZXvOi23yIfCHG5LN5DD1T
         y51mLbzztaDq0+d1/H94neNYD8DENlgO+tVvf8OkfsMzdes5oz//HXsBTVUqAqGvSY9R
         mYnJ84U6K8zuXydViIqveCvJTeojDNMpJl/xO7UpgJsIiygKZ08AXe+By5RcsFtmnV79
         gDR1FIZbwVXtCZQzGFtkTuOd3SQNkXLDpKXLZFu+6oG8Ypzd/8hvubRf2CIh8C+una/u
         oS7XWjBn5PZgaWnmFpMC2xSSwDzFg46m6J+WLm7gK1pRV5GtIFDmz99LImfigTvM2vg6
         ZrAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733209061; x=1733813861;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eVFLB+6OBC9CZT606g/sbUfLAfNYRu7/+f5lWtBw8fY=;
        b=X8Drh4PoedfvwRXMtqJZiPKstU0a+9d8PcVXfA88ur0eJPsHAqSZHsXrLWdBqVsysn
         du4LLuAiS7qzuKHp8zhKRUTA37Ibzci5gVErrv4LJFVwppjAYE7HUnAEb8kjLB+UP8Lq
         /xc7CtNydz3CDDzcXJE1TNsZ3aez280CZM3Jirj8znzo9s9PsEb7IyxwafJW/pSebpGx
         ePZR0jI72ZiPVJmP0Nr7tqX021Hyx4FTdb+duIss6IhT5TEgIoM34oUSsctVuvbiBNwD
         CI+KG6Eef+aSj2tw2TmwLGZLl3wOfWvM/BWcp6bFzOjxHZoC+JaUgjXoJxPMNHtTGP5J
         GSRg==
X-Forwarded-Encrypted: i=1; AJvYcCVw4U/X1eTO5RRUkxtHgKa/NQSmSzlJGFlt+wIbJYoecVk73E7GkVJPnpC3uJuMCXZNoGFRu72juTeECno=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAYsWpaKagYh2NfWJM4sBRPFCFYLvjlsZH48RU/hN2wIRPkWd/
	KAC5D2cYhf0kBUAx8NzeVeFLfN1zHlLOg9g1uKqfICGhkQa5f1kKk3Uz8x+zGKs=
X-Gm-Gg: ASbGncvMsWE8iaOv7U/+MsYpfHer6To7Kryjh6sEninqhRMER5mbdOZ8CQHapcfvMDK
	RaKV+5RyKOTGklQ9FBXfMAwqVeRNq3ZiltwPnJA0yQF1rY9IusGO7BLKrnR0R06mVCs0GYGB7vG
	E03LZT5CBxJn76lvZN2EtALYTEgurvnTAI7p0/bcscw3PVV4EcUDwEQ5uHN7CHtCc7MVZK282bq
	mhMCpF1PePnQf1T3O6LZZDcOK3VpwCA1vYF9NtvdUSrxraSQdIgojI=
X-Google-Smtp-Source: AGHT+IHBAYAD3b2nuutPCc6vz21mpmvr9yIOVo8l4J3kzBSf1gujYTEow9QfmlkAK91qibZX9uKohw==
X-Received: by 2002:a5d:598b:0:b0:385:ec6e:e899 with SMTP id ffacd0b85a97d-385fd42a804mr907858f8f.59.1733209061057;
        Mon, 02 Dec 2024 22:57:41 -0800 (PST)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ee60549dsm6267059f8f.34.2024.12.02.22.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 22:57:40 -0800 (PST)
Message-ID: <fe254a002000f2bbfbe51d074cf28f7427a27f9a.camel@linaro.org>
Subject: Re: [PATCH 2/4] dt-bindings: power: supply: add max77759-fg flavor
 and don't require nvme address
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: t.antoine@uclouvain.be, Sebastian Reichel <sre@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Peter
 Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Date: Tue, 03 Dec 2024 06:57:39 +0000
In-Reply-To: <20241202-b4-gs101_max77759_fg-v1-2-98d2fa7bfe30@uclouvain.be>
References: <20241202-b4-gs101_max77759_fg-v1-0-98d2fa7bfe30@uclouvain.be>
	 <20241202-b4-gs101_max77759_fg-v1-2-98d2fa7bfe30@uclouvain.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-12-02 at 14:07 +0100, Thomas Antoine via B4 Relay wrote:
> From: Thomas Antoine <t.antoine@uclouvain.be>
>=20
> As the Maxim max77759 fuel gauge has no non-volatile memory slave address=
,
> make it non-obligatory. Except for this, the max77759 seems to behave the
> same as the max1720x.

It also needs an interrupt line, and the previously mentioned shunt-
resistor-micro-ohms, and probably a power supply.

Cheers,
Andre'


