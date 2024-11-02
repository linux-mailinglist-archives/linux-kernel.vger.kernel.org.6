Return-Path: <linux-kernel+bounces-393478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7888C9BA124
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 16:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D262282334
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 15:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2ADE1A76D2;
	Sat,  2 Nov 2024 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfVP/+Gg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7181A76A4;
	Sat,  2 Nov 2024 15:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730560965; cv=none; b=drDri/ndikDGYMW5inRRlddMECj4pfD/TMUcZsKxeXE7HDDx7X2NaAFEu9p49ZUFqO/VWSoh9Lxz7XW5kxjWx0lrpubAAmzBGh1kwQ1fQg/AaG/T1WOxqDC9B/l1BHbfH1HqlwO/ITDZ3Y8NHcJ8exts0pq9gzIMYzvkg4WnmrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730560965; c=relaxed/simple;
	bh=0E9FnIba8YISVBF+XObPqZLXOvidxbgGlojWB3QDDq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZpI65AQ4zYIpSEGOrTl8IZwrQI0nkFQ4gS9kMvyUvsEcAbKJ89CKdAcx9hPbkaSGBZatfly+jC3uscYq4eKPb7wkSyminqY5s2DcX7v9o9sR/lLbr5xorf/QSKuaLceMpXdwoFGY/Q0EQFxpDISqulI9wUmNi3a4hWHPdDfbtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfVP/+Gg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25165C4CEC3;
	Sat,  2 Nov 2024 15:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730560964;
	bh=0E9FnIba8YISVBF+XObPqZLXOvidxbgGlojWB3QDDq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dfVP/+GgKMm4traXec6be5eA47h3+DDTJruujarYcMUTHAgoMNoywWxUY01oE8qNn
	 kY//7xOdxM4eiJNIDu803d3Q9uCwj23H5TAV8n18Ax834PVB5Vn9wYgGb7sKalph55
	 yhMIGMKIweluOI6cMFmMirk18Be3LXlCCnLddG9mZYqYwAp1ArVW2DLli4ObI9+9/P
	 pVFZCZjrmoNXrXednHOnmNP7uv0Xi5BbTxIu3g5EGwRjusjcm6FdL7UHz0DG25cOPZ
	 fajYr86TzV2g9nadkcZQZOXupeP+A+4FF5AJ69Ck/rTavvL5h5CvBTo6DjCcPcaq5b
	 1YikpFZnWwcSA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: x86@kernel.org,
	"Daniel P. Smith" <dpsmith@apertussolutions.com>,
	Ross Philipson <ross.philipson@oracle.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-integrity@vger.kernel.org (open list:TPM DEVICE DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH 2/4] tpm, tpm_tis: Address positive localities in tpm_tis_request_locality()
Date: Sat,  2 Nov 2024 17:22:19 +0200
Message-ID: <20241102152226.2593598-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102152226.2593598-1-jarkko@kernel.org>
References: <20241102152226.2593598-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

Validate that the input locality is within the correct range, as specified
by TCG standards, and increase the locality count also for the positive
localities.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm_tis_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index c58f360fb4a4..c86100ad743a 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -234,10 +234,13 @@ static int tpm_tis_request_locality(struct tpm_chip *chip, int l)
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 	int ret = 0;
 
+	if (l < 0 || l > TPM_MAX_LOCALITY)
+		return -EINVAL;
+
 	mutex_lock(&priv->locality_count_mutex);
 	if (priv->locality_count == 0)
 		ret = __tpm_tis_request_locality(chip, l);
-	if (!ret)
+	if (ret >= 0)
 		priv->locality_count++;
 	mutex_unlock(&priv->locality_count_mutex);
 	return ret;
-- 
2.47.0


