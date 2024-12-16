Return-Path: <linux-kernel+bounces-446851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 874499F2A1C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 07:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A4EE18855F9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 06:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F831CCB26;
	Mon, 16 Dec 2024 06:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="YTtVwuZf"
Received: from cvsmtppost22.nm.naver.com (cvsmtppost22.nm.naver.com [114.111.35.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2331CB51F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 06:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734330404; cv=none; b=tuI2WU1NcwfL4Oqq+KcfrwGgjjmqQPTnuNH2lnaHr1y7Cb4sLNpFKOC4hAcVC5lOMzz9gToviRgllZydcOlw3J1oNRRMIZrWNRny013GkaW53i5bwCwP72R6wbm53seQz/seivsj04bndonfxsv3akIkjFUJsiqcZmqxV/vurR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734330404; c=relaxed/simple;
	bh=ayZS94VE5tZVTwJ9DpvjUG9tb4ws5zhFpr6/AsctdA0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QBBkZLGV5rmfzeDye7f8GcX242jmoNz+hBdYw8lJ8PY7g4h/csGUbh69MCJUy64Mpq7EXdylmtjlH4pENd1TgawQO8EQUDuLWBBwSEtMCHfbG8GJ0zHcTbCGqXuYx0gtF0PoG9ReTPLFo8cA+5jKvA2dLTNCq7xsvDisA6UE594=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=YTtVwuZf; arc=none smtp.client-ip=114.111.35.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Received: from cvsendbo011.nm ([10.112.22.32])
  by cvsmtppost22.nm.naver.com with ESMTP id sMztwuP7SaaQ9LUQ40ZBPw
  for <linux-kernel@vger.kernel.org>;
  Mon, 16 Dec 2024 06:16:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1734329793; bh=ayZS94VE5tZVTwJ9DpvjUG9tb4ws5zhFpr6/AsctdA0=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=YTtVwuZfTzfvUI7EdrIeBuQZSdn3hD0hvhNWwihmv7Zk4pIwvz3SiA6PiTaEWYd08
	 wjn6lh+hwZPJu45uP7zE924KboUrZc7AycGhZVVx/HGn77S7LVZmUvlJ28gGEsR/ed
	 rLirSWnZJWPiemUIdH+XKPBMdWxSnHCAnySq9Gk+21lqpLKgK3Lt6qxgqGYxs65XPs
	 oMXHiIvSQLlCVJrn5C+t8lD3rzPZpCnCfgyJY6RXXLZyxfmr4nil76cQ+Q/SKeKJlb
	 jxGGKEusroad4JWuJLUugHT21M3THbD2kGnvMLeZnSEDP0+SKzUAuWqgZk39llseMR
	 owCR1bWhH6QJg==
X-Session-ID: nez-X4wiQqaQCni22iXOzQ
X-Works-Send-Opt: pYb/jAJYjHmdFxb/FxJYFoKwaBwkx0eFjAJYKg==
X-Works-Smtp-Source: PdblKotqFqJZ+HmZaxKX+6E=
Received: from junoshon.. ([59.10.11.192])
  by cvnsmtp009.nm.naver.com with ESMTP id nez-X4wiQqaQCni22iXOzQ
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Mon, 16 Dec 2024 06:16:32 -0000
From: Junho Shon <sanoldfox@naver.com>
To: edumazet@google.com,
	davem@davemloft.net
Cc: dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	junoshon <sanoldfox@naver.com>
Subject: [PATCH] Staging: rtl8723bs: Remove unnecessary static variable initialization
Date: Mon, 16 Dec 2024 15:16:25 +0900
Message-Id: <20241216061625.2118125-1-sanoldfox@naver.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: junoshon <sanoldfox@naver.com>

Fixed a coding style issue where the static variable '__tcp_tx_delay_enabled'
was explicitly initialized to 0. Static variables are automatically zero-initialized
by the compiler, so the explicit initialization is redundant.

Signed-off-by: Junho Shon <sanoldfox@naver.com>
---
 net/ipv4/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0d704bda6..b67887a69 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3498,7 +3498,7 @@ EXPORT_SYMBOL(tcp_tx_delay_enabled);
 static void tcp_enable_tx_delay(void)
 {
 	if (!static_branch_unlikely(&tcp_tx_delay_enabled)) {
-		static int __tcp_tx_delay_enabled = 0;
+		static int __tcp_tx_delay_enabled;
 
 		if (cmpxchg(&__tcp_tx_delay_enabled, 0, 1) == 0) {
 			static_branch_enable(&tcp_tx_delay_enabled);
-- 
2.34.1


