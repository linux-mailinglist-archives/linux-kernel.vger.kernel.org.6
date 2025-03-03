Return-Path: <linux-kernel+bounces-542225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 281C8A4C74F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB7DD3A3CC7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AAE22ACF2;
	Mon,  3 Mar 2025 16:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nB7I68ID"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED7B22A4D8;
	Mon,  3 Mar 2025 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019404; cv=none; b=M7AEyhruWLDkKkYqzKW3ltE63Z5b2BFclOpVpdjbaLOs5ERmn4efnZqDtPtnxMLJ/vAm9xoEqVy0+qu9XwGsW03ft842k6ERCg6FQhXIVRtcJlfSXB7dxxyNfYyrqBNy8MBJEdb/GXHcAHrzd8mEdaK1vXb4QgK3dvYwStyqxoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019404; c=relaxed/simple;
	bh=kzBJWSicag1qKjz5770nSTUwj7AkXxzpM6uIrGZGg44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X31sRLoq3IOelwAQqMTmRS213lJOMTpgJ2NeCzg44xx3vuxZMgWI2WXcoponSTtcnpiGKXnNXEph1J95sWTB8uKg+xSh5qjfUg0ox644wPOYqB5KAvyclgrBK+HIooqYefNkFC+7pO6wsnhaOJ1GiY68rRvFPCT846PsoGbIZH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nB7I68ID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29EDC4CED6;
	Mon,  3 Mar 2025 16:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019403;
	bh=kzBJWSicag1qKjz5770nSTUwj7AkXxzpM6uIrGZGg44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nB7I68IDHkeEdvEfQt7xtrr/GSldM48ulGv52HN6brfc4RCaRHaXF29b/HPLpZl2G
	 obvBWXonIZDo4Nkc/7ZFMqu4q+//CU6btqaG0fn0RX66mUtBNrqChBzPJ9SGbWmiUp
	 ixi2lgwjnD9zEnOo5Y0EGA3YlqLyUyXTY7rsZFAPhiIb41jdvepc3vMBGF03qdW0Te
	 mYCaqxDAT5gbmS67Wr/CI3m1NXXEpIkoRlZ7NnBYXsxfxPg+kqdr/6CKTum4ouUh9U
	 cwF9gPA5pV1djnrM0O4u5lbdy7bgEXtdBoNG2eiR3feNbJVJoxDC1KV4J6oR3A3YhQ
	 ZCa9mNztCzVqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 06/17] ASoC: dapm-graph: set fill colour of turned on nodes
Date: Mon,  3 Mar 2025 11:29:38 -0500
Message-Id: <20250303162951.3763346-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303162951.3763346-1-sashal@kernel.org>
References: <20250303162951.3763346-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.5
Content-Transfer-Encoding: 8bit

From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

[ Upstream commit d31babd7e304d3b800d36ff74be6739405b985f2 ]

Some tools like KGraphViewer interpret the "ON" nodes not having an
explicitly set fill colour as them being entirely black, which obscures
the text on them and looks funny. In fact, I thought they were off for
the longest time. Comparing to the output of the `dot` tool, I assume
they are supposed to be white.

Instead of speclawyering over who's in the wrong and must immediately
atone for their wickedness at the altar of RFC2119, just be explicit
about it, set the fillcolor to white, and nobody gets confused.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Link: https://patch.msgid.link/20250221-dapm-graph-node-colour-v1-1-514ed0aa7069@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/sound/dapm-graph | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/sound/dapm-graph b/tools/sound/dapm-graph
index f14bdfedee8f1..b6196ee5065a4 100755
--- a/tools/sound/dapm-graph
+++ b/tools/sound/dapm-graph
@@ -10,7 +10,7 @@ set -eu
 
 STYLE_COMPONENT_ON="color=dodgerblue;style=bold"
 STYLE_COMPONENT_OFF="color=gray40;style=filled;fillcolor=gray90"
-STYLE_NODE_ON="shape=box,style=bold,color=green4"
+STYLE_NODE_ON="shape=box,style=bold,color=green4,fillcolor=white"
 STYLE_NODE_OFF="shape=box,style=filled,color=gray30,fillcolor=gray95"
 
 # Print usage and exit
-- 
2.39.5


