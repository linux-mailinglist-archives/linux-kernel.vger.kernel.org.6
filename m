Return-Path: <linux-kernel+bounces-437256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E7F9E90EE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 677E2164073
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917A82185A3;
	Mon,  9 Dec 2024 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d561UqDy"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370AD217F45
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741400; cv=none; b=KZd+cdStPGNReJQsAFnMmASrhlh7SMS61BsqOWbL1+iWzX//PdD7o4PLOuzmOMqcSv44xyHGzvYwyoSDlGpX83Z/Je8e5FtH/rnYRaimORDlHLAbaamIvfkSN85WRj4IJ2RKXwHMwglAUxdav+5ae8XOvHeamHsFHbIEYsDTiSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741400; c=relaxed/simple;
	bh=PWJY9T7StgCjlU/EoLY1YnAftn+uydTuW14dCopwpBM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=o4YAvZzxn19ePguXV9RFpb/bw9h0ekX4s7wK74HycP4itvZDPQxqzcWQ2b5t+6Lr7Lzneo9ZuAuznSAJm5gIHuYEVomY24xTHgJ7ieRL6SJYCTplZ4ZdPHFJO3ZbA/LVdQJ4+vZDuYxrk9YR8j8sNpbeiJGpDHVM7JOKAt3E7XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d561UqDy; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385d851e7c3so339585f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 02:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733741397; x=1734346197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HldRgXZlNwLf5fyqIyt/xpE8o9fTDtPf3iGgDTBBGX4=;
        b=d561UqDyIloQiSWd88UWENMh3OZMNLU7vkJOSfA+epcNhPilmNHJFn24z4Dmn3ROu8
         ngH5ypClPJ9PcK01TnfLfDaDjcfLQiBI2ZaEfy+KOx1bfwRNnpIknEbk6g5Jo53m8/4+
         DjHF7n/l2XQtoJxQBF10pAmwdpKGcwMyBdsz1CIpCM5jVkKXKc+oygvbMoN011sPNEh7
         uyTgZodmx4M9izY3Y3CpgrkLRUFBNg22V2mPlPgiOVqbqUR+iHJrXKqxta/u8it5ZCPN
         CObeUNP/nU5PMLnv3ChvPbHKZqkIhL1px+0T0XSIvvxd3SpLnwub2+6ubR2rxec2gta4
         LT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733741397; x=1734346197;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HldRgXZlNwLf5fyqIyt/xpE8o9fTDtPf3iGgDTBBGX4=;
        b=dV2aso0ytZ49vDTxIZgth+g7HRUBDhZsdrQIQvNjz0oKYs9QwnUMA6U9SKM6alcjmz
         jNlBmvccrGh7pEKecIkp7bZryGzagZh7jzLPOXuJ0De2lJKrNDEgmfDPvGxbcOR5LzRt
         T7jL/yBY/ELrXQolVEKD+6uSw2x6ivJPHQf8ebKVNfi7K7++4QW+6On5UFY8ZI0E1QIE
         YJF6V8JDEqsJPRarNvrI9kKJodL40wc6iBKLk322QhFrH7MzMp+FBeU4jatVZxItOS71
         OGZM2r0W5XN/ds1REzT45pcVo6k/bGi5XrsDeza9bBXtGAgmhWXUGOe/iaFXVFlsiGz+
         axnQ==
X-Forwarded-Encrypted: i=1; AJvYcCX57WFpWoi91vPhhDv+tqRmq1Kl3Kf1fCFItjsxvuFSCDn3hUsGpTQutCRpUoaBPlKwMQu9uHKVg+txdj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvl7igzIDQqJJ3b78h+3XCDx9e3ZWKWpDfFU280CGxNjx53abP
	Xox7dyF2k02Hre7Y+JUsOiPLaRS4Eep1sDxV86OJDWJdk6sNm/OkHDo0bjoWd4s=
X-Gm-Gg: ASbGncvw182zXrYrzNiPqSnw6UnihcbPpxLo2FrmGeJpsEKF2jF1yU4N4YhetPFC5eH
	YvFIhpioy2OLisIrplACHWr5XGSSrF6Xk6kTEGHdvrbzuDiIdmpTg31RI58sxWRs5NwfpDCXkmu
	60KT6dgfDMC+D0RdEKKOzTkMIwDg3rwqeuHQCP4YHPMKCnTEehEKeTWBIq2Yotpy9FzoXK5zzPv
	FSo3vsOvBDdnoZ+pjXhob8h3TLe7RMj3+NXDsYdRLU9swYJcgXJJwkuPPxDgRiTKw==
X-Google-Smtp-Source: AGHT+IHxRoXs2saioOScD36Qx8G113XvIArop5p7MfwoQX5UHxDTuYrweuCHNEqAi0Kh1dl9f33ubg==
X-Received: by 2002:a5d:64ec:0:b0:385:ea11:dd8f with SMTP id ffacd0b85a97d-3862b368a48mr3146673f8f.7.1733741397649;
        Mon, 09 Dec 2024 02:49:57 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434ea1ae415sm80301445e9.33.2024.12.09.02.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 02:49:57 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241204145559.524932-2-igor.belwon@mentallysanemainliners.org>
References: <20241204145559.524932-1-igor.belwon@mentallysanemainliners.org>
 <20241204145559.524932-2-igor.belwon@mentallysanemainliners.org>
Subject: Re: (subset) [PATCH v2 1/2] dt-bindings: soc: samsung: exynos-pmu:
 Add exynos990-pmu compatible
Message-Id: <173374139637.46435.13275133164438214681.b4-ty@linaro.org>
Date: Mon, 09 Dec 2024 11:49:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 04 Dec 2024 15:55:58 +0100, Igor Belwon wrote:
> Add a dt-binding compatible for the Exynos990 PMU. It's compatible
> with the Exynos7 PMU design. It handles system reboot, as well as
> other system control registers (i.e registers for the USB PHY).
> 
> 

Applied, thanks!

[1/2] dt-bindings: soc: samsung: exynos-pmu: Add exynos990-pmu compatible
      https://git.kernel.org/krzk/linux/c/33ebc0fb73ba8fabbc1c8f581f7f512a0b277645

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


