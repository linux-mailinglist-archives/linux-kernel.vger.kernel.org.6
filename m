Return-Path: <linux-kernel+bounces-566905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4891A67E2C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 904A53AFC79
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31381F63F0;
	Tue, 18 Mar 2025 20:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="CMjwLu6f"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D0C1BCA0E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742330797; cv=none; b=ESUryxJ1aGGt9q19vJky3E5lFV1hGRsW8GCAPMmRfuOeWayy8kPDdQMAOe8qvIfrYKVY15oTGGAKR7AiU1vJXq5I01EZNBk24j9zpi/ec4dvDDwIH786ap8CC/5Uf/P4ZGA6DhN7y2xH6Jn531F8BcofcoHC2Ewf2DnJ+OmMHH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742330797; c=relaxed/simple;
	bh=xkay5qH9AM2QFXK8oihleucAVC2ss5YBgCNpmJ4izJM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:Content-Type; b=nusqFkFMagIDM9yUgD2K4dBkMS+aFwGpk7SGLeEubtfPeFgU8EtuSZxYwQ+52TLUraVyuUX6kcTeq63EaiP2olBel0pcPhgYVxbWgLVrU06mQypG7Z3/VSIUeVpcIhF7bOS4Js0eC2D7wo61O7hMXHBfMU1QUkimjDaFUHvMZpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=CMjwLu6f; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5b6f3025dso8925288a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1742330793; x=1742935593; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:user-agent
         :mime-version:date:message-id:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOxN+ZknqyDDX0vVNYFZ1rF8uRtHiCBa7wmST/H5E7g=;
        b=CMjwLu6felEdlBpgEoiJ46WY5nXUYzdR1x2FuCtzffpS5pS1PGyM1rUm27Xe4ApqWS
         pia93oXFRBw0XQO0c9FHAtPLj2aZlECwwagSUmxswCeEM0CIoNApso9bl3cUAmvs1upO
         1ABHDvPWROUdmSs/kW8MdSJkMr1Xd5o5TWr4jh4/4y/1iXmOp47h0iw+dzOvn32wqG1v
         c2PCVG4Er+8ppMje9GrXnAL3FvGOORpe9+RNLDhmDpjCA3ZKXf1ATefo3NTX5SAb2Ziy
         oILjeJ0nQ/9i0P1stBudgDoRvs7s2gNcm78wW9RwAh85KFyDpkwcUVbS14DmSDbzhf6g
         kaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742330793; x=1742935593;
        h=content-transfer-encoding:content-language:cc:to:subject:user-agent
         :mime-version:date:message-id:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOxN+ZknqyDDX0vVNYFZ1rF8uRtHiCBa7wmST/H5E7g=;
        b=RosjG1yIcvLvosellqKowCwmwChWYmqH7QHCnF6+f2QAeFb9bzkGNX2ezcBQPopOaX
         IlKY3QyIog386h9RvWZHuzFf9OOf1eQSoKoZskUgHjgSzsbm5lb9p6d9JM19AhjBxtvM
         8Qj19DH20A1oZKnG7MX2j5WoLieSx3a7cu0knNDv8hmxSNCZkO+O0zdYDPAyi8aaUqtV
         Ztb6LBpaqkh2eu95ObfkgfdFCSPMlZ/FAJlZlf1n1Q2N1xf3JlefFOltZqsDodfm+dlx
         9aRXQv8QPTphjBgBFjOscINux/eQaQkbSa+aqWNf+3LvIzLXNqBd3RlH6hZi8I0yS8m2
         v30g==
X-Forwarded-Encrypted: i=1; AJvYcCUUVeHx9F6s3sXqJv50Sp4FwDiiLw7+hCCmdDRJsqM8egZF9lN15LdwrTCoH0LKniADaL95OuNBRoJNWHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvHyLSN6qhDyDM6YfS1qAw6RVAkGX59DynO5PTdfUktNsgVD9E
	gs/9U4+0DfbNZjREejSgeHQB2bCn2eSwU+DlWw5tv0wDgt+uFEC6+mZZmNbG7g==
X-Gm-Gg: ASbGncuQEQ7za8HxC/1LEHUhN0udWurUpvE7erU4xVb39EUEI7vIEvg1bTKDSer7UgN
	TS8pQ4mPcf+8mtkVhFy51NdTfo8SpVW+54vHd7ZIvPSWm/a+zCwEkquEu/v2S+fs9fz6poIQ8V9
	AdoQK17wSKGcwWNUX6YZ5kIphLy07aujUFS+oYne7ZbegPO3AhUWiKdLCLwptr74ds6xdPJljHU
	/yjzdBrdFv2VDBrWrUMq+EqAsSLqUAgsg7gXl5Uv0uu+0NEUlTzhz7G0O3P7vUmlhxyOyCpX7M4
	Gu86HA8pfxP1IB3Bgh77atGTAJd1/8ju0y6j5Z3aEi8=
X-Google-Smtp-Source: AGHT+IHuT5Q8Sx3B+XRIeJFH5Nv0x7Ff5aMv5XHIeldVLfzmgtrOAgutMuXojagHXaBw8zQjZMqy/A==
X-Received: by 2002:a05:6402:254d:b0:5e4:a88a:657 with SMTP id 4fb4d7f45d1cf-5eb80fcaeb0mr162425a12.28.1742330793244;
        Tue, 18 Mar 2025 13:46:33 -0700 (PDT)
