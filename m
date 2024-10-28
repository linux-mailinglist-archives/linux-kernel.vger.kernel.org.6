Return-Path: <linux-kernel+bounces-384597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0414B9B2C15
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C451C21FD9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA621CC8BA;
	Mon, 28 Oct 2024 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="L/Aqgzaj"
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675D4199247
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730109311; cv=none; b=I1xmt8RPurcdrul1XniO4Q5eyACtt6tXjUy79emqn8ky5/26qZcxe6IovIwSO7HvBbqNBLh3cXgPVRVtnDIKu8Mxcljhsn21C927om9bKIN4jyLQnzR0SG/w+h9OyG/ueFY5f/BI7TZ2Zix31oluRB3iGuWupqr4OQ4fduWzlSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730109311; c=relaxed/simple;
	bh=eTqrp/K3avN9ztKXcg2YVkfVz1O4Uq2icFwjpENa77I=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=oUemT9pgNzGIE9xFBcu9/zOE28fP5tiaNEPCsdsAdfrvy/rQbOe1VM+krEVZS0laxlkr3rnp3n2v9OfdNWmudV05syN4BtqdM2VtcIjlgz2407yJ/fH2aIaIU9raBE/BxPLzguOU78d3Rw3bmQMEfq6UmQGT5gMFmEMpi4YkSLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=L/Aqgzaj; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1730108999; bh=xeyQ4CVlwUPQjV1gtHpbGii9ZeSWJyc+nho/aGfUvpc=;
	h=From:To:Cc:Subject:Date;
	b=L/AqgzajXRmAsx6Nd/LoBT6A0qQ7S++mQin8xJPRaA5WacxVIk+T6YkjUd4AbWAb4
	 lBXqCRJId6yUbR6oydefC7qThp4JjvdWSTGsPf0RMHAO160EpLTTyN8pbpusGCIt3w
	 fIn67I7OkAd6+ZS2JaDqYPWS63Sh+TQkI5kbEb28=
Received: from localhost.localdomain ([111.48.58.10])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id ACF3628A; Mon, 28 Oct 2024 17:43:15 +0800
X-QQ-mid: xmsmtpt1730108595tmhr2h2n9
Message-ID: <tencent_46D189AD021D29866D1A9806B47AB013700A@qq.com>
X-QQ-XMAILINFO: M0yQCYO1Pk4BB9UWeDIUyjZs3jTlXV1Ox3W3489j2qduakf8YQmQky95WNP7w3
	 kEHZJj3Swch0FXjcS5ciAQqliZAwisS8ib0v4l5b3DUHTMd94sPA9rtLDNodoek0O8Jrd8oEqaLo
	 ExFEQ4QQIPxKCFuQBaQsKFs/hRIeCI6aiSwU1E8vutZ+QZmVNSkCwd+jugg8H3qZKE/9mLiKxAst
	 KtB0lB2YA0wsY5n3L7hWDP0N39u+2zgCrW7cfVmyHfHRXijzrfjWiVH/n6/P+YYgc6zyJg7TS1uL
	 OpxreeJs6/tG+g5BcGTTyZrjDZS3ynmd+LiDBwtuIMtYptjcDm8lEUrrUsPwHC+vVwqOIlNhP0wN
	 tv8GtoQtJTQ+RRcxKebED7AnFpgYFung3bSpUFfS+gOfJywifJBp7UqgXyS8HQ5lUOwOc7nJOhdP
	 ASpS8U6x/y6ZW6tlNZnHMRzwvJ1mjL9grTjqiymxBTvaO6/5lCy8LH8NBfmCqo22HLavODtKmdBb
	 EpAdxq+TAN8v8ORiBVcaJyZ2QiN86d8TjGIugczIrewM5bC6vRhoF09Z4A3H9f6XHQorOBqoAi12
	 CQpwhCYJLXMjMvSkW7N+AU/LHgvZUN01y9rNfofyeSQ7A34+vsmit1jxVqk8IH4Ok6MTqYcGhdwT
	 XZP2ddKuDj0EDJ6wtJ3O7JjDc3rD/LIJRLrBstwOeExuOevfPaR8jgbGWm4kkyzcss6QjmAM9UH3
	 pN52Otdku4RRkyRwxFhfwGUGC3YZssJ3kg8vWwIq4b1YKCtjMdiLwm76TDvBogw/E1ZTpF35trkY
	 yLknEV0AyxEQqwnDIJJAFljlQs7wkRfZfqAkayQN9PV5d8Qprs1H8+pkqaUkJU2LL71VUkwKyRdU
	 RJr0Z1vF4BNVjSJH1DPKFFnzK6FPIBStBBF/UOp+0ymBAb9omPafA=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: 1064094935@qq.com
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	pengfuyuan <pengfuyuan@kylinos.cn>
Subject: [PATCH] drm/xe/hdcp: Fix logic errors
Date: Mon, 28 Oct 2024 17:43:14 +0800
X-OQ-MSGID: <20241028094314.524356-1-1064094935@qq.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengfuyuan <pengfuyuan@kylinos.cn>

Here the gsc struct null pointer check should use '||' instead of '&&'.

Fix the following patches:
    drm/xe/hdcp: Check GSC structure validity

Signed-off-by: pengfuyuan <pengfuyuan@kylinos.cn>
---
 drivers/gpu/drm/xe/display/xe_hdcp_gsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/display/xe_hdcp_gsc.c b/drivers/gpu/drm/xe/display/xe_hdcp_gsc.c
index 6619a40aed15..f4332f06b6c8 100644
--- a/drivers/gpu/drm/xe/display/xe_hdcp_gsc.c
+++ b/drivers/gpu/drm/xe/display/xe_hdcp_gsc.c
@@ -42,7 +42,7 @@ bool intel_hdcp_gsc_check_status(struct xe_device *xe)
 	struct xe_gsc *gsc = &gt->uc.gsc;
 	bool ret = true;
 
-	if (!gsc && !xe_uc_fw_is_enabled(&gsc->fw)) {
+	if (!gsc || !xe_uc_fw_is_enabled(&gsc->fw)) {
 		drm_dbg_kms(&xe->drm,
 			    "GSC Components not ready for HDCP2.x\n");
 		return false;
-- 
2.25.1


