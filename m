Return-Path: <linux-kernel+bounces-231070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA659185C4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE3D31C22272
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC302185083;
	Wed, 26 Jun 2024 15:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pE3eXARI"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C2218A94E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719415666; cv=none; b=URl9UGqgOmw++tyfU3OyBQrUdMSIbtGHIPLj1JOJkjZb7zOQKfPlF9woY8DnAZ72bndF2QSP1nR+ePOAqAtk2SEsaGg/4P4DmLnVn2hJmnegt1DP86mwGz7T6gqXX+l+MqregcwddnmSHpJTYOgS4Qz8658RbwhTtn7+v6bP9b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719415666; c=relaxed/simple;
	bh=R3GS8HHHErj7MvZI0Ir09AX9yQNspKMfc3Km8T303a8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cft1LzDOUT12xAbiHs8bgT7F/6Tg2zxbhXYXWiMdzlkDKPW4mxEVAfuqem9krVK33lp8pJvv1DqLa5phvshN079fYfrNKz5fRP6Hu55kDRWUs+BpmjFGd6fuZyg5iWej1RqkI7uva3OKiWwuUsTtmJqTxYamukX2lJvX1nLXHOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pE3eXARI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-424a2dabfefso20487455e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719415661; x=1720020461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jYDKthMr8PlU7RMNm/cVX+jCdaMflBOcufutTHJLPhY=;
        b=pE3eXARIr+SEf2PYxFXfaqiBV4RTTutnmpMApLOZZDNI/TleRCFm7zUed9rotYL+PG
         7KeD2bqHdG1HJRFwQmqDFb/O+y2eLMOr1/dYDkU06QL8RijQ7UidSW21uQHjFXN8p2Qx
         XyY0h3QFGCQAuiakiKuFS1V0rWzvG/xamN5nymJWbA1HrcbrO1ib9ji+n2uenkU8U8eO
         fH5aqK17hM4A0KseQ3czZJZtyVv5NFaKe7zCJJQMDRCZl+fumeb9PSLAZ7Jj4tg+bNuV
         ANwPCtST8Yg63K63FQ4NyKrPUdfmFLKOg/h2Apl6mYNod70XAp9nHYafzWgoZKgHCV1X
         jqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719415661; x=1720020461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jYDKthMr8PlU7RMNm/cVX+jCdaMflBOcufutTHJLPhY=;
        b=taKMTP7i9k224B3vSFf+6hE7mg5tZ/euEReYQOv1BaN5AAZ/ZU78aDQvb5hDzJL8+K
         Cf0m2YlVM65qq0Y4CfflcF3w/zp0x0ZP7NpiZWAHT1MwVWuthSooU9xcKO57jjAsIbDG
         JYyhCHgXwLAbX26jCdO7vn76H0dFkkziBUKKVOSGzTFDXT+MgbfKyxdtojrwqrVsdFQS
         zviYqO8fOmRdvKqwYJfffF+BTt73Fn/RGM7m+kffv02ULaM+fuAWADBCWSjRc1vz8sQU
         jPDo7Pd1RbWdk2QLSROEWhRmuvEwN6ONVxGBz98vfSF+V36sOnic5IpOR7yY/+5ILCaf
         0CiA==
X-Forwarded-Encrypted: i=1; AJvYcCXXFA4GXNuZFBrkeEsK/qZv1z7eC/Hv5mDOkrsFC1nNHOrvbcWRuwZq+X9x18MOwqhoyef5sLS8TgMvXUqCawE8DNXsYEDxoj5ozdP0
X-Gm-Message-State: AOJu0YzJQv/BFKaGdwqbO+/h0okWy4drjc/e8Kseyk725PE86yeHQthk
	svjADusNlTj/ZgTLoy7gzdfNnxlM8mqdymlzaH/TEpIDL4Z7HCEJ5T3vZNi4f8w=
X-Google-Smtp-Source: AGHT+IEMQpIEwx0dH+XhPkFS6EJi2CgtiwjD7ua3gdSKxmKrlk4K/C5rgHIgRTqFkzvhQeFAcYKPsA==
X-Received: by 2002:a05:600c:3514:b0:421:e7ae:955b with SMTP id 5b1f17b1804b1-4248cc3415bmr86578825e9.21.1719415661304;
        Wed, 26 Jun 2024 08:27:41 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:7be7:aef1:af9e:fff6])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4249b4233b3sm42321675e9.0.2024.06.26.08.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 08:27:40 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH 0/2] arm64: dts: amlogic: handle hdmi system clock
Date: Wed, 26 Jun 2024 17:27:29 +0200
Message-ID: <20240626152733.1350376-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

This patchset adds the setup of the HDMI system clock for HDMI Tx.

This is another step in cleaning HDMI Tx and its direct usage of HHI
register space. Eventually, this will help remove component usage from
the Amlogic display drivers.

Jerome Brunet (2):
  arm64: dts: amlogic: gx: correct hdmi clocks
  arm64: dts: amlogic: setup hdmi system clock

 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 5 +++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi       | 9 +++++++--
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi        | 9 +++++++--
 3 files changed, 19 insertions(+), 4 deletions(-)

-- 
2.43.0


