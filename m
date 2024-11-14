Return-Path: <linux-kernel+bounces-409145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9659C87F6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62958287975
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114351F818E;
	Thu, 14 Nov 2024 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=merzmedtech.de header.i=@merzmedtech.de header.b="pg+4hoHH";
	dkim=pass (1024-bit key) header.d=merzmedtech.de header.i=@merzmedtech.de header.b="ELIXin6W"
Received: from mailout01.agenturserver.de (mailout01.agenturserver.de [185.15.192.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C5D1F77B8;
	Thu, 14 Nov 2024 10:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.15.192.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731581181; cv=none; b=GOwNqBlUd/1VrLDMMU7WfhbOdMsGRN68YSf6SXk6TrIEKEWNGO0dnCsPtsZIpNC3QQD+Kcap+6wwWzUkjKNgFsp4vJzZ4vMGDGJ9SG575ylRi0P4mc7qpuUONbnUNoJNzwrAZOIlqlkpPf0dkXGdm80xRA70v8ueU6WO7xW2iWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731581181; c=relaxed/simple;
	bh=ytTP33QWUvhpFf/61F4EPneExfKnvwV/PgFhtrUMW8Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=o0s2icC8dt5bZEBWjEZyFcataV5ffIS0UkT4BAf8cTEnaxE+QyuTV2jwn/4qEwF7ziK/iJpnVBAx8Mz3TYv7M127rA1UMPnnz7C2psetQWJFn9GKQZm4nck7mUndf9jxhEHXYlU6vh7dWqlhQAQ7HfzhGE8LiP5Loo2MEi5W6y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merzmedtech.de; spf=pass smtp.mailfrom=merzmedtech.de; dkim=pass (2048-bit key) header.d=merzmedtech.de header.i=@merzmedtech.de header.b=pg+4hoHH; dkim=pass (1024-bit key) header.d=merzmedtech.de header.i=@merzmedtech.de header.b=ELIXin6W; arc=none smtp.client-ip=185.15.192.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merzmedtech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=merzmedtech.de
Received: from mail02.agenturserver.de (mail02.internal [192.168.51.35])
	by mailout01.agenturserver.de (Postfix) with ESMTP id 5BBA66CBF;
	Thu, 14 Nov 2024 11:38:58 +0100 (CET)
Received: from XXX.XXX.XXX.XXX (XXXXX.XX [XXX.XXX.XXX.XXX])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: h.v.raven@merzmedtech.de)
	by mail.agenturserver.de (Postfix) with ESMTPSA id AB5B6A11DD;
	Thu, 14 Nov 2024 11:38:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=merzmedtech.de;
	s=agenturserver2048; t=1731580738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gh+s1njB+eHDBkuhm8NNHW0/KkfuruIfemdW9Ilrtq8=;
	b=pg+4hoHH/VpBX7zCPf+YHbcZ0TnDR9q9ygGljgwmqqWqqS1JJEHr2dUBMYBGmAYLlcZW5M
	whN6OVd4+lpL5b4jkg6maKKLZG5puHqhQ1FO3FvqZoIArFel8NvICgazpg2p8eQZ6c7Pe0
	JAYM+9TWmiYIaGibmsDJ6MisLEX57zBea3mNYDFqBx52zMRoppc7T4i/b3oIqO5bTREFZ+
	4i+Ur96FX2/BOZbyQG/dr1I7jeMdvobKb7wSeQB+dIcSXF8rB+1nXLnoGbZg+UihkSamqv
	UegBx6FqtaAx1KT2sSDZ69wponO5FpU79qK0S69nI/JljqpaH1Rva9y1c/I3wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=merzmedtech.de;
	s=agenturserver; t=1731580738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gh+s1njB+eHDBkuhm8NNHW0/KkfuruIfemdW9Ilrtq8=;
	b=ELIXin6Wb0Dq3JtRaPVRVFgoHeNn5RK42OTX+b65+/+woljPvMCcSuft3YUaMKR+RD+iEP
	QzijwnVnM499HXuusnfRxdhn/XmSdc4toYdxrc2BUdT2bIXzR7i3dgaksgZjXD2Errl2TB
	9EyqI7DPfELrYfL6QkQcrouqlP9AODQ=
From: "Hendrik v. Raven" <h.v.raven@merzmedtech.de>
Subject: [PATCH 0/2] ASoc: simple-mux: Allow to specify an idle-state
Date: Thu, 14 Nov 2024 11:38:37 +0100
Message-Id: <20241114-simple-mux-idle-state-v1-0-0b082dd6549b@merzmedtech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC3TNWcC/x2MQQqAMAwEvyI5WzC1B/Ur4kFs1IBVaVSE0r8bv
 M0w7CYQikwCXZEg0sPCx66CZQHTOu4LGfbqYCvrENEZ4XBuZML9alGQa7zIVI331ruWarSg2zP
 SzO//2w85fy5KvG1nAAAA
X-Change-ID: 20241114-simple-mux-idle-state-08dd2d49e312
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Belloni <aleandre.belloni@bootlin.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, "Hendrik v. Raven" <h.v.raven@merzmedtech.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=756;
 i=h.v.raven@merzmedtech.de; h=from:subject:message-id;
 bh=ytTP33QWUvhpFf/61F4EPneExfKnvwV/PgFhtrUMW8Q=;
 b=owEBzQIy/ZANAwAKAQP8mG1lSaY7AcsmYgBnNdNBEIU2bPbRE+WCBqh7/k3XABkEds52xtA1B
 +IO8pfEDC6JApMEAAEKAH0WIQRfy2xFNGjRY609IOcD/JhtZUmmOwUCZzXTQV8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0NUZDQjZDNDUzNDY
 4RDE2M0FEM0QyMEU3MDNGQzk4NkQ2NTQ5QTYzQgAKCRAD/JhtZUmmO579D/9ih61DPqfLM6seiD
 qFilUyuEXKoTnXFXLg2xhxGaDTG6g3aS5GnFWz35pWnQYYoPQ5o9loF99duOvvITLptIO9zM2lC
 sV67/GLFDPmMUZKbJTlTj6ZqDU8EECV3nODiW9zzsIaWhO4n71AYA6mu57L/oeyko0T2eQPTbk5
 QScS1ugGHfva+ghLfH3JiNEUDS9u7KG3DvU/sK/yZXeB04qAw9nxduVWiJmmD5OtJFQWkPJES3W
 QPNtpgGvJ+f+o4KkEH6AQpWpgsXSpgib1VqkothgXmeMnMA87fgJpoRYiDcJcOU2y/zu/c/iY6H
 puCczP7EQSMXAITnrKw4mi/PP475PezyDHDC/snlR2sIKNsKN01GisuHQQeAJhkoFeOBU0wNeOh
 yGpZldFR7jj9RdhYk8oSnMCZzG8m+DYZHmDH1CLoGXxbYQF/8kYAhTeJhE4oPielX4Huds/Fhks
 oR7k3ZrxDV4YxUyWeoH9ptRaRHJVra1Iq70Fpvj1TPlxR4eroE2dTYvWEynRr3wDYOkgV6PPwD7
 HITD+/gf4uhSeBUrs9WSmfrsUn5NfPeb7Hd35JxnUIQfmgd/t3mIcMNKMTXi8KnrQF+o3mRjaSk
 ATkYuySC8S68+mZYEbfNyWGWFknLg1+cHuU5zHYmy7L4hIBpPllV9ZKGU1fF8f07cloA==
X-Developer-Key: i=h.v.raven@merzmedtech.de; a=openpgp;
 fpr=7A67B9A9F57B4F324AB6B8EB045B81F5FB5BA3AE
X-purgate-original-type: clean
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 758
X-purgate-ID: 155922::1731580738-D8CA1432-BE9004F6/0/0

This series adds support for the idle-state property from the mux
framework to the simple-mux audio variant. It allows to specify the state
of the mux when it is not in use.

Signed-off-by: Hendrik v. Raven <h.v.raven@merzmedtech.de>
---
Hendrik v. Raven (2):
      ASoc: simple-mux: add idle-state support
      ASoC: dt-bindings: simple-mux: add idle-state property

 .../bindings/sound/simple-audio-mux.yaml           |  5 +++
 sound/soc/codecs/simple-mux.c                      | 40 +++++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)
---
base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
change-id: 20241114-simple-mux-idle-state-08dd2d49e312

Best regards,
-- 
Hendrik v. Raven <h.v.raven@merzmedtech.de>


