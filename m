Return-Path: <linux-kernel+bounces-218563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 203D990C1EA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 04:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FDF31F2252E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BEE19ADAD;
	Tue, 18 Jun 2024 02:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="xJ1GcQZ4"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29E6197A7B;
	Tue, 18 Jun 2024 02:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718678877; cv=none; b=AYXRMIWWXRGaPp7zetMG0hBlGUQikRaU50YO43W9kPGdvsf5092zPVLr03gLGejkjO4RgJlrjqjyPMojQnAx/IkykUxVePo9eEKcJfB1xrv5nXQaal+1ixfehKZjlQyuh4lWzC4Id7RlC8NC/ZLYe46DfZpXN/AH8vxahRwxFPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718678877; c=relaxed/simple;
	bh=Of9hd9gJdC44iU0TcP82vIPNrhugyO6E3ElDHzolkOU=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=g2/P7NzcS1MUDH14WoN5x9v8GhyZ8dhv4JiX0u4qz/UntwYFHw5a+T3lo6dKOx+M09yWDZw07YxMcy3N6Ryc3t+Rhtkgga27UcIGWA1pGbKtbxBGohjS8ROksuzcvC0agf8ZSSfrrYKI03lDTmlTd+UqGcNDbKu8rQA1/UdX5t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=xJ1GcQZ4; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1718678861;
	bh=+PgtJypd92me9yUpBAxp9FE7WuW9NkxbHeiGjuU9UJA=;
	h=From:To:Cc:Subject:Date;
	b=xJ1GcQZ4OvYeoGoT9brQMiF19/Y+VpV8j/o2JrkdQGAyuNlLXwNCVqIK6/i+uUtI6
	 kZ07yDiSyCEIggg1sT37i7uFTrJUH15X2cfquxxu7C8NoRsDefFkJ2ElIujiZa9xdM
	 LF+TEF0fKXaYKwLnrAatfihg62ijPL/NswKrFdak=
Received: from localhost.localdomain ([203.119.160.30])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id BE6A6499; Tue, 18 Jun 2024 10:47:38 +0800
X-QQ-mid: xmsmtpt1718678858tlzx1vhih
Message-ID: <tencent_227A20B261EF28E4C37834F2089D5AD91408@qq.com>
X-QQ-XMAILINFO: MmpliBmRb3iCozKJu14BkAyOGk/AAu8guHS+mU/NbcekN6R7XfkmN4oZlAJee/
	 35L6pt8eoh9KgfQudDoAVGG0+2rXzSkNxCAFdGlzKbrgHBAqOqb+pC2wS1/JBEZtQ/SYK1VaRC+9
	 KkUO0+xVGKzFRqJfOuNwqwYYJ5qS+zReaWC6HMugL0J3dY0Tm6XcwUfLbPzzjRVWHAsAhYXv+HXP
	 yMWNaJYOlJIjIJBu+lSaUwAKSKQ5MyMr5MNROH8fex4S3mAltt8kzkyUrp8cjq6ts+9/qVmhTSZx
	 UGZTlIeuWWIGOYCF9j+o+Zhm8xvfAAGoHP8bMi+vsEHSxDLkcyxMZAHpnAajs1YqJR3ZvejKdHQQ
	 O4fAvEfZz36wH+0s1pKtcX1//AHBcPOaTkUQPOoDYxWE0EL3f3r3Dr9TaK6fs1dXJQyfF3c8PM8T
	 noZ6uF+qeQtrDt4hEeO4k7zEtTwEEn9A3lp6GXobVYLJWm7cfdDBEbU8L3iH5+kqnnRaTF+9jwwv
	 +dU+CUUOWMUiPU7UsArQejXDp25/VjgkkON0mFDjq3JYWnfh03EkBwDonTHpeCSEQC7q+FboVzvu
	 To44bomw6TCbagDNjT7/nhzuOk/wxGoPtc1hQzH3PbiI62Hh82I4aYVv6r+V3Xl5mi9GP21ZGy4A
	 s84JT0XuWcEfpJyO1wFMvY+rAfQKm5Zou8v6meyW3gwLT5jbEISIJeEmWRdqIqUfcwIWZ/ILw3CC
	 xLh3OzOzwRi2YDoyIiWmKLAuQ/JipTk3UZqzGIa7eh4s2exXlvJHB9zvP0oOxGGzkKO7v2VCpT2t
	 7ayye7ilvKzBQnpVsk36L//fLci5wQq0CplU6YBXj9jk5z/BR81XAcMIBe5Arl7ryyvIELPjsG/O
	 SBUm6gw0OrVrdzte4CpsbCrbnCffqiwGYYPEJs792MRtJYIUrJjJWWMr81fssM4wTXBe6hvp0OTh
	 Xh5g+xZOkJPsSLZCF8i5nzpO2t35Pz6o5MJfoEEBmJi59Bfgl4MQ==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: wodemia@foxmail.com
To: alexs@kernel.org,
	siyanteng@loongson.cn,
	corbet@lwn.net
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Zou <wodemia@linux.alibaba.com>
Subject: [PATCH V1 RESEND 1/1] zh_CN/admin-guide: Add zh_CN/admin-guide/numastat.rst translation document
Date: Tue, 18 Jun 2024 10:47:37 +0800
X-OQ-MSGID: <20240618024737.76204-1-wodemia@foxmail.com>
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

Signed-off-by: Tao Zou <wodemia@linux.alibaba.com>
---

I apologize, the previous PATCH had an incorrect email address for linux-doc when it was sent, so I need to resend it.
 
 .../translations/zh_CN/admin-guide/index.rst  |  2 +-
 .../zh_CN/admin-guide/numastat.rst            | 50 +++++++++++++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)
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
index 000000000000..4f7fee557cb5
--- /dev/null
+++ b/Documentation/translations/zh_CN/admin-guide/numastat.rst
@@ -0,0 +1,50 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/admin-guide/numastat.rst
+:Translator: Tao Zou <wodemia@linux.alibaba.com>
+
+.. _cn_numastat:
+
+
+===============================
+Numa策略命中/未命中统计
+===============================
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


