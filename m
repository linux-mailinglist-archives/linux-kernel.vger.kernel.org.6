Return-Path: <linux-kernel+bounces-298407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0895A95C6DD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B80BF285895
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 07:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AD31428E0;
	Fri, 23 Aug 2024 07:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S1a7fTeB"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5996F13D893
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 07:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724398977; cv=none; b=HfjoLSiEmCoJr1essitIiOgo1xw1qAOWEN2tCDpssFR1AtiZlKm89XbatalKbyF5QU6gD19IwKyEDKV2C/8Hu04vPaO1HuZoGnxkK3ygCbRwwlgld5PRkp3g0fwQWlepLqg0oqznMyFf/56o8fVb1EMlw2ox1/Z36SDn0NOjBeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724398977; c=relaxed/simple;
	bh=++WkiVdL9Z2PtHWazg09gCpk+JB86tmXtiiJMLg3oqo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GWKVG4gqv7NrcCrSJ7keHT2avY8Tra9wTCEpeSsS6fkmnaWLdeFjhK5gypunfSKMvyYTsaTPXSx4TXOALHwTnfv8heJBNB6OUPLyiNl78uicki/1sRo0t2TZokpJqNsGqEJjHvQ0pRZXXr3OIhOP40cMepnQjpubfZVUSI6vEUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S1a7fTeB; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42808a69a93so2964775e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 00:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724398974; x=1725003774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLWiFtCjSL78CQ3UPXlCQZPCZIJyhrFFQBp5jT+5NwY=;
        b=S1a7fTeBBwlwL9Nq33ZjxImrGZD1SYd/QLGShOrejpleWDdkc0pbION7fmGv26FK0a
         /2hbQF7PDhm5oxYP/+C8Tr95q9L88bEgfgZlyYULXBU1Kcy9MtN7ldH4/vmqpHU7wrsy
         7QaFwUo33oHAbM9nwA45w+cXbHGSO/wE5qAJmXG6lnHaVLdOG0BLG4grVcyI9xpl2huk
         eXAxZwlQy8cFCpcaolN6rva1aikIm9ylMjTuWx7iAIFSDJL6qXtPfRxxpwzxNEW25FS0
         e8oHi1lZgFoIZ6HZGMWjZjUrcaBIMICkfQV+WEZN5DW7LRnbBi4uQw3bdamoPp7sKIgL
         8REw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724398974; x=1725003774;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLWiFtCjSL78CQ3UPXlCQZPCZIJyhrFFQBp5jT+5NwY=;
        b=S6CtA12DtC7L65JE9KUIzCEfyM8Y+sm7GPWopLC4GjaxAP4AETQlpCB+G1oVim4CvT
         0cnGyJz33rZL+oGCj/HvVPQupax0/249Y8kqvrbuoAPqqueHtSorWbrINA1WC0KMl+lU
         afpO8X+lowr9dmK6dw6E22q2/SOGbG2fRyET1NrADubx/4BnE3RjFniQ9lCssouRf/0q
         zE5SOGMdXkKUIHOqlQNuT+kCTb+B5hwK5dJnuRzT0TcuFT+oC3qABo0byGvLHRcHgcow
         NiSvFs/Y0eihj4V76QUTaoLYxJKlpE+v83nmKcuVqqNiDpBZHPB/JQDjw84c8AiHhs0t
         LRSw==
X-Forwarded-Encrypted: i=1; AJvYcCVuqoVmhbFHyBmSYbTTCBSFyuQwDlAByDRsPLKjaBKg1D48LuuARNKF8lAsESz47vHntUMJzlJqUgSOOJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YylW5MOSZsX5Oa9n6OJTcjxkXvToa4ZPacS5BEv2bTDB+8OGSfK
	wpSgh9kIvtTNHoK31sywYIR6UuNqKfyWX8jHpVtyF5UOaAtn6LaPPciihf12QlU=
X-Google-Smtp-Source: AGHT+IER5+q0SoK0e092RXOa02/lekajxpcF4iEz1XnizK8El6GyVz/LwKVf0lppoubRCW7lDmvqDQ==
X-Received: by 2002:a05:600c:46d4:b0:424:8b08:26aa with SMTP id 5b1f17b1804b1-42acca01063mr8754545e9.3.1724398973564;
        Fri, 23 Aug 2024 00:42:53 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373081ff63esm3485541f8f.87.2024.08.23.00.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 00:42:53 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sunyeal Hong <sunyeal.hong@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240821232652.1077701-4-sunyeal.hong@samsung.com>
References: <20240821232652.1077701-1-sunyeal.hong@samsung.com>
 <CGME20240821232656epcas2p27c080a6d52524b222428931697390aad@epcas2p2.samsung.com>
 <20240821232652.1077701-4-sunyeal.hong@samsung.com>
Subject: Re: (subset) [PATCH v9 3/4] clk: samsung: clk-pll: Add support for
 pll_531x
Message-Id: <172439897209.16898.1400754032970597946.b4-ty@linaro.org>
Date: Fri, 23 Aug 2024 09:42:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Thu, 22 Aug 2024 08:26:51 +0900, Sunyeal Hong wrote:
> pll531x PLL is used in Exynos Auto v920 SoC for shared pll.
> pll531x: Integer/fractional PLL with mid frequency FVCO (800 to 3120 MHz)
> 
> PLL531x
> FOUT = (MDIV x FIN)/(PDIV x 2^SDIV) for integer PLL
> FOUT = (MDIV + F/2^32-F[31]) x FIN/(PDIV x 2^SDIV) for fractional PLL
> 
> [...]

Applied, thanks!

[3/4] clk: samsung: clk-pll: Add support for pll_531x
      https://git.kernel.org/krzk/linux/c/9224e288f2e1f9161cf0c54122ac9168b6b68877

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


