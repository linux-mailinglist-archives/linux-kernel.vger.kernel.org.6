Return-Path: <linux-kernel+bounces-380797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 308959AF638
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 02:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FED1282412
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 00:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AD9AD2C;
	Fri, 25 Oct 2024 00:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d9gt2XxC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE027494
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 00:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729816664; cv=none; b=l7xSIzHoiD5GhZZYXh7Cb6pyDdoSP6m5d6/oYkBwmlb3nW/OIkUz21+rzTCt8OR0Xx37/l448u+mBYyl7D0mWXeu4TbFuTtqGMHPfYVeN6Bh5fu2vSfWhzFlQlBJ4KSUkJW+Hmn3AEwDV96Esv0wQ0FCr6btcdBHqVf5793ebHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729816664; c=relaxed/simple;
	bh=yrAbFN8l2uG864OjMtuHA7PmCXHYRca82Pm03xQNoiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ERnRukVNOATIlAqJoY9F2AmjVQ1ctkixUMbQaLrWQUoxOPD92g1f4+miBiNQqkRO8w+JvD8+/k02ZSN1VMdQuKxQUx05+Ej71M9KfOnGWwXjvyoERmsT9XYpnNq9K1AaWfbqr55KonP0gs0XbSLE6J5FUW0OxchkPg5m4AUCqbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d9gt2XxC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729816660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mWQ6P8ECAob7FcZr9Z6ZYB0b12pFhFDHYkv1F0PAn8Q=;
	b=d9gt2XxCEZh3XdLO4NvSYZiV6nVqrucKQuPvQldhPgrCeQGRFPgIbuLeNXH86qxzYXdb8z
	3nS8bNs+EOyY3AAi+FRfEElCckfj8MisT2Vx9z4j3e+6xRNTsLdbpFWh3LrRDSTrNm2mv2
	3xV34n7ussarDzdvXUagkfoVIP7DxbE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-0WE0eyiCOWKUiqhaUhVfjg-1; Thu,
 24 Oct 2024 20:37:36 -0400
X-MC-Unique: 0WE0eyiCOWKUiqhaUhVfjg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 956EA1955F40;
	Fri, 25 Oct 2024 00:37:34 +0000 (UTC)
Received: from localhost (unknown [10.72.116.27])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DCFC01956088;
	Fri, 25 Oct 2024 00:37:30 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/3] block: model freeze/enter queue as lock for lockdep
Date: Fri, 25 Oct 2024 08:37:17 +0800
Message-ID: <20241025003722.3630252-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hello,

The 1st patch adds non_owner variants of start_freeze/unfreeze queue
API.

The 2nd patch applies the non_owner variants on nvme_freeze() & nvme_unfreeze(). 

The 3rd patch models freeze/enter queue as lock for lockdep support.

V2:
	- improve comment log & document(Christoph)
	- add reviewed-by tag

Ming Lei (3):
  blk-mq: add non_owner variant of start_freeze/unfreeze queue APIs
  nvme: core: switch to non_owner variant of start_freeze/unfreeze queue
  block: model freeze & enter queue as lock for supporting lockdep

 block/blk-core.c         | 18 ++++++++++++++--
 block/blk-mq.c           | 44 +++++++++++++++++++++++++++++++++++++---
 block/blk.h              | 29 +++++++++++++++++++++++---
 block/genhd.c            | 15 ++++++++++----
 drivers/nvme/host/core.c |  9 ++++++--
 include/linux/blk-mq.h   |  2 ++
 include/linux/blkdev.h   |  6 ++++++
 7 files changed, 109 insertions(+), 14 deletions(-)

-- 
2.46.0


