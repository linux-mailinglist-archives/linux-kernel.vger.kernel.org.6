Return-Path: <linux-kernel+bounces-184134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6978C8CA2F6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94CE41C216E5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 19:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41471386C6;
	Mon, 20 May 2024 19:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DIyl5bCw"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BF154735
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 19:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716235043; cv=none; b=RI5yiWsGeZ4LAwK79BQ24YIwZ9WvHmv6i6FCx6VuJcXbxU3JuSLLJ1nwLFSiHMgcStdiK4Od4Nly3+gsephb0qxtvDfGwV2yqMvNsyQg/8IL+3ESf7lA5XCQM8dmCq6QNo6y+4m7U+PHyXRwA2KnJq3DGWlcPypop2uB1x6Idlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716235043; c=relaxed/simple;
	bh=KbdZiWU/yJLATN8W3LnKGoV4prfPNDWGjBK11wMs1JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=duMZaYYBmmiGn4yuRMLwSD0PZGDVMoMSx2b5itEuCHifGKxN1J7vCE9hLaAY3JLKpwZ4Y9T2kWdatds6ytY/IZahBc5pjjP34hxAsLHk+L5CUJ+yQa8w+vuLn0YmwCCa1RiKlGldkTtWQFJrbCY9zMYRSWlkYRPC42luxovRn24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DIyl5bCw; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ed0abbf706so18495405ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 12:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716235041; x=1716839841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fnF+Mknkz+zd02jEEOQ0KqrK7Y/NJrOjG6yc2dtSwvk=;
        b=DIyl5bCwFY4xYezb6VcO7A41HhBIIAScDKa+Ji8udTTheqpG61hp2bRW9zrMqWkXCh
         fZkKRG0pIYTwNxgXDOYKBA1YuR9Gq4b5coxSbQiyWvE/19Q6yaQZbkgHAiFOL8HVHxDZ
         jhbnqToHFKJ2PMLH21pY2o9DAUkToLUQsSB7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716235041; x=1716839841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fnF+Mknkz+zd02jEEOQ0KqrK7Y/NJrOjG6yc2dtSwvk=;
        b=kMx0MhgLG77B7YAg6TX4RPVY55BlfN82yDNhB53gWkw2k9PYRdy4FlG47A4Q3tIZzq
         c6W1EMwYOr3LGZbfgVBtI5o6Avsrf/s4c8xl03Ha1ghfnp17zhx8SNZvm+9mkDiPZQd6
         O5Wm/oBwEBezWLIe2Del6ruVYRJqMKhEjexnTkBQK3FCeoDeCxDI+NZGe+Oelx9llngV
         xn8c/2HjaQrOhxNBgV+sNanKR66l3LUNZqFJSpdTVrQMdk9oH12Ar1uvkf7mfX1j3CeU
         Ag8IlbrOi7HaVM0viPdZuIlie9dgzTIufiUOdlp8bwMLunfKDkK/MWz8y5TbBWUHJ5k0
         QQCw==
X-Forwarded-Encrypted: i=1; AJvYcCX6ugl9zWoHRNRD/YIVzZkmmAtybp9yJ1Ggnw2faxtEbfCah/qiAkYKToIPNIIM29AudMJurqB6WTXxwTy8YJuxszVWcteC1jD0tECi
X-Gm-Message-State: AOJu0YzAYV2wFXE5UP0Vnxy1Dv5qfIuKrekwxrb4Oe1RMFQbTgFTTg5t
	D+nHSCgaYhhSVBtOVnHl/kNWz45i71Mpu7XNRIHqbmMeAflNJNMllvuPSBfK4WP+C3JB+xlUkEI
	=
X-Google-Smtp-Source: AGHT+IFLOJWoQjDyhCGKYBlSnHVGpAwxx4U7rvTLHLxQ1kl65e9qSyMQupncqTXqrJ2K/OEY04WwLw==
X-Received: by 2002:a17:903:2350:b0:1f2:f854:f54 with SMTP id d9443c01a7336-1f2f8541142mr66290255ad.62.1716235041064;
        Mon, 20 May 2024 12:57:21 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:cd20:112a:72ca:4425])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136d13sm207501405ad.242.2024.05.20.12.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 12:57:20 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Stephen Boyd <swboyd@chromium.org>,
	Kieran Bingham <kbingham@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Douglas Anderson <dianders@chromium.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: scripts/gdb: Replace missed $(srctree)/$(src) w/ $(src)
Date: Mon, 20 May 2024 12:56:52 -0700
Message-ID: <20240520125648.1.If6cc3e73812d5f66aee58d335bfc9439c0ad9285@changeid>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently we went through the source tree and replaced
$(srctree)/$(src) w/ $(src). However, the gdb scripts Makefile had a
hidden $(srctree)/$(src) that looked like this:

  $(abspath $(srctree))/$(src)

Because we missed that then my installed kernel had symlinks that
looked like this:

  __init__.py ->
    ${INSTALL_DIR}/$(INSTALL_DIR}/scripts/gdb/linux/__init__.py

Let's also replace the midden $(abspath $(srctree))/$(src) with
$(src). Now:

  __init__.py ->
    $(INSTALL_DIR}/scripts/gdb/linux/__init__.py

Fixes: b1992c3772e6 ("kbuild: use $(src) instead of $(srctree)/$(src) for source directory")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 scripts/gdb/linux/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/Makefile b/scripts/gdb/linux/Makefile
index d77ad9079d0f..fd1402c0a1a1 100644
--- a/scripts/gdb/linux/Makefile
+++ b/scripts/gdb/linux/Makefile
@@ -5,7 +5,7 @@ ifdef building_out_of_srctree
 symlinks := $(patsubst $(src)/%,%,$(wildcard $(src)/*.py))
 
 quiet_cmd_symlink = SYMLINK $@
-      cmd_symlink = ln -fsn $(patsubst $(obj)/%,$(abspath $(srctree))/$(src)/%,$@) $@
+      cmd_symlink = ln -fsn $(patsubst $(obj)/%,$(src)/%,$@) $@
 
 always-y += $(symlinks)
 $(addprefix $(obj)/, $(symlinks)): FORCE
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


