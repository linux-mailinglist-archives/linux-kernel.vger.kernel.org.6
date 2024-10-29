Return-Path: <linux-kernel+bounces-387871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CEF9B570C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A0A01C20D3F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDA220ADFC;
	Tue, 29 Oct 2024 23:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b="jGJSPyYT"
Received: from sonic306-21.consmr.mail.sg3.yahoo.com (sonic306-21.consmr.mail.sg3.yahoo.com [106.10.241.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571EE2038D9
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 23:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.241.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245082; cv=none; b=MEMDf8ra7vbQGXsy325Tz4U2MNBfCWtTG36gs/T6eMcxPusP7ZTbblOtyAbpZzDjkEqtfYDmSm31XOPZUhBHY43Dh9qCgelfKtYLXqOKo/vRzSQ3XTSv2S6YMdhXO5XlUsLchCguOxHQJ/3l3rR8vX1Owo9sSiHGqoE2KJdSKdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245082; c=relaxed/simple;
	bh=w7HW4iNMeHO932LTBNDZgLJxyPb5FGS1JRxdU0k+BxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=DGoIcPjkc8zGEsj3KxBxIiGrGcumChRHv6NR7vYyrMizA7OrmClcEKX6UkDRnUuXHQ2f3SFDRLyMLbnzvRCY2cZwXJAm/n9sAmMiOpjT3qIZnLSiW/EHHfw3yIGVnBjEHDeYb6QvFjXfJsLNAfyLiLjJKrsyuLaq4W3wJX00POU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com; spf=pass smtp.mailfrom=myyahoo.com; dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b=jGJSPyYT; arc=none smtp.client-ip=106.10.241.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=myyahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myyahoo.com; s=s2048; t=1730245077; bh=CANO7+oMA8nkkb8BNVFqkHt5bjmgbHDSwStgzlrk0qQ=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=jGJSPyYTUaLmZoAZUzJjnAYlie23f3ofYzabUGzoNu5lJg2Ms7mRNgw8hwm4aQhDrWMUAe375XEeY/DEqsz9J088O4Q+eGPdO1GEhZIw8hYjPFOtyJgHMUHP5HGXiSfacx88sR3vykimLZdDdGOcdUpEGn1VrGsf+TPTMo5+Ds6yDu2v5ahBAi60S0jxXiLzQJalS2icT39UwnAERBRFMoMGSldz+wMQVhHaDhKbDS9lJtK2EkljRrSwPsJST3IGcXhsdRwKaawcnkJ9m+DfjaN8GK9OanvjpkbmuSdfRf0CcxSCIpn+WDLsrj73yEKi8kH2dz4Gc55R2C+lXkoNtg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1730245077; bh=gU/z13pLDmCV53hK8nPPHWISZl1bQUueogbZcFY3cad=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=PA0zHjFI2l/HQHiqruy8o+tZNeUn0azivbkdMMsJrxgovxhAxJ6ponaGFD68oimVtjBw2xdzDQj7kFrIIoyw5dHHoi9UV7oo8EajZfz0JEGNQw+fEd92MKn83R5S/LDF5LZC6PAWEAh6uZdg/Ka/sc3KygD0RrSO5kMWV0ol4qUcG16qLYo5ApBondD+7v/73p78vi8+Vh9Wpp//ZcvpvqmRg9vj0M0TYm1U6gzE1ol43TVzkm84CRkxs+OpJLyBb0dHIP/qoGvSuq3pF4Y4DKit3zyFsMzqkL+nJkdcvfdB2nkQ+BjDUGlSmWvHDrA2ftZS7PgxRwkQSyStKZxOTA==
X-YMail-OSG: beuo.ywVM1k0CI2LLdS3x3SqFoCdAA_DHi6NaiQwY6DjMjaN2ZQZ7EulSZJ13QP
 0c2X.P_rbsNT8oB4Fjw5tT9CtG8uEMFZziucXI.9KRexKCZGY.GbdnDGzXmTgQpzkP_fjH763_4M
 bdr42fleEt276KxW9NpJ6IRrpKD5JIOTXn6bU_NCSSC__nVm4PPHGEBQo_DgYNJgXmBljQW5tSd.
 n0pWJJMiayazTrJIMy0g.g_G7r2PWwMENO4XmDkMgvc_V1nj8NIrJQ1YHg6zKWevo.MFQuysypJi
 CmSXAYdoLypv59x81fya6gnbOq0fbmOFIj9EmDUJ4.MdgDv09s0NBUTS_D4NY9mg3il1TWraI.89
 i5uZV1ONnj_I4EiFdN75ArzPt6jYZNQ7peaeOUS07dtpE1tce5uRvFrw1j01gklbp_lE6Q1H.VU3
 kGCggayFkpmnkXyygmI1LpRGz14wocu1HZ4JCiTlEU167jgio1th0Qeov1WzeIMZPGcE9HSzvNF_
 4vpjee0Uxf35KqnIBlFcoBaG__FlOdnKliyhVUbgOx3dbkvjl.sFuTUdM.nzBW1VFXE4mkHBhsC6
 5wht328csCwDRpRV8FkY7CmjhLTaE8CgrF8kq6ZWat6DPITTgnKKexwn8uzHS61dnLHUP4Pp71eO
 neW6pCg3mg9qRnld20hgXH1.7bJGhT..d41YznoYTWMALxys1rDSyPZ.dJcAgbK6RGS7MAadU51S
 B.Fy2vaKVFx8WxO2imxj1BGTlG2yDb48M7p3hskAMdzlLXce4OOntVaworq.jasfMUp16Dob5eVY
 JwoeMSSqZP581NQ2UYa8IMko49d.LGgFm3D6rQqsolEbSceKH4hZZVaU3GSsNmSDYOZQD2ajxbNl
 7L7Txc254ktCgTtzWkVoaczoRUXSiGjSpZbXHt9CWoKXtJCeJO.9juvnBtbHkBxH41ugLQ3VSDbF
 4F8boSpACF90ZOMnBRW7Rc.1lqCWDCq5aKbtR3ez9sTcDw9spPB4lYIumQQiKH57qhgMnS3Uq9.T
 wDUz.YbmnXqN37BlLLbOpxXPHH4PhCFIJA4E5XoOibbh55uFDh7UoUONLdtsCA2286aUJrR5UOHU
 avcwUglDr0vOP5NuSiJI51pEo5yZW6QJb8bewBXc50YwyssEHTreZoZnfJDOGsp5tB6AecldDWuP
 ppasrwaKLpZsZnUpY8rOupcLWqxhG7UZANENZATckmnREBJePFk.HYq6q6.Dl9Y02L3iUuTSJE4B
 TOz8nBn8bV1K5lluGGKxTcax5rNxL4kK6LlmWdYA1Idixouva6QE6kYfjLQkU7P3OyotnB_eD2yC
 4ViLNStmm5.yefa7ZXG2BzLe68drqzxkoYJZleTwjesOtdrKzMSBxD7NYwHAAaYcSjyvayl3cufw
 CZUXXKbckbFe9UpnEt1mWlReqQR6oF2bxtP5vqsfcS5Gl0IB4PZb0dsaMds9LGsUVm4bvQQBhvE.
 9msKSCxoeX7_q1YPhdGjjDQF1RNK9qvHGjcpEacK623fyAf2U7LpVeFgOa2cgHF3xOjFggEO8eV3
 oQpLcQVGHR07e5cyU0UvZ2TR5_N8GEwMPW8.6Q0m7hTL3m.R4poM0l3MZ2X6onPzStR2trVd.JdT
 j4EG_sqmMDL2LBpkrlkG02Hzcg4spzg693hHWkuH0F0s0tXJ8dDaZ8DNiEQDj4nmgp4DCI8IE3Zd
 ehwk874BIrh9EAFXiIj43i0yygVFGnIU6mmVFz85nuZrW7o1XEZbhBc65tcw8C3msjQUIAiWbSiF
 wlKPDhnpjXT8xN_w4UcMc4MpykF2IVvtB.GRdSRk7KE3fK80WrJG2a4zxJ9DbaD8TgfHNnznNDPW
 Yere2c78LCVDIuLZ.Flh2AtTe5xXzfFCpdBHgWVI_IlOkKCEO_TWJdY68a9fqjAh5yM.s_H53IDo
 3eEhqxV8L3Qlid660u_mh_DP6COUv_.SuKqNgqhvqSNutNANJcJIuJEkiY6Ztidguyi2zjgMovhi
 svvYhLxh6QruLCJ8qwxdpOmyxg_lbvCIiiP7egXDRKnMH9utM4gPYuyIvCWxs4CkQ2.lOdqx6nqI
 MEMwZx7VVar_op.4c7IMderF7j5joLavR1B908lNPtWMUTi61S8xPltQzAIb3pVZyzUsMk6uzTtk
 BkMrjV.ToVR7bOCBUYeGmH_M4uOqMYdFtVcT35LqoaqIAc2ef6Nau9KyJuQC4C4NQI3QGOdpPwCG
 Lx_p7NHNlY.8OcUMXgrQAgnuYsL1oPe24i8aqY1k-
X-Sonic-MF: <abdul.rahim@myyahoo.com>
X-Sonic-ID: 320644b0-bd48-41df-87f6-9d2cb6f7bc86
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.sg3.yahoo.com with HTTP; Tue, 29 Oct 2024 23:37:57 +0000
Received: by hermes--production-sg3-5b7954b588-2czcw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 30c7e69c8517e1fdffb1648896dbbb2f;
          Tue, 29 Oct 2024 22:16:48 +0000 (UTC)
From: Abdul Rahim <abdul.rahim@myyahoo.com>
To: krzk@kernel.org
Cc: Abdul Rahim <abdul.rahim@myyahoo.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nfc: s3fwrn5: Prefer strscpy() over strcpy()
Date: Wed, 30 Oct 2024 03:46:34 +0530
Message-ID: <20241029221641.15726-1-abdul.rahim@myyahoo.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20241029221641.15726-1-abdul.rahim.ref@myyahoo.com>

strcpy() performs no bounds checking on the destination buffer. This
could result in linear overflows beyond the end of the buffer, leading
to all kinds of misbehaviors [1]

this fixes checkpatch warning:
	WARNING: Prefer strscpy over strcpy

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>
---
 drivers/nfc/s3fwrn5/firmware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/s3fwrn5/firmware.c b/drivers/nfc/s3fwrn5/firmware.c
index c20fdbac51c5..85fa84d93883 100644
--- a/drivers/nfc/s3fwrn5/firmware.c
+++ b/drivers/nfc/s3fwrn5/firmware.c
@@ -469,7 +469,7 @@ void s3fwrn5_fw_init(struct s3fwrn5_fw_info *fw_info, const char *fw_name)
 	fw_info->parity = 0x00;
 	fw_info->rsp = NULL;
 	fw_info->fw.fw = NULL;
-	strcpy(fw_info->fw_name, fw_name);
+	strscpy(fw_info->fw_name, fw_name);
 	init_completion(&fw_info->completion);
 }
 
-- 
2.46.0


