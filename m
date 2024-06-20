Return-Path: <linux-kernel+bounces-222007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C02F890FB9F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 05:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B502283979
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 03:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080F11D540;
	Thu, 20 Jun 2024 03:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="dvlteus5"
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E2921364;
	Thu, 20 Jun 2024 03:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718853632; cv=none; b=SEheb9fLW+XwZV7kmYlpd22r6c3wEnXwzvegQswfzW/hlGDM5XLpjmAQt3Fm7yc98/pC1YMGn7XbX9v/8hUtuD6qdaejb4rq5c3oHp92Iqv5X9iGYBnVecdJ5GxiJ+2kdbkvFGg8cKuLS5JZjvGaTQ8DRxCd7al9Svap6nwXFQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718853632; c=relaxed/simple;
	bh=CHW1zTgc3XSEVilLZ7AQ8sZuDlWf6261czsQKCF6kIo=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=Zbceq13dIt2n0CkUxp0WMqPuEMvcnT/TWOS3uNMNlefZfTl5VREmcJH/AWfo6e7/T1dGb+MH40PHphhDWtRfAqGXem0/VJmmepckr1G5tj/DLZI/U1w7U8cNO87GEJakScWENRpkqCoylqdo9pGUvVpIYHjxxQE5C1ZBN3ohlEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=dvlteus5; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1718853622;
	bh=n+Ycraue3gNeFeSACQbytVWxM5fUCGW+abg062+fSwk=;
	h=From:To:Cc:Subject:Date;
	b=dvlteus5VGL6Rsla1/dgHvpqUAo9j7wYm87wG0uiQGBL+MSKff1+vDSRvTrr0/QvT
	 9WleFuvI+jPQQSeTEl76RIAHqZdnv0zQ7wh3L/t354TpDihhnqDILS4+12/WsGBw5M
	 Es8I+8QXhYB9RnPHpdKUJtIdgZ1A0vxWk4zW1s3s=
Received: from localhost.localdomain ([203.119.160.30])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 38EB3818; Thu, 20 Jun 2024 11:14:14 +0800
X-QQ-mid: xmsmtpt1718853254tn274j54i
Message-ID: <tencent_6C54200469B1518482F88605A0980FBFD20A@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85NoZyAAn3uQfJMW5LFhW6Bcg+G0i/jldQm4eKCsIZVQx/09NUuc99
	 ddU6iNY0O5OjIiVEOfH6kFA5MxcPTXsjDpQiiUJD5nZmR7Tcq4BesdYhnjtosiZAV4tv/24GZR1D
	 bxosVLpOJWE5CsPGK0kXSLMZxxDhXzbtRW3HgULcChTn2bgdjteCXytMHrLrttVsrXi/zMOF0Ck+
	 diCLAW+P5h4kOOcgHQSSUFPjkrjKcyEwPw4hUex6iK++ih/W42aIr5GzI5DFFIhWvIN76PLXjCS2
	 E2XqGMryTRD/+wwOUu1uQrXJ7LZC5hzRoMqF7DTl41TLUoGJbP44VMMJ02wJz04bo7ghcNXiuzKJ
	 49TPrKgAHJMkm3pGfH9E0er1mPTrDUvN5yQrEW0DMaxr/F4FmbkY4740KIG52L0IwLIZ+mloLX7E
	 moWOViKA2Hl16VrdJOuw2Wes79Q6esncxbpnxReU7iPqwtl8+trCTm5xOFr/TbcWcahsdiW1PWjL
	 8T79ayEWktXH8OV5qIfDbp7eq8VlGWolg/vEb/tMTd2dN7ZNU18djrGUwK/e4XfisPzY9BcOOINu
	 +Xe4J9RdOwvIAoUUerqilvxcxrgM9MeNeb23xFbh3ohnj4gt6R0Ek2B4+oMtjH6REAX/34FFcwtA
	 3uOCNcfKhHYPkbi6QBha1kZavxAkDnyXcorTD0XgSr+4A4sRH5dsw3oknjHrb67NK4zITLOLKchJ
	 945Vt9RvfTh8tCjSGFj1VIY3GszoHe+dMGk8OexOncH4fi+Go7pVh9+6WntVAlTQ9lol5NFUGWER
	 QE8HuwXUT1BDbyS9TykvWed8E+EsX6Mr7kS7EzCu5QsimcKa2+3Yy+DG3ZpmjhViRqyNeu46cChl
	 MFpDB9BI1zCDQWbyMxtG2BSzL9AwzX1d8KhOpvpJFCHKJc0giMnvFQpP3eSe5DB7/xDF81iHBxwW
	 BOGHHkmaQ0ZH+dLq0fytd/ZZAdbmXA3XEaFhq4Pn8AuZzTixQsIg==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Tao Zou <wodemia@foxmail.com>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Tao Zou <wodemia@linux.alibaba.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] zh_CN/admin-guide: Add zh_CN/admin-guide/numastat.rst translation document
