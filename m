Return-Path: <linux-kernel+bounces-329364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F2097906B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 13:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED75282238
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 11:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0941CEEB8;
	Sat, 14 Sep 2024 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BaRyVGw1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63AB154BE0
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 11:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726312848; cv=none; b=XrRU1qxj+ss7rqNH3AXM61M7XffdbqvPJKpeaawbkRekhsPtAVTCpfOfhSLNInte+Tw4go/8hvA2Qlrvzycru/HtVvrI4LImI6444/HctjsF3E+xJ9wX+5JUs7qgAqRle7umbNydv2vuP0sMNwTnHz1EAX95Qdc876gmpMJfI9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726312848; c=relaxed/simple;
	bh=+CB+CuYtZ/mhcbG17QDFzv6IoSH9Ssufh4NcWKgof90=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hUBQKlnm8E15sOavd1ohTatsEcHsUMRIWpZUzQ4pcLXjfIKFbVIDKZr2V185MSkGiI7ZawMoI4yiltB9/GSgVvQZthw8611bwfSd5iyBIgCA3+90y32PsAdoD5sbIAh1XOavJkNyr8T6CVQxUPWYsdKXGW77/kLsG6KW2Iz/2DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BaRyVGw1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726312844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=VDcY1DfwhFJthdW3rQWNw4xYgYdrHBOnbtRjNWLoSsU=;
	b=BaRyVGw1/lGP9mt5+2CsrsSX+oi7ZoKaQUe5b3VHPJuPv1bWqL0MIfBLqeAXc1Fer3gBKu
	iNjl6otSZJHPhD8MfN8Bldn2UmCQKA9f+Bmb1X7gB4TRA44OgzHVYayodWO2RoyTwO9xAW
	kFDylUfd68c2ZHZzldlOr1RGHQiFynw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-386-OvZ34fq1OGOVmLTWMt3KOA-1; Sat,
 14 Sep 2024 07:20:43 -0400
X-MC-Unique: OvZ34fq1OGOVmLTWMt3KOA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C3161956096;
	Sat, 14 Sep 2024 11:20:41 +0000 (UTC)
Received: from darkstar.users.ipa.redhat.com (unknown [10.72.112.115])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88D6630001AB;
	Sat, 14 Sep 2024 11:20:37 +0000 (UTC)
Date: Sat, 14 Sep 2024 19:20:52 +0800
From: Dave Young <dyoung@redhat.com>
To: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: [PATCH] x86/e820: update code comment about e820_table_kexec
Message-ID: <ZuVxlJ77V2_U0HPM@darkstar.users.ipa.redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The setup_data ranges are not reserved for kexec any more after
commit fc7f27cda843 ("x86/kexec: Do not update E820 kexec table
for setup_data"), so update the code comment here.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 arch/x86/kernel/e820.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Index: linux-x86/arch/x86/kernel/e820.c
===================================================================
--- linux-x86.orig/arch/x86/kernel/e820.c	2024-09-14 10:39:57.423551301 +0800
+++ linux-x86/arch/x86/kernel/e820.c	2024-09-14 18:56:30.158316496 +0800
@@ -36,10 +36,8 @@
  *
  * - 'e820_table_kexec': a slightly modified (by the kernel) firmware version
  *   passed to us by the bootloader - the major difference between
- *   e820_table_firmware[] and this one is that, the latter marks the setup_data
- *   list created by the EFI boot stub as reserved, so that kexec can reuse the
- *   setup_data information in the second kernel. Besides, e820_table_kexec[]
- *   might also be modified by the kexec itself to fake a mptable.
+ *   e820_table_firmware[] and this one is that e820_table_kexec[]
+ *   might be modified by the kexec itself to fake a mptable.
  *   We use this to:
  *
  *       - kexec, which is a bootloader in disguise, uses the original E820


