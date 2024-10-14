Return-Path: <linux-kernel+bounces-363268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2B699BFD7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92B0C2843EE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 06:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55C513E028;
	Mon, 14 Oct 2024 06:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Z4xa+sbr"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DBD13D62B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728886393; cv=none; b=UioEhatTKov6Ie0Aj5IE38XcQNOTWRYkWRLqIYhvVerwhrHclzbmGoqbPKKJ5oZQL+fN75cScEp2+Ap71MW9kGsj6Bt6xP0oSAcjqyX137kENDvvWpLpZKZ9n3EGOobnsx4EFtmzR0ZMNcxkuUG+44azgtNo9JGVvlLF1MRPlaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728886393; c=relaxed/simple;
	bh=ib/zqlp3I1R02nEi+3/evWIldRvuKIHCVnH0oVdwMn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=An8KgnAqd4TgMINX+b0N+ZMGQazVNI83wjIrXXHbGzdxzZ/3xPtzG/0BwDqyWLPDQ0wZf7jafsnFjTu1Vjk8osGq3gmYisYga98TZvcS5N08fRJnjuDOK6OXR6L+OMiw7zMSxLP4bQ82mZNhRwqnBO5iwiaD3da5iPJXv8XgOgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Z4xa+sbr; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D08248BE;
	Mon, 14 Oct 2024 08:11:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728886282;
	bh=ib/zqlp3I1R02nEi+3/evWIldRvuKIHCVnH0oVdwMn0=;
	h=From:To:Cc:Subject:Date:From;
	b=Z4xa+sbrYvIobPkh0viGsFcpdJjpTouuBty4Vv/5VqrYkrmO4HKhVBYba/Qg2a8i4
	 e1W9qDBZRbZQLk4Uy1Klbmew4fYs8W5MDSrdpax5nuuAhh1QVaVOy6sfCt4ZI1pX6M
	 eBhqaNNplnuAHM6p+9LN8MwvmVQpDlI+lqgLc1qg=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	kernel-list@raspberrypi.com,
	Stefan Wahren <wahrenst@gmx.net>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v2 0/2] staging: vchiq_arm: Two memory leak fixes
Date: Mon, 14 Oct 2024 11:42:54 +0530
Message-ID: <20241014061256.21858-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two memory leaks were identified and this series addresses those leaks.

changes in v2:
- Split patches into two

v1:
- https://lore.kernel.org/linux-staging/b176520b-5578-40b0-9d68-b1051810c5bb@gmx.net/T/#t

Umang Jain (2):
  staging: vchiq_arm: Utilise devm_kzalloc() for allocation
  staging: vchiq_arm: Utilize devm_kzalloc() for allocation

 .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c   | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

-- 
2.45.2


