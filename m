Return-Path: <linux-kernel+bounces-552054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3050FA574C8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 872581891A7C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E48D2586E2;
	Fri,  7 Mar 2025 22:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="gOH6zKmH"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347CB25743D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 22:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741385413; cv=none; b=rPYxo22U/QUxsUBDHIPAXzkyTaLqyUhSsbNUHJI6qLV+c7WQ/DRn1A1sSYd5g1aWf/0WNDsTHNvF/mo6AGJY7okfovUGCM2/WVnB0e/31FsCKx32+6iKxo1tKNelhzBbwiiSZ/P9/3gmO3wRFUN67r29t5xYPW/UvHH6oXs5hyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741385413; c=relaxed/simple;
	bh=1YcFRjVYBTCJjQaO7GgxpO9RCwbK7HG0/zdfTAPCRxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=txJtbg9jEd1CVHV+2CWgJnq8FmczfOpA3Rn63Aay+Y9O73KH/69zMQzDFGMzaHomze53R8S195Xdcz2KzVMXvpqB4N2XWKb6zmYUeZ+3UxCckOsURvFLbwgKvzF8q6AJ4iazoyI8Ir8Z4ZIZuEdCY3hDFdWXPp6rLwcHVSRD2sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=gOH6zKmH; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abec8b750ebso394272166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 14:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1741385409; x=1741990209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S7ynko8s6D62stAmktc1cO6KpfN/W8l8FrMauttot5A=;
        b=gOH6zKmH+sOTpT34h+v48HyHIozcAYN/IQiNvn96S9TyJeBgumH1l97ZJTtu6t6vsL
         8uzCHIeaVQN/bapGxhQ2QGoPRYWGFWh3O96rkqmW0NavMc8pHwfzn4V6lQu0XHAeTBnv
         RGThozdQddLH4tLEP5/36iRBjW5byvcdgoBrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741385409; x=1741990209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S7ynko8s6D62stAmktc1cO6KpfN/W8l8FrMauttot5A=;
        b=dWF+sGU4UYVdMMQxjIIYnL6CAHZ4CozQW8gnG2TDrUJeaeFjk2py+Z+SdnpQk51qrz
         8lQ8HZhQIflkQe6N0tw4ohbHG5mr4d70q23OJT2RjMSnoEXAOcaR41UApPnW2WYuhsPE
         sZF0AeW67tQFqfyPhj78ZmwJoAb77hnPi9qa/choPTpvdy2Dij9+KBk2U7hCw+7wtJ/J
         FBytcObwJcoE1dKrCloOA067QBv5MQECC1F8N6WOQive9hn9/vherwdC8fu8+SAiqTcI
         Fd+ZYBIVX+uGIESejZ9zRy7zNzR8KDc0b6hNKy+8TQezVDjnKXO4bJcPw2YuJ2S8hI6W
         b1Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXuCX/o4wHOSE7Txlo8eKy8E7ak6CO/w+XFaqbMGDXq4/YNo78CV1jR7oHZlTqReu7B2gxfV1TWeRmxIsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAG/I9VPda2Rs9Nsk1N46lboLYgvGFmhMIN7gsu+2DlCqlkdm2
	v1zdNDnJHOScNt/j+7d4J2qf/NsAMReUY5QNmPCh9MXdGkFmoffzyEnDlqW5a7M=
X-Gm-Gg: ASbGncuqulZpDDhXF8NFAQg4p0HK7bK7UkxMUlp2XW9GeEBE+jLm01Cu9jTFAs5QVxd
	cPsx3TwdejIWHGRDmCRkcNK9Aah13zPN+BhM8WiUxHTRVqomzf1qNLftwK1PnryN4yEs9twgUDq
	lJPESbLfS949exkREPrLcUDgEToVycBDL6YAIw0+BkKYyMSdA8yiR9X74Wp9T0BJELlm/rE4nXt
	XV4DkjzfZjYCniSW87q8zh7Jf89ZVeigAOnLBeOiE+YPx2Srr1dsvrgvuWZfwkWwjw1/yhpflCT
	aFLkyfEyQoYd0Nfe3AhlsgSjLbFQlZM8pcgYJplnati3U2/K6pShgCJ2j59yX9rEbmMo07xDQXV
	c97Q=
X-Google-Smtp-Source: AGHT+IHaBgRGVEzcLOnW219VBHPeHC2jyWF3AQiF3GwQQqGFIvaVnBYVqpwKUahyBaeF1r9cOp6lMA==
X-Received: by 2002:a17:907:94ce:b0:ac1:e1e1:1f37 with SMTP id a640c23a62f3a-ac25273af3dmr635514366b.10.1741385409202;
        Fri, 07 Mar 2025 14:10:09 -0800 (PST)
Received: from localhost (77.33.185.121.dhcp.fibianet.dk. [77.33.185.121])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac2399d79f4sm335686766b.176.2025.03.07.14.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 14:10:08 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs/pipe.c: simplify tmp_page handling
Date: Fri,  7 Mar 2025 23:10:04 +0100
Message-ID: <20250307221004.1115255-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Assigning the newly allocated page to pipe->tmp_page, only to
unconditionally clear ->tmp_page a little later, seems somewhat odd.

It made sense prior to commit a194dfe6e6f6 ("pipe: Rearrange sequence
in pipe_write() to preallocate slot"), when a user copy was done
between the allocation and the buf->page = page assignment, and a
failure there would then just leave the pipe's one-element page cache
populated. Now, the same purpose is served by the page being inserted
as a size-0 buffer, and the next write attempting to merge with that
buffer.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 fs/pipe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 4d0799e4e719..097400cce241 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -508,13 +508,14 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 			struct page *page = pipe->tmp_page;
 			int copied;
 
-			if (!page) {
+			if (page) {
+				pipe->tmp_page = NULL;
+			} else {
 				page = alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
 				if (unlikely(!page)) {
 					ret = ret ? : -ENOMEM;
 					break;
 				}
-				pipe->tmp_page = page;
 			}
 
 			/* Allocate a slot in the ring in advance and attach an
@@ -534,7 +535,6 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 				buf->flags = PIPE_BUF_FLAG_PACKET;
 			else
 				buf->flags = PIPE_BUF_FLAG_CAN_MERGE;
-			pipe->tmp_page = NULL;
 
 			copied = copy_page_from_iter(page, 0, PAGE_SIZE, from);
 			if (unlikely(copied < PAGE_SIZE && iov_iter_count(from))) {
-- 
2.48.1


