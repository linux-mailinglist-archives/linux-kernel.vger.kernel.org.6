Return-Path: <linux-kernel+bounces-369880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B900F9A23F0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC731C21D65
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFE01DE3BB;
	Thu, 17 Oct 2024 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P/RP9ML6"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A611DDC13
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 13:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172105; cv=none; b=b1+5S6aDETnpDGVzrBMRoaysFh1xhfiThR9yBap3GgDdQGYKHcgpzUyu6MW7nyhm9V+05E9qNGjx9uR1FonaYYBBLmsRnyMuhEwsmEPmOZcK1Q1vMp8In+JSe00WHmGnxM8HYyi7lx/z2qvmjH/I64pq2yfSV1fTZGlgfNmGYk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172105; c=relaxed/simple;
	bh=02NgDY9TEy4fD09Pg7lPlldsZDy4wU5WxOvaCrMw0i8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LArvc+NUeLTdAckhCP3WhrfbrrRcDYFZ3UdpvHw2Au0/JM/x979ZoPOLc/mEETRGZvcLDIyj9eaWchyydIpxfgaBFlDTfNAdrii07gMommevYbUa9Mo6ejzNKgYNpwNn39Db4mlSm9ZFDwXJdTAtxr5QDn9ib6ZWRchSuPyT5mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P/RP9ML6; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729172094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fzC6WdulX+ZW0uSTCasSVaRSB5BnAwOMgygi0bqXHOw=;
	b=P/RP9ML6sYFTlgcI5V9Oe99eQ/8fh7a4Go53vWSR50Jyz6JQXsAG/C+wEOH03yDoWt2Qir
	G5qKtPq9RIX1pSgaGdXGyswc8KafwOQJAhLXMsDbDeiQvOb+D73TJCXtFB8xba9r0K0OTX
	S90aoExzVOeYntHXODrGkO+BwqpTldc=
From: Yajun Deng <yajun.deng@linux.dev>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH net-next] net: use sock_valbool_flag() only in __sock_set_timestamps()
Date: Thu, 17 Oct 2024 21:34:35 +0800
Message-Id: <20241017133435.2552-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

sock_{,re}set_flag() are contained in sock_valbool_flag(),
it would be cleaner to just use sock_valbool_flag().

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 net/core/sock.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index f8c0d4eda888..49337da24701 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -820,14 +820,11 @@ EXPORT_SYMBOL(sock_set_sndtimeo);
 
 static void __sock_set_timestamps(struct sock *sk, bool val, bool new, bool ns)
 {
+	sock_valbool_flag(sk, SOCK_RCVTSTAMP, val);
+	sock_valbool_flag(sk, SOCK_RCVTSTAMPNS, val && ns);
 	if (val)  {
 		sock_valbool_flag(sk, SOCK_TSTAMP_NEW, new);
-		sock_valbool_flag(sk, SOCK_RCVTSTAMPNS, ns);
-		sock_set_flag(sk, SOCK_RCVTSTAMP);
 		sock_enable_timestamp(sk, SOCK_TIMESTAMP);
-	} else {
-		sock_reset_flag(sk, SOCK_RCVTSTAMP);
-		sock_reset_flag(sk, SOCK_RCVTSTAMPNS);
 	}
 }
 
-- 
2.25.1


