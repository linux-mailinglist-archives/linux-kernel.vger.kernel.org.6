Return-Path: <linux-kernel+bounces-389628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6342C9B6F15
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22DAE283866
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E28B218D96;
	Wed, 30 Oct 2024 21:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="J2H7JwTk"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DB31D1E7C
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324044; cv=none; b=m2PNPnl9DcndqVkOqkqvzAmw1YPrk7KP9PshfSFoxHkoK/yWsaOpL1h5CXnd+obuY/sfQc29jpKxp3dYHZGX2IZ07oYw3PQXGFm+mv/WlgvwWoPOiOubFc7h7/9mE52MP/qtt5kxh84tZvwXAmpqz0SV9jCM55XWwDkUaTavQsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324044; c=relaxed/simple;
	bh=xAD+6+J55DPemJek11kr/Jq/FAoAyraxtOihtWfhZRk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=e3AQjZQNB8TpGBFu9+Cz2pasy1lxOjx8CaYiIUfqMsS9q8VgK1nEegHqtuEg2Agot5JCIvw83DQBKJvp84OfqBJcLBWvdT51ZnvFEnnLSkSKjAO5p0DuoaCy4uMdyXMlEaD5rYuFinqqnYf9NbXN3napDT1bsZsm2+oC58OwTCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=J2H7JwTk; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3e5f86e59f1so197543b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730324040; x=1730928840; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Y7RPUx3KMPE26yjaIC0NfMX0BGsi69Aouu0wh1lVz0=;
        b=J2H7JwTkCiCd9i7XnVvL646uqVJ8QCNBd+cw5HDmjWiIrMcZ6pmVlEBKi0mvJ4TJWI
         Xg2VgFkOBdTrK0XWqB/ZTxBqPlowEteOUGO6Pyt6AE7DkkCeNxUZjmo2ZrWz2/i0nJ+e
         SEJPQiK7X0XmiWH6pJZ7Ncih2djf5MrWAVB0AhN0JxojfXHJHKc43RU6kmoWq7tNq7/r
         W2sZkVgOl1kYFHVtPR9uPl1BZyX2NQQ7ja+TXmiVjwrJqOnCpgQSTWdtM0bRlagHIQnm
         FRafP6GbP35MWDtNrfnZxbAGoJ4fYL4y/19TdBu5u94QqdiSBmUiIw802tD+dq1K9PML
         Td4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730324040; x=1730928840;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Y7RPUx3KMPE26yjaIC0NfMX0BGsi69Aouu0wh1lVz0=;
        b=Xbn8kIUpZXN4gY9i7+Ho367bjni6ddJJii0ztgCQ2OuSKLI7O0Wsi89lVJrIb87MKw
         St/W3JB80nKNrlRxPC1Vj5Lvun8nq8dxKg3QDnXCRZq55/Zoro8RePaRpaI4rujxE5nV
         LvPdlj/U2s8r9vTOJUT5AyH1yjOEMNH457Dc42jN0AJmupwMR8yAFVtCnG/rchldyImU
         wvXw0owiLWub1uHVEQ8+UhTZP9c0OcbDPGSMa/SY7fAAeOGyA3MfZSiR3FdOD+A4gd3d
         XvddG34Gj6u8lVXLoHjDKdnaWG7SNyUa3mRCFrflmW+IJ06suswUJLTGpwjZOA2R870V
         mHUA==
X-Forwarded-Encrypted: i=1; AJvYcCUCbBOOWx54xPoOtwBNID66+K4PAsF8QgRwA606vRqFwch+Y7k7CuObSsbfZvWs1uc6YR5V6r8GPewCBBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhqqxaiN3SUGki72R2BTZcI5X5KgKUVzjYNtQnOxOi9vTT2E9h
	AdvKPMg/tG+hRg+dDeya2sknvd+2XVcWXeNrWodc6I5MVRoWHqgh4xKAY834LOI=
X-Google-Smtp-Source: AGHT+IGB2O9gRZPROliM0Hcdi8+6D1eD/5WXD3xdEwRwuS1KmFiAzuK+QNPzUly/kACYth4P/XB9hg==
X-Received: by 2002:a05:6808:3c85:b0:3e5:db57:c479 with SMTP id 5614622812f47-3e6608a9bfbmr932021b6e.3.1730324040252;
        Wed, 30 Oct 2024 14:34:00 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e6611a661dsm52127b6e.14.2024.10.30.14.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 14:33:59 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v3 0/2] dt-bindings: dma: adi,axi-dmac: convert to yaml and
 update
Date: Wed, 30 Oct 2024 16:33:55 -0500
Message-Id: <20241030-axi-dma-dt-yaml-v3-0-d3a9b506f96c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEOmImcC/3XNTQ6CQAyG4auQWVvDlH9X3sO4KDNFmoCYGUIgh
 Ls7sDIal++X9OmqPDthry7RqhxP4mV4hkhOkTItPR8MYkMrjDHVMSLQLGB7AjvCQn0HJjeFJot
 cV6zC1ctxI/Mh3u6hW/Hj4JbjwaT39b81aYghLxskTKvSZsm1pqWT2vHZDL3auQk/ieqXwEBkS
 DmbwjaY6S9i27Y3ckDarvQAAAA=
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Convert the ADI AXI DMAC bindings to YAML and then update the bindings
to reflect the current actual use of the bindings.

---
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
base-commit: 52a53aecddb1b407268ebc80695c38e5093dc08f
change-id: 20241022-axi-dma-dt-yaml-c6c71ad2eb9e

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


