Return-Path: <linux-kernel+bounces-435871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6F49E7E1D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 04:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD35416C65F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 03:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD3A28DD0;
	Sat,  7 Dec 2024 03:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iinet.net.au header.i=@iinet.net.au header.b="injSqMSb"
Received: from omr012.pc5.atmailcloud.com (omr012.pc5.atmailcloud.com [103.150.252.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A475C17C7C;
	Sat,  7 Dec 2024 03:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.150.252.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733542793; cv=none; b=M6uNDESvNf69NjNVYhru4QjlnBqYWOXBImHuxbFsFCyoZTtpyuifAoi+bs5fzHYOtbKEfrz5um1Bm5Ye3JSsAJVX2d+q/1yehhMtX0fIH2tN3MwReYjvdFbt03G4xn5j+wDAwEg0MYV8BxsAe9ggkIN2qsoWWnhzdbQlRQOM+So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733542793; c=relaxed/simple;
	bh=T+A3OvEiIKRd9miAv8Q1Y6ZrLhAo2qahZkhgFwF3iUs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TthI0YroO7FBJT+CNMSxYlNN38jwk4EeCPW9p/+feyzhCdnU8rejCeA+vNWpqDeFPuYufwsqcdms1V6hBdU32zJshkrteuEMAGMZ9QquY24Nt548cHuAcDZHHUp0AyTMneoznG6NO99QPYG5gARPm1vmGkhB3qn9yiDwClaOwcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iinet.net.au; spf=pass smtp.mailfrom=iinet.net.au; dkim=pass (2048-bit key) header.d=iinet.net.au header.i=@iinet.net.au header.b=injSqMSb; arc=none smtp.client-ip=103.150.252.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iinet.net.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iinet.net.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iinet.net.au; s=202309; h=MIME-Version:Message-Id:Date:Subject:To:From:
	content-type; bh=CXN0570aOiwMChVwhQkv6hbbsoUm8XIHFR6HkMe7bo8=; b=injSqMSbHCX7
	7bBHa6Mqt8fb3oHK/w9FBKtoowtq8XIexCyTYD665yW5GGCVHtFXCnzdTKJf+FMxJV5gf17+5R3wH
	0QbKMeBUzsOAPfZAWXSJw+ZNsEA5NuQMlXVaqV0slQPwGZN0wiH+MMtBs2Hd77im2frkSQ+YxKN4M
	Yv2CZ8faNYQ1u/L2JyClTrWDWKdsnzWuieL9mURY6xL/D+6TCwvIp+qWGAGpBfUKgLll3iE1KpdOz
	scH1a48L4Zb373r/9irJxBVDnMATecu2rqwAQ6JRLy/bSOlRFxKm6zZoybbnwQY+JUBSkhWoFLsp2
	9uMuoR/pjHdYWMyqE6wsig==;
Received: from cmr-kakadu03.internal.pc5.atmailcloud.com (cmr-kakadu03.internal.pc5.atmailcloud.com [192.168.1.5]) 
	by omr.internal.pc5.atmailcloud.com (Exim/cmr-kakadu03.i-0b90e6e05a7b179c7) with ESMTPS
	(envelope-from <gordoste@iinet.net.au>)
	id 1tJlfW-000000005qg-1zvf ;
	Sat, 07 Dec 2024 03:39:46 +0000
Received: from [220.233.184.101] (helo=localhost)
	 by CMR-KAKADU03.i-0b90e6e05a7b179c7 with esmtpsa
	(envelope-from <gordoste@iinet.net.au>)
	id 1tJlfV-000000007lO-3dwF;
	Sat, 07 Dec 2024 03:39:46 +0000
From: Stephen Gordon <gordoste@iinet.net.au>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Stephen Gordon <gordoste@iinet.net.au>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Decrement refcount on correct pointer
Date: Sat,  7 Dec 2024 14:39:12 +1100
Message-Id: <20241207033912.68475-1-gordoste@iinet.net.au>
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
X-Cm-Analysis: v=2.4 cv=SanxdORu c=1 sm=1 tr=0 ts=6753c382 a=HSUqTxjWRdnMbJspRni59w==:117 a=HSUqTxjWRdnMbJspRni59w==:17 a=RZcAm9yDv7YA:10 a=x7bEGLp0ZPQA:10 a=4jraHwQkAAAA:8 a=HVOBkmTHOsy81tmx7DYA:9
X-Cm-Envelope: MS4xfEIIihYa21+f0Bi5lsN4bFSkeGOk3CDP/6Wtnru6/W8mnFdFYJ8dP+hepVPwq3QgGdmwm1jXDXkXLUYdG2yDTldZPp53o/PG+K8qaVe7G+8p53ND98T0 5XCZ9LBHbOKEqqozzGwjjTzv5iH+Y9PR/mqDrPCzGfKfPsQ5zVgGz1Jk3QgV5sfGirbhvZxddc1HMJeVsKOlr1Dp7ss4NiISdtA=
X-atmailcloud-route: unknown

Signed-off-by: Stephen Gordon <gordoste@iinet.net.au>
---
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


