Return-Path: <linux-kernel+bounces-218483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAE990C06E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 423571C22BCA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC0C41746;
	Tue, 18 Jun 2024 00:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="irPygqq0"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670C238DC3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718670988; cv=none; b=cNw4OGX8F+QhaskY9NBQ5sc5BDQpUrlIOIqNAgbhy4K88QD5gDh3wGRpgsPKpulGUXh6+5Hysp/gA0N/Hs4vTdBto0s5gieUuRpd86RxwYeNDg8lZe1cOswwkGfBOUhANmILGaEyKZ9bqoD6LJ2GkjpApbPCwl+prFqm1c0Wi+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718670988; c=relaxed/simple;
	bh=7yYhYFXwxi5LaA7PY+8rYBzxce1baQFOVy6cQN5EAa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWH+XC46fwyFIQlzv9rhI78DpvQXIwpzUR5bFIoKtecUGYdtkMMaH38U1P+SJciADJpamhXnYpztkRmIt43SexwkvdsZBirXFSixYoNXR9rRytvUQeDze4QWHF3lV98ey1E+3arupl8URv+f2w0BaP3+lFIe6v30Lz6sgaY1mMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=irPygqq0; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-24c9f628e71so2564183fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718670986; x=1719275786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRVpacVKP8/kEybh72yCSJAMvmAUrPd+O+416uJUqRs=;
        b=irPygqq0qWMgS5fFpE//n7Qy94OUzIvGmERGwVMl5MzJp7Lesc/4TEbeRZ2Vm/H8wl
         +Hb3r52lSkrAR2qkGgcCOXHG3l5Doa5yO58SLQ8n9YS5Ns0E6fL/BZYK7WPTpEb6TW2F
         +PmDt1WInPwEOhdcQVv8gc+yZI4qm+A+sH9F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718670986; x=1719275786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRVpacVKP8/kEybh72yCSJAMvmAUrPd+O+416uJUqRs=;
        b=KRKi0cuaKxv+ZeLBd2HH7Qf6h+bQv4eZRKTcISM5SUyD/S8TKhSGQU2u5sOeNkiBG4
         VfSYAR9SzfQNpCh271EwvEauTwjdz9VDT+5RqTGlOY9pLyfovXrNW+UrA1MS8wdA6pQE
         BWmthjc88PKINDmyp4EqzNLDcK0z6lb1p2YyFCRPAdR4G+gatNxvLjUB7RIivMPIoFEE
         HGVo5lgbIpxwewqgcG5Yesz5DIH0HzZOxvGvguyBoRJSAk5oQ/omFLKP803m8tBz945e
         wRyo3cwlX7qTzrAP4WgOSnwXB8O70h/Dv9mF0GfiVw2Y40EzS6oXTiyNChd9O3qDC2M9
         DWPw==
X-Forwarded-Encrypted: i=1; AJvYcCU9j5PbbpudLUlPBXvToSXri8R9gmUMolJPsfGoIiJqfQohXWrhbQKQ3J8cpGgy62udI/2+b5IDGYzQilNpF13a4hcgPjaTisrgkqH2
X-Gm-Message-State: AOJu0YyKCSJX9N8SpAO2B5fafYtJ9Tkywnjva8/7mvb5MH9gUxj3QDFs
	n+EtPjz1gwuSmNKzK5aRKlKgwE2b7eiZhFkGyB9+JYzkrZD5SXP66PSSiPc+QQ==
X-Google-Smtp-Source: AGHT+IHWXXcRbcfJ1ShLSP+A9Y/8QRIg/zpY9j01+uksHi/wtWTwRM3Xfurp0UfLl17dBlvcoaNdfw==
X-Received: by 2002:a05:6870:a714:b0:250:73d9:7739 with SMTP id 586e51a60fabf-25842b1e846mr10966179fac.45.1718670986623;
        Mon, 17 Jun 2024 17:36:26 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:1798:e71b:11ad:8b94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb99f4dsm7905917b3a.216.2024.06.17.17.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 17:36:25 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: kgdb-bugreport@lists.sourceforge.net,
	Douglas Anderson <dianders@chromium.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jason Wessel <jason.wessel@windriver.com>,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] kdb: Replease simple_strtoul() with kstrtouint() in kdb_md()
Date: Mon, 17 Jun 2024 17:34:44 -0700
Message-ID: <20240617173426.10.I9adfcc6e69e279d7c083b677d9ddfb812a17d665@changeid>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
In-Reply-To: <20240618003546.4144638-1-dianders@chromium.org>
References: <20240618003546.4144638-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The docs say you should use kstrtouint() instead of simple_strtoul(),
so do so. This nicely simplfies the code a little.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/debug/kdb/kdb_main.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index c064ff093670..6dcbf4ea4bcd 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -1612,11 +1612,8 @@ static int kdb_md(int argc, const char **argv)
 		bytesperword = (int)(argv[0][2] - '0');
 		if (!argv[0][3])
 			valid = true;
-		else if (argv[0][3] == 'c' && argv[0][4]) {
-			char *p;
-			repeat = simple_strtoul(argv[0] + 4, &p, 10);
-			valid = !*p;
-		}
+		else if (argv[0][3] == 'c' && argv[0][4])
+			valid = kstrtouint(argv[0] + 4, 10, &repeat) == 0;
 	} else if (strcmp(argv[0], "md") == 0)
 		valid = true;
 	else if (strcmp(argv[0], "mds") == 0)
-- 
2.45.2.627.g7a2c4fd464-goog


