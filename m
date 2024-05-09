Return-Path: <linux-kernel+bounces-174723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1D28C13DE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 19:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E90331F22AE9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 17:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3568340BEE;
	Thu,  9 May 2024 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="E/sGQ9XS"
Received: from sonic301-32.consmr.mail.ne1.yahoo.com (sonic301-32.consmr.mail.ne1.yahoo.com [66.163.184.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FF338DF2
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 17:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715275181; cv=none; b=KTUSM2FNPZdjYvV7LJfpc+lkGcDdBcrJAQKj9plwfnkqjN1QYMxA+GFBpukW0Xjn/qn/4Wgao9BMGPHbHivtzqUNUOUeVsAjs20UHiuHVJT9yLNw2m4Lk6C2/pz7FFmsRTwV5fjurU6INh49zuqfgSpzT41m8EOPRbwItLIRbpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715275181; c=relaxed/simple;
	bh=lPwiKuRV4pwIKYvBI0L3A7kueSDCMOHQdhNSH02aozE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:References; b=Agw8wMbZqHpxLH2J9tmS5qhPAmifiG3Xz+x4E9HrfQiIrHMRvvjWgklhrRXXBsjogwtVv8m7E+3hYDMx/6CkZ7bW1K7ldq7iOhc89SgECxnAAoYx6W5zQzwKwJg5SkjrC6w+Iz0tnB+blwI4vjXVhzHqv/dv1vxEl7qjI31kqTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=E/sGQ9XS; arc=none smtp.client-ip=66.163.184.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1715275172; bh=NZbNRrxw4TZ5GUHo6xbduEkO3V+u7bBWuS3fZOqgnWw=; h=Date:From:To:Subject:References:From:Subject:Reply-To; b=E/sGQ9XSQAInYBcCAr59IhHBQXni3bhPlU8Kgm/Pj2cAKpb7uaK7/kw+fMjFppy3kOTBmW/jtCEybtg5MTLzsOTnCCpr3HUpu3TzWcIfIFQDJQu5759hjR4DtUBtmkafrOO2eNix8t9aF0lAj3kIdV8dhv5SfVUOu3od6OcBe3c4z4WpnsMxptvobPv1Pk8OeKjm3LRk4bVIS966ZDuofIppwtnj7qdm/nxtGlN663ayGGissB3ntg5xnJa1hlEnF12BJavjN7OlsU/yXiv2o01KflE0vMWU4TdLKYnq6cZMTc2ReWhkGOoPzFr2U2SdTFjFh1XMYh0PonQNfyaVhw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1715275172; bh=6PzBqGn1mN9HfO1K0PxSsW8pRPgg8FNbGJqdYvpAzIJ=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=TctDPwm9EgDLpZ/B2h55RnpXsINTP9p71zzI1BEiiBtvCvHK6dA3/YCzFgbDwKRsiuNglTgrYhgeBY1S5cYEoIAwID4w9u0NbQiayRURmi9d2MMmwwsXsXZ1t3lVdtm5xtJQAaBjeFmIqsoPSuDJHnVnZHkFuDjGQO4WAusoiaDmaGgDMcCiCcCX5rrPEDZcznVLcT18OXAJPjoWb18iqc9jLoepNM/HF9eM8gy16Nyy+IP4NelqwaY673PQgNBkgl51wGW0u49MaGfl2s9nRFwNvw2WvzsJXeTqNCGcpSN3W+jM1pKVDE/z5LM71ZbT2Vl8hCQNwbGRTpIfTt3bHw==
X-YMail-OSG: PkdX.QkVM1kpyhiQ7hOHI.512rSweFleKGxwxW59QRIDbtep3ObYtuyUTwSuxff
 AGaSjyJQsnB6yDFrwLl5iVQ3dNJ6YOFVA4fptDODHPf_y9mSfTjaD9McrOuOCsf6vGNW3MEZHk49
 jA.xARcbFCCqbR14Nq7JCBA_KrFXRu8m3g81G_Dmz.XnIH4mr_t6npgLLarcq.V2jsucCDS1m2Jk
 oEZViNZo_Ls78C91WAAeCRs_vEGQMns8eR4jdjXN14gdiwGcF5IA4BAARXHxZ_L0AXdb2E2G3hFz
 75lwFDVVypkctsXxNYeVYqhbgJD0NwUHycxRPNaZKO7gjO3YHFSxtZ.zqK7SeTITncn6C09nczVA
 CXfSohnBV4vNf0FqPfMe4GBCX.5ahxuh6xeKk_M4OwSWmDK6rXmlsEGxtMxheds5Pkrh82p9Hl5a
 eQWiayE2GYQlRmfZeDjzFb53uupFXxYxm00Pzgznc0yrPOmAXE.n4pbOe7AD1OW70Bwht9tjyMgW
 b2cq2c_3BbF3xEMti2hM8l_SlsQ1q6rGUDDlFICDJ4s7fhsgPGknwJslqXrBznmhhYhguiatRJXg
 KtS.RiZhpvCYt0Uc9o0H4f7enyEXGqjpRC1RFasWtRRPMUdLRsWgL8e3GfzfKhqz6Gfsaq0MCgxu
 0rqWszq_Y4_iB0YJo6_C.bt8BOoyKkWsxqYE49lsLKFgGSZZ7yorp25FxAlM2ks4erHf9I0EoGSW
 asSbVHGJyCZ_w2JDWLOLg6iNVnMozj.dE.ua_L6kCF.KqLFr7guemEyuWiGLoYCoVpboEn6k9OK_
 QKj1ZNkU6BB0DuNqYdfjNadhZE3yJvhOxBjfO2LmwJ7h56qvpeqfhCH5990jorXPK4vpeS12Ap8J
 HkeY8g2vSdQqCBZSizCOeWWPljDPopP5a7JmxNRDqkrynzoLXCgAk6KQ0O0m_0t2W0hGZgg87wF1
 aLpmntWbCcLlC6dJR7ZQrMgodV460CrRrg1qBAeGsKmbUFBm7joDLK6wMyeur9PjX3Q7xLYlYN2E
 BEaPipw3TSD3xeDLOam3EaIN4o9viXOTasTRC_6871iskeYLJ6hgPwIV_10BlpG2QmazMxC_Yd_x
 ymLm.ThPVTNmB.K5nWl5FbBzWg8JljuH5yvyvzcdZPSGQsvCCVJcWsDkPRlzt70ZBwQYOq09anuP
 SyOtbvNgUisYCxgyikZX9Brf.tx4LJV9p6b28W2enzdiMZv4INj6bvKN2AbJetGrHaiOLSxcvD4Y
 p3tBIK51D8hpbzZLC6xYUn0.y2YDonFezMIbMpngkJ1LdsS66Nl40FfPp2lteqtJvlAVtufr5GLE
 I6bf6kl07TBCZN3L59QNceTG22lDe4C40E1qm4Rr7_b2iNmURWKr9mLBHECB98t4V4CIBalf8YH9
 _mcUJP_a4R55nOWd.0VN31up_HbQ1DBsX0ds_CRBibSl8DlIvZI8.3oKsQEPrTOYZcGU2MiwK9Xv
 3HWcsQKjB_7fEsXuN0kSF8rJQhQ4CPZrYEHo65LvNbnMe9SFC0PmYFkymEcw7XyV1VSY5RvJaVDX
 3IeeFx8r_z9SeU3v5KrZ0idxMvLuZU9tiNsYZGZDaJXDaZgAw.jiy.szEZIMt_5yxETOLkiWn2Vf
 ATR1_IjwgvJGkos5Ki9bodAMtycLm1ibnGuB8ZtXX9ahIDAbwRKtbN.C4nWnlHfjw7aL5sU4v1OV
 mdpcCflLVin2haFqC7Gi_gjA0Coxsn_cFg73mdH3VxvqJS7J5vTPJkof7HVGGAMxFFNG29cM6q9o
 UYGKEWV0Unv3_GGPu4VXJ3wx9GKRR0PIWCvq0sCsYGMR780K0yuOGET3jeQ73m79exLF.jMMvCWM
 qHpUsdxEfyw7MAUiIZus_0BER_N6aUtRDj2o3OsKRsBqaZ8WfMmvfsHbDOEiof.t3CEvYkPyFTF5
 c3TKCjl3q4MofUDMMMlhYLZnO.kfqpJg0.KwRv29iF.o.ZJ20zfNzIQFK1lK1ZunWVd6gbmKBYdR
 NaCA6CMmMN0xq4IPpsacONpQLsGtgi7o0eUklNph_jVV_EonFhLQaW36Ji047gqf6.4CTFXpq2kS
 7SHGeg_x9XttOrknHlHix61fWTBwih3G4PXXbVvt5A6AstCbqd__7jLjQnYOesn8p7rKkPRXsJdZ
 382CdREwKOniRcxTqHvI6U9FI9Y3MzB7fGVU89c_lZRzoA.UALDNvtwX.S_CTe4vnhYpR5qfcLJV
 4Yzl0VgX.bzMUwXpK1wzoxDp.dpYm4_SkFSKeq7LjD.2srIBDXx9yWjP6rlkxoKjVFz5mXC01x6g
 zGg--
X-Sonic-MF: <ashokemailat@yahoo.com>
X-Sonic-ID: baa26a51-26d1-4fe6-8191-d04c43177dae
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Thu, 9 May 2024 17:19:32 +0000
Received: by hermes--production-bf1-5cc9fc94c8-dv569 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6f8786067ae67dbd6de1c4462c36a576;
          Thu, 09 May 2024 17:19:26 +0000 (UTC)
Date: Thu, 9 May 2024 10:19:23 -0700
From: Ashok Kumar <ashokemailat@yahoo.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Subject: [PATCH] staging:vme_user: Add blank line after struct decl
Message-ID: <Zj0Fm+vBdzPHlZKS@c>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
References: <Zj0Fm+vBdzPHlZKS.ref@c>
X-Mailer: WebService/1.1.22321 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Added blank line after struct declarions for improving readability indicated by
checkpatch.pl

Signed-off-by: Ashok Kumar <ashokemailat@yahoo.com>
---
 drivers/staging/vme_user/vme_user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/vme_user/vme_user.c b/drivers/staging/vme_user/vme_user.c
index 36183f923768..5829a4141561 100644
--- a/drivers/staging/vme_user/vme_user.c
+++ b/drivers/staging/vme_user/vme_user.c
@@ -106,6 +106,7 @@ static struct vme_dev *vme_user_bridge;		/* Pointer to user device */
 static const struct class vme_user_sysfs_class = {
 	.name = DRIVER_NAME,
 };
+
 static const int type[VME_DEVS] = {	MASTER_MINOR,	MASTER_MINOR,
 					MASTER_MINOR,	MASTER_MINOR,
 					SLAVE_MINOR,	SLAVE_MINOR,
-- 
2.34.1


