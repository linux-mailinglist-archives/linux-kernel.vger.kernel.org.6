Return-Path: <linux-kernel+bounces-309321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B4B9668D7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B17B7285530
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A649C1BC06E;
	Fri, 30 Aug 2024 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OtV0fUNI"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148B81B3B13;
	Fri, 30 Aug 2024 18:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725042154; cv=none; b=lrqRXFjKbY1d11182G3uqwCkRVQyqQXHDMzVx12Jov2yWAVwv4Z09y7afeNdvC9hpCa8Rzug8qptc7pcEt14i8z6TT7StoIXxLYX5Na1tkYzWpopSUhYhtlR2ZYE0QZQVK5EZmDuJHUdwee6y+hSChMU4YaOeVyANmgmdqDKn0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725042154; c=relaxed/simple;
	bh=iPxydC4ULYzP46EMCs+sJA3UlXi9bBkH3ecEvdhSCGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YjnvUReovYXvq/Ia22nzAi9iOeIjEYktfYsJFyaKX8B9FNbaN10/6xxvM+wqMd8hCg3k7943OVlWkoKwV5LDzlJklRlNvPd8eF6zRi/BP+jQWU6ukav9WJBYMcN5WvwGWSTNHtotu6fO/nDn1ingUSJmMXSpVtTSVSGOCPlfvqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=OtV0fUNI; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=XWs/60Qc8mo1giESc1/N4HmXbyxb+7YdXNX6HnpRBCU=; b=OtV0fUNIDfaWkHgpb3KMRcLC3v
	AzZYRTyliGxqXDzs4pqNPXKUF3ZqTR7nkzVLMdYpleK34l5IOPZkmTr2NSTWTjJQnId1xGwP8paoS
	tit50STIJCBGTEZzWwifFzoqa6C+nfoluKliWxi+BjzVH+uvjE2q+Bwv2dpqSr3EITFJFNX2cNFJc
	IGiljaaIWKOjU5TXN9tG95F+gg5JL1UO8KK/VZpY833b07KbDEEc176FkJWbRCJp8O/8GYYn7NvGx
	6mczZSc8Lu7DXNpJC/DrR6lRXl2OVYzTzf5T47TuI+jhdBbjugqc+gY7FWc9bkQUFxbqVvYkLAJSU
	wzpbnmyg==;
Received: from [177.76.152.96] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sk6GS-007FWw-Dk; Fri, 30 Aug 2024 20:22:28 +0200
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
	kernel@gpiccoli.net,
	kernel-dev@igalia.com,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH V2] Documentation: Improve crash_kexec_post_notifiers description
Date: Fri, 30 Aug 2024 15:21:00 -0300
Message-ID: <20240830182219.485065-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Be more clear about the downsides, the upsides (yes, there are some!)
and about code that unconditionally sets that.

Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

---

V2: Some wording improvements from Stephen, thanks!
Also added his review tag.

V1 link: https://lore.kernel.org/r/20240830140401.458542-1-gpiccoli@igalia.com/


 Documentation/admin-guide/kernel-parameters.txt | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index efc52ddc6864..351730108c58 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -913,12 +913,16 @@
 			the parameter has no effect.
 
 	crash_kexec_post_notifiers
-			Run kdump after running panic-notifiers and dumping
-			kmsg. This only for the users who doubt kdump always
-			succeeds in any situation.
-			Note that this also increases risks of kdump failure,
-			because some panic notifiers can make the crashed
-			kernel more unstable.
+			Only jump to kdump kernel after running the panic
+			notifiers and dumping kmsg. This option increases the
+			risks of a kdump failure, since some panic notifiers
+			can make the crashed kernel more unstable. In the
+			configurations where kdump may not be reliable,
+			running the panic notifiers can allow collecting more
+			data on dmesg, like stack traces from other CPUS or
+			extra data dumped by panic_print. Notice that some
+			code enables this option unconditionally, like
+			Hyper-V, PowerPC (fadump) and AMD SEV.
 
 	crashkernel=size[KMG][@offset[KMG]]
 			[KNL,EARLY] Using kexec, Linux can switch to a 'crash kernel'
-- 
2.46.0


