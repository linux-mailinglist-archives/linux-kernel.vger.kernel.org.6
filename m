Return-Path: <linux-kernel+bounces-439740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4348E9EB366
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5C12820F0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F365C1C07CD;
	Tue, 10 Dec 2024 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fRXbLfcS"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9FD1BDAB5
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841112; cv=none; b=o50exyQPt5bSAw49GFaKOAXFmDmQPdMMhRNiDTRnq3bjDtUfZS9dnO04dM99m0W5aRLAGISB5codlv8E1D6OyTUCNJWh7NCqUeSB87g5b8CGpJYF/xVExTgPgydsqT/gxok+Sci+tiNjgaCrWxdVd2NwsqDD2a0zBavwboQO3vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841112; c=relaxed/simple;
	bh=RK87QEwL3LlvRROvTEuHWHIhrWUPkbmydqOAAo5kyN8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eYVfPoMhyldKWXxFNEfbcxo/qpKuiBRxfBszoK8j8rmKT1Cz5f9juLXLB3SG5vO6Vz4s4Fv+xkKAJlO8bEZu9weYT9drQhL+dczF73r1Ik7vKMd3QZgPnJptFnBfcUSdFu0kV04Eu0xbgrLVMK8HctJ5b8MU+EaSHVQa9dleAfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fRXbLfcS; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-8019860a003so94148a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733841110; x=1734445910; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xBFqXT4tYJZMF5Un3bMo/k+jclj9EFryPv6FKf2LD2k=;
        b=fRXbLfcSFc0V2ehTGmoDHSOnSYyoGalqzjIb5lXwuxLgA3cuzmd4nDo42xHiaa64W2
         nJfUNEglV1bIZml+eS7zVKjf3387E2uTR7AT07Laq2xNKI1gy+6YKg8idmUEA+HvLr9m
         vGarkkHK+51/b5HpKfna/8+sOuCS9Lhj6QMdINtzYt3QPrlS9clvq34mwUNKEMSLnN4P
         cmCQogw1ysMlF4yKNWlCyP2cKWSul3HOqPhuKRLOJeCeKVW7r9fKx1qCPw6ru/7mgF7N
         SOfF3Y6yxF0ixmGkktWVTzbG391qzwyK5558vsZBcfCQRzqFwopeqHizsmlVCZRJkyp4
         hgog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733841110; x=1734445910;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xBFqXT4tYJZMF5Un3bMo/k+jclj9EFryPv6FKf2LD2k=;
        b=sZABWpRDVAULNt7u8vLeGc9JwJw8izRHdHOO0lY2rjs+6hcVBhGUJLwd4iUUep7w7j
         pBWCGVktbaw0v9TZSYGHutMH8VX6olVKH0y6hHi846r/ZtoHGZmcB9Br4wBpjcdPGAGd
         AdNoIWqr3kgLWFzBg9h9ACx40Rh+hSRIodn8rwgEdpPU/SAijIQorTkzujP97qzZGJk8
         XRPix5qfquvOxzQpPtAEd2ZJW/ueJ3DJNLaZPCwPqBsue9cBfb7yxrNIMF5WBAQyD3OC
         gHOdsIwabzwmLbMU/wRHfTdP1Djhlq2Qq2Jmp0uzxzFjcuEyhx6E+QebGDZHmlz0vwyQ
         k3fg==
X-Gm-Message-State: AOJu0Yziav8IF9CPqBT902WxdZ7L7T+O18ZZglxT4gFrFBiByr61RLwo
	BalP50Al/uHcJgl98QkuiLqupyOUKPdkHGkwESCBsGH9fR5FVzcln++sN0lFAuViZX6v+/KviVE
	rapBG/WB5JA==
X-Google-Smtp-Source: AGHT+IFKQMA2vbxEpun0Ak9BIjmEHP1yZeaGmVfzUU2no2vEQwei7Cv1PXhOzdaM8hbXU9rHam+WpbTjZGbnHw==
X-Received: from pgbeu25.prod.google.com ([2002:a05:6a02:4799:b0:7fd:48ab:49fa])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:32a4:b0:1e0:d8c1:4faf with SMTP id adf61e73a8af0-1e1b1b5199amr7961244637.28.1733841110318;
 Tue, 10 Dec 2024 06:31:50 -0800 (PST)
Date: Tue, 10 Dec 2024 14:31:04 +0000
In-Reply-To: <20241210143114.661252-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241210143114.661252-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241210143114.661252-9-cmllamas@google.com>
Subject: [PATCH v7 8/9] binder: propagate vm_insert_page() errors
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Instead of always overriding errors with -ENOMEM, propagate the specific
error code returned by vm_insert_page(). This allows for more accurate
error logs and handling.

Cc: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index f86bd6ded4f4..b2b97ff19ba2 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -353,7 +353,6 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 		binder_free_page(page);
 		pr_err("%d: %s failed to insert page at offset %lx with %d\n",
 		       alloc->pid, __func__, addr - alloc->vm_start, ret);
-		ret = -ENOMEM;
 		break;
 	}
 out:
-- 
2.47.0.338.g60cca15819-goog


