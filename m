Return-Path: <linux-kernel+bounces-395226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9959E9BBA8C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E9428271D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E561C231D;
	Mon,  4 Nov 2024 16:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="PLUN+0xI"
Received: from out0-211.mail.aliyun.com (out0-211.mail.aliyun.com [140.205.0.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE8242056
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730738873; cv=none; b=M8G1uBKr0l6Ah+g0R7zF1I9hju68Z/fGEVhGVi8GKvrj/TsFnPZlvK6T/DknIh+56nDgB171+cYHxVDBuJNQTfnLtkcUVSCFzR6j+IyWPFpRbVawK3NT8VOCnizqd54u+gWD9NTIzgkHIUw5ld6keBGZHdinCF3dSYPwNwHnThI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730738873; c=relaxed/simple;
	bh=myZeYWpQYaiq+fTfZMK1OCk/vsr0TfYMNeOFF08Gm8A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T6jjoio8pi4J8EH5WbRDkg1h7HhcNVrCnNniEqd5BDku0XCWukF9UFdWbM7//yL4xz8ELhxK+0SC5kMyRnd3gA7KuR2jD/ZNnfOcDODZ/JF7oni8NUC2SJt2du+JyLVXZV95//4nb54g3zUbHavLxw4ZIGTRT/5Dz/SQ7/4/H+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=PLUN+0xI; arc=none smtp.client-ip=140.205.0.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1730738866; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=tbP+2lwAJPJ9A1CD88cVCLEMtQehziqPotA3rPigMM0=;
	b=PLUN+0xILhOX9WDy37cnnGAYYBZzcf99DNEVdHHvKue7Fgqi0QIAnvFG+uuhWet+2bIPmE062BdXkbVL8bpboDP+wu8jcFFrJuA26pjG3R32CWSRiPXah6A156lqAlSf8sO9SJOGqstHSJUiCh+vtsHSdeNUsRZlfd2y7KYP3BY=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.a0U4bCj_1730737926 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 05 Nov 2024 00:32:12 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 0/4] um: Some minor driver fixes
Date: Tue, 05 Nov 2024 00:31:59 +0800
Message-Id: <20241104163203.435515-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tiwei Bie (4):
  um: ubd: Initialize ubd's disk pointer in ubd_add
  um: ubd: Do not use drvdata in release
  um: net: Do not use drvdata in release
  um: vector: Do not use drvdata in release

 arch/um/drivers/net_kern.c    | 2 +-
 arch/um/drivers/ubd_kern.c    | 4 +++-
 arch/um/drivers/vector_kern.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.34.1


