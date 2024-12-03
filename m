Return-Path: <linux-kernel+bounces-429102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A4C9E176A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9BCA28310B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561F81DF27E;
	Tue,  3 Dec 2024 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHFGmCEu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FC91DEFEA
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218042; cv=none; b=hIEv0VDoX1AtpCdCZNNOQrnyK0qGiEG7AbSHhjZK+MVybDx7UnD/EsARtHpg2xPPDQ5ztuQmS03q4u5vMvY3FocnrR8qLUAlsX8OdF+PWNFNXvu78SpmiQewxSRiKWahs5rzbcV/pAOav+PrgYt/3YKCxnnlOaWAD8qTBLcw5E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218042; c=relaxed/simple;
	bh=Ince3mWEv75RuKdJa0lCInd/VfuFqee8x2RBuI/adjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=Nt1o+BHwU10p/kqPXkMkAFH2/Yu5L8koUfuCouadg/M2DxvswBk3w7UQs9teScq7U9b2blf2+I8C1spE3grcicurOCFbE6JsREed9GU9Q9qzw4hi7oM01ciGo9DjooNbXvXP/U5f0VOVXbF/yWl43dxom+PLDrPna0Z93smqM70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PHFGmCEu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733218040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0EK26W2r8agytXtW5C5i2nqLQK7qOjfnw0z/ar6mvxw=;
	b=PHFGmCEuI7fVFW9iyHKQo7hHAOvkhWolhCkIKlQ8IWZIh70OplaE5YlU4K31bXz/697PzJ
	vsOkI4fkLyuG4VK6dFcksWmkHQnydRCPdHyxNjmdbYl8AJVzZVF6T6VtUn16zOP86PSXUR
	8uCVrLajjtqWSLy2wuymcOATxWwlpPg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-xpmqXa0IMDepN6lfWQz1cg-1; Tue,
 03 Dec 2024 04:27:17 -0500
X-MC-Unique: xpmqXa0IMDepN6lfWQz1cg-1
X-Mimecast-MFC-AGG-ID: xpmqXa0IMDepN6lfWQz1cg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C75C0192538D;
	Tue,  3 Dec 2024 09:27:14 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.224.51])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7D59D1956052;
	Tue,  3 Dec 2024 09:27:08 +0000 (UTC)
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
Subject: [PATCH 0/5] tools: ynl: add install target
Date: Tue,  3 Dec 2024 10:26:59 +0100
Message-ID: <cover.1733216767.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This series adds an install target for ynl. The python code
is moved to a subdirectory, so it can be used as a package
with flat layout, as well as directly from the tree.

To try the install as a non-root user you can run:
  $ mkdir /tmp/myroot
  $ make DESTDIR=/tmp/myroot install

  $ PATH="/tmp/myroot/usr/bin:$PATH" PYTHONPATH="$(ls -1d /tmp/myroot/usr/lib/python*/site-packages)" ynl --help

Proposed install layout is described in last patch.

Jan Stancek (5):
  tools: ynl: move python code to separate sub-directory
  tools: ynl: rename ynl-gen-[c|rst] to ynl_gen_[c|rst]
  tools: ynl: add initial pyproject.toml for packaging
  tools: ynl: add install target for specs and docs
  tools: ynl: add main install target

 tools/net/ynl/Makefile                        | 24 ++++++++++++-
 tools/net/ynl/generated/.gitignore            |  1 +
 tools/net/ynl/generated/Makefile              | 36 ++++++++++++++++---
 tools/net/ynl/lib/.gitignore                  |  1 -
 tools/net/ynl/lib/Makefile                    |  1 -
 tools/net/ynl/pyproject.toml                  | 26 ++++++++++++++
 tools/net/ynl/pyynl/__init__.py               |  0
 tools/net/ynl/{ => pyynl}/cli.py              |  0
 tools/net/ynl/{ => pyynl}/ethtool.py          |  0
 tools/net/ynl/pyynl/lib/.gitignore            |  1 +
 tools/net/ynl/{ => pyynl}/lib/__init__.py     |  0
 tools/net/ynl/{ => pyynl}/lib/nlspec.py       |  0
 tools/net/ynl/{ => pyynl}/lib/ynl.py          |  0
 .../ynl/{ynl-gen-c.py => pyynl/ynl_gen_c.py}  |  0
 .../{ynl-gen-rst.py => pyynl/ynl_gen_rst.py}  |  0
 tools/net/ynl/ynl-regen.sh                    |  2 +-
 16 files changed, 84 insertions(+), 8 deletions(-)
 create mode 100644 tools/net/ynl/pyproject.toml
 create mode 100644 tools/net/ynl/pyynl/__init__.py
 rename tools/net/ynl/{ => pyynl}/cli.py (100%)
 rename tools/net/ynl/{ => pyynl}/ethtool.py (100%)
 create mode 100644 tools/net/ynl/pyynl/lib/.gitignore
 rename tools/net/ynl/{ => pyynl}/lib/__init__.py (100%)
 rename tools/net/ynl/{ => pyynl}/lib/nlspec.py (100%)
 rename tools/net/ynl/{ => pyynl}/lib/ynl.py (100%)
 rename tools/net/ynl/{ynl-gen-c.py => pyynl/ynl_gen_c.py} (100%)
 rename tools/net/ynl/{ynl-gen-rst.py => pyynl/ynl_gen_rst.py} (100%)

-- 
2.43.0


