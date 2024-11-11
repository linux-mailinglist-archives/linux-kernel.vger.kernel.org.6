Return-Path: <linux-kernel+bounces-404114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B94119C3F3A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D6DB289044
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4084B19E826;
	Mon, 11 Nov 2024 13:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VyghVp8f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9651A0B12
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 13:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731330313; cv=none; b=DQ7qQ+Ii0FH21m71pgfZFAw2JVfTHQBeRD6Pnr4BIt1kJmIDjP5L1oO4QUqfX1xX1zyzRN+PGvoMmWs2VYZOxwDzIJSMhw4DF07a6nKNGrlw+NwBKALXFogLOJuTsVFbFmg5AnCn2RGICL3Y4Bm7Rqrx0yiv+dx/Zq/gkyp+Q9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731330313; c=relaxed/simple;
	bh=SVHh1fatO0oQO4UReWs7wXWXGCXs6Dml1ZS/FKUTm/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=sjsG2w++hMj9/HimvJvkrfHPFPy3FselN3ge6dShtCqlZBn+nHu5ZMOtNOIxZw67oXVAvyimst+yIZ7D5elqe1SWdHctmR0+FC5mSrozjm9NZpjzhgiRZHS01lJVoAg0y2O7tpMu18ziCoVfGZlGg6AG8bk0NtXB8suM8nkfn6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VyghVp8f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731330311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1cOooKZkaMPDXtuTp8ptu0pElUOFrvu05o1tdMQaEFY=;
	b=VyghVp8f2v/WAu90OKu9ndtfSnI7FQUqsj+AYmz8q6c728qnz9U6pRtyvYSsZSTydG0OPR
	MUgmfjhjtzPdYpz7cwQXk/cDhJuZLfJgdpDStKtZFsideUt6FJMxYgB6/frsnCrPLskI8t
	jXUwuQ1z7lGxwX/E3Ki7k+nDAZIFH9U=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-ppjqHuYlMm2SY4kQiRg0TQ-1; Mon,
 11 Nov 2024 08:05:05 -0500
X-MC-Unique: ppjqHuYlMm2SY4kQiRg0TQ-1
X-Mimecast-MFC-AGG-ID: ppjqHuYlMm2SY4kQiRg0TQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8950B1953945;
	Mon, 11 Nov 2024 13:05:04 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.224.51])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 723E31956086;
	Mon, 11 Nov 2024 13:05:01 +0000 (UTC)
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
Subject: [PATCH 1/2] tools: ynl: add script dir to sys.path
Date: Mon, 11 Nov 2024 14:04:44 +0100
Message-ID: <97c08d1fdbd374ec6216a59d3b08f03d376ce2aa.1730976866.git.jstancek@redhat.com>
In-Reply-To: <cover.1730976866.git.jstancek@redhat.com>
References: <cover.1730976866.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Python options like PYTHONSAFEPATH or -P [1] do not add script
directory to PYTHONPATH. ynl depends on this path to build and run.

[1] This option is default for Fedora rpmbuild since introduction of
    https://fedoraproject.org/wiki/Changes/PythonSafePath

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 tools/net/ynl/cli.py       | 3 +++
 tools/net/ynl/ethtool.py   | 2 ++
 tools/net/ynl/ynl-gen-c.py | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/tools/net/ynl/cli.py b/tools/net/ynl/cli.py
index b8481f401376..873463dbdcc0 100755
--- a/tools/net/ynl/cli.py
+++ b/tools/net/ynl/cli.py
@@ -3,9 +3,12 @@
 
 import argparse
 import json
+import pathlib
 import pprint
+import sys
 import time
 
+sys.path.append(pathlib.Path(__file__).resolve().parent.as_posix())
 from lib import YnlFamily, Netlink, NlError
 
 
diff --git a/tools/net/ynl/ethtool.py b/tools/net/ynl/ethtool.py
index 63c471f075ab..ebb0a11f67bf 100755
--- a/tools/net/ynl/ethtool.py
+++ b/tools/net/ynl/ethtool.py
@@ -3,11 +3,13 @@
 
 import argparse
 import json
+import pathlib
 import pprint
 import sys
 import re
 import os
 
+sys.path.append(pathlib.Path(__file__).resolve().parent.as_posix())
 from lib import YnlFamily
 
 def args_to_req(ynl, op_name, args, req):
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 717530bc9c52..a86e88019e22 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -4,12 +4,15 @@
 import argparse
 import collections
 import filecmp
+import pathlib
 import os
 import re
 import shutil
+import sys
 import tempfile
 import yaml
 
+sys.path.append(pathlib.Path(__file__).resolve().parent.as_posix())
 from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, SpecEnumEntry
 
 
-- 
2.43.0


