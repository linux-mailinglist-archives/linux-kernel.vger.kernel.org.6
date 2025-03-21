Return-Path: <linux-kernel+bounces-571187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC7DA6BA40
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D25487284
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FBD22687A;
	Fri, 21 Mar 2025 12:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8CDLVPE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4BF1E7C05
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742558574; cv=none; b=sxwjxDMHm7Og6WG19zhG7CzSt/dfRDInXvVy1yqsatHGC60F7hfYs44n/Tlhjql79cLYFycP+QAyABbahzXmf2fVo2itNPq1+OxLdatgWZjwBnbWKl8kUaRu321eKOxvfoyrdOGzTAbhoisqPW1RYOjfIj0uerodDEmtmA3KTYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742558574; c=relaxed/simple;
	bh=LyrnnUk0hkTOPdH6RUlj9ZZgbaB3oZMp1/U1MZgiGII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A9IuRSSw6OUjdjCxYIQsxHdeNQXTxnJms7GxjuLyxKqmv9WxfHTvQYoTKqbgPlnf022TmWhutt6hOsfKyEQnG5snpGlJBUP8nnwqczJudm1jRflL5WaiagJ5xDwNddSCTBOfGto14cf1fkRoAexS4oO7N4Yc168MsTpXJEfqM7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P8CDLVPE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742558571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4jLIle/P9WpT7ouFiC+7oWLuQiQ1HDSN71BsIzpDbhk=;
	b=P8CDLVPElOGUI/ZkonbhwxQ5FqK4kwIEDtoZGw6DANx17nqx9Fuw6gnhBOcw5621lrc0op
	9Q4bcT0KKTNWhXZbFH8O95yOjYVvitdhU7uZglElXa+c8CtPz2edPeVj0zYujzHAWqEtQU
	+QQ5Op6281LURjg/1YLclWaZ1ADZI5E=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-K-dNROZVNbyNOorqJEjf4Q-1; Fri,
 21 Mar 2025 08:02:46 -0400
X-MC-Unique: K-dNROZVNbyNOorqJEjf4Q-1
X-Mimecast-MFC-AGG-ID: K-dNROZVNbyNOorqJEjf4Q_1742558565
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 32BED196B37C;
	Fri, 21 Mar 2025 12:02:44 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.79])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 66710180175B;
	Fri, 21 Mar 2025 12:02:37 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	willy@infradead.org,
	david@redhat.com,
	vbabka@suse.cz,
	linmiaohe@huawei.com,
	gehao@kylinos.cn,
	shan.gavin@gmail.com
Subject: [PATCH v2 0/2] Fix parameter passed to page_mapcount_is_type()
Date: Fri, 21 Mar 2025 22:02:20 +1000
Message-ID: <20250321120222.1456770-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Found by code inspection. There are two places where the parameter
passed to page_mapcount_is_type() is (page->_mapcount), which is
incorrect since it should be one more than the value, as explained in
the comments to page_mapcount_is_type(): (a) page_has_type() in
page-flags.h (b) __dump_folio() in mm/debug.c

PATCH[1] fixes the parameter for (a)
PATCH[2] fixes the parameter for (b)

Note that the issue doesn't cause any visible impacts due to the
safety gap introduced by PGTY_mapcount_underflow limit. So the
tag 'Cc: stable@vger.kernel.org' isn't needed.

Changelog
=========
v2:
  * Improved commit log                                (Vlastimi/David)
  * Use page_type_has_type() in page_has_type()        (David)

Gavin Shan (2):
  mm: Fix parameter passed to page_mapcount_is_type()
  mm/debug: Fix parameter passed to page_mapcount_is_type()

 include/linux/page-flags.h | 2 +-
 mm/debug.c                 | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.48.1


