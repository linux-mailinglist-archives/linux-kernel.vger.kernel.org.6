Return-Path: <linux-kernel+bounces-444289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3239F042E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 06:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A087188AB78
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 05:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6C61684AC;
	Fri, 13 Dec 2024 05:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X+DmThaF"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555FF79F5
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 05:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734067673; cv=none; b=ip9f9Wqn78fPrbUawQvxyHarMnaWEmD8oTjjWnLhJ4VQ48cfoKkUaJbyEV7llLhHBNPmO+Bt7r6KljwR1JHjT/a0ZiMlNvseUQ+5j6RhXdL2oS/fJoxT9IVCCPuAD2ZyPDSJlh8jgjaRvvrunss0enWSuUny582ILyEstI/enNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734067673; c=relaxed/simple;
	bh=PKpp1ScewKJPqehPv2yTI+ebSdDc3GG9Q5vvBr/q23Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Rjiq0Z2VnrZMoSmSIyx2JyapuQbB0IAPe0l0ptBpgqTCc47eBKJhY9nVE7PBQNxMjlOkvEDL9OenU+vpZiSP59gYSpesOovFOEs76Kn4gwm91LPuxpMVxwe2q7mr7BLUCJ0y4UAY9JrORGwhfBgj8ojH3VMXmS0Q7ffz4hp8Y2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X+DmThaF; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-728f337a921so1520039b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 21:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734067671; x=1734672471; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pHzjLDekd5mQV8SYfeuvwYKyGO1BHWQrWxmHdBR2+PM=;
        b=X+DmThaFfFm5NVSRQkSPpeP/IMg98w8+hEd2FNS4jb0GpZucY83quXNY+zJKKKXh+f
         vQEunykyg3lOYM01WeetEmioS0N3xeff3S5udYO2aBk3TfGaoyteO1MmJIZE5j7ejjvt
         VfGKWJGOBfcyI8jH+Vwt0s3KIzS2EaPj1EIm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734067671; x=1734672471;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pHzjLDekd5mQV8SYfeuvwYKyGO1BHWQrWxmHdBR2+PM=;
        b=JzR+6upjvxzzGtajMrjAj0C0non1MvteFRDmQ2hQC0AGJuASoYq+PitawUMhyIT77n
         1LqYE/oN5Mf5RCEVLUo0Fn6CNSNnv6FwSP6pf+vaKAaCXdzTxwWx/31f8EyGIz6lZQpD
         Ne21wdzoT2zDqy0Gc7ZwkbzmA8tBOBUGM2K98j0bG6Fb4Kcw8YhGjmq1a1MGRjfD1+aV
         xxsDmMbieFSeszzTzUs/Hc+8u2LVkliFSiHWvnOo8tCSm8hmEqOZSKYg36B4BIA1Z7Ku
         l6War7rkMDOcY2wiWQdE1YDBYfyD+AZPh6UDvxtvyXpdUInmKRFS5lOGde4G3uz8ITKl
         nYUA==
X-Forwarded-Encrypted: i=1; AJvYcCXAp4pt4yK1CaiqzjDXXxKafpM0svOHQJmTu8274I3kRAnN3yz+pUOo6aRjiOGgLeNjAi4NVbOzhpb1yz4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4bhXcjavORPmd6yw0cskHjKc/zp02sguSTfwLTYML/VZOFZKG
	dxuKiQt/bQxptcV8zC7j8W+qTjHynVuopZRLclqtvJarGATX2lo+YHfS0Ud8MQ==
X-Gm-Gg: ASbGncvAvXWmgn/AOZd2+QpBPW+LwNeqB9kGv0AEK4FQ3rxS8Tr+Tjd+MCw7dtOvIIW
	sGj7yqeiRSov5ivqVLLpyQ5UmefzPvRElX4P+prElhtadcEXJc9KENMXUceHzM9Np2rB52BAhXI
	unjJtDsg7hmz+DJX1F4FJFSDB4ph38DKYro6ZhqggyGjSJFrqVU/ANtnpmk29hj+6mPayQhPKRu
	9Xi9LuIEovelEFGXFa1TXoecpvaLh4KCltfQfglThtBN9qYL6x0QGLquItbgwo2YCbez++plyOG
	ZZ2OzynUJQRu8iORpVrW0l1UWWwFNBgXuWbGGoiMFm3KrWI=
X-Google-Smtp-Source: AGHT+IHB67SDjQZdu1KmnyQPCBhhCJuO+6RCt8yzJ21rj5AHz2vHeQnr45DTMywbF+2HqFLTeZ/Yjg==
X-Received: by 2002:a05:6a00:ccc:b0:727:3cd0:122f with SMTP id d2e1a72fcca58-7290c1456b3mr1782962b3a.9.1734067671614;
        Thu, 12 Dec 2024 21:27:51 -0800 (PST)
Received: from yuanhsinte.c.googlers.com (176.220.194.35.bc.googleusercontent.com. [35.194.220.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7263803a805sm7386830b3a.14.2024.12.12.21.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 21:27:51 -0800 (PST)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Subject: [PATCH v3 0/2] Adding second source touchscreen used by some
 mt8183 devices
Date: Fri, 13 Dec 2024 05:27:46 +0000
Message-Id: <20241213-touchscreen-v3-0-7c1f670913f9@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANLFW2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIxNDI0Nj3ZL80uSM4uSi1NQ83bTkRJNEU6OktDRTCyWgjoKi1LTMCrBp0bG
 1tQA7gEEWXQAAAA==
X-Change-ID: 20241213-touchscreen-fca4a52bff58
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Hsin-Yi Wang <hsinyi@chromium.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.15-dev-7be4f


---
Changes in v3:
- Split from the v2 series
- Link to v2: https://lore.kernel.org/r/20241018-post-reset-v2-0-28d539d79e18@chromium.org
Changes in v2:
- Add second source touchscreen patches since they should based on the
  first patch of this series.
- Link to v1: https://lore.kernel.org/r/20241018-post-reset-v1-0-5aadb7550037@chromium.org

Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>

---
Hsin-Te Yuan (2):
      arm64: dts: mediatek: mt8183: kenzo: Support second source touchscreen
      arm64: dts: mediatek: mt8183: willow: Support second source touchscreen

 .../boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts      | 15 +++++++++++++++
 .../boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi    | 15 +++++++++++++++
 2 files changed, 30 insertions(+)
---
base-commit: eefa7a9c069908412f8f5d15833901d1b46ae1b2
change-id: 20241213-touchscreen-fca4a52bff58

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>


