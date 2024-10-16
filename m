Return-Path: <linux-kernel+bounces-367468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5A69A02BA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE0D1C2498D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AE71C4622;
	Wed, 16 Oct 2024 07:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gew1NzeQ"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EB41C1724;
	Wed, 16 Oct 2024 07:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729064248; cv=none; b=J5AK6xagoPmiVjn2Kit/lTyOnHYE12UWjIKCkTHU2WP4CvREbCfvYx++G0G8FInNzauy75w9xIZZYPyH5fMl1Z4OuJdogFCp6aqcNpn0K3iWeB4l6p5qjkGaVsHuzFRFOiTuQDAzK5M3HHG15ZSQrzkV0y9U4RkIfS2t9XUlyuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729064248; c=relaxed/simple;
	bh=1aygPNI3MrtPWGtPuWmjnr2yDdVvTyC+RH4vScP5os8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uzoUfAWKIa5ACGRVnzFrnl5WXHcDtC5WFvMpkMqLNeKKb3j6iIYg2n0p5y3NJpTN/jx77434Gp2kBWxUec6+2C9Fa0KU9zP/TOG9idCKda7IGL1QIkfVr2QiZjuBZJxG4IShQGvubb5iK5bkF0ZT4dKA2cdU2XanEULUZjtfY3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gew1NzeQ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e2ab5bbc01so1071039a91.2;
        Wed, 16 Oct 2024 00:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729064246; x=1729669046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdXBvIE3AExRgp3hXtIJcaBGzKqp9wpTyWZscjBbOt0=;
        b=gew1NzeQYFNh6GQt9kbrUg7kJm/xvKn77GOIDtj3WL/1YsJ+IUqpKE76Me1rBTY7Q/
         RmMyud7Glbj8oyCVnZsWbNdmFKA2KvOJPYCMzfkgJuLFPdoma1eB2r3LJlIXmafZoI71
         rof+R7x9agAhvS7f1qCUZIZtkRNMrA758q/g4UqBhCpMj/VJq6n3Dd3NCaNhqv5w/pXY
         kHesDt22fuBaknxm7upYi7abJjAXxE2c7MHP4hlp9yf0qKUGt2Hmz4j0AI2Xq3ulFavI
         YSJUl7EhxwgiwUmPxZbEy/6xBAPklhNRvXcifgCjKzb0tGLnoEEmXqBoS3ZlCQAkghfn
         H/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729064246; x=1729669046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HdXBvIE3AExRgp3hXtIJcaBGzKqp9wpTyWZscjBbOt0=;
        b=sksi4XVim2IgRlG94pORvVsvfgZjaQTQXeBBaNL92voc5Ra1c/HRBOw0YC4mCKmeg8
         djHaL9tAvJvsX2P8/2H2gsuqVV8Z21D7xG+aIndqHZCAFx4265mi/07QeHdEdJ4xT7Ji
         BH6VPVge1DTvpVH5YFl7FkDvPaVwpPh/V0ILNI24sob4L4BL+hGB3EI9YutGpe2FOZEY
         eSN116dTcpZ9BYzWWZn3wdrgOsWfOG0bhmJCsZcMfEUuFAnVG0QrP72hFoZZeoS72e/O
         Ur/xfb2wESTeEmPuaj7pj1/g0gzCLQkGHMdg9BEU3XVpuuuu/Z8tmjvvLE6BFx7YZR9+
         rl8A==
X-Forwarded-Encrypted: i=1; AJvYcCXOBTIC9N3lmV8fhtmxYK4wYxm71V4YTfRD2Fi9PPGe1Gc7SCkhIKPKjex8KDPU4rIeASOT1rrT82il@vger.kernel.org, AJvYcCXs7uFtvVD067eNTGdvHOXfQGEmFuLG6bm7DH75uw4RX32kp2z83PLUkUbv1rzWkFKPJIp1Fm5H1HoZFCAI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7SdeKVIG+V0yyheLDC+jLM6FUJ1wnjalvaIGqGfFX0mWetLW3
	8m6/jXv+9y6k0FiO2dxSnYB6tyobO2+1CadZ3IFKmK/2YJWxoKPUWWUAaw==
X-Google-Smtp-Source: AGHT+IHTFYf2RmMoLVt3mWD27psiArXEXPum3fHQrqEBzIUzKiTNe15MOy/O+7lWes5lJSM0AcAojg==
X-Received: by 2002:a17:90a:680e:b0:2e2:e139:447d with SMTP id 98e67ed59e1d1-2e3b786ebacmr895197a91.0.1729064246313;
        Wed, 16 Oct 2024 00:37:26 -0700 (PDT)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3b7e6339fsm765471a91.1.2024.10.16.00.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 00:37:26 -0700 (PDT)
From: Frank Wang <frawang.cn@gmail.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	william.wu@rock-chips.com,
	tim.chen@rock-chips.com,
	Frank Wang <frank.wang@rock-chips.com>
Subject: [PATCH v6 2/4] dt-bindings: soc: rockchip: add rk3576 usb2phy syscon
Date: Wed, 16 Oct 2024 15:37:11 +0800
Message-Id: <20241016073713.14133-2-frawang.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241016073713.14133-1-frawang.cn@gmail.com>
References: <20241016073713.14133-1-frawang.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wang <frank.wang@rock-chips.com>

The usb2phy is accessible via a syscon registers on RK3576, similar
to RK3588.

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
Changelog:
v6:
 - This is a new patch adds rk3576-usb2phy-grf syscon.

v1-v5:
 - none

 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 50d727f4b76c6..62a28cb2bc7bb 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -80,6 +80,7 @@ properties:
               - rockchip,rk3568-pmugrf
               - rockchip,rk3576-ioc-grf
               - rockchip,rk3576-pmu0-grf
+              - rockchip,rk3576-usb2phy-grf
               - rockchip,rk3588-usb2phy-grf
               - rockchip,rv1108-grf
               - rockchip,rv1108-pmugrf
@@ -233,6 +234,7 @@ allOf:
               - rockchip,rk3308-usb2phy-grf
               - rockchip,rk3328-usb2phy-grf
               - rockchip,rk3399-grf
+              - rockchip,rk3576-usb2phy-grf
               - rockchip,rk3588-usb2phy-grf
               - rockchip,rv1108-grf
 
-- 
2.25.1


