Return-Path: <linux-kernel+bounces-360478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AD8999B98
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C21E41C22640
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 04:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F117A1F4733;
	Fri, 11 Oct 2024 04:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="f013Btbg"
Received: from out0-204.mail.aliyun.com (out0-204.mail.aliyun.com [140.205.0.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7741C57AA
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 04:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728620434; cv=none; b=MXnF0nVPYucu300+3RIc18wHvPRq+du1Vn0JEsqX/AEI29/OpgSxRq3yFGIlh5aYkrXao7zGNRtkRGrrWLP0Mtwpk1DdysNRn0OADwjExw6118XVO3Jget2Eb/pTBoOXw0jg7piYfu6j7I8aZ0bKjC8YhtuWl5FAK1VID3GoTZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728620434; c=relaxed/simple;
	bh=ZsYo2T/bqu4tq9UIJopEojPy3JaHqKnJRWbfZ5DyoZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=niKTe3xiDxYO7lxI848K/9UqUAdfjpbd0WNWuLouWmOAJ/9ysu6UnQUWYufZ+ZceBfDb2LFK2B9gkt3MD43FLZCEM/7EOiGRhb/DDIWaC+Qcot0hL9657uA3ifwVOdmJjcGtUHzDm4RcpYhb6lYnLrjViplg8O+R/Tv4AWwNeUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=f013Btbg; arc=none smtp.client-ip=140.205.0.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1728620428; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=5FGxvE++JZaYDMBJ9FqjCNXnX4zxFosLHXSH+gJCOYg=;
	b=f013BtbgWyZZKRAVpbsIa8TvrbKeYBNJvdx34oM6qjweQ7pTvetVskdbeFJ8M7d0zT7rkDyhKgvbsSRA5Ek7JNEO2CrWthjE7OinS0V3zEPgKk/zOSnKlywunswbb4Lc9YTXssWygrw0eXIrf2ZTW6Lzc/YUFiCdcQ59LZKXiNI=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Ze33tyg_1728619495)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 12:04:55 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 4/9] um: Do not propagate dtb parameter to kernel
Date: Fri, 11 Oct 2024 12:04:36 +0800
Message-Id: <20241011040441.1586345-5-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011040441.1586345-1-tiwei.btw@antgroup.com>
References: <20241011040441.1586345-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This parameter is UML specific and is unknown to kernel. It should not
be propagated to kernel, otherwise it will be passed to user space as
an environment option by kernel with a warning like:

Unknown kernel command line parameters "dtb=/foo", will be passed to user space.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/dtb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/kernel/dtb.c b/arch/um/kernel/dtb.c
index 4954188a6a09..73369446ed1e 100644
--- a/arch/um/kernel/dtb.c
+++ b/arch/um/kernel/dtb.c
@@ -31,6 +31,7 @@ void uml_dtb_init(void)
 
 static int __init uml_dtb_setup(char *line, int *add)
 {
+	*add = 0;
 	dtb = line;
 	return 0;
 }
-- 
2.34.1


