Return-Path: <linux-kernel+bounces-382119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B449B09B2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC881C24AB1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9248B1862AE;
	Fri, 25 Oct 2024 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="YbG4Yt1f"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD2C14A0A7;
	Fri, 25 Oct 2024 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729873257; cv=none; b=sogqefSqqhhtBOdnlQ52o770MTV+faVDCZ9/xzbGFMI73TDQXv/KhujnxSYLLQZTEYrapCJk0yefSYIjzZtPr8/RACH3aK1wGaTrAdM0721N8Ay1RmPUk2vXu6s68hpiJJbMiTBVDxBBOdopG963Sr9SCR62Id/BWSWzda3d3tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729873257; c=relaxed/simple;
	bh=Nnec9soSG37dMDOLuUy+sWKmAvQakFDh2jmGS5IqsBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VABkDEm4LP+DucirTaLvfMtgLWHXY6tEjuUbjAsrzwgymj+oGXaaJrNx1VF7Y0sgBG+ux0z1JqHwXiiNdG8Lg1ePFaK9Bu1Oshx4EGPJq6tmCZ1O7Ds2G8vqcGzRd3kTAKMeHdlZO4hsWDLH11dJhmgUA6wW7ThbHKLBu3t+pyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=YbG4Yt1f; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=EHLpWcwrtqUoy9yZdOs2vFLOu6EebO+piZZlDeFdZ2U=; b=YbG4Yt1fz5SrBiorVVGTzoxFeJ
	BhofV7UIxCiw/O7cutk+kz6WvBmC3k7ykYF4pUi6Z41Y6UYNkseVt0/GgfigbyWDEAiyY4Seab18d
	qoAmreG73WYGcrQoiJnm5C1E5e0fnuHLmy8r/TujFw69CXkl9j8jpFNsDKCRo5EjjK/B9F3WeMKof
	feMj6hD08D7rHFaMNeGwde8yIbz3T+m0QRWT8e5R/yy3vJTbOjp/mDajPO7WEJJMKc9TPUtvtOBTp
	6Ni5Z62vjOyA5HYEFgC4gDu79/x6kDOtLC2DwdWldwyENU8OkTUe+Td1/VEXNbvhdFgi1bqn+J4FG
	K11pt7BQ==;
Received: from [189.79.117.125] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t4N3P-00F5mK-VM; Fri, 25 Oct 2024 18:20:48 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: kexec@lists.infradead.org,
	linux-doc@vger.kernel.org
Cc: bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	linux-debuggers@vger.kernel.org,
	stephen.s.brennan@oracle.com,
	horms@kernel.org,
	kernel@gpiccoli.net,
	kernel-dev@igalia.com,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH V3] Documentation: Improve crash_kexec_post_notifiers description
Date: Fri, 25 Oct 2024 13:18:20 -0300
Message-ID: <20241025162042.905104-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The crash_kexec_post_notifiers description could be improved a bit,
by clarifying its upsides (yes, there are some!) and be more descriptive
about the downsides, specially mentioning code that enables the option
unconditionally, like Hyper-V[0], PowerPC (fadump)[1] and more
recently, AMD SEV[2].

[0] Commit a11589563e96 ("x86/Hyper-V: Report crash register data or kmsg before running crash kernel").
[1] Commit 06e629c25daa ("powerpc/fadump: Fix inaccurate CPU state info in vmcore generated with panic").
[2] Commit 8ef979584ea8 ("crypto: ccp: Add panic notifier for SEV/SNP firmware shutdown on kdump").

Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---

V3: Improved wording and commit description, detailing more about the addition
of code that enables crash_kexec_post_notifiers unconditionally.

Thanks Baoquan and Simon for the suggestions!


 Documentation/admin-guide/kernel-parameters.txt | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3978fb704c53..2a7a523bb90b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -918,12 +918,16 @@
 			the parameter has no effect.
 
 	crash_kexec_post_notifiers
-			Run kdump after running panic-notifiers and dumping
-			kmsg. This only for the users who doubt kdump always
-			succeeds in any situation.
-			Note that this also increases risks of kdump failure,
-			because some panic notifiers can make the crashed
-			kernel more unstable.
+			Only jump to kdump kernel after running the panic
+			notifiers and dumping kmsg. This option increases
+			the risks of a kdump failure, since some panic
+			notifiers can make the crashed kernel more unstable.
+			In configurations where kdump may not be reliable,
+			running the panic notifiers could allow collecting
+			more data on dmesg, like stack traces from other CPUS
+			or extra data dumped by panic_print. Note that some
+			configurations enable this option unconditionally,
+			like Hyper-V, PowerPC (fadump) and AMD SEV.
 
 	crashkernel=size[KMG][@offset[KMG]]
 			[KNL,EARLY] Using kexec, Linux can switch to a 'crash kernel'
-- 
2.46.2


