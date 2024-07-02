Return-Path: <linux-kernel+bounces-237213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5701491ED83
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 05:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010C41F22008
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 03:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BED52BB1C;
	Tue,  2 Jul 2024 03:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="q0+707EF"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976AF2AE66
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 03:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719891728; cv=none; b=FehX98dg5H6qg8q+uStqPbCOMKIbPf4j6QmCpDq+yPKtEdSB1FRMpeEZjM1zuZXTYwzd9g3kvVV6w3HzAsj7kdHl4RYIaJIDfyMuVdebWOhisy376dYQZlxJQFiULDnP9FoQTIJMOm0JysMdbwe5T6B2lfQcNxgKnFB0i+ZDuJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719891728; c=relaxed/simple;
	bh=VT+xgDApO93xrdz4374Uv9pxQU4bO2YjGscqme+ykbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vt7HeRr4WyMPz7JU1Ms9MeN+w0/uFslRgfEqcUtEMOizftr15u6xhVTJHgYsYj7MWmTw5J5W6TtuAu/1tePpGATeHldLEbckUAeow5f+/YFCYcUdCwbNmzp3ZZqq+fQ2iF07+fdByjqS02uU9w9pW0wzqqZ5y6Gi01/jkg6tW1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=q0+707EF; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c9229c53b7so2156004a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 20:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1719891726; x=1720496526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qXwS5FNu142LeFbX+kvv8eX9edjrwrcGHefzN76Waeg=;
        b=q0+707EFEYbMTHPkQI/0kCYWHhX022GNprj/qII+uaeZL0u+feurLPueTC9eRJtTgs
         jz8dEks4tOswp2Bp36qqlvd6OIcy6+B6rVGQUZnMOxfTRRTKmMUgY+VIipJcTCTMNtr1
         WYlpbhcd6+CefNqwQkwjkTbz6UgcweYCGBBVBw5TfgKED4Ay1MIa973qZoP3q2wyQi6p
         3mK0Yubm5iwCyZ8iGXTpApb1Ld6MdbhKLquBEkGaRNZKx4u7wvVXp8pQsN5mI3pS6MO+
         76Yf/rm+2vEHVc3lblRdAlUXN8DaSZLBD0es5tpqylGavc/siFHYjYyPam5+rkNylli7
         uDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719891726; x=1720496526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qXwS5FNu142LeFbX+kvv8eX9edjrwrcGHefzN76Waeg=;
        b=GQwMPMIfTytgrfJNH0UhyU6UMCW+juGOHHFL3yhb0I4KuVrqqDwGfhgDYMqS717AlE
         H4Unu6qW9ZpEEFmqnfGk3EhWtH+gO+gMfWMKeamBwCAlTWS8zmid1ef+Wg0GMdmzxhYM
         1RUI8xCPV91jCtOytOGrj45BQ+eosOSe2v3uKf8Xv0eJwkysBP787Eef44tvBewHeeYH
         zJLLo5rkZz3xIZ+DYMwHFFa0kVm5FR87vT59gdtjOWLgMg3C6sF4IzuUR6JpT58Q2U9l
         NqmDrmYcmblp9RYk2XTgCOj5vuREFh3y0PP7dPjrtALcv2j1Mo6Y4HauCW1LHtDIbGez
         wjYg==
X-Forwarded-Encrypted: i=1; AJvYcCW5Sage6VYQBY6pn8Ps/MAs6SUvqf9PRNwumyX69SNvTsRll4yWWE3G9H3ZUpqaShInSBi4CUC81qvp+Y2BZvSKz0fXbYb94+WEAOGr
X-Gm-Message-State: AOJu0YyDE3Wl0Lq2hKUjOLfje//nSHT5Ai3bFbkjr1AI1M6SIZoQhqEO
	sg1XumcH7FbNQXTKXu6og/sqg7ThhVWD6tU11YINgO1XhNvyQ8170ofFcqZnhdSZu5JHiMMrYUk
	W
X-Google-Smtp-Source: AGHT+IGef8Rs5zQSAanq33h/aAXIXAYTVkzd76pQ0aVFTjWRzYWESFvs4EqqePkjtQ8ctjkDKPJzhw==
X-Received: by 2002:a17:90b:3449:b0:2c8:6a9d:5060 with SMTP id 98e67ed59e1d1-2c93d6c654emr4234627a91.7.1719891725870;
        Mon, 01 Jul 2024 20:42:05 -0700 (PDT)
Received: from fedora.vc.shawcable.net (S0106c09435b54ab9.vc.shawcable.net. [24.85.107.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce6ec6asm7683610a91.26.2024.07.01.20.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 20:42:05 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: geert@linux-m68k.org,
	gerg@uclinux.org,
	dhowells@redhat.com
Cc: linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] m68k: cmpxchg: Fix return value for default case in __arch_xchg()
Date: Tue,  2 Jul 2024 05:41:17 +0200
Message-ID: <20240702034116.140234-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return value of __invalid_xchg_size() is assigned to tmp instead of
the return variable x. Assign it to x instead.

Fixes: 803f69144f0d ("Disintegrate asm/system.h for M68K")
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 arch/m68k/include/asm/cmpxchg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/cmpxchg.h b/arch/m68k/include/asm/cmpxchg.h
index d7f3de9c5d6f..4ba14f3535fc 100644
--- a/arch/m68k/include/asm/cmpxchg.h
+++ b/arch/m68k/include/asm/cmpxchg.h
@@ -32,7 +32,7 @@ static inline unsigned long __arch_xchg(unsigned long x, volatile void * ptr, in
 		x = tmp;
 		break;
 	default:
-		tmp = __invalid_xchg_size(x, ptr, size);
+		x = __invalid_xchg_size(x, ptr, size);
 		break;
 	}
 
-- 
2.45.2


