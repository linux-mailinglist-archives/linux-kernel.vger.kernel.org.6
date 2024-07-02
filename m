Return-Path: <linux-kernel+bounces-237748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96B7923DAD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF5E2877BF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B5216F8F5;
	Tue,  2 Jul 2024 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="L8PzqMIs"
Received: from sonic308-44.consmr.mail.ir2.yahoo.com (sonic308-44.consmr.mail.ir2.yahoo.com [77.238.178.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEA816F0E4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 12:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.178.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719923124; cv=none; b=uXvXdRRQ6r/GAFtn/9IfLFNdcJMoZ12mh8eTtrC3eQ4VYGX6lZYYIczIEDm/yhWO5mSFoIRSC6XOHsyjQa4t+GV0PQRWrgb+RL6S50OP9e2SfB5oQ2120Z3UjMVlMHizfzgSGhks6mu3f5oD9mvGZa5/1mTxqe4TIHasMOjWV34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719923124; c=relaxed/simple;
	bh=czYlFkR7gACaffEBBYkZYMloku7B869PLgAxG+uGO7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=tSuBf8ISSN/tqteuR/MHzY62sl//7UW8hjMd6YG10XdXrefEG1icQedua1yeKYoLq2Nbjj9Cv9Mbo/ceXa42H3dqkYtEILn5mqSR9XIqozmAKyKMOYyflSGZGPfYMxRhFsWaXppM7E4RLu6tnnq6L4nHC+QNFVYa1BgwFqJu2h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=L8PzqMIs; arc=none smtp.client-ip=77.238.178.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1719923121; bh=J8LVgZXsBn/SKy0ON6Xyfp/jRyWWH2Gsbog4fAcslz4=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=L8PzqMIsKDTAK56PMorZq7qZ61MdL2ugyUDQ+g2LY+T7W6D9cEpCC6yp+h85eJwC3n0lLqYaRFLRLb7z6esToj6ef1un5gbVQKXpqq4rMOG0eQPDK5RjYN4mKCfrirYpk++Ym2lcYf7PkgQLzvrBucCartUDCZkjbIMxpin82kJtZ3m1S5EAFrakPMPLksFo0LT3wr9eU361BSHt1qPgRd+UX+lFMfYuWE76PIZO/HPa/eCKk0B6yEoQPpodVMc36i6FnbN/5p7SEU19fVhsO3Ch0vViSo9K3fqVX6A9mZbL1hJjEBx9CXGzwJONNMKh5He8BrAR5HO/Kd+RJYaIxw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1719923121; bh=ojo8wkfSFDTTQ+tYwEoPp0kEyAweQJADnia1W5e98f4=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=e9e1EtIgvfoxLMx1LoRRC/LYpIeMTfSUiQNHMWo2/ltJEuqTDMIfAqWO9XlRrQRs9pDr7YNcNeBIk/EDh98233xthDEbkrEsrg2o1epd2kEXJFjxkw3GViykcpZ1K5Smk6gQfi81HihIbbCIdHm2qr8m8Y9FTZr2w5k8E6ft6/lpOH1Ja2j23IFiFAtKvBiFaDW3XcJha9FvFwD59GsnqD4i6mHuHjBH1uFDwFCuJ0RkRFtgem/Z22/qaKDcSFBb/KvKHcy8ZTZokkz/lV9qFTkO03HK4o8BQdXzNdivi8dT8itX7MoUQ89er8MBxi4TjxEbMi0fS858lJOaz1ET9w==
X-YMail-OSG: INJqqsoVM1nUAl02a13QJLORw6oGZokgB9tm0D_u0t7.L.3_e8rDkhW0asv59PQ
 wUB7ez8C6hw2C66ImTssx46a7xqfLZpGmx.b9PxJWj6kMkbk64d5wPuFePSRhmRcdNyCR1FYP5EV
 HPwhTSavDu9zWK73CFsTIJ76uI_LLg1EaSbwpwyGLYzIgOM5O.o_MIXcgvPiIhrYSw6mBe3lNrIF
 jgHTL6oGsYRrG2D7FPo2FJbsuP2dCxBIX8l3hRK4nry77Gx9Cpi8eApdfhHc5Jgot9uzDbvjykd8
 ySZnsdbxn6lXbl4uOmZEQBpslc7CVG1GbH8NXZj_PRXBf.WbA0XKOugzTRGPRKLYuH4F8W7EIf76
 vZuukz7ZQofO9EugcmV2HV2qCcV_GRAqahcjlPhP5aNzgE4c39JwdeBD5FLnLUS5lfhhCSFiF4kX
 Qdfp4Rwx_V3ygH.1g.xRcwtMO4HP7c253DxO8Y3FwdrS37n9AYS.B3ogqPOy94PCXTfSsrRmNsBw
 TDno83H0N_p37.mARmrXa5qZvxnLd8JobcTS9yViaetHuSpq0y6Rcrvv1xPOrPDSpAJnHrLXEJuM
 xiB35FeIU4WwsZ2RpttSmIkZxbfS2OdBkC3zcOkEhPh6c_EsjilB5uF4EPo0QRjjgclx4BEoSG2G
 RTomCdub9A2Kl5fXW3Iyb3JwTLzUuWcOAzIZiRCVb9wmbt.XPpwMNJVFm1WCH5tIg7mMY2ul5msE
 Y0cv0S2XxxVJ.raBl1mPpPlsr2tANCk5SoSzsfo0Ydc31xE_Mz6yk0rahRsWYlKm6iAP1FLq1_XN
 Gpbm_sXubjjeg4bvX1TUMCi6rUSBLa.DhK6TGHz9uAhOaEjFh8OMWTL4DwsRsg62nNPtgSCCOOZe
 O7PJHKPLTGt37sH21x0csJy6Oa20jG.gQeoRg_g9EranMPJDfS59anwWW7UzrDQOqOCsd6BRTVqr
 oejA9rlIXRU1awHyrz4ICGNPfb.6IpUeyAkz70QXHeV54M_asDv3Mr3vQR4xXWjokvgJnHZKPrAD
 vcYV_9rtdjJPgQBpVw79wTw.tr5FzF1jhyuiUiGfGeNCVg4DbOnoatnxnDxw3gtVgnCfR6HP_LEZ
 O_nOnTJ4z_58kWOuoNMRoanxUUk_a2mm2Ntyj4DIEVTnj9GKO6ndWlkxQO.kUEpUbWHvlFxKrjiT
 q1o6Lv5ZxlifJ3hRwcx_D2DdTs_1bQnDw6qvuAT4uOdIS.jLKi9DoabPle203FeAx_KQmUdOR8L0
 5lWF8Lzwg23ZDW1Hpxoxx.TNG74ZUD_t4AspQXJHWizYo0poqnlJ5zeaQZDelLEcrLvgNHGRe6Nr
 wpUHPQ9f2yQJDsQ3ADVppsNcRZME951iXAWtPRzry.Mtw.9T9zFWIHhA5pRnpIz174IvXawZnFRZ
 0QQDJ9F9nb_EUfzn6hVlslQ8hngLGtFw4VStOBn4e0l_BLdkRVNPLXAZdglMs.8lWSCOxyq5XNot
 T7uzchyjW7FpQm9NrgYIyrb22lSGN91uX9ujSf7D.BM4kv5_gt1plXDcEaVy.A0r7NsDgXofBZB6
 EnOk1gpi7SbbBRqv1.7sigXnuzeiJTsIN0oBSl62Y_lvcoXe9VAUni8IxulWDnYqdZjw.JoO80p_
 rWBlfnY3qLL3b_V_Iav0oYgVVx74zkvTHWY0tG3ytP8x0CqwROaETxlE8l0Wwz.MyeWCZwO3zyKk
 szoeKme69weeGHYsKK5klMTM98WrvkQNRxgGfL4WPfJob0q1ORg94cY0nEoRRfDydfq6YY7jlj17
 6pXXd9GpBoeTENmft6HgwEC4mlxBmTB7EwEU4xUYlJNa0oEr9Xu4IRCsTG_WP8_Z2DkWUDfb5Crs
 rRhr2isIezCmRjRJPjuFar.eAvUupu1ljHnjmeY_oMHAifaXy.Op1KhAEHRS4riDxqZZleB4HqZO
 S7w2nfRaXNrw.BTFuw_kRrFKfD9NGYerZ9rFIRRHox1cky96VzGe3aDFBUHJQ5sPtIXuvx08G5.j
 LfaBCHbFQnjWtjvgSI45zi1kt58OLLxOoH0s9wjdHRCWx3Zd6GMrpBE3z5zwYV08YN.UgdNk6UPg
 E3Ik49m7izLziYezWdonBe4OJf3z8yuPGwy3uED77zpFK4fr.PDwDg_xtZURZoRpfDkW.edw-
X-Sonic-MF: <xzeol@yahoo.com>
X-Sonic-ID: 22345d43-bb8b-4137-a272-4ea238d35601
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Tue, 2 Jul 2024 12:25:21 +0000
Received: by hermes--production-ir2-85cf877599-mvt7h (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0dd9cec1d13f3a8113ebc66190b2d374;
          Tue, 02 Jul 2024 11:52:55 +0000 (UTC)
From: Alex Vdovydchenko <xzeol@yahoo.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>,
	Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	Alex Vdovydchenko <xzeol@yahoo.com>
Subject: [PATCH v4 0/2] Add MPS MP5920 Host-Swap controller
Date: Tue,  2 Jul 2024 14:52:49 +0300
Message-ID: <20240702115252.981416-1-xzeol@yahoo.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
References: <20240702115252.981416-1-xzeol.ref@yahoo.com>

This series of patches adds the MP5920 Host-swap controller, which is used
as a protection and control IC for devices that are being inserted into a live
backplane. MP5920 acts as a voltage regulator (MP5911 etc) supervisor. IC
utilizes pmbus and provides monitoring, statistics and limits to electrical and
thermal characteristics such as:
- input and output voltage
- output current
- output power
- IC temperature

One must take into account the nonlinear character of readings, so there will be
a statistical error in the range 5–10 percents, depending on current passing
through. In order to use the IC, make sure to specify a valid I2C address
(consult to datasheet and dts-bindings)
MP5920 datasheet: https://www.monolithicpower.com/en/mp5920.html

Changes in v2:
  -  fixed typos
Changes in v3:
  -  removed unnecessary license blob
  -  removed unnecessary headers
  -  edited device tables style
  -  added chip name checking in probing
  -  fixed typos in pmbus_driver_info struct initialization
Changes in v4:
  -  added i2c_check_functionality in probing
  -  refactored usage of dev_err_probe insted of dev_err
  -  edited chip name string handling while printing
  -  restored .driver.of_match_table, keeping i2c_driver "old" style

Alex Vdovydchenko (2):
  dt-bindings: hwmon: Add MPS mp5920
  hwmon: add MP5920 driver

 .../devicetree/bindings/trivial-devices.yaml  |  2 +
 Documentation/hwmon/index.rst                 |  1 +
 Documentation/hwmon/mp5920.rst                | 91 ++++++++++++++++++
 drivers/hwmon/pmbus/Kconfig                   |  9 ++
 drivers/hwmon/pmbus/Makefile                  |  1 +
 drivers/hwmon/pmbus/mp5920.c                  | 93 +++++++++++++++++++
 6 files changed, 197 insertions(+)
 create mode 100644 Documentation/hwmon/mp5920.rst
 create mode 100644 drivers/hwmon/pmbus/mp5920.c

-- 
2.43.0


