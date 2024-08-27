Return-Path: <linux-kernel+bounces-304032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3659618EB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 23:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6C9C283C62
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 21:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D381D3634;
	Tue, 27 Aug 2024 21:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPFQVQOG"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5DF197A7A;
	Tue, 27 Aug 2024 21:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724792486; cv=none; b=mzuGwofE2s/Ps3Wfs6fDRQQSyTLfGkWu/Rta3/GCcokndqxK72woD1KHSUWPdJJov0qPAGCQassOEWojfnwQhheEi1pOPPUt6ppqKunhj9PjKqAWbwmA0n8/OELFNcvgh+H7a4f4cAk5G23QBI3Vw+V2bQk1dgqWEnC/EPyQvCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724792486; c=relaxed/simple;
	bh=usWNg3YCPNSMfYd3cIsqzqUm/OvMLGLPE61i3N326PM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BwFMZylZPFlH+u6EJZddaqKGufoRW8bnXIBB6M/dVViJmiP1p4YCzZpwtLJes2pH61XetquKMfsfXg3IQuaVXQHeKroWLkKh4/FrzooiUTZ9+eMisQ0mTA/l8odWj5Bz0mInQB7/H9AIquZWHPziQXTbuP7qfnHdx4qXFLliZws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPFQVQOG; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c09fd20eddso3117657a12.3;
        Tue, 27 Aug 2024 14:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724792482; x=1725397282; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6mF59s4e9GQ30bjpcbJxfb6SjZW26Gx1uj0s1ti4M5I=;
        b=VPFQVQOGRgo0lqaHe7w6cohYsKHnrOLy/QslfFaLPSwfH4va05UsyCd1Pr+IujD7W/
         sFTVs8tQ8/ha4df8QBIIJ+RmYrEedF0mSnw216+P0UPMe/dkI+kWUZ5dPDK4nxh+zinv
         8rl0DNitPQjYpb+9VUnEUVjLkMceykJo7488gEqBTvAkmK7SMXhw7e1YkODHTAQc/Avd
         LU5TWA2VSmSF8m4hpxsnYQ0C/wxQWcUCtWmo5/WFW0FgKLE4GEHzVjuyyJ2wlYXzcNik
         RWHwh6OI90OIoEaYXBrijzaO7zXTp/XTDaW1ct5Qh1osFbnnXqIMb6RO/NvaiOT5pXzw
         xI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724792482; x=1725397282;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6mF59s4e9GQ30bjpcbJxfb6SjZW26Gx1uj0s1ti4M5I=;
        b=Iuo7sO0W1S4Vh/FxF6zLgVVM1drjqalzQ96M221oE/qGAV84I9Zg6GJQHpvjzszW4s
         oRVUMYHbT2A7yzMBeFETKFmM2vEoZfF3Fbf/K3Xm5oj9Q1cile31ArXasmQPsalc0YNO
         NSa6lAZdGNENypcxgGgPsU1e+iJaI0QyblrU017VJgY3PDby1YemuRMMH+oVMGSRP258
         SL5w9i4CyOio//nS/SQfkwISCtRUIpyqC3S3XwbR0u+z9lgzx5ob0OG+MtAiC6BI6CBv
         j2lx5mKbgFwzI1QCjGGAtoF2J9xjLd/JdKiUSCBSOXA2OLMT3DKStpRIIjn72/Ysqr5b
         dBUA==
X-Forwarded-Encrypted: i=1; AJvYcCXwEbXYnImssNQjQbe1bsYaWmYVqUAP8r9kdu+rqV72+07c9czrqXISzU39IQZ2+vwQJsViZYDBFJID/NU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXm4UIN/8wm/M4I1cXLSMrTiS1Hll9Szndj1FTCrRYbfI5BLK9
	/R1/m4lZjGR+8Y6f91kA6mrgJjJVRJrQ/Mg2TVBf1chwhY0bay0/hr0EofuQfrA=
X-Google-Smtp-Source: AGHT+IHeAYIq8ZK2b9C5inDMUKXAqiguCU5CEk35GI/I03s053vBBofOZLle6SADgKilXe/GFeohOA==
X-Received: by 2002:a05:6402:1ecb:b0:5bf:8f3:7869 with SMTP id 4fb4d7f45d1cf-5c0ba2b8b7emr2727653a12.21.1724792481486;
        Tue, 27 Aug 2024 14:01:21 -0700 (PDT)
Received: from cleve-worktop. (85-193-33-82.rib.o2.cz. [85.193.33.82])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb1c3114sm1405835a12.13.2024.08.27.14.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 14:01:21 -0700 (PDT)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
Subject: [PATCH v2 0/3] Fix regulators and assign them on NanoPi NEO Plus2
Date: Tue, 27 Aug 2024 23:00:42 +0200
Message-Id: <20240827-nanopi-neo-plus2-regfix-v2-0-497684ec82c7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHo+zmYC/03MQQqDMBCF4auUWXeKCVFLV71H6WKMEx3QJCStF
 MS7N9ZNl/+D962QOQlnuJ1WSLxIluBL6PMJ7Eh+YJS+NOhKm+qqW/TkQxT0HDBO76wx8eDkg11
 TKdVYVtoSlHdMXOaf/HiWdinM+BoT079nsDO43w+2qAcaJexwxkWhwtbWru3JmJrcfZhJposNM
 2zbF65nCeW/AAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724792480; l=806;
 i=cleverline1mc@gmail.com; s=20240824; h=from:subject:message-id;
 bh=usWNg3YCPNSMfYd3cIsqzqUm/OvMLGLPE61i3N326PM=;
 b=zxoLESLLq24R3sH7xZvnxDTPC8MqEWSAzHNx/zAj1mXEbGLtRE4nQnz+MmEA4+ixlxw333hPa
 WI+S+UoeoChC7utoYf9tHcOJeQ1xTiSN01kiF1O5DZfUnIGfThWSjqE
X-Developer-Key: i=cleverline1mc@gmail.com; a=ed25519;
 pk=CQifx5FUgTQKAoj5VCYrwYHi235AkXQ5yT1P6gkaBxM=

Many thanks for your feedback, especially from André Przywara,
I learned a lot from you and your kind words motivated me to do a follow-up.
Regulators should correspond to reality (schematics).
Proper regulators were added for pio and r_pio.
Added missing regulator for mmc2.

Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
---
Kryštof Černý (3):
      Fix NanoPi NEO Plus2 regulators
      Use regulators for pio on NanoPi NEO Plus2
      Add vqmmc-supply on NanoPi NEO Plus2

 .../dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts   | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
---
base-commit: 6f923748057a4f6aa187e0d5b22990d633a48d12
change-id: 20240827-nanopi-neo-plus2-regfix-b60116ce12ca

Best regards,
-- 
Kryštof Černý <cleverline1mc@gmail.com>


