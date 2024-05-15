Return-Path: <linux-kernel+bounces-180131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C278C6A74
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804AD1F22D25
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6B2156649;
	Wed, 15 May 2024 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eobG6Nhv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1167543144
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715790150; cv=none; b=HFmozkS9b/AM5yaZhq1VkJoF4Vm91FBDHFk7N40jBBj1mDv2uj8E8fU+WRQxJQXDkeGxijtHmfIqYQlBBd1gjckSr2JbEzL1iUqxtXJUnnfJ4OBrMY5uimKOxZxJhAjzgWrjlag1M5tG9FcMsPnt1B94AthWrWKjHGMZP5KjK0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715790150; c=relaxed/simple;
	bh=dyY5xHwj0t2PCxhheNyX2xM7JFQDx7iIcPYvy0V0ZcA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dMgmdl+AkdtiOz1xlZ3btg1qZ8u5/EClYYCTL/E0losuEOWakcYaic+ZCBiz2JKu44KA2Jdv3ZXvww8tYz8++jbFZINq+vyvKnPYF8U4yhBFgBnJIOVnb0Y1r4cfyz5vaKjuJJB+S+2TI2vUBe9C0ID6v8lZkW4nzvH2eihc1JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eobG6Nhv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D46C116B1;
	Wed, 15 May 2024 16:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715790149;
	bh=dyY5xHwj0t2PCxhheNyX2xM7JFQDx7iIcPYvy0V0ZcA=;
	h=From:To:Cc:Subject:Date:From;
	b=eobG6NhvC9EIz45JGu6GXyPPyCjZG1Z2MiAMmxt5uPAyZjX2YPE9fhJ1h/feCwZQR
	 f5w4ygry77wpZNWqgZoGu5pVObb52ysXFYzgp2IXnE0h9daEyghWuYSrIqEo6HPIVD
	 RfvzEc1TSylMr/xYUuwz5Ba3I1Sjf+5uB1dl7E1tOsfpPNBq5WFST5s+eTsmm/tFc2
	 TF/3CMKlVJI0CsW+TJASLex+sr9t+zUJS2h2tf7NnPEqb6BSPQJVV3+7re69BwV3ue
	 ewU6ymaybKa6vz9vnc5A2uGNSBKrI4h6wgf+pj2OnbSFCue7+8xUfuxPgHZCgEvKnV
	 eqaWmk41Dia3g==
From: Oded Gabbay <ogabbay@kernel.org>
To: linux-kernel@vger.kernel.org,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Ofir Bitton <obitton@habana.ai>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH 0/2] Update on habanalabs, Xe maintainer status
Date: Wed, 15 May 2024 19:22:20 +0300
Message-Id: <20240515162222.12958-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dave, Sima.

A few weeks ago I left Habana and Intel. Therefore, I'm stepping down from
the maintainer role of both habanalabs and Xe drivers.

Ofir Bitton from Habana will replace me in the role of habanalabs driver
maintainer and as for the Xe driver, Thomas and Lucas will probably suggest
someone in the near future.

Although I'm not going to do full-time kernel development in my next role,
I will remain as the accel maintainer and will probably continue to
participate in discussions from time to time.

Thanks,
Oded

Oded Gabbay (2):
  MAINTAINERS: Change habanalabs maintainer and git repo path
  MAINTAINERS: update Xe driver maintainers

 MAINTAINERS | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--
2.34.1


