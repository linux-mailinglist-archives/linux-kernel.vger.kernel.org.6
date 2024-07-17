Return-Path: <linux-kernel+bounces-254573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAE59334D9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 02:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2031F22CD9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 00:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8854610A1C;
	Wed, 17 Jul 2024 00:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IQEtIZwq"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D91AD21
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 00:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721177497; cv=none; b=S7qbdEusi/k2DmJIXlx1f9fi5g390I8+RnHR+b6lUWuhyDuKGzbxLQljVunb4GxDaxiRUja/GMOpNP7U5HBX6bJkjXOGRCq2qeCiyOjHMu7hSZkY9Ebmc6H9WMIC0FXPCmapUsBKZuxUkAKmptAtov2W83Gw/VgINkwXWR1pXW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721177497; c=relaxed/simple;
	bh=TxBuHJK85vkREbw0WLP5ADupaB4b16I7uMojTYknRa8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V9YJX2g8nYnrkcEp4+gIp1NqUzqG/VXfczfHuBAG9EL3MMv/IqnAN2edSLcvoR5heNYSuvqbu1Cb+2UqRTgFkKu3aVE+pldzcXLVMomqAfNc9ZYnhcM6q9dZNERPVSVb2omjQyQVbzyo+E7zceyRUJI3gioXyrJcGmWGGGnTuXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IQEtIZwq; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-664aa55c690so11263097b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 17:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721177495; x=1721782295; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HTO1tsJpanrsIXuREfXU+lZcoE2mxE9RW1fzcKxRuPY=;
        b=IQEtIZwqThfL2tkpbppOAJIWrEBFeGp3JwQsUjLtFGvkKsUrCT2pEDg7MyBBoxyUGt
         ZxUx4caN1wQfl7C4IqBbD0err8tciyYKAN+fRjlQ0V/0ez+9/DnETUu1YAOkrXOXH/jn
         8Fg/+yy7AAraMqKS8laXtfRbjiMdBgWsZFn2+DHpJwlmnc74Uav7A8q5+WLs2m4RAkl3
         88+Y5ECH4bCBGSqBtID+FiQsBaAyskBiKCFBst4Gxzw4Rds1vSrfTNk89/5aUCg0q0eR
         EX4d0r7RJkPtjJH+KAZNbiq2sN/C6DjhZ1HCSjTmKSkzSlxirdTo/f/gihcOZOuDeMHf
         M//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721177495; x=1721782295;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HTO1tsJpanrsIXuREfXU+lZcoE2mxE9RW1fzcKxRuPY=;
        b=dIlCFjD7eOF7m64RDDB4GnHRMtVMMNj30nZup3if/5NMb9cM/1qIn374q4kFScEY7G
         mPxlVJVCzhYpNefYNH8Px4ZlygQ2eO4UU0YPV3P0J/X2koSzVkWBtUT9jYlLzlUO/d4c
         3p5sx1bRM1PfTUbF+bazHFTMhrwemE7YVd2Bdow+QQMTPjHPR3HeR4p5ykczV01iRDpp
         Hag3qs0vKZtFgPshUbpX+2q4X6cBu9Hvall5fiElblpNE6ohD81vkRjfQv9BAcn2yQxW
         +y4maubpaXViKoWnRWVQYOuCvFSXM0TEQPeRjzuBGeOK0u1Req1L6n0XqAq4gxVaoCGo
         c0rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsIOY0siUTyHvxseQVyjtzT9Im4ncDZ2Qc/wGDqucbSZPAEYkL3BGAy0kdXM2uNrwIocxtzJwc5c/1Wz6PLJQfZBxYOEgje55AgWRB
X-Gm-Message-State: AOJu0Yyhi52z0SAy+5UiFWjSByKhTmQ37il81Jcdpr9wBggoRdXOaXzG
	P03ULNC7XCxFcSMrJEwtcwnC2teQB/uWUGAr32snzb064Lg2hmlbrIhibpak4WbTKUbVDy43COj
	NvQ==
X-Google-Smtp-Source: AGHT+IGg09Ayrrw6aRkughQryryAOlXFSVSJLvjMGLhBlG76jIsoZGI0TJ101PkcfAxrh48DyXAxTN6wUSc=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a05:690c:289:b0:65c:4528:d8ee with SMTP id
 00721157ae682-664ff0079f7mr6537b3.4.1721177495402; Tue, 16 Jul 2024 17:51:35
 -0700 (PDT)
Date: Wed, 17 Jul 2024 00:49:49 +0000
In-Reply-To: <20240717004949.3638557-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240717004949.3638557-1-jthies@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240717004949.3638557-5-jthies@google.com>
Subject: [PATCH v1 4/4] usb: typec: ucsi: Fix SET_PDR typo in UCSI header file
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, bleung@google.com, abhishekpandit@chromium.org, 
	andersson@kernel.org, dmitry.baryshkov@linaro.org, 
	fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org, hdegoede@redhat.com, 
	neil.armstrong@linaro.org, rajaram.regupathy@intel.com, 
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fix SET_PDR typo in UCSI header file.

Signed-off-by: Jameson Thies <jthies@google.com>
---
 drivers/usb/typec/ucsi/ucsi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 57129f3c0814..375f1881c1e2 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -152,7 +152,7 @@ void ucsi_connector_change(struct ucsi *ucsi, u8 num);
 #define UCSI_SET_UOR_ROLE(_r_)		(((_r_) == TYPEC_HOST ? 1 : 2) << 23)
 #define UCSI_SET_UOR_ACCEPT_ROLE_SWAPS		BIT(25)
 
-/* SET_PDF command bits */
+/* SET_PDR command bits */
 #define UCSI_SET_PDR_ROLE(_r_)		(((_r_) == TYPEC_SOURCE ? 1 : 2) << 23)
 #define UCSI_SET_PDR_ACCEPT_ROLE_SWAPS		BIT(25)
 
-- 
2.45.2.1089.g2a221341d9-goog


