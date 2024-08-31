Return-Path: <linux-kernel+bounces-309952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14954967260
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 17:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCFB8B21948
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 15:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B41F24B26;
	Sat, 31 Aug 2024 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="REX5TnHI"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F631CF92
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725118163; cv=none; b=ivOIb47g/JfwY9fDspMi+jbrvJUTVA65Yjj6OaId2ZK7ZJXKFP4/a1kocRqS7UB3ftw4qrLuRerprWTw9yju/OgAWr4y1pEtUKQfgCnq27BGDIsmC7DeqvnGlLYno/M7eqe5YriLedCqTtaZkyFGt6xxgblQ+srxPVuRQEikANs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725118163; c=relaxed/simple;
	bh=o1dbJ86oCg3TnnG/1I4nHOQNnLyWx7i6Cy0GoomQTZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IBbG/kI9JQ2+8FgcD20ekNuG465UcOUsqywrZnYiTIwAKxkVC8GMwPnKg2KbECLVRAf67e3td1OII/Tx4GuRUXWNx+qlGB3ep91KD9O6wSOoEXGdqcQ24Z+RSGMpO7j5gqXe+KrHNoF0fnUrMm9ROjchWI5Q+NntxL0tzHy7L2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=REX5TnHI; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42bbd0a40faso12468255e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 08:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1725118160; x=1725722960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UqG1I3pLaErdof2yFJozBhLe1kftcjRzLM7E0m6PE84=;
        b=REX5TnHI0SnXGB1TRdsTu6ZPQUmX6yYd0pi6vfLhWnsNdcyHvop0HHH8SmKUYoHGaS
         gXjBnQ1LDG+De2gcmZIA0Ukd6xX8QZHDbEpCIy3MXXQRCDtwLZ9KEOLPfunVYBPwHcqo
         k9izLy/Xbu7omzOUKtBKmMOp/aAUqYl6z42r91WlVzJEbsXROplT2B8hKQJ1WkDAdF12
         uOZU2TsUhYiwK/NLIqy0c1205zu8xRecuoC1jd5a4hUJpk8/J9p44TXLaQIXWJbPR6i8
         5mEI7T+C9iSKx2jcXynu7XYFvmp4rO/u8L8A+5aqa2aBeOjLcY67vO+kL6Nll+vP9d1e
         GExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725118160; x=1725722960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UqG1I3pLaErdof2yFJozBhLe1kftcjRzLM7E0m6PE84=;
        b=eRXxLUs/WBW60Z8WbLR2KO2gqHKJL5Ko2YXjMkmgn6AOWE4CxEcAxytlFRDwaqdA+k
         QEdl47nXmuaZY9h9HCoLhJcheHfvv3B4jQqnWuQAs5BFT/OKydZ/Wyb8H1jLo4MWtvNZ
         4NF+POP0hK9mWedlJWP6xjbOGaQPfFtz0DEBJpnzqrVSiFH95tBbD/eKDA6NctXvCtfY
         B0+FHAmPA1oNnYU2RFpho1/c4Ft10aipw9hAob46lX9UWg0XiFqh8pplEK/w1LnkTrEt
         6eJ72W7nQhpqxAof1OIhB05ifoId3ZAvb4FKPcR2qQD4E+i94TdfuDlU517XRcMdO8yu
         m1PA==
X-Forwarded-Encrypted: i=1; AJvYcCWewMKQO7CyeWLfIgvXuh0/dapqDNMhHWLaYwr8ZUMoycZPaYZ2hD/QDCK4pA6gptV49vPv5Aj1N8e4zdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUytfizVrnCHOq+mpf+vhCePWRz0oyxkYt9Zi8aFR9Mrk/RS+4
	5jpFFzVrAgD1wfR+nICPvYDx2uCJv0nav7p9xjY8E5qP/MrXtELpDJADCyV8A+o=
X-Google-Smtp-Source: AGHT+IESNe5n94eeHhugi5qWN5pl2DKDZXFu/lA0O12m9FDrhevLccPAvSA0hbLSDMP8+QtD5LvSqA==
X-Received: by 2002:a05:600c:c17:b0:426:5e8e:410a with SMTP id 5b1f17b1804b1-42bb032cb54mr66335135e9.24.1725118159111;
        Sat, 31 Aug 2024 08:29:19 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749efafd65sm6781328f8f.93.2024.08.31.08.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2024 08:29:18 -0700 (PDT)
Message-ID: <fc488ade-4ced-472d-83d4-505d7fc73a27@tuxon.dev>
Date: Sat, 31 Aug 2024 18:29:17 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: microchip: sama7g5: Fix RTT clock
Content-Language: en-US
To: nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 eugen.hristev@collabora.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240826165320.3068359-1-claudiu.beznea@tuxon.dev>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240826165320.3068359-1-claudiu.beznea@tuxon.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26.08.2024 19:53, Claudiu Beznea wrote:
> According to datasheet, Chapter 34. Clock Generator, section 34.2,
> Embedded characteristics, source clock for RTT is the TD_SLCK, registered
> with ID 1 by the slow clock controller driver. Fix RTT clock.
> 
> Fixes: 7540629e2fc7 ("ARM: dts: at91: add sama7g5 SoC DT and sama7g5-ek")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

Applied to at91-dt, thanks!

