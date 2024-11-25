Return-Path: <linux-kernel+bounces-420576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B549D7CD1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 658FE16313F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CB8188714;
	Mon, 25 Nov 2024 08:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lIgl0WCU"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE0515F41F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 08:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732522904; cv=none; b=FS0N1pKtkDihi4t9yAb/vNmGvrQVkAGobR0TSZyzIxJ7S62DD0a1aBpgJW/Bqy5aPp7mISd2kVyqE4yo7TVoSfUuuJmoTBJUPZI2ncfyU2tX078hrjm/I2pYQsWyTZJnWzx+6rI64PmqWAva6TkXb7SHvW+fTPug3LJlNRPTRDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732522904; c=relaxed/simple;
	bh=UoSKl7TJOogkZt4o8FxS/fJ8sB2gC0Uf1Z0S6lETcEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tIwCb4MpEuzpzi5EqMNT7FbclEcYFAe3eMmBz64KNJQk7j1gWXXmqJUDBRBQSOKtUHepEdN7+WFj1awmqmcbGehhLa9zLbG9qV5yMw4m2yuRx/7Xi3xM3GkbUEWWTAv/OgkNelDIS+b15TG1p17eIOkg+XkQjaxkS5uRWx/UyD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lIgl0WCU; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d0062e9c80so5337309a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 00:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732522901; x=1733127701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V/7BP+eiBJ3tguIkvumVtoPzEUTFOBtF5H0ionm7gQI=;
        b=lIgl0WCUZ9tNOV8wf9jNkygrR+jJdOoHqmh0oKg1Q2VBBJjPbbfSv+04MrPKoRsPic
         jERmmnbdcTwFc+8E9QMYvJ3Z8PfcSOeeiNG/JSUsY+NIGl7FAoxnE4WHNhrZYuPtHrXy
         qbOAfCXRaf0k9U2jrKpuF5CycaGW402U+s57w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732522901; x=1733127701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V/7BP+eiBJ3tguIkvumVtoPzEUTFOBtF5H0ionm7gQI=;
        b=W6kW9OrXk7rpI3dd0D7HWLuPjWHvXjcv7wJV5UwmHBzMgM7JOZqgK1XLGu6eFviiuF
         F/tnmkcFAuMo8z7JSzX8cD62UI2wGcrSsIXtG0/URTo45IhJLueO5gHcPsIsGkSVRESx
         B5SKrhV6960a9C8x/qoAsO6ajlXJ5GiDgLJgh6R8XmY3VfWVyhjWmPKs173c8ySYXrwf
         6brp0e4PDbD+Xnsa4m1G8UCxnZLMy7Hj/d+jJoFw5/2L5k5GuCG3nx1RMVuI4mZpkkJI
         N5lptbM3lwzuu8VxFWybVbarYvCMdwuR9XjXHRoFwygHYZ687pbvzYAed5mBHl4N/HSO
         CKWg==
X-Forwarded-Encrypted: i=1; AJvYcCWs5vpYByGjTaWDWqSNUm+n7FsS12QgCMKn2hbocTVWKx3tb+SJqb1vCCxJM/NkqUc7NFHq2T69HlTQWx8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcxco+CjxlEBKodG5LfmJNiQ/AR0o2/BiKQb0iZ2Fj1NXn1Ve1
	pIDIZ9OLxjnMXOxcCZ8DuqyayAkUmthoeefdcthiLbMP84YXK9qP6dZ1z2M7jQ==
X-Gm-Gg: ASbGncvufdj5anw8zI5M/32+SKScZgL4PKUg5UyULCLmn6oGT9X9WTFplq77mdkCpCK
	JhmaDj4KPge0veVWLo6WjiZ30yam/WSOp6n/z6tJoBB+Fh+ds3PNRGS66UyF72nFSjCnZ6Ai68O
	Rz5/z81T0Oldc3acyWQi791Hj2+Tpejfb7BZSCxIsCyJ2XY9vojG6PT/zTNHOEfsXFL4cr0oxIA
	/F/rrUYv2WJCLYkEs7aTBwRbrazOxrzo5FNbQC+rco1thSQrPkqDNN0TlIhpl+QlM/N60ox9szI
	/LKDbu8W
X-Google-Smtp-Source: AGHT+IGY+FX04mfzxmplompk/IW14NqbgJnlcBAfKd6jUF+oXS9F+fBvE0X/zqk8o3s+U3ZXOSneZg==
X-Received: by 2002:a05:6402:234e:b0:5cf:e894:8de9 with SMTP id 4fb4d7f45d1cf-5d0205c6315mr10497739a12.3.1732522900638;
        Mon, 25 Nov 2024 00:21:40 -0800 (PST)
Received: from localhost (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-aa50b28f719sm430537166b.12.2024.11.25.00.21.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 00:21:40 -0800 (PST)
From: Wojciech Macek <wmacek@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Rafal Milecki <rafal@milecki.pl>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	Sean Wang <sean.wang@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Wojciech Macek <wmacek@chromium.org>
Subject: [PATCH v2 0/2] Add Starmie Chromebook
Date: Mon, 25 Nov 2024 08:21:27 +0000
Message-ID: <20241125082130.2390310-1-wmacek@chromium.org>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an entry for the MT8186 based Starmie Chromebooks, also
known as the ASUS Chromebook Enterprise CM30 Detachable (CM3001).
The device is a tablet style chromebook.

Wojciech Macek (2):
  dt-bindings: arm: mediatek: Add MT8186 Starmie Chromebooks
  arm64: dts: mediatek: mt8186: Add Starmie device

 .../devicetree/bindings/arm/mediatek.yaml     |  13 +
 arch/arm64/boot/dts/mediatek/Makefile         |   2 +
 .../mediatek/mt8186-corsola-starmie-sku0.dts  |  29 ++
 .../mediatek/mt8186-corsola-starmie-sku1.dts  |  46 ++
 .../dts/mediatek/mt8186-corsola-starmie.dtsi  | 480 ++++++++++++++++++
 5 files changed, 570 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie-sku0.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie-sku1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie.dtsi

-- 
2.47.0.371.ga323438b13-goog


