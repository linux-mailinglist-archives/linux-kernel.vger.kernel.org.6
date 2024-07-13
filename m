Return-Path: <linux-kernel+bounces-251521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A93A9305CB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 15:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5C901C20B1B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 13:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7EA13957E;
	Sat, 13 Jul 2024 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="oVKD2X0m"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511B71E86E;
	Sat, 13 Jul 2024 13:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720878652; cv=none; b=BLUd2cWUByp++MlmRMR3DrkFp2YrXI/W0bj0Bk/us/yDa0igQmSv0WFOkTrRcU+3lzj1hkScZ0r8D9jZaQ532gNuIdSpBBl+BCUQLxweiEq6eR0ydmYVX/GgegcjkD+QBL8zzQq7TsliJ4rij842xjfxoOlgAYcZGL1Hx59abuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720878652; c=relaxed/simple;
	bh=glbXfZ57zeOAVeFcp148EjAAduVLDX1Nm1Qm/7z/xoA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=T21pnGqQ1LgwAXHa60C06jMSVzXyXIOUbXcmL5kgyUK8bqovNlDJUS/AoOk1AIFpTu28CplHpwXHzNkeSEtYPz6Qd0mBDXTkL7llZFQsqr3OIlthRCuAKdEtrVZCclT4hKEfZBYgRrY8qLDKfvsvv7v0AoCSrz62VGfkjY0ykZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=oVKD2X0m; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720878625; x=1721483425; i=markus.elfring@web.de;
	bh=2DkVKMeSZLdTkmkibS3yN5duPZ98hT8azZgpJe/6Ne4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oVKD2X0mTNKOGyW+A2lRub+vSt8nRJ3u1RmIjcfHbrj80xzT/GIjmfEVRRePuCkW
	 DcbyNcsFnipJ466fmsWjrJYn+LSRTIJcjjcQvF9a+pvEgaP/MXguHgOyCEsW/0MXA
	 H7sxhs3PK/kDpBkLEdtYdvsXiEzk36OXOGfZsVMTT3UFjqTE4kXzi/wx78rpsG9v5
	 yHg4PcEljd3xJxpSHUnHgDh7LPMJx9X19NTUlHK1kGgfiMl26+o3HbQgRRTKWSRII
	 ojciR2Bwc2Z1GxHCuTDxGVZWTWi3DPeLs3JrMEcFaf5yShMlJM1lRvVPDj3KyArzM
	 qjzmoXcleRC3xt+lZQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGgNU-1sWWt03lty-00GaSe; Sat, 13
 Jul 2024 15:50:24 +0200
Message-ID: <45f97bd8-21eb-4ef6-bc7d-9201e7447c08@web.de>
Date: Sat, 13 Jul 2024 15:50:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-nvme@lists.infradead.org, kernel-janitors@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] nvme-fabrics: Use seq_putc() in __nvmf_concat_opt_tokens()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JdDdT3GUzpkpOCWjWe73M1t1rMwD8wjznYly5YMkYxte7etCvLg
 cet9s3eO2FDEIbS9AiOD0GrGdcPp13qepmsYUQtb4HxQYWE4F3JMBdNrw2sjPIQYMXO0NYy
 1Z8NGLa6i+6afWzt+Bx5gkGFmx5xa+E0xr+AoLgacbxXiqjLWj/8lIIZIq0fjIhSvdh7xl7
 suiDGhITR/WGZphwVA5mg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uCU1KQ/BpF8=;ODwdkhcsbvCG4oe2kr5D2e7eFzg
 PMFYW+OgDj873lsKpNxLJwCw7Da8SXNXKwM3QSur9WkmwssCtEwRVrsWl0N+xSS9bi9yhEn10
 pw0RTuB8Bct1+XgieILC+yBjujpQkLzFoT5fz7AqnPF+bEpU2VbKyNJq+pkF0ZKjr8B+9Z6sb
 HoNDoC42ZUvYtLi2RuxvQg+3PfQxoCTfpygJZSCnrwFeqCKIjtJCLRJ2Fldx5cDIWl+rUN8AE
 TRadzXXm8+6y9sjJOhhbjoLpJQfpt5qDRVG7nBuBUTWM9jQ5zPR9UD8MCmhHRFsU83hY2I+6Q
 jx6ufLSV8n03wNfO/3iDuXg+h7Z6a36HkS1vLNhsIAIqLPXEjOOjOm8eSGo0owjxT4+pQT4vn
 cYYD8tG/ZPaEFhhKKqVYWz2093Wpe9DKyyu+r2Qolqlcko4NaZ/HoG2Qn09McwL0cis7bQSKi
 1rsIUGZ0/+gara7YD8sLoBYLq8q+Y+J/fVV4arustcvVPSXrZSlYq4Il1+yYBLQVUFRG2CAUa
 Jvv4gT+09xzJeYzKHs6GC7RjUjQalKT8Ryc7aHo4aarf5KyyUHh1hjuT2/ElHfurORKGHP7Lh
 bI9CzcnWYrQ+R4xzPSlMAEHSBPZaAB1nyBYgzJu8LCxQzet+o3ExuN0tA7J3fzLS97WvWMfSi
 5+8uktOBlN57/t8fCSzAiEXghc7PsEcSG1+z6KYr8DMChT9ZKzBuMe75vWR5uSBCFdppbXexQ
 RgjlQNuG4z4pnh6GGT6B0Gw4h2QP8XwRwGKDgQ1TTVdei8JuiWpMUG8LGYWOYahZ4cujYS5x6
 hb3oTzfgNxr2neW8JYmpNszQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 13 Jul 2024 15:43:17 +0200

Single characters should be put into a sequence.
Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/nvme/host/fabrics.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 44e342a46f39..f5f545fa0103 100644
=2D-- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1403,10 +1403,10 @@ static void __nvmf_concat_opt_tokens(struct seq_fi=
le *seq_file)
 		tok =3D &opt_tokens[idx];
 		if (tok->token =3D=3D NVMF_OPT_ERR)
 			continue;
-		seq_puts(seq_file, ",");
+		seq_putc(seq_file, ',');
 		seq_puts(seq_file, tok->pattern);
 	}
-	seq_puts(seq_file, "\n");
+	seq_putc(seq_file, '\n');
 }

 static int nvmf_dev_show(struct seq_file *seq_file, void *private)
=2D-
2.45.2


