Return-Path: <linux-kernel+bounces-200237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92428FAD58
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137BA1C222EC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10721422A7;
	Tue,  4 Jun 2024 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VZ1tj2rA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96A4139CFF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 08:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717489128; cv=none; b=ZDET0HQo37wHWT3Y3brIg9yrrMaUYxSPkKdxvTxGXHlajIsJRJMg24+wxUqTKyHqvv0yxC/pv9lJDNitCLXJjj6pdWBf26dc6FcJCgH4vf8jA0kGJxhe0ri8mv4Ej6S6q9hdnn24GMhpcs3y+dkmx0U5YQMj4VD+WjetOdPdBmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717489128; c=relaxed/simple;
	bh=t4AlPKcMOvF+J0KAl9cz4z7x0CWBkr/MlJ8H27UTrHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K9cElx5FzLEBEI4iV/1ojFc36NjMOJMD/GoixaEzxg8Hx8wcRJT/AlqqnPjUinF7wsiCgtIQjvFV6wFV0nuFQK27TwqVKqjAlV5QR9hcXqYGQsKuPjsY5GnxuxKfiW45YwZwJkxuRs7UflUtUS6PDb7Xvbp1BBwd4X+CVRteZ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VZ1tj2rA; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717489127; x=1749025127;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=t4AlPKcMOvF+J0KAl9cz4z7x0CWBkr/MlJ8H27UTrHo=;
  b=VZ1tj2rAgXtHBalW/UJ8clMAe9qAeuHk2hmk1VIt/5kXaTk0Hpjd16Jc
   BzVi6hlAec7ObOwbkCybWicAuAJyuBBmUv0DQKwCA23fZMtn7Po5sGbuK
   Cw4rsb1Ep5+Hx2h69wtRqJXcDhjxcDh9kM+Ttt7ToJsCjKU6SEd/BRUr3
   MB3eW//Ucf7qP/5XWUCS08FTCa+SmvfLm5jGhRn3pi/qNESyunEhRzz6g
   Fx4J4FRpWkhXOAuoMXWBUAo+EA8TLHjTkHEWKd5bZ5CwQEwGclgKn8Nkd
   w4lyK4LqsnNK2KQ3pJw6RFr7Gt9uEOVU4pNWUzQxbT1MsgcjSNPukYkR3
   g==;
X-CSE-ConnectionGUID: r0A87p79TICQ5Bsr30+6KQ==
X-CSE-MsgGUID: 8wgmX4ukQbOzTUV1Axucmw==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="25417177"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="25417177"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 01:18:45 -0700
X-CSE-ConnectionGUID: 1zgcUipQRbSslbX3cwqIaQ==
X-CSE-MsgGUID: iF7ryx1fQ/KGN7P9cTR90Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="37286242"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 01:18:41 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>,  Dave Hansen
 <dave.hansen@intel.com>,  Byungchul Park <byungchul@sk.com>,  Byungchul
 Park <lkml.byungchul.park@gmail.com>,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  kernel_team@skhynix.com,  akpm@linux-foundation.org,
  vernhao@tencent.com,  mgorman@techsingularity.net,  hughd@google.com,
  peterz@infradead.org,  luto@kernel.org,  tglx@linutronix.de,
  mingo@redhat.com,  bp@alien8.de,  dave.hansen@linux.intel.com,
  rjgolo@gmail.com
Subject: Re: [PATCH v11 09/12] mm: implement LUF(Lazy Unmap Flush) defering
 tlb flush when folios get unmapped
In-Reply-To: <24daabde-300e-4a28-9a1c-9e406b087195@redhat.com> (David
	Hildenbrand's message of "Mon, 3 Jun 2024 20:00:52 +0200")
References: <20240531092001.30428-1-byungchul@sk.com>
	<20240531092001.30428-10-byungchul@sk.com>
	<fab1dd64-c652-4160-93b4-7b483a8874da@intel.com>
	<CAHyrMpxETdVewTH3MCS4qPyD6Xf1zRUfWZf-8SCdpCFj2Pj_Wg@mail.gmail.com>
	<f17f33e8-1c1f-460f-8c5a-713476f524a3@intel.com>
	<26dc4594-430b-483c-a26c-7e68bade74b0@redhat.com>
	<20240603093505.GA12549@system.software.com>
	<d650c29b-129f-4fac-9a9d-ea1fbdae2c3a@intel.com>
	<35866f91-7d96-462a-aa0a-ac8a6b8cbcf8@redhat.com>
	<196481bb-b86d-4959-b69b-21fda4daae77@intel.com>
	<Zl320dWODSYw-PgV@casper.infradead.org>
	<24daabde-300e-4a28-9a1c-9e406b087195@redhat.com>
Date: Tue, 04 Jun 2024 16:16:49 +0800
Message-ID: <877cf5ceby.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

David Hildenbrand <david@redhat.com> writes:

> On 03.06.24 19:01, Matthew Wilcox wrote:
>> On Mon, Jun 03, 2024 at 09:37:46AM -0700, Dave Hansen wrote:
>>> Yeah, we'd need some equivalent of a PTE marker, but for the page cache.
>>>   Presumably some xa_value() that means a reader has to go do a
>>> luf_flush() before going any farther.
>> I can allocate one for that.  We've got something like 1000
>> currently
>> unused values which can't be mistaken for anything else.
>
> I'm curious when to set that, though.
>
> While migrating/reclaiming, when unmapping the folio from the page
> tables, the folio is still valid in the page cache. So at the point in
> time of unmapping from one process, we cannot simply replace the folio
> in the page cache by some other value -- I think.
>
> Maybe it's all easier than I think.

IIUC, we need to held folio lock before replacing the folio in the page
cache.  In page_cache_delete(), folio_test_locked() is checked.  And, we
will lock the folio before writing to it via write syscall.  So, it's
safe to defer TLB flushing until we unlock the folio.

--
Best Regards,
Huang, Ying

