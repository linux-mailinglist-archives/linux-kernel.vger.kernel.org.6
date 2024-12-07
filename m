Return-Path: <linux-kernel+bounces-436009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDD59E7FD1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 13:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649B31884551
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 12:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EF1145B26;
	Sat,  7 Dec 2024 12:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iinet.net.au header.i=@iinet.net.au header.b="oh2EeuDt"
Received: from omr011.pc5.atmailcloud.com (omr011.pc5.atmailcloud.com [103.150.252.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1D510E0;
	Sat,  7 Dec 2024 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.150.252.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733574205; cv=none; b=bJ4z34LClvCcR5y0rNOoCiW7YCQWYxEEPzwlokrSUho6FhgukBnwcHeYoO2GIld/FlDaWyWTPh5F056NrD4LZq2UvWlbcIz5xXr0UA2jZMqOn0s9pnf1fwIGXXXDaeJpGvxWfVXFOGZz3AOEtVw0X+wuhUU7BQ8aR22JSSKZd8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733574205; c=relaxed/simple;
	bh=9XuAjMOa4DQbaba+Yjt5Ge9W5m0QcoJ1cRWOdV6Nwy4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JzGij1tAvC6NWZp2b7fy0cPghNthUVpN1THsynBqiaxHeh4y6isfH6e8GC0PZGMmHswvkvqW9zF4pfco0gOn8MgtdkX2T9KXS3fFHgjbhJtNUreeZOMdOgSMHFQGiq18smHiD4pnjx6+Fji7UFSKgMUqetMBiDbuTKBCLUNqyKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iinet.net.au; spf=pass smtp.mailfrom=iinet.net.au; dkim=pass (2048-bit key) header.d=iinet.net.au header.i=@iinet.net.au header.b=oh2EeuDt; arc=none smtp.client-ip=103.150.252.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iinet.net.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iinet.net.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iinet.net.au; s=202309; h=MIME-Version:Message-Id:Date:Subject:To:From:
	content-type; bh=ktDARhdLniN1l9piKvBpErS2QEpaNg0umPELwf6t5ro=; b=oh2EeuDtyED0
	d2XZjG1W8HcuyH7suh6CqP7vq1VtU/dt19k7qdFOAjutatLdgXKDrxZobd71hj7tr6hq9unpU4HA9
	cwb3aP9NhhNWxlbKNN/5qAe9+N8f7lwRP5TaK7N601iTFkdF7ZdxVcBXzSHlE0FVfun4BQauL70I5
	AiiCmVnVRgjagTMBOjY+3izLRCtkZPWSXXQn06nqeqdlpm/R4u0AryK/+X4zq1rAleKza30NgBaom
	dQcqbXYOpanH/l1gfZQhuujEiA5j/gjsewmZYa0USYc3WcNv/7GS1jPilBldz7MN+T/PymYoc57wO
	FfKfBxRHEnZNoC9VeDPAEg==;
Received: from cmr-kakadu03.internal.pc5.atmailcloud.com (cmr-kakadu03.internal.pc5.atmailcloud.com [192.168.1.5]) 
	by omr.internal.pc5.atmailcloud.com (Exim/cmr-kakadu03.i-01aafa3d57eedb868) with ESMTPS
	(envelope-from <gordoste@iinet.net.au>)
	id 1tJtq4-000000005oC-47Lz ;
	Sat, 07 Dec 2024 12:23:12 +0000
Received: from [220.233.184.101] (helo=localhost)
	 by CMR-KAKADU03.i-01aafa3d57eedb868 with esmtpsa
	(envelope-from <gordoste@iinet.net.au>)
	id 1tJtq4-000000003wf-1K83;
	Sat, 07 Dec 2024 12:23:12 +0000
From: Stephen Gordon <gordoste@iinet.net.au>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Stephen Gordon <gordoste@iinet.net.au>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: audio-graph-card: Call of_node_put() on correct node
Date: Sat,  7 Dec 2024 23:22:56 +1100
Message-Id: <20241207122257.165096-1-gordoste@iinet.net.au>
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
X-Cm-Analysis: v=2.4 cv=V9V70/ni c=1 sm=1 tr=0 ts=67543e30 a=HSUqTxjWRdnMbJspRni59w==:117 a=HSUqTxjWRdnMbJspRni59w==:17 a=RZcAm9yDv7YA:10 a=x7bEGLp0ZPQA:10 a=4jraHwQkAAAA:8 a=HVOBkmTHOsy81tmx7DYA:9
X-Cm-Envelope: MS4xfEHN2qmahQ2S5q2GtZ74TTTA8DAr+KCC6e+jfLoxYvrRp/3HNaI5PaXriy1U9MmQqC/S3xlexQM5yFbMumHJoJBOlUTNG4d9mrB24XHQbQxOQMpvZN8R /dYQmJ8kx++KjQ4xWqfim9IKU3GzXoCMrlvKexmdCeeaxsadnBoiU85pDFxvjYLbDpVHkwwSMgzjh1urZkKPzXhqMo+VmJKa9yw=
X-atmailcloud-route: unknown

V2: Adjust commit message

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


