Return-Path: <linux-kernel+bounces-311752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C7B968D09
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 19:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C2C2B223CE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0BF1AB6E0;
	Mon,  2 Sep 2024 17:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ovwvto6C"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C88E1AB6F7
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 17:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725299899; cv=none; b=Ve3GZyoSLMDK8VUb+tXwPOHBqOp93D5MJGQdSyD/GW/equhzhuUzDbYNmXa1oZfhcuXtZAX85VsGqc+i9KPcTDTL449xYmScBt9O5auc6pSDUdPyudG1VnCWBoXFLd+FJXdQh7poBlh7PqUGGm/J5BIVsARvT6vMOX+yEkTQdLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725299899; c=relaxed/simple;
	bh=4kzEsaQgEmzVzzfopdsGcAYx1LDjy9ZtSHVQooEPCW8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=twZ1LHc6Fhshc7LYkqe+K6TEB2I+gLt8W5QrKrYGMkp/zy1jU17RZYbkrHCkKduWCo6+9PVQaLliR8bMVOHtJyyzFrqk5LG8ZhKWNXqtCLj/hgq9qJczZHAOh2G2XXATCrZJgbIKy+W28KzRebC8wyteb/CvgJHFJR33dpizQTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ovwvto6C; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1fd9a0efe4eso46362225ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 10:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725299897; x=1725904697; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cCbFzRw/DuV8itIPIbeFQvrbmd5zaqmR5Px/qsB2pkw=;
        b=Ovwvto6CdcmhQvbSAvATPzjUc71Sq1kxQTZduN50heP3WqOwrxmoMspca49xSf7kCC
         ZScP9pqVRT++xEEOPbpFUNVGwb9YA/AaTMFf2+tcuy3jntSiABu5uqFM1Q+w0bkysGLh
         xskYGVtGH95Rb6Ay3RZY2y8FH6Z7rHPBhAAAFMRfaUOA8m5f6xD+0V5sUO2B3NDzVYbC
         oEcig22UvL55zPtLfVJCh+Uvd1cYizCuiklCXJKX/dzALYl+qHLcgVoLwv4tAVGnX95t
         zMwV7ulf9WQ8TpDg+uoX+tvgm6Yij2VnRcWrna5eThxuqe5X0wwWYKwCzhfWqrfcuQGD
         yzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725299897; x=1725904697;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cCbFzRw/DuV8itIPIbeFQvrbmd5zaqmR5Px/qsB2pkw=;
        b=fvCgERIHu0iAcNw3SXkTyYQgdqtRzia+ylMqOxnS+/nDW21s/6MyPZiUjNpjE4730s
         Y6QWQ+jleaqtkj8v71XO8xs763Z/CBLpReKUzSV3YVEqwtJf657HBklYa0o4q+U189XJ
         9Fon/dyNEqKueapxPBcNTDmQg2/xDEcn7vJnFbwjo/5dOxcZvhf26ZWEO/RH/AW9hGH7
         EpXm1b0laG/TTKt9Esixp8nqUWbzkqEojBQmkqCY0aVc+Br+zjifEsjZmp7S+uoGFYrd
         xVoaXN80+3IEQfVR9Oi4Dddu0sORf7INuHYBZoM1CH5iUS+tsyp1aznK7SB2GYB+A9rU
         jKtA==
X-Gm-Message-State: AOJu0Yz8vIli96QHasojsT0ms+9mojKpVRtjIVSraRxrdqalxHwhbw3p
	VEoHkshwibnN+wrK/JXKARtf16PFVIRyxIm4kA7IkngQ+lRkDSXUvCKxVfyMxRLx25HV9T+2n3d
	AtyGq57ANHw==
X-Google-Smtp-Source: AGHT+IGIDuqx+5qheu2BI1hhS4dg90zd7hg1VEbxWnqmECtcRFXoSSuQmeJyzIlgfkDalczwPboAidV0siCfFA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:902:ec8f:b0:1fb:1ae6:6ab9 with SMTP
 id d9443c01a7336-205271aa1c6mr11723385ad.0.1725299897407; Mon, 02 Sep 2024
 10:58:17 -0700 (PDT)
Date: Mon,  2 Sep 2024 17:58:09 +0000
In-Reply-To: <20240902175446.3757185-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240902175446.3757185-1-cmllamas@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240902175810.3758196-1-cmllamas@google.com>
Subject: [PATCH v3] binder: modify the comment for binder_proc_unlock
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	bajing <bajing@cmss.chinamobile.com>
Content-Type: text/plain; charset="UTF-8"

From: bajing <bajing@cmss.chinamobile.com>

Modify the comment for binder_proc_unlock() to clearly indicate which
spinlock it releases and to better match the acquire comment block in
binder_proc_lock().

Signed-off-by: bajing <bajing@cmss.chinamobile.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---

Notes:
    v1: https://lore.kernel.org/all/20240830073743.2052-1-bajing@cmss.chinamobile.com/
    
    v2: Reword commit log per suggestions from cmllamas@
    https://lore.kernel.org/all/20240902013636.1739-1-bajing@cmss.chinamobile.com/
    
    v3: Wrap commit message. Add version history.

 drivers/android/binder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 905290c98c3c..089bf2b45f0d 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -277,7 +277,7 @@ _binder_proc_lock(struct binder_proc *proc, int line)
 }
 
 /**
- * binder_proc_unlock() - Release spinlock for given binder_proc
+ * binder_proc_unlock() - Release outer lock for given binder_proc
  * @proc:                struct binder_proc to acquire
  *
  * Release lock acquired via binder_proc_lock()
-- 
2.46.0.469.g59c65b2a67-goog


