Return-Path: <linux-kernel+bounces-388095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CA69B5A7B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 04:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DEE3B232A5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 03:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C675D196C67;
	Wed, 30 Oct 2024 03:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S6pJcoMf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E8428F7
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 03:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730259916; cv=none; b=hOyAPZxjjdHYYPHPxKrL9CwhQUmQz3+XDqGHQLYOmHQwRlh+CsY3vYlHnA02//fttLhX30cMH4oKGzUAyNIhrbPl8a4QjpniwXZsBocihYVqsUNEjmVrtc8yo2/Heqc+/pCmQTd4aM4DfbadcaPJ5uD+oPstwswQS6JHLL2Gufc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730259916; c=relaxed/simple;
	bh=pvqROz9YZfbJDgEflMBYVsJrtToifyimXzdNQpjU7O4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kCRY2MpfybClV+UVXRwdErhHRWrGmAbMytLyuXXt+i1RVQcA9u7bCTPbT/wf2a0HoZ6GNkoSe/PhXHl6OH8y+7hiRl+L7iJI982Yf6beLN7zVhPhrakbq4ZlEqdqdmaAOZOklTuuJa7fPVQmPHebwOv5poP1x46aQsk6mFlMjz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S6pJcoMf; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730259914; x=1761795914;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=pvqROz9YZfbJDgEflMBYVsJrtToifyimXzdNQpjU7O4=;
  b=S6pJcoMfrz9Rz+qqjUG05ck2aNu60ZwJNFNUwUkffwsK5ngwEubDZCGJ
   aNz4vz19PyAF0PPFDJ5hRpYn+WtzzKTb4OJ6GGs6k8S7duJVkyByJwv00
   /p6Y2MH2+xKBn488HlHDxTewnD5/X3JiuXlIWxA9R2E7TEMnDr5vfN1B3
   OSgccfNfwsNfYFBOSCZYz0sI59WEbycrufIf5GdhkZcV/+IWmfxPIcmTP
   6zNGmxk8n3bbh91bNReS/2rnO+boYPqEU2DeqquU/D60PShTMJVl877dn
   efTATlls/w7+5lklH6nNbCadzk3QjrQXzDF37oTapQXcli77utk+6O+Gf
   g==;
X-CSE-ConnectionGUID: 6FUt57YHR0ycqpDFf3uG3A==
X-CSE-MsgGUID: apJYzfJeTPaWgIxNb7HTng==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="29387079"
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="29387079"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 20:45:13 -0700
X-CSE-ConnectionGUID: t/3/jWFKQJS5zkBnZq0PSg==
X-CSE-MsgGUID: 2inaq6ZqSeasK3/rdRnLIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="81812491"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 20:45:10 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Barry Song <v-songbaohua@oppo.com>,  David
 Hildenbrand <david@redhat.com>,  Baolin Wang
 <baolin.wang@linux.alibaba.com>,  Chris Li <chrisl@kernel.org>,  Yosry
 Ahmed <yosryahmed@google.com>,  Kairui Song <kasong@tencent.com>,  Ryan
 Roberts <ryan.roberts@arm.com>,  Kanchana P Sridhar
 <kanchana.p.sridhar@intel.com>,  Usama Arif <usamaarif642@gmail.com>
Subject: Re: [PATCH] mm: add per-order mTHP swpin counters
In-Reply-To: <20241026082423.26298-1-21cnbao@gmail.com> (Barry Song's message
	of "Sat, 26 Oct 2024 21:24:23 +1300")
References: <20241026082423.26298-1-21cnbao@gmail.com>
Date: Wed, 30 Oct 2024 11:41:37 +0800
Message-ID: <87o7329s0e.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Barry Song <21cnbao@gmail.com> writes:

> From: Barry Song <v-songbaohua@oppo.com>
>
> This helps profile the sizes of folios being swapped in. Currently,
> only mTHP swap-out is being counted.

Better to describe the user space interface in patch description?

[snip]

--
Best Regards,
Huang, Ying

