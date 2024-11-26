Return-Path: <linux-kernel+bounces-422733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32F49D9D7F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 19:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8EB0281D89
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F2B1DF738;
	Tue, 26 Nov 2024 18:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IU/UWMgf"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF031DF99F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 18:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732646445; cv=none; b=CZB2R3iw6W53YAtGpAdMzuscY0TImZgb7mkRpTJTBXeANxi9jX7J2wqZzU5GWNPZ8TSF82x1ttPusasWaFjWGD44Wuc5P7EQpTEwfE9gcCaWzqsSnQ5FX5S6yQy/T+oLxhY3izGKLhNLj6KidtyZnLW7qDsMfjNpoOzVqUYj5A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732646445; c=relaxed/simple;
	bh=W1uos8U0fyZ4z1CKRpKfES+fI7812NfAud0CZtZrJgo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jgNwErAohGtqGhYYFtXECeZl40us0pUmmVUgCxkm8Ig/K2YQZAjHY5z9NpfdW2YQKltbXO8JVHMKHJ/AT32+RVjMlI6sYxRSjTgSuzGdE0XrVYx0uVd/cgxICHnAEUwWTfzkqiaR+RXyanomJUY2BYbp/f7uu7dompGzTnBWOsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IU/UWMgf; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7eb0a32fc5aso5232761a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732646443; x=1733251243; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4aAcSP4tCC4KjpwxBl16IgKI38w3EH12i0rt/RCl3F4=;
        b=IU/UWMgfDLeAKkoIORuQGSxhFsv3vb+eaQQXJ24tEaYE/WOmBVatk63/zYOXuJ04Zu
         QajYjW5S3B4peZRXgkEI2lIhBDGfuHX6fdeX5+fTomyOoD/Zn0KV3a03LH9ilD0Nbwzf
         E20Zo0mBW1+hqvgxkxZepQGqs6pnL3/sBDmneWZM25hKRpCzieMqin1gCBvMogGuOUTu
         LE7eQ7BbRWAcIYzP4WzieBZ543raNUmUT/yFTRB++iTO5ORgmiTqo6blBCy0KpLt68bn
         ncitNYQJu3qr1HKElu+8yD3BI1ZQCwjv46QlHWThzA8sirYTpJLDMOAjQeo8maEzuVHH
         HoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732646443; x=1733251243;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4aAcSP4tCC4KjpwxBl16IgKI38w3EH12i0rt/RCl3F4=;
        b=DvJHOPKxhewOOMkps54kio1mHBOc4SULcuNyJ0MMIjlBeKG253uRv/EZbJmsrXdnF0
         Da3l/Pxdhrjn200AmJKl4nPp/IWh0b4Cm5ycQ+q0ikDK4rc1EUScWBTCOo9yQ4aMYwjy
         KZ4JhhYy6DibiRfuXp4VvZrAy99Jy5g3GFwbtw2jFIqAWAuAWG19aOxzxW4wjEV7djA+
         guaq05H2fkNme62TI7OXarR833byNodKUMmOgUlL+wuAJNqpNntq07vMEL2x8lueJlcd
         Q4NKHyQQj6vwFgpwrGaFE9A8m/Y3SzUWJ0Mrax84aPpoFZWVMgYCz2JoCpAH53bhjdSw
         tyyA==
X-Gm-Message-State: AOJu0YzYgWukzX05dgHEYTREUbWIGInmdZHUtQx9FV0wtIS4M+twUfY0
	/WIxs2BLV2fCptF0N7+zkjyEP05DHLYTU+yj/C5C2EDzBvyPpz9v4gBAThptBgb98TKItuAUZh/
	K1ScbJkBwTg==
X-Google-Smtp-Source: AGHT+IE/nlDO6Pbjyr2D8bkoeDIG4jcFf2KoHDlZ7rdZCoEDIFVfpaHOptF8AlbF7nkwcnEiT8N/mBYO1omyxA==
X-Received: from pfxa39.prod.google.com ([2002:a05:6a00:1d27:b0:724:f18b:c05b])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3944:b0:1e0:d2f5:6eca with SMTP id adf61e73a8af0-1e0e0c67e7dmr693917637.46.1732646443244;
 Tue, 26 Nov 2024 10:40:43 -0800 (PST)
Date: Tue, 26 Nov 2024 18:40:11 +0000
In-Reply-To: <20241126184021.45292-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241126184021.45292-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241126184021.45292-9-cmllamas@google.com>
Subject: [PATCH v5 8/9] binder: propagate vm_insert_page() errors
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
index f550dec4b790..339db88c1522 100644
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


