Return-Path: <linux-kernel+bounces-210604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B7F90461B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 23:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE648283AF1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 21:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3510A15383D;
	Tue, 11 Jun 2024 21:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BxQpBCjF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF0121364
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 21:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718140313; cv=none; b=rzAWeKm2WeqSHjXzmahCVRy+zNWfDo/wZAoDVrixwy3shkU1gZMZkdj4mpR9e/fRi8Y1Alg+TG3sl/0jsy1Q7XwRVcdn5x0xxtsPASyYBcMoZJ7EsGvEagHIDsXdPeYyA8HVdNTwuxA7O6aoSbCjSFJt0+a2M7Xlp9IaheqKwNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718140313; c=relaxed/simple;
	bh=IPkb5xs1tp8nidpR6ZdO56H7HFPrCZ4YuB4PKAsh35M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uil+Ep0OmEOjgXg45n2gQUSR+C0FnWF4zCmr0uOx6sSgSg55kPUYai6NgrsBc79OFUJEPlsE36mVx7DCU2Cvf5CIQFWVn2PQZM3gImzVpNnptYDdMvfPlJCUODC1GhIl4U9tm+z+8XvgYMmb4Fz0Msol2HwkBlRd74qQtJfiCHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BxQpBCjF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718140311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v2UqnbFZuqSpoV8dV5NBW3nYaLHw6l7BBeQAt1ESKMM=;
	b=BxQpBCjFw9kPRxAJM1/btwWauPKABs2GGFGdZBGyITxaBFttKIJ+g0r/jajasQ5ovWlr+e
	Rn5hF4Z7tzfbsgdHooM75iC/RVCQ7spQVTe0f0VqMrCfwdHikbh1DuQ00wCjh1qsEBuac7
	z4pUEpv6JUgm2GcKoET4Q/lE54EJF/A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-fvRH1C-5MymEhA_KJsglyw-1; Tue,
 11 Jun 2024 17:11:47 -0400
X-MC-Unique: fvRH1C-5MymEhA_KJsglyw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D42319560B7;
	Tue, 11 Jun 2024 21:11:45 +0000 (UTC)
Received: from optiplex-lnx.redhat.com (unknown [10.22.17.224])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A90419560AB;
	Tue, 11 Jun 2024 21:11:43 +0000 (UTC)
From: Rafael Aquini <aquini@redhat.com>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	aquini@redhat.com
Subject: [PATCH 1/2] kbuild: rpm-pkg: make sure to have versioned 'Obsoletes' for kernel.spec
Date: Tue, 11 Jun 2024 17:11:21 -0400
Message-ID: <20240611211123.959459-2-aquini@redhat.com>
In-Reply-To: <CAK7LNATxSePzOrHaQvS1MQo4mpAwdfwrDu3iuUsYZ+RL=LiirA@mail.gmail.com>
References: <CAK7LNATxSePzOrHaQvS1MQo4mpAwdfwrDu3iuUsYZ+RL=LiirA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Fix the following rpmbuild warning:

  $ make srcrpm-pkg
  ...
  RPM build warnings:
      line 34: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers

Signed-off-by: Rafael Aquini <aquini@redhat.com>
---
 scripts/package/kernel.spec | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
index e095eb1e290e..19e458341f45 100644
--- a/scripts/package/kernel.spec
+++ b/scripts/package/kernel.spec
@@ -27,7 +27,7 @@ The Linux Kernel, the operating system core itself
 %package headers
 Summary: Header files for the Linux kernel for use by glibc
 Group: Development/System
-Obsoletes: kernel-headers
+Obsoletes: kernel-headers < %{version}
 Provides: kernel-headers = %{version}
 %description headers
 Kernel-headers includes the C header files that specify the interface
-- 
2.45.1


