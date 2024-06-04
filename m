Return-Path: <linux-kernel+bounces-201200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDA98FBAD1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FD0B1F22D94
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E21F15099C;
	Tue,  4 Jun 2024 17:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dZ3ClPgP"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021D214F125
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522975; cv=none; b=HNe003nLIaqJsYm6t72Wh9PzYNF94n7keab4utrNsvRmFx4UIA4UlUg9gmK6TTTbbRAHKgEhPGqWnqpucMuCAapcantcpJsxkf1VW7BoHV81uNLdZdxejSjx+ywDXXhi0gRDBl9siruJuXjUThT0gEK7c8zyhkR2D5mjbt7Pijo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522975; c=relaxed/simple;
	bh=OLqVA6Lr6AXWA6PthG7ToqVqZCJe1M5rtwRfWlo6chI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dfUuaIm/7X7p2L/jbn8MIEDMOi6tpzovlVo9jNVMtLA3QWssi4WwZ2/kpPrrfF4AHNXhCipgoGCgjGzHuawItZ5cd7C+wkgZJNUybegWbYkp5k8tQczwS4dRh2dt3dvpEYVHednBcnanRndMhMTK6JwlZ3tJkjB6QgecaNgECN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dZ3ClPgP; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-35dc9cef36dso4950986f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 10:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717522972; x=1718127772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CUDUkB0yPn3kyHBF8xhR/h1d7c4PgjXWcM1OaQiMS8E=;
        b=dZ3ClPgPlMkvZka/mvj1zRu0KZs9YYMnNkTGTXpXUiIKUAswye6mAaWB9iKPrgoii5
         INoKh2JwMTizK+BfPjr0hRsQpjlTDUPLNyTkgEyrzpkCaeG5AUnD0j0WsYThMJ0oN4Vn
         FhJUCzpUejU3mLCtTcZ0tVlDerl+gmzs/gaxJv+/0+GA5yDAgQ8jGASfiiDet0xxKVdy
         /b2DQQehKoCOukUEiQp3DgcW62OlQjKoiCdP2uQRUzUq/K0umH6YcZ6kem6YWv0Gzoga
         DYXJqH+Ycn9e6PqyNd+77U8I7/85jjP4CQuPHgULdrJstEVlovu1GWee1N+VH1aX5Frn
         +TDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717522972; x=1718127772;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CUDUkB0yPn3kyHBF8xhR/h1d7c4PgjXWcM1OaQiMS8E=;
        b=OwdfXZhhcSCvA2qJspQqaLBIEG0A/7zHhtpHnMfzy93kMkJqcJVcwMGD4TJyASD+v9
         mAPep2UvXI9LCPk5AjYtxw5T9OC/qBU+FdJjYsPkO2dDZ3zgh1aXv9nc7f3KFgc0kC3W
         IfHkHUl6uNXXIS/5ZhK0sDM0ZoG+E0Jh4PfRZYHIIykxiSw7JdlB/mgE4SqPBMrtY4Az
         ZbM2hUwAC8pzUxS++1y5gfp9ZQBOfkiRGu/VeSiMvQk9KiA3zCZhRrPET4wB2hTRenEc
         sMQyj45DGNMsFkjxspDUZGl1h0uQBfAdRyRz/hC0Rqg51ZkpJiw5yLGjPd4ylKfcKJ6y
         1hrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3opcDDJigl9r0bK0nR1eW07NataRgTBNR0EG6kRUgvToRStl8NMRK0or/dga7TuJXWoFusaahUKbQIiQzTIg7PhBGRTZH8p51y9xI
X-Gm-Message-State: AOJu0Yz5QtyZ10P0m/nYSWjHVgB2YSm2n/23GN19E1tO8ouNYfIZYOaj
	vm7/W1YfmEFgH/OYH3Qt8BN9D3U+ngjaZPfd2r1Ccgv190ZDK09FHHGbl+SfUmE=
X-Google-Smtp-Source: AGHT+IGhKXEdUROFwRvvnHW7fRzNnhSf3T/ROeeU1mS/Kbg505utfgtM14I+vys8Mdd+aRFjeUo0sg==
X-Received: by 2002:a5d:64e4:0:b0:35e:8099:67f with SMTP id ffacd0b85a97d-35e840677edmr121290f8f.16.1717522972206;
        Tue, 04 Jun 2024 10:42:52 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:e559:5ee:5c4:82bc? ([2a05:6e02:1041:c10:e559:5ee:5c4:82bc])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35dd0633791sm12267406f8f.72.2024.06.04.10.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 10:42:51 -0700 (PDT)
Message-ID: <44ec6537-7217-4fb5-af1c-900de7b2a97e@linaro.org>
Date: Tue, 4 Jun 2024 19:42:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal/drivers/mediatek/lvts_thermal: Remove filtered
 mode for mt8188
To: Julien Panis <jpanis@baylibre.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Nicolas Pitre <npitre@baylibre.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240516-mtk-thermal-mt8188-mode-fix-v2-1-40a317442c62@baylibre.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240516-mtk-thermal-mt8188-mode-fix-v2-1-40a317442c62@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/05/2024 12:44, Julien Panis wrote:
> Filtered mode is not supported on mt8188 SoC and is the source of bad
> results. Move to immediate mode which provides good temperatures.
> 
> Fixes: f4745f546e60 ("thermal/drivers/mediatek/lvts_thermal: Add MT8188 support")
> Reviewed-by: Nicolas Pitre <npitre@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> ---
> Filtered mode was set by mistake and difficulties with the test setup
> prevented from catching this earlier. Use default mode (immediate mode)
> instead.
> ---

Applied for v6.10-rc3

Thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


