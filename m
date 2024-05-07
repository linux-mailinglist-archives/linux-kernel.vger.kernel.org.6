Return-Path: <linux-kernel+bounces-171029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EFA8BDEF2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1618281DE7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1BD14D71D;
	Tue,  7 May 2024 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SFaB42SJ"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E898E150997
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 09:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715075345; cv=none; b=Kp+6yZyXS5zUbAvE3kdK0TA99Vz+pDGBh2MNyAl989wDLnEAvNF6izQccDSCypmxe6pBb2E9nT3s/+NwBLZDHPARCag0cpXszxZUcCwbjMKaZB8tMaoX9DLoCykFioTJyhl+FLq3te2B6oFJsluuOl96Qma9wmdR7RjhKMlZ5k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715075345; c=relaxed/simple;
	bh=lxtT+tCI4jL059QQESghZnrZukScDPtHohLDdzuOYBk=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NeVA0Q0QGRP3vGWyp31fHgDAImUk+ffZntG/1x4rctotg4br9rKpMiJ31mYkicjqaGAOYWXsRpE1vBqQU+4ur6PJ0a17iTRoLhSwIifOQXIOP+9jx/czCnpOIF1Duko1+wpic0kDSCk/LdAJEiWgyA8vO9Nr98owfSnKXy7In+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SFaB42SJ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59ab4f60a6so622075166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 02:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715075342; x=1715680142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Bgg3zxtJYPnqt4NHW+d4WaRnGJUInrGr8+3LGqkJRo=;
        b=SFaB42SJ4ZJqe83LnbntsQDR92mPyFHmciMGVa5r7emtZGLiBkt4Ije/ejct4OhpTm
         e5eq0ngoPxw5nBvIsKnF7RwbgFF2Gdq0eWe+/OcvPtugrXCdLPLfn1hvcsGbSa1gOujw
         aNrGY2LtDi77eWs4aM+l//8mG1Oes6lSwtHFJjyYDSauGIkxZIyUZ5xMzUxXyBisii09
         AGODvaBHucq4vKeHgTwy7MLjFuqB7OXvbdfMSC0TrIOHd5vax9RGJZNHLbAu/o8oypOg
         lUXEpYbjs/Dhcb/4seX1rl35hiLHYEt5NxF+7GdLqa7AmPpKzQNWz2EfDs6ekIdLG/9R
         AWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715075342; x=1715680142;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Bgg3zxtJYPnqt4NHW+d4WaRnGJUInrGr8+3LGqkJRo=;
        b=SlfPufnoDlVy8HqM0MHpXC4K22uF4hmrPvjkP3QeDcWAiXxoW3hqvegkEV/eIwREBz
         zu6RB9WhYVKDzKP0OOGwL7kFO6N1d23NWBPruGIUqfSkTaH8CXoBPgSltd4oIdwotGYv
         WYy0iZv/JXsySneI/5lQ2t2pk/Ipv0kKRx1H+/qkCwDKpZsd+NlRexk0PoGOnhtdFOL9
         vCZucwWtxDOJMxUz11Ua94u0zrpX9GAyty+H9+LAQNlUDfy5lTjRQGcXQRZD1JFXn2ox
         UkoFhpK0z21AaesPDYyC5teIu9TDNa4ubvMl/10DEZ0S4av2F308T+x7yqFI8Cxm3EXa
         t/xw==
X-Forwarded-Encrypted: i=1; AJvYcCX5ESlETAu8+A6kwbMaNv42GwMeJSFK0ICj5EV4haZ5+9TyOfcTf4aPDpfejBb/jrcK0Y+lcNw615F0RGAiIRHAIZ61/9UBZRgqqjf1
X-Gm-Message-State: AOJu0Yx5sGGmJyPgunItdUUcKiH+aWM1F3hjls+p/wWXvVNMiczMre5g
	sGbQ76TqhpHnG2ZqyJ2j2UbNxF+epjsU/MxvhzweNJcdQNkQmMDCl9M8wfOzWGwtBZHZaXSv+Qa
	J
X-Google-Smtp-Source: AGHT+IFmHeE3lcBLmnxClRQs4AEPEUnXv/IqNkBVg2rMNk4slmqta8jMmXGP+5KJreMBtiic3HfGHg==
X-Received: by 2002:a17:906:b7c2:b0:a58:7c50:84e4 with SMTP id fy2-20020a170906b7c200b00a587c5084e4mr11565763ejb.2.1715075342136;
        Tue, 07 May 2024 02:49:02 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id gh5-20020a170906e08500b00a59a9ffeea6sm3910824ejb.96.2024.05.07.02.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:49:01 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240507055948.34554-1-krzysztof.kozlowski@linaro.org>
References: <20240507055948.34554-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] clk: samsung: gs101: drop unused HSI2 clock parent
 data
Message-Id: <171507534100.608425.10238086621749823821.b4-ty@linaro.org>
Date: Tue, 07 May 2024 11:49:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 07 May 2024 07:59:48 +0200, Krzysztof Kozlowski wrote:
> Drop static const arrays with HSI2 clocks parent data which are not
> referenced by any clock.  This might cause -Werror=unused-const-variable
> warnings.
> 
> 

Applied, thanks!

[1/1] clk: samsung: gs101: drop unused HSI2 clock parent data
      https://git.kernel.org/krzk/linux/c/7c18b0a5aa46cc7e5d3a7ef3f9f8e3aa91bb780f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


