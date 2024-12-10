Return-Path: <linux-kernel+bounces-439200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAEC9EAC22
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9ED21665E4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663A7215787;
	Tue, 10 Dec 2024 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vg78lIx0"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CA8234977
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822951; cv=none; b=pB2z6HfB1RL/whU6xgkIZBkWZhwPiAimpA/lvC7y59EIzpqar4SEOHkmN9hJRyIz5iu7xMj/BBkV4dKcrL3pYOYpehusXc3jbwwVLNn7Hy5TJH+f91V72yBKzWQdolGuug0uMY7gVybmlgPeHyBz/mZGuU+AHcMYg18y4hHhgpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822951; c=relaxed/simple;
	bh=w7J6GH74FD94qUt1WS+yjzRqg4NaeMgHNEi8UiOgVn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FQ9oHPDYof/yqxH+b2MYubKuOBk99V41dxmSsDeTCrb7Dn8d2q+eCKZR9g/uN4OLHnH716d0lS0GM+ZZpA+APM2/82jz5a1B2PrGwKXQlLE/IK8yTRM0kw7xLm4XB2bPo0muh9tHRvuUpNp8mI+CRuSUTxeiucY7oXvnH0AjRfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Vg78lIx0; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46677ef6910so47750291cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733822948; x=1734427748; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y//l0kib7ot3BmgnrtGvxoIcjefJ0s0WEOD2mlbXDKo=;
        b=Vg78lIx0/RD5K8tXoRwFSDourh3Q6ZGtVxChPDjsTW/MJbzr20L+GUKGYjFlv7J00a
         pkIDktVd3RYDAD+y4BF2FGJezB/LRE9iHi7ew+GbO/UyIGupNBARcyvk7kjY6z7xiPiK
         iKGcPBdfM4TtEf0W9UL3+gVx/ZaWrRCrdqi+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733822948; x=1734427748;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y//l0kib7ot3BmgnrtGvxoIcjefJ0s0WEOD2mlbXDKo=;
        b=k0QQzbINoDyrk6qjVqrYWUFsBYkgFSOswO01rVTT4LNjSv+3oPUX2U8NetJDuyvSF9
         sOATzCzGfGjFgxKcVxzL+ktuHkXD9//p5MA20qHcIUW2p4KJ/hASRZl1k8u81p++ghDY
         W5Pt6yuysWQ2CjAe/ZlTW+jZxlyXj4wTFlHeIt2+PfmxQSRynYwGdZv76Eod62S6QLht
         jXpC23du8fk0bbB9zcsbw3vzNcJ3jVBI0OYm0k4ZxWiytF6T1s2+eRs30Gp4fZrjBdAG
         X2fWRi7HLSwkM/C5FOBUkcTO99c32CIw+1PXHXAFODciLTFyCkmkIlcl0OfXRkIcrumb
         FuFg==
X-Forwarded-Encrypted: i=1; AJvYcCVaIr9ROPGAiPY8QtNbNG2vAwjed2Gyg2jyXq4rHM3g2kfAzlm/nyylSPlcD/I/Tj9Tw+DXw/ybns5zxPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze82By8wqRJvQYzGGYQNFjrigCTMdQ92Tv11p9Kne69p0RglJB
	iuPYAGsyoMcBYFzMUQeDSt2goSdLjK1yHhNeuTlSYd1S+HWUpT8WTufXjdVsTw==
X-Gm-Gg: ASbGnct2/cdfFK/6ox2hT5h/W6JX4tcl0hwcmOUpAakaWWpJT+VAVOdKmLsoOHEiWT8
	5BN8/ZifF21SP93sEQ6YIqW97e9sp3cN3tng+STJxnsb/q0e4ze1+ee6XvtdK6PO7zFrjtRYYPU
	77vLRIE3Y9eSDQqs4mqS2Xx5nt80iY/Z1tRndaS46CPeM5l0un1nSfYb7vjM7G3zwXG0E0X3MUc
	y4jcZ6q8CnB+Q1PuFcdVCk9rIFKfGhbltxgwc1T7tC65PoOUQspjqDFaQgBJ0a1pKDSk07sur7W
	vcO0BsC2pX/a/k9970+63BGK+hlc
X-Google-Smtp-Source: AGHT+IFf9kYaWa576VrO6wskX+9beQZ8FmZVkS93oM2U3Ri0fbfJz0ugCHR5677iLTfU/+g8oDAzSg==
X-Received: by 2002:a05:622a:110:b0:461:2150:d59c with SMTP id d75a77b69052e-46771eac17fmr59619831cf.9.1733822948169;
        Tue, 10 Dec 2024 01:29:08 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4675dd86ce4sm24343241cf.30.2024.12.10.01.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:29:06 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 09:28:55 +0000
Subject: [PATCH v2 11/11] media: v4l2-core: Introduce
 v4l2_query_ext_ctrl_to_v4l2_queryctrl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-queryctrl-v2-11-c0a33d69f416@chromium.org>
References: <20241210-queryctrl-v2-0-c0a33d69f416@chromium.org>
In-Reply-To: <20241210-queryctrl-v2-0-c0a33d69f416@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Mike Isely <isely@pobox.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-staging@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

We use this logic in a couple of places. Refactor into a function.
No functional change expected from this patch.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/v4l2-core/v4l2-ctrls-api.c | 51 +++++++++++++++++++-------------
 drivers/media/v4l2-core/v4l2-ioctl.c     | 28 ++----------------
 include/media/v4l2-ctrls.h               | 12 ++++++++
 3 files changed, 44 insertions(+), 47 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls-api.c b/drivers/media/v4l2-core/v4l2-ctrls-api.c
