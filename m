Return-Path: <linux-kernel+bounces-313191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EAC96A1B3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E3DF2886EB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ACD186E3A;
	Tue,  3 Sep 2024 15:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kOEKiEJj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEF517E00C;
	Tue,  3 Sep 2024 15:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376145; cv=none; b=cCV0qD4+JgpMhgSAnhCqnQWyxcMhXR1jrnwYPgA+ItJtxGTBDhblMPDkk5DrtXCGzDfkENiiWflmeuvFaFld+segk6dAGrPXjGip/KvIWKZyhO/dQAl0YJwvL1pkppHTCwFvSOw/IEKw3pOWvcPugYB4FjnmVt68JRUw2EtuFNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376145; c=relaxed/simple;
	bh=zm4/QGk9CS+/IIoe1jxwGscR7TcTiBk2vzixJgadSOY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=K0SjZCn+YnB3Xm715hKoh+Bl9w+uQDJCA3lwxIzad7rzXlNF/cSkXFd+HwZALIFD4h3i/XARwHqXQXeJYWaAVCjIRJhMqv1gK/fO988IG8YnFdLEEH4mD57hdVYjotmZA76gA6lytyDMOGIlPgRyYOYqWXcr6mrFJrAlfVARtgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kOEKiEJj; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725376143; x=1756912143;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=zm4/QGk9CS+/IIoe1jxwGscR7TcTiBk2vzixJgadSOY=;
  b=kOEKiEJj39cq0MGh1Jb4rRtgh9LTcM5rI+PRy/+V8xiXad7F19tFejvj
   rZ/j8jJHl5d8iHw+3XpnBoFhQjW4DNJCQnbeIzCZp92zOD3nIYmxHwVM3
   au26Fa4BBpFtf922XKTYbyyOey2b1dIZY0nBYPo5h8F6uVhwKfRmUKYb4
   IaWYkQud3i3lvEImtGhPnJb+qA66Mr3shD9upgpjQ7DpyjAcAfB3UobBr
   J57epqD+tzAc7s0bphYTrpKK95l3Sg/b6vtbHu1pF4MhN9J4GGQGnX9hq
   +QmeWworUvO2vM2Orqnh+lpMdsHrAQETlz8MyJaDItrrpa/6q+Pi9r1aN
   w==;
X-CSE-ConnectionGUID: dENiJ4N4SqO6NzOk/moixg==
X-CSE-MsgGUID: F8x+JcXISlCVn6FAhwprOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="34646765"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="34646765"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 08:08:59 -0700
X-CSE-ConnectionGUID: ExhaOXuoR/m2Wujb7/2knQ==
X-CSE-MsgGUID: tn+oqKbTQ1GEW2v07FGHmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="95671930"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.241])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 08:08:56 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: platform-driver-x86@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Cc: linux-kernel@vger.kernel.org, hdegoede@redhat.com, 
 Shyam-sundar.S-k@amd.com
In-Reply-To: <20240831003905.1060977-1-luke@ljones.dev>
References: <20240831003905.1060977-1-luke@ljones.dev>
Subject: Re: [PATCH] platform/x86/amd: pmf: Make ASUS GA403 quirk generic
Message-Id: <172537613010.2288.8288166885849253035.b4-ty@linux.intel.com>
Date: Tue, 03 Sep 2024 18:08:50 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Sat, 31 Aug 2024 12:39:05 +1200, Luke D. Jones wrote:

> The original quirk should match to GA403U so that the full
> range of GA403U models can benefit.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86/amd: pmf: Make ASUS GA403 quirk generic
      commit: d34af755a533271f39cc7d86e49c0e74fde63a37

--
 i.


