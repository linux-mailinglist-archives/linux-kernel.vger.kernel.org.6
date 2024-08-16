Return-Path: <linux-kernel+bounces-288826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F79953F32
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 04:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111D528389C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9812BD0D;
	Fri, 16 Aug 2024 02:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="VMBkWlrA"
Received: from out0-215.mail.aliyun.com (out0-215.mail.aliyun.com [140.205.0.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B301CFA9
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723773617; cv=none; b=Vc8dzVLPTiPoBplgvVUaxLO0ef3ohis+bMM1V1d3vNlr5zh0BSD4Q8Tx8rSXs9nx1nziUaQp3KRVAKOsyntAzbnHRrSnmIQKReqYa3ugG1Jz8KLyIbIm303addtMOywz9/ADjTNOSJlEADUpE6OZpzozgtOAgSSQY5/6R9tMfjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723773617; c=relaxed/simple;
	bh=XHoRfXf7x9ExGR2aGjdbQZVDY5xk2DFJPLdK1z61FC0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hCZuF32/8hpac+f6PXkqtcbKglvnkP3iEPVNWDG2R0/KKffG/KXJs5GznRGlI8+e1v6iWPCtkBXYgpt3uUnZjZcbssiNbI1ZiJNmZzvT/+KDjFioAngBZSvRMqMDlWeiVxZhQoRMXHlf+CULm3/K1ccKwZl+ZlcYsdLvWnK0ErY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=VMBkWlrA; arc=none smtp.client-ip=140.205.0.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1723773612; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=NRfAU3ymm8Wxy/p6rbnCYROMpjpqmee7bWrNxlEfXps=;
	b=VMBkWlrAdElbxo4HiBgTXaZKwUPLtii4f/ChyTW3gW4qWTGW+wBZxSwLi7h1GOMewkzOqoFXeejqx8fO81juQmYIKfblzXOw5rkgGcWAPigbIDy4dTDfXf64GxssiyvqskV8GA1Zy0YgbjR4MbdHHMiRzmuHwnkc3GYuzunJEMY=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.YtEBof7_1723773290)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 09:54:55 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 0/6] Some minor cleanups for UML
Date: Fri, 16 Aug 2024 09:54:41 +0800
Message-Id: <20240816015447.320394-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tiwei Bie (6):
  um: Remove unused kpte_clear_flush macro
  um: Remove the redundant newpage check in update_pte_range
  um: Remove unused fields from thread_struct
  um: Remove unused mm_fd field from mm_id
  um: Remove the call to SUBARCH_EXECVE1 macro
  um: Remove declarations of undefined functions

 arch/um/include/asm/pgtable.h           |  7 -------
 arch/um/include/asm/processor-generic.h | 10 +---------
 arch/um/include/shared/skas/mm_id.h     |  1 -
 arch/um/include/shared/skas/skas.h      |  2 --
 arch/um/kernel/exec.c                   |  3 ---
 arch/um/kernel/tlb.c                    | 17 +++++++----------
 6 files changed, 8 insertions(+), 32 deletions(-)

-- 
2.34.1


