Return-Path: <linux-kernel+bounces-576597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D83DCA71196
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14B7C188EF72
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6395319DF62;
	Wed, 26 Mar 2025 07:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eOjxRJHB"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F20A55
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 07:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742975051; cv=none; b=WjayO2Su4KHDNuwbzB0QFyzgdTokJ3JIfJZodQ4bk6DPUQM1ouaqGzI+PQv9fDmGLLc6vuwuRJ4bs9djQ8O+FX1gwO0kgRqPa/SHFJGLiuFtdVsNp7E5BhbhpylpU3XbY86Wyt7XyZBv1Re1O+CpAim9tQYBoe6WwHvazMMfx6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742975051; c=relaxed/simple;
	bh=/yoi60wu1frvpRXlNIDUf/GRlnb+EATV0oTKPY/DQco=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T4h1mSDUMGGhHgMEMSLsdKfmB2ClEQV0IT0VHKl3lF0qgIGyGzuV6/rJaQCpcNl8JXvmoLIEi9f/ogdUEPW9y6iOSoUEmXJVjp65nRiknl1ksrsZ16JpfuxHny2+YfcvaMIoBZxsYvg/o6skkr8VMD3nESpjYnexaxyhZDlgwXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eOjxRJHB; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=FJJ67
	N9FHAiQs2a7zhLhPnTvU6+WgrcFiIDSKAkPwkU=; b=eOjxRJHByJO3xr39X+Yms
	6XT59RivHBe6TLJfwnyq9NpCPowtJuA6+V3+eRpfJyh5HQZd2+RK60isSCBVClif
	vgPN8SeyoH9N7+rWjz/WNZMhvH0Jpw09rqpSHTm6zjIQneNDACBRajTh0XCbkgNU
	Et8aOaK+BMDbDlKsHa65sA=
Received: from WIN-S4QB3VCT165.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAn52I8sONnWri_Aw--.3696S4;
	Wed, 26 Mar 2025 15:43:59 +0800 (CST)
From: Debin Zhu <mowenroot@163.com>
To: paul@paul-moore.com
Cc: linux-kernel@vger.kernel.org,
	Debin Zhu <mowenroot@163.com>,
	Bitao Ouyang <1985755126@qq.com>
Subject: [PATCH] netlabel: Fix NULL pointer exception caused by CALIPSO on IPv4 sockets
Date: Wed, 26 Mar 2025 15:43:55 +0800
Message-Id: <20250326074355.24016-1-mowenroot@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAn52I8sONnWri_Aw--.3696S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFy3Ar4xCF18Cw4xtry7ZFb_yoW8tF13pF
	9rGwsxZw18AFWxurs3WFWkury3Kr18K3Wxur9Fya1UAryUGry8Kay0kF1SyFWayrZrKF4a
	qrnaq3W5K34DAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_E_NQUUUUU=
X-CM-SenderInfo: pprzv0hurr3qqrwthudrp/1tbiXwAclGfjrDNqggAAsk

Added IPv6 socket checks in `calipso_sock_getattr`, `calipso_sock_setattr`,
and `calipso_sock_delattr` functions.
Return `-EAFNOSUPPORT` error code if the socket is not of the IPv6 type.
This fix prevents the IPv6 datagram code from 
incorrectly calling the IPv4 datagram code,
thereby avoiding a NULL pointer exception.

Signed-off-by: Debin Zhu <mowenroot@163.com>
Signed-off-by: Bitao Ouyang <1985755126@qq.com>
---
 net/ipv6/calipso.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
index dbcea9fee..ef55e4176 100644
--- a/net/ipv6/calipso.c
+++ b/net/ipv6/calipso.c
@@ -1072,8 +1072,13 @@ static int calipso_sock_getattr(struct sock *sk,
 	struct ipv6_opt_hdr *hop;
 	int opt_len, len, ret_val = -ENOMSG, offset;
 	unsigned char *opt;
-	struct ipv6_txoptions *txopts = txopt_get(inet6_sk(sk));
-
+	struct ipv6_pinfo *pinfo = inet6_sk(sk);
+	struct ipv6_txoptions *txopts;
+	/* Prevent IPv6 datagram code from calling IPv4 datagram code, causing pinet6 to be NULL  */
+	if (!pinfo)
+		return -EAFNOSUPPORT;
+
+	txopts = txopt_get(pinfo);
 	if (!txopts || !txopts->hopopt)
 		goto done;

@@ -1125,8 +1130,13 @@ static int calipso_sock_setattr(struct sock *sk,
 {
 	int ret_val;
 	struct ipv6_opt_hdr *old, *new;
-	struct ipv6_txoptions *txopts = txopt_get(inet6_sk(sk));
-
+	struct ipv6_pinfo *pinfo = inet6_sk(sk);
+	struct ipv6_txoptions *txopts;
+	/* Prevent IPv6 datagram code from calling IPv4 datagram code, causing pinet6 to be NULL  */
+	if (!pinfo)
+		return -EAFNOSUPPORT;
+
+	txopts = txopt_get(pinfo);
 	old = NULL;
 	if (txopts)
 		old = txopts->hopopt;
@@ -1153,8 +1163,13 @@ static int calipso_sock_setattr(struct sock *sk,
 static void calipso_sock_delattr(struct sock *sk)
 {
 	struct ipv6_opt_hdr *new_hop;
-	struct ipv6_txoptions *txopts = txopt_get(inet6_sk(sk));
-
+	struct ipv6_pinfo *pinfo = inet6_sk(sk);
+	struct ipv6_txoptions *txopts;
+	/* Prevent IPv6 datagram code from calling IPv4 datagram code, causing pinet6 to be NULL  */
+	if (!pinfo)
+		return -EAFNOSUPPORT;
+
+	txopts = txopt_get(pinfo);
 	if (!txopts || !txopts->hopopt)
 		goto done;

--
2.34.1


