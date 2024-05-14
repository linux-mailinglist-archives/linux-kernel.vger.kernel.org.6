Return-Path: <linux-kernel+bounces-179261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3469E8C5E1E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 01:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A90EDB21654
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 23:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3737182CA3;
	Tue, 14 May 2024 23:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XMRYHZwv"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA0F13D619
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 23:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715729880; cv=none; b=k/mAfWAsUmwVGEPCYtw4jPIW2uA7JF1YW6uCrf71FKcqOF7NkLOxWWtrdDhs3TUjM7ARrzPrtNDBw4rcsJOzr1RDbFxqlZCeYiq7uHyYN3VNmYaQcTCoJY5zEvVd2i3dSByonj5Gz7yzY9Lb33bCXLAIbganQDSnb8wxxCGaBRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715729880; c=relaxed/simple;
	bh=M0ojsRsGu00hlS+3D/N7mtRoW2fXDtGb0dL7Dj9nSEI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BbGgiNcyQTBMX0kDA46Q9BNqQOBiRpVdYXKMSXC3ul4VfmvRHeNNO8brQSydqHwDElGgY/1vBSYsPyE7RFOELRwZKg3Snb2wjiHwkHMMRAqNB3NumoFJxxICeOXidOXKC1fKottEQRh9WZ6FaG7Bcent1rsDd+Gfht7kuDAOYX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XMRYHZwv; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f44dd41a5cso6157156b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 16:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715729878; x=1716334678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U/46gzPRjfsjywIh4JZDG9x4PubRXzjsJhZrxZRHzS8=;
        b=XMRYHZwv1mBGvBcx6lSEfGBbDW4MMi40t3slgMuu4Pp7Wt3luR+mizh03LmcSf85ak
         0dVF6s7MQ6VoRzzYEJCkcKS45zOkai1q9OCU4pp+2FqaeaW18bI+ZN9TjjuODgCtMWIy
         U28Z+B7RIOrtCDbP1zF1L5ovEGmzzBPApfGLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715729878; x=1716334678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/46gzPRjfsjywIh4JZDG9x4PubRXzjsJhZrxZRHzS8=;
        b=gAJjVrbiAMvMeRsFDyP27KDgL/gvkRBaTAiqSEInRnOadutEZgX/ZpMriYDGQHPV9l
         SIkOFt/M/Ts2JxmJQ7+ZJJA/u41VP6YKN/N83FGl22UZPWiWHQa6Idqt1EaYdlp/Q7MA
         QBiLBYSDHFr0VjRkrTGalPybgNV2XlrL9B07hKZLF91JkAyDBllqH7gC3cN7bGeY6YyR
         yo1IKZFiBK+xZZrJdT8hCqekidwOwz6atvNAS9nVIvK4emvPou9/Tcxra9AFAgTHWXWH
         V6kZU2I/VYB/iiRWfH1XdQJNWP+tE8MQkjWFJd5a+qutkle91UixN0JKSWrmbBL5AjAO
         AXgw==
X-Forwarded-Encrypted: i=1; AJvYcCW+xH50DoFAJnMxtKo0ZfMtoKBpEe0W/sSfuj93J7VAChq1wESmeZN101ac/VVAWaK5wgEBGuoIDBspdPnEI4hTyca9GQMKUEkifO8f
X-Gm-Message-State: AOJu0YxHyrI7rKzZlCYhjoFyFhr1aQl8d7dX9IkuhojIkblnYjTCBuUh
	RconAe59NI80woayGn8qUCz0wsWHdMMOzfBrr5uSjDhNjCwcDKcjVh7X42GaHA==
X-Google-Smtp-Source: AGHT+IHkWP0liojNW9LtVuhI4Z2GrRahcPNwxeY6SopHSto2NofFRMQtA1v0XzpbwKOEEaFOcB1wng==
X-Received: by 2002:a05:6a20:9782:b0:1af:ab0b:1c08 with SMTP id adf61e73a8af0-1afde1b6f80mr14140701637.46.1715729878103;
        Tue, 14 May 2024 16:37:58 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340b76e262sm8858679a12.35.2024.05.14.16.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 16:37:57 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ubsan: Restore dependency on ARCH_HAS_UBSAN
Date: Tue, 14 May 2024 16:37:48 -0700
Message-Id: <20240514233747.work.441-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1157; i=keescook@chromium.org;
 h=from:subject:message-id; bh=M0ojsRsGu00hlS+3D/N7mtRoW2fXDtGb0dL7Dj9nSEI=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmQ/XL0cMiBAzkKwdeLzy9N0TrgLVfExeGQZ0JN
 BHF7seFPsyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZkP1ywAKCRCJcvTf3G3A
 JgcVD/wOawyFjlRnf29/qod98RqXmvKGYR/z9gCakCBi8CxR4/Svp5cc0T+1pQzJxoBBpejCMg0
 pxH/ab2G44oXnSULaNGapGZ9ntp42d7DnWiaGdghDJs4jq3mBvhU0185EFH6k8FjNeio8qOlkzv
 LB+qmxeol6rTzNUICQEJtpC7MjGXDrI/JUqDk1fZv6ff4wyQo98trBnhME4QDzoTGzodcr85+MK
 seSwVJg6ecBebIIFhz3DVVzIJnNxeMxEnZpTEssJLlImhYpeycEbBFSR2zDyTvse/FGdwy0pUFK
 QM4cI+mh8yFa/+zN3C68no7tg2X4sBU9dMnRmQbj9mASW8Sb0QSnWVxY3v+5RlMTtESHi/17hNW
 rrv7je0gK4u7WSLM2ayMhcVuGBo6QNx23Jl4PnB/3ONTkgDdcPszSp0ZPMC+ZxifMJF1myji/kE
 JhrrIhEKljsD6Di1P0ATy6w3ZgKnqu0lFKIGkOetXWIFTOYefwC1q4MH7b3xDklAqAlIsBvEaR7
 1aQCDkbTy/0YQCvK0n2IUMBrFXZR3VYLlbk9MzllZAeApJm3Hv9Kw1O7MDrj9bViSqrlzXNA2H7
 OBDGcCh6D4DMvDBgFJO4rmlnrgsvq0AgWoOTzGdS8A0pH9fGFC06u3z1Jj9A2K/lntAbCWi1qKp
 9P8N+ld MNH39rig==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

While removing CONFIG_UBSAN_SANITIZE_ALL, ARCH_HAS_UBSAN wasn't correctly
depended on. Restore this, as we do not want to attempt UBSAN builds
unless it's actually been tested on a given architecture.

Reported-by: Masahiro Yamada <masahiroy@kernel.org>
Closes: https://lore.kernel.org/all/20240514095427.541201-1-masahiroy@kernel.org
Fixes: 918327e9b7ff ("ubsan: Remove CONFIG_UBSAN_SANITIZE_ALL")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: kasan-dev@googlegroups.com
Cc: linux-hardening@vger.kernel.org
---
 lib/Kconfig.ubsan | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index e81e1ac4a919..bdda600f8dfb 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -4,6 +4,7 @@ config ARCH_HAS_UBSAN
 
 menuconfig UBSAN
 	bool "Undefined behaviour sanity checker"
+	depends on ARCH_HAS_UBSAN
 	help
 	  This option enables the Undefined Behaviour sanity checker.
 	  Compile-time instrumentation is used to detect various undefined
-- 
2.34.1