Date: Thu, 20 Jun 2024 11:14:06 +0800
X-OQ-MSGID: <20240620031407.1087-1-wodemia@foxmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tao Zou <wodemia@linux.alibaba.com>

Add translation zh_CN/admin-guide/numastat.rst and link it to
zh_CN/admin-guide/index.rst while clean its todo entry.

commit 77691ee92d4a ("Documentation: update numastat explanation")

Signed-off-by: Tao Zou <wodemia@linux.alibaba.com>
Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
---
 .../translations/zh_CN/admin-guide/index.rst  |  2 +-
 .../zh_CN/admin-guide/numastat.rst            | 48 +++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/admin-guide/numastat.rst

diff --git a/Documentation/translations/zh_CN/admin-guide/index.rst b/Documentation/translations/zh_CN/admin-guide/index.rst
index ac2960da33e6..0db80ab830a0 100644
--- a/Documentation/translations/zh_CN/admin-guide/index.rst
+++ b/Documentation/translations/zh_CN/admin-guide/index.rst
@@ -68,6 +68,7 @@ Todolist:
    cpu-load
    cputopology
    lockup-watchdogs
+   numastat
    unicode
    sysrq
    mm/index
@@ -109,7 +110,6 @@ Todolist:
 *   module-signing
 *   mono
 *   namespaces/index
-*   numastat
 *   parport
 *   perf-security
 *   pm/index
diff --git a/Documentation/translations/zh_CN/admin-guide/numastat.rst b/Documentation/translations/zh_CN/admin-guide/numastat.rst
new file mode 100644
index 000000000000..817043676c90
--- /dev/null
+++ b/Documentation/translations/zh_CN/admin-guide/numastat.rst
@@ -0,0 +1,48 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/admin-guide/numastat.rst
+:Translator: Tao Zou <wodemia@linux.alibaba.com>
+
+
+=======================
+Numa策略命中/未命中统计
+=======================
+
+/sys/devices/system/node/node*/numastat
+
+所有数据的单位都是页面。巨页有独立的计数器。
+
+numa_hit、numa_miss和numa_foreign计数器反应了进程是否能够在他们偏好的节点上分配内存。
+如果进程成功在偏好的节点上分配内存则在偏好的节点上增加numa_hit计数，否则在偏好的节点上增
+加numa_foreign计数同时在实际内存分配的节点上增加numa_miss计数。
+
+通常，偏好的节点是进程运行所在的CPU的本地节点，但是一些限制可以改变这一行为，比如内存策略，
+因此同样有两个基于CPU本地节点的计数器。local_node和numa_hit类似，当在CPU所在的节点上分
+配内存时增加local_node计数，other_node和numa_miss类似，当在CPU所在节点之外的其他节点
+上成功分配内存时增加other_node计数。需要注意，没有和numa_foreign对应的计数器。
+
+更多细节内容:
+
+=============== ============================================================
+numa_hit        一个进程想要从本节点分配内存并且成功。
+
+numa_miss       一个进程想要从其他节点分配内存但是最终在本节点完成内存分配。
+
+numa_foreign    一个进程想要在本节点分配内存但是最终在其他节点完成内存分配。
+
+local_node      一个进程运行在本节点的CPU上并且从本节点上获得了内存。
+
+other_node      一个进程运行在其他节点的CPU上但是在本节点上获得了内存。
+
+interleave_hit  内存交叉分配策略下想要从本节点分配内存并且成功。
+=============== ============================================================
+
+你可以使用numactl软件包（http://oss.sgi.com/projects/libnuma/）中的numastat工具
+来辅助阅读。需要注意，numastat工具目前只在有少量CPU的机器上运行良好。
+
+需要注意，在有无内存节点（一个节点有CPUs但是没有内存）的系统中numa_hit，numa_miss和
+numa_foreign统计数据会被严重曲解。在当前的内核实现中，如果一个进程偏好一个无内存节点（即
+进程正在该节点的一个本地CPU上运行），实际上会从距离最近的有内存节点中挑选一个作为偏好节点。
+结果会导致相应的内存分配不会增加无内存节点上的numa_foreign计数器，并且会扭曲最近节点上的
+numa_hit、numa_miss和numa_foreign统计数据。
-- 
2.39.3 (Apple Git-146)


