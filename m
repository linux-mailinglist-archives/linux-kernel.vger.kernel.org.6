Return-Path: <linux-kernel+bounces-282999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EB894EBB0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA0E28233B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E697172BD6;
	Mon, 12 Aug 2024 11:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=vignesh.raman@collabora.com header.b="FVuGh4N6"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C9A219FC
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723461689; cv=pass; b=RBqfOWAZNvmN3B5BnZZnF0yIxB37ptT13KT6wXJC/vZKUrKa9EjUuv4a327Hno0hDzpTN+nWq7ro6xbUYUBh3BMNUsx02RC/CWQAbOeAvXz8yDPytROFQaUp/9UxorMKPb8f103J8hRA1hfmSIPq1sP7mHg4M66/N5hCt+mY31E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723461689; c=relaxed/simple;
	bh=Y3ifjZQfp+MRM+J1pnHfGSk0yQd6aLfQ33iKHf92FWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D/lPJzK8HcpVVvlET6nHWDjj5A6O2HmIRzGU58PXQhap7my9kKFuDsnqsU4qEIo1YbaThYT+IHrzBK8VzOG1RussWOXymtM94cFcC98DZdpTaVuk+TAyNDeQR+jXqvef4yG0FvK8iOVIAHScF3MMss7mZj/aFlkJuviW2Z8z5fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=vignesh.raman@collabora.com header.b=FVuGh4N6; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: daniels@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723461682; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hSDBnQ7E3G2NfCheKXcumPD8j3KEvI0z7Zig8vXA8xyc2mt8vGFgeesuSrNPMKTAq6fiE2LsTbopcIqiu+J64R8d7s2y41U8SJqB5fCyeQSsxRjVZTXrPgQTE8uHpiWLwwQMsbUui2Bx8c/W4HICoIKK9bcZ+AhXGEWyOvdk2GA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723461682; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ElgfAUgp1A3HJ9rIBV/vS6smXyAx/v9/DJS44pjWjJ0=; 
	b=eF/904qFd6gKf0NPmk05DL8dfamJzkQ0xQ1HfLfyFqRZQmuFBf9dEJCO1i3drE4hs2EqEWcZ22VSRQNXOfeik3u3tAz6bXB3qb+BWvP3boWjaoXn4XSCkeFjnaQHt4sBX1SHdD8AF710xLytHI+zd/1a0oGbMbXVGWl/OnxPdD4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vignesh.raman@collabora.com;
	dmarc=pass header.from=<vignesh.raman@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723461682;
	s=zohomail; d=collabora.com; i=vignesh.raman@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ElgfAUgp1A3HJ9rIBV/vS6smXyAx/v9/DJS44pjWjJ0=;
	b=FVuGh4N65uQ51d1NKzefCpdRMhvdoj6WUr/918dEYvuQwvQNWVzFhBs4iwyqMcDE
	pLZrkMpsWWAFIIiHeVmjBL8V8QcArYiUsg3TI7kXmrRA4V+AWxtns+z+8O+6ur7vEyI
	R/auJfYpGE25kTkoasxaFy6qaH6UNQNn/QeIKO+A=
Received: by mx.zohomail.com with SMTPS id 1723461681031721.9508608249985;
	Mon, 12 Aug 2024 04:21:21 -0700 (PDT)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com,
	helen.koike@collabora.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	robdclark@gmail.com,
	guilherme.gallo@collabora.com,
	sergi.blanch.torne@collabora.com,
	deborah.brouwer@collabora.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] drm/ci: enable lockdep detection
Date: Mon, 12 Aug 2024 16:50:28 +0530
Message-ID: <20240812112030.81774-1-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

We have enabled PROVE_LOCKING (which enables LOCKDEP) in drm-ci.
This will output warnings when kernel locking errors are encountered
and will continue executing tests. To detect if lockdep has been
triggered, check the debug_locks value in /proc/lockdep_stats after
the tests have run. When debug_locks is 0, it indicates that lockdep
has detected issues and turned itself off. So check this value and
exit with an error if lockdep is detected.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v1:
  - Pipeline link to show lockdep_stats before and after tests,
    https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1246721
  
---
 drivers/gpu/drm/ci/igt_runner.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/ci/igt_runner.sh b/drivers/gpu/drm/ci/igt_runner.sh
index f38836ec837c..d2c043cd8c6a 100755
--- a/drivers/gpu/drm/ci/igt_runner.sh
+++ b/drivers/gpu/drm/ci/igt_runner.sh
@@ -85,6 +85,17 @@ deqp-runner junit \
    --limit 50 \
    --template "See https://$CI_PROJECT_ROOT_NAMESPACE.pages.freedesktop.org/-/$CI_PROJECT_NAME/-/jobs/$CI_JOB_ID/artifacts/results/{{testcase}}.xml"
 
+# Check if /proc/lockdep_stats exists
+if [ -f /proc/lockdep_stats ]; then
+    # If debug_locks is 0, it indicates lockdep is detected and it turns itself off.
+    debug_locks=$(grep 'debug_locks:' /proc/lockdep_stats | awk '{print $2}')
+    if [ "$debug_locks" -eq 0 ]; then
+        echo "LOCKDEP issue detected. Please check dmesg logs for more information."
+        cat /proc/lockdep_stats
+        ret=1
+    fi
+fi
+
 # Store the results also in the simpler format used by the runner in ChromeOS CI
 #sed -r 's/(dmesg-warn|pass)/success/g' /results/results.txt > /results/results_simple.txt
 
-- 
2.43.0


