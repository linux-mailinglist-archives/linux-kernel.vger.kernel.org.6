Return-Path: <linux-kernel+bounces-438315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58539E9FA4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E08DA282828
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7480C199939;
	Mon,  9 Dec 2024 19:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WGAZv5ud"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17EC1991CA
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 19:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772533; cv=none; b=tKO2yjHrTPcEcrZ+LwQsjPgIoSPo6vhAVDxn7EWwdh+zhdNVsYgVGRjdNkZe2F4WPGLUXEMCFmSWu9eIISeFds7JVRIL8sk1Udm+ZF0R8EfInCutBefTUJO74bVYMeojfM9OuLEKq9JgkZhpxou2YHmaXHZgMeBBO8PC0Qa1FoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772533; c=relaxed/simple;
	bh=bGhWqBXSz8K0txqXiFCuPd7y7o6C0UeSwmy15KkcIn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AqH54PgbG00q2rkLN1249CEiiL+eibhk/qgpYsFODCk1X251HWlUEFyEtBe66e8yVNgLJvSTmnSNJzi7gpEWzSHYTi4yhbSXaff8MFgUpqBo2HAFmr2BjWOXlm43gbmlfJ3dGtDUDa/acfTh2qZkPXy5ejwRMsM++7p6hyvZiHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WGAZv5ud; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434faac720bso1110725e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 11:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733772529; x=1734377329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IuSpj/HsYjKUq+UsFvNv/TltZ5XFd6qk5tdowlJF1TM=;
        b=WGAZv5udWhX40eLfEKeSavxIbYtBKqzrVcNJVTNyO+w4ydXEKQ+TuPOEj62RHphTCe
         wj20XRC1mshoJ6MRLxTlbINbp3dYlest9osb9vMnHSx63QU4j+10SfGlSHsuiidbt+VO
         bnjoSM2MCN8zjyaGBVwMH0CPu+o4TN8ddn6EE6GbfEQSyM0SX3wHWhePUJswUg6fV7/c
         FkMAvJaW0h8BE1HsRIVXvN3SEYSYD/XO2W/KgXpIKt+I+uPoF9+pAD2XuscvnJNSnahm
         zZTeAsH2Eiz8iHD02pP+TmM5I4RmCa0in2VC3JVjEQ+H+ACPQMFarWaTsz1rH79SLIoL
         7FRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733772529; x=1734377329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IuSpj/HsYjKUq+UsFvNv/TltZ5XFd6qk5tdowlJF1TM=;
        b=Up5aiGShveDLnm7q8teGAZrTlhVWQvV3vL3zt43w+euaoGOk72IebjwyedQDSehXDB
         07wYjh7UhoDiBVPCCK/4Rp7T2npMjKK3ctW8W+eUm/21SUB4md3395Gy+B2ALEDfS1uO
         XJIIokhOC35PnT8QS5x3F7GIHWrrZo+OiePQWpCDR83ttY2Hea1MCaq/yB9fOpSborux
         /T3zGzim4q3bXQQ+iXhf3ligImUaSdgsZwPmUS2V9zPtwxcYoP1v9HH7cFnytBYAg5nX
         FEVPi7YpK1rDtUtK57gxX5B51g+67p+Ktrr0pDTCIP7p36PuJXSL5hu2shXY2nIo+UxD
         pylA==
X-Forwarded-Encrypted: i=1; AJvYcCVg4vXV3ctP9yjJaTTnX/G+hFl+pGfRqyrO0H5qE80PIG42TPpp7DhUd+UZwDdIA0gDlIVoFirHwVduJ44=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzxRFwTE8d6Sbn/7viDLZCKpTT4u+Q2fAKJbTB7SZaEhzcG0Ih
	uvFe3mxrqI3ls5A3EtE1ntFHJhYjbzQo8/scRdmRxg7lujLkdYudneNTNWS2/VA=
X-Gm-Gg: ASbGncttCfpOu1QzzWdm7ulgx9tbBGN0MPxpdwnYPdu7wdAcpglaJb+nTxhub74OU6S
	BBzFWmHTn0aEFLRxCQZ3CjcfOEKima7KzS0hY9P/hl6S8/jOgT18KxdlXKhfdN08PxX6VHfgUmd
	zgzHZEeMy89mqlG9njkz4ANEkBy6LJ9MRznoAZ3CQoJB9zKEGFtAXMZADT5Y1vUJkwG9/O3njPK
	eztN1p6aFotl+Bi0NXgMzkXMOOWbQU2f1Sh4oNcG5dN5p1vyyUVw6YywntTfzUB
X-Google-Smtp-Source: AGHT+IHptp/TSN8ArgGPm9cywAb5bVkFu4G3aOR1tLTZhOcuZyzTX0x6rWRDIu6DPFmEx/1jW4oROQ==
X-Received: by 2002:a05:600c:3502:b0:432:dc5a:b301 with SMTP id 5b1f17b1804b1-435019c8db0mr3209025e9.8.1733772529211;
        Mon, 09 Dec 2024 11:28:49 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f13f735csm80686325e9.16.2024.12.09.11.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 11:28:48 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	Will McVicker <willmcvicker@google.com>,
	Roy Luo <royluo@google.com>,
	kernel-team@android.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/5] Google Pixel 6 (oriole): TCPCI enablement & USB updates
Date: Mon,  9 Dec 2024 20:28:45 +0100
Message-ID: <173377246177.140612.3507892014297013464.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203-gs101-phy-lanes-orientation-dts-v2-0-1412783a6b01@linaro.org>
References: <20241203-gs101-phy-lanes-orientation-dts-v2-0-1412783a6b01@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 03 Dec 2024 12:40:23 +0000, André Draszik wrote:
> This series adds and enables the Maxim MAX77759 TCPCI for Google Pixel
> 6 (Oriole).
> 
> It relies on the bindings updates proposed as part of
> https://lore.kernel.org/all/20241203-dtbinding-max77759-v3-1-e1a1d86aca8e@linaro.org/
> and
> https://lore.kernel.org/all/20241203-gs101-phy-lanes-orientation-phy-v2-2-40dcf1b7670d@linaro.org/
> 
> [...]

Applied, thanks!

[1/5] applied (but b4 lost rack)
[2/5] arm64: dts: exynos: gs101: phy region for exynos5-usbdrd is larger
      https://git.kernel.org/krzk/linux/c/527c9640e4f04044afa98f3ce18f8af89ac4a322
[3/5] arm64: dts: exynos: gs101: allow stable USB phy Vbus detection
      https://git.kernel.org/krzk/linux/c/95350c0ec27d906cd95375084ce343bc65421e70

!!! NOT applied - waiting for bindings to be picked up:

[4/5] arm64: dts: exynos: gs101-oriole: enable Maxim max77759 TCPCi
[5/5] arm64: dts: exynos: gs101-oriole: add pd-disable and typec-power-opmode

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

