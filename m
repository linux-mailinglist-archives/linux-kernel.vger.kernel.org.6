Return-Path: <linux-kernel+bounces-549667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B988CA5553D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E6A3ACE38
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A28E26FD8C;
	Thu,  6 Mar 2025 18:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b="b7DXUpxd"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564EB26BD85
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 18:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741286541; cv=none; b=HelmzRaDJa4jyuC6f12hWCqIlJ6yf4zy3ueLrTaZ+aMYjyI8+xUpahyO7CXXE2pPYoy2LYB7FfSzIiwx15A91YC+AZg/4bW9OnFRy3nTs044nyEj0DYmUT62LwJ/d1ovGEyGwdyA3yNXceAX65mlLiH9z7ByjFI5urY2jcz7HFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741286541; c=relaxed/simple;
	bh=ffkKklzS+mSa+8hF6E9RwA6ptmWZgFmKAk0mKl2rZWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKIlCA/aDDs4CDyLUpqxgudqmqKyNNRu1nrOQ2hX/0WH2Da/qoXqbSyl5ghyy8sXn1m5pBlas3jueZATIvI2ZhLhft2zKma8tUCKkSZx6BnIZV1ZVarRv1Grs8M8udL5Qc385cnrf6SI3IikY4NiUwQ5DTdIg0M5KOQHaN1EJOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu; spf=none smtp.mailfrom=kragniz.eu; dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b=b7DXUpxd; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kragniz.eu
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43bd5644de8so12269075e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 10:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kragniz.eu; s=google; t=1741286536; x=1741891336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fspkIM0MFhhj+8j/ws7LV3/Ik6vwUd9t9FxZaCSPwBE=;
        b=b7DXUpxd/nLqVBJqeEdHo+SpWWN13Fsz3Rw8oPfMZS74BFHK6psIJnHeUU9rUCeaw3
         kxgOaRAu0V7Ccwnp9m5YYTofccdItq+jAUsmS8ntMAm8KPd8zmOpwOfOH/s4/gQHQOVz
         vltwHUyh3324Sxzi2CWN4ylbmHBvdO7GxkwhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741286536; x=1741891336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fspkIM0MFhhj+8j/ws7LV3/Ik6vwUd9t9FxZaCSPwBE=;
        b=NwYB+epCw2buHJzmrb0ZtEDOT6q1DH3vVZmmZ5HNhN9W+QxKDAdreXVHMLmyFNxJZU
         h7EITnXAKrblP4LGmNsIlOPrFqYMHprZeYBkMod/uxFaD/OgobsMtz7IED3St6NsqYvf
         nCnP//S4aiGC1kaQdAr8dFCb3WrotkCebEAXOkuU32kl81eUzCkQrjl/SahL8Xd2CviC
         QAl1NH4vaypYtxMS+/2dQXidd66AK4Xtylz3+SXix6XI0CHt38TFd1ZN79q6f46K3NXW
         PKef5Z81KBs8bayAt5UP7k7dtcw6wYTqqPTK2rpY3o84ETFYuXPkrR2h+7vjhOVhWHs5
         6CCA==
X-Forwarded-Encrypted: i=1; AJvYcCUF34+Zzz3IS4HmijyrbkBZsWYUeQekKcBOn2ZvwPs+WANJnmhV85xtz/vjcThYXJqFVBw3S7y6vg4pQKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhQkhHmHbw58qq1vHUAZFFHkQ0Ryq23ssGrYzBttQR49xKVu7C
	VkMtf0eC1T7SUeOv55iAVKq3al2YhyRfm+oGaY4BHD9skiArO2gMHiJQTr4mltgDxPQ2PUYeCk6
	iHAN20A==
X-Gm-Gg: ASbGnctGuOjS0/i2DnTu8ITfneXJfgW/po6tYQfvwFPXZT6FakGH+KGmtFn+lbWPFNG
	KEHMAHX1cTYK5Qg7HpXVPFuC+af4M/zDr2WtY1QBzdJUvzRRYIyJ7QAk/dg+z3FriVa9yFuIGSd
	hjdNiTQ5JX2CqCtrz2HYdBJQbbKsowDOX1P1rmoVH54wBkUz2BHb9JVlr272XsJfUaQovTnwMXX
	pOMH2B9jYTUyOAkh4Sie2tzRzbGpgiNMQQYNdo1wZ99QbOB0115oz0lUSmLOSndMiiFCx1/Du1a
	IHGxiMk68cdrrTVxYOrCJOHen9R3PSV1nmybGJeEaPoaSpg/3coOHPaL8wLZ5k59G+hsfoAFieK
	H/feJ4g==
X-Google-Smtp-Source: AGHT+IHYWhm6CLJEOoTdTAhEcrcxD0egOdz7+YQF/vM3ilRKL5hchpwKNaBZjO6SX9IAm4cERiFsxw==
X-Received: by 2002:a05:600c:4e91:b0:43b:d116:6483 with SMTP id 5b1f17b1804b1-43c6021f13cmr5658405e9.27.1741286536542;
        Thu, 06 Mar 2025 10:42:16 -0800 (PST)
Received: from localhost.localdomain (161.26.169.217.in-addr.arpa. [217.169.26.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd42c55e6sm57052725e9.23.2025.03.06.10.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 10:42:16 -0800 (PST)
From: Louis Taylor <louis@kragniz.eu>
To: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Louis Taylor <louis@kragniz.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] tools/nolibc: drop outdated example from overview comment
Date: Thu,  6 Mar 2025 18:41:21 +0000
Message-ID: <20250306184147.208723-4-louis@kragniz.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250306184147.208723-1-louis@kragniz.eu>
References: <20250306184147.208723-1-louis@kragniz.eu>
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


