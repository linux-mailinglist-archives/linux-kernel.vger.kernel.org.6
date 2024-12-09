Return-Path: <linux-kernel+bounces-437836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B769E9957
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AA05282A70
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1C61BEF70;
	Mon,  9 Dec 2024 14:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cTXuCPdX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9D81B4254
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733755673; cv=none; b=Gk//ve5opcaY4cce3ob/R3uW6bkfkCiPj5urTY8yPcKvcv7p/DdQitZsC0cH2w8aItOzpmDoSkT36awn5Hts+ixFoQd/j/AVHjB+rapq03vxhiV91KRYTHBFj9meFH/ffKqd/tQirzhoeCeLsHlnt4vFH23FCiRGUb5Z67C73zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733755673; c=relaxed/simple;
	bh=6VdqSl8alXvH6pPsK78wHQAqoCIfIhg5UpI5s40sgg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=atT9jWs04zJ9sI9dkZ+d57DYUd/S9kqGqGTDLPauEtN5tYLFL6oHskqgkLhi7S5qaKkSpL6gSG0Dusr54EaEP61idQDVTfI68rwhm0dJpwdn3AHon7nNy2rr4C/lI3xvdUcwTZgioCcxavdbMG17a7SE2YkFPzcH+Yy2hJz1Gxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cTXuCPdX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733755671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l7tcKVC1kh1dFVI8oN1xiQyOlNqxnj21TIJYyRp/op8=;
	b=cTXuCPdXcSdCQiyw+gmrN2US8ddn/pYdw8a5ATIlfTXP5qlu8GTcP1eCkw0rCoxRuSh+Fu
	933nD0Nhcr8mhSd2xdCUOfU5zBZvLImPh77HFkssh6ps/h5xZPD3Z7nJVRS178yozlAx+l
	4lOF24sNvb27xkiKrXRCxhUNSjRNxUQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-0HX661lWNk2VIEQC5cRWAg-1; Mon,
 09 Dec 2024 09:47:46 -0500
X-MC-Unique: 0HX661lWNk2VIEQC5cRWAg-1
X-Mimecast-MFC-AGG-ID: 0HX661lWNk2VIEQC5cRWAg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCE8A1954221;
	Mon,  9 Dec 2024 14:47:44 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.224.182])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5BB241956089;
	Mon,  9 Dec 2024 14:47:41 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: donald.hunter@gmail.com,
	kuba@kernel.org,
	stfomichev@gmail.com
Cc: pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jstancek@redhat.com
Subject: [PATCH v2 3/5] tools: ynl: add initial pyproject.toml for packaging
Date: Mon,  9 Dec 2024 15:47:15 +0100
Message-ID: <18b1997fdbacf056dbcedcdb82f350703c6da8b0.1733755068.git.jstancek@redhat.com>
In-Reply-To: <cover.1733755068.git.jstancek@redhat.com>
References: <cover.1733755068.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 tools/net/ynl/pyproject.toml | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 tools/net/ynl/pyproject.toml

diff --git a/tools/net/ynl/pyproject.toml b/tools/net/ynl/pyproject.toml
new file mode 100644
index 000000000000..677ea8f4c185
--- /dev/null
+++ b/tools/net/ynl/pyproject.toml
@@ -0,0 +1,26 @@
+[build-system]
+requires = ["setuptools>=61.0"]
+build-backend = "setuptools.build_meta"
+
+[project]
+name = "pyynl"
+authors = [
+    {name = "Donald Hunter", email = "donald.hunter@gmail.com"},
+    {name = "Jakub Kicinski", email = "kuba@kernel.org"},
+]
+description = "yaml netlink (ynl)"
+version = "0.0.1"
+requires-python = ">=3.9"
+dependencies = [
+    "pyyaml==6.*",
+    "jsonschema==4.*"
+]
+
+[tool.setuptools.packages.find]
+include = ["pyynl", "pyynl.lib"]
+
+[project.scripts]
+ynl = "pyynl.cli:main"
+ynl-ethtool = "pyynl.ethtool:main"
+ynl-gen-c = "pyynl.ynl_gen_c:main"
+ynl-gen-rst = "pyynl.ynl_gen_rst:main"
-- 
2.43.0


