Return-Path: <linux-kernel+bounces-223537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC1C9114A3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 23:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A0C284085
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0D27C09E;
	Thu, 20 Jun 2024 21:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WdPzgKQ+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E357602B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 21:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718918986; cv=none; b=chJHtfPJ2dhoydZnoIaGNwXT5Y6N94KwtSork8vMQpEK0ssGYfc113iL7avgjjTYuPO2+LT7pSSAAkbpnJPCDvl1tp+x+QAg86Ab9Cee2byI19s9ElYUNlsPC9n2z0xWzm8QnoSmJ29bq+lCy8WnFzjhqPudqmS4yfNgARwVjdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718918986; c=relaxed/simple;
	bh=HqLTeh+hRuOdsMdCFhvUGmUrdGJHJjRocB8YnnMn0Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iZrriAOKgUeFfIU3PQ01W/75FeSpqs5gjFtOS72E/YiZALP2GHO5dYPWcLlT/a0hb7R9yefqRHa/cyAUnlaiEK6ShIWm3D34oFXzIXh3tvgnc5a3ZhdRZryOxqv0NSk7nG0pickpFa65vWfxag2lrIKXA2++VfBZuVU6ci72zMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WdPzgKQ+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718918983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HF79DDQtv0PLe7b6WwHL/CJcYBqjxqUaW/gWbVu1+DQ=;
	b=WdPzgKQ+D41D7zT+d5RbOzE13aVy69DLWSKig+eiexc+PyLJ6TOIjvEVHUKRoxyPUssXAT
	1qyoNgQVyM0SOV1gmVquRhbvWp0uEanUDgezMUDamGOM/eVwCW4iAcs2r9TUTPQPIGRoDE
	zxYkDUyux+MpwTcZbLraqJjORok3aKY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-PvgNEFPgM7a1bnwCnBVSqg-1; Thu,
 20 Jun 2024 17:29:39 -0400
X-MC-Unique: PvgNEFPgM7a1bnwCnBVSqg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B475919560B4;
	Thu, 20 Jun 2024 21:29:38 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.54])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C98F419560AF;
	Thu, 20 Jun 2024 21:29:36 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 0/2] mm/migrate: move NUMA hinting fault folio isolation + checks under PTL
Date: Thu, 20 Jun 2024 23:29:33 +0200
Message-ID: <20240620212935.656243-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Working on moving some mapcount related checks -- especially
folio_likely_mapped_shared() invocations -- under the PTL, where we are
sure the folio will remain mapped and the consequently the values are
actually expressive in current MM context, there are not that many
problematic bits to sort out.

This series tackles the NUMA hinting fault handling: we now perform checks
and folio isolation under PTL with the nice side effect that we have to
take less temporary folio references.

Did a quick test on a 2 socket system, NUMA hinting+migration on PTEs and
PMDs seems to continue working as expected.

Cc: Andrew Morton <akpm@linux-foundation.org>

David Hildenbrand (2):
  mm/migrate: make migrate_misplaced_folio() return 0 on success
  mm/migrate: move NUMA hinting fault folio isolation + checks under PTL

 include/linux/migrate.h |  7 ++++
 mm/huge_memory.c        | 13 ++++---
 mm/memory.c             | 11 +++---
 mm/migrate.c            | 81 +++++++++++++++++++----------------------
 4 files changed, 58 insertions(+), 54 deletions(-)


base-commit: a53138cdbe3ea8875405e96fa9cde64e24f4f9e1
-- 
2.45.2


