Return-Path: <linux-kernel+bounces-330169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7F3979A8C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 07:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A36A2B20E73
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 05:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A5E4C618;
	Mon, 16 Sep 2024 05:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="Lr3XnNI5"
Received: from out0-210.mail.aliyun.com (out0-210.mail.aliyun.com [140.205.0.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534DB50284
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 05:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726462834; cv=none; b=NVxHi7s4hHLoez7tGAeBnLjN1/KRkb1spkwpMlT1N7LSGQAhCQOoK4mfA5AbqXk5dlc4nhoEfoJQBMJ/jJtY/VUkgliXhfQ0Hkna+IccjAxXIkdUxl63wzfsHXyc5DqwXhU9FQ04ZBp/mDZWDcKRNk3GLHDvBDJocuWjmNQezAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726462834; c=relaxed/simple;
	bh=ce4wRwk8gpNOXbsBFkbMo0/grK2bV8MLHmm8TrU5jbU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qvL6phSbeXnD+2jfnII253RvdexaispaJvIUspjz71ID3+uhus+3aKJNlhydEyxLvgWBpoFcMTLBicSeYaoCU/H3yTW6VPYts+ipgjK/Blcr4BWLcdANpU+Wp1WmQY11G6YPH0cY6bZEWVfOJy3veZvjsdVXVLYLZKcwlvtPGbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=Lr3XnNI5; arc=none smtp.client-ip=140.205.0.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1726462802; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=LqAz2DZDSQfpAEuQL5O51eFz4tgSk7iYOPQ8/l20hj0=;
	b=Lr3XnNI5ZcjPlpd4ejrmAwx4V5IB7THn21Jv7pybaaf+Bf3QXSNm+AzSWhzOWrem8YWUqk/wfpQKZi5O8lXmqPPPj2H+tK/sIQ8Yi0YTLnjgbYZ49lMfmFlsCF41kfWGYD80Tzs1rePHPkZ1C6CDGsbSspjdCfOggiNtWyDEJ3w=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZKOkLOT_1726462796)
          by smtp.aliyun-inc.com;
          Mon, 16 Sep 2024 13:00:02 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
   <benjamin@sipsolutions.net>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 0/4] Minor physmem cleanups/fixes
Date: Mon, 16 Sep 2024 12:59:46 +0800
Message-Id: <20240916045950.508910-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:

- Add "um: Fix potential integer overflow during physmem setup";

v1: https://lore.kernel.org/all/20240913142137.248245-1-tiwei.btw@antgroup.com/

Tiwei Bie (4):
  um: Remove the redundant declaration of high_physmem
  um: Fix potential integer overflow during physmem setup
  um: Remove highmem leftovers
  um: Fix the definition for physmem_size

 arch/um/drivers/virtio_uml.c       |  9 --------
 arch/um/include/shared/as-layout.h |  3 ++-
 arch/um/include/shared/mem_user.h  |  5 ++---
 arch/um/kernel/mem.c               |  3 ---
 arch/um/kernel/physmem.c           | 36 +++++++++++-------------------
 arch/um/kernel/um_arch.c           | 19 +++++++---------
 arch/um/os-Linux/main.c            |  5 +----
 7 files changed, 26 insertions(+), 54 deletions(-)

-- 
2.34.1


