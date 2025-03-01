Return-Path: <linux-kernel+bounces-539983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 314BAA4AB9C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 15:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11A3C171B49
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 14:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0311E0DE8;
	Sat,  1 Mar 2025 14:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WLP38u8Q"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF3C1E04BF
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740838418; cv=none; b=s4a2811DGje+LSZ/bj3cZto/qHgRGowOXY6QRaf+5deHPUNkVQgChQcd6MZTe+QmLB+eQk1njs0A5lj+Sk9v4LNRDmhbx9IAGNaDxjJAH58WQU2TXCdJFIWsg2rp2W9dt/kz/v22XYIFElOOT/MqykPDnvhoHreF7wP57cTmgLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740838418; c=relaxed/simple;
	bh=kaLeNKCrV3DUrxPBC4orfb5NQSWt3UDFoXv2KQEv8y0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oseBbaR+zOfVPuoXx56i8rqiO+dQudcAX6TPGOQWfysREGF2UqSci6RiYz6WMgyEo2xd6n18U5YviRpNWSHJL2OpRl3Uq9NJGxfXwAddVJnVGFd9u4z2rEMm0zs2kydmMqk9uQ6IvXmT86GLcBFLtYS6DsaLtvZTyORiAx76jeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WLP38u8Q; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dbe706f94fso453473a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 06:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740838415; x=1741443215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JF2SZUIZ+BCUsqS+/yls5B4+IVbjBfE9IjNCznqvy2o=;
        b=WLP38u8QdiBjjb+kmfdvdhkkjvRGmFrdwKM3h7QyXEnbsJRNFXkDPjjnU+IIIbiT0r
         5Ff1sjD7QNhhymMNyxbgwUauDLRxwqnPYU6p9H4FMYlfuzZdjkDKDv2QBmhKVkA9OdJT
         VUaRZBubYyTTq5aGW/9QHhJ5NlsyJLrhZa1htmCL84q6q3bdY7IXyKG5ldyPqmcilyS2
         OnkPfKxAOSEtRSBnP9ox5ar4/ZMO6LaKwlFVhBNzhXacKgY2jvcCxVTsXkbkBKZCh21p
         DW/86jI8REEUM+FW7tZXrjJGZSlUAmLlnQnvQMhf0uVKY0L/p/wwqFZ08+e7whs49l+B
         YUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740838415; x=1741443215;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JF2SZUIZ+BCUsqS+/yls5B4+IVbjBfE9IjNCznqvy2o=;
        b=g2W/3hYNI7mOyiGRDa0J/M1f8COP0lVIqI4d7vxX37yyU+35U7DD2gCatdGAuQ05Pr
         /7tHB1gPAUcJPID7G1ZO/j3EwjL+z256hhGa8YgvIPyIUQMiTuJnlrXA8zHOia6rmh+U
         /NWfAf2VHLFhqhRwsdOrpWavhByA3O4FBQZSpWcKHsmMRKfItPtPo2e6RuSNEN7VmDmE
         INyeLEpVIzKDiLX04XN6EVXTtJnN3YCBmezgl82Ax7JW4ycSvyXbI3ul4EjkXcjZuxyA
         bKYDBlXntrlkYuoOoshDcp9Ohr2ALqj3JQk0OMSVrtJNExPImdd+CX6Rv8t7xnMv7poc
         E3aw==
X-Forwarded-Encrypted: i=1; AJvYcCXN4WPZ0kQdxOIyjxW+1MU2zwHbKkurVHFPn2z5sN74TOeIb+6XnOka//UqZOE6sMJX8hsM+lezjOcCyFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQgiifOVb7oMOXmW1EXA/S7olHvuCARTJVVjdgiugRh6aOMZl2
	TOxzJ2fZz2LQLgwF4IZjCmGwEM5YFhJYCyvdIK7MMKf7mVcncFU04GGv6oPzdgdTIK30nAJwNDK
	6fAg=
X-Gm-Gg: ASbGncu6j5NPswhT2ZGlV6jMKFgRHtEq4wyBXUP2m3RT3YSA3Gc0Sb9kF24dCcRKEKs
	C8Qj/ryCNmRAsWe3quSc/7ZpPqVXs1Zh74wFFuVw5wTo+cEmGy49Cc+VzQqPVdjz6JCy6KZI85/
	hFCLJFdfqTsqPLIbaBWQu+m2Q/80TJVT0i3M47gbRAoSaHoGrUqMQ9f2EM0NbNMv+xZFyzVRmNA
	hBQ2rRRb/MULpkvWGTGrC1u+yLehKmmyxepZ4RkUBNHz4EIVf11Z50XRQanXPspZm0PKyh/5IWk
	6lDxJzxnqy4AzOnV975M+cOeWA38OP2bOCAwDVXKCWATEabocbKoaNtOKtK8
X-Google-Smtp-Source: AGHT+IEXjfOAsbzmDdwBeUYHq/6or4MctOJ1aDy3KgGo+cF5AzBxwpd05SEBfk2hys/UsQO5ckCxQw==
X-Received: by 2002:a17:907:3f2a:b0:ab6:b8e0:4f25 with SMTP id a640c23a62f3a-abf25fbaf6fmr324049266b.4.1740838414804;
        Sat, 01 Mar 2025 06:13:34 -0800 (PST)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0b9cbfsm485532366b.14.2025.03.01.06.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 06:13:34 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250301-exynos7870-pmu-clocks-v5-2-715b646d5206@disroot.org>
References: <20250301-exynos7870-pmu-clocks-v5-0-715b646d5206@disroot.org>
 <20250301-exynos7870-pmu-clocks-v5-2-715b646d5206@disroot.org>
Subject: Re: (subset) [PATCH v5 2/2] clk: samsung: add initial exynos7870
 clock driver
Message-Id: <174083841272.17657.12697906967603393824.b4-ty@linaro.org>
Date: Sat, 01 Mar 2025 15:13:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 01 Mar 2025 09:27:13 +0530, Kaustabh Chakraborty wrote:
> This is a basic implementation of the clock driver required by
> Samsung's Exynos7870 SoC. It implements CMU_MIF, CMU_DISPAUD, CMU_FSYS,
> CMU_G3D, CMU_ISP, CMU_MFCMSCL, and CMU_PERI. all other CMUs depend on
> CMU_MIF.
> 
> 

Applied, thanks!

[2/2] clk: samsung: add initial exynos7870 clock driver
      https://git.kernel.org/krzk/linux/c/4149066a5e958963f7123be51d3a65d336045c21

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


