Return-Path: <linux-kernel+bounces-332742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1AB97BE39
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 16:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A300F1C21237
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457A31BF33A;
	Wed, 18 Sep 2024 14:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="qic/ifI4"
Received: from mr85p00im-zteg06022001.me.com (mr85p00im-zteg06022001.me.com [17.58.23.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3E91B9B41
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 14:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726670913; cv=none; b=kANr7H0HDG9bJDFnv9KRZIaeiGRt7QtlAHY7slDsa0bGqIwMj570uM111Tl3JbuJzJpruy0s8ErR19xfe6XsSCIw0Cc5bfd5PUOeMpc6NvS9nI9iOO1igogyGx7NdfSAdbEqWGvW7PRlNoMoOrz2v8Tu2me5kcSnZF7wIgjDJdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726670913; c=relaxed/simple;
	bh=VhKwPA5VPwtCz834reUj0Yt9WHCUgE4SAi/V86p8O/Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ftr0O7lPjZ6iv8s6MjzB7afKVOC5vYiNTVmDTgBeuKoEWq31qjrA6Q34mkjdBj7WNB1c7JhB5/+Ve8Qi2mVk1uhorfdJJ6uLlQ8QRymOs5kvzXXiJ0YbdCVaqR2C6BneNuQaPMrEAsmqcVq/AHrE/LWUUsesHBgEWWnvre7gvUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=qic/ifI4; arc=none smtp.client-ip=17.58.23.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1726670910;
	bh=wtlf4h6AAz2c2aJAMy34JanAf3vVh2xC4mB4nDOXmdg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To;
	b=qic/ifI4mF2oXKciY7LUAxH9Vkx+mkebCyC9ovEX31w8Ww4sHVXIPIXpplOCN4J1j
	 IfJCRuaBjKBCKdGeZYm4uMC4iP3ulgIaDWDviHsqrZNEU3izEYC6C5RZb6WE0vktI5
	 QdOw8g1HiJR+o9KS6KDx65B6s5iWJdtAYOQrUnjo4oUB6akgNyJjY6sYKJKzsuhI5e
	 IxTTEgHJemk5SeXKNowce6Gok6xn+HvlmqgGVVLKGFMCy7yLXiCwC2SUy/ROuGzF3x
	 ku6ouAl4OlpxH9WE5j93fxQyULcNHmWoDnhCUmaGww9EZ/xClo1tDW2V165rfUd+ws
	 5lVCyfDmzIpyg==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06022001.me.com (Postfix) with ESMTPSA id 8DFDB8002E2;
	Wed, 18 Sep 2024 14:48:28 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH 0/2] lib: devres: Simplify both API devm_iounmap() and
 devm_ioport_unmap() implementation
Date: Wed, 18 Sep 2024 22:48:12 +0800
Message-Id: <20240918-fix_lib_devres-v1-0-e696ab5486e6@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACzo6mYC/x2MWwqAMAzAriL9dmDnwMdVRMZ0VQui0sEQxLtb/
 AwkeSCRMCXoiweEMic+DwUsC5i3cKxkOCqDrayrOmzNwrffefKRslAytUWqEQO6JoBGl5Aa/3A
 Y3/cDuxTsa2AAAAA=
To: Andrew Morton <akpm@linux-foundation.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: 0n1nTAuTUssfob8J_KitzD7wuHgGPyNj
X-Proofpoint-GUID: 0n1nTAuTUssfob8J_KitzD7wuHgGPyNj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-18_10,2024-09-18_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=679 malwarescore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409180096
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

This patch series is to simplify implementation for both API
devm_iounmap() and devm_ioport_unmap().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Zijun Hu (2):
      lib: devres: Simplify API devm_iounmap() implementation
      lib: devres: Simplify API devm_ioport_unmap() implementation

 lib/devres.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)
---
base-commit: 6a36d828bdef0e02b1e6c12e2160f5b83be6aab5
change-id: 20240918-fix_lib_devres-321e311a147a

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


