Return-Path: <linux-kernel+bounces-435505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7729E78B9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29DA316C119
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D18F1F3D39;
	Fri,  6 Dec 2024 19:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="KPr1iBy0"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A05B154C12
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 19:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733512697; cv=none; b=HvzJL/Bm2h+1QQShcxN6KSOXy0EQEmymWl9lT3i09AJbywsPZeC8to9mwy35l5nWkcitNjaV92AY39dkjabFqGqoRvKt/kstwgUjp0H8l0X6Sq3WiJ1DiFIUUe+SBzrG1MHnrXCNaCL8HBzNhiH3GmyO8lcwlSkyb0NcmMhlQtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733512697; c=relaxed/simple;
	bh=XXEsKHStx4nAG+6QErJ1NiHGu6mTByr3YcI0FFX/DLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=boLoYEoBm0svvc8A8MYAIHWjGnn5HxY84xq8YXD7X5DUTj07G9MJdI2ncCF2ig6QZqMjO2gjray4HdmxLbxXb9Una5pa/tjm+whH/bqebCWt1L5vgSzmELIaPsEjLY7QtxZmH4VQViGPewRRJRYg6Sq8Mw1fdNdcW3WTFYNcMoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=KPr1iBy0; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ffe4569fbeso33772221fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 11:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733512694; x=1734117494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XXEsKHStx4nAG+6QErJ1NiHGu6mTByr3YcI0FFX/DLg=;
        b=KPr1iBy0FrEE17TDfJQI2s6Azr173ocp+ycFX4CUZxKV5QPV9KWtlZzC6qYpo35+cg
         3ox9ve/sGFGjdcJugZFImoC+fRQMDPkWo3c0OT3eXyUSUZIIYibyvPY8rDNfdIRp3eQF
         0H0DjYbEGDyr5Bvc9MgduaD8atznpsEd6UmeGOjaa41KxWLTXsSEQyG57lNOZtdoenJW
         udM7+1qdBwhOIthO6cTpCNRazUhVYTvZfkZdY3GC+xRKlP9Ma7yoK6m3TYaecr44ZDBO
         C1f2/hijYyM8YmsIYcUJrHBOlxGtb+ZQaRJjMzgztALJiT6A9TQzSt2vZffRKNrTQfDC
         jAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733512694; x=1734117494;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XXEsKHStx4nAG+6QErJ1NiHGu6mTByr3YcI0FFX/DLg=;
        b=Eas8uscL1Hd2NMUI8FnUDFMna3S+tnP57xjWRSNLDp+PQI3/SjeaSIlDzNyPC4Iadp
         Ppg3vvtKFeNyq5f7jrV75txHhvuw7VKst3pGajXiVugu/9KZiLfOytjIozqkIZZ5jDJa
         6+99krZxWf1X6aoJ7gK1DhCQ2fmbasPsUV2F6J1xznuKBl4AHgpamKrGV3QTZFhBZCJl
         NSe5Xv9LFP/aRTchThVWvAyG3+1yv6Pi8/pn8pej4wokinX9oRUdlh5r2Ur33sPii3SM
         Zc78QOKomVMHrv9Yw9DjQn38IS7bxaT6vinwJbIazPcJPFGvK3h9oGK/U3Fch4yHpyZ9
         88tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdnfHsnIyZ5W0Q2RmL+n1YOLlAYy80mF5ig2qVG9jke9xox9y43Rl5MXd/44mEg3EdHW4ACzFnVXz7X28=@vger.kernel.org
X-Gm-Message-State: AOJu0YziMbT9KxtVIfAWArzKlOa3Fy38Kdo6vcdienf7hk9Az1MbFwJG
	LN3dyv69ElH1p3vQCpTdJwXJvqIeTYoOod8OehjoL2cDzh6k8Fu95aRVlCxLu1g=
X-Gm-Gg: ASbGncvKbYgx8saTuWgiqZU2PmlHl2iQA/GnC+hA/iX/EAodyz5EPCVhVme3yr/5wwi
	vHxNBO5tm4fESJazGQRJwnCH58vyJf2buTZQCiA8nqtX1GSdeAzfqi13pvjhqZgwsk7wv5gr8CV
	jQdAyJhKopuAxq7raRoNzMQNkwh9SA3YqCD9MF5DcDUmrhDP1n7WGr0ubk/70xQZ2PBy9KWL9Lq
	KKgECxGRqAqjrBZQKrp9XPPMIBneuY6/m+s1X9xUYW+tNi/Uyz6ZvBjPU7//FQDddnzOw==
X-Google-Smtp-Source: AGHT+IGis4qREcli745RBFrLJcy+fcg/7cCX/7Rt7z8z904kRcAYTDaWI9H2MT/YlwbjEUPc5o2viw==
X-Received: by 2002:a2e:be23:0:b0:2ff:b3f0:68d9 with SMTP id 38308e7fff4ca-3001ea9934bmr32824321fa.3.1733512694247;
        Fri, 06 Dec 2024 11:18:14 -0800 (PST)
Received: from [192.168.0.104] ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020e56f44sm5485231fa.104.2024.12.06.11.18.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 11:18:13 -0800 (PST)
Message-ID: <b39e495d-dd23-4965-bc1c-b30db81be0f8@cogentembedded.com>
Date: Sat, 7 Dec 2024 00:18:11 +0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/4] net: renesas: rswitch: fix race window between
 tx start and complete
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael Dege <michael.dege@renesas.com>,
 Christian Mardmoeller <christian.mardmoeller@renesas.com>,
 Dennis Ostermann <dennis.ostermann@renesas.com>
References: <20241206190015.4194153-1-nikita.yoush@cogentembedded.com>
 <20241206190015.4194153-3-nikita.yoush@cogentembedded.com>
Content-Language: en-US, ru-RU
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <20241206190015.4194153-3-nikita.yoush@cogentembedded.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> 3590918b5d07 ("net: ethernet: renesas: Add support for "Ethernet Switch"")

Sorry this patch sent out broken, I've reposted it fixed.

