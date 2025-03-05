Return-Path: <linux-kernel+bounces-547615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 629F3A50B9C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6575E3A6564
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B10253F24;
	Wed,  5 Mar 2025 19:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jImYgd9P"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0526A1A23B1
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203446; cv=none; b=FD3H5/LRF11tPpE/Y2qnv8guj0f779fNEKlNkcBD2xaI8Gk1pxbBldGm+8vPCgZQ1aQOprG9li9MC48NXNa79UzeJ8bowkAW5nxQeezoRbss64HyZgR2nuGvyuUSj3HU2UMfRHCM2Ca9ILqNEonf+EWec0Lz53yEwi3OXbuqrT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203446; c=relaxed/simple;
	bh=NiSAOPAgkdb/WErvFuPt8dYjPkHrz80Z5l1d8QBlXxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dogNK0v5sEwZ21RJZO/D1v+DV1Ek1yPoWItQgIRGUrmMIDCqLQYN8HIzf5ZVrG1g4f/5AnPyWOFDz+X2zIRWh4JGFefX9/o1bgNqpsjj01ozv+ASl4tQM0NI7/7shisNgLZ0AhXLBANBvVR6ofoaLHtriB+PwcRnFRujHVxJNV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jImYgd9P; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22400301e40so1881775ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 11:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741203444; x=1741808244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HZfT3BJ97SDi73Ze6YNCLhdfpk5R2Zm48aUE8tr5nI=;
        b=jImYgd9PGpn8uTDmZiA+x6xDKd+XFV+7AeY9BKFETZPtYBVU3QwkXORp1S9lQBj+vo
         NQv9zIqWuPxs9Ip2lwSxLnnWK3ldfBny+mVfGVjw5tumUYjtPbAMnWwq9dKTMr5ZkxCd
         V8pZZpAGw/IWeDBZ7xL8DjlMIw3S0isG+PfTRFMw6kwK0IJFhTiwj0ghu5GV2CBMxDyU
         Ohgdk16auEYdwoW62Wmf7XHfLWUQD7Q8E5KBKUjlUex3gv4/UoHaxHhCrNN4f4uaYrxi
         WFZ7J71Hla8xnNas+DmhfEhDgwpj+uf0NTRj1gHIQVuYSsT8SRDFpR7/2uHNOmDlyetU
         2hfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741203444; x=1741808244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3HZfT3BJ97SDi73Ze6YNCLhdfpk5R2Zm48aUE8tr5nI=;
        b=dmj5OhSBLAIAqUM3pe2urX/EGWw/mt8Fw2nPMmXp9sXF3wwyMT+/ob6T24c3iNfA9y
         cPjzDzUQlkmo4yQscUInCL+jEzupmIkqJcYOmFlLh2+VPCFc5VqlML+yOQE5TVGIb/o6
         NnW/BKuTDIxJw5o4Zje4LYLMp60fYHaE4rgnCPMmM33m7pcG/NdjXJcT+lBLSWf1JIaS
         RVPOUJH9TCiNLYV/66P1CjbBtx/7Nou9tujFWDYO6oaGYqRFN4xgfQgbV/1agg/6j/Xw
         SLhg39hLyYhppk61bjlYe3HqP2VlnjwSjSH73/49sB837Jox8KKi3a9U5kx2iqFCGhle
         vMZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxbiI/4jJr1X43X0AWtQwejiOJCfoYz1/25J1nP8wnS4S0sfd63lhA+d+ywhUtOhjh9IyoP8HRfg30tC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFdZwcNKq9yhpVwK9hwKIXXuUH782MvI/q9K+14qQo4ujzMIdv
	njBNK2cqJvpHbTMOB+f+TWRN5yJwWWd60L6ncVAg4t/pMAN/7ZKtfyOsFg==
X-Gm-Gg: ASbGncsl/YBU8shCq0QOOMglcj/Jj3WNzyCtcLcaBPxO3RKJs/1zTJB5XRmmCuWuVA9
	8DEBMQpvKbQcpmZGHI/8XWqDi48jrKLAUALRMMdZFFKINPsjpYsNvoRPC6auSS9kd3HU0RqS+rR
	UHjS8hQjNpvicyObfM/IblgPMNoqicIkdQxhOJpVew38gFF4JvGUt6e1MhHsmox3q+2JU2qtCB0
	h1QDOOqtLtllSXEFbgpvdtHDtVOqc+PsrXzh2dTLv5IXJI922FgClMaocoYwpj5vJerRi1/KZ3k
	XR69UuAA+nUjVrqH5HVr/D4iV1WdVManwKazNX6cP3O0nJgsCBzVV9kPfAJI
X-Google-Smtp-Source: AGHT+IHsMPQdEsN+BrWmog6Gj2bXAKJEAfY6RuvXg31gY6PlWFrf/eyHD0qoGNGZW7v0mj/fHoDj7A==
X-Received: by 2002:a17:902:e881:b0:21f:1365:8bcf with SMTP id d9443c01a7336-223f1d33ae6mr27861905ad.10.1741203444288;
        Wed, 05 Mar 2025 11:37:24 -0800 (PST)
Received: from localhost.lp.veng.com.ar ([200.10.125.114])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7a2bbesm1898148a91.37.2025.03.05.11.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 11:37:23 -0800 (PST)
From: Gaston Gonzalez <gascoar@gmail.com>
To: linux-staging@lists.linux.dev
Cc: dpenkler@gmail.com,
	gregkh@linuxfoundation.org,
	dan.carpenter@linaro.org,
	arnd@arndb.de,
	niharchaithanya@gmail.com,
	jiapeng.chong@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	Gaston Gonzalez <gascoar@gmail.com>
Subject: [PATCH v2 2/4] staging: gpib: fix kernel-doc section for function usb_gpib_interface_clear()
Date: Wed,  5 Mar 2025 16:32:18 -0300
Message-ID: <20250305193614.39604-5-gascoar@gmail.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250305193614.39604-1-gascoar@gmail.com>
References: <20250305193614.39604-1-gascoar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add '@' character in kernel-doc comment in order 'assert' to be picked as
argument by the kernel-doc compiler.

This change fix the following warning:

warning: Function parameter or struct member 'assert' not described in
'usb_gpib_interface_clear'

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
v1 -> v2: no changes in this patch.

 drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
index eeabbdb39057..090857824d07 100644
--- a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
+++ b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
@@ -621,7 +621,7 @@ static int usb_gpib_go_to_standby(gpib_board_t *board)
  * usb_gpib_interface_clear() - Assert or de-assert IFC
  *
  * @board:    the gpib_board data area for this gpib interface
- * assert:    1: assert IFC;  0: de-assert IFC
+ * @assert:   1: assert IFC;  0: de-assert IFC
  *
  *    Currently on the assert request we issue the lpvo IBZ
  *    command that cycles IFC low for 100 usec, then we ignore
-- 
2.49.0.rc0


