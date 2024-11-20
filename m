Return-Path: <linux-kernel+bounces-415859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D465C9D3D4B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E8131F21FC3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86C31B5820;
	Wed, 20 Nov 2024 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="boiHvcTO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954961AB523
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 14:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111787; cv=none; b=WjT/2t+941XvLdQhWtw9K3458bBd64/O+Mubt99FYoHh9cIWHP7A6cbvUE5BRwFBcmD9EQLjDzkO20HSPKEFnk7DBRXxliKEZFlwp/Pa4iXWYHBqDfVqcbK0K27ZNozum9ESYaUb0zed8Emqr+9AM2DM8aLNOMHSt9rLCE1vyrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111787; c=relaxed/simple;
	bh=kTPHfsq4DJAcWWjUzh3BGlulaCBUrfKYBfa77ltIsvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y0V8DjbMewm+3+09XpICjsLSyR6OhHmumCv7IkjXPTWgPzsab1w49PMtiEpcMlTWLB5PveX1bXnieVI5sRjov1qi7VuBwLVpnVDqelz/54bsihHnXO7MxrfxDrJXwkbhEu0Qbn5RyFTkbJtuscW93uUXdV6Wb1P5UxHlWuxVs7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=boiHvcTO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732111784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zrUcZWPztkGVBiyMC7XdsN6uvVC0ZWFJvxTNJD+Z3sA=;
	b=boiHvcTO1HvjskT3CmeITjCbGosBACnbPt5kJetBlFG4hzJ1H/Pg4uTzZs2xfOLKXIYAlW
	EETfKt4VYjuuAVgz+e2jkhHjkH3gc4k7INe9OwTsfwbGPx9IcOh9+gJSJRlMqxmy2J0D7P
	eiLPfpDYAUm4ZH5Q2CTrgCIOLB1kdRQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-j7GLY49kMEuUecpW9LA-WA-1; Wed,
 20 Nov 2024 09:09:40 -0500
X-MC-Unique: j7GLY49kMEuUecpW9LA-WA-1
X-Mimecast-MFC-AGG-ID: j7GLY49kMEuUecpW9LA-WA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E7C819541BE;
	Wed, 20 Nov 2024 14:09:38 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.74.7])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BFF101955F4A;
	Wed, 20 Nov 2024 14:09:36 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 0/2] two fixes for pNFS SCSI device handling
Date: Wed, 20 Nov 2024 09:09:33 -0500
Message-ID: <cover.1732111502.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

A bit late for v6.13 perhaps, but here are two fresh corrections for pNFS
SCSI device handling, and some comments as requested by Christoph.

On v2: add full commit subject in 1/2, change the caller in 2/2.

Benjamin Coddington (2):
  nfs/blocklayout: Don't attempt unregister for invalid block device
  nfs/blocklayout: Limit repeat device registration on failure

 fs/nfs/blocklayout/blocklayout.c | 12 +++++++++++-
 fs/nfs/blocklayout/dev.c         |  6 ++----
 2 files changed, 13 insertions(+), 5 deletions(-)


base-commit: adc218676eef25575469234709c2d87185ca223a
-- 
2.47.0


