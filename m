Return-Path: <linux-kernel+bounces-516430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0744A37157
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 00:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C08316FBB8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 23:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856201FDA8B;
	Sat, 15 Feb 2025 23:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9rm8rtV"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C641DFD9C
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 23:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739662961; cv=none; b=Jt+Wi66t1c8p91ftY5NpP6EqWdyNDOuY5i/Dv1MIz0H/SILpISUy2L1zGOoSLLTLnlftwTNBivAKBM+6v0hgNZF1GiKZ6aZaMS/eDIH6wkNoHqAacSt5EbvwBh9jsFCp0DF/1A3E/7SUjXM/bgz20jea0cH3ZFCBDLihNEyJK3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739662961; c=relaxed/simple;
	bh=J2Ijsb+HD9ILre/twDctrrk2xivaEVKQsJ1LLyLy2gM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhAETxmtPhI+d6w4dWrxM2F97ZaR2djKbdWFX6Q1w+1WTUwL9oBAUjqs6TWjpABnpDullcAQKpWscD0d+rDINiqhYmmmXeyC1XZ//2VYyvAhGT4C2kDyc+cTnsXSjkSbdqTTpt7ghp2SO+EVpevHi94cBeWQE8XaT8qw872+OYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9rm8rtV; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220e6028214so49803995ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 15:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739662958; x=1740267758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZLmRNArgA80J6VvBUYgRP6X+hYuozIBGig62C2XSMA=;
        b=h9rm8rtVut9flmPesv4pqLh9Hsesc4uc/FDSTRmZpQKOs9jQ+dV4p8mB+BDSCr6g1u
         S8qT8Pok8BNRsGS2RMcMI1aBqL0amjGeJZo0EzxzkOhmCxAvmXNAvByqe95wGHCoOcTv
         6FpjAk85h+TnaOkr/O5+emppM2aeGndlAuDYmvD80holXrrWflQOiWXciqgLmu0KWWlk
         m9FoTRoCgIUrmd0VLr+tYRMojt7qIFqUVuHCiFVbc9khVpylupV/p6itHr7nsaNO12Gp
         0euxBrXxXUuh8No/ITJiX2FJAyGQ6TeoGtv8Qb+ftoi41GUDZuh5d85QxDwAudko5OH6
         xseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739662958; x=1740267758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZLmRNArgA80J6VvBUYgRP6X+hYuozIBGig62C2XSMA=;
        b=RZF0xhgobTnAKoIohGi6tfRd4fu0P19rQ8n5bd22PENa++zrvzzMhyTHoKjSylaB4p
         Rjf6OB/bsBQ9tSsill0S3U61mxdfa07qALN76tJhFvPrgyRllSWhyLEeSf1HJcW5cVGJ
         aiqUssbuMCstJMudDuJlV4Pdt6Zx47CM5+ezxH/HvNXhnvV7V131CTTqYh0SuOpMh/2z
         5XFdQMMygz/6azLju/Gp+l7vdwYrJNQu+1504C1DbtJ4xL+8E4K9wYyujy6IkDHlzSWQ
         5FNXtsK/cent5OTF9TSzikJyi2Nq/6aweVGsN0H7A3hN48WTOJp16kZmyP+UvUotCzlb
         0r/A==
X-Gm-Message-State: AOJu0YxM5uB77iCBLlEdYP0AWlXqaqGESm8HA1i4/x8ycNymV4YnMwUL
	HAZPiJL1wD5ZtVnK3mcfNOMb1W70cCzu6AtBNLR6j1vDB8ieGnFjR4VYJKWpWLQ=
X-Gm-Gg: ASbGncuGv8nJrL8PgaXOTPwDNg9vaM6meVgVLWfQgUL0cq59nMCoBG3t7686eaNUqsZ
	HBN6o6rFXPntqn8wwadxnJ9iJscRhE1HaqcAhuHw/Oy9GW1bqE0pQC74jGr1HdNZ7BBS4r6FVm6
	bSGACvmPEu/A+CT/k/rxw5BzlbeHifN0LfO9+TfG4m2JP15RSJA/ossF8nzubciWNuubw1KJUrF
	J5Es6XZE154OQgO0sKe1+hV+Xl2OvE+nHbvPepgx61OcWRwd8rfUZOgOeBNESeo2rD//dzKXsI2
	BjH/085qZuFXyp4aGgs1+PVolR4gXE21zI+rJICw6QOnHruDyKjqL9uLqMSMaGNzvQM3qCqqCnc
	Q62nBS97P
X-Google-Smtp-Source: AGHT+IE6NmHktcig9BJo09+F38JhiWnR3tXxtr20ZPVa7Hu4MD4NW4XEaxTqHvWYdSX8s5q88Nsbiw==
X-Received: by 2002:a17:903:2291:b0:220:c8e2:5e30 with SMTP id d9443c01a7336-2211c5547a9mr19003245ad.46.1739662958471;
        Sat, 15 Feb 2025 15:42:38 -0800 (PST)
Received: from test-suraj.qjz2hk5f2gku1a3adsvczrat5c.xx.internal.cloudapp.net ([20.9.134.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349210sm48803145ad.11.2025.02.15.15.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 15:42:38 -0800 (PST)
From: Suraj Patil <surajpatil522@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Suraj Patil <surajpatil522@gmail.com>
Subject: [PATCH] docs: Fix typo in usb/CREDITS
Date: Sat, 15 Feb 2025 23:42:33 +0000
Message-ID: <20250215234233.105867-2-surajpatil522@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215234233.105867-1-surajpatil522@gmail.com>
References: <20250215234233.105867-1-surajpatil522@gmail.com>
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


