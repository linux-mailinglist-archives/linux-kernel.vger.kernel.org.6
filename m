Return-Path: <linux-kernel+bounces-448144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A709F3C21
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034CB1688EB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FD81D8A10;
	Mon, 16 Dec 2024 20:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IIPdAtkO"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3697B1D515D
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 20:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734382277; cv=none; b=uT98DtoTf6KPbYL7YNArZFkqQORTPO1lwxnbifXKB98hHgpTn+fR/Ehntsun1Okqa9PpPCfvluBhPTUgXXF9XwdLoaB/xTDeo/sy38z2fBpgkSbNEiaI8iQemUjySZ2yo8LEcq93zE5hp6DpbDh4oulnc/l07zMdkR09hrqXML8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734382277; c=relaxed/simple;
	bh=vNP9A4C18JfdqCO8C4qyuw1JeEu32Q85qs6oleMDKCY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qVMtA4qWpHJGuPyYxXqY7gEm58jaW2oKs6evMRaORu+eRBQeWEIHbmCGNzdTeLSCqUyV7VZjl+BTOv9wyOyL7Brwob5eugBWGA0ss6mKAbpJd71VSfXeAFP3qSQwcNE71GpLgC5D4S+TlJu3HM2BGi4a5UNXL6cseKm2ll90/E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IIPdAtkO; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-71e3eb8d224so684178a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734382274; x=1734987074; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=URnb8c85jwthSeIOjmWdLO1dJRmKyq17s+Or2MsbRA4=;
        b=IIPdAtkO2B2LU+1Ckv2905zDjbiMTKqgWvgFpdSgnN+ebUeOcWydpiZIsll4vgfNqP
         uqt5GJSv14eeNjsdkdmExHW4q31aT5rqrwPCY2QcRRohDc95ksrvfCvEZ9AIOrLGIh+D
         TgjoI+7mPkjuR2dvXAZnr/YYi7Oe5hsOanmxGQrq5NWu44Fzw5HPg3MPziGPtKBiqAr8
         yBOHTOZ1krBq6sEzCVb+hmmH7sqLipkgP0L//THteI0SPMvXV/0H6pANq5mIoI9dShRG
         jMS//xvW/Dsqs7U/VQoUlCU1/P2VNrOa4W9HlEyG7FwzDs7fJNUsOfENUEm/3hNQXYYL
         +21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734382274; x=1734987074;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=URnb8c85jwthSeIOjmWdLO1dJRmKyq17s+Or2MsbRA4=;
        b=OxA31y59l1Hd6+mNhL7HguXfVYm9VXhIlHh0rn0bwlGv2myKvD01+RfbITbYBigvMt
         9uOzLTIRIJCNOzKSfA9O79uW67QQHw+eEOOMH8GLptJ85RKk6LLCx7RtFFPDAC6MXnbN
         uIyFAgmeEzxYYZI9CA5pJFx1ufQ7bIClc9Ltg5W02OTzCrCff6PRL5wmq4FbjvhO6lH0
         eGaZMm/53K6hLdi7lgXYFvJKK0MXY+QodWlx3DBn5c2etXOswsb1xnVOZUMkt0j4EgF7
         UmnDqEx1Y+5aUVSgIDlNhU8K206UHnnaSQSZIotZp7ZP41+0Wg9PZwf+/jfPwe5asgay
         O25A==
X-Forwarded-Encrypted: i=1; AJvYcCVBHluiNYdk5i1RI5dDFROxPWfQUWeKr/pSlWK0Eo/Vtg/cIzgcvPUaOp8JJZLzUCaRHTL0Cfsp/Lx9xWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYDK1kQ1XKTcLApd0qXTbvNgjkCE77HLXa4kMvBFczT87DHwX/
	YabNCUPqi8mfsSoGZkMvXq7RVAvkne83UYROlkLrvMvOPetm8UY+7yjMkycIzcM=
