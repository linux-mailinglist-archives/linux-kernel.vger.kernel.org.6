Return-Path: <linux-kernel+bounces-405373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A64B49C5073
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C373285E0C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5270C20BB44;
	Tue, 12 Nov 2024 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RuXKYFFT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2BA20B20F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731399713; cv=none; b=OIZTQ3oMwVUMUXTY3KF68t8PAlYGXK6u1BVFyU4QKNjvXeIybOfiIH6cnTnc4dCpKTl2VYetVjEZVVL6ApYZ7cd3wjpXWYRiALMLXsiPlpVC3uxGr41ZgCBsm1Uv2faP2cXqGVOGKmox3SOWi+wlFD+uC6Ryx0vd7lD18FNUT9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731399713; c=relaxed/simple;
	bh=E2JnKx+5iCgJILO+r22UoLU1siqCaV3PfeuXSkuonLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=nr24E8mJxtzwoleaeoxjM3JJsQXwNWUINUznqt8qk5uf6wVR5/I8mvDBmbDkSzdyEDiObe/onrGX/Zy+Y8bX6arjuBw9o5WuhJWJN3kHezwESUbrzxR9IPpyqpHJP9jynrzsMdET4Fsy7SRbtLWWUzzZEEaS42BzOOatGJa3WJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RuXKYFFT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731399711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kzi9gdJPeVpG71SW03k//T9gQOGNKFRiWfLnFWSTCbM=;
	b=RuXKYFFTNth85ArgBxZj8XaxwpXcqYSIZHC996IyCbGY0wPqTLC7Fp0sZQKJ2I6pWOAvTL
	jomu2TlseG/iMefOYDYUBPcKq0uJCOxI/niimc5jCqQ8stlyeT7S7mRO4JXhsdgvFpY5qn
	/Px2664fnpDOnvvnn7n8f55aXkwH6UU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-NL_IQbuNNMGixk4i6X3dHg-1; Tue,
 12 Nov 2024 03:21:47 -0500
X-MC-Unique: NL_IQbuNNMGixk4i6X3dHg-1
X-Mimecast-MFC-AGG-ID: NL_IQbuNNMGixk4i6X3dHg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5462B1955F42;
	Tue, 12 Nov 2024 08:21:46 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.224.51])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 138F430000DF;
	Tue, 12 Nov 2024 08:21:42 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: donald.hunter@gmail.com,
	kuba@kernel.org
Cc: pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jstancek@redhat.com
Subject: [PATCH v2 0/2] tools: ynl: two patches to ease building with rpmbuild
Date: Tue, 12 Nov 2024 09:21:31 +0100
Message-ID: <cover.1731399562.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

I'm looking to build and package ynl for Fedora and Centos Stream users.
Default rpmbuild has couple hardening options enabled by default [1][2],
which currently prevent ynl from building.

This series contains 2 small patches to address it.

[1] https://fedoraproject.org/wiki/Changes/Harden_All_Packages
[2] https://fedoraproject.org/wiki/Changes/PythonSafePath

Changes in v2:
- rebased on top of https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/

Jan Stancek (2):
  tools: ynl: add script dir to sys.path
  tools: ynl: extend CFLAGS to keep options from environment

 tools/net/ynl/cli.py             | 3 +++
 tools/net/ynl/ethtool.py         | 2 ++
 tools/net/ynl/generated/Makefile | 2 +-
 tools/net/ynl/lib/Makefile       | 2 +-
 tools/net/ynl/samples/Makefile   | 2 +-
 tools/net/ynl/ynl-gen-c.py       | 3 +++
 6 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.43.0


