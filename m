Return-Path: <linux-kernel+bounces-380105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3E49AE900
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7BE1F23073
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDF98614E;
	Thu, 24 Oct 2024 14:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="qGASYWmC"
Received: from out0-193.mail.aliyun.com (out0-193.mail.aliyun.com [140.205.0.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF54D14F12F
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780439; cv=none; b=mE2gBHJuGGLp5W3CXIychC5Yuwq58g3FtkTirgXnyYXFQnwqTtmNXDCzmMgbzSJR9czNkopj4+ianPA86z/oHkQGyn5dYEn0Ub0joqUw3esKf0RWsqhMay2WS2bxgWSD87UefyoxOuN9LJ/NnslKUuVqIEKzLjHPs03ZA+W7WoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780439; c=relaxed/simple;
	bh=hHv32pTbIHeCcn4InqeoBgLkXlSccB/lv7UepkiorzM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S5puFXmI9vdfyVkEy2Yx+p3XTWUzRcHesYurKXo28scMgvgmw1sVyB7eYUWtm0seaUf20yPEjLgkkZbaTNp8hHYSY7eO3mwDuAYv/YMFprIKKKsYz8XvAhFJ70yPVQWm6Q6hLP2n4kdonHQqdK2U18mkYvyxFPXvrphLFGH82+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=qGASYWmC; arc=none smtp.client-ip=140.205.0.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1729780433; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=klL1ZgjZxIjtqjW3xwH+I3qTIyPhe6x0FsOJ1N0m5N4=;
	b=qGASYWmCipX/NVe8lj0L9u+DhTMyoNBhDwm8P6korJu/+tybCnaUSduPbjQMilcuDv0IIRU+4sp7bvn1pj3PLQcUDgJQ3LsrSRVMSM5ibpYoOKAvSdTYmVbliHUWfpyuVeYy+KfK7e1upZMbQbEI1ir9OYnrHu5DVNIXUsziJ0M=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZreBszI_1729780109 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 24 Oct 2024 22:28:34 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 0/4] um: Set parent-death signal for sub-processes
Date: Thu, 24 Oct 2024 22:28:24 +0800
Message-Id: <20241024142828.2612828-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ubd io and write_sigio threads/processes may leak e.g. when
the main process is killed by "kill -9". Fix it by setting the
parent-death signal for them.

Tiwei Bie (4):
  um: Add os_set_pdeathsig helper function
  um: Set parent-death signal for ubd io thread/process
  um: Set parent-death signal for write_sigio thread/process
  um: Use os_set_pdeathsig helper in winch thread/process

 arch/um/drivers/chan_user.c | 3 +--
 arch/um/drivers/ubd_kern.c  | 1 +
 arch/um/include/shared/os.h | 2 ++
 arch/um/os-Linux/process.c  | 6 ++++++
 arch/um/os-Linux/sigio.c    | 1 +
 5 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.34.1


