Return-Path: <linux-kernel+bounces-342597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C99E69890BB
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 19:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0C11F21734
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 17:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A4013E41D;
	Sat, 28 Sep 2024 17:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAUKr9uj"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C161E531
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727543938; cv=none; b=KgJ3B+DK30s2EpTQ2ld93ktCickrQtqicjgQfzA2NjWo5EiHe72mA4WrH1hOCsif8XxOFMALumd+4yO9WSfdm9I9TbUGZGAGPFVT4ZXIBVYZpTQokZxitOb/RaQ/cm58bVjHVwq4x6CuJIu4QLsr7kOlrL53MF6LfVEbHBSrifk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727543938; c=relaxed/simple;
	bh=bmACG6HxwU/7dSN0MbjUmSLFCbNcVmTMUVQp1EVGmJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A/BG6YDdsB+LFEEP6IIDQiKlu79ETCTCBDsovMY3rbvkHK0VX35IWaWqK8BR1PTNj9lYY9bZuHeM/3ItOUdDDgx0u/tQ9RBqKV3h8tGyruhnHlDXQNgMq7x4r9NjORoaysCAw1kOAlbds0CN7OODDzc+jWWW7+d0T97e82nP5CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAUKr9uj; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso29598535e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 10:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727543935; x=1728148735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p8NuiYSt8wJAr0VVOHDlVqwMqiURWjiBsLWVHXGngnA=;
        b=UAUKr9uj/2w0m3CMDUH4HiIIJWJtfBLm3BQnIB6d3DeAzcDwfT5pHraxrm1Odmm4QI
         f718U6WPm5/AenyhFfB/pq9DYxzvNPXJG2zE2bKLM3mIO7Z41ZFKOieKIzriVNReZule
         LiX88JN13dtuFQJzV2ngp2+37KnTmwcqYIW8Uxf8McEdS/7ZazLkmzLGkqRX+7T2JSw0
         PNaG0wymt9rsEjJTtodvq7IgGM4WDdr3VNc6rlmc1Vt5vb982ks54A6ewiRHmiJLHduU
         +t9qdhzMWeZNAWL3kQBWA1sUOdAAYQv+ooj4tdQUYMqGqZO2Q1XQmqSg4iFCiqydVgPS
         oF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727543935; x=1728148735;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p8NuiYSt8wJAr0VVOHDlVqwMqiURWjiBsLWVHXGngnA=;
        b=cowavs1RGme9ksok8/itP1IqDRXt+wTH0m9OAGwH2W4Ai0tAB9lUwbZdz3+3Pta3Un
         KEQcmtEJm3PnqjpuoJW0yzHk0aN0YE7hwbvO69WbRBZJA/+UkKY1ZJMs1aU3hiBg+wBY
         +FjDatup8LxTZBwct0G7BShg62gs7u3gweY9RWvbOzUKIK2wKirkwjFIgjN3GJXOlzMs
         WlfwJ9xGkMrw+urVsNvLDbUcTErruH+NMXwkr1yC8RmWnw8PmAUDU/AoubLRfD21lsO3
         9J69pyQgmlhUo4HGZA1KfiKSDDOsIGrgO+Vx2+KIYuVUVF1aSsU3kt45gq9wX5u/Hbnr
         iEkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrjnuqbCIWS/7D0cbGTf98z63n7KujM4OlGzeLO6VVhhOkMOK0NIPlahab2tmsdBggV0mNjW+PT0GvYcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS9xPGxoSnlUtALwV93JpheMpsGacBBgBdWRw9SgCN5uJHwByM
	2c4RkY409AhkgvDIo8v5Ay3su7XNsgqGFt/B2JuVdGT3ivp7l008
X-Google-Smtp-Source: AGHT+IFmmIHk7jMGC1Rr49hdZC3xWIHG0TdbmxVJ/tvIZRVpiLLGzZ/mp8cIHr9g4anhuMyAjTK08g==
X-Received: by 2002:a05:6000:d8f:b0:37c:ced2:843b with SMTP id ffacd0b85a97d-37cd5ab75fcmr5003739f8f.20.1727543935169;
        Sat, 28 Sep 2024 10:18:55 -0700 (PDT)
Received: from [192.168.0.10] ([178.233.24.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd5730e92sm5262538f8f.80.2024.09.28.10.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Sep 2024 10:18:54 -0700 (PDT)
Message-ID: <5207019e-5059-4721-8ac6-4f4ea2753643@gmail.com>
Date: Sat, 28 Sep 2024 20:18:47 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/3] Fix degradation problem of alpha blending series
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Shawn Sung <shawn.sung@mediatek.com>, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Singo Chang
 <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 Jason-jh Lin <jason-jh.lin@mediatek.corp-partner.google.com>
References: <20240928161546.9285-1-jason-jh.lin@mediatek.com>
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Content-Language: en-US, tr, en-GB
In-Reply-To: <20240928161546.9285-1-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2024-09-28 19:15 +03:00, Jason-JH.Lin wrote:
> From: Jason-jh Lin <jason-jh.lin@mediatek.corp-partner.google.com>
> 
> Some SoCs not support pre-multiplied pixel formats and extending
> configuration of OVL pre-multiplied color formats, such as MT8173.
> 
> Fix the SoC degradation problem by this sreies.
> 
> ---
> Change in v8:
> Remove blend_modes for not supported pre-multiplied SoCs to fix the
> return error from drm_plane_create_blend_mode_property().
> 
> [...]

I no longer see the warnings I mentioned in v7, and everything looks OK
on my MT8173, MT8183, MT8186 Chromebooks.

Tested-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>

