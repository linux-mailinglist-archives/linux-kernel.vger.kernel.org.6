Return-Path: <linux-kernel+bounces-419363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECAF9D6CF7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 08:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E7A2815CF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 07:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F376433C4;
	Sun, 24 Nov 2024 07:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NCNE1bfe"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57452C80
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 07:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732434246; cv=none; b=Vr3wIrNgj2HD9eZDJclKMXl865r8QDBJwcd6Mytfq5kkBLhmIlVBY9peHrIpRCcRr9jJ/hlU7YOe0zmBwTZCHOaKrxnKwBtjL94gULIB3AWtEPeg39oZH/+Ah+OIyU0nJI2cH2nBRnPLlXXWWJSKfG4vFuNwbB1Q20aJipWzQQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732434246; c=relaxed/simple;
	bh=i9UtdqXtVjG4OxCdBgR3ofGqYJaU4aMbCNFixJDYH2c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dfa0LFnBio04oNBP5NfC8FBHKWpsaNfsCF2AQW/Mb4W/Oh6Gjw5p+L5efspC+TM/pwH/JVW/TU+3dT1JjLTpgxSG4e5HLYBW4DrYXac+YePp9Hxlxk2xPQI9VRcbDFFLPBlTXWwzq5wDBiccvXR0rdCRyCbuICY5aMvlFn1vuuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NCNE1bfe; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=pB/P2
	KM2O7XmmfZ64PdjOHBu5Bm2PcLL67BQ7nehanY=; b=NCNE1bfekUMRVsonZSwbC
	qYOhLhXdrgoFBsYqX/dGDfALriboZRcC9jQ3QyG36UWh4O+b4kkASOeezLTrCZR7
	813GzhUX6fAddG6m3NEtpcFo5nf9HT3ZR6q0XZE6e47hxggDDDAxNmyEYpsbB+Df
	9fMjZTN61ML91IeoaC0DM4=
Received: from localhost.localdomain (unknown [111.35.191.191])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDn73UX2UJnWv1eCA--.358S4;
	Sun, 24 Nov 2024 15:43:40 +0800 (CST)
From: David Wang <00107082@163.com>
To: surenb@google.com,
	kent.overstreet@linux.dev
Cc: linux-kernel@vger.kernel.org
Subject: Abnormal values show up in /proc/allocinfo
Date: Sun, 24 Nov 2024 15:43:18 +0800
Message-Id: <20241124074318.399027-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn73UX2UJnWv1eCA--.358S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtryxJF47KrWxJr45Zr4rGrg_yoWkXrb_Wa
	1rtr4Sq345J348WasrWr4qv3y0qay7Kr1Sgasxtr1ayF95tan3G3WqvwnIqFyfJr42yF45
	uwnIqr4Ska1a9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbjQ6tUUUUU==
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMwqhqmdCzvKzgQAAsZ

Hi,

I am running 6.12.0 for a week, and today I notice several strange
items in /proc/allocinfo:

       -4096 18446744073709551615 mm/filemap.c:3787 func:do_read_cache_folio
 -1946730496 18446744073709076340 mm/filemap.c:1952 func:__filemap_get_folio
  -903294976 18446744073709331085 mm/readahead.c:263 func:page_cache_ra_unbounded
  -353054720 18446744073709465421 mm/shmem.c:1769 func:shmem_alloc_folio
 10547565210        0 mm/compaction.c:1880 func:compaction_alloc
  -156487680 18446744073709513411 mm/memory.c:1064 func:folio_prealloc
 -2422685696 18446744073708960140 mm/memory.c:1062 func:folio_prealloc
 -2332479488 18446744073708982163 fs/btrfs/extent_io.c:635 [btrfs] func:btrfs_alloc_page_array

some values are way too large, seems like corrupted/uninitialized, and values for compaction_alloc 
are inconsistent: non-zero size with zero count.

I do not know when those data became this strange, and I have not reboot my system yet.
Do you guys need extra information before I reboot my system and started to try reproducing?


Thanks
David





