Return-Path: <linux-kernel+bounces-306686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE0C96421B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946B71F23514
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFBA18C33A;
	Thu, 29 Aug 2024 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahQguTn8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF25D15FA93
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724928033; cv=none; b=Ij25N2k5Q782y7KaigVGuU/wuKB6sweVcipnLN6HZz39olid/8bZRd+O0vI0QuTIsFDxAheQaZh4lNFJwMLGm9RStCwwVE+qgNLa0aYfVKx2QCIPTlPyNy68/BDKg9XZNDSGMznTnuL/Xf8KFhMTj+nVeOdyAntOb3Mk3/1PsnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724928033; c=relaxed/simple;
	bh=KRFiGN7GySW5CrfFzzhgi3dePYkxsNPkoz8ejOOYftw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=j1dKTSm/904OiQ2JV/VfbOJqXLU7LKtKqgL7snHB98PZYFwq4y4edLNyUf2IaiMegU83i+cBLzapvAiddpeRYl//njQz9s7uVryt5sXTGWxpuEIzdn/UIf7FWh3y+KU54qFpNIS8kXDlPgk1BSTEXoKI1xwVrX8rdoIF72POpu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ahQguTn8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724928029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3NA2za3mLWwZQgdkwnzS66f5eQJoKJP/wfMq+IdUpAY=;
	b=ahQguTn8Af4irxGoBZ1E+qrzJwxP2+eAdW22dtSAPXlr6fK9dNXllGCOg9/iHtFzyqp9H0
	EnVFf/6z0vpUHieGfIHIa8Vgg+aVfii+qp42KE5NjkvHcPjm5G5DjPahpz7yeqXmm7Kcx9
	PyWFo/tWlblJL/VEm9Gg0muX24YQmEw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-kQup8Y_wN6WRSA2waTXVeg-1; Thu,
 29 Aug 2024 06:40:26 -0400
X-MC-Unique: kQup8Y_wN6WRSA2waTXVeg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ECAB51955D4E;
	Thu, 29 Aug 2024 10:40:24 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.42])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5B6D919560AA;
	Thu, 29 Aug 2024 10:40:19 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: thomas.lendacky@amd.com,
	dyoung@redhat.com,
	daniel.kiper@oracle.com,
	noodles@fb.com,
	lijiang@redhat.com,
	kexec@lists.infradead.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 0/2] x86/mm/sme: fix the kdump kernel breakage on SME system when CONFIG_IMA_KEXEC=y
Date: Thu, 29 Aug 2024 18:40:14 +0800
Message-ID: <20240829104016.84139-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

In this v2 posting,
- patch 2 is to fix the kdump kernel breakage;
- patch 1 is added to clean up the confusing local varibale naming because
people may mix up the local variable 'size' with the passed in parameter
in function early_memremap_is_setup_data(). This cleanup is suggested by
Dave and Tom during v1 patch reviewing.

V1 post can be found here:
===
[PATCH] x86/mm/sme: fix the kdump kernel breakage on SME system when CONFIG_IMA_KEXEC=y
https://lore.kernel.org/all/20240826024457.22423-1-bhe@redhat.com/T/#u

Baoquan He (2):
  x86/mm: rename the confusing local variable in
    early_memremap_is_setup_data()
  x86/mm/sme: fix the kdump kernel breakage on SME system when
    CONFIG_IMA_KEXEC=y

 arch/x86/mm/ioremap.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

-- 
2.41.0


