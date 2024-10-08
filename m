Return-Path: <linux-kernel+bounces-354352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EAD993C6F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 03:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965E82842F2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 01:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697981DFD1;
	Tue,  8 Oct 2024 01:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmOKKrRJ"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CB3B669;
	Tue,  8 Oct 2024 01:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728351844; cv=none; b=G9epa0hywCds5WyvwAJH0T4Vts/I9+IhqqkUA+s6fYFVrgzifSTLpi/5a23YzKIL0gkjb4juuGsPtkULUCrWZhOENI/fZX40ZwJmII0XVWT3YYQOeB6vDSlAgA27D1cRIhSfIedzc57NbSWLNP/PZ1fMwMZbzRkTen5AQ/eUt+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728351844; c=relaxed/simple;
	bh=dacwKXbCV55NUVj9tPto/lozv5grPYQM3YXGg9J/Do8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Aj0ncRXDHzsn7RYFtTb8aQftf/eIU6Q4+yOrjctrcpGY7KsGLOkoSo7b8GJ/VzoFguMdq2PMVpacbF4Wb6t/KfyYqEzYngAVAJHOnk6SfP0Xi7Zn+ls6Wu0Cex27hcg9IN9j4v6m8eJ2mOSDpeIFAgBhTN+xF/qFAXI+83HCEVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmOKKrRJ; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5e7a6de544cso2456793eaf.0;
        Mon, 07 Oct 2024 18:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728351842; x=1728956642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMA8NIgbUUWy2PaRc1Fk8S2RKWxEcaTI3Gg4Jjq/WS0=;
        b=AmOKKrRJggjbpnqiwoe+eTqX/53r8JYDBrpgS4J0XVaHaU1iBWGSZOw73/hZF52DSG
         PepyjtXpiY8EWGUcZ1yJ5ibmz+QXavI7vfsvy/GboSKfKFyakZpkBN5ZlcxB/4sIkDq/
         YH4JRf0SbGjJjdWUfSxu7vTZuqGg8wifEWb+Z2gHEyr1yv5NOaGWGn5iy9qml3Bc1OAb
         I7rOns0XDv0TZUKqJgMzFIykstbk+fyOfhHW3cByGMXiXzJ3b79rVO1ibzty94IG/T8r
         sMUh3do67WMTh5AcFijuuFm7kDDJjpZbie32JEOuYzF+srw6Qd1bnngTNmuegu9BY01A
         gilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728351842; x=1728956642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMA8NIgbUUWy2PaRc1Fk8S2RKWxEcaTI3Gg4Jjq/WS0=;
        b=ZrrVI3STnHfnOPLnsJ9tAK9BU8blreGsHjgTuHn1h+SL9j3QX5KqHVIhZI4CDqTcYF
         WjILCppS7l7LSoxogWKY3YLdVIato5//nCkyoTVFYh7EDJIV7tF1V8PuZ4zPtJ8RndkW
         85uFsg0F50ty/9jFpF+V7rv3Dj5R1BWJGwyeNKWl8M8vh0Wor2V1HPfPtrcfxMBWQ8zR
         t6Lc2udfk4BKUpmkyu7LC06pRmovwkrR8cXhZQ9OM7m59Ta/lOiCPv9sxkI/Ruj9k8oX
         INdPOINg+91ejj+ZnG7Sx6SqCg3SG7D13mDcvB/ZXnnEdN1uk7q4Y993iPs2s/bGjtKn
         OKfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5/QMy+U9r46I9Y4M1qiu9ZHs6bkWyyPo2jx+I0cqvD5VUk+hkeU737InNinwjLx1VVtKk7Pv8XL0B@vger.kernel.org, AJvYcCXtgzp3H9Fc63NtZ1SW6+/aeyNg0E7wOX5CYyr4O1HN+1VF09lCzUoos7du0H5kGu/ehbVB6Gyl0Ga5i917@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ5fSTBtRwgp0twRuhFFEs1dpgu3uLLnRGBlUJyRNN4sOWqoR9
	lnRuxYso5nBCVcKTOvYgiz+KygoY8zJBi6VDS+DLXplbvTe+5KVT
X-Google-Smtp-Source: AGHT+IG/wPKeG7rs6dIdkvUMb/ihW2JWNEUHrbX/RXLsnFy/MnnjIeK3XJYpuEqL+0u1GxUip2afYQ==
X-Received: by 2002:a05:6820:228e:b0:5e1:d741:6f04 with SMTP id 006d021491bc7-5e7cc079979mr10120950eaf.3.1728351842312;
        Mon, 07 Oct 2024 18:44:02 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-715567715cbsm1739626a34.17.2024.10.07.18.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 18:44:01 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: aou@eecs.berkeley.edu,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	guoren@kernel.org,
	inochiama@outlook.com,
	krzk+dt@kernel.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	chunzhi.lin@sophgo.com
Subject: [PATCH 1/1] riscv: sophgo: dts: add power key for pioneer box
Date: Tue,  8 Oct 2024 09:43:52 +0800
Message-Id: <12e65a99f1b52c52b7372e900a203063b30c74b5.1728350655.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1728350655.git.unicorn_wang@outlook.com>
References: <cover.1728350655.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

There is a power button on the front panel of the pioneer box.
Short pressing the button will trigger the onboard MCU to
notify SG2042 through GPIO22 to enter the power-off process.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts      | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
index a3f9d6f22566..be596d01ff8d 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
@@ -5,6 +5,9 @@
 
 #include "sg2042.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
 / {
 	model = "Milk-V Pioneer";
 	compatible = "milkv,pioneer", "sophgo,sg2042";
@@ -12,6 +15,18 @@ / {
 	chosen {
 		stdout-path = "serial0";
 	};
+
+	gpio-power {
+		compatible = "gpio-keys";
+
+		key-power {
+			label = "Power Key";
+			linux,code = <KEY_POWER>;
+			gpios = <&port0a 22 GPIO_ACTIVE_HIGH>;
+			linux,input-type = <EV_KEY>;
+			debounce-interval = <100>;
+		};
+	};
 };
 
 &cgi_main {
-- 
2.34.1


