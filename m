Return-Path: <linux-kernel+bounces-257208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FE59376B7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 12:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E8D4B2195D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C1883CA1;
	Fri, 19 Jul 2024 10:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgHXLqJo"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42E942076
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 10:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721385593; cv=none; b=ZVQXbMa0bzp/yMZ1lkHnImLyVfJsIvGy3Ww1cXjyFAwqBMtFwCgWz/tcWRmsC9ZhTJnAkKtfIDzmz8/HTe3i6QV9yG6txCapwQL0PWIKV53Kb3nHVUppXwbKYljjwhPS8A+GR5bhlvlUYWRL9LStgur9cyu4WKaU1KJ3kaZvVjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721385593; c=relaxed/simple;
	bh=bN//6Jro62xaWG8EqO5gnjBdZk65GZ7aAczPnCTO820=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NbB9PukdVkSJneLsnnlLG7NXuMm+SXQhKwIyQ1XQPWFrGPtFLOPiaFFCr/cSqa4PGHzV61zUN2J4tbiZBfLRCTA+4iUa5KjrbSSolaYZ8hW1S34bOaZdJYn9Lh07JB/LYUnzdbkDw6pxsF62Ahq/eTKQkqFA2B8PoFaePB8WiFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgHXLqJo; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eeb2d60efbso27662031fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 03:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721385590; x=1721990390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=igSaV7XZ3Cr6vZxP+aTe+2LlltaNI5nN7ttSrnUQLKQ=;
        b=TgHXLqJonNsectpkNoVw7aWoNE00G/QVJ4CVpnWfkEgEP7vb3d6BA6Z8rTPszJvYMu
         uNG9rjukrJALtkMKWOuz30uzIss+x2aNzQz3TDAz87FCiMlPb/BbVkqx07mbz3AWqirl
         IY87oRpvfwsY2rGlOt9h2j1AfNH0FV853AI/EWhdxttDBfdjwwEGnRsz8RhJLgA+T0r9
         RbKQ8aYxJ9UkVPtKjB44e9R1ehn+/E7EpU/Cl5+8fTMIR4AM4harRU4iEVmGToNVVz+7
         iW1z8BzHU8SjJ4wmUCMqVCbrOMSl7mkmMYewAzD3VszuVhHwGI1jdS857/fFK8wBIU8s
         dkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721385590; x=1721990390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=igSaV7XZ3Cr6vZxP+aTe+2LlltaNI5nN7ttSrnUQLKQ=;
        b=SegOzFzpM/rgP5HzN/L+G2l2A26iYMRklgEjQ5bMTj36M/kZKu00+DU/A8QnN2Jm9D
         NHaO1x7JpK+M74eesGivRmKdY9xK19MkrzUgzJmwfAkAv6EYULCWDMYF75fqPH50Y79s
         ntTMrUbw05N4i7ArgcM9mzsMNuq3XMI5oNYRlKZVzoVVn0Zmh+hddyKpwVaec1EtTsgv
         n0F/Vs01t7JW/7nOw7iFdNqMDInTX0LWuxTzyPNds4p9wWPFmmhHpzf+ZVjVzJtVdfFE
         A39uBjJaDgsETLU3r1nolnBk/HDFKEzM/cRoNu59b+R1Q/PNhR/Bk1NM456XC7YWcYni
         9/HA==
X-Forwarded-Encrypted: i=1; AJvYcCULa1tTdt6gk/fW2Reh2gvhp4ZzEYjs6r9qD5wEnmvOC8G0dmxGMhpBYq7QNWeeycJPzhRx0m0Kd8ygFuIFnPnOrOSFmd0kwXSQKkHd
X-Gm-Message-State: AOJu0Yy27v3iD69ZZ9A1f1Oiw7jIlSpvgi2H+I3zibdI2v1dBqBOG9zt
	dUQlhNLA0vURUULdTwp4Pu4v9qyYkUmX0PRdwOIlHrXESylkl7U0
X-Google-Smtp-Source: AGHT+IGDMZz5Ed0SYJ86pWbecobgjSLO1BwlQZsL9m550SurHJlk/eyq8D+wFwn/pahNaIpsuWzXZg==
X-Received: by 2002:a2e:6a18:0:b0:2eb:f31e:9e7b with SMTP id 38308e7fff4ca-2ef05c78c4amr33331211fa.14.1721385589731;
        Fri, 19 Jul 2024 03:39:49 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30aaa247dsm969213a12.22.2024.07.19.03.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 03:39:49 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH] kexec: Use atomic_try_cmpxchg_acquire() in kexec_trylock()
Date: Fri, 19 Jul 2024 12:38:52 +0200
Message-ID: <20240719103937.53742-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use atomic_try_cmpxchg_acquire(*ptr, &old, new) instead of
atomic_cmpxchg_acquire(*ptr, old, new) == old in kexec_trylock().
x86 CMPXCHG instruction returns success in ZF flag, so
this change saves a compare after cmpxchg.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Eric Biederman <ebiederm@xmission.com>
---
 kernel/kexec_internal.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 2595defe8c0d..d35d9792402d 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -23,7 +23,8 @@ int kimage_is_destination_range(struct kimage *image,
 extern atomic_t __kexec_lock;
 static inline bool kexec_trylock(void)
 {
-	return atomic_cmpxchg_acquire(&__kexec_lock, 0, 1) == 0;
+	int old = 0;
+	return atomic_try_cmpxchg_acquire(&__kexec_lock, &old, 1);
 }
 static inline void kexec_unlock(void)
 {
-- 
2.42.0


