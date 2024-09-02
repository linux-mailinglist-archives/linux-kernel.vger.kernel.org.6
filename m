Return-Path: <linux-kernel+bounces-311748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4419968D03
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 19:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 132AB1C22A9B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210271AB6C3;
	Mon,  2 Sep 2024 17:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FLacJi7o"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401221CB52F
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 17:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725299693; cv=none; b=X2R1VkJQE0wbCutffonBSfP/Q0pj/et8J78s4K5EBKGGpYdan0aTeBxuoFKRHGFU2CtUkvqd9Nqud0MlnCAH929SFyUfM8r4+VZ0JrzGfxue13jY847QFataf26dyBwT2cM0Jo3KfO9zp/mKl/oeOL4fhuj2wqP3UNM7pJvNWCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725299693; c=relaxed/simple;
	bh=Or4L0YtTs13BfkOi4I8rk/X5k1kjVy3taOVwkK78xZc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=U85JZYU1ul1eGDBIpL3SojKcvsoHZcLN/fAv+qK+Bs/jSnnTRAUQ+kpCdFFK0U8bjoWm2mSwVp5Ls7LermVh3JVVErq6kCHfT6CnqVgvbi8KbmI1aT0VqbiFjBlprVj0LYWiHaBqD7Gk5ox0OwY1dOeMuzBDw2yZxd3+kDbjHAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FLacJi7o; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7cbe272efa6so4220751a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 10:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725299691; x=1725904491; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GWsvH8nGGz0m9SYddh/G7CLw/uQRBwu3ZhTMKxeN9Lk=;
        b=FLacJi7oU+LeSdB9SQu5iuwqSU68V4wsmXw9xiQ/gM5Tx3JxviVsmCGrIsVvncoFDH
         bcg0BPWkxZ7+mQrBZaIrvejlTeooP66DrkwYavlMKmr1OOoD0faL/GW0L2C5/n8RyTqT
         vYhoUpMLR8QvCA7stCdHIPxcxaVs9OxL8M4w1lvCMFAUR2T/7JDSf1qPpHYmjgJvZtcq
         KQYZey4BVjnw22yk5YO5iJPxjQsTBYRO4fF/paExynm7tihKwQ1PE0nmRQ26ayJ+Qcll
         Hifl+/1/QYjE85riS38EEZ+14+Y9TjPiAaSvXFdPIv4wiEs2p20RvpVJSXmQvuWFu2yE
         KWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725299691; x=1725904491;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GWsvH8nGGz0m9SYddh/G7CLw/uQRBwu3ZhTMKxeN9Lk=;
        b=IFo3LkdoUfAIfCErhyvaOLrZoo9QSdWJA99U012B/QhnzNBJuSG3p+lmwjfOYrQdih
         N/Ht4S9av1W5WhZs9gNt6Gl/DoR6/QoXvRA40bnSADQ3FakSPEsh5b10jE0VZFzxVy+d
         Hm9jr5LjZ627/ux/J2pm/bb2XyVjAqSnxxrjQU/X8Gt95SINNuI2BVZwW88yebIfN53K
         Kx97d+o7c2EfgSnXzxRaLxLxodLzirjuN4GbPWPKPf1oYSqyN9gD49MhaDczXEX6ptTi
         KvJ7G8L+e0gx/Zy03OXsipDsujoxmtAE3q2pEpe1IdPjaU99FA5K6Wqes7+dXSiie8I5
         gIYA==
X-Gm-Message-State: AOJu0YxOx0AyR3y6JTxwlf9JM4/pCZaah4AUtcc+P1WFUM6LCoW2yKAf
	EHxRKoJQCJFtgevBxtc7ZruepenNveKovrcMUxSXEeBKQTPkt4nPLMlhaucR9AnWK29tZaKKYa8
	WWOzRtI3ccA==
X-Google-Smtp-Source: AGHT+IGniTMUWie8uszJ+t68Wk37bOALsHtWnWnwn00Se8rfnBzrqxyuq/isZ4hrNm4mlEuSeoL0ogWyCuGTfA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6a02:f95:b0:75a:b299:85b8 with SMTP
 id 41be03b00d2f7-7d4c1033910mr28598a12.3.1725299691194; Mon, 02 Sep 2024
 10:54:51 -0700 (PDT)
Date: Mon,  2 Sep 2024 17:54:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240902175446.3757185-1-cmllamas@google.com>
Subject: [PATCH] binder: modify the comment for binder_proc_unlock
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


