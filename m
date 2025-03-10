Return-Path: <linux-kernel+bounces-554181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4868A59416
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D3E2188931A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A64223714;
	Mon, 10 Mar 2025 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="oNVZNyOe"
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475B314F11E;
	Mon, 10 Mar 2025 12:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741609211; cv=none; b=m0un5C3fXNw+wCMP/DUiH0lrxEdGrrVUPvxPJShfm79GaaWGnEsErDECWqs50zB44XlJkOOEk7Hes2L52/eUBEVHKRdq6YKskj8MnvGFFo7T6a+LXiruRJQDN3tumaSdzabIzUV4lVB9Ljn99KxeSi94s5VOcI3IoAwxEw6Wz14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741609211; c=relaxed/simple;
	bh=D345LRq3bdgwgLdIgf4ibIIQK43XnRCm1Jnw5lxJB0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NyLRvAGlR7HkpFatmKgkQekf5puC9BTxDXnQVWgcKv57qq5l1RZ3b3ENV5cXsW2dV+9J+qB5wVLQ8kKT+HrageamWqwlu3Dvd2K16QfZhlLEgAsiahDBiuPu8uSWU/xbYIpq9Jl36JNIZHeMbNKNkwJyUz1AWzCoIUuZ/nuQaT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=oNVZNyOe; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=KSjT+hQVoMfaSSrHYNtWxh3wtoU4L9qucOgNsgeUwtE=; b=oNVZNyOeYnRNFjUJIw7TFB1GQ0
	mgMXMzYLMHS1uBjaCA//J81gS9b1nqwePBk8D7TCg5oZ3OeGY0A8UFBulcqz0zDL98EFVBB9tI0Ey
	8qz7h7MhT5/AT36LgWEotxCpPfn82Ic+kvU/NWjErwvWgTQvUHhXWMxJDpzHnWjjevd1bRYarNzVv
	E1sDkhhZzJ3LUAWElS046yRk8ZqbnAZfO9+cQ6ru/ngoJDjgWp5V+ESJe32FbT+qCHTUbd4Ffq0+1
	FMEFPJkl/GGlEK0rF9C6GHfmfrkdxR62dxMg8tJJVgyNv0UlE44GU7fWZ/2X4L4qW98z/mdlIlDal
	PWd7Snag==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1trc6t-00GUvz-1r;
	Mon, 10 Mar 2025 12:19:55 +0000
Date: Mon, 10 Mar 2025 12:19:55 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] tpm, tpm_tis: Workaround failed command reception on
 Infineon devices
Message-ID: <Z87Y69l5_GbzlLfp@earth.li>
References: <Z8lkSKOqBgt78pU2@earth.li>
 <Z8ogT_gERUYstPbK@kernel.org>
 <Z8sgfMmsfn894yLj@earth.li>
 <Z8sixTuKG5sxO-D1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z8sixTuKG5sxO-D1@kernel.org>

From: Jonathan McDowell <noodles@meta.com>

Some Infineon devices have a issue where the status register will get
stuck with a quick REQUEST_USE / COMMAND_READY sequence. This is not
simply a matter of requiring a longer timeout; the work around is to
retry the command submission. Add appropriate logic to do this in the
send path.

This is fixed in later firmware revisions, but those are not always
available, and cannot generally be easily updated from outside a
firmware environment.

Testing has been performed with a simple repeated loop of doing a
TPM2_CC_GET_CAPABILITY for TPM_CAP_PROP_MANUFACTURER using the Go code
at:

  https://the.earth.li/~noodles/tpm-stuff/timeout-reproducer-simple.go

It can take several hours to reproduce, and several million operations.

Signed-off-by: Jonathan McDowell <noodles@meta.com>
---
v2: Rename flag to TPM_TIS_STATUS_VALID_RETRY

  drivers/char/tpm/tpm_tis_core.c | 17 ++++++++++++++---
  drivers/char/tpm/tpm_tis_core.h |  1 +
  include/linux/tpm.h             |  1 +
  3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index c969a1793184..4ab69c3e103c 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -463,7 +463,10 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
  
  		if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
  					&priv->int_queue, false) < 0) {
-			rc = -ETIME;
+			if (test_bit(TPM_TIS_STATUS_VALID_RETRY, &priv->flags))
+				rc = -EAGAIN;
+			else
+				rc = -ETIME;
  			goto out_err;
  		}
  		status = tpm_tis_status(chip);
@@ -480,7 +483,10 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
  
  	if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
  				&priv->int_queue, false) < 0) {
-		rc = -ETIME;
+		if (test_bit(TPM_TIS_STATUS_VALID_RETRY, &priv->flags))
+			rc = -EAGAIN;
+		else
+			rc = -ETIME;
  		goto out_err;
  	}
  	status = tpm_tis_status(chip);
@@ -545,9 +551,11 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
  		if (rc >= 0)
  			/* Data transfer done successfully */
  			break;
-		else if (rc != -EIO)
+		else if (rc != EAGAIN && rc != -EIO)
  			/* Data transfer failed, not recoverable */
  			return rc;
+
+		usleep_range(priv->timeout_min, priv->timeout_max);
  	}
  
  	/* go and do it */
@@ -1143,6 +1151,9 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
  		priv->timeout_max = TIS_TIMEOUT_MAX_ATML;
  	}
  
+	if (priv->manufacturer_id == TPM_VID_IFX)
+		set_bit(TPM_TIS_STATUS_VALID_RETRY, &priv->flags);
+
  	if (is_bsw()) {
  		priv->ilb_base_addr = ioremap(INTEL_LEGACY_BLK_BASE_ADDR,
  					ILB_REMAP_SIZE);
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 690ad8e9b731..970d02c337c7 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -89,6 +89,7 @@ enum tpm_tis_flags {
  	TPM_TIS_INVALID_STATUS		= 1,
  	TPM_TIS_DEFAULT_CANCELLATION	= 2,
  	TPM_TIS_IRQ_TESTED		= 3,
+	TPM_TIS_STATUS_VALID_RETRY	= 4,
  };
  
  struct tpm_tis_data {
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 20a40ade8030..6c3125300c00 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -335,6 +335,7 @@ enum tpm2_cc_attrs {
  #define TPM_VID_WINBOND  0x1050
  #define TPM_VID_STM      0x104A
  #define TPM_VID_ATML     0x1114
+#define TPM_VID_IFX      0x15D1
  
  enum tpm_chip_flags {
  	TPM_CHIP_FLAG_BOOTSTRAPPED		= BIT(0),
-- 
2.48.1


