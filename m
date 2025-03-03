Return-Path: <linux-kernel+bounces-544685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96646A4E461
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271E28A0EB7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11A727C852;
	Tue,  4 Mar 2025 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="siAw71ck"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421E827C844
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101930; cv=pass; b=aJnHVBC7TovPlo3RSE9WWmlvdgW1yepyX9wmMeheqRF2gOKMEUbUr3jwLHsvO2tfMwCwfDhb7xYqJGu3NaxDoqYwQEklnmfFrELBSdG/5okPFKzuTU5w6GAB00gFn6/k59zxh3GnXIBUutwHkvhshuYWF1rx+7aNH2OF/8dY44o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101930; c=relaxed/simple;
	bh=r3mxuMjNusqmirVJKOK5JOo0+qILqWy0KjInHbfQg3Y=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=cIfyVcLD2jZb2m94mtTKezrrBfBFZsE4Drr1bsDJik2Ngi0ZQVTxRPXJ+vkypC7/reHWrmcR+yfbLwffno1Zd0R/c56bP4vCZmqQqax1L2kdDNWpYJXoYjFdbVgDG9w4hehMPirVZTMSsVkcc9a7aB1vD+i0eBAKMO9Q45QjhZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=siAw71ck; arc=none smtp.client-ip=185.132.180.163; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 64D1F40CEC8C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:25:27 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=siAw71ck
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fbC1yJXzG0BM
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:23:35 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 5ED8841898; Tue,  4 Mar 2025 18:23:26 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=siAw71ck
X-Envelope-From: <linux-kernel+bounces-541704-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=siAw71ck
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 6C9AF420BE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:30:36 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 427EE305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:30:36 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E941896D37
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8AA21171F;
	Mon,  3 Mar 2025 12:29:58 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8B620F093;
	Mon,  3 Mar 2025 12:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.180.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004995; cv=none; b=ciB0b3sDguxQf0+H8dGmRGIXRcIugA37aanch95oQfiWob0XOrjcxcBCu9HYUEK60VDdVA3XkNRrtU8tFa9f57VbrfZJt4+zRVE+x+jwk3YxErDF5P3+XTinw01sIKLAjkzHXUd0L53ngcOE4z4iGOj/e2Z7UBbORlTVvUghrHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004995; c=relaxed/simple;
	bh=r3mxuMjNusqmirVJKOK5JOo0+qILqWy0KjInHbfQg3Y=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=iv9QGnaGyoET6EvUiSTuVl42E/vusi2XzNIF656VeN541UfM/C9dJYEKZ4tWfAOL+K75c7Zpnu3w0Pjysk7RbDdfpIfjLW4JB1QyKsO9Nk8ozCbvXRWc0XNKc8AMSv4CO3AZdF5hIB1QW9s7Up7MGtP2oB+Ch4lMrQ0xE/E/qVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=siAw71ck; arc=none smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52382ge9017916;
	Mon, 3 Mar 2025 12:14:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=7
	HBksRmujiRqIhNMXWm0stTBBO2G8Z6mwPtk8Cx3/I4=; b=siAw71cknw6UcArEi
	KI2X+NtfzjLCrCpIBNyKK1AMdQ2nRJPzdvXV1IX70Lrtgg0YmTAPb9wxsbyZLuFf
	LqYXtePCrMCTCK039JRsJO6Aunc/KEd0XibKFbjezJS7TceS709/l52RGTMVCw1F
	+8R+NaZpwAarOvr8CMDvsivEil2Lk7GT5ASBs6UY8skmClFJ8U5oDt9vDwX7XP0A
	uB4XfAJuvxksC5hOc1SCvOZKYVNpKjG6FTIC6rkuEGu9xk69/9wGBlWRZoPq2nl3
	8qIrV6/KMlcHMlL1qV4CobbujgPiEZJaSksqG64Fy7QqrC5m4dqyQzqliOHbON03
	3qYaw==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 453u711fe4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 03 Mar 2025 12:14:28 +0000 (GMT)
Received: from Matts-MacBook-Pro.local (172.25.8.157) by
 HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 3 Mar 2025 12:14:26 +0000
From: Matt Coster <matt.coster@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Brendan King <Brendan.King@imgtec.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, Brendan King <brendan.king@imgtec.com>
In-Reply-To: <20250226-fence-release-deadlock-v2-1-6fed2fc1fe88@imgtec.com>
References: <20250226-fence-release-deadlock-v2-1-6fed2fc1fe88@imgtec.com>
Subject: Re: [PATCH v2] drm/imagination: avoid deadlock on fence release
Message-ID: <174100406750.47174.5779964447854559103.b4-ty@imgtec.com>
Date: Mon, 3 Mar 2025 12:14:27 +0000
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-GUID: bpIBZufc03XJfFS43l1NXtmySg71wGFl
X-Authority-Analysis: v=2.4 cv=LrJoymdc c=1 sm=1 tr=0 ts=67c59d25 cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=LHZ2_XVCwAsA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=r_1tXGB3AAAA:8 a=Jn6vUoLUptEalpbYKOgA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: bpIBZufc03XJfFS43l1NXtmySg71wGFl
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fbC1yJXzG0BM
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741706621.48343@qExXTA/fP2NFKOGv4x/zng
X-ITU-MailScanner-SpamCheck: not spam


On Wed, 26 Feb 2025 15:42:19 +0000, Brendan King wrote:
> Do scheduler queue fence release processing on a workqueue, rather
> than in the release function itself.
> 
> Fixes deadlock issues such as the following:
> 
> [  607.400437] ============================================
> [  607.405755] WARNING: possible recursive locking detected
> [  607.415500] --------------------------------------------
> [  607.420817] weston:zfq0/24149 is trying to acquire lock:
> [  607.426131] ffff000017d041a0 (reservation_ww_class_mutex){+.+.}-{3:3}, at: pvr_gem_object_vunmap+0x40/0xc0 [powervr]
> [  607.436728]
>                but task is already holding lock:
> [  607.442554] ffff000017d105a0 (reservation_ww_class_mutex){+.+.}-{3:3}, at: dma_buf_ioctl+0x250/0x554
> [  607.451727]
>                other info that might help us debug this:
> [  607.458245]  Possible unsafe locking scenario:
> 
> [...]

Applied, thanks!

[1/1] drm/imagination: avoid deadlock on fence release
      commit: df1a1ed5e1bdd9cc13148e0e5549f5ebcf76cf13

Best regards,
-- 
Matt Coster <matt.coster@imgtec.com>



