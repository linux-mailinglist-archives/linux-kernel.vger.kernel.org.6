Return-Path: <linux-kernel+bounces-228115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB67F915B19
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 02:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 591021F22859
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E048610788;
	Tue, 25 Jun 2024 00:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p71QgWx7"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BA64C80
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 00:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719276378; cv=none; b=fKTqrglYznn01tZ06L2GhBcg0+UyXsTC6ECkyMU4OGYC0RnMdrBMQnN8xxkYopKiWcTyKYO9RdJyIdIz73eLQA17Lkl/fQmz5A7ly+H6D2cxqDtgYtTv29Hm26ckd37uV7hJs4qrEvmHm3heqRUWFNQ0iHfBx6LwgyJ6CeeBG3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719276378; c=relaxed/simple;
	bh=PhO04b5vnwj1IYmCREjtGGMauS7EuNjizsSLyOjqKtA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HNtS4zyoudJFXZDKxq171Une6zu8hSDqTbqVsJvSkGYCSlqLEQNqsNIwST9yG4NGpGme2KV55DGSk5T1DxQcpm8Ht+3CTem5Pz359iN3Grua3Y4IVRyJN5OumIQqy5363TksXL60vpZtk69N3NELV9wKFSncybD1g7Oc3H/NW48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p71QgWx7; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-63c418df767so111297607b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 17:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719276374; x=1719881174; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qaF4lRrKmjcDJPUizuhtYrRFMMSSSEUx2z4AL3XH5xQ=;
        b=p71QgWx7ykVC4S49NfbKXPpQedR5V579mKIWhWhtCCSvlqhIBy/TYFsFU1kyAoOTGN
         WVzjoZ3Lw57C8q3fV5odOSBxmjUs6YB3/pBmy517kWhJS3n7dGEAYaj+YFvB+cid8xPj
         2W3PiZHmRciqxvJjNJ+QsqaKvzEyOfomGFT4n2eFWecimJJ2g/YMOFyjuN8g2AU8T/Tk
         vB+euDIkI654wxmFfhX8nly77mLikwFd74don6EBuehvYMFQ6tj7x+GsrfHXKJ7aA7+W
         C8+PScyvLOCfLkyZZa6E3KmRUiPgmuz935+43k78uggqhEoNZxlSv73nW1GuxfjxRWWe
         aPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719276374; x=1719881174;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qaF4lRrKmjcDJPUizuhtYrRFMMSSSEUx2z4AL3XH5xQ=;
        b=ttMDyYhhtl2+uW6UY+3DeW3IiZEKYhfzzF390hyR+R4KtgQVFM4qAzniNE1GpRa2y8
         K0lGBDNl0NcWpXnp/hkDSCVvum3XB1E8I4DWTU5myVtU8v80FH24GGUUeGpvhSIf1T8X
         9VSUkXCoyugcYEhrWKNYw28OuV3uf0f2lvsz/NX02iaU0y/rUDy0+AJSt7IkvK+QEFSH
         uu3VvkeJ8QuRWWzfv1LudpeOFIFz4ZNZF/We76HI759qA3PrYGZW0QOye53O/vTvE0nn
         NTnV417uJki46YxeYZE+R1Az8m3SIuc1PQGV3HuSMKetpLahRqB2nfTF8lE3Ta6nvEjp
         ssQA==
X-Forwarded-Encrypted: i=1; AJvYcCWEPlQH6M5kTpFfBNJBxm5zvxWhyH+sCLhqUQLsKzpLVtu5f60/AgXklYRk9Qc5qYTuVl9LRNkp9lsMkjM5IZkMgv4yKOl/9JXdHDZL
X-Gm-Message-State: AOJu0Yxur/eFDfcGqcsibd0dtbaxHLInO/d0MAzEXhutkrcsSdPhtKA+
	AxJ0yadyVNzrqYgYXr6jg9CBgLIeIX4gtceWRS3O4sPQR0y1CskX4GU9MFDIZHY2gzbq07Jw+By
	WOQ==
X-Google-Smtp-Source: AGHT+IHJbHp56R2XaZLyd8wT2oNqKkZon5G2CAy830vus2Bf7IvtvXG0WYkDzWAg9RB4Gf9zk4i+Nbk0E7Q=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a05:690c:7001:b0:62c:c5ea:66ad with SMTP id
 00721157ae682-643ab54d839mr6464827b3.4.1719276374559; Mon, 24 Jun 2024
 17:46:14 -0700 (PDT)
Date: Tue, 25 Jun 2024 00:46:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240625004607.3223757-1-jthies@google.com>
Subject: [PATCH v1] usb: typec: ucsi: Only set number of plug altmodes after registration
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, jonathanh@nvidia.com, bleung@google.com, 
	abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Move the setting of the plug's number of alternate modes into the
same condition as the plug's registration to prevent dereferencing the
connector's plug pointer while it is null.

Fixes: c313a44ac9cd ("usb: typec: ucsi: Always set number of alternate modes")
Suggested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Jameson Thies <jthies@google.com>
---
 drivers/usb/typec/ucsi/ucsi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 76c48d873b2a..77e46bf4a098 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1180,13 +1180,13 @@ static int ucsi_check_cable(struct ucsi_connector *con)
 		ret = ucsi_register_altmodes(con, UCSI_RECIPIENT_SOP_P);
 		if (ret < 0)
 			return ret;
-	}
 
-	if (con->plug_altmode[0]) {
-		num_plug_am = ucsi_get_num_altmode(con->plug_altmode);
-		typec_plug_set_num_altmodes(con->plug, num_plug_am);
-	} else {
-		typec_plug_set_num_altmodes(con->plug, 0);
+		if (con->plug_altmode[0]) {
+			num_plug_am = ucsi_get_num_altmode(con->plug_altmode);
+			typec_plug_set_num_altmodes(con->plug, num_plug_am);
+		} else {
+			typec_plug_set_num_altmodes(con->plug, 0);
+		}
 	}
 
 	return 0;

base-commit: 819984a0dd3606b7c46fe156cd56a0dc0d604788
-- 
2.45.2.741.gdbec12cfda-goog