X-Gm-Gg: ASbGncv4/kefOLv4DZAjbp1/FftrxV5LdBRXguFeaflWuoYCzz/XSN+HR//TEULN5Tu
	5VKJVKG95rxhNgaj9QthzAi/EckeC3L3WV03Ot1G80invTzQARHHx7iSJZJVzGTRwogRWWG4PxL
	p5HDEXzHvg0RDvJbsf5yFuTl2UZ6ctHATlHPqLifjWDaYusqAAzHY8Ijv15xAcgunxKxz/47MUL
	KhujEwOKXAu9BEU+pxvB6bmQtWWy233a2akcZRn+XZaDrOTJ0BmXOEeUk4+btDxaWUzkSbsUnKG
	JhMqfup5l+BB
X-Google-Smtp-Source: AGHT+IH1J3XcLxwZtLTGQT1Z5igc3BumUE320qN/m0hlGwtTCk7lq302xmrBaQLKwY3jWYE1crR5hg==
X-Received: by 2002:a05:6830:440a:b0:71d:415a:5d30 with SMTP id 46e09a7af769-71e3b5bdb50mr8590525a34.0.1734382274271;
        Mon, 16 Dec 2024 12:51:14 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71e48355dc0sm1649022a34.25.2024.12.16.12.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 12:51:13 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH RESEND v3 0/2] dt-bindings: dma: adi,axi-dmac: convert to
 yaml and update
Date: Mon, 16 Dec 2024 14:51:00 -0600
Message-Id: <20241216-axi-dma-dt-yaml-v3-0-7b994710c43f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALSSYGcC/3XNOw+CMBQF4L9COlvT3kqlTg6yOuhoHC7tRZrwM
 IUQieG/2zAZH+O5J/c7T9ZT8NSzXfJkgUbf+66NQa0SZitsb8S9i5mBgI0UABwfnrsGuRv4hE3
 NrbZbiQ6oMMTi1z1Q6R+LeGGn/JwfD+wa75Xvhy5My9Aol/avOUouuM5KQNiYzKVqX+BU+yLQ2
 nbNwo3wTphvAiKRAmqyW1dCKn8Q6o1Q4ptQkXAKTZEKXRptP4h5nl+sAxrPPwEAAA==
X-Change-ID: 20241022-axi-dma-dt-yaml-c6c71ad2eb9e
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Convert the ADI AXI DMAC bindings to YAML and then update the bindings
to reflect the current actual use of the bindings.

---
- Resending since this didn't get picked up or commented on for 10 weeks.
  Maybe it got overlooked due to the dt_binding_check failure? As mentioned
  in the commit message, it is OK to make an exception in this case.
- Link to v3: https://lore.kernel.org/r/20241030-axi-dma-dt-yaml-v3-0-d3a9b506f96c@baylibre.com

Changes in v3:
- Picked up review tags
- Fixed rebase botch of patch 2/2
- Link to v2: https://lore.kernel.org/r/20241029-axi-dma-dt-yaml-v2-0-52a6ec7df251@baylibre.com

Changes in v2:
- Picked up Nuno's Ack
- Added more than link to main description
- Moved source-type enum definition to description:
- Moved additionalProperties before properties
- Removed unused label
- Fixed node name
- Link to v1: https://lore.kernel.org/r/20241022-axi-dma-dt-yaml-v1-0-68f2a2498d53@baylibre.com

---
David Lechner (2):
      dt-bindings: dma: adi,axi-dmac: convert to yaml schema
      dt-bindings: dma: adi,axi-dmac: deprecate adi,channels node

 .../devicetree/bindings/dma/adi,axi-dmac.txt       |  61 ----------
 .../devicetree/bindings/dma/adi,axi-dmac.yaml      | 129 +++++++++++++++++++++
 2 files changed, 129 insertions(+), 61 deletions(-)
---
base-commit: 95282a5c5eae59227d58d3b63ec57f377a9093c7
change-id: 20241022-axi-dma-dt-yaml-c6c71ad2eb9e

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


