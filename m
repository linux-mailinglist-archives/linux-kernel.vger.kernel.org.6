Return-Path: <linux-kernel+bounces-360471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9AD999B82
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A49E1C2254C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 04:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F9D1F9411;
	Fri, 11 Oct 2024 04:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="UvrDOeZa"
Received: from out187-16.us.a.mail.aliyun.com (out187-16.us.a.mail.aliyun.com [47.90.187.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1911F4735
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 04:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728619822; cv=none; b=JEaWvVUfYQpdLiOfnIEZXeq2cL6kpOwGmi91FULjajWnHzmOitH4E89+jAKE9g3k0kKhoJrpccnurT6KmAmj5RdcwWbtWY0M6CUTbF50GPb/FYlan4lw+2HKa9X3EKBByayEFqos9YBYFZFjb8Xrkvx9jGVg2lTjYhXGDd19Yo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728619822; c=relaxed/simple;
	bh=ImHg/P+isWNA9PAYGzxPnP7O8vBmOa3MrpMDoWnfWrY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HUX5gXTC95TYZCZt8+p/gHtkBRAYhW/loPEZj0yhbZS00V4eybhZhKtKnPD46wQtuTBPU59fI8eRg7huyUmpS5k9dBAuxC7vlgpVTTfR8Ln+fd1WJsRJc3pZuXy/9+y8/BwWkKnQrBFL4aoa8vFNitVdkY7EGaUdM6PhKH90XdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=UvrDOeZa; arc=none smtp.client-ip=47.90.187.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1728619807; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=8NmPvcnWT91AsuQqlFB1CSKtDocctu2T6xzr5bt3FQc=;
	b=UvrDOeZa19fTJuzBF/p5pAanSN/i/N6Bc6ZJikMMLuXv5CyB3Yg8lDNjlbyIbwKga0Xf8UM5tGcLXgvnndMPRwbiFOcOYUpByF/QMCTbTD5VJtUzqVMby1EEssUb2QSL9eI6F8GvmL/4f2nTO6iurGBehsksbbOBufLwYxW7KWw=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Ze33ttH_1728619484)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 12:04:50 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 0/9] um: Some parameter cleanups
Date: Fri, 11 Oct 2024 12:04:32 +0800
Message-Id: <20241011040441.1586345-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tiwei Bie (9):
  um: Remove UML specific debug parameter
  um: Do not propagate mem parameter to kernel
  um: Do not propagate uml_dir parameter to kernel
  um: Do not propagate dtb parameter to kernel
  um: Do not propagate noreboot parameter to kernel
  hostfs: Do not propagate hostfs parameter to kernel
  um: hostaudio: Do not propagate dsp parameter to kernel
  um: hostaudio: Do not propagate mixer parameter to kernel
  um: Do not propagate initrd parameter to kernel

 arch/um/drivers/hostaudio_kern.c |  2 ++
 arch/um/kernel/dtb.c             |  1 +
 arch/um/kernel/initrd.c          |  1 +
 arch/um/kernel/physmem.c         |  2 ++
 arch/um/kernel/um_arch.c         | 13 -------------
 arch/um/os-Linux/skas/process.c  |  1 +
 arch/um/os-Linux/umid.c          |  2 ++
 fs/hostfs/hostfs_kern.c          |  1 +
 8 files changed, 10 insertions(+), 13 deletions(-)

-- 
2.34.1