index 95a2202879d8..9dd2bc5893dd 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-api.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-api.c
@@ -1123,39 +1123,48 @@ int v4l2_query_ext_ctrl(struct v4l2_ctrl_handler *hdl, struct v4l2_query_ext_ctr
 }
 EXPORT_SYMBOL(v4l2_query_ext_ctrl);
 
-/* Implement VIDIOC_QUERYCTRL */
-int v4l2_queryctrl(struct v4l2_ctrl_handler *hdl, struct v4l2_queryctrl *qc)
+void v4l2_query_ext_ctrl_to_v4l2_queryctrl(struct v4l2_queryctrl *to,
+					   const struct v4l2_query_ext_ctrl *from)
 {
-	struct v4l2_query_ext_ctrl qec = { qc->id };
-	int rc;
+	to->id = from->id;
+	to->type = from->type;
+	to->flags = from->flags;
+	strscpy(to->name, from->name, sizeof(to->name));
 
-	rc = v4l2_query_ext_ctrl(hdl, &qec);
-	if (rc)
-		return rc;
-
-	qc->id = qec.id;
-	qc->type = qec.type;
-	qc->flags = qec.flags;
-	strscpy(qc->name, qec.name, sizeof(qc->name));
-	switch (qc->type) {
+	switch (from->type) {
 	case V4L2_CTRL_TYPE_INTEGER:
 	case V4L2_CTRL_TYPE_BOOLEAN:
 	case V4L2_CTRL_TYPE_MENU:
 	case V4L2_CTRL_TYPE_INTEGER_MENU:
 	case V4L2_CTRL_TYPE_STRING:
 	case V4L2_CTRL_TYPE_BITMASK:
-		qc->minimum = qec.minimum;
-		qc->maximum = qec.maximum;
-		qc->step = qec.step;
-		qc->default_value = qec.default_value;
+		to->minimum = from->minimum;
+		to->maximum = from->maximum;
+		to->step = from->step;
+		to->default_value = from->default_value;
 		break;
 	default:
-		qc->minimum = 0;
-		qc->maximum = 0;
-		qc->step = 0;
-		qc->default_value = 0;
+		to->minimum = 0;
+		to->maximum = 0;
+		to->step = 0;
+		to->default_value = 0;
 		break;
 	}
+}
+EXPORT_SYMBOL(v4l2_query_ext_ctrl_to_v4l2_queryctrl);
+
+/* Implement VIDIOC_QUERYCTRL */
+int v4l2_queryctrl(struct v4l2_ctrl_handler *hdl, struct v4l2_queryctrl *qc)
+{
+	struct v4l2_query_ext_ctrl qec = { qc->id };
+	int rc;
+
+	rc = v4l2_query_ext_ctrl(hdl, &qec);
+	if (rc)
+		return rc;
+
+	v4l2_query_ext_ctrl_to_v4l2_queryctrl(qc, &qec);
+
 	return 0;
 }
 EXPORT_SYMBOL(v4l2_queryctrl);
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index aa31678fb91e..ca89880b1359 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -2302,32 +2302,8 @@ static int v4l_queryctrl(const struct v4l2_ioctl_ops *ops,
 	ret = ops->vidioc_query_ext_ctrl(file, fh, &qec);
 	if (ret)
 		return ret;
-
-	p->id = qec.id;
-	p->type = qec.type;
-	p->flags = qec.flags;
-	strscpy(p->name, qec.name, sizeof(p->name));
-	switch (p->type) {
-	case V4L2_CTRL_TYPE_INTEGER:
-	case V4L2_CTRL_TYPE_BOOLEAN:
-	case V4L2_CTRL_TYPE_MENU:
-	case V4L2_CTRL_TYPE_INTEGER_MENU:
-	case V4L2_CTRL_TYPE_STRING:
-	case V4L2_CTRL_TYPE_BITMASK:
-		p->minimum = qec.minimum;
-		p->maximum = qec.maximum;
-		p->step = qec.step;
-		p->default_value = qec.default_value;
-		break;
-	default:
-		p->minimum = 0;
-		p->maximum = 0;
-		p->step = 0;
-		p->default_value = 0;
-		break;
-	}
-
-	return 0;
+	v4l2_query_ext_ctrl_to_v4l2_queryctrl(p, &qec);
+	return ret;
 }
 
 static int v4l_query_ext_ctrl(const struct v4l2_ioctl_ops *ops,
diff --git a/include/media/v4l2-ctrls.h b/include/media/v4l2-ctrls.h
index 59679a42b3e7..83b84cb5cf06 100644
--- a/include/media/v4l2-ctrls.h
+++ b/include/media/v4l2-ctrls.h
@@ -1404,6 +1404,18 @@ v4l2_ctrl_request_hdl_ctrl_find(struct v4l2_ctrl_handler *hdl, u32 id);
  */
 int v4l2_queryctrl(struct v4l2_ctrl_handler *hdl, struct v4l2_queryctrl *qc);
 
+/**
+ * v4l2_query_ext_ctrl_to_v4l2_queryctrl - Convert a qec to qe.
+ *
+ * @to: The v4l2_queryctrl to write to.
+ * @from: The v4l2_query_ext_ctrl to read from.
+ *
+ * This function is a helper to convert a v4l2_query_ext_ctrl into a
+ * v4l2_queryctrl.
+ */
+void v4l2_query_ext_ctrl_to_v4l2_queryctrl(struct v4l2_queryctrl *to,
+					   const struct v4l2_query_ext_ctrl *from);
+
 /**
  * v4l2_query_ext_ctrl - Helper function to implement
  *	 :ref:`VIDIOC_QUERY_EXT_CTRL <vidioc_queryctrl>` ioctl

-- 
2.47.0.338.g60cca15819-goog


