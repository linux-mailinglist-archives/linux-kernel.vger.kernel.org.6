Return-Path: <linux-kernel+bounces-190226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D66978CFB9F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B861B2148D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AA65B1E4;
	Mon, 27 May 2024 08:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="DOoj805X"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F7A5FB9A
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716799028; cv=none; b=fLhZAidoCv0Qj7OMCh6mlieVMePF1Cl5BzH0gS2zb7tDfpnwj7KRNzZPQGXtFJGTgu0GeSL2ESof+w05/hnqLFNiz8FOF67hgo+r6KIxpp40YFlvUVKfRqs0NApvwRUM2vwzy43i3d8twCpsQeMQx5Po3dY7Crd+fMJrnIo4uVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716799028; c=relaxed/simple;
	bh=RbipRVg2tNyaG/cNib+sJw6bO31urPkoIZPQqa/oGQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jKj8fdahgF49gKNZ9/UEyIqhqOcrK/rmCTYDj9S/5+H810k6vDLyNs37yM1YvZzxO32H6IZ0CeOnspkOxwSwzyZ6dY1ZJtHT7CLOZF7cgXnK9ZxSNTHyQ2Zg5UXyMALpfUc7CTuz+WN9ahmUGP2qz6+qC8UQ/HRW8Im35nX72Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=DOoj805X; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6266ffdba8so210729766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 01:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1716799024; x=1717403824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ewc2LUQ94iYhmeL+MlQNu0aDN9jkcSs6LpUL6X+zlA=;
        b=DOoj805XSVFbKD3bZVlHXVl8s32C7iAYJCcCknY/L3SNIeVgbM5YvY9q6fuOkl4N0S
         Ia/23DbBjbuhibIq0rAadV99BO2SMFXQaD7sL1CrI8h7n8d+2H8Amm/3Bw2oInRoxMKu
         8f+l83vPRHrjaBDT1x3ceLWHPSXhy8U4zXb1Freno6koiRkPG9ryFTnScaIMO0kNOi7W
         yx0vU6cifcDLlUW/Nd45FT/QycyQcbFgtVwmhXdEia0zN8wofoB7G2PXP7PX6L/4Mjbh
         Ebc5riB/8hqyq7JzhzcIsVe2dyElc/T6879XDZNChMhDSvWV89O0qmCSnmbDgLGmX+3t
         UggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716799024; x=1717403824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ewc2LUQ94iYhmeL+MlQNu0aDN9jkcSs6LpUL6X+zlA=;
        b=rNSwhy6WLMGhngHgQ4843F1gF1jfW7fld50CRkayCWM6edalFbmv1u7w+vXeZabvRi
         JSWDA2q1BVOSNm+HpSA547UKaVBKW1R4a/Kcynmc0JlFGadhPA1ZHj9aGZYgvEpSRPmW
         VBBONHDSe1UMBhbojAxl2Cj08pjr8CIXKyIMcQ+XrTA0+2/9wtAJHIZkRlOp1ElCdqnZ
         0f6MB94CZO4nnUk1lylH50xRC5LgHzCReeaaB88aIgpbN1AVVVLDYlnFSQhK+9cxiQRP
         3qnvZPoCporxZ1Qz8SWes/hN3eGCVmSqWhIqaJA1HazuAKNUmoO9QPDj83euS+srf1LT
         zheQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZEYzFe0HVjpx1g7Wb88TYVotUVh8q9LlgsCd/UKqL56FpPgCZHn6ap7hIjJVbBq8OyjyoaMzSHCOz7rWI6KGqPUSJbboZn7CvOLyM
X-Gm-Message-State: AOJu0YyNL5vWdI3drFlTM0xRd3raME3yG0SBDm7XDo1D6bPbJbGGxWqx
	xSAR9c/2NZ9tWxU4/mFnHSjCqJXTRieyv3x0C78/72C4nHaTKE8mqv8cKNpY8VU=
X-Google-Smtp-Source: AGHT+IGZ58gmMolIHMHhK1a1HogNCuIa2Saz0HAtP5KiJLECmvcEN4FxWyc89b3s9DUSyiyQJ3gt8w==
X-Received: by 2002:a17:906:2a8b:b0:a59:9b8e:aa61 with SMTP id a640c23a62f3a-a62643e1448mr582253266b.35.1716799024362;
        Mon, 27 May 2024 01:37:04 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a62f546025esm91292366b.56.2024.05.27.01.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 01:37:04 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: markus.elfring@web.de
Cc: Shyam-sundar.S-k@amd.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	thorsten.blum@toblux.com
Subject: [PATCH v2] platform/x86/amd/pmf: Use memdup_user()
Date: Mon, 27 May 2024 10:36:29 +0200
Message-ID: <20240527083628.210491-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <50d10f0b-d108-4057-be9c-a90e2398e810@web.de>
References: <50d10f0b-d108-4057-be9c-a90e2398e810@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to memdup_user() to overwrite the allocated memory only once
instead of initializing the allocated memory to zero with kzalloc() and
then immediately overwriting it with copy_from_user().

Fix the following Coccinelle/coccicheck warning reported by
memdup_user.cocci:

	WARNING opportunity for memdup_user

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Update patch description after feedback from Markus Elfring
---
 drivers/platform/x86/amd/pmf/tee-if.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
index b438de4d6bfc..1b53cabc9aa2 100644
--- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@ -301,14 +301,9 @@ static ssize_t amd_pmf_get_pb_data(struct file *filp, const char __user *buf,
 		return -EINVAL;
 
 	/* re-alloc to the new buffer length of the policy binary */
-	new_policy_buf = kzalloc(length, GFP_KERNEL);
-	if (!new_policy_buf)
-		return -ENOMEM;
-
-	if (copy_from_user(new_policy_buf, buf, length)) {
-		kfree(new_policy_buf);
-		return -EFAULT;
-	}
+	new_policy_buf = memdup_user(buf, length);
+	if (IS_ERR(new_policy_buf))
+		return PTR_ERR(new_policy_buf);
 
 	kfree(dev->policy_buf);
 	dev->policy_buf = new_policy_buf;
-- 
2.45.1


