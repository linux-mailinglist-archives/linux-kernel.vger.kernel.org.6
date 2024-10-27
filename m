Return-Path: <linux-kernel+bounces-383814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C129B207D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AAD91C208D1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A74184527;
	Sun, 27 Oct 2024 20:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="D7TzJVsx"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE99762E0;
	Sun, 27 Oct 2024 20:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730061733; cv=none; b=DXI+wuvermv/qsF8Am++i9AX5K/XRqjwyfyetAAZQSvBg5rK8Q/ZvjB6w+gSdRPZtBhSvo9b7hRXw2Yp2iZknySuy9YW/gWGxP54aKlNlbtnGsXTr65bd06r7pXOPxvQ8KLpgg6CEV3NDRQM/lR87tMehdKsPzuuCQwx/PVteiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730061733; c=relaxed/simple;
	bh=v79S6PUrGE159g3ufeYYr858SvA0k47ESZK2/z2G5ec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=me61Fv7AkKvVhHhgZ6jjvO9euw4IKcBddnB0OlXgZ1EDrAD79lx0jlE4eBmqD1CHSfVNowGJyiF69aOqH6pRj3ITw+qvjt4vz+M/Q77Us1oTVZ8e2g4xcwybo94flAJGnKh+29ZtG9arhybJg6lgVsSY7O7QfRgMdsWv/cyMAhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=D7TzJVsx; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=FxIReQk1S15DxmmdigQ/aBi+z2bQeCrpB1btCYSB/wQ=; b=D7TzJVsxo2l8g8syJxk4o1O1sG
	I8FSJam1xhJuzwqGa5XuazVMdRCj87qWp2kLoUoEpeh/N3r2G/PA0gwf0t91EHRNkUnzFsrmq/Y2+
	5wNQJWWCfInlUzQQot0JDeCyLHXvll3RA3WB+C93fykW3BDsaFgkdK0H8Tcv1FLONeob0z3QzJaJQ
	owuTzuHsMXzVHiv1cs3KMOjGNskSLKU+BR9dw8e8+9XoUDVmgA7nKQYQm+xk1qhQA7xTgAnZt595x
	RxMUsTqdLGDj1WMesZ8Zgab3RejU3yqL2H5EYUOdCyW12On5w6u/bUXKsP/6OO37GQeDweIvTtwke
	MCHXDkZg==;
Received: from [189.79.117.125] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t5A5N-00Fpx6-MO; Sun, 27 Oct 2024 21:42:06 +0100
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
	mhklinux@outlook.com,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH V4] Documentation: Improve crash_kexec_post_notifiers description
Date: Sun, 27 Oct 2024 17:36:58 -0300
Message-ID: <20241027204159.985163-1-gpiccoli@igalia.com>
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
unconditionally, like Hyper-V[0], PowerPC (fadump)[1] and more recently,
AMD SEV-SNP[2].

[0] Commit a11589563e96 ("x86/Hyper-V: Report crash register data or kmsg before running crash kernel").
[1] Commit 06e629c25daa ("powerpc/fadump: Fix inaccurate CPU state info in vmcore generated with panic").
[2] Commit 8ef979584ea8 ("crypto: ccp: Add panic notifier for SEV/SNP firmware shutdown on kdump").

Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---


V4:
* s/AMD SEV/AMD SEV-SNP/ for better clarity, since there are more variants
of AMD SEV - thanks a lot Michael Kelley for the good explanation.

V3 link, including interesting clarifications about AMD SEV variants, by
Michael: https://lore.kernel.org/r/20241025162042.905104-1-gpiccoli@igalia.com/


 Documentation/admin-guide/kernel-parameters.txt | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3978fb704c53..1dbd0b0df6fe 100644
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
+			like Hyper-V, PowerPC (fadump) and AMD SEV-SNP.
 
 	crashkernel=size[KMG][@offset[KMG]]
 			[KNL,EARLY] Using kexec, Linux can switch to a 'crash kernel'
-- 
2.46.2


