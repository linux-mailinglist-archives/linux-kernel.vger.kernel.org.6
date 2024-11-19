Return-Path: <linux-kernel+bounces-414838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D03AA9D2E04
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD421F22A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FAF1D86C3;
	Tue, 19 Nov 2024 18:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dr+KgiUB"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5531D7E35
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 18:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732041197; cv=none; b=tC/YLRx7pPJGt0QBU80qNsdgq9Y/4XdoiTaNEPKFe35i7cMmdL9tIZBN5NRhZB1CZRneHQOBm8cbfOBwdyNnYBZlNxB2cFqndJlr0MYITmGKpOUqArUdOugfDGJQmyo4FD7KMUST5z1SwmK/ITXKACu3KmN/8eJdrKaiRMNIeDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732041197; c=relaxed/simple;
	bh=wxsmlyP+WToV6V1HulnlNVW1tnL7apXHhJYL687VBOM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oXshl4resYVoLdiP9sWnSOLQOCxXjXPONkZWbAEFeV87vGje/5TZYiGdN20gQERRWK01trbKkNYgsXjwd7H96XIZvNthDZzP0BEL+g2whOxm3Js6S8k2s+Kza5Oi4ke+pBMYXUkgOeCQu6Kv/St/LdCZ0BgJDKmeQXev5g8r9/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dr+KgiUB; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ea45ba6b9aso3852195a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732041194; x=1732645994; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CcyRSlRTjN2gWvMAog98q27NJnjQzmeZzTCDDKlo7k4=;
        b=dr+KgiUB6qmuj4i862tdq1fqC79lNowU9t0Y9HYLHdMbXmefZu83MFtjy/IFct8ftZ
         IB+3G881O/TZKlXjZMvulnEpuXL+favz7G96A2iROcMYIsWWMJ6HBCXCRxi8DVAzPbu0
         6jQmrrCrjQ5L/pY52cIKr7LIpFqENPLl3Vjb/djUciwXkE27SyrT6a98VH1Ln7PMat+N
         daTNfWr/nenZ/vBHYbdfNqVg9PLzcpEfh/n+zo9/w/Zu4Zsw96tA9YR/F3145p5RqGv2
         MwplHX1cHZHqa7x/MJcAbYbafgUZICT67MURVkVIJPRgWSQMYREsfNOrbsAXHyEvSzzC
         pTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732041194; x=1732645994;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CcyRSlRTjN2gWvMAog98q27NJnjQzmeZzTCDDKlo7k4=;
        b=JxrffM5tq0Uqe1Cst2YQ05up4qh6BELhkQ4d/NAU3FPlbvsRL7fWHvo8AVN5b1mFlV
         EmpjhtOHEgjc75sRyKrcff/t6QYk4WawGR30Hu/tE6xPsWjB8xzwrzBNxJYnoidlnyB3
         Ox36rqXqPaDRykqCbd9WR6ZdVEulzxKO5p3VcObccXppQ2v7tq9pZBaRJH2iS5dPk9E4
         BBKr02K1rj5c7c4AwxpDQ1T/CY1RLHXLsy03uqq2rMj2Lxhx/nj2pCHFJ5j6dq1kvVPL
         5rVW3ah+HTQ2rYY55qihoRS+NbnjYwDyzVDphpD4SCULuQ1/ZvGVaxYQeIkSTTJFpjG6
         ubwg==
X-Gm-Message-State: AOJu0Yy7XqiczX71upp0KDjSyOj9vX8U7Z0iydoRID0RADjY5d1JWj7i
	MDG/oA/Ow1aaZQNz3NsbU7dLQoZQmmNfmd2UGSBRqHRqX7WU5rwKIlbLzx2SAzc6TgyFakte5sN
	SNUlkWS9Atg==
X-Google-Smtp-Source: AGHT+IHEMaKeMAlsSZSmKtt5fZMyNgnoazxqAI8o2ZhbdOkrf1pvp5xfQ7xLi5RTDzM3Nl0CnL2XkjmMoMISdQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:90b:194f:b0:2ea:6b45:a5b6 with SMTP
 id 98e67ed59e1d1-2ea6b45a6b7mr17904a91.0.1732041194673; Tue, 19 Nov 2024
 10:33:14 -0800 (PST)
Date: Tue, 19 Nov 2024 18:32:41 +0000
In-Reply-To: <20241119183250.3497547-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241119183250.3497547-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241119183250.3497547-9-cmllamas@google.com>
Subject: [PATCH v4 8/9] binder: propagate vm_insert_page() errors
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
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index f5dbaf1d7d65..aea35d475ee8 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -339,7 +339,6 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 		__free_page(page);
 		pr_err("%d: %s failed to insert page at offset %lx with %d\n",
 		       alloc->pid, __func__, addr - alloc->vm_start, ret);
-		ret = -ENOMEM;
 		break;
 	}
 out:
-- 
2.47.0.338.g60cca15819-goog


