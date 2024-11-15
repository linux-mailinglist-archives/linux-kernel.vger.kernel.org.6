Return-Path: <linux-kernel+bounces-410135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9151D9CD503
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 02:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1197B24CE3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 01:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCD05B05E;
	Fri, 15 Nov 2024 01:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oe1HLGNA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180FB28366
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 01:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731633708; cv=none; b=oz+wF6bZTHB9VceA0f9ZXirPGiAWi8N39gs5DBeR0aBmin7Upf0iRzv3FOXX0XYUhnJWREs9WopZ0eUyoTJvkBtjzJ8yvE+zMmCXGh2No/YCoTGNPlkJO/e3Qpob5tG9CHbSxkDGd2u86Q54wDD76F4NMmJ+kFKCN3ray941D6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731633708; c=relaxed/simple;
	bh=0q+59TdxB9dq6grIoOxOxeJg7c5lWcqCZSTOZ8YhA5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=IiFioYFKbtS+j8nYbqKCFOXDZI0ZwU1sL3FZrQD8jO20ec9/nMvqY25QRPGzoEdngdFk+t3aGLO210WVJnQVPEzJyWWZ03YtPmkmOsrzJsD1FSOdD4vztJvo7Vhi0xbbGpSs3MaqGxfqVp0stm72bOaP71uY++COI+9xbBb5+l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oe1HLGNA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731633704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9vvkwI9Qvrwn21VKFyaeqJcATB7LqpeY5AvPDATgnFA=;
	b=Oe1HLGNAqn1xzqUmb+NKcYdmV7gDVaEWVbEooIyzt46uSp8ixwhZe3osYoqgMVTCCrm4L+
	4WC7SWjKWICj2xe7M/mEg8Tsm9jQKNJnRlE+u3owSzj+kkSK7e/jc2nxNmkbeoJbIl0i24
	co26Yf2ds8YjQEaSmXA30J2fym+MFjw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-ez4P6viXMzW8VRFn6B7k4w-1; Thu,
 14 Nov 2024 20:21:40 -0500
X-MC-Unique: ez4P6viXMzW8VRFn6B7k4w-1
X-Mimecast-MFC-AGG-ID: ez4P6viXMzW8VRFn6B7k4w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 514681956077;
	Fri, 15 Nov 2024 01:21:39 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.16])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1920D3003B74;
	Fri, 15 Nov 2024 01:21:35 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org,
	bp@alien8.de
Cc: x86@kernel.org,
	thomas.lendacky@amd.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 0/3] x86/ioremap: clean up the mess in xxx_is_setup_data
Date: Fri, 15 Nov 2024 09:21:28 +0800
Message-ID: <20241115012131.509226-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Functions memremap_is_setup_data() and early_memremap_is_setup_data()
share completely the same process and handling, except of the
different memremap/unmap invocations. The code can be extracted and put
into a helper function __memremap_is_setup_data().

And parameter 'size' is unused in implementation of memremap_is_efi_data(),
memremap_is_setup_data and early_memremap_is_setup_data().

This patchset is made to clean them up. It sits on top of tip/x86/urgent
commit 8d9ffb2fe65a ("x86/mm: Fix a kdump kernel failure on SME system
when CONFIG_IMA_KEXEC=y")

Baoquan He (3):
  x86/ioremap: introduce helper to check if physical address is in
    setup_data
  x86/ioremap: use helper to implement xxx_is_setup_data()
  x86/mm: clean up unused parameters of functions

 arch/x86/mm/ioremap.c | 117 +++++++++++++++---------------------------
 1 file changed, 41 insertions(+), 76 deletions(-)

-- 
2.41.0


