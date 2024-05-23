Return-Path: <linux-kernel+bounces-187098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057088CCD15
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B46602821A6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CDC13C9D2;
	Thu, 23 May 2024 07:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCTZxrXb"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52A43A1BF
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 07:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716449755; cv=none; b=fjRh1XFyO2mLcyaSH5xIA0yHOflgeH5+nbJaVSdoQ1lMphu5hdS4GWdkJBM0I3wX2jh3cLla1WyNzz52o4qUUfx2e3emKCo343DiAfHzuFLun6QBvmV7NU+VoUz6DB0Klmjww5yd41255XkCbTieiv0VJ02MigTX8dtOrDQyKvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716449755; c=relaxed/simple;
	bh=ncs1lAlk+fu9rWEPB1hvPGNLy664a14YaFIYHbF/HfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ePsWraDbbPkRwSmLerEo2Lv10bv7paWym8gutExKDR6n+lSJnE1fA8vFS5Y7XdJEE+0wBAyk7Uw9CC8/MVP61mKjlBz94diqads6eW0qpsH8khGB5wFAVQktq9dmvjWXSMWN04GUEh1IrDA7PBW6fI6a8FlLW7WbbswmyLC+L8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCTZxrXb; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5231efd80f2so8117334e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 00:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716449751; x=1717054551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3+NKs2DIKniT5pwrnywyYUogTT0Vo2nz647Z/Tvq1cg=;
        b=OCTZxrXbpCJ8XQVg9hrv4EgJLP3PQpx0zP+3ko86ZJ5nXgYGtKOtby8T/V2yJcWZoU
         KFlTOlsRoeUQ7rnkTCfz2Qe+0WsCi2AxvPTjRGRWM16eQnv49+hqQa+oaxTT8vDh3kCs
         zvCTqV7JVpEmcdVvH265sbpplZm4xNWMGRKaW+01yakMEBuuyTdmLftA9EOC525nHPUz
         yQRVFIQDH0VHlkehmNCiwnkujaZr/YZzCRWy/FRCyOcNJJhx6hKcxy5SBoUy7sKIlfWW
         36137jvvLkCZYDFlOlxN41xjgUYSjFkXTuIXYeGmuC7Ori6uFCLbeHOy4fZLnBHdRrBi
         PLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716449751; x=1717054551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+NKs2DIKniT5pwrnywyYUogTT0Vo2nz647Z/Tvq1cg=;
        b=oAaincZh594oDTiw8078WfQmPOpT+JdKN5BLxWfKC9J9YWtFtWOrUPsq7rvlXLRKTU
         QeweDUetSxmbgirB1HXTQ5Q+Fce04kclSPhhPssMGJGMAl7PqXPazaqKAUbLROOLpejY
         Oq1io7/wEGYoMGTYTX0Ig46PyGHHSm+UxDwWuklbjh/6wxgd50mMnckfmsMv5RV7melx
         gVwo5spZACja/7tOSZLLAnZN3pcQsfG3rJxffBgmEBjfS1EMqLZOOqMNxqcYaYG1XKjR
         3q0z7WsaefEHpZrU/b7QjADXiNHYCvKdHGE9g59FmURt3T7kKvwO8MbuPVN4sKnBP8sz
         xN8g==
X-Gm-Message-State: AOJu0YzDSnnNxMXnDHFKIbz+d8OCULd10JpvEjdpSI902Z/jlrB4Rp/8
	iLTDGUm1D3sYfyGAfNkobiAvx9ManJpUmdsRfEq//Oja8Bs2ne9Qjg4SI6EP
X-Google-Smtp-Source: AGHT+IFjE7brsmCeTCMtAdy9S8PLMAN9C2HfTZuQd930iGIV1jihMa/zhajVY+dsQcfBJXKj5bsvsA==
X-Received: by 2002:ac2:54a9:0:b0:521:44ce:2999 with SMTP id 2adb3069b0e04-526c0c544fcmr2594388e87.47.1716449750762;
        Thu, 23 May 2024 00:35:50 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bc99sm35840452f8f.11.2024.05.23.00.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 00:35:50 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] fork: Use this_cpu_try_cmpxchg() in try_release_thread_stack_to_cache()
Date: Thu, 23 May 2024 09:35:14 +0200
Message-ID: <20240523073530.8128-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use this_cpu_try_cmpxchg() instead of
this_cpu_cmpxchg (*ptr, old, new) == old in
try_release_thread_stack_to_cache.  x86 CMPXCHG instruction returns
success in ZF flag, so this change saves a compare after cmpxchg
(and related move instruction in front of cmpxchg).

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 kernel/fork.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 99076dbe27d8..c9e994d66930 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -205,7 +205,9 @@ static bool try_release_thread_stack_to_cache(struct vm_struct *vm)
 	unsigned int i;
 
 	for (i = 0; i < NR_CACHED_STACKS; i++) {
-		if (this_cpu_cmpxchg(cached_stacks[i], NULL, vm) != NULL)
+		struct vm_struct *tmp = NULL;
+
+		if (!this_cpu_try_cmpxchg(cached_stacks[i], &tmp, vm))
 			continue;
 		return true;
 	}
-- 
2.45.1


