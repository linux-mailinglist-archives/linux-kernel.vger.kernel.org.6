Return-Path: <linux-kernel+bounces-381304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 204F99AFD68
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AC0DB23453
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D2E1D4352;
	Fri, 25 Oct 2024 08:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LxbWFJ8e"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A6E1B0F03
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729846737; cv=none; b=gmiVe/1rvEJCjYW9Q6+gm4InzuGMc1RlRrX/GH04n+6TUSjpExttTE02o64GzA9xEAuMUc9k6/GtzCNL7n54uy0EaM9T0tWUhOkaG8LenSaFCC66jih3/69hkYJveFJdajJJ6K2mR9mL5iKbxTe6tyG6H35hTPIbAOeo3QCZxC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729846737; c=relaxed/simple;
	bh=R2dEa6EmWh/Yg7c71jGQjYKMjCVjTYxrdQ5Vom/u8tg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mb86zEJ7yiBcUGRNIU4BcVVQF0ZoJZcJ6zF5Jg9Umqb/WnpMgq7fTxq8uzASlR7QVFnRgeu2UEWgzG/JxsutKEBueh5Ey1+dehNo93Sn6lsP4N7nQIb+lZ9tRfp/q7QEAtapIWfPfB6Pk3chkWEwTH7iMQZXgAQ6JFLHpXZgR6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LxbWFJ8e; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a2209bd7fso230206466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 01:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729846732; x=1730451532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xT0AQUPQMRTs/7ousRoEZpcKGvcFZZKiJbtlxnilbyw=;
        b=LxbWFJ8ei5TqfuRjViMKWVonk2eQhzgauvqm4mauBZZMnUMsrju5UCzBIT1JPfyxBG
         IhiuKVxMBK1TNhCthG5WuM9qzBr0Xd11jhOlnrlYP3UNXr0PTWjwbKGKwArdl8QJOoWG
         qtb1Ss7bEEG1tC3JV6UnlS9Cqby7VYfao6XrEGBBlBLE6ww05B0JCv9MabYPmllqAa9k
         ZYWRahpbWC06xdWMfCxHfvQ9K9PHSgtjNh1dCM13UbIWWHNCw0dJuUc+cAdqtkD6BttI
         rzFl0Y4RhjSlUG9Za3XqoTI3eP23OjfSerNB1hOOSOwaEEADVQVb1B2KB4JKg8I6/CIB
         UIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729846732; x=1730451532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xT0AQUPQMRTs/7ousRoEZpcKGvcFZZKiJbtlxnilbyw=;
        b=JsWcHB/QTW6s0tvaTjzSOSXu6MgTfMCv6ezkx4Shb5ZlJP3RhSTrQ9WVCk1tZaULqq
         ANxprfBL6pLARuBR639UIKSBJd1ry8JMncYlYYzLZIl9vb7m5g7LuIbVcheD0DQF4KV+
         c3ZcsX3Bz+IlSGCoYRDkEGs1vQg2Mbc146oBEEAgSPUhCvO/lkx2X8/v8kAw2V6DBVpH
         Qvrcj7qRtkSksz5la2VK9z5hfHAjJZnkOTvS6Cno+wIMsrA4qRqZweE85E/7ZUj8YZiH
         zE9Xlu8chhXfQ14msWr6ricRD0MLMbJxVT37UYJXXMwW2nz4ztjUT92joqLbeurd25MM
         JgKA==
X-Gm-Message-State: AOJu0YwZ4oC1CaH+s7zjKemTt9BuByCf7ooE4FeSSWeB4jqGJaP2oOPJ
	+1c9RPVvIzAunLTmRajoo/zSk7caj7FY6A2y57AT+eBXAqVR00jPbsPxlDXwisg=
X-Google-Smtp-Source: AGHT+IGpqTSkLkpSD3jFqth0AGuMpmBccHsHr83MteUP12eHoMJXdLBCXVBYezFj8rK3hldmFuOKQQ==
X-Received: by 2002:a17:907:3e0a:b0:a9a:2523:b4ce with SMTP id a640c23a62f3a-a9ad2710931mr405963666b.6.1729846732569;
        Fri, 25 Oct 2024 01:58:52 -0700 (PDT)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b3a086fa1sm44847166b.212.2024.10.25.01.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 01:58:52 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH] .mailmap: update e-mail address for Eugen Hristev
Date: Fri, 25 Oct 2024 11:58:48 +0300
Message-ID: <20241025085848.483149-1-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update e-mail address.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 .mailmap | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 442da8603cef..bccf924f59bb 100644
--- a/.mailmap
+++ b/.mailmap
@@ -199,7 +199,8 @@ Elliot Berman <quic_eberman@quicinc.com> <eberman@codeaurora.org>
 Enric Balletbo i Serra <eballetbo@kernel.org> <enric.balletbo@collabora.com>
 Enric Balletbo i Serra <eballetbo@kernel.org> <eballetbo@iseebcn.com>
 Erik Kaneda <erik.kaneda@intel.com> <erik.schmauss@intel.com>
-Eugen Hristev <eugen.hristev@collabora.com> <eugen.hristev@microchip.com>
+Eugen Hristev <eugen.hristev@linaro.org> <eugen.hristev@microchip.com>
+Eugen Hristev <eugen.hristev@linaro.org> <eugen.hristev@collabora.com>
 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> <ezequiel@collabora.com>
 Faith Ekstrand <faith.ekstrand@collabora.com> <jason@jlekstrand.net>
-- 
2.43.0


