Return-Path: <linux-kernel+bounces-229105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4AC916AFC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFAE128962D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2065816F0CD;
	Tue, 25 Jun 2024 14:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dWm+Fhik"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED6716D31C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327035; cv=none; b=W6m2PeCPk1ZlWSE3LsSAf8i8fsEdw5jR7xgSE99bCYkjWhPx5XcOSJlUoZOOpZFr7QG29/IW87R5bbHDkk6nR19DlDfFJYdKD5rAyQk+feq9fhpQue8DQ8iv3oFCkXHWgAgrm6V4pUM6l/Jzdi/HiNCjTTO3Z4Ia87i97PfbfXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327035; c=relaxed/simple;
	bh=v7iSGpLcLcU+iCmJ64zXmEkSR2GS0SCMYIqR/adHl5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XmU+Z0NwwQ42YdKu/wJQnPHHogWGg0Jnyv0uX2aKakItpPYsdPD6Go8Dq2zC6lbTqd7opt8Q0VkxtwBXPdBqU1UrlILzTgbwPpmAMXpnH7/bMHnOOIsTsYZvXnZRJqJiUA+UGxJfStpwWHtvPuGv/nlTZfPS0PDoVfI4XN2Chng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dWm+Fhik; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a724b4f1218so355667666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719327032; x=1719931832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lX3TM1Fki2eEB6hMLemhPlhYp9SkoeIi5lujOC+FPr0=;
        b=dWm+FhikNRotKsqVHUmd7Ez3paS+h5a8G36bwebWpPVAoWDKjLF+6nNfzHB3a9LiEF
         O/Ryh775hELrlwFn7atRWX8waU0kVCEauSB8Hio5j+FSQdXCzKnRIbW7XbhKi/fY5TJG
         6EFDBY8qQFsXAFNySJBDsV23pEmSWGAMxYqHXcHoCA3cLcWktpKZBWyCqv7O9f8OqCMO
         FOefhebUl9Lrz1BYPavzXM1NdmND5mmhfh0hE/R+ZGmqVMoBEfhPTT8XznXqJ3DoWhmN
         4p/cKg4ff88sY+bQ6ZKRX6K+JqUTPxyph2SAcWsQL3NnuTYTakwJst/Ibuvi9Aa7U33w
         n6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719327032; x=1719931832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lX3TM1Fki2eEB6hMLemhPlhYp9SkoeIi5lujOC+FPr0=;
        b=BHuxPKqwJn6VZeCkwY/1ox/6J6F52eq2q04qYyd4jD25J6M71HhK3341kHJgzLw/X7
         euWQgb5f0O5Zr90U04zxAz27WgIKaeUD/x2NKNndTLjMlpqZ8PQHDya9OJ+0c+ZUoeTk
         TvMfUK0V0sRQyT/dWfGW00WSJdU+D5QsOV85GnSJMQ+N76S8KK8iNZ227Cebs0osO0Qs
         Qoeh+Md+CLU8emWCubMxIm1YnvUG1HLtp3aS9rII3TZb9j1Efg6qhC76GVCWbImdbQYB
         aI1I622OHVF7eFBGiNyRf98/eCcBdPGFq606+gpVBXXn8lpcECUXjGmKZOzpontyQrAa
         1THw==
X-Forwarded-Encrypted: i=1; AJvYcCWDTIN1/641Ym+S2BoHnlUq60LDUuzyn+tRwXmY3E/cbk2XlM36iDZPUyfBcKD3ev3AANxv/DoYeAobr5ybkPk6MNU0R9TXMRnjXXu4
X-Gm-Message-State: AOJu0YzjN5bpEiF3Gu/ir5WtwtMUGAgE5z5YzOE2G4QSPk1y6XH8yp97
	8iQAp10KK1bzjZ4QM/yfIb2dp5Y0T7ywspfx8Dgd0ecODgwYkg124qNlqqIrS5g=
X-Google-Smtp-Source: AGHT+IFUUy+Ij+z9priiZtm1Z/MbuNV3/WMHqNwFfXw0FhxS9uRT69YZDNrxaFymHUjd4zBdIJFR/Q==
X-Received: by 2002:a17:907:8dcb:b0:a6f:718f:39b6 with SMTP id a640c23a62f3a-a7242c9c190mr463024766b.25.1719327032066;
        Tue, 25 Jun 2024 07:50:32 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:b30c:4c5e:f49e:ab33])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a724162f037sm355945066b.194.2024.06.25.07.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 07:50:31 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 0/2] arm64: dts: amlogic: add power domain to hdmitx
Date: Tue, 25 Jun 2024 16:50:13 +0200
Message-ID: <20240625145017.1003346-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

This patchset add the bindings for the power domain of the HDMI Tx
on Amlogic SoC.

This is a 1st step in cleaning HDMI Tx and its direct usage of HHI
register space. Eventually, this will help remove component usage from
the Amlogic display drivers.

Jerome Brunet (2):
  dt-bindings: display: meson-dw-hdmi: add missing power-domain
  arm64: dts: amlogic: add power domain to hdmitx

 .../devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml   | 5 +++++
 arch/arm64/boot/dts/amlogic/meson-g12.dtsi                   | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi                  | 1 +
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi                   | 1 +
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi                   | 4 ++++
 5 files changed, 15 insertions(+)

-- 
2.43.0


