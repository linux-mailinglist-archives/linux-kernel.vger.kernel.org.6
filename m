Return-Path: <linux-kernel+bounces-203878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBCB8FE188
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED48EB26C3C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704B11474A9;
	Thu,  6 Jun 2024 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wazrRhQp"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FB113F42E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663708; cv=none; b=TBWuYFpV9ZYeXP9uIAVZ9+QwFSMpEmQ/lsb73y0l9ApEjeckhYce04qkr4kKVl2DZBngBR9ouEbs3Z8adv6b4lVuhC/kt2+2AeWehqT5DbOFJ9rL8JF/fenShAKJpuZxUPF3z4ynspwQb6AF7KIOPNbJAUQMhqHJMQqvD4hjZkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663708; c=relaxed/simple;
	bh=zlmLcdUmYl0S4n0pRhWJV5tV26JKeT3szLzZNHMzvlI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Py2XKc/bamPMn2d7mzZ45crkg8KU4GAY0KUzuccyk14gRRYS4ST/24X0u28ONnTTELJvpyo+wqmYgVKVoIwtWd81/QR/KpeguG2Ubr79iv13DlCnmvFsVuXE2GagfW5wzrLa8B5pQhMuN5GIEdh4ouzVuQtKluouAZlUESg89oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wazrRhQp; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42121d27861so8271695e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717663705; x=1718268505; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JdxVYMQSwsBjETYXUb/TiJR6/kX0EA1fzEmOgzqhPuQ=;
        b=wazrRhQp4QvGhi9FlOtwBScSxwZP+XDmD1VRx+i4tHgz5w7fd6u9qm4y4HiHDp3xKz
         X3GpBv12vRNFgQjq1cCpCbj6y+FH1eBcKB+ZXIPsHSrxetvcntMxextvx0lKEEduZ296
         A/XJUPZwwvPORIjQbncS+fxYApG1+EWQL/X37dB0k1Io8nUjloQ5bS6Ln+E2bHEbUZXO
         MXnN3gSxDn5vdX81t67sExeXUEceWOZ8qqJdFEAfLPIIXX0ImHtTLGSnS8XkbH1lLz0s
         UJ7uU2rgn9cHhBp8CYOflyIkq7TtT/c/4C7vNF9IumTl+zA2rIo9NxoyGSyLGPY3yW69
         7pIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717663705; x=1718268505;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdxVYMQSwsBjETYXUb/TiJR6/kX0EA1fzEmOgzqhPuQ=;
        b=VgiRKkJ3Z8VeqrTTgyFRhOvko2YYh9n8onWTeoiG1u/hQtBmcDojOry/bO/e96FfNz
         NG9sJwHMCFh0MEagqnPmbkt5TNzDp1xJ2sYIrkmzFL+O58/iufqKMAFXOXn+fN66dMr/
         iYe7LJnYt3wJPIhtsbz7vsh3VAve2Z/Bb86ePqkkdCGcQwqIEDAjqNBZXXc6+C72vM6A
         XEq9n2aMgGOmVAyAjcSsBe5nzEvjeVE8oc4GjhE+lUnrD5Nfw2fI/OLTGnB2Kgki5v8e
         AeTwZPmGV9W+RQtFVR1BcuhTF+I3Q5qIc0CYwaVcv8OmoXjy5Ydssztq2HL6q16MH3hZ
         ie2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVH6jMpA8QsK81utTwnH8FL87kOjw0FVH6Bq13qaI0escCCwQMCfGuxC9nAFHEZCo3Po0m4k2Syd6BPfh6KS78vRz2zrMtbVWZcdOoZ
X-Gm-Message-State: AOJu0Yx+Nv3lNRyPF2ychVQk2uj2UqzJp86u3voJt4dLwubG5K7tXMOt
	s01wWo3z7Kovvir8k2XR3xKzLLWGTHSvMHJ1egcwOHovhp1isQSYu9GW2os/gyzrmUdvQS/0HwS
	1
X-Google-Smtp-Source: AGHT+IFgBJznRwWmXlhoTzwqKs7ghgTMjkOwyXK3mR+0BcfvkTEQacyLBQZBl3X+FE+uIo7F0zE8eg==
X-Received: by 2002:a05:600c:19cf:b0:41b:e406:5ae6 with SMTP id 5b1f17b1804b1-421562cf319mr39231825e9.9.1717663705084;
        Thu, 06 Jun 2024 01:48:25 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2c690dsm14227445e9.34.2024.06.06.01.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 01:48:24 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 06 Jun 2024 10:48:18 +0200
Subject: [PATCH 11/12] arm64: dts: amlogic: a1: drop the invalid reset-name
 for usb@fe004400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-topic-amlogic-upstream-bindings-fixes-dts-v1-11-62e812729541@linaro.org>
References: <20240606-topic-amlogic-upstream-bindings-fixes-dts-v1-0-62e812729541@linaro.org>
In-Reply-To: <20240606-topic-amlogic-upstream-bindings-fixes-dts-v1-0-62e812729541@linaro.org>
To: Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=761;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=zlmLcdUmYl0S4n0pRhWJV5tV26JKeT3szLzZNHMzvlI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmYXfOhMzyc+h9+JVkIjeLiJwkC5RIgnBGzlwVjY/q
 6rUuKkiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZmF3zgAKCRB33NvayMhJ0RrOD/
 4hoFGbYDtDrSzDp/8RkgMNtJHyHQbgjQoe8bid5k3WIoTSIs2HT4OsTd+NVWYzoHxpcwiO9dKp6hRG
 DxZHkkv2qdyh0FGFAqP2tqInuS7ZzCmC0+7YMKNPbZRiBtMSomUfS0g0jFmVaE74GoYS+FT+sL18BH
 YeTOeDcsggbJFR/wpTLGj7bcNobfkWSrmN0RGgpVYWmbUcX4+Gfsj8JpKggUOa/QzBHeaDT4qD4qUh
 q3sJjsxEaM6jK79ATjh+HOf38oWIM+xg5LwghNEvUT2L+awNu7Uwo2CwLhGJucU9BPLB4y1MX7HuMV
 tSZOI4gre04jo8nRU8YSal5o/q093SVDfa8u+SRApA29LbBLjEx45jXOQ+FrsnV4YAAIY7A7fuomCV
 X6GurODT2X33NcdkQzt4zonX/5rZ7deD4zy0qpFnU7fH0/zcoTrwshlXyRKyLaKDqYHp9flB6pTCOd
 OLN5DVQt8VfKLSvk1pzTetHpxToRpIjg4sEeJ9aRpR1Rj5uO/6yfX5p3K0I16sWWGK6ima5ZLHjJRO
 /8/P06M6sYEt++JkHo99VuSxDkDF0eZL2BT9LBrwNrN7clHqHLHonTMoDhGEaGrWNTRCcBvqUF1wds
 vxJlrpMzP1MrD7ek0tmVFKItmHGE/k0mgg32p9F+FdARyNPthG+VCNw1hG/w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

This fixes the following:
usb@fe004400: 'reset-name' does not match any of the regexes: '^usb@[0-9a-f]+$', 'pinctrl-[0-9]+'

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index 4be801d12c4b..ade3a51ce89d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -453,7 +453,6 @@ usb: usb@fe004400 {
 			assigned-clocks = <&clkc_periphs CLKID_USB_BUS>;
 			assigned-clock-rates = <64000000>;
 			resets = <&reset RESET_USBCTRL>;
-			reset-name = "usb_ctrl";
 
 			dr_mode = "otg";
 

-- 
2.34.1


