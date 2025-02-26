Return-Path: <linux-kernel+bounces-534999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB779A46DAD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B78073B0929
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F10260A2C;
	Wed, 26 Feb 2025 21:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="NvaNvXKm"
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7359525EF86
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740605941; cv=none; b=qR+S5uLMmLdqiFpYykkEZE7bb+W5sJrTsCkQRsfnI1px680ZSSTF8JGXooORAAXcKNuXTNsh80OjcGUCguING2j0MtUVgKzPcAvLkIuD6DIh1VHCyMt1U4WaMShfLhVX6YYrW0+SXm5ulUlwKYYR0+bhlmSE4gtPjp4Leeu2dys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740605941; c=relaxed/simple;
	bh=ZNex3sNHO1gK7hwC1yQ98UDg1F2Y+2a1P6/fzIJSBx0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YdD9Ap+65PD/tT9RbLsQa27x3jWG+6+Wo/SayPVa6H9/KL+xkfQV2p1+GkUFD+eUmm5YFU5J6/U7GzskH6IZ91H9h4/fKctVrpNw5VtHkZcRZegvzyKJDaswKYuGXEQ7Nird+W13Jt890TkWsPtII64pdxbEgfdojmUkzpzh6U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=NvaNvXKm; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QLbeON001971
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:38:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=TZ9PNSGnUmWogA7wUt
	UsRsbdSZ0fPSdGDef34CF3mKc=; b=NvaNvXKmNEp8xMkea0V3voYEGwyamwIAEc
	yUcTFhwRAzEEl72WsQhNIGl9YoLXu8g0FTvA7tQUp9U3xJQHculrU/05MYvfI9sV
	Cs+dj2bs6cUVJAzIWBECGPEQ7RH25m0w0ZLKR4iON2/OMzi35ATYhy5o8l+O+O3l
	peEK3NUYMd+h6lHELU9Pe99XUJCv31X508SZk7y83sUIcSq3YoHekWhxSjw4E0sD
	lBCdNVieBer5VdKzGAnUCl3g8sq+4lGc4s78pEmucM7ZCMpOr8W0Z/fzr33fBXhF
	8cSPYd9mvzujbh0H5rVRoni/+2WoPPDgka2DGt3Wh8E1TisqtnlQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4528hu9ae6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:38:58 -0800 (PST)
Received: from twshared11145.37.frc1.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 26 Feb 2025 21:38:49 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 2E7EB187DD4FE; Wed, 26 Feb 2025 13:38:45 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <pbonzini@redhat.com>, <seanjc@google.com>, <kvm@vger.kernel.org>
CC: <x86@kernel.org>, <virtualization@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 0/2] kvm/x86: vhost task creation failure handling
Date: Wed, 26 Feb 2025 13:38:42 -0800
Message-ID: <20250226213844.3826821-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: NaRcN9fcFclURv9jahVw-ZCO-BrROMM6
X-Proofpoint-GUID: NaRcN9fcFclURv9jahVw-ZCO-BrROMM6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_06,2025-02-26_01,2024-11-22_01

From: Keith Busch <kbusch@kernel.org>

The suggestion from Sean appears to be successful, so sending out a new
version for consideration.

Background:

The crosvm VMM might send signals to its threads that have entered
KVM_RUN. The signal specifically is SIGRTRMIN from here:

  https://github.com/google/crosvm/blob/main/src/crosvm/sys/linux/vcpu.rs=
#L651

If this happens to occur when the huge page recovery is trying to create
its vhost task, that will fail with ERESTARTNOINTR. Once this happens,
all KVM_RUN calls will fail with ENOMEM despite memory not being the
problem.

This series propogates the error up so we can distinguish that from the
current defaulting to ENOMEM and replaces the call_once since we need to
be able to call it repeatedly due to this condition.

Changes from the v1 (prefixed as an "RFC", really) patch:

  Instead of using a VM-wide mutex, update the call_once pattern to
  complete only if what it calls is successful (from Sean).

Keith Busch (1):
  vhost: return task creation error instead of NULL

Sean Christopherson (1):
  kvm: retry nx_huge_page_recovery_thread creation

 arch/x86/kvm/mmu/mmu.c    | 12 +++++-------
 drivers/vhost/vhost.c     |  2 +-
 include/linux/call_once.h | 16 +++++++++++-----
 kernel/vhost_task.c       |  4 ++--
 4 files changed, 19 insertions(+), 15 deletions(-)

--=20
2.43.5


