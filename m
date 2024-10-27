Return-Path: <linux-kernel+bounces-383720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BDE9B1F7F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 18:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A781281323
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 17:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2019E17AE1C;
	Sun, 27 Oct 2024 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="MDBz/DCN"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0A213E04B;
	Sun, 27 Oct 2024 17:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730051934; cv=none; b=IJkHQkFOtJYI2vP+ULUNsefVnAE3GDZQ2i0LBlo2NiYnaUdQ8I4gxkue4gGT5G7q5Wz4yu9qKxJLIyC5w5s9Q5lQjcj78i1813lqLdWnf5KazzHL0DyPwMndQ54LfbZOjSj8mtbSOSe/xTceYwK1zanWhMJFpr2ZY5A0S5V3uEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730051934; c=relaxed/simple;
	bh=ZjTQBjIK+/Z1d5oluhWNj+jzL3Z4Ffog4uiVmcdc/jo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VwvxOcw0/OgDq47Zgnb9K5j1xgqzsGV6uxkGz/j4Z4KxqIA8zT2VebdzCU1H4zoqEmj9AjouRNpxt5+tdCTrWS0+jXXMR0/9Qd7Adhn0BtudDfUtk5eVtnDW+i8pCDM1iswSAv/wKPXHKJuoj01AD3fKW8agMZcTqIhMr26IBgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=MDBz/DCN; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+EYxh3PAF2StjbS6XQUuDIepM4pqjcsAUbbLfrUfkKo=; b=MDBz/DCNOUZvjCqX1ePpLaGvlS
	aE4Q0gy6ii59jGv7tPRgl4QRR5ZrucmSM6lqdxPNXUEOrWYzqZ3FR2MD/t5CX4oxKWyD+s45KU57c
	uLRygNdqehYhmO+H5RFCwGs1d4nbKcaT8fe7mqTcqfYU76Car+hrszGUCHAdy1PbzmeNGrHfJdFMA
	YIW5dU870nlb+iXKIVS8dGfRfIUUpBqDRoZW46aLrx4Dr920YkVPgDcJXWSN7uBaq5iZGvwKADtOT
	pd5Av7XNj6lyHVpYgekoPvxTasM2mIHEfcVm7/IWBa30e3zxrCEmOKLnaoq57GEzpWi29U8khPHeY
	4HoveHyw==;
Received: from [187.36.213.55] (helo=morissey..)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t57Wu-00Fn6f-Fb; Sun, 27 Oct 2024 18:58:21 +0100
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lance Yang <ioworker0@gmail.com>
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH 0/3] mm: add more kernel parameters to control mTHP
Date: Sun, 27 Oct 2024 14:36:36 -0300
Message-ID: <20241027175743.1056710-1-mcanal@igalia.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series introduces three patches related to the kernel parameters
controlling mTHP. The first patch is a straightforward documentation update,
correcting the format of the kernel parameter ``thp_anon=``.

The second and third patches focus on controlling THP support for shmem
via the kernel command line. The second patch introduces a parameter to
control the global default huge page allocation policy for the internal
shmem mount. The third patch implements a parameter similar to ``thp_anon=``,
but for shmem.

The goal of these changes is to simplify the configuration of systems that
rely on mTHP support for shmem. For instance, a platform with a GPU that
benefits from huge pages may want to enable huge pages for shmem. Having
these kernel parameters streamlines the configuration process and ensures
consistency across setups.

Regarding the third patch, I’m open to suggestions on how to reduce code
duplication between ``thp_anon=`` and ``thp_shmem=``. While I duplicated
the ``get_order_from_str()`` function, I realize this isn’t ideal and
would appreciate advice on where best to place the function.

Let me know your thoughts.

[1] https://lore.kernel.org/linux-mm/20240820105244.62703-1-21cnbao@gmail.com/

Best Regards,
- Maíra

Maíra Canal (3):
  mm: fix the format of the kernel parameter ``thp_anon=``
  mm: shmem: control THP support through the kernel command line
  mm: shmem: override mTHP shmem default with a kernel parameter

 .../admin-guide/kernel-parameters.txt         |  19 ++-
 Documentation/admin-guide/mm/transhuge.rst    |  25 ++-
 mm/shmem.c                                    | 147 +++++++++++++++++-
 3 files changed, 186 insertions(+), 5 deletions(-)

-- 
2.46.2


