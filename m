Return-Path: <linux-kernel+bounces-195468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E77A8D4D46
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 15:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03051F22019
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 13:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2722D17624C;
	Thu, 30 May 2024 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ur4nqItg"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8955C17623B
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717077149; cv=none; b=XYX1PX5EZF9TK5Uhe8O97boA2FYc5LgIB8hlJmz5R5FfSSJAX+g7Ivg6BFQOaITCB5NNBHblV8IIghpu4vBY89BDhNTupiPE+IZGbMbWasX1TtGVR2tTe8EV4zk++g9QMMnigVmi1jMCvWBSYH5i/5fC0k4xpoirAlkuJ9+F2c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717077149; c=relaxed/simple;
	bh=r7Nq+l30WnAPJMcoY9sAdA5J4veJVYeW/rCzNbYA8To=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JkCq0rbX+g5S5Ac2fSEkVgMknMj9WYGBDewhzyoM/wcTLm8WwhcGTmB7QzQlHS3bHzsFIoyF6JxT/2cFE19CwEhxGwmLcWR9W5Qogk4IPPhEBmw5L6UaSaQ5O/PuqFy/w/dbendK8VuJYh07juX7zEFRRKxMWHavKhW5hCsgNLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ur4nqItg; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-35dcd34a69bso232618f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 06:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717077145; x=1717681945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z5xCJKQ4ugEjWsoL7YroP9b14wp/Gl8VnioYQ/OGksw=;
        b=Ur4nqItgT5FN41pNzH3cNluCsLUW42sh+9pI6jIt2sIgGw9jk4mPVXBNIb1JWr8ZAi
         qXSP2VwlGiUDh5igso93zJbEG8kPccH23sjpCcU1cEk8vR1JIYqScax7FU9IxMgS2g5+
         D35KHeNHA0m+oZyQ0IVWagzlGPbP/8N7oyPg0vlqC4Qn3VKUpE3PlGMFDZ4gqqDk/QY+
         Gu6ydYQcGghV8AvRSrlEHfppfSioCxxF+M9Xw7lAb2DnGrBuiqjTbZIZeJzUQfSyESZ9
         Hoaxt2hw6JVeIdiP8yvzrv+7krvdt6HEHSzElAfJQzo5lvXz9Lqd+vucwFGFgT23otuH
         NHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717077145; x=1717681945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z5xCJKQ4ugEjWsoL7YroP9b14wp/Gl8VnioYQ/OGksw=;
        b=MxeCTqdStNLyC1Z4/TUOdtM4SBwWwkGhgT7kyQxMQ+keyKfZnOQZm78A2lWkzUwelh
         35B2ikwfTHmUwS9nfgKB2apooNcz79duoS/2iSEpcQ1oaB4M86SKztMcAPalW8WXfTAg
         V0JgbUp2FdufbSR4zH5iAX/oOx/8+6GTHBwaqpbCgZorjBJGzOuvZWBM1GcG4ZL8fHHh
         fg0Vg/9VGz32s1O3xTpd0uGMuSPbWlJ7A3aISXqCRd4Sv/8J96DhB+mof+CFpazhqc3J
         uyhhqFcfkQlGUFU4BpsdgfVWV1YBy251q3RBNdcjSbH4haGtiuR8weLfGD4NybEjF/7f
         8URA==
X-Forwarded-Encrypted: i=1; AJvYcCXTcGXfBQOy2+/DhooMIHsaUbW3sRqu8pw1wi1TYGMtLuXgLMbqzMU/LQmkPiXrtHVumNVXDB0e93WZsViSxxsgptGqv1uOnc6YdnP3
X-Gm-Message-State: AOJu0YwVWHIBLvNi236th7rfdkB6v5Kq3kk+cnVm2cR5YoWJqS7CjWXe
	M5/RGqqjupam4e/ZFJOhjmnGZzxpBhock35ovEYyrzZJjomqVL7y+DI8YFv/Ppo=
X-Google-Smtp-Source: AGHT+IFc1suDxNrUDOh2i/f0r05vdv6ugqX8mGy8cQBMw1VGOc/OpcHdjJLyHRt+fpRtRE8s9RTS+g==
X-Received: by 2002:adf:fed1:0:b0:354:f815:8b85 with SMTP id ffacd0b85a97d-35dc02bd8c2mr1521286f8f.67.1717077144893;
        Thu, 30 May 2024 06:52:24 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dbdb6f34fsm2471094f8f.73.2024.05.30.06.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 06:52:23 -0700 (PDT)
Message-ID: <27d42cbd-5985-4b05-80cc-59ab21b3435d@baylibre.com>
Date: Thu, 30 May 2024 15:52:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: mediatek: Add a module description where missing
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 sboyd@kernel.org
Cc: quic_jjohnson@quicinc.com, mturquette@baylibre.com,
 matthias.bgg@gmail.com, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20240528121320.160685-1-angelogioacchino.delregno@collabora.com>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20240528121320.160685-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>


On 28/05/2024 14:13, AngeloGioacchino Del Regno wrote:
> Add a MODULE_DESCRIPTION() on all drivers that miss it to avoid
> modpost warnings.

-- 
Regards,
Alexandre

