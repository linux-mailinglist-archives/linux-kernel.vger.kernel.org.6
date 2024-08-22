Return-Path: <linux-kernel+bounces-296289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CD395A8C2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 02:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B459AB2252C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 00:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155FD524F;
	Thu, 22 Aug 2024 00:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b="Q89nzcDc";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="r2GtIk26"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A103FC2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286242; cv=none; b=Yp1/KeurSjOaIxXqIHHoaGluuuVvmXr9hQ5AUdsTzXPkPRt4e6y85FD7iXQkvMhxxfV7iQDLbbu82t/BOuAVdDMTMkOYw3fw/Ajpus2ackytKb74j9H8Ge8VJ6eQuSY50tNYu6i70//VnBHFwln5cY8LNJgV2pQlCiSbXkUV/f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286242; c=relaxed/simple;
	bh=rfQIt6yrRhb9t4G12CePLYsvrES22E9sLirarAwlNdM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FEl/J1qlKV5WT8jifc/7k+p4ug19UfwXZQPPSH3MlTmHYO3eE/kVuzbtfQTwG0DjUYozMtUTE0BULECIZ0zLmue7ZwXp7DqVGV5L+dpcSSF0tH7GjeDOYOOQwqDiAVKFgColdEUCzNZ6558GebbGik5Yt0OflHvlSZBkDVVnl1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev; spf=pass smtp.mailfrom=lkcamp.dev; dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b=Q89nzcDc; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=r2GtIk26; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lkcamp.dev
DKIM-Signature: a=rsa-sha256; b=Q89nzcDcEJWtbZt8P6NA8izuzaR4WhiWyAUsT0jnOm8wvbgXNW70UJDNvZhgYeYrc3mla+8bbKDDfYUr8S+qlYgBnTbYAxi58vtrxIdFi+mujA0gco+8DkfDUHJX32PHaIJGdoiN3mSBczwRIJnJSb09/Gjw/G+Phw72X2+X9pc3IyuZpcq+lqLRDvEAseNLSGjzDzKCf/25biQMutZTIBMEdKH3+9YEqX6f8+8J+yXOF56c2DWo6t3rjRrAaH/HwKkSZi+Z934kSep+jfT0OShN7MaS/hPtgomUdGeVtQsM9bIQvRCL73BRk0LX+4KvZhfoYfMAXeDVvCMdLhL/Cw==; s=purelymail2; d=lkcamp.dev; v=1; bh=rfQIt6yrRhb9t4G12CePLYsvrES22E9sLirarAwlNdM=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=r2GtIk26jrQWFXyEnNA1Q+h/mtC9Ev5W92tdHnCZkEswb0/F1ISN423v83I9HRdl04fc1Y5uUctRkB4x69pc+AGlchGots9HZTU+vvsc8PW62b+3Jp5jZMzoXntGLbmyLUrLLAsncy15G+emEgae8Z6r9YwXmcGrxZ3LlW6hylQk6NN9J4Qr9Vue7CnZylouw0+35Orn7SJdUDjiCE5vXDcsAZ8b92eGJxepAELNWUKyDskqXehAoY69PX2C69uxGFlUEazDTqI8Z4Vn0KQ2oYAhDTCF/9eLT8ziushT/BNn5KknTAPAA24mR3u77w/5J0swL7CGGpV3Nmw3km1QcQ==; s=purelymail2; d=purelymail.com; v=1; bh=rfQIt6yrRhb9t4G12CePLYsvrES22E9sLirarAwlNdM=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 40580:7130:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -2138234990;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 22 Aug 2024 00:23:48 +0000 (UTC)
From: Vinicius Peixoto <vpeixoto@lkcamp.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH] staging: rtl8192e: Fix parenthesis alignment
Date: Wed, 21 Aug 2024 21:23:43 -0300
Message-ID: <20240822002346.94433-1-vpeixoto@lkcamp.dev>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Fix parenthesis alignment in rtl92e_init_gain in order to silence the
following checkpatch warning:

CHECK: Alignment should match open parenthesis

Signed-off-by: Vinicius Peixoto <vpeixoto@lkcamp.dev>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/stagi=
ng/rtl8192e/rtl8192e/r8192E_phy.c
index 18b948d4d86d..ddb0004198cc 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -944,19 +944,19 @@ void rtl92e_init_gain(struct net_device *dev, u8 Oper=
ation)
 =09=09case IG_Restore:
 =09=09=09BitMask =3D 0x7f;
 =09=09=09rtl92e_set_bb_reg(dev, rOFDM0_XAAGCCore1, BitMask,
-=09=09=09=09=09 (u32)priv->initgain_backup.xaagccore1);
+=09=09=09=09=09  (u32)priv->initgain_backup.xaagccore1);
 =09=09=09rtl92e_set_bb_reg(dev, rOFDM0_XBAGCCore1, BitMask,
-=09=09=09=09=09 (u32)priv->initgain_backup.xbagccore1);
+=09=09=09=09=09  (u32)priv->initgain_backup.xbagccore1);
 =09=09=09rtl92e_set_bb_reg(dev, rOFDM0_XCAGCCore1, BitMask,
-=09=09=09=09=09 (u32)priv->initgain_backup.xcagccore1);
+=09=09=09=09=09  (u32)priv->initgain_backup.xcagccore1);
 =09=09=09rtl92e_set_bb_reg(dev, rOFDM0_XDAGCCore1, BitMask,
-=09=09=09=09=09 (u32)priv->initgain_backup.xdagccore1);
+=09=09=09=09=09  (u32)priv->initgain_backup.xdagccore1);
 =09=09=09BitMask  =3D bMaskByte2;
 =09=09=09rtl92e_set_bb_reg(dev, rCCK0_CCA, BitMask,
-=09=09=09=09=09 (u32)priv->initgain_backup.cca);
+=09=09=09=09=09  (u32)priv->initgain_backup.cca);
=20
 =09=09=09rtl92e_set_tx_power(dev,
-=09=09=09=09=09 priv->rtllib->current_network.channel);
+=09=09=09=09=09    priv->rtllib->current_network.channel);
 =09=09=09break;
 =09=09}
 =09}
--=20
2.46.0


