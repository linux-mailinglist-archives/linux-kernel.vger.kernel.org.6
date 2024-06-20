Return-Path: <linux-kernel+bounces-222187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F8590FE05
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4162285D94
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5724CDE0;
	Thu, 20 Jun 2024 07:48:20 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04F7482C8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718869700; cv=none; b=h6xqHczlPdEtFWQCXfwqgxzuoaRU+ybQtkJcbmBuMrSNT8n/uL2sAtC3vfJl7Do5SH6DGnjgZRtMyPCZec0O+wpsaDsCFSr+sNQsXUiDpu2/VQJV87c9WpAe49341z4KFIteU9Qh6pWvNZEr74uDFwnVYNfwncQvvKyOkgCE4Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718869700; c=relaxed/simple;
	bh=fSsLmm6xI8rM7ZlJBg3+JGciXFSOY7iTXxxC65tu3Po=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=do6O2qZeLMmLtGlre++lBABjiW4qUTh8THWvjbB/ProXHo1ObPCpZ02bMTjW0DH74QRv1aJ1uTjlIwAH2M+TEtyWQ3JpbqCVGKEh6Oc9dH/UqDgRW0zLWqqeb1AoNBRKFBCDEIqegmVyZkuRkizpugoPEFlnA4bxZX4hgoj/VJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowACHjeWs3nNms1TLEQ--.25969S2;
	Thu, 20 Jun 2024 15:47:56 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH 1/2] drm/panel: ltk050h3146w: add check for mipi_dsi_dcs_enter_sleep_mode
Date: Thu, 20 Jun 2024 15:47:20 +0800
Message-Id: <20240620074720.852495-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACHjeWs3nNms1TLEQ--.25969S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw4kCFyfCF1rtrWDWryUZFb_yoWfArb_CF
	1xZr47Xryjk3s8uw17AanrAryakan8uF4ku3W0va4fKw1UCwnxX34kXryqvrZ8Jr4jyF98
	C3WUtFyjvF4xGjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY02Avz4vE14v_GF4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjfUOPEfUUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Add check for the return value of mipi_dsi_dcs_enter_sleep_mode() and
return the error if it fails in order to catch the error.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
index 292aa26a456d..24bf05d0589f 100644
--- a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
+++ b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
@@ -526,7 +526,7 @@ static int ltk050h3146w_unprepare(struct drm_panel *panel)
 		return ret;
 	}
 
-	mipi_dsi_dcs_enter_sleep_mode(dsi);
+	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
 	if (ret < 0) {
 		dev_err(ctx->dev, "failed to enter sleep mode: %d\n", ret);
 		return ret;
-- 
2.25.1


