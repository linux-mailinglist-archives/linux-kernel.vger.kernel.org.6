Return-Path: <linux-kernel+bounces-329835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6979979685
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 13:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 870171F21A11
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 11:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456381C462B;
	Sun, 15 Sep 2024 11:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="AAeA4fs2"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC62A194ACB;
	Sun, 15 Sep 2024 11:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726400981; cv=none; b=m+cyfH0aJI2IH7xTDAReJc2q2mHNrkPu7maqvcyIbbPrPwvMyN4QUUlLzURuZBihM1TcKxSBwPdxPFpT9rTtVzMT70HPtJNakRLtYN04/uYHRXeuCJnUlPyhrD57fHKHEILnl9d6bD7uaIvTPZ0bsXLOZFdncVxLL93RJrDQV3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726400981; c=relaxed/simple;
	bh=SOWT7H8/0YJNIdQkDiiAu6PzGXTTeVlu5vTJPgyTytk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=jXlOSv4XDZ79EZb58SH+qNB0yAr8SN0zhvjq9oOpmz3CWHqQlgYu6FVNupVCR2OhhOxoTP9lJi9bZK0OJ/v6tSkC5eMSM2yWtfsPocA64fzP/XB5M+K1Kl4reRZgnjUuVLRfgwWxI07BJmYUPBhowZeULzqOeXOiw0UV2GFkGvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=AAeA4fs2; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726400965; x=1727005765; i=markus.elfring@web.de;
	bh=/JziMUAx9DdLA+PFaPvm1xXijXoOH/QWJFYNeBwV2H4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AAeA4fs2hU026GF84NZgJw6N+KD8V1TVoez1Lj/GbSjHQBUvpgBxUpr69ZcloO6+
	 0auImSdUjafSwnbiT+Q/Q+MSgKvjberMSUimfzF4bcja+Tm4tpEH909HzVEvmR8kv
	 Td41ywfyBBa4Xa0DYZdcwc1onv20ZJcCPsGt3MZjaaBg1mVttw1FbfhJZULnNj7XQ
	 x3Bovllt8XKOlbkFg+1QuJKP7VMi5dlrLaRD6R774uqWnzeZ0FP+y9QeQ0GZiQu8m
	 nYtMLhh8cmK1UgqbIPFKxEMb9e3Xz+7WOpO+MLQObSV9ZP4j+1TJdozLnO5iEjyZB
	 gFP9mMsXLZ+i07B+nw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2ggd-1sqche2ASl-00EJrb; Sun, 15
 Sep 2024 13:49:25 +0200
Message-ID: <641210ba-571b-43e7-9007-5633a6c7434c@web.de>
Date: Sun, 15 Sep 2024 13:48:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-sound@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] ALSA: i2c: cs8427: Use common code in
 snd_cs8427_qsubcode_get()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6Gz+vawK1wJrtDmZxXyooYgxbHQCDwb7oAKyqWnSpzGh4qPAWrm
 JkbJXRMlX7bh4URytpvlwlAHLMIF0S/3OFlY1PAnIrtwnb7aRfq5EqMB45cqt/h0Loa+h0H
 Ptad8SAtWqS4k50CZJHLB/wH7DIi/agXRDx/2QEZDNVF+Kyvmhe7SBTxLiF0F95zS6sKkkR
 Jvm2aHY+GX5W72jRY06nw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CB1niy/AYks=;UJ3I3d54o/v6N6YJjPqwBO7XE+S
 hllowBAAowvrLCzRfz4QLbRaJZWvZkcTtAycRIOktYiV5fWOk2hSybJIaoiHOjOqL3TbfNfGh
 BdZVj3Q4WnmcfIYbdvDr/bzZZgcoPK6ekHbS4lU8v+Z+WhwSLAy9m8kBrYYUgAOHZ6MxfkFJp
 4uc3wOCcvB06oJXZwftogafBpaCWNx96RHorySydYcpn+QbFN+ORZWQvRtS6zmSVk3HeB6SOg
 cDNyBk9UHAcFXIfQbnHvuOuAskcHjUIs3uaVAYpIvGV1Id40zFpD5LWku/Hm0Njlxcu1pFU+B
 0+yPoV1RZcIYf1FulQ6zcV3xbV5o16C1eqA6VyFBgF1I335wrt7Ap2X4BakreuSQmV3S5T5DZ
 v98w50Ny9n6BikiAvh9sJnMChBkspJ5+wBbCzLRzxzbFViSRz/DBavZssEyn9PDP8BZPd5a9G
 ixQUvppjcX/FCaoVTJVK0f4SVmdaIuPRH9NR69QWTlDYzt70/OwfXcnG43efaMPVPJuf8fw8l
 RTgkrcjWHglNT/+Ei2ruKV2/rWBlcDrxng/dJ+hvyQeSCtxrBr9pWvNkw8ghB7qwbhS3BP/HL
 wql3j2rEHvXE7Nu72KqT5scNGIYcfa7TUU/vus6roF67yvRe/ZLOO4dVuLIZGBtRKB1baiVrY
 F99iKYqZqONzs0X2Txzm3nU5pSAXkuZ2iL+Vm67ZU5nIrwGZiPRMo5ycjIJWWLwTQig+VDWod
 OpS0P6GFPusQcI3bPma9h5R+yRLNXEdUJZkNCuwpKfpUmaoH8et21ebVMITYgCrMiQbfR8rAG
 AYcPAw+kv8wK8nA+8rOcjV2g==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 15 Sep 2024 13:38:29 +0200

Add two labels so that a bit of exception handling can be better reused
at the end of this function implementation.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 sound/i2c/cs8427.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/sound/i2c/cs8427.c b/sound/i2c/cs8427.c
index 29a1a7a0d050..ee650006cac4 100644
=2D-- a/sound/i2c/cs8427.c
+++ b/sound/i2c/cs8427.c
@@ -397,18 +397,25 @@ static int snd_cs8427_qsubcode_get(struct snd_kcontr=
ol *kcontrol,
 	if (err !=3D 1) {
 		dev_err(device->bus->card->dev,
 			"unable to send register 0x%x byte to CS8427\n", reg);
-		snd_i2c_unlock(device->bus);
-		return err < 0 ? err : -EIO;
+		goto recheck_err;
 	}
 	err =3D snd_i2c_readbytes(device, ucontrol->value.bytes.data, 10);
 	if (err !=3D 10) {
 		dev_err(device->bus->card->dev,
 			"unable to read Q-subcode bytes from CS8427\n");
-		snd_i2c_unlock(device->bus);
-		return err < 0 ? err : -EIO;
+		goto recheck_err;
 	}
+
+	err =3D 0;
+unlock:
 	snd_i2c_unlock(device->bus);
-	return 0;
+	return err;
+
+recheck_err:
+	if (err >=3D 0)
+		err =3D -EIO;
+
+	goto unlock;
 }

 static int snd_cs8427_spdif_info(struct snd_kcontrol *kcontrol,
=2D-
2.46.0


