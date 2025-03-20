Return-Path: <linux-kernel+bounces-569708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AB5A6A667
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 779A6175708
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556F5A944;
	Thu, 20 Mar 2025 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IjVijfH9"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C78229A5
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742474766; cv=none; b=YKGoL6O+MLA+y162V3Ca+9yG2NwaWUVkx/Q6uJHiZg+2/IdhdNDP35sKSaEOLZ9K99XzPMvXp+wOMIHm7L61WBpbVXgbVSrZ9aJT8wX4oQNXc+dwXRAVM02MYsnoJaN+/kZQX2++XeHDavwvXGGYfBz1mORm9UxwX5xZjJr8HNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742474766; c=relaxed/simple;
	bh=gUTj6pkXYtfCR7RG/DA4rREjr3XxfW+t91BATIMfZd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cYSO3tfS2+V25VtvcBG+OZFYJkmOq8sc4Czhcu6n8TvwZLubbDGrxL5C+d1G7AE2unJcjrgJ11hIDblwrf1YXGcU2sruDLtnnEvzzvLYAlNctqGSaz2S8DO+zWJ+g+fovuzfxp7AGKP7/DJLiVcXCNSd6XPnHasyZQzS42ukQc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IjVijfH9; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742474762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0LwHn7dsELp2UKJ8EPQ1BTRVUwHXdy8XbS/H1ImBUVo=;
	b=IjVijfH93XImSaPwMQYpAYbbETLE+xUAicRZ5Lk3RZUdPx3V86O31MdlrztSStsNUT56o4
	2ITFe7XH35YAlEimxDY7s824od2i2z6RIA8UpSttTb2Wreq8dBzC5QRkRsx2yINMNph0zB
	uMY5zXEnf1D5jyDfSLU+wLiDrtSdERE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] xfrm: Remove unnecessary strscpy_pad() size arguments
Date: Thu, 20 Mar 2025 13:44:51 +0100
Message-ID: <20250320124450.32562-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

If the destination buffer has a fixed length, strscpy_pad()
automatically determines its size using sizeof() when the argument is
omitted. This makes the explicit sizeof() calls unnecessary - remove
them.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 net/xfrm/xfrm_user.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 08c6d6f0179f..a4d92ea43e3d 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1161,7 +1161,7 @@ static int copy_to_user_auth(struct xfrm_algo_auth *auth, struct sk_buff *skb)
 	if (!nla)
 		return -EMSGSIZE;
 	algo = nla_data(nla);
-	strscpy_pad(algo->alg_name, auth->alg_name, sizeof(algo->alg_name));
+	strscpy_pad(algo->alg_name, auth->alg_name);
 
 	if (redact_secret && auth->alg_key_len)
 		memset(algo->alg_key, 0, (auth->alg_key_len + 7) / 8);
@@ -1174,7 +1174,7 @@ static int copy_to_user_auth(struct xfrm_algo_auth *auth, struct sk_buff *skb)
 	if (!nla)
 		return -EMSGSIZE;
 	ap = nla_data(nla);
-	strscpy_pad(ap->alg_name, auth->alg_name, sizeof(ap->alg_name));
+	strscpy_pad(ap->alg_name, auth->alg_name);
 	ap->alg_key_len = auth->alg_key_len;
 	ap->alg_trunc_len = auth->alg_trunc_len;
 	if (redact_secret && auth->alg_key_len)
@@ -1195,7 +1195,7 @@ static int copy_to_user_aead(struct xfrm_algo_aead *aead, struct sk_buff *skb)
 		return -EMSGSIZE;
 
 	ap = nla_data(nla);
-	strscpy_pad(ap->alg_name, aead->alg_name, sizeof(ap->alg_name));
+	strscpy_pad(ap->alg_name, aead->alg_name);
 	ap->alg_key_len = aead->alg_key_len;
 	ap->alg_icv_len = aead->alg_icv_len;
 
@@ -1217,7 +1217,7 @@ static int copy_to_user_ealg(struct xfrm_algo *ealg, struct sk_buff *skb)
 		return -EMSGSIZE;
 
 	ap = nla_data(nla);
-	strscpy_pad(ap->alg_name, ealg->alg_name, sizeof(ap->alg_name));
+	strscpy_pad(ap->alg_name, ealg->alg_name);
 	ap->alg_key_len = ealg->alg_key_len;
 
 	if (redact_secret && ealg->alg_key_len)
@@ -1238,7 +1238,7 @@ static int copy_to_user_calg(struct xfrm_algo *calg, struct sk_buff *skb)
 		return -EMSGSIZE;
 
 	ap = nla_data(nla);
-	strscpy_pad(ap->alg_name, calg->alg_name, sizeof(ap->alg_name));
+	strscpy_pad(ap->alg_name, calg->alg_name);
 	ap->alg_key_len = 0;
 
 	return 0;

