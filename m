Return-Path: <linux-kernel+bounces-432821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D279E50B3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 546C818812D7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970E11D5CFD;
	Thu,  5 Dec 2024 09:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHrL7f3y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7BA191F60
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 09:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733389516; cv=none; b=oVvZL81kBdt4WYtkNxoJGv5KA+7DnUuoSpMP5dQ6jpQYEpyK9MWeIrdICSour4sF0BcaoS5kvGc803CcP+54BG/FyN5Gh/KGK3F2IY94k14Qo2gOM9siv66Pco7x1gCfqXnVqhWv5nZDeO2JNNuq5KSR1nd5tZppgDSn0q/fTjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733389516; c=relaxed/simple;
	bh=GkhaIqMeil/YpC+0NN5nAJtTx6M9jt4MENZ29cqAP9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V3c20E8ZaZqmuS/wC4zd6pd0T1vVZ43VR84/G6VsOwMleRq43CBerCF2Oc7k7G949dekA5NB6AzprlHwAwLPKhlqMQB9otu8DvGyJ8spQSEM7pJ82v3k00OQeZAhvaQV6XPCRMCuMFzQT5b0GarCD6m9JIyAl4jnegNZ0kRCE60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BHrL7f3y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733389514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1OQuhMp8WIbLLy8H/zcKw1FKrd4IsOgaGA+1zvBnNg0=;
	b=BHrL7f3yV3W38kKXidOWf/BQ7RasmJ4tJLpUKOkpFZ1P1xn7r3FiTig1cUP4B9mZGprvtL
	KodOW0DfsfyHUrG+nTsEUFoMm10KcflqptKxBmDExO00K06a/tXWI8P2C7mE1gU5neFvoP
	AkIJAeb4mRKdlFyGPfeIF0ECKFGXHwI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-WrnA9WONNoqR5M38rT3MIw-1; Thu, 05 Dec 2024 04:05:12 -0500
X-MC-Unique: WrnA9WONNoqR5M38rT3MIw-1
X-Mimecast-MFC-AGG-ID: WrnA9WONNoqR5M38rT3MIw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434a04437cdso3925345e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 01:05:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733389511; x=1733994311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1OQuhMp8WIbLLy8H/zcKw1FKrd4IsOgaGA+1zvBnNg0=;
        b=oCjxZIcGVDY0SrasSc8I2mE7Wn6d1i8aRLDZMoDNzU7fGT/eRhO+xrBAJ+HKdJmVF7
         s6xHL8GSdg+wbfYQHyKMOgPnQfT5Prd0SU+nHRQhZAds7vR1EGtxeAs4V3NthHAquP0F
         nLUtcVDvMwSFWW8QFq2R+DuK93GSjan/RWDdzDmOADCVvZXAmnXr45QKZXzA+WjteX/x
         aoWWPD6LrNSzNsMhb/adYca4NF9E3ezxfsRO0FGj8Ahce1iHpYKAkIfzWmFbc7Zd2iXp
         +Nrf9IUNIqXM7anNE/YjFxjKJD7YbnmM0gXp4BJsQHprU+3+N5k9AEZd7NUqcRGunTHc
         v1gg==
X-Gm-Message-State: AOJu0YwHGAn9W3Hhnqk2kEtshPtmi2ktdDj9zPy0yt9GphAaNNoNieKP
	xbUbEO620dAKR+etc9lg8JnZUJ+flQlrzSzprtDMrdnHShyTZ8qHz1sdFzrcNsh7HtXR8SL1Y0A
	/7KFDprWlX+VaqGv5SUVsuLif1Io7XWh2zGCJuiFqB/OlfiKI0UlU+rpP175cNZd8AzUFGvGpVp
	DbBlsDeeYnPNsFcJO0K/hBjesl/a9okWYX1rxK5AhrJg==
X-Gm-Gg: ASbGncuBiRVg5dMFSWgsnX9Q9DpIY00mNb4o0YhNsdrQaYEYgQUxfjcsO+KkP19lIKh
	+7I5uTg3gzNP7R08OnCc/dKPKn3h9VnCrYWvFn6ZUcyuT/YrJHG0l5K+S/jNPXmxut9eCgiea8P
	6CGV6GGyredw+S4I28nNJA8SekxudTCMJCbzYNiRozBm+1EUp+yMimp4NXc5l0ygltm+ANXwfuW
	69hW1bMmyUejVYOYug0Abfk93Wmn8GeKRv5bTV+DG8IUpv8m4QvyndBM5PLBgV3QUiX5CKl7Y7v
	BKXmOae9elqRmmoF8NyVD8IEoOndaYjM8gM=
X-Received: by 2002:a05:6000:70d:b0:385:e17a:ce6f with SMTP id ffacd0b85a97d-385fd3e9d2fmr8918183f8f.24.1733389511404;
        Thu, 05 Dec 2024 01:05:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGR2udGB5JLOouFfrZ9UZdIQE4KHjRl9FWpjtS3FhlJurS+tCw+8wslXPydcXlXwso73YXI7w==
X-Received: by 2002:a05:6000:70d:b0:385:e17a:ce6f with SMTP id ffacd0b85a97d-385fd3e9d2fmr8918147f8f.24.1733389511013;
        Thu, 05 Dec 2024 01:05:11 -0800 (PST)
Received: from localhost (p200300cbc70f7e0075dc9c4033fab5f8.dip0.t-ipconnect.de. [2003:cb:c70f:7e00:75dc:9c40:33fa:b5f8])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-434d52c0cfdsm54932005e9.33.2024.12.05.01.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 01:05:09 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Oscar Salvador <osalvador@suse.de>,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH RESEND v1 0/2] mm: don't use __GFP_HARDWALL when migrating remote pages
Date: Thu,  5 Dec 2024 10:05:06 +0100
Message-ID: <20241205090508.2095225-1-david@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resending via a known-working SMTP setup.

---

__GFP_HARDWALL means that we will be respecting the cpuset of the caller
when allocating a page. However, when we are migrating remote allocations
(pages allocated from other context), the cpuset of the current context
is irrelevant.

For memory offlining + alloc_contig_*(), this is rather obvious. There
might be other such page migration users, let's start with the obvious
ones.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Zi Yan <ziy@nvidia.com>

David Hildenbrand (2):
  mm/page_alloc: don't use __GFP_HARDWALL when migrating pages via
    alloc_contig*()
  mm/memory_hotplug: don't use __GFP_HARDWALL when migrating pages via
    memory offlining

 mm/memory_hotplug.c | 2 +-
 mm/page_alloc.c     | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.47.1


