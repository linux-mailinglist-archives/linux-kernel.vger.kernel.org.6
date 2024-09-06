Return-Path: <linux-kernel+bounces-318007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF4C96E708
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 02:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C4D1F23D76
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC491799F;
	Fri,  6 Sep 2024 00:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E1jR/33C"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7E91BC2F
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 00:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725584288; cv=none; b=fbBnzm22oEwHiZavVnQMeIYh7xiN+tu8qI1yCczZqpenNL4WDMaFhASI6GH34kQ1wPTzy08Hasblhcvv+0XhbrSdD3BC+hGRHbJZHkX/2oHMgUdUPr8Loi3MW2w+HjTXPTt3ft8DwuK0xdZDTUtb4kwkS2uXPeRhlZ2/A8NBP2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725584288; c=relaxed/simple;
	bh=dY+RGFX+cNu9X2vO0IcaDdSj9wfnP28ZjHbh6T05zQU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eAiiIzh1zw6qjJcY9fY8H1ubnCcoe3Y/FC2so8c/4jOCxMYC8pF0iU2YWJ/4CcPxdz3FoJJmsDCrPeFOhkmdXF7pWVDvUf+p0HO6fewDUx+Mf2YmCz2aodSRl0Aglli2ostqSNlM/FlKMvpH+WReYq7wOJo6p2zYwUsmMqA8z38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--royluo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E1jR/33C; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--royluo.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e035949cc4eso3504704276.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 17:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725584285; x=1726189085; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZUr9RBTogku73PpkKtYXYUmUx+8qMZI1152dmkaX1tc=;
        b=E1jR/33CRoNd/D1dUy3lucYZ8nmj9hWbH8nXQms2qGhZO2xkjxfDvP6FD4FDOCSuik
         1eWkTmsIWSV2fCz9/F76F6hLO9g2+IM4xINR99NTBEYuK9mM0deOBXrVwPklVB5qikYO
         gyCq+v+D1LxE3hQ9E0jsj70GkHOzz3Rg4UZyRe+23uLuaw3tWKwQLglQmFwRW4+zbICs
         BE2wG31AKHASjX+1VDncNl2KcbfUVWzJKFppxzspqHirZjBTbYM4ANPfelACOaZFE8sB
         4Eyv1M2k8jhDOYlFscqm4QgWtBGycjh3fugGYQDrnW04Z2FhnxNvZlVuFmE+1R7a5k9h
         nVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725584285; x=1726189085;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZUr9RBTogku73PpkKtYXYUmUx+8qMZI1152dmkaX1tc=;
        b=er5UbcuAjfHoHJxAHtCfuR0WTNH5QeqFFlmVpokWm5lvwfwO1UCshOBYuQHX1ly6k6
         hzb9rZEQVLAUe6+T5YAkUVWbCt1tOijKNQBSltkA9x8o/d0CuzVLp91ja23Dx/Np+w8T
         gi7pcN3RqbQ/eFe3/0GqEy6sGmRTZmG3pv10gh5wHRXlawCQqA7bZ9DO+wz1RJubjnr7
         q8YxbH6wOmjE2t6Nm4+ETpx+oBy1uco2Py5U2yQ8HUoG+PRVmcZvdvbOhzK69Ce1k/5R
         C2Mrcz9stkhuT21dp+l3LHgDv5jIvT3HYLV/LVGHvE1+8bzKoRYAMFEvVSdUAfD1Cnr6
         fpUg==
X-Forwarded-Encrypted: i=1; AJvYcCUHmfgVKvQYrnJMFiiCGDnQOrAhd+d6o48hnPuJcOKn4lzjnt6STAbA9P7oiLeT2pHXnCE+GatgGeILkt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKe9P15LqE/cRBxoW7rwB2NwDgHBy4ey4WBgHa8OM7O1SaPwBx
	ztFmNj2veQk1QQodhFjpJHHfTippm9V0zSwtmPN0i6Uhf8ToCv6nte0NKvaWO4kazO/7Uhr2mmT
	XEA==
X-Google-Smtp-Source: AGHT+IFVaGdYnqoxmzpMhrlWdS8//ypdRlOXtb1ajgUGqzHC+RrjmGKaMalfJQrOLZyrYX6KIzs5g5zguF4=
X-Received: from royluo-cloudtop0.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:bb8])
 (user=royluo job=sendgmr) by 2002:a25:aa90:0:b0:e16:57bc:ac26 with SMTP id
 3f1490d57ef6-e1d3489de68mr2283276.5.1725584285560; Thu, 05 Sep 2024 17:58:05
 -0700 (PDT)
Date: Fri,  6 Sep 2024 00:58:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240906005803.1824339-1-royluo@google.com>
Subject: [PATCH v1] usb: dwc3: re-enable runtime PM after failed resume
From: Roy Luo <royluo@google.com>
To: royluo@google.com, Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, 
	badhri@google.com, frank.wang@rock-chips.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When dwc3_resume_common() returns an error, runtime pm is left in
disabled state in dwc3_resume(). The next dwc3_suspend_common()
should be skipped as the device is already in suspended state but
it's not because power.disable_depth is non-zero.
Ensures runtime PM is always re-enabled even after failed resume
attempts.

Fixes: 68c26fe58182 ("usb: dwc3: set pm runtime active before resume common")
Cc: stable@vger.kernel.org
Signed-off-by: Roy Luo <royluo@google.com>
---
 drivers/usb/dwc3/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index ccc3895dbd7f..1928b074b2df 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -2537,7 +2537,7 @@ static int dwc3_suspend(struct device *dev)
 static int dwc3_resume(struct device *dev)
 {
 	struct dwc3	*dwc = dev_get_drvdata(dev);
-	int		ret;
+	int		ret = 0;
 
 	pinctrl_pm_select_default_state(dev);
 
@@ -2547,12 +2547,11 @@ static int dwc3_resume(struct device *dev)
 	ret = dwc3_resume_common(dwc, PMSG_RESUME);
 	if (ret) {
 		pm_runtime_set_suspended(dev);
-		return ret;
 	}
 
 	pm_runtime_enable(dev);
 
-	return 0;
+	return ret;
 }
 
 static void dwc3_complete(struct device *dev)

base-commit: ad618736883b8970f66af799e34007475fe33a68
-- 
2.46.0.469.g59c65b2a67-goog


