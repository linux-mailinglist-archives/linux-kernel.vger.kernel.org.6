Return-Path: <linux-kernel+bounces-543437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D22A4D589
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C7EC7A9D35
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA191FBC91;
	Tue,  4 Mar 2025 07:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b="JvoF26Lp"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1ED1FAC3E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 07:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075173; cv=none; b=miFS4KUlXk8B+ynhFGS9xkVEt2gTvVgRSmhMz7SMSHzPja0MDyJb97HoeE6h8mVXxl/Xpx5YSUVdbKEwLNFV8V1sJ1bflSSQk89tLWdZ25OVaC/z0xURwF+WhY/ibjNlrX/iN/x+u9N8ZXvqfa6I75QO98LTOG7fS7fhRjKe8rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075173; c=relaxed/simple;
	bh=ffkKklzS+mSa+8hF6E9RwA6ptmWZgFmKAk0mKl2rZWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjH/SPDfQ7x0G67AIWvB11jrlUq5KAeYILpSZVv6LQPAg/pBn1h2zc4vtA6QxDdryh6i+kIds4YLTLHHybLjt5WCBACak24lQoRlEwdsQ6KP8fq6JO93+PJDB269vdPHHi+bccQuOBWS6xC4ZngIA6DB5EDe8hO05WnVrNLncZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu; spf=none smtp.mailfrom=kragniz.eu; dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b=JvoF26Lp; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kragniz.eu
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-390e702d481so2327993f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 23:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kragniz.eu; s=google; t=1741075170; x=1741679970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fspkIM0MFhhj+8j/ws7LV3/Ik6vwUd9t9FxZaCSPwBE=;
        b=JvoF26Lp5mZK1/ZdGrKMh9CR7BMoMEHmK1IKmUQFrbDz4NZ5jkf2szTuTRZii4DLT5
         1HX9zPD/yPUP1iysHpL4DrPJnGnWChfdfUzNyQbdtg9fgdKSDYFVhuUdWccqRLiuo8sT
         MEQvYnQZQDBhcXLtmqVzZHM01RzVMW86OE+c0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741075170; x=1741679970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fspkIM0MFhhj+8j/ws7LV3/Ik6vwUd9t9FxZaCSPwBE=;
        b=orQAN+FCN1sKvRzXItrNDdfpy1VSbppE3F2wTC6fHxZLoBom0Jr+WJ8j8g3SLvjt5K
         4jATP63KF1IbuoWwvMswSBY4yLcxIxILx8RSuqvT5sFKCSnHuIcK1Hx58kbrWWEIHRPo
         w9ODVqLLezrEWO8aIb1k8bx3mF7Ihzlt8DJDxW1rL+sbZuYKDzHwmcYBC+I4qSh9G4IW
         gQtFUk4QVIx2tg3S+Q17zq+PCJjULLjSad2Ro/xwIbt2uL44AEYL+ZoymsK1+Uo45VAs
         ZfG8qhbq5vV2Wu/H03rAq2AOdOuvQbkC6yFBHk919fS32l+ZoL67PVwGbl9uORez4gvM
         Z+mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZp65xP6643yAee0NDYahCRrP3o4YgC65B/gw+762CR3kSeAu+xm+kRjXivviddFTp0dsX0cJ7mrSc9Mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNCxnZyb/IxKDMrOOAnvezBwjhtdhF5rQEbdAyBZOs64zgLhHO
	y/mlhQvl+cuZ1jqQMe9R0lAPQpUuuJWNOu6k1VxaniMV/Y7M4pMm21dsCoRvYTRLT+vBwiLzSN6
	acwBPkg==
X-Gm-Gg: ASbGncuSE2IuDdkRfVzGqs43St/pIfGUK38E6V06FtoRSjzGQuFKckwe72XE/Aw/rvV
	o5WzFfchEKy2NU7/qPdEM7n9k5QX96LR0s1u0t3blSF7LUrnXFG+ArerRzE+77e0qiPqDVV1oqA
	zn74DhzOXXkUTZbM10pdufASMFKLvcxdlVKTjL4oUtvrj7AC/O01dZxI/5/28AsIAaB8DCTRXt1
	I6eRscLMni8e2449/W9J+IMUiXxYAkaUGd1asACqjDy7ddoggyZTohc9Aw6xtWoeJXExCI6HRAc
	tL274IXA4kHz9Pvy293jiFQioZBPxQYaXIN/mu+H1YRUN6WKZLWfGlqvOauy36PfZk/cSB1Wtyn
	fwRDeXg==
X-Google-Smtp-Source: AGHT+IHIyb1A7d2Tr2gfLqNxAQ/nvH9JUKa4shI+GoAr/0+9ABwypYaEdX9hoE6bhngi4uHT4IX3lA==
X-Received: by 2002:a5d:584b:0:b0:390:d954:5e7c with SMTP id ffacd0b85a97d-390eca34e23mr16502503f8f.38.1741075169722;
        Mon, 03 Mar 2025 23:59:29 -0800 (PST)
Received: from localhost.localdomain (161.26.169.217.in-addr.arpa. [217.169.26.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4796517sm16618101f8f.5.2025.03.03.23.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 23:59:29 -0800 (PST)
From: Louis Taylor <louis@kragniz.eu>
To: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Louis Taylor <louis@kragniz.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] tools/nolibc: drop outdated example from overview comment
Date: Tue,  4 Mar 2025 07:58:18 +0000
Message-ID: <20250304075846.66563-4-louis@kragniz.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250304075846.66563-1-louis@kragniz.eu>
References: <20250304075846.66563-1-louis@kragniz.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This behaviour was changed in commit a7604ba149e7 ("tools/nolibc/sys:
make open() take a vararg on the 3rd argument").

Signed-off-by: Louis Taylor <louis@kragniz.eu>
---
 tools/include/nolibc/nolibc.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 05d92afedb72..70872401aca8 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -31,8 +31,7 @@
  *   - The third level is the libc call definition. It exposes the lower raw
  *     sys_<name>() calls in a way that looks like what a libc usually does,
  *     takes care of specific input values, and of setting errno upon error.
- *     There can be minor variations compared to standard libc calls. For
- *     example the open() call always takes 3 args here.
+ *     There can be minor variations compared to standard libc calls.
  *
  * The errno variable is declared static and unused. This way it can be
  * optimized away if not used. However this means that a program made of
-- 
2.45.2


