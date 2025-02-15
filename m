Return-Path: <linux-kernel+bounces-516427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919D5A37152
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 00:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C810C7A3F9E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 23:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C811FCFEF;
	Sat, 15 Feb 2025 23:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3d1p2qo"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4911FCFC5
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 23:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739662657; cv=none; b=hJR+IEC2kY9KKRAYLxiVm5+63d74rzK8EAPy8HL6fdn2MleP3cT3PDvJo1jc/oLEh7LMMu+TAbwlpWQM+J7MHl5WEUA0BX8g47nbK4zWZIFp1cHaTYuJD98tacOyr+T0NEVg9mjof/iT8dD+EamYgq+u5av0NIiHABOSPgbyEbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739662657; c=relaxed/simple;
	bh=J2Ijsb+HD9ILre/twDctrrk2xivaEVKQsJ1LLyLy2gM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UL8OpzFZ6glA2b5ZZu/H0TigcqEM+jrodutu/dReSQIgAtpkaAw/FbJj5NH7C4kE5BZ3zXTJVtqSeoZhNIB4BIpjmM1qoI8MYyUg2DL9DftpIbAx/SzYFXza11sZnY7SL5KdLrk7Jd0z59ORwaKHW2EXosVGUSJagBqZvwi+Gtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3d1p2qo; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220e6028214so49779165ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 15:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739662655; x=1740267455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZLmRNArgA80J6VvBUYgRP6X+hYuozIBGig62C2XSMA=;
        b=c3d1p2qo/i1QbnhPm4OeaKXyr/Cjw6sVuR1ujvzCew9j2yQ/PlPHH5AWZvTKtFs5P4
         pcQxBQRBVUK0mscWe3BL0KE++kT6LJt2rssxRcgt+ibt1i+MNgoMrQ/yJuyBuF9ZXBEa
         02sQ8sLUXfzao3F7Cj2snWeNtW9Eie3JrMl4OOUNNMJNiOjUpwKmU0eigcQydMHh/T0j
         3EosChoid1Ks7rDy/kRbNBVePULtqap9YMzo2cWZuej8FVHi8KaxOuZdIINh1YQpFB8F
         zIuKY6BmFXsseHEYECrosmQ8TopJUJI0HgIcXffxqFobowpHITyxhZ0tDKAJQGWQKJ/R
         18Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739662655; x=1740267455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZLmRNArgA80J6VvBUYgRP6X+hYuozIBGig62C2XSMA=;
        b=MzVQtNNXAgHJUssVUPO2/iZjzejzbWF/yqEX1ZpLfusMVqCkz8dEfZ1+ub62J/BmNh
         SlqasSiL0gD38NA/s4Jlmr+JHbhdbCq5dhWZJ8NEHtZtTOov4pygxP/iQOqfLfR6k07F
         jkYirGQ7YuNYbPeuv0Py/jRJoB+lzCY1abYDs9gmaTklBA0yNhrTvB2jK3jiYrRCEls7
         9FX7q5Eg4SOw96PzNfLEU2I5nyPZZ4NfRv6/LKbHluHjmKXWAi0hCqoNk7MHYJk20X+c
         DKnJTTX7k3Uo+4q5LHhD/iz4lKpARxvZfKdbf6FpQBuaTO66EPxYQqgtrFCQRiVfie4A
         kXUg==
X-Gm-Message-State: AOJu0YzNSBgKdb1gEP5JevT3l1aAQg+J0yHPht1fv85YTkmfHvjy+G5o
	z4ItOoH00WWYT1roGkSqqo966hvGNWoV1Yr3aOAAEu2FmWwvK/BEiWa7QaJzs54=
X-Gm-Gg: ASbGncupVCt0TmuzFidsqwsAKnkkOzDNrFPzBVyG5jmj00XeTOOhAj3jUhf1tDUciEj
	ydAZVD7W8ku3RSetnNUnnuGXhb9YXMH7brJg2WvxlRxrjPo/iCLUOM8lmEWwOwf/QRt2WyDJJ1k
	+E2GlnS6qQuWYD/3XSEtEiOoP3TAC4nCgOPbV/1TCsu3khC2djVLZ43QYrJYJmwwoy+/OxA7vj/
	Mc7TuSf+hu0/zsj5f1JWwFxsUFmXFIDOINIJeVveXVx7Xwwi1mVaHYPbLjIKBhyjA9naZY01nf9
	31m8BfLIRh41vb2ub370BMpKdtnliVJxQHaoLiPO8lzYwm7++hG2hjTOHDkCxm2u3wSQJPShLZc
	73e5wfBHM
X-Google-Smtp-Source: AGHT+IGHpYXBVaxzFZltX34plZc0gv+ME97gWlwFyjYr3ZnYEjPjouOwyO/eQTYtIsBhnAL6ElMWBQ==
X-Received: by 2002:a17:902:e882:b0:21a:8300:b9ce with SMTP id d9443c01a7336-2211c55225emr21118555ad.49.1739662654816;
        Sat, 15 Feb 2025 15:37:34 -0800 (PST)
Received: from test-suraj.qjz2hk5f2gku1a3adsvczrat5c.xx.internal.cloudapp.net ([20.9.134.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556d66fsm49165565ad.180.2025.02.15.15.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 15:37:34 -0800 (PST)
From: Suraj Patil <surajpatil522@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Suraj Patil <surajpatil522@gmail.com>
Subject: [PATCH] docs: Fix typo in usb/CREDITS
Date: Sat, 15 Feb 2025 23:37:28 +0000
Message-ID: <20250215233728.105709-2-surajpatil522@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215233728.105709-1-surajpatil522@gmail.com>
References: <20250215233728.105709-1-surajpatil522@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct 'Implementors' to 'Implementers'.

Signed-off-by: Suraj Patil <surajpatil522@gmail.com>
---
 Documentation/usb/CREDITS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/usb/CREDITS b/Documentation/usb/CREDITS
index 81ea3eb29e96..ce6450a6ed7c 100644
--- a/Documentation/usb/CREDITS
+++ b/Documentation/usb/CREDITS
@@ -161,7 +161,7 @@ THANKS file in Inaky's driver):
         - The people at the linux-usb mailing list, for reading so
           many messages :) Ok, no more kidding; for all your advises!
 
-        - All the people at the USB Implementors Forum for their
+        - All the people at the USB Implementers Forum for their
           help and assistance.
 
         - Nathan Myers <ncm@cantrip.org>, for his advice! (hope you
-- 
2.43.0


