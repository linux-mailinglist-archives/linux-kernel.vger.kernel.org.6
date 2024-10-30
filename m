Return-Path: <linux-kernel+bounces-389602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 069EF9B6ED8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF3EA2817D8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B2C219487;
	Wed, 30 Oct 2024 21:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fJKXZMMo"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11100218595
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323758; cv=none; b=q3f9rA9MQICpeSwBvsTL7kHQh4SIvJq5aD67uTNIiB8Qd1IQTcRo4ZGUSgtp3ANHPf10rdPG4Cq7Jsx3B6lrB/jiaLP14L49VnoxLybnrdjr5qCvZ5rOPqXHoUNZUQprtr+lYxHzT/SfcM/wA5383E2EVf1VYN4gSyrnLTT05DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323758; c=relaxed/simple;
	bh=hAp/Wgn9qETJ9JtmrJOl57caWyJEtC39CrlS/6VnGMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eFUqfpe5c0heRnhEavLyTARgpnoem/dPVMGxOUvnxSZykNVwT6GvYxuYFgU2h2zIJLW3F+LbfAg7oxThC8fx+Z8pqWm0PPBHyqFBr0QLX96pALisLBmshxZwRk+TxtzGJ5BlIYnHHTQ6w0J9dZUi72//cSTQUlKIwiLdhPdd3SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fJKXZMMo; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso2971275ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730323756; x=1730928556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1LFW748m48R3d4nGBRyW7y9JsiXUpIXaqKR2jh3vhg=;
        b=fJKXZMMoHhvpokEchR1lVDqSuAxz4eWJGDhOaTZGy006iHjzUHfISO0faYL1jRof1Z
         HON2I0G0i8OpZf9P688gDiL4P4s5xnu1/YEapLu3NEL9sY0jK5bxhr3sMHNqF1j1YZbG
         V3Ga4uL76reu89/D9+w5SFlETWmpCeWH8PJA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730323756; x=1730928556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1LFW748m48R3d4nGBRyW7y9JsiXUpIXaqKR2jh3vhg=;
        b=Qf4elP+tfBflrHGAq4IcHntUofFdId5PdsgxSaRHPwKT36aIdPtEIWm/YLbLvHjT+u
         IyCpMeXMr6D0btHFHxvsG/6rT9XfE4x/cq8Wog/6wOMoreVSGT7R6voxzKR0N34CLIQw
         oEwqztP8X4pI+3PWws+Qr7/U6gXXharVtvzrsxkzYRhMz/HefRXuTBr1fCE85XIEb7dY
         MkoUFfw0AWmJOFqj46Zxq5g3cnWFduhAom/E9vwWPMICCQU868Al7kCFu1kaY9pcqnWZ
         CohbMcLH3dmhkkqm2zL6IrzmAt0shnvvHmdBXCCT5yJfvY1dmlONpqwv/VRat6bQsxeY
         Vkpw==
X-Forwarded-Encrypted: i=1; AJvYcCXzvM2Nxk+eU/6PYZm0+rPAfi967jH6GYxwqYh7xiilGbD1DdM0xVdbOvX7Pqp4E5aiTOO9VfFXM5RB1xA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9frVPYdQusH9Pw5YKavdBXyAZ7a8RoFXbGZT43aUMGj6+J772
	A/+JosnTF37V5vmqWCgkrzWqlEkkh4ooThjNWmqmYOjEdt7TTrzYGqubQWD3K5H+L7ypuSCSNiM
	=
X-Google-Smtp-Source: AGHT+IH/KrpwE9PQHVPUqWJzTKYOAjHoclvbrW0UAtqgCiIc5SyQ/Ee9JadYFBZqNKDKLFyOZzsbDA==
X-Received: by 2002:a17:902:d544:b0:20c:7181:51c7 with SMTP id d9443c01a7336-210c6c8ff93mr235487335ad.52.1730323756367;
        Wed, 30 Oct 2024 14:29:16 -0700 (PDT)
Received: from localhost (198.103.247.35.bc.googleusercontent.com. [35.247.103.198])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-211057d833fsm335115ad.261.2024.10.30.14.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 14:29:16 -0700 (PDT)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: heikki.krogerus@linux.intel.com,
	tzungbi@kernel.org,
	linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev
Cc: dmitry.baryshkov@linaro.org,
	jthies@google.com,
	akuchynski@google.com,
	pmalani@chromium.org,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] platform/chrome: cros_ec_typec: Disable tbt auto_enter
Date: Wed, 30 Oct 2024 14:28:38 -0700
Message-ID: <20241030142833.v2.7.Ic14738918e3d026fa2d85e95fb68f8e07a0828d0@changeid>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <20241030212854.998318-1-abhishekpandit@chromium.org>
References: <20241030212854.998318-1-abhishekpandit@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Altmodes with cros_ec are either automatically entered by the EC or
entered by the AP if TBT or USB4 are supported on the system. Due to the
security risk of PCIe tunneling, TBT modes should not be auto entered by
the kernel at this time and will require user intervention.

With this change, a userspace program will need to explicitly activate
the thunderbolt mode on the partner in order to enter the mode and the
thunderbolt driver will not automatically enter when a partner is
connected.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v2:
- Only disable auto-enter for Thunderbolt
- Update commit message to clearly indicate the need for userspace
  intervention to enter TBT mode

 drivers/platform/chrome/cros_ec_typec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 3e043b1c1cc8..aadd2704e445 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -313,7 +313,8 @@ static int cros_typec_register_port_altmodes(struct cros_typec_data *typec,
 	if (typec->ap_driven_altmode) {
 		memset(&desc, 0, sizeof(desc));
 		desc.svid = USB_TYPEC_TBT_SID;
-		desc.mode = TYPEC_ANY_MODE;
+		desc.mode = USB_TYPEC_TBT_MODE;
+		desc.no_auto_enter = true;
 		amode = cros_typec_register_thunderbolt(port, &desc);
 		if (IS_ERR(amode))
 			return PTR_ERR(amode);
-- 
2.47.0.163.g1226f6d8fa-goog


