Return-Path: <linux-kernel+bounces-570737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B44A6B410
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 293424865CA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 05:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A031E7C1E;
	Fri, 21 Mar 2025 05:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="deixNdEj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFC812E7F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 05:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742535138; cv=none; b=DwFrxKSC2iQjARgxbY9muZBDgyOV/jxBjFsF3tH4JzJ4ilMfLa3w6ICCHecqwGfJqRhKuzXsZ/bougS6GdzYAHjD/sxVZ761P1EO2CJwHzFgN+Jk+Ce7V/54832PislcP8T1JFehht7Q+H7PPstKdeJXLXzqSqnUUOSc1T/D6e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742535138; c=relaxed/simple;
	bh=pDPep0m/n2iGCPuuUzx06R6D8ZseGyV4z7mjj94qU1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GhfUYC7sF0WfQVajdKdWTPXBuy97ovDJsbuEJvzvhJCs1rLYXMI7b43QfouUxmf4bGPXKSNB7sismswxGbkNSa7B/dFh1cUXHWR1YpVPMdk814JyTUBaHLnX4QYYu8DRO2iW6sBYWX3RD4SJKfQlGqyLOVQfbnbkFK7cvcYqMIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=deixNdEj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742535133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YgL6IG1V+/q/f3by8uc4cRW6YV21SW0qRFzDtp4/Pyo=;
	b=deixNdEjsKfpsf458TQsDuFVcvVbB5XJrtPHKmw404wJ0X5vgGt/8+cYFk6MAwNJXIbMYk
	RVfms57z9XVHxVy/al1xROO6Jei9rZFzwhPWXo0JK4UnDTYOkYyj2h5NF84UpyoMF8QEsY
	AGUtN/4XNxccM1KDTVtjRu9RitiEXl8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-4Kd6ubaAO9yUjABb1h_y_g-1; Fri,
 21 Mar 2025 01:32:08 -0400
X-MC-Unique: 4Kd6ubaAO9yUjABb1h_y_g-1
X-Mimecast-MFC-AGG-ID: 4Kd6ubaAO9yUjABb1h_y_g_1742535126
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 025C2196D2D0;
	Fri, 21 Mar 2025 05:32:06 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.79])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4BA719373C4;
	Fri, 21 Mar 2025 05:31:59 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	willy@infradead.org,
	david@redhat.com,
	vbabka@suse.cz,
	osalvador@suse.de,
	gehao@kylinos.cn,
	shan.gavin@gmail.com
Subject: [PATCH 0/2] Fix parameter passed to page_mapcount_is_type()
Date: Fri, 21 Mar 2025 15:31:46 +1000
Message-ID: <20250321053148.1434076-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Found by code inspection. There are two places where the parameter
passed to page_mapcount_is_type() is (page->__mapcount), which is
correct since it should be one more than the value, as explained in
the comments to page_mapcount_is_type(): (a) page_has_type() in
page-flags.h (b) __dump_folio() in mm/debug.c

PATCH[1] fixes the parameter for (a)
PATCH[2] fixes the parameter for (b)

Gavin Shan (2):
  mm: Fix parameter passed to page_mapcount_is_type()
  mm/debug: Fix parameter passed to page_mapcount_is_type()

 include/linux/page-flags.h | 2 +-
 mm/debug.c                 | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.48.1


