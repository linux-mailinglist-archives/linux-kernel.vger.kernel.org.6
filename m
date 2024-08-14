Return-Path: <linux-kernel+bounces-285555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F51F950F8E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEF00281C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41151A76D6;
	Tue, 13 Aug 2024 22:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCobg8HD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072F016BE34;
	Tue, 13 Aug 2024 22:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723587335; cv=none; b=OX/9yCJkiLZ28GcJInwXQtSWoSu9dOukhgjzeBpN9XL5lruEqnI6ui1OZFmf1eCDSVk+2vO3Vt/WsZGpocRsPiCCauMzWp6Z1hbKNJi2e45tI/j48r80PTykolNsWyGfshQM1TXK4SmlLdiK190VBAPKyCm+dCODO7kzvGgCpco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723587335; c=relaxed/simple;
	bh=FYHaFzOiFxZuIxjj47094gz6uizuqz/cvG1pwVG5PDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DS8OnctJ3w5c9TQeNB6WAYw5/SFU2FknVEhf6spvVitXgCvoL+y8NbUsLIMga6PxtUbQT+KidvE+73o3JYPFK7r0g+lJB7NccYRL3T2KXAR9PgU3GE7jQyoBW5kzVsHSOAJ58fzTNvH81ngCzRJ5RZUecBvKs6swUfE4u8yt5lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCobg8HD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCE6C32782;
	Tue, 13 Aug 2024 22:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723587334;
	bh=FYHaFzOiFxZuIxjj47094gz6uizuqz/cvG1pwVG5PDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tCobg8HDDH9fxzTE7orSj2xZj4bM0/pXAD4Dmq1SlOIPNP/O9uen29q4aEE0RzWxR
	 5gNKBZcJJnYcMDLiIg8v/xzWuDsqhMoXctXildp4v/E9AyHzIH8PpK+bSvdaRgGjuZ
	 fSHS5Y8WIUWk54JyyI4IdFOIpTu8HVeH+9XZlM87m8FCcPh8vO6pVwDfuXZHfgtdlP
	 fRJWg2vKM2iri9BfsFD0ie+UVhd9iiiUkPCIQLBx8z/H+LMsHOxfkbheyAHnQBuHIL
	 tirMbZyTkdkH6QoAF/du62DLJVRXAqKLY/7VeMgF6LFktnKcfqjdqZBXlnWwt+B2yl
	 yzASHUtFuQAMQ==
Date: Tue, 13 Aug 2024 16:15:31 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH 2/2][next] cxgb4: Avoid -Wflex-array-member-not-at-end warning
Message-ID: <97388e8a7990975aa56cf0ada211764c735c3432.1723586870.git.gustavoars@kernel.org>
References: <cover.1723586870.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723586870.git.gustavoars@kernel.org>

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Change the type of the middle struct member currently causing
trouble from `struct tc_u32_sel` to `struct tc_u32_sel_hdr`.

Fix the following warning:

drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h:245:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h
index 9050568a034c..64663112cad8 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h
@@ -242,7 +242,7 @@ struct cxgb4_next_header {
 	 * field's value to jump to next header such as IHL field
 	 * in IPv4 header.
 	 */
-	struct tc_u32_sel sel;
+	struct tc_u32_sel_hdr sel;
 	struct tc_u32_key key;
 	/* location of jump to make */
 	const struct cxgb4_match_field *jump;
-- 
2.34.1


