Return-Path: <linux-kernel+bounces-392304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE219B9223
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81931F22A8F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31151A01BD;
	Fri,  1 Nov 2024 13:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G1p6q+MJ"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FB3335D3
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730468029; cv=none; b=Nt31TShnLx9CI5NngofzNcxOqMpGbt6Ya/LoMeAwfoo4BXn/IA8s2fQ3azoAwsFVisKI3ZN1EKKKfNQDbWEbCyDqttHfaTE8PjvhKL7gWrcQt+tqIW4KSxoK7kaCHVjh06hFSdJM7Q4/e2LvWO4TcWGaP2mxI2OZ39p/L8KaNj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730468029; c=relaxed/simple;
	bh=cSRSVKy6fxvv4pqCUjjonIGzc8O9xPKLp2iSTjcSfEE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Znx9M6P0lfizjzC4wOdWp+QBkP5t7Vp7anwqVZ8PR2ZaDkNNX+Aue2WG0a2Ewyfey03S/FnonJCSVnERApXM/S51CBBlEJdi3Xt1rOGLZk9jMOX4w+vN6tB5Az+rfumkp+E3OTRw6BPmXbM0jQ5HQZ1abfoW10tbkObnPc2QvTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G1p6q+MJ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43161e7bb25so15431675e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 06:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730468025; x=1731072825; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSRSVKy6fxvv4pqCUjjonIGzc8O9xPKLp2iSTjcSfEE=;
        b=G1p6q+MJJsqRhFUr4G6NIFliI4oHAarbBW+Z0bn8r7KXDunY+Fs2RjqPqZQ5CecLPU
         zfihzov15LAEk8GurA+dnZTnL4p4M5fS0urjnEfLyoEyXKabJUoKU4wMH+C4AYomXOHX
         8yrsjHuF6Tg0g0mq5T1OlHzUxl4vvnmwEJH2RjtM+OG8KWKG3ekX6JDWzeXexTloTXp3
         +IhWIjhExQZmd/muLy5fy9C3Ha91Wqz5qwkfKTF2P0Qsr/J+4Pf/rdHva9+pPINxz7a+
         9/MEz9bnXYRp+O9DbnMKviAV0miArJWdr6vXUIoPuHNgji9d9ap/suTwyd8UMvfc1Wop
         pjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730468025; x=1731072825;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cSRSVKy6fxvv4pqCUjjonIGzc8O9xPKLp2iSTjcSfEE=;
        b=VJKZZ/VWtLmO2ivJvozY9gcMi2XsTTOO3t3En+WmS6IbpAt2RkTmyvNs6CAY59eoVK
         JPxM0I+5gAJeaK0w4gjZPT7tvWrm9e34SFNl23gYpFCFtErT8v1UcKR7mt4foNep0RQd
         d0FqkV1gNuBNvcH8zh/ZovU+X4Z/5aU7w2MTnhuT1f2FgwlKM1WDZTYBsVpU2P5M5YhK
         vZGX9hV20CmOI8C3kDmMbnjg8p/O18Bf1we4U/l2pZjKiGig8oxnlSD9nPI2mEOO53mF
         pG3FcZRiagR8nHNURVd9swQ5z+RWM+XoWrQ7aXXNMKF4dSWvbyzpugXbdg8pWuK5DWwn
         PGMg==
X-Forwarded-Encrypted: i=1; AJvYcCUGDOfJiBAQmms1WxSzOI4JGxOZlO2Q/mFq8ZJgaWHnCMU05D/0aV6774vD4tYPhF0agEoonaC2ac1b1RU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqDmspSUvEryMlmxkHbhs7zt7Y/m1t46yRR0r1qF2ryfoicM1J
	1xa5LLGH/Rp8z+Kdfapat7ihu2QuJ+Et3dj6A4GJhl+wTsqsRddkTMukJ4ubI50=
X-Google-Smtp-Source: AGHT+IEH/LV34+9Gvkw5TCuAvD/S65wFK2Ymadi8Nr+OKQpBYeZS9kWI6PwyE6h92sZJAW5b995gHQ==
X-Received: by 2002:a05:600c:3b88:b0:431:5e53:2dc4 with SMTP id 5b1f17b1804b1-431bb976d14mr84779975e9.6.1730468025405;
        Fri, 01 Nov 2024 06:33:45 -0700 (PDT)
Received: from localhost ([2a00:2381:fd67:101:6c39:59e6:b76d:825])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bb78b809sm105155455e9.1.2024.11.01.06.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 06:33:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Nov 2024 13:33:43 +0000
Message-Id: <D5AVPVHDHG9A.ARDI8CYMPNCN@linaro.org>
Subject: Re: [RFC PATCH 0/2] wcd937x codec fixes
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Mark Brown" <broonie@kernel.org>
Cc: <srinivas.kandagatla@linaro.org>, <quic_pkumpatl@quicinc.com>,
 <a39.skl@gmail.com>, <quic_mohs@quicinc.com>,
 <linux-sound@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>,
 <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
 <dmitry.baryshkov@linaro.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20241022033132.787416-1-alexey.klimov@linaro.org>
 <1995b110-ff67-48c3-9a82-c29a6a95a059@sirena.org.uk>
In-Reply-To: <1995b110-ff67-48c3-9a82-c29a6a95a059@sirena.org.uk>

Hi Mark,

On Wed Oct 23, 2024 at 12:21 AM BST, Mark Brown wrote:
> On Tue, Oct 22, 2024 at 04:31:29AM +0100, Alexey Klimov wrote:
> > This sent as RFC because of the following:
> >=20
> > - regarding the LO switch patch. I've got info about that from two pers=
ons
> > independently hence not sure what tags to put there and who should be
> > the author. Please let me know if that needs to be corrected.
>
> The tags are fine there.
>
> Just as a general thing if two changes aren't directly related and don't
> overlap at all it's usually better to send them separately to avoid
> creating spurious dependencies which can slow down getting things
> reviewed and merged.

Thank you. Noted. Yes, they are technically independent. They were
somehow connected in my head, something like "both are needed to have
working audio with lesser troubles". I'll try to keep not related and
not overlapping things separated.

Best regards,
Alexey

