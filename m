Return-Path: <linux-kernel+bounces-300085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CF995DE96
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 16:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D9CB283095
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 14:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B70176ADF;
	Sat, 24 Aug 2024 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="j0IH/FDH"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F17154BF0
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 14:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724511228; cv=none; b=mrQdkXPBce53Luy9BEOCzfBfLH8nVepZPzFLrrE81pNi0VZc9Tbu5qSjixQTHGtXKcxcGUaiXjgxjDqksjiSgR4g1Yy7zKds5COTNyFyvuUTr/U4sWtnprBh/Ice4wN/FCmb3MeKCfqo49GI5oEHF7CCXoX9aJTO/VRPVxGfYAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724511228; c=relaxed/simple;
	bh=/JsEau8brkLXr7oKpwfXPD6AUQJCnf27nPEb3S56Hr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dTlxyNddTYOo01+P9k9cedGcCY6LFMBt/jS4lKVakrEO7WMNB1vkBodEczP45ynuXiv3zS4gK96sOszd6tcdPRlq1zjm5TFSrxmRMfEM+lWffueR/fQsjvfSWWhHhS49O2zv0Fs30fhdpsThHGpYk0sMSYbCCpsm21NAdSoTfzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=j0IH/FDH; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso35480781fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 07:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724511224; x=1725116024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l62ZXkDjkO/9RbV9AkhIHQNaZIShFDlH2pL9xxXwU6s=;
        b=j0IH/FDHVskWTIgSuDT0wwu4ffEWdAsV6A8d2pcVQx+4RH4F8ejX6H53KJWjlphpRn
         Kw6gBGHMejB80y/ndBa8zOufEBwiTQEcviQb7GIGc1XajiJBwwvLgsxnMvti96yd8CQn
         MhzGz6x0B5hWptL99g052BYAU+LxaWNs+FZhNyWG+RpiB553KYMbdO3Qga337SeRIHoE
         Ra6WEhffWQ08iHWgd/MRkYxWcwRE1Wd6o3CN8D3KwrEUFPR3GBqLu31fGS3tnaQTH7Fj
         XzYdov/ZoG6fQxnVuVCz4rE3JOZKJcRWO3fnNpN5gCA6+jcVzAc0X0rCqlvpQ/TrmLL0
         iC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724511224; x=1725116024;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l62ZXkDjkO/9RbV9AkhIHQNaZIShFDlH2pL9xxXwU6s=;
        b=k07bic9TBKED4ee4MhRzY7DOgucnW/GtLxY3UeKBMTlIK+5BNHWh0VE8Cx6KXlbxfY
         2476IDbBg473yiaERviMPkNgdAipdLPXqmi9l00NEZsvP7H0dldp7uVYwWLNTFpgjMsL
         0qcMHTK3x2DbwSvSBUiZfWBKdrzoChuHFZ0/JGiMnNKNxM3Uq19eUxpiIcFLKCYO7zE6
         Th0lK3K6RYmE/sOX3imVIJxmv8GiQ+5OAz66P7QZ2XBudLIHwI8/Gb3naHgxhboR4U43
         E5mYhnlMLfnuZlyQeXj3KrjFqpa+oY1ouXctX+1s3GdhR7cR6ndGq+0EwdwDYN7Mhm/n
         xTFg==
X-Forwarded-Encrypted: i=1; AJvYcCUjclx1sMiTZxxZyWyFZS19L2UkHfhsYG9DhaySYu2gFwhL2ZcbXU4BAanJ22JTtSf2+4JlIjEz4jxQIP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT0QVFqDDJYDtAvaHx4bBYhL9ekWZwG2ehuRz1Bxnbv+JiKktg
	t0rILqOChUFTjFljp/vEHM1eYiOIKhVLU/o5JuUHxfcTCsJ+nhWhpLpqDC6GuIs=
X-Google-Smtp-Source: AGHT+IHWbWqgdC2nPGTjCpSG2/Yy/IeWdZQTtHHgJtiQJ7X0BY6UfL5m2t7msptFp4JJayuged9ZpQ==
X-Received: by 2002:a2e:702:0:b0:2ef:2d3a:e700 with SMTP id 38308e7fff4ca-2f4f5754e91mr38772991fa.18.1724511223545;
        Sat, 24 Aug 2024 07:53:43 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f433671sm409703366b.128.2024.08.24.07.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Aug 2024 07:53:43 -0700 (PDT)
Message-ID: <5665dd6b-59af-4106-888c-67b374b9f7ca@tuxon.dev>
Date: Sat, 24 Aug 2024 17:53:41 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: at91: sama7g5: Allocate only the needed amount of
 memory for PLLs
Content-Language: en-US
To: mturquette@baylibre.com, sboyd@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240714141315.19480-1-claudiu.beznea@tuxon.dev>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240714141315.19480-1-claudiu.beznea@tuxon.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14.07.2024 17:13, Claudiu Beznea wrote:
> The maximum number of PLL components on SAMA7G5 is 3 (one fractional
> part and 2 dividers). Allocate the needed amount of memory for
> sama7g5_plls 2d array. Previous code used to allocate 7 array entries for
> each PLL. While at it, replace 3 with PLL_COMPID_MAX in the loop which
> parses the sama7g5_plls 2d array.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

Applied to clk-microchip, thanks!

