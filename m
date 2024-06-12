Return-Path: <linux-kernel+bounces-211403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A82F0905136
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AAA01F24C5A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FFB16F0DA;
	Wed, 12 Jun 2024 11:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lq8CUop0"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B98E155A52
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 11:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718190990; cv=none; b=I3yz2rNJDBy9W8NNrr5uAZKpGRZTRpoRV3xuefbOzKhcxEpb64AdOC6ArqRGE/8YZFmvZnM3Ysats8AQya6XLX7g+/eDSMxHQN6FMkdw/9QOgUzXpGE46d+ZSUOrZxcI4LbyVzfBqna727YcZUYsogwH+k6gs1lV34ag+HKsO/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718190990; c=relaxed/simple;
	bh=6WIbM/yRrBCMeBCWP+Zk2RivA1OpNHDdgbheWxxWPGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sSD5/VJmh1uBe7mGjsf/oGwShGP6vxQSkRCITnO6tBOQC0K8StKE4RzcCC5HZ9VlXHiz92INkzbJdP7OYuF1nrbemgqUT+0xmeukOzgQDUmUKAm9GVjHyUVPdmELGhzFA7UfMmdVltnHg4AyVQddfETqtNohTZS3MHZExE0c8Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lq8CUop0; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4217c7eb6b4so33501275e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 04:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718190986; x=1718795786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QSoXMnr/AHLsd2eigsBHGTPuPHmBb5vzNsTv17MtRpc=;
        b=lq8CUop0EF5/6B7hi82aSivq30zu/+ULmb49eXyVV7TscKmjtc3n9nUl1rkwjmsBWD
         JH5S8IYlJ1IbiKntZuOr5sunK5KBXupL7nB6zRDJlykftR3/T1yZaLNJgQ1uypGD1EbI
         q9mj0exr1Ju1PyoS6oLEL3At7b/Jx/o5B5rV/B7rqbLM7yCVZYrnNo9VUr3ZokVrHLEV
         JTry3ZP5zOoQtLtfE0xnplE29dZr/Gn5tbUBdHbQCBPPjWMcMmG6l6fenUWhx8mokmBr
         Klx+gUPl7a2IA8TPN60O4iFrts4BaGgqOj70sO1Dh7BCRwnvyrZBGq7IpWxS54Diehms
         wpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718190986; x=1718795786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QSoXMnr/AHLsd2eigsBHGTPuPHmBb5vzNsTv17MtRpc=;
        b=uH/QQ43YMv2zU/gSOPc7qTHhhWmlWRzUjXI8tWpTpT8vZZXGLPcN3rhA7F1Pp6o0mT
         92MN8n2VwvzEFZDkDVZMXZS/j7iMpkRNRwj3HJOmMlMmUOzl4wQaubbIkdVw8DPeb+mW
         w0LkYrvvOYfRY+PAbPCHoKkkVnlR6aFjK8J/UfK37KBv1O5fbyw7oO1PNLqX/t2d5Hnh
         Tgn7VTV+7liH6BF67KVhZJOlP8nrE7yK6jVqiDJr0DshY94YPxeQOizn234cY/xg35nt
         vmSEtHa9s3+WwfA/s1qdFyEgaquBGIu1aJVSxYDsegqtliEK19ufxiVrOVCkPvMqkXZS
         qcsw==
X-Forwarded-Encrypted: i=1; AJvYcCWdNPQMHeMV5HpGlsxZ7b7ar7tjF84CB7TDvONqQMincyM1LFA9W6WjMt6ejE4ipkcRVMKLtZMm302sh0oVSHhSrnztbSWpyAJ1AtEh
X-Gm-Message-State: AOJu0YxEKTKj5uUxaV9oH6vLcWUptb67hmKOLGiae5wfQuvMAHlqiL9L
	iuGiBWGP2aYVl3lrd6wYTScAJTLXb5jRGmon3PZGNNhFyq+4XIhwWVTGOkHUlaU=
X-Google-Smtp-Source: AGHT+IGOCZNcIyA/tr5UUm+USYoqBR0ZQJOtGZGPrc28TlspHiIvoT/2tTuJfzTVrYDnOoe731TUlQ==
X-Received: by 2002:a05:600c:2192:b0:41b:e0e5:a525 with SMTP id 5b1f17b1804b1-422864ae1cfmr14089625e9.17.1718190986533;
        Wed, 12 Jun 2024 04:16:26 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286fe75c4sm22852375e9.5.2024.06.12.04.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 04:16:26 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	arm@kernel.org,
	soc@kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Olof Johansson <olof@lixom.net>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] MAINTAINERS: ARM: vt8500: add Krzysztof Kozlowski as maintainer
Date: Wed, 12 Jun 2024 13:16:23 +0200
Message-ID: <20240612111623.102868-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ARM VIA/WonderMedia VT8500 platform became orphaned in
commit 8f1b7ba55c61 ("MAINTAINERS: ARM/VT8500, remove defunct e-mail")
and clearly it is on the way out of the kernel.  However few folks send
patches to it and it is nice to actually take them, till the platform is
in the kernel.

I do not plan to actively support/maintain ARM VT8500 but I can take odd
fixes now and then.

Extend the maintainer entry to cover also VT8500 DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: linux-arm-kernel@lists.infradead.org
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 63d991d95c73..c7a13170b697 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3107,9 +3107,11 @@ W:	http://www.armlinux.org.uk/
 F:	arch/arm/vfp/
 
 ARM/VT8500 ARM ARCHITECTURE
+M:	Krzysztof Kozlowski <krzk@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Orphan
+S:	Odd Fixes
 F:	Documentation/devicetree/bindings/i2c/i2c-wmt.txt
+F:	arch/arm/boot/dts/vt8500/
 F:	arch/arm/mach-vt8500/
 F:	drivers/clocksource/timer-vt8500.c
 F:	drivers/i2c/busses/i2c-viai2c-wmt.c
-- 
2.43.0


