Return-Path: <linux-kernel+bounces-359153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B718499881F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8152928B18E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553871CB30F;
	Thu, 10 Oct 2024 13:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="L3wyaQsc"
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2491BBBFC;
	Thu, 10 Oct 2024 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567971; cv=none; b=bGeJc3+FBklhR9089PTBjTsdrKPr45ijP68Wb+DK6iISJfDfjPlrefCVH2p1zBUtnaOKb0arhOq3TY4cBJ9bg34rgEboHUEidgA5E6+zPPD1w17Hw7obSrRVZHeqg8LzruXeOC1Sb0QsuCO3a3Buqh/4vPE7lxZYkIuoa4zP0Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567971; c=relaxed/simple;
	bh=/Yfo5ib81mCzDEetfWG2fGvlxICAnTuqgqaS76MyLMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=I9DmodrO6u8lDvgvmEjU7CrE4L2M6sV6+yvBSfvN89oOkeJUmxdQn0QBjOLeVRrmf2xovfxBHtrooi3Q9FYeV5XvYqpoXIhV8jMrRDemd7fL3XD5ktaSYujI6BFgE7MBx4pk3fMS3vPGJ0p4LPNy/d1fxam7JyqQ1YyTmw1sIBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=L3wyaQsc; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1728567960; x=1729172760; i=christian@heusel.eu;
	bh=YbVdfUKx0Gkw45c8+fCEZ4ungIa0Xfesdo4ntJ7H6hc=;
	h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=L3wyaQsc5y9d2T0MD6vpOywFJEW0gQHj5+iI2W/VURDt4LKhdEo8w+6teCHe3rfC
	 AP8W9rv3azP4KzT6Xqhd5siJzGXxgeP/S3js0t/c0YX6oW9TMmiiS6WPTH8vGA8eJ
	 Q36FPKtnUAOWThKgTuQF1HfiphCcWvJMhQzrOMjmdURySXnNt18M4Ou9DCzPcgiTh
	 4I8wKHVAz5qWgyeb25tpqRpUdMFEX6rYvxSavgXTL/EA/u1Up5Dy0Yaz5tBHxpzyt
	 ExqRDi2gAxk985Fq2OXJZjxSfcUXLVbgt+IHyvEL3EBj95/hJya4HT5GF4+nhS1VO
	 vy07xo5zrIGFn918mg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from meterpeter.localdomain ([141.70.80.5]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MuDHR-1tqJF30yK5-00wwUj; Thu, 10 Oct 2024 15:32:28 +0200
From: Christian Heusel <christian@heusel.eu>
Date: Thu, 10 Oct 2024 15:32:11 +0200
Subject: [PATCH] ASoC: amd: yc: Add quirk for ASUS Vivobook S15 M3502RA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20241010-bugzilla-219345-asus-vivobook-v1-1-3bb24834e2c3@heusel.eu>
X-B4-Tracking: v=1; b=H4sIAFrXB2cC/x3MwQqDMAwA0F+RnA00tUX0V4aHdkYXJnY0WMbEf
 1/x+C7vBOUsrDA2J2QuopL2CmobeL7CvjLKXA3WWEeGDMZj/cm2BbQ0dM5j0EOxSEkxpTf62XP
 XE/fReajHJ/Mi3/t/TNf1B3THhzNvAAAA
X-Change-ID: 20241010-bugzilla-219345-asus-vivobook-5d5e371e7b45
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Thorsten Leemhuis <linux@leemhuis.info>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 Christian Heusel <christian@heusel.eu>
X-Mailer: b4 0.14.2
X-Provags-ID: V03:K1:iU3xu8NdBoyFUyQgV6ZckZHRRD9EnPZXOBoJybeKasiLsQuVisx
 9QTP3BmxEU08Nxt5810R+2dthTP3lfwDHRMer+HuPHQsbMr02zrWi5rsrnNODtqVL5wWnwa
 ERSNUYq0am4guSn/41J+yknpB3dOxF8RF2t/h/jHjuIdF85XAwUIv2xar959YH3cdyModNO
 jggwN3XZGepKgG0hIxSEw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GNlUAwnDLdQ=;TmveZfhALw/AYfBGb9UOdHt31Iw
 lDsic/JoHqzVItF8AbflzIB8kwPNSP7cR1qCZepwNujDG1Y/XQxuNrKCvutt6imOCmsDo9Om9
 UDnYFHXs2I458drxia8tbZ5kf2mVBjvfY5m0UrB055NtCyQkFyQWOdPXIEqh292SPH8FE8AcY
 VGNiELJm1aA5vbIW3CG/m0J5/KVuqqCq3txDUHCnv8x1ID+Ic6I9tklPB4dJfWals1wNeNPqk
 rMv6hTOue/NiqS40GrqDNtTH1uGKPhPD+xnUypp/0Y+sVXidA+sBProg1xq+1cBJOWh2YeJX8
 dgEmOYBShKZ5wqxp7yU/gVVQETV8Yl4ePy4AA1SQBxZPJCcbfbYYH12HZ4tMbHc15TpfIIYOR
 8Gi7gHuuTLTA8yj0zJxMR9fHYiWzY/QdWGmVjNsIIG2joJGRgmzptDp7oixqJReLX3BgSxeeT
 4LkCCpYKr5l9nul0MVE3cQT3BrwmZOlBaYR7vl8Xy8KmdvEn63MYbBLkBuLnsKeoVoVJ1Yypl
 G2MI9ZjYB2zPDQVDwSVVjQsdqQANTn8bAhlZxBGb/7SNbjknJXAC9myV0PplVt+AdGpYTrMY/
 frzxogcLWnT6SHelI/rZ0kaab0AShMtpfu/drGLcAivd2KZedcITpQ5c4q3NYTVlR6MvnLqxE
 sloDA/5fe85ca9TdPCqPMb13wdYLmAmigirZrhPYL7PBrhfhWc0pjC/pXzTLJOkDFyfYz1tB0
 cniN78WlFoJAs8kSndPKRAIMPPnVC53Gw==

As reported the builtin microphone doesn't work on the ASUS Vivobook
model S15 OLED M3502RA. Therefore add a quirk for it to make it work.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D219345
Signed-off-by: Christian Heusel <christian@heusel.eu>
=2D--
Note that I do not have the relevant hardware since I'm sending in this
quirk at the request of someone else.

Also does this change need a "Fixes: ..." tag?
=2D--
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 06349bf0b65874321e1c54afcff50417cdc9248c..e353542dcf636b5e38db89af53=
2a73c55e29de51 100644
=2D-- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -339,6 +339,13 @@ static const struct dmi_system_id yc_acp_quirk_table[=
] =3D {
 			DMI_MATCH(DMI_PRODUCT_NAME, "M7600RE"),
 		}
 	},
+	{
+		.driver_data =3D &acp6x_card,
+		.matches =3D {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "M3502RA"),
+		}
+	},
 	{
 		.driver_data =3D &acp6x_card,
 		.matches =3D {

=2D--
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241010-bugzilla-219345-asus-vivobook-5d5e371e7b45

Best regards,
=2D-
Christian Heusel <christian@heusel.eu>


