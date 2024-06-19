Return-Path: <linux-kernel+bounces-220627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38B890E490
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427932855DE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 07:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2594762CD;
	Wed, 19 Jun 2024 07:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ghBU6q6r"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B1A47F59
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718782370; cv=none; b=BIiZOP7sLO8kyC/E5TRUfjWlh3UApjp4gWQbMeQoYMzhFjQnHV0rjUKkILLK6eaV1maT6EWgmCc8blqOl5+d6ei+PtWndprWI/8JDkk5ZUEYcZw+2txH19+L/86Iu7oSIy/FKi0qLxOjH/oZPbXvlqLVCxRcadYO0hsjbE8E+5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718782370; c=relaxed/simple;
	bh=X+zUOKHagxOhak6kW7m6miAY618xfGHWy+jbD1zOAGs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yv6Y9PNnd6/jEywTJ/csXNDfsriq/I0alsGoq5r5GiqSeCFt7H5S9xF7xlBHfHfln+5e9TgEu0ayDkszZNnlwPCzAUWAPZpsEBSUviaOSNdKgJP2j1NLqd0U8D3htPR5Q4yniPxE97qIcR84SoYq0sDxDq1vf191DOckHsnw03Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ghBU6q6r; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718782368; x=1750318368;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=X+zUOKHagxOhak6kW7m6miAY618xfGHWy+jbD1zOAGs=;
  b=ghBU6q6r58eZsp80zsbNT8fXy5nhLFRvk/UZFP7WQ8VIu8IXnALpQzP+
   IOukD4Z/J3ICso8KSEjs4M/6ZmK9ch/+BibayDj6Y4c4PNjlfIm0V35PC
   Awj91I5j5lubNWhDIfKxc5S5jdXkr3oN4awzqFWhfApK2C7OnVjV/aQIJ
   PnSXiuEl+KxOC4J/wPpiurhSMKTmcLkyfVjRaptOFJEg2vR9OaFeKk/Oi
   f2m/qyaRCkXfOzieLTKSaqfQDrA2UohtuKCKs3akD7tCYKg1pHMuakl33
   cV7OOemNDfpWhzRIR20eDFkwDHxEotAY1KjMYNwZYi6XNDNM8Gzf9fB3J
   w==;
X-CSE-ConnectionGUID: N5snsQvuTM+6ycsd8AtZUg==
X-CSE-MsgGUID: kx0jWEMkT4WjdQZFKRI6ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="26296321"
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="26296321"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 00:27:08 -0700
X-CSE-ConnectionGUID: dqKLDcOUSl+5+vnGNTPr/g==
X-CSE-MsgGUID: kwOYi2QLSw2aOFmcxqI+LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="79296144"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 00:27:05 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Zi Yan <zi.yan@sent.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Hugh Dickins
 <hughd@google.com>,  linux-mm@kvack.org,  Zi Yan <ziy@nvidia.com>,
  "Matthew Wilcox (Oracle)" <willy@infradead.org>,  Yang Shi
 <shy828301@gmail.com>,  David Hildenbrand <david@redhat.com>,  Yin Fengwei
 <fengwei.yin@intel.com>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/migrate: make migrate_pages_batch() stats consistent.
In-Reply-To: <20240618134151.29214-1-zi.yan@sent.com> (Zi Yan's message of
	"Tue, 18 Jun 2024 09:41:51 -0400")
References: <20240618134151.29214-1-zi.yan@sent.com>
Date: Wed, 19 Jun 2024 15:25:14 +0800
Message-ID: <87plsd4co5.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Zi Yan <zi.yan@sent.com> writes:

> From: Zi Yan <ziy@nvidia.com>
>
> As Ying pointed out in [1], stats->nr_thp_failed needs to be updated to
> avoid stats inconsistency between MIGRATE_SYNC and MIGRATE_ASYNC when
> calling migrate_pages_batch().
>
> [1] https://lore.kernel.org/linux-mm/87msnq7key.fsf@yhuang6-desk2.ccr.corp.intel.com/

IMHO, we shouldn't ask people to use link to understand the patch
description or commit message.  If so, we can make the link less
outstanding and maybe add more words about the issue.

> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Otherwise, LGTM, Thanks!

[snip]

--
Best Regards,
Huang, Ying

