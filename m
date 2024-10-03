Return-Path: <linux-kernel+bounces-348636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1497498E9F7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AE331C21A21
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5660654648;
	Thu,  3 Oct 2024 07:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Df4rezYx"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6442323D7
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 07:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727938908; cv=none; b=icjVkt55S+DlvVvcgKxXbPI40nycFhDZOHw0IX3NXVXTfrwm8raJ9KcomEw+a8sXdoGa6ItcO9hFH9Y2MfAs9eao4KA+g2by+3awvDuUqypLX/EzXnV1dAb6DKYneRHgctRzDOHl6M8UKFKsfUZOb1DrDxmJHHfCqL4wtBZSoBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727938908; c=relaxed/simple;
	bh=NJyRYUgZtjXxtOlk4pU0XNCvKW0BQnhXD/BFMm7aoSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WpWq5OxypDRe5M1rrc8QNwo0kA5DhwBUUYvEgtb9SCVLiL8BoHg5rcs9nANUnOwITMnkhEMR5TuFaATovmfL6aHHXpQFrvfAj7u7EagC/NA9Oo9gazthaFqQu1ghjxMkC0ht0axyswGtU8R5sngKh0qVjc0Cvv/7YVa+t/ikmNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Df4rezYx; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-718e285544fso525617b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 00:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727938907; x=1728543707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AZJgskQg5tDgPdSx1KJYs4rKBMoBQcgj9HSr6fJPbCo=;
        b=Df4rezYxBnV2VgqWxtqnxXtiwo4uBcCCVJhXRxi6w4c3AknPIE58kIaCZ3tvzuLW8A
         EPkhEBj/zg22NSVcr/xqm287XX2xPQFtJ/xqSrH//ENw+a+7ekmtrcxHqP/YXmOF9WOQ
         kai+6w/W2v9qZAxR3xNRiFV4t1fC/mPdrOvoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727938907; x=1728543707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AZJgskQg5tDgPdSx1KJYs4rKBMoBQcgj9HSr6fJPbCo=;
        b=JakqxOzsPpjZu5rBs7+9ogmXq75tq5+FmXY1dJELf0u8EC6rQWw3vqfNS+8nhaDeU+
         UY4ewDXzziUqDVdTZRGVsmH4w5R1g9i8BLSLMP7/hB6bAOStJiY/PFs8PSHKMRRfSTBm
         oJQU9k5X80vCh95xSF9UGZlKaTUIJCboblJWO3Mc/wvVl81rdlSOZVL3IYZKWUfdtJql
         azWAP4NyHjPrn5XpzHCi5SpYsC564xpug5P8GhbPAcfOfHfKgYOPpXA0tLjiNWA1fgaL
         2GBtXY/8XLNpo+HCs4Mvs+AyHpBKapiawuEENL0N4R6LdDDqCkTMpIP+Kd3rWSILTPGw
         Okgw==
X-Forwarded-Encrypted: i=1; AJvYcCVc/EXX+37YQccSUaZR/MOTGkaN1Otwz+qW+WFoAP1g0PvFVcfSwTjN87y19JkMkbvuxaUiDz/INGyXOHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgQGeZ3vSHNc9KUrba2rURterNHrjUOt6sgINXFVSboV9NPZiU
	KVqboZ0eZa3qnSVpS/TjSzUBjl1c5O51A/ekUzD1r6GpZMk7d1Ej8mJIUeDkRA==
X-Google-Smtp-Source: AGHT+IEtc9guZHmCHC6M224cCyhunrP9QOCWTENBTkqLfl+XJjW5TRlJ4EfZo91lZvdW9MJ3b/Yokw==
X-Received: by 2002:a05:6a00:92a8:b0:70d:2583:7227 with SMTP id d2e1a72fcca58-71dc5c485f3mr8062978b3a.6.1727938906729;
        Thu, 03 Oct 2024 00:01:46 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:3bd0:d371:4a25:3576])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9d8e473sm633782b3a.81.2024.10.03.00.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 00:01:46 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Fei Shao <fshao@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 0/9] Add platform supports to MediaTek MT8188 SoC (part 2)
Date: Thu,  3 Oct 2024 14:59:54 +0800
Message-ID: <20241003070139.1461472-1-fshao@chromium.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This series is based on top of my previous "Add platform supports to
MediaTek MT8188 SoC" v3 series[*].

There's nothing to change or address in that series at the point of
writing, so I decided not to resend it and start this new "part 2"
series instead.
(if I need to update both series next time I might consider merging them
into one)

Specifically, this continues to introduce the following platform supports
in MediaTek MT8188 SoC to lay the groundwork for the board device trees:
- PCIe
- MIPI DSI panel
- video decoder and encoder
- JPEG decoder and encoder
- vdosys0 and vdosys1 display pipelines
- DP-INTF
- eDP and DP TX
- aliases

Please have a look and feedback are welcome, thanks.

[*]: https://lore.kernel.org/all/20240911143429.850071-1-fshao@chromium.org/

Regards,
Fei

Changes in v2:
- add linux,pci-domain to PCIe node
- add power domain to PCIe PHY node.

Fei Shao (9):
  arm64: dts: mediatek: mt8188: Assign GCE aliases
  arm64: dts: mediatek: mt8188: Add PCIe nodes
  arm64: dts: mediatek: mt8188: Add MIPI DSI nodes
  arm64: dts: mediatek: mt8188: Add video decoder and encoder nodes
  arm64: dts: mediatek: mt8188: Add JPEG decoder and encoder nodes
  arm64: dts: mediatek: mt8188: Add display nodes for vdosys0
  arm64: dts: mediatek: mt8188: Add display nodes for vdosys1
  arm64: dts: mediatek: mt8188: Add DP-INTF nodes
  arm64: dts: mediatek: mt8188: Add eDP and DP TX nodes

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 643 +++++++++++++++++++++++
 1 file changed, 643 insertions(+)

-- 
2.46.1.824.gd892dcdcdd-goog


