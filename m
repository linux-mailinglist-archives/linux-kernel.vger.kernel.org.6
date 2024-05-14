Return-Path: <linux-kernel+bounces-179239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8968C5DDB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 00:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784F0282C44
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 22:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1260E182CA8;
	Tue, 14 May 2024 22:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KFjZjbH9"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DCF17F378
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 22:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715726925; cv=none; b=O0t3JAP+KgKhAhYvwKJ8Q7OBNewxllr9yn3a3Q9IG81HiJP3Xu/Murtd+iPlD1hDnHcACnRSiuMD758shpDlKOrxurslGgH7gvHBNuIs5WS50KhTp5A5BWuS7NhTIHCfejZyNWJ7QhTiWU6SeMmxDT3yTIt6xZPE96hz3fOEoY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715726925; c=relaxed/simple;
	bh=J7vPh0ZbPIZnc4W98FXR0VGHZuZYhbZC2ygC3LT6oBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TSFT8GmC1ZsJO+4l9C22aDKanC+8A1DT31pk90wYEWEEMQxFnZPb25hmLIxykhIPhDydg1it+eeLhaKzKxAb56bQKARKLLR+UgpDm+R5zoTJuQERxtPzhcOyA0bARNaWt1JP5nM/zuSFBoqPllisOqQposFbKznHQ1GnEFD/gPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KFjZjbH9; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-61eba9f9c5dso4646225a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 15:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715726922; x=1716331722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7dEnatMats0sY9eR6iWDX8uys8lNwT71usJDglUkjFU=;
        b=KFjZjbH9kgedpzd8DWp/husbn61V/lNXNlDfKResCDliU+375dKCXPSW7C7pVTdZDO
         rAkDqVZBrtUl57x31u6v0OqIwuN1ZQqlRsL9yzkGwSvYTqlWHYb1LV1k9kqSXYRtgiIA
         RaIbX3wvbub0PumdCh1Qu/OmgEMBc/w++qe20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715726922; x=1716331722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7dEnatMats0sY9eR6iWDX8uys8lNwT71usJDglUkjFU=;
        b=hn5nacgcqu2rpoL69wbgOHDR3KVHZ6E8VH2pC7cuDYE3hWngNH0fGsBQCS+ivPyKER
         r88/GR8uIKHABuEMuSOj3lI9CuTIeiuHoEX5GMwh0qGC7SrP1i9/65+6CsAKP9ap1tFC
         WmiTJ5W0ws2b2fqmO2HOdnMkfLZvGvE4zkWvkZKtehDVCPx2QFe2kma2VUM9S6ryDrWL
         r30sgj+W75uTOiMJsW9hkzRcIemI9fUEbtue6CsIz0X0avu6jLyyOi+8+XmGVcLA05hv
         PN4fy9aUvuiKJ5MltApgSsnmBrvKiMvju/5NrOnHxvcsog9qGOZfLCBVim5hMbdEEpx/
         l9uQ==
X-Gm-Message-State: AOJu0YzYE7obz3H6gqua7WpxZ7rSxHPPuRKZCtAJOyK5dV7ttKJIxmNI
	Vj3wJbvDa9YOoRqPoOd5ddd4CLXfg7w0GFGgN1MkFQIVOUpmETMuPEGRpg3BvA==
X-Google-Smtp-Source: AGHT+IFNYthq6sGRj5beJQGDuOSDHf6eMfI+iPOay6PKYPk2IVvOV/nkNwPHeh6QcabowUJdNEzJDA==
X-Received: by 2002:a17:90a:aa12:b0:2b1:6686:dd7b with SMTP id 98e67ed59e1d1-2b6ccb7e416mr12324060a91.33.1715726922083;
        Tue, 14 May 2024 15:48:42 -0700 (PDT)
Received: from localhost (4.198.125.34.bc.googleusercontent.com. [34.125.198.4])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2b671782d89sm10230359a91.55.2024.05.14.15.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 15:48:41 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: Kees Cook <keescook@chromium.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-security-module@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] loadpin: Prevent SECURITY_LOADPIN_ENFORCE=y without module decompression
Date: Tue, 14 May 2024 15:48:38 -0700
Message-ID: <20240514224839.2526112-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If modules are built compressed, and LoadPin is enforcing by default, we
must have in-kernel module decompression enabled (MODULE_DECOMPRESS).
Modules will fail to load without decompression built into the kernel
because they'll be blocked by LoadPin. Add a depends on clause to
prevent this combination.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 security/loadpin/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/loadpin/Kconfig b/security/loadpin/Kconfig
index 6724eaba3d36..8c22171088a7 100644
--- a/security/loadpin/Kconfig
+++ b/security/loadpin/Kconfig
@@ -14,6 +14,9 @@ config SECURITY_LOADPIN
 config SECURITY_LOADPIN_ENFORCE
 	bool "Enforce LoadPin at boot"
 	depends on SECURITY_LOADPIN
+	# Module compression breaks LoadPin unless modules are decompressed in
+	# the kernel.
+	depends on MODULE_COMPRESS_NONE || MODULE_DECOMPRESS
 	help
 	  If selected, LoadPin will enforce pinning at boot. If not
 	  selected, it can be enabled at boot with the kernel parameter

base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
https://chromeos.dev


