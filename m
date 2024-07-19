Return-Path: <linux-kernel+bounces-257014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8A79373F9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ADD9282266
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 06:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DED4174C;
	Fri, 19 Jul 2024 06:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bV+h6eTh"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FDA2C182
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 06:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721369971; cv=none; b=Wq+rc6wQlo+2CXzjZwI+e1hEhH5J2bakpRO+9FjC05c3hntc8CnMN+gogne3KK6qL91knRf++FH33QVIPhV+kot2LlKvN8oDQmQlzs5WMZt2jcdQkEuEtgX1AavXrX1s1/9tx/0sthm+JZPHqhOh7M7/k6zXmoN5RyXcjYdaQgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721369971; c=relaxed/simple;
	bh=mZ7H/UF+3Zel36BCGfdzY8DlVZN98R1G5YlPQQ/+uwU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fBSYwER4vbzxr8DoYAoPgmbERgcCj7jC5WKF2zXPUS+BtII1CB3zebHEJ3Mlar13LKH58rL4QtFReGlguWS/MPYXqreyUui4UWmTaCdVnG4Wq5UVrJLAqoV1srox/geJjbqrCBZQ+65huGWxQ5hy/f03wlWf0ouDh9rjYp18XYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bV+h6eTh; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: yuzhao@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721369964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZ7H/UF+3Zel36BCGfdzY8DlVZN98R1G5YlPQQ/+uwU=;
	b=bV+h6eThusCkDKgOefN3Ag6jgIiX6neKLsyV6V2C3q32DoL7o+ohxFBZ0QyICQ4itRlZ+X
	ukDzp1tsI5btn4M0oLTc45oo+Mymb7c574Id6kAqs56nWC5akUBlLnsDKo9eUvN21Kp9gf
	plAVSUf9DY8qE6JzGwRSEnDSzzzJVE4=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: oliver.sang@intel.com
X-Envelope-To: frankja@linux.ibm.com
X-Envelope-To: mhartmay@linux.ibm.com
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH mm-unstable v1] mm/hugetlb_vmemmap: don't
 synchronize_rcu() without HVO
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240719042503.2752316-1-yuzhao@google.com>
Date: Fri, 19 Jul 2024 14:18:26 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>,
 kernel test robot <oliver.sang@intel.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DE0EB84C-B69E-4FA0-8CBC-516BEB821BDE@linux.dev>
References: <20240719042503.2752316-1-yuzhao@google.com>
To: Yu Zhao <yuzhao@google.com>
X-Migadu-Flow: FLOW_OUT



> On Jul 19, 2024, at 12:25, Yu Zhao <yuzhao@google.com> wrote:
>=20
> hugetlb_vmemmap_optimize_folio() and hugetlb_vmemmap_restore_folio()
> are wrappers meant to be called regardless of whether HVO is enabled.
> Therefore, they should not call synchronize_rcu(). Otherwise, it
> regresses use cases not enabling HVO.
>=20
> So move synchronize_rcu() to __hugetlb_vmemmap_optimize_folio() and
> __hugetlb_vmemmap_restore_folio(), and call it once for each batch of
> folios when HVO is enabled.
>=20
> Fixes: bd225530a4c7 ("mm/hugetlb_vmemmap: fix race with speculative =
PFN walkers")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: =
https://lore.kernel.org/oe-lkp/202407091001.1250ad4a-oliver.sang@intel.com=

> Reported-by: Janosch Frank <frankja@linux.ibm.com>
> Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Signed-off-by: Yu Zhao <yuzhao@google.com>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.


