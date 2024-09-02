Return-Path: <linux-kernel+bounces-311389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFE896887A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939CD1F2380B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19D619E960;
	Mon,  2 Sep 2024 13:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEnIjUn4"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A6A3BBC1
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 13:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282463; cv=none; b=PWiUIK+9M+35aNwYvMfOJphj9Mc7nL52U+FSJea+nwjbLu/4zWba9TrwzSANsRrp91Jrul5WllFbddO4bzaJ274Y+MLdD7q/H2InLoR6dXPsFM4LfC4RCtQOgWwHSpk9QNU5aprAr47bHsZ4QHWmwJ2xfsuwYSBBdgX1N+jNWMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282463; c=relaxed/simple;
	bh=mMIIxfmZ7Xm7XJ95eGk3R/BSaVcbHE6ZqvxroO+6mSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lQPAcYGrGYtqIFOx2zqUkybpzmW0Lkx+GYRE/VTJtCFqUyS7FWWo2mZpFQSVTlotuteCmG+4lt+VPq2ctC/JA69VSNkA3Pp4qYgREW2gyxjVlbjsTGKhIUhpc6O0N6bb3HrfLmz9GrvtP+DuP0OvkvmmPSGKpUSzS64clZYDQrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEnIjUn4; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20543fdb7acso13638415ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 06:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725282461; x=1725887261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sFZUTAqHg0mXdnubj/djkGjdGB11n7hT4rjjj4dAEN4=;
        b=dEnIjUn4cWi6y0abUOW8EKIrIkXgX43kTaJ6GWZgDulTCWNzSHOuoGx8Ok88F9+R3a
         QNqnyPHwvwpx+8UDLA5Z98/mD6kLTHQDEOM8tnDUr09Q3pOKczCIAqGjQ6IYFuz8lWlu
         oska7+UgkOFY/2EzKvrtNLc0GGARhRYxB/+Fl1NIBHoz1WVOmaob+ewliJk3x3uIJkXQ
         dZnuOMFAAbiEzB5FbjzH9lfB8cjsmIOXHG8lrjjOliXqbpdr14gqTxgmOf7qozD8cF1+
         3gYYKld6n0G2OiORXq+0HOzu/WKtSglivZ31LJ3PvfEN4gVy0f2OqElpdB/cqHz1IsZa
         RrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725282461; x=1725887261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sFZUTAqHg0mXdnubj/djkGjdGB11n7hT4rjjj4dAEN4=;
        b=GekQnykBgn5xOGpih3Wj85uviII4/xbEcr/rKbi5qhEVqun1aNuk8ACtZCwgUMavYd
         U7OODPOCa5iAzH+YY2gHksRWzZBMkF53/0lCL9vVfNKYUYcX1VwvORtOIMJCZ//IbYjA
         QJrXGGBqTYwDDNETQwJPDJ2MPHXsGyCqjC3hyedvrtjm6Z6n0CYGbnSa54nY4uItQdXR
         uM29rsUQl9bgRJby/gUQkE9zz/yHeGxFx0+w35/0UdovepLKpaoAjWqpXGgTHsojwnZ/
         Z74a5IaFYthtzm9uMcJbBzR2AiiSxc+c6s0aIdWuwUI3e1YmfJ9esKvwINN4alavrj8g
         AJMw==
X-Forwarded-Encrypted: i=1; AJvYcCWFXAMSGp4q7eG3+lRzSaWZCiJCaKWWf6eW3pZbjpL+2P2yhWPOVniY66tO+ENn8tHmmzf9P+rZ8ga7oOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/pdQN40Hbo5qpBQ0sqh21s73mAqvOBbizfaibgBom9em0+he5
	CyUk1RqwWXKHtva7nG2T2OR/36+meR39riLoFzYYNSubtR+q+FDQ
X-Google-Smtp-Source: AGHT+IGqMjFYG2eXF6JWqFl+h1joY7hESP7l1agLujJsgExFiN4sFQOBsvcjHdmTZMci0p7yJ+yong==
X-Received: by 2002:a17:902:e886:b0:206:64b4:3088 with SMTP id d9443c01a7336-20664b431afmr7791165ad.29.1725282461127;
        Mon, 02 Sep 2024 06:07:41 -0700 (PDT)
Received: from localhost.localdomain ([175.112.156.113])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20569425c69sm21297765ad.304.2024.09.02.06.07.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Sep 2024 06:07:40 -0700 (PDT)
From: Ruffalo Lavoisier <ruffalolavoisier@gmail.com>
X-Google-Original-From: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>
Cc: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] binder: fix typo in comment
Date: Mon,  2 Sep 2024 22:07:32 +0900
Message-ID: <20240902130732.46698-1-RuffaloLavoisier@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct spelling on 'currently' in comment

Signed-off-by: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>
---
 drivers/android/binder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 905290c98c3c..52c30a699b0c 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1546,7 +1546,7 @@ static void binder_thread_dec_tmpref(struct binder_thread *thread)
  * by threads that are being released. When done with the binder_proc,
  * this function is called to decrement the counter and free the
  * proc if appropriate (proc has been released, all threads have
- * been released and not currenly in-use to process a transaction).
+ * been released and not currently in-use to process a transaction).
  */
 static void binder_proc_dec_tmpref(struct binder_proc *proc)
 {
-- 
2.43.0


