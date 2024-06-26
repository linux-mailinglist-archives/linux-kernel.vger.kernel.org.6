Return-Path: <linux-kernel+bounces-230635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6875917FAD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D74781C20D53
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A5B17F374;
	Wed, 26 Jun 2024 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U4pv5eo0"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B558148FE3
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 11:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719401389; cv=none; b=X9QP0L5Gx9g7bbTUEieMKpKESEtnf7IE3FEb3EnnuiGQKK18gRxk/mMOR23CYNWU/iyoJNjoBuPpCDaYluub1KBWbxLIpKkKr5cvjf6T9LTuXeWpuH7cExly/k+FfX1AE5aKoi/id2YnYR+o6YYbm3sAvGFLba81bdVHpff48Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719401389; c=relaxed/simple;
	bh=4gzPNh34IeO799FCFLFPDSLzK9cSBUSofNIw5HvDk9I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sK9RRL1Tf6Ip3535UUKTAWqQevei9aiSjchs9NM6xOOEbxIYk+vTnHnt0bclv8Kre7XMy6dogTX7LbNQL/2If1KJFbRsw7gsdDXYnYOQt4F3uBD8pCENxQu6w4W19k5kp5iZ6TDSSghx+E7+ZQ9vOs2h0i9gAAQ/DdULFx5d41A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U4pv5eo0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42108856c33so3036205e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 04:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719401386; x=1720006186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KymTIi2UrAbK6iLm559b/8fUQ5fKn1XuICh61Vx1aqk=;
        b=U4pv5eo0tnJHRR0uioAhVA1K5FzBDFK3FxXDv1044CT6Rvdqoxw32kDkm0GzwQW6Dq
         ZEEcXmV/P9c35Hz4EosreW8P3Iln8AlZMEGuU3XwpXgQGGF9f0PKec9gG6jJH6UVWZmg
         vawrW5W/cQY2sHkytpKar5xCutHo5HKNpJbIONYxmfyTYP3O56jP4hdOSNL0YvamPKCo
         4t1PgLEkv974b1nIPDztgdZVyFp5Ed+DILWf+LpIKnwD5hntrxCPMCrJU1xY1M1lxjNe
         +1SQ0uILRsErlCDMWY0tnv2P1XEOTDzd2Ua/aMmg04YWaR6YOX9orNOqI96NabwMOdRQ
         4aIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719401386; x=1720006186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KymTIi2UrAbK6iLm559b/8fUQ5fKn1XuICh61Vx1aqk=;
        b=G79a7u+HwjdNeoq4XLzNomHiE54OpZvVixxy8Yz69FA0HpFS/Fo8/JugT5Zo6te1ak
         tDbJGA1Sbmf+PCMqDw8Ohdz8tBU6OpWXWuDzD51JUWAHoKROJQV49nmaWPorM7k3DNNk
         5DmPxC5AfqEFhI79MZyM75buLRWJZOI4tEm6wqchdtBC/vl6nnC+Jd9Ocnf1c9fOn8JJ
         fmoEpN/YyQtQfnhmWybUCGkzo8DccWfeCnzOMWSCj/J9GpOWOJ8fsxHbARNeT6ZoBw8e
         r8lGJsDIGeTHGxu2EA9s0sBlIAFpVFKpZj9Rpn6MREsMxj4CA05/03rKt5ETifO6k5xh
         PHAA==
X-Forwarded-Encrypted: i=1; AJvYcCUU8IkChpiJywnuf6w5mB/Gwp7EKeCeR62ocXWbh6MLFdjA5ftpT0ltIvmAieyrIoHfWIf4oF4hQF1U2fJ+HvGMA1mhOLvAapINh9Gh
X-Gm-Message-State: AOJu0YzU8jBq/EAi40gKm+u3Iqd7TldMKLPX52U3aOs9yFR3iyd2awwJ
	hlv2vbu1YB1R53JHvtu8WASNk/FOD0yaSLy8gBWqPMegFIwNruC5X6TmQP9g9OE=
X-Google-Smtp-Source: AGHT+IE6TNITZiZA6yQUaGfTrdfEFJVtYZpT8JcHpQU2L5nwmmJ0MMbqoSUKGdT+ui8ILtpg/KxC7w==
X-Received: by 2002:a5d:4a81:0:b0:360:70e3:ef2b with SMTP id ffacd0b85a97d-366e36ba8d9mr10405352f8f.26.1719401385693;
        Wed, 26 Jun 2024 04:29:45 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f679bsm15645355f8f.81.2024.06.26.04.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 04:29:45 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH] dt-bindings: soc: sti: st,sti-syscon: document codec node
Date: Wed, 26 Jun 2024 13:29:42 +0200
Message-ID: <171940131512.32913.10924044937405928062.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240517142245.178556-1-krzysztof.kozlowski@linaro.org>
References: <20240517142245.178556-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 17 May 2024 16:22:45 +0200, Krzysztof Kozlowski wrote:
> st,stih407-core-syscfg syscon block comes with a child - the audio
> codec, whose binding is still in TXT format.  Document the child to fix
> dtbs_check validation errors, while allowing later the binding to be
> converted to DT schema:
> 
>   stih410-b2260.dtb: core-syscfg@92b0000: 'sti-sasg-codec' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> [...]

One month on the lists and STI folks did not pick it up, dunno, then I guess
I will take it.

Applied, thanks!

[1/1] dt-bindings: soc: sti: st,sti-syscon: document codec node
      https://git.kernel.org/krzk/linux-dt/c/68c402fe5c5e5aa9a04c8bba9d99feb08a68afa7

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

