Return-Path: <linux-kernel+bounces-400891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2AB9C13B6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 02:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2DF0B21740
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 01:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F4E629;
	Fri,  8 Nov 2024 01:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b="t9G4OocL"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71080DDC3
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 01:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731029854; cv=none; b=jPlVFGUD5ONoMdUnE7+IbdWNJ8mp/QpX+qh/dPoT7dTOvsQLrXkQTKc8nKOWSUNL2sf1ABzcCPBhWhpF9Bx5HI4CnSQn/6vM5WaCpb0puTCrIjG3t3Vnyz3aMVyfqhOgPWSSD8BXACYIgT5F8pnhjTeUf8aJ9RzennPc9HufSgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731029854; c=relaxed/simple;
	bh=601PxONqDN+puHXMRm8j5f3xUm3oomfzrXf4jxdXAMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Y6oEFl7Zb0K7dxB7vt6/NxthLzya5Ffyool8clGzoMue8MPIiGRgfcWfGzeCdWginbQc5nMa7RuqVd2oXJ9dI+W58Ll1AXFBRR63wrvLQM7HNpl6hRMb+e8EUmoLxikQu0svhoV8szJVus8UD9vw0kBoPaQlT7qt5is567kWIMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org; spf=pass smtp.mailfrom=jookia.org; dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b=t9G4OocL; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1731029847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BrH3xbEOBIjpGvNeoZvkYNZBvZ3DHxApnAuafUg9pgY=;
	b=t9G4OocLHYrHbK8R8pVmvUnB0lIY17l9b40eHh7Aoe9EBjQwDxHzAxGk3rQ5AImW7HNmci
	WRk0GgmgAEwAeZa1pWu1ZSxSEkcoDa4zI39GLcsDM4U26orUmHkNRqx0ZrHeV+FqFKlgQe
	izd2ZpJjQiB+BhjUcAba3JIOBAtubBAhtFLavM4cCVg5/wZsn36ToJdRe/hLGGHI/djTo3
	0NWLFSS2pF6Tjz2tzVjtpbPmPJRGU/VgEWKAeUZ+2fb1YUEhccaIEjSGlxPIgCFzK1Jzy4
	7DC3a5/bT3UQD5qsXb2HKkzA/2qmCG1VpOFCtUMToxdv6Bt7qRvMLCXs0ZiPCw==
From: John Watts <contact@jookia.org>
Date: Fri, 08 Nov 2024 12:37:15 +1100
Subject: [PATCH] ASoC: audio-graph-card2: Purge absent supplies for device
 tree nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-graph_dt_fix-v1-1-173e2f9603d6@jookia.org>
X-B4-Tracking: v=1; b=H4sIAEprLWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQwML3fSixIKM+JSS+LTMCt0UwzSDlCQLi0QzSzMloJaColSgMNi46Nj
 aWgCiQu0RXgAAAA==
X-Change-ID: 20241108-graph_dt_fix-d1f0db88a696
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1731029837; l=1594;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=601PxONqDN+puHXMRm8j5f3xUm3oomfzrXf4jxdXAMk=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgPs7MDd2XR
 g2uRE9caV1lPPPeu0VzIG9fPrrVmYyAhLcAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAqalNx/4z2OYiBMfG1sJCLOy
 hWeUIn/WDoReMwOQR1tt2OYkQe4xwwLDaMY+hELHy8F3jHrNcuPKIvT9XE3/IDwUAARjY
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:/gEvgms/9HpbgpcH+K7O4GYXmqkP7siJx9zHeEWRZTg
X-Migadu-Flow: FLOW_OUT

The audio graph card doesn't mark its subnodes such as multi {}, dpcm {}
and c2c {} as not requiring any suppliers. This causes a hang as Linux
waits for these phantom suppliers to show up on boot.
Make it clear these nodes have no suppliers.

Example error message:
[   15.208558] platform 2034000.i2s: deferred probe pending: platform: wait for supplier /sound/multi
[   15.208584] platform sound: deferred probe pending: asoc-audio-graph-card2: parse error

Signed-off-by: John Watts <contact@jookia.org>
---
 sound/soc/generic/audio-graph-card2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/generic/audio-graph-card2.c b/sound/soc/generic/audio-graph-card2.c
index 56f7f946882e831cc4474c86b31f69e15de1549a..68f1da6931af2161dc8815b8c04d10cd614cc182 100644
--- a/sound/soc/generic/audio-graph-card2.c
+++ b/sound/soc/generic/audio-graph-card2.c
@@ -270,16 +270,19 @@ static enum graph_type __graph_get_type(struct device_node *lnk)
 
 	if (of_node_name_eq(np, GRAPH_NODENAME_MULTI)) {
 		ret = GRAPH_MULTI;
+		fw_devlink_purge_absent_suppliers(&np->fwnode);
 		goto out_put;
 	}
 
 	if (of_node_name_eq(np, GRAPH_NODENAME_DPCM)) {
 		ret = GRAPH_DPCM;
+		fw_devlink_purge_absent_suppliers(&np->fwnode);
 		goto out_put;
 	}
 
 	if (of_node_name_eq(np, GRAPH_NODENAME_C2C)) {
 		ret = GRAPH_C2C;
+		fw_devlink_purge_absent_suppliers(&np->fwnode);
 		goto out_put;
 	}
 

---
base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
change-id: 20241108-graph_dt_fix-d1f0db88a696

Best regards,
-- 
John Watts <contact@jookia.org>


