Return-Path: <linux-kernel+bounces-438821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B68449EA6BE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 04:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AE51287B83
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 03:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597E31D86FF;
	Tue, 10 Dec 2024 03:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iinet.net.au header.i=@iinet.net.au header.b="GUeD7QSv"
Received: from omr008.pc5.atmailcloud.com (omr008.pc5.atmailcloud.com [103.150.252.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7582A208A7;
	Tue, 10 Dec 2024 03:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.150.252.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733801875; cv=none; b=OZQJH1V2yvBgh6p2TPByXYM1qdBSYB07L65YNIE0SQWKQ4vbmXYFNABPN0WwP6R3ZKP76WVCHdHgNKgd+pR8p+ePNglWuQ4WfKz0PSMCz9r3am/uLqOItpKxocZcl6WqNGvdkjriDnZB3dZzMxyFJR7iWoBNUl0Z5G+hvPk3rv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733801875; c=relaxed/simple;
	bh=gLhyfabq02Bj70fLYwpnksZiiOtWldwNZW6Um8FhRHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fc2n1m4zNa3htsZlOBWL49UVx+k0rhbvZKBWcstlfkb8/uUbCePcs6k5g+FmDEDek6y1UpdKQVwqwBeOmpsRVP/30LRX8Tg78KImvWeg4+F6cQiWhuTJvEMwIR5vbDLjym/KYvOa8w9o8+yPAHw2iQKEcqCk/kkZWZ9GkiWeMxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iinet.net.au; spf=pass smtp.mailfrom=iinet.net.au; dkim=pass (2048-bit key) header.d=iinet.net.au header.i=@iinet.net.au header.b=GUeD7QSv; arc=none smtp.client-ip=103.150.252.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iinet.net.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iinet.net.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iinet.net.au; s=202309; h=MIME-Version:Message-Id:Date:Subject:To:From:
	content-type; bh=wJ9zGkLh3ckpggy5IHKgRCyU3rRLzOy5VXQyXUJYMIw=; b=GUeD7QSvrF8S
	G7GKNq6SEqbtaW48rdDbPyYmVvFXtFSUfF8xX3I3t2GTjwqmQCyPXZp0YukEJVFuPMUN/OiuMCYBe
	hvOrzJmnwU4bxoAm9CjfQ6v4LYsLRFlRdf3PmibGDCOiAMwxSWgTgOh7NnHC0l6gELYcEkM4rdasf
	SdxAoaOhtEaORTfN6u1liSdBHozF4hnEB1VhAfyWU58ZEaXuOGqcBGyBur+1R0apu9ntKZ98/ejXQ
	YpdT2QZ29rmZXp6j4eYyu/h4IjGGmhilSj7JptUWR4GqDz20lrzSR/rDHgkCOqP7MBBhtOys1O363
	Hc37fphm4QbpK2N9T80ukA==;
Received: from cmr-kakadu03.internal.pc5.atmailcloud.com (cmr-kakadu03.internal.pc5.atmailcloud.com [192.168.1.5]) 
	by omr.internal.pc5.atmailcloud.com (Exim/cmr-kakadu03.i-02e9f6dfe86874a57) with ESMTPS
	(envelope-from <gordoste@iinet.net.au>)
	id 1tKr4B-000000004sH-1lUc ;
	Tue, 10 Dec 2024 03:37:43 +0000
Received: from [220.233.184.101] (helo=localhost)
	 by CMR-KAKADU03.i-02e9f6dfe86874a57 with esmtpsa
	(envelope-from <gordoste@iinet.net.au>)
	id 1tKr4A-000000000qa-3gfD;
	Tue, 10 Dec 2024 03:37:43 +0000
From: Stephen Gordon <gordoste@iinet.net.au>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Stephen Gordon <gordoste@iinet.net.au>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] ASoC: audio-graph-card: Call of_node_put() on correct node
Date: Tue, 10 Dec 2024 14:36:47 +1100
Message-Id: <20241210033648.4872-1-gordoste@iinet.net.au>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Atmail-Id: gordoste@iinet.net.au
X-atmailcloud-spam-action: no action
X-Cm-Analysis: v=2.4 cv=U5iUD/ru c=1 sm=1 tr=0 ts=6757b786 a=HSUqTxjWRdnMbJspRni59w==:117 a=HSUqTxjWRdnMbJspRni59w==:17 a=RZcAm9yDv7YA:10 a=x7bEGLp0ZPQA:10 a=4jraHwQkAAAA:8 a=HVOBkmTHOsy81tmx7DYA:9
X-Cm-Envelope: MS4xfDTc6Mzrxq9qSBfwyLiXDk7uwpLI7MwRsUJPzvIBQU9MDuDiaLD5TMIxe2fGjmdGvISLCIsD0zSxN1iKKoDHCv1m4px9xL9eEX2jfIqYvF1d33grqAGE x4YiUISSXuE5MvA1NMe6xaPO3HUFq552rhiFpfjjhlSE5ffx1UuqEllMB25ruLuyjirVzYXJADCZq84e+s88hWQbETFWCQTtM20=
X-atmailcloud-route: unknown

A small obvious fix.

Signed-off-by: Stephen Gordon <gordoste@iinet.net.au>
---

V3: Fix git log message
V2: Fix patch title

 sound/soc/generic/audio-graph-card2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/audio-graph-card2.c b/sound/soc/generic/audio-graph-card2.c
index 5280c1b20..1f5c4e8ff 100644
--- a/sound/soc/generic/audio-graph-card2.c
+++ b/sound/soc/generic/audio-graph-card2.c
@@ -771,7 +771,7 @@ static void graph_link_init(struct simple_util_priv *priv,
 	of_node_get(port_codec);
 	if (graph_lnk_is_multi(port_codec)) {
 		ep_codec = graph_get_next_multi_ep(&port_codec);
-		of_node_put(port_cpu);
+		of_node_put(port_codec);
 		port_codec = ep_to_port(ep_codec);
 	} else {
 		ep_codec = of_graph_get_next_port_endpoint(port_codec, NULL);
-- 
2.39.5


