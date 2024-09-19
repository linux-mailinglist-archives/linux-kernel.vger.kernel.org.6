Return-Path: <linux-kernel+bounces-333773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C8197CDDB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 20:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62A6B1C22149
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 18:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3BC2F86E;
	Thu, 19 Sep 2024 18:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=internode.on.net header.i=@internode.on.net header.b="aBjBiQxO"
Received: from omr000.pc5.atmailcloud.com (omr000.pc5.atmailcloud.com [103.150.252.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C433C25624
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 18:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.150.252.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726772131; cv=none; b=II8uZzekwUODM3ERJ5Dbp7W/DroVci0N1vT0kQK0dbEhRLxK/fG8NwCypMZykD5Ra883V9XAvtJktIizyHKxq8NBe8LAN9/DRe+yxC/6Aq7hueE3o/v/6Wm15gI8kmf2ccrT1juj0Tjom5IQPOp7L58M4gryIlcP/sc77FqPZbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726772131; c=relaxed/simple;
	bh=chaRijaW/4ADbHv2b3PNvl3AH4FWg2/8ru69hKxIMng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mO4zMsA6VJ2Q+XZ3nPaR/SJ6cwOVHDWhdMsyoNeV8w9I4isqG/IDLMr9YV84dQidv1SkCrcvN2VUcfknqi3ZyI5/JZpZGR4UtALpx/7B1EIFWchFulOfps88UJ4JHfpl0cC3v4JpfwKMq3k5+R9osMnOhbzecmoFkR2GhuyyBxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=internode.on.net; spf=pass smtp.mailfrom=internode.on.net; dkim=pass (2048-bit key) header.d=internode.on.net header.i=@internode.on.net header.b=aBjBiQxO; arc=none smtp.client-ip=103.150.252.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=internode.on.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=internode.on.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=internode.on.net; s=202309; h=MIME-Version:Message-ID:Date:Subject:To:From:
	content-type; bh=CNvzFe9fGd98RlReCYS+NNkkhCDG6VKvF/0EOMmVuWw=; b=aBjBiQxONcG+
	WStWCQNFMDyM5XL8L1jEzI2qqij749Gda8n53drz+derd8HA4XwjKNa1vC5DUQSy7cyHzmZZFGv/i
	G+nnprzZT7RD0myzz/ZaRUj4YYxRhCBLVjgZZyFZH7sAmglhQi35Q18txbtpwAK2d1sga2+NtVtzS
	cvf6N0YJ+WBlWG4v4QV8JyCDTRXH0LecxI/++lVRzLSvTsqUs+EBwPtRX2Zm+RnIrG47s2/xXCkbM
	7f9S5CEcTO7E09RwZmIP6KPW0RQrpHSGLZy77sAn0GMAh3vSQjJqElpc4FhJRUPPtZP1sMvxuFBXa
	1em9/3Q+IyV26dom6HPYbw==;
Received: from CMR-KAKADU01.i-02175a00542f9bb7e
	 by OMR.i-011229ae50fa0cd71 with esmtps
	(envelope-from <arthur.marsh@internode.on.net>)
	id 1srKST-000000006NL-2t4y;
	Thu, 19 Sep 2024 16:56:45 +0000
Received: from [203.173.7.72] (helo=localhost)
	 by CMR-KAKADU01.i-02175a00542f9bb7e with esmtpsa
	(envelope-from <arthur.marsh@internode.on.net>)
	id 1srKST-000000004vD-06HQ;
	Thu, 19 Sep 2024 16:56:45 +0000
Received: from amarsh04 by localhost with local (Exim 4.98)
	(envelope-from <arthur.marsh@internode.on.net>)
	id 1srKSP-000000001Cq-1EPo;
	Fri, 20 Sep 2024 02:26:41 +0930
From: Arthur Marsh <arthur.marsh@internode.on.net>
To: wuhoipok@gmail.com
Cc: Xinhui.Pan@amd.com,
	airlied@gmail.com,
	alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org,
	christian.koenig@amd.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	tzimmermann@suse.de,
	arthur.marsh@internode.on.net
Subject: drm/radeon: remove load callback from kms_driver
Date: Fri, 20 Sep 2024 02:26:40 +0930
Message-ID: <20240919165641.4632-1-user@am64>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240630165949.117634-3-wuhoipok@gmail.com>
References: <20240630165949.117634-3-wuhoipok@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Atmail-Id: arthur.marsh@internode.on.net
X-atmailcloud-spam-action: no action
X-Cm-Analysis: v=2.4 cv=S/DfwpsP c=1 sm=1 tr=0 ts=66ec57cd a=q73fGBFtUWUW5y4nvQjQTA==:117 a=q73fGBFtUWUW5y4nvQjQTA==:17 a=EaEq8P2WXUwA:10 a=x7bEGLp0ZPQA:10 a=pGLkceISAAAA:8 a=aIJAOKreiCTeCyBpU-sA:9
X-Cm-Envelope: MS4xfHYppumKWIUnyI2Ju0M49vhnvlI5I58KLh4+FPPY2NoGJ2kbZEMp8UJ0GP5RcBj4Y7lrVRzdx8vKa/zkhB+xX2yttGtN9cY+gbgwMpCjdJRG9KUiZfoW mgFQnH+Gory5lpvGZtlBfdI/y0NdXfFypS6yxqGrTmIK0ZplfmRYhuA0wyzStGh3shfYwSgojx+DgA==
X-atmailcloud-route: unknown

Recent kernels resulted in a blank screen, with Xorg.0.log reporting:

(II) [KMS] drm report modesetting isn't supported.

Sometimes while bisecting the pc came to a complete lockup (magic Sysreq 
unresponsive).

At the end of bisecting I had:

90985660ba488cd3428706e7d53d6c9cdbbf3101 is the first bad commit
commit 90985660ba488cd3428706e7d53d6c9cdbbf3101
Author: Wu Hoi Pok <wuhoipok@gmail.com>
Date:   Sun Jun 30 12:59:18 2024 -0400

    drm/radeon: remove load callback from kms_driver
    
    The ".load" callback in "struct drm_driver" is deprecated. In order to remove
    the callback, we have to manually call "radeon_driver_load_kms" instead.

This machine reports having:

AMD A10-6800K APU with Radeon HD Graphics

with the gpu appearing as 

Advanced Micro Devices [AMD/ATI] Richland [Radeon HD 8670D] 1002:990c

Regards,

Arthur Marsh.

