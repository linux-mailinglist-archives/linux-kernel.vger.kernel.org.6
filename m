Return-Path: <linux-kernel+bounces-260579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 462CE93AB2A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 04:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48C401C22EE4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 02:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C8D17C95;
	Wed, 24 Jul 2024 02:18:44 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CAE1CA93;
	Wed, 24 Jul 2024 02:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721787524; cv=none; b=k9eL7vJ7Ji1BXpL2svabtZqkleJOmIBdLYP0xo/4trBc02Ed0rDYekAsxrsqyFGg5bsRIJuI3hQRFjqmwKUY9JPKDXeoyTU7+w4AuWSP8uwgBp18MVjALqkjzehd6n0k8WU+qcqh8MKgXTSqI7z0tB79qYEEzS4DPI2qhtFJ3/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721787524; c=relaxed/simple;
	bh=JtpI4NwjWgIkoEKZFJoiukOQ1YfwMkxr68FJ1EAWtYw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Ttt9glm/srjHu9VEuB7+WHw9kvwUJ41ok59nrv+FmSbXM/hpNuhtoQ+hp2CbHxBMOjzcNrMuS2PG6fEHRvt4IHsVohR0x1gBgHcAZLqnKuq2pW4FFAPiBm7D060xk2p16x9oqlzsWNu/oLMFIvlWcxsWEEwRDk0pIHx0wogpkp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee366a063c05f8-63e03;
	Wed, 24 Jul 2024 10:15:29 +0800 (CST)
X-RM-TRANSID:2ee366a063c05f8-63e03
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[223.108.79.100])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee366a063c003b-8ea7d;
	Wed, 24 Jul 2024 10:15:29 +0800 (CST)
X-RM-TRANSID:2ee366a063c003b-8ea7d
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: jolsa@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [RESEND bpf-next v2] selftests/bpf:fix a resource leak
Date: Tue, 23 Jul 2024 19:15:27 -0700
Message-Id: <20240724021527.2957-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The requested resources should be closed before return
in main(), otherwise resource leak will occur

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
Changes in v2:
 - check for cg_fd >= 0 and have just one out label

 tools/testing/selftests/bpf/test_sockmap.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index a34e95040994..285a9a714666 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -2075,8 +2075,10 @@ int main(int argc, char **argv)
 
 	if (!cg_fd) {
 		cg_fd = cgroup_setup_and_join(CG_PATH);
-		if (cg_fd < 0)
-			return cg_fd;
+		if (cg_fd < 0) {
+			err = cg_fd;
+			goto out;
+		}
 		cg_created = 1;
 	}
 
@@ -2092,7 +2094,7 @@ int main(int argc, char **argv)
 	if (err) {
 		fprintf(stderr, "populate program: (%s) %s\n",
 			bpf_file, strerror(errno));
-		return 1;
+		goto out;
 	}
 	running = 1;
 
@@ -2109,7 +2111,8 @@ int main(int argc, char **argv)
 		free(options.whitelist);
 	if (options.blacklist)
 		free(options.blacklist);
-	close(cg_fd);
+	if (cg_fd >= 0)
+		close(cg_fd);
 	if (cg_created)
 		cleanup_cgroup_environment();
 	return err;
-- 
2.17.1




