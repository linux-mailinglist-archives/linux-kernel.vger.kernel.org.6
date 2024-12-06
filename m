Return-Path: <linux-kernel+bounces-434632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC179E6932
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EF361883105
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B531DF965;
	Fri,  6 Dec 2024 08:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b25HpKoR"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA2C1DF980
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 08:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733474586; cv=none; b=qNkBWpT0rHO4Zc/1VzPMN3lpU0IAESJ/fzqazNRnwKHXGZJuDtRngc7bYhukL2vx9FxzuNMPdOPcn0+cjukOrKWcXGVsB0UPWryRcvc+hMcW259C1lNvpGhUqGoh1bTja8zmjMCmDBVhLGEPpN9FdU9aww+2l7CXTzrrYpETYaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733474586; c=relaxed/simple;
	bh=jPUQVjuSzSOJ/arE+PacopEd78zCyLhaXvXPnH4ZH9A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D8gw1pYixMwNt1xkk4hqBaytZ9BlP/2pA4DcfHOgYuEl5s9p4sE3f5VFJv+PsxZBgzsS6UbyTbJLfWy+LVzs9HXI4aZn5AX7XkmAxiIUNe5gceJcD4Fw5WwtRv/J+GEmo/OthbRyIz+AEDw4sTKbLH+fy8yoNc9cuu1ATzAh1IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b25HpKoR; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa62fc2675cso20457966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 00:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733474583; x=1734079383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYjqo5ba54ttoq5t6xgwst4ctEjjHBn2LNYh1P3rOcE=;
        b=b25HpKoR80Gz8g+MnMVgvJ8i98+yqVabjz9oJhj7RmCuSuAPLgxl5TlDb4SUwDWSR1
         ZavTVSJZN9shogAUuKKl0CScbnTWNZsTQhgmGgat3U/RqMlkr9MRU6jaU0qA9+/dmZ5E
         SYoPGP/8lVyR63IeEB0LKkX+0xLJPvqS4zP/6aqVfTfLgXYVpQNhXe1pQiPdNPMhnlBF
         DEF4T7dYA6TThNh0hfPn0R9AqDKavRhBIGwlR4WuJ+T9QLWkaEPLYDENLdLKN8butk0g
         4wfhepGlnmbmExMg+luV3XBs+NOeiVR03/lXVI6q7l6sroN2ClyOVJI4PoPxEOoEXKnC
         qWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733474583; x=1734079383;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mYjqo5ba54ttoq5t6xgwst4ctEjjHBn2LNYh1P3rOcE=;
        b=vOh7qeDRdXW8YZUaQOFSLjVtmaDqTVTbT582HFQwlXilqhBRQqEW0Ea3treXV1ffLT
         GjDikhSsvwlnK+Lws1NVURSe/eohhsI/UKEl4RNyXSlJzaJk6MXIz7IysFiLMglLzF+m
         kxrWrXS4reqeQJfZL5cJt6I2M7sBjfMrG6fagiMR3RV+pecYvIMFUsgQ4ZeN7hfL7rMm
         YmqrMe+GJ5UEBcBWD1psc2VUYLAZxDEYJ+hfu3VK+iMCO7/nlDmKfFxsfGrLWY0PDN8W
         vGm7Bit4XVXMCB52j/tMXL0376cSsdq/ZkX3TFcooQU3f2SeqNW7gG7/Em3RBLaGP3Zt
         MuSg==
X-Forwarded-Encrypted: i=1; AJvYcCWK/gh5CVyU6xFmZoCJw7B9oaymvEAqLTb843FhUj2FCuph/xsNHj5dof8Rj4KRXyXUSZc6fLN8shLh+Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztf+S+7dudgxc0Lk1uWt1QbnANd3chkiEf8dzXTDu3QiQOudzq
	q+yuVoNYJT1weJk7QFcUyhDjcGAapnJa9P4eZZ7df4hf7Tf9HFfMOfiiSp1eb7Q=
X-Gm-Gg: ASbGnct1wZ2OaTX5jf1g74vNI7QqoDlB5J2r5bHi/qFrD4TmaIZhcIGPgauCzF3WV7b
	lqYG48Vap2UUuYTTtXnDQizT0dGulLM7W4lVWYYb6/wAShofEc1M/au4sUryTqgT1T0luIcdxDr
	5nltPgR2NE3kc5be938PLrixavGFinBGQY92vclpJRyfsAH02OHjIzIht+LI/rvA4P2dEJ3JYt0
	hwDWbBQvy0UdRUO5mgt8CA9YvbzyM6d1PCPFwWMXFyPatpB9dCISjsbsv9Uj5p3cg==
X-Google-Smtp-Source: AGHT+IHTXmV/7F1fhFBALPMfg5CarEeLHNYwtri9LUWrJRXBpe19hqN0vsvFDOg2xiQCfi1NgUUSXw==
X-Received: by 2002:a17:907:ca87:b0:aa5:5346:1c70 with SMTP id a640c23a62f3a-aa63a2dba94mr72852466b.12.1733474582794;
        Fri, 06 Dec 2024 00:43:02 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e58dbcsm204741266b.15.2024.12.06.00.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 00:43:02 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Z1K1rnndKGIFdgfj@standask-GA-A55M-S2HP>
References: <Z1K1rnndKGIFdgfj@standask-GA-A55M-S2HP>
Subject: Re: [PATCH v3] arm64: dts: sprd: Fix battery-detect-gpios property
Message-Id: <173347458162.8205.11832128238740553024.b4-ty@linaro.org>
Date: Fri, 06 Dec 2024 09:43:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 06 Dec 2024 09:28:30 +0100, Stanislav Jakubek wrote:
> According to DT bindings, the property is called 'battery-detect-gpios',
> not 'bat-detect-gpio'. Update the property as such.
> 
> 

Applied, thanks!

[1/1] arm64: dts: sprd: Fix battery-detect-gpios property
      https://git.kernel.org/krzk/linux-dt/c/e1daed030b56049caa2d8cc040c824990374d941

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


