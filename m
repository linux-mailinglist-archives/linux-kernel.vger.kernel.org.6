Return-Path: <linux-kernel+bounces-429108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AA09E1932
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B585DB3DFAE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15101E0DAA;
	Tue,  3 Dec 2024 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/Hz0mpp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C2D1E0DB1
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218064; cv=none; b=KVVHK8oyt3upVS8Gz8uZYLci8YItQbVGzkbn9IENk1+OSAE3xcrvhzXHuHGis0NOTS3ZXsLYRZjbqy/uvzJfQ9HrafPbQmmF8O+RQYMW+gmSaYw02AlkvXelHLz14YHhS9KrHN7SerSZYi9QpEvY91huXzYdMVr0N6u7rFjxIvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218064; c=relaxed/simple;
	bh=LtoeILdsYxQuEuNm5Sq9+1S03A8uKng5c7MwWdMzhJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=r8dtwIEAUM4fpMDCMa3ji9Ftcsmtv3Zj2UrWQ949N54dDL9Qae8jTyH46wNKDeTJ0tmPkrOq7TD4iI5VW1lp79xc73MSjNapyxaY85Ek/6nMw2MJaJxM19Srw4tZJRolusWk7FmTr0uvlvsQuStpNImofj5lLVopabrnLhFhPX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e/Hz0mpp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733218061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OcfOiDWwi48053cjduhTjVXfsTwP0dn8jUXizpYq9Dc=;
	b=e/Hz0mpptJjueDzy9t6qm0IIWApJAt8QvW9ZkDlSaP4mb1e/sQ9vr6ubFdmfSw/K7HNqw3
	5bI395YSJHr9c0oD9CZfNOAdmkJ2FaGJRhp6KB/l7ZhNqtzn0P+HRSU9YyRzmMK7Eop0F3
	OKeSK02MyaLXhVCiaW5nCZoSwZJWtX0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-hnN35gWDPA6MpsCjWM_Cbg-1; Tue,
 03 Dec 2024 04:27:36 -0500
X-MC-Unique: hnN35gWDPA6MpsCjWM_Cbg-1
X-Mimecast-MFC-AGG-ID: hnN35gWDPA6MpsCjWM_Cbg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1AD01945CB2;
	Tue,  3 Dec 2024 09:27:34 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.224.51])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DC9E81956052;
	Tue,  3 Dec 2024 09:27:31 +0000 (UTC)
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
Subject: [PATCH 5/5] tools: ynl: add main install target
Date: Tue,  3 Dec 2024 10:27:04 +0100
Message-ID: <f8c507624278c9f3f252991760303b5a83c53515.1733216767.git.jstancek@redhat.com>
In-Reply-To: <cover.1733216767.git.jstancek@redhat.com>
References: <cover.1733216767.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This will install C library, specs, rsts and pyynl. The initial
structure is:

	$ mkdir /tmp/myroot
	$ make DESTDIR=/tmp/myroot install

	/usr
	/usr/lib64
	/usr/lib64/libynl.a
	/usr/lib/python3.XX/site-packages/pyynl/*
	/usr/lib/python3.XX/site-packages/pyynl-0.0.1.dist-info/*
	/usr/bin
	/usr/bin/ynl
	/usr/bin/ynl-ethtool
	/usr/bin/ynl-gen-c
	/usr/bin/ynl-gen-rst
	/usr/share
	/usr/share/doc
	/usr/share/doc/ynl
	/usr/share/doc/ynl/*.rst
	/usr/share/ynl
	/usr/share/ynl/genetlink-c.yaml
	/usr/share/ynl/genetlink-legacy.yaml
	/usr/share/ynl/genetlink.yaml
	/usr/share/ynl/netlink-raw.yaml
	/usr/share/ynl/specs
	/usr/share/ynl/specs/devlink.yaml
	/usr/share/ynl/specs/dpll.yaml
	/usr/share/ynl/specs/ethtool.yaml
	/usr/share/ynl/specs/fou.yaml
	/usr/share/ynl/specs/handshake.yaml
	/usr/share/ynl/specs/mptcp_pm.yaml
	/usr/share/ynl/specs/netdev.yaml
	/usr/share/ynl/specs/net_shaper.yaml
	/usr/share/ynl/specs/nfsd.yaml
	/usr/share/ynl/specs/nftables.yaml
	/usr/share/ynl/specs/nlctrl.yaml
	/usr/share/ynl/specs/ovs_datapath.yaml
	/usr/share/ynl/specs/ovs_flow.yaml
	/usr/share/ynl/specs/ovs_vport.yaml
	/usr/share/ynl/specs/rt_addr.yaml
	/usr/share/ynl/specs/rt_link.yaml
	/usr/share/ynl/specs/rt_neigh.yaml
	/usr/share/ynl/specs/rt_route.yaml
	/usr/share/ynl/specs/rt_rule.yaml
	/usr/share/ynl/specs/tcp_metrics.yaml
	/usr/share/ynl/specs/tc.yaml
	/usr/share/ynl/specs/team.yaml

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 tools/net/ynl/Makefile | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/Makefile b/tools/net/ynl/Makefile
index 617b405d9ef8..e18a7f68cf5c 100644
--- a/tools/net/ynl/Makefile
+++ b/tools/net/ynl/Makefile
@@ -1,5 +1,16 @@
 # SPDX-License-Identifier: GPL-2.0
 
+include ../../scripts/Makefile.arch
+
+INSTALL	?= install
+prefix  ?= /usr
+ifeq ($(LP64), 1)
+  libdir_relative = lib64
+else
+  libdir_relative = lib
+endif
+libdir  ?= $(prefix)/$(libdir_relative)
+
 SUBDIRS = lib generated samples
 
 all: $(SUBDIRS) libynl.a
@@ -22,5 +33,15 @@ clean distclean:
 	done
 	rm -f libynl.a
 	rm -rf pyynl/lib/__pycache__
+	rm -rf pyynl.egg-info
+	rm -rf build
+
+install: libynl.a
+	@echo -e "\tINSTALL libynl.a"
+	@$(INSTALL) -d $(DESTDIR)$(libdir)
+	@$(INSTALL) -m 0644 libynl.a $(DESTDIR)$(libdir)/libynl.a
+	@echo -e "\tINSTALL pyynl"
+	@pip install --prefix=$(DESTDIR)$(prefix) .
+	@make -C generated install
 
-.PHONY: all clean distclean $(SUBDIRS)
+.PHONY: all clean distclean install $(SUBDIRS)
-- 
2.43.0


