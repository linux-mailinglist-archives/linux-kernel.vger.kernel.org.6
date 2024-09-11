Return-Path: <linux-kernel+bounces-324426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 342B4974C4D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED781F24FC7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224CB15383B;
	Wed, 11 Sep 2024 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2ZEP16W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD9B2C859
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726042593; cv=none; b=eZB3QNipP85/6ZXFFNTmNqFEDrnJtLFENbbLaV1fVOT4sVPF65QJCZNK7eDn8L1NKUOArhzYMVpwkfk2SMPNon/NtwDa3k2mbYdjQEUgCXGfQ0+VpS0nGfx3z8n0Y1oVANcLeLMOKagj3flwibqJm/zBci4Q9mxXf+N9Fub8lDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726042593; c=relaxed/simple;
	bh=lt74xK1G5wgCfAROwh/2txIm453K2zbIGmez/wCZob8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=SHSuu6rVK2tSEYq+kiSJozgnH8YXWSrSEef98E1x64cqLykYAIdUvS2HDL7iBnScPbqCygUEfkbCwzwF3+/kRycFbOyiJJHnx2ct+Yy/IOvOtJH0bX7yCh0EXwXNrvPRygPSZYLUgc5yWyhyqdE12nJzACY1NvetZaVpnTtUJcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a2ZEP16W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726042590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S9gOHV2P6n1r9v/KacsRsytS/lNb4zOlPi+8XQnUG00=;
	b=a2ZEP16WFjYohAVlH8SXuUXAQ7haJB9eTsXknBCVG1VNVvXc2nXb1n9qv1iT9G5PEHThI6
	JI99FxCD4TFdlKJoVe9dx0IlQQ3HyCvvydUmYa4mmwNG7X5m77vwO5LPy+aY8xMJe5uqB4
	/BogKXoUQ3Cp1QKqU81x7LE6UafZetc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-1M_BptrPMby1ljoBlh4kPQ-1; Wed,
 11 Sep 2024 04:16:27 -0400
X-MC-Unique: 1M_BptrPMby1ljoBlh4kPQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 502DB19560AF;
	Wed, 11 Sep 2024 08:16:25 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.58])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F0C3630001A1;
	Wed, 11 Sep 2024 08:16:19 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: thomas.lendacky@amd.com,
	dyoung@redhat.com,
	daniel.kiper@oracle.com,
	noodles@fb.com,
	lijiang@redhat.com,
	kexec@lists.infradead.org,
	x86@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 0/2] x86/mm/sme: fix the kdump kernel breakage on SME system when CONFIG_IMA_KEXEC=y
Date: Wed, 11 Sep 2024 16:16:13 +0800
Message-ID: <20240911081615.262202-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Currently, distros like Fedora/RHEL have enabled CONFIG_IMA_KEXEC by
default. This makes kexec/kdump kernel always fail to boot up on SME
platform because of a code bug. By debugging, the root cause is found
out and bug is fixed with this patchset.

Changelog:
v2->v3:
=======
- Add how the miscaculation is caused into patch 2 log according to
  Tom's suggestion.
- Add Tom's tag.

v1->v2:
=======
- Add patch 1 to clean up the confusing local varibale naming because
  people may mix up the local variable 'size' with the passed in parameter
  in function early_memremap_is_setup_data(). Suggested by Dave and Tom
  during v1 patch reviewing.

Baoquan He (2):
  x86/mm: rename the confusing local variable in
    early_memremap_is_setup_data()
  x86/mm/sme: fix the kdump kernel breakage on SME system when
    CONFIG_IMA_KEXEC=y

 arch/x86/mm/ioremap.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

-- 
2.41.0


