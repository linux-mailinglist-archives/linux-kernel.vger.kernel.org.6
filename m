Return-Path: <linux-kernel+bounces-355568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 426DF995421
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3E21B28E33
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3051E0492;
	Tue,  8 Oct 2024 16:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8DhuU86"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19871E0DC0;
	Tue,  8 Oct 2024 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728403866; cv=none; b=GxsyelejUf9Kp2GHGBU7ybdxSiP3CWDWPZ+j7xu+I4ckzy4CK84G7+of5LTPwxx9h9B90A3DnjhIyVtlhmiyl3VLgZ+1FUCzxc5A1nMjn9MG+JVm8etna0XhvTgQjs+oTV5OC3VnLNDows7Isq97fL0duqieFeFSKgOuQNZ3gtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728403866; c=relaxed/simple;
	bh=Xt8DuBNs96hhkBdp5GHqDAZDvXSQaTX8uPGcgmnnau0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rMRPQitlY9QoVYGBUb7yUiT9VTQ6LnLwzrzx1u5XGfuzwUmJnzBcicsiz7D8dvFrQ6bTi4py0EAq0F2n4UIE8CTVD9rJU/M1XYxbDSLJq/1IaPig965fiWbnsqJJ9YwPsdm8XzQBNdO9GlhRPPxaUQK1g4ku5sJkjYYwh90xPTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8DhuU86; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e02ceccd0so150515b3a.0;
        Tue, 08 Oct 2024 09:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728403864; x=1729008664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iGZ+kv3d5HgP90R79168sJs+XrZZiuRd/+Vmov8YRGE=;
        b=F8DhuU86PPwVGZj6EMiNp4eQ0f29YMNDXkfeCPjA+DB70Ow006WCrlNFL3umy697+r
         L8eUiLl2f3y+TO6IqFdl0AqUuPIR8MGT4070aAFu/Y9voAoUVIiDgq4vEhlrLyZ4Y20W
         GKMG+BUPkBpyjXPNhmx1jTvEiX2E3H5N2aMiaIAVw0Nd59Zz9VJUm84PPZ8IlMMKXeEG
         X0gWPd++/i5BY/lghHtEPs275oaAHlkdGTh7uWyQS6xnDlDutgRVfgeGtet9PAbtujja
         AkKQrkH2apVA1/KasK8WwSMlPiDK1DC/XAMpAy6shFZbCs+LnB8dDlh5vjQ0hquMlGQA
         QAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728403864; x=1729008664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iGZ+kv3d5HgP90R79168sJs+XrZZiuRd/+Vmov8YRGE=;
        b=AXwyuf5LlDFHOWLcTs1yffRmgsxfE+Jy5ektTHqA9a0dwmcomwgard+JeXiwL7ITs/
         X8cEpafiNWSz3JlJSt1LWOcJ1vUdASrV8P46y9ZtqMLyxpEJXmzYQBdaHK+aU/w3owwa
         bhs0dEy212Mi426iI9DoQeul52xpvP647SwOKsxtUoggwvVrA85KmvhaUT68SBOjItJm
         8y6FTgk8jeUqUPD7KCvldFmYB4YqegRnDAirzA802zdqTvxm+72zr1qzzWmLmOksvelr
         aFf4skzLK0SfJFOui2tKbpf/3p146YAQ4YibxlXrc6ONr0Ty9WcZd1hxV4G/NaGaBdhU
         SQ2A==
X-Forwarded-Encrypted: i=1; AJvYcCVcvUdRTzzqrJhz17J7nmWem0/hAFONWm/kAjxx7N/eRJZDu2f+DIamdRVSgWnJBnjo+4YjNIalQGRz65nV@vger.kernel.org, AJvYcCVqxwppwZdW5z8IUOaTZREmVB+6N+BlnrQUfRb2ZvihEuqdnw+lDCS/VehDgfhFBhBlRqN6+ukR6qg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7zZ82QbCtKFxeYm723zA4ugqFfwrENYhPfSFzvkjSLHD+UMbx
	3JuzKPQ3MbSiGjPWoc9+oKMt5gZs+fPxqfsJQ0oDrt5UOeFBD7B5
X-Google-Smtp-Source: AGHT+IHEdM7bz4eMiX53qyAX20iBR36HtnMSFA1wa31oy8jvPhmBA/HTYt/zOi4BqYDW3ZmTeqaDwA==
X-Received: by 2002:a05:6a00:10cb:b0:71c:5e1b:6871 with SMTP id d2e1a72fcca58-71de245db37mr10144027b3a.6.1728403863967;
        Tue, 08 Oct 2024 09:11:03 -0700 (PDT)
Received: from aizome.localdomain ([117.172.223.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbd78fsm6295261b3a.4.2024.10.08.09.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 09:11:03 -0700 (PDT)
From: Pengyu Zhang <zpenya1314@gmail.com>
To: corbet@lwn.net
Cc: rppt@kernel.org,
	linus.walleij@linaro.org,
	fmdefrancesco@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengyu Zhang <zpenya1314@gmail.com>
Subject: [PATCH v1] Docs/mm: Fix a mistakes for pfn in page_tables.rst
Date: Wed,  9 Oct 2024 00:10:50 +0800
Message-Id: <20241008161050.14732-1-zpenya1314@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation incorrectly calculate the pfn value as 0x3fffff,
which should be 0x3ffff instead.It is obtained by right-shifting
0xffffc000 by 14 bits.

This patch corrects the value to prevent any potential confusion
for developers referencing this document.

Signed-off-by: Pengyu Zhang <zpenya1314@gmail.com>
---
 Documentation/mm/page_tables.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/page_tables.rst b/Documentation/mm/page_tables.rst
index be47b192a596..e7c69cc32493 100644
--- a/Documentation/mm/page_tables.rst
+++ b/Documentation/mm/page_tables.rst
@@ -29,7 +29,7 @@ address.
 With a page granularity of 4KB and a address range of 32 bits, pfn 0 is at
 address 0x00000000, pfn 1 is at address 0x00001000, pfn 2 is at 0x00002000
 and so on until we reach pfn 0xfffff at 0xfffff000. With 16KB pages pfs are
-at 0x00004000, 0x00008000 ... 0xffffc000 and pfn goes from 0 to 0x3fffff.
+at 0x00004000, 0x00008000 ... 0xffffc000 and pfn goes from 0 to 0x3ffff.
 
 As you can see, with 4KB pages the page base address uses bits 12-31 of the
 address, and this is why `PAGE_SHIFT` in this case is defined as 12 and
-- 
2.25.1