Received: from [10.2.1.132] ([194.53.194.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816968bfbsm8049409a12.17.2025.03.18.13.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 13:46:33 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <c0435964-44ad-4b03-b246-6db909e419df@jacekk.info>
Date: Tue, 18 Mar 2025 21:46:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] e1000e: add option not to verify NVM checksum
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Many laptops and motherboards including I219-V network card have
invalid NVM checksum. While in most instances checksum is fixed by
e1000e module or by using bootutil, some setups are resistant to NVM
modifications. This result in the network card being completely
unusable.

It seems to be the case on Dell Latitude 5420 where UEFI firmware
corrupts (in this module's sense) checksums on each boot. No set of
BIOS options seems to help.

This commit adds e1000e module option called VerifyNVMChecksum
(defaults to 1) that allows advanced users to skip checkum verification
by setting it to 0.

Signed-off-by: Jacek Kowalski <Jacek@jacekk.info>
Cc: stable@vger.kernel.org
---
 drivers/net/ethernet/intel/e1000e/e1000.h  |  1 +
 drivers/net/ethernet/intel/e1000e/netdev.c | 22 ++++++++--------
 drivers/net/ethernet/intel/e1000e/param.c  | 30 ++++++++++++++++++++++
 3 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index ba9c19e6994c..61dcc88dd2ff 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -461,6 +461,7 @@ s32 e1000e_get_base_timinca(struct e1000_adapter *adapter, u32 *timinca);
 #define FLAG2_CHECK_RX_HWTSTAMP           BIT(13)
 #define FLAG2_CHECK_SYSTIM_OVERFLOW       BIT(14)
 #define FLAG2_ENABLE_S0IX_FLOWS           BIT(15)
+#define FLAG2_VERIFY_NVM_CHECKSUM         BIT(16)
 
 #define E1000_RX_DESC_PS(R, i)	    \
 	(&(((union e1000_rx_desc_packet_split *)((R).desc))[i]))
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 286155efcedf..b99b22dcaba4 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7567,16 +7567,18 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 */
 	adapter->hw.mac.ops.reset_hw(&adapter->hw);
 
-	/* systems with ASPM and others may see the checksum fail on the first
-	 * attempt. Let's give it a few tries
-	 */
-	for (i = 0;; i++) {
-		if (e1000_validate_nvm_checksum(&adapter->hw) >= 0)
-			break;
-		if (i == 2) {
-			dev_err(&pdev->dev, "The NVM Checksum Is Not Valid\n");
-			err = -EIO;
-			goto err_eeprom;
+	if (adapter->flags2 & FLAG2_VERIFY_NVM_CHECKSUM) {
+		/* systems with ASPM and others may see the checksum fail on the first
+		* attempt. Let's give it a few tries
+		*/
+		for (i = 0;; i++) {
+			if (e1000_validate_nvm_checksum(&adapter->hw) >= 0)
+				break;
+			if (i == 2) {
+				dev_err(&pdev->dev, "The NVM Checksum Is Not Valid\n");
+				err = -EIO;
+				goto err_eeprom;
+			}
 		}
 	}
 
diff --git a/drivers/net/ethernet/intel/e1000e/param.c b/drivers/net/ethernet/intel/e1000e/param.c
index 3132d8f2f207..8711eb10dd11 100644
--- a/drivers/net/ethernet/intel/e1000e/param.c
+++ b/drivers/net/ethernet/intel/e1000e/param.c
@@ -127,6 +127,15 @@ E1000_PARAM(KumeranLockLoss, "Enable Kumeran lock loss workaround");
 E1000_PARAM(WriteProtectNVM,
 	    "Write-protect NVM [WARNING: disabling this can lead to corrupted NVM]");
 
+/* Verify NVM Checksum
+ *
+ * Valid Range: 0, 1
+ *
+ * Default Value: 1 (enabled)
+ */
+E1000_PARAM(VerifyNVMChecksum,
+	    "Verify NVM checksum [WARNING: disabling can cause invalid behavior]");
+
 /* Enable CRC Stripping
  *
  * Valid Range: 0, 1
@@ -524,4 +533,25 @@ void e1000e_check_options(struct e1000_adapter *adapter)
 			}
 		}
 	}
+	/* Verify NVM checksum */
+	{
+		static const struct e1000_option opt = {
+			.type = enable_option,
+			.name = "Verify NVM checksum",
+			.err  = "defaulting to Enabled",
+			.def  = OPTION_ENABLED
+		};
+
+		if (num_VerifyNVMChecksum > bd) {
+			unsigned int verify_nvm_checksum =
+				VerifyNVMChecksum[bd];
+			e1000_validate_option(&verify_nvm_checksum, &opt,
+						adapter);
+			if (verify_nvm_checksum)
+				adapter->flags2 |= FLAG2_VERIFY_NVM_CHECKSUM;
+		} else {
+			if (opt.def)
+				adapter->flags2 |= FLAG2_VERIFY_NVM_CHECKSUM;
+		}
+	}
 }
-- 
2.39.5


