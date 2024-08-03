Return-Path: <linux-kernel+bounces-273384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE1994689F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 10:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59CCA281D10
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 08:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF4814D2AC;
	Sat,  3 Aug 2024 08:05:44 +0000 (UTC)
Received: from mail.valinux.co.jp (mail.valinux.co.jp [210.128.90.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F67D847B
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 08:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.128.90.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722672344; cv=none; b=hnbHKNsDGwZle3MS/zPTGIx2Igr81iUSsPMYC0+KnmQ+nc9oZvLqtMBcPbzOrIHKCPt9NtM6LRyxyjRwbK8wdI22DDTQpboUw5bnNXTQuFgJAFzMYlUFGPWqKUiLxKJdPna76s4TUMvFo+2zokFGu+4gzbXMxJVIIBuA6j6llJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722672344; c=relaxed/simple;
	bh=SntP2W3aZTOJi6CPS/uvFvDAZ2GMZ5oYcuvjRqcnHGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T0Mt5pEu+PNJu3rwI1DhN0LxHrh4wzg2cqeqQKRf5iZqpQ8Bly3ovIhY3/YOUcJCH81NmZpws3UKQh6TuSIO+uWH5cUoarOvLTHctac2jTcrjKbTt/jmHNZeVhdAPZHOyN9GREUnMBYfU78KyPrwqUE9BQR/n5FxwUGzP+xiJXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; arc=none smtp.client-ip=210.128.90.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Received: from localhost (localhost [127.0.0.1])
	by mail.valinux.co.jp (Postfix) with ESMTP id 6C8D0A9DD3;
	Sat,  3 Aug 2024 17:05:40 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at valinux.co.jp
Received: from mail.valinux.co.jp ([127.0.0.1])
	by localhost (mail.valinux.co.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DduQScXsUTSd; Sat,  3 Aug 2024 17:05:40 +0900 (JST)
Received: from localhost.localdomain (p10213112-ipngn20001marunouchi.tokyo.ocn.ne.jp [153.220.101.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.valinux.co.jp (Postfix) with ESMTPSA id 00DB5A9DCF;
	Sat,  3 Aug 2024 17:05:39 +0900 (JST)
From: takakura@valinux.co.jp
To: pmladek@suse.com,
	rostedt@goodmis.org,
	john.ogness@linutronix.de,
	senozhatsky@chromium.org,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	lukas@wunner.de,
	wangkefeng.wang@huawei.com,
	ubizjak@gmail.com,
	feng.tang@intel.com,
	j.granados@samsung.com,
	stephen.s.brennan@oracle.com
Cc: linux-kernel@vger.kernel.org,
	nishimura@valinux.co.jp,
	taka@valinux.co.jp,
	Ryo Takakura <takakura@valinux.co.jp>
Subject: [PATCH v2 0/2] printk: CPU backtrace not printing on panic
Date: Sat,  3 Aug 2024 17:04:44 +0900
Message-Id: <20240803080444.221427-1-takakura@valinux.co.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ryo Takakura <takakura@valinux.co.jp>

Hi! 

This patchset fixes 2 issues on CPU backtrace during panic. The first 
issue was pointed out by John [1].

(1) The usual(non-panic context) flushing of backtraces written into 
ringbuffer does not work during panic as non-panicked CPUs can't do the 
flushing themselves.

(2) CPU backtrace triggered during panic has stopped working since the 
commit 779dbc2e78d7 ("printk: Avoid non-panic CPUs writing to ringbuffer") 
as it disabled non-panicked cpus writing into ringbuffer after panic.

Sincerely,
Ryo Takakura

---

Changes since V1:
[1] https://lore.kernel.org/all/20240729114601.176047-1-takakura@valinux.co.jp/T/

- Thanks for the feedbacks by Petr and John.
- Fix the issue (1) seperately from original patch.
- Fix the issue (2) by allowing non-panicked CPUs to write into ringbuffer 
while CPU backtrace is triggered as suggested by Petr.

---

Ryo Takakura (2):
  Handle flushing of CPU backtraces during panic
  Allow cpu backtraces to be written into ringbuffer during panic

 include/linux/panic.h  | 1 +
 kernel/panic.c         | 9 ++++++++-
 kernel/printk/printk.c | 2 +-
 3 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.34.1


