Return-Path: <linux-kernel+bounces-511081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C45A32588
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7C013A734A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E7B20B1F6;
	Wed, 12 Feb 2025 12:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fik8NhyS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EC52B9BC
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739361725; cv=none; b=D5vrm4s4zUqAfRUs7ctf+lpzqgSpmq6vjOdtJP9GQtUGKfVkmQTWyFcs26jenrCY3rpEOj5D0j1EXSExR9LD/4mAwL7DTMcvNMIEaOvBuRKhVriIh65GAu2xs4m+/PlFingByTSSgqDI7qFJc94Cy2HO2KywXTHGi5qNGWskaOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739361725; c=relaxed/simple;
	bh=dIfwYaEK6l7GPdYkOMJaIRqUNxzO77R65/rLjfZCHZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=At9vroxOL10GOEfQcWrLQzdpozRWSeLolyRvUFiP8SbElFdORYx/zbSfkGiz4d+bhuk1gztw7sST7elg56bk/ADR6+CNcd0zi5ZTJ1G49dpPsqZZSyW90JqzKyRMgWLsn70wzhFwCaL6Vjf3pfo8oq6zYMikOb5uaHa1r+KwftE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fik8NhyS; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739361724; x=1770897724;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dIfwYaEK6l7GPdYkOMJaIRqUNxzO77R65/rLjfZCHZQ=;
  b=Fik8NhyS41FyORHSmdOHvIoy/mLKpOC90QTVN3Pk47/qAaz0stSP1NK4
   xhRh5d3t+fIDnwzLDNj2FOJPXzH5tW7ugJBvltKowZ2gGlfmwqhVSONHE
   PMSI2cp0jvZuraKxtOJmNuKX/dja5jn0vZCPYYBtIQdEnlIncbPbGOG4k
   KtshZG4kxX8DNsPJp+TleY+rLrVNk4aTOA5wOhCRhY2ikMSs0rT7XqgnH
   HXxacKVwY7m0TXR7rMRx24wngHRWdVL0a2d0xfKjPcD8CwTE1c55UKAbd
   CE+bFe6yvRae9vAC+6peFhaSaSJY5+0bmniTKk5NZf1CDE1wUCmINUlII
   Q==;
X-CSE-ConnectionGUID: qSXtQ078QYKn3G058vE2FA==
X-CSE-MsgGUID: aHXvJCJnTy+igcl816zyhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="27610690"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="27610690"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 04:01:55 -0800
X-CSE-ConnectionGUID: VKaM4QA3QO2B6FkxA7/Bvw==
X-CSE-MsgGUID: fF+d2onJQOek7Yp6Arb5tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="113463458"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 12 Feb 2025 04:01:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 00C9B1FD; Wed, 12 Feb 2025 14:01:52 +0200 (EET)
Date: Wed, 12 Feb 2025 14:01:52 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Jun Miao <jun.miao@intel.com>
Cc: dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/virt/tdx: Correct the errors in the comments
Message-ID: <r7shaamvucw35wqymhkmceu3gpu2fedgv2umlcgdglglw65m4o@heaniim3gikx>
References: <20250212075805.2906200-1-jun.miao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212075805.2906200-1-jun.miao@intel.com>

On Wed, Feb 12, 2025 at 03:58:05PM +0800, Jun Miao wrote:
> In comment of config_global_keyid(), the "will fail" is duplicate, delete it.

  In the comment for config_global_keyid(), the phrase "will fail" is
  duplicated. Remove it.

> Signed-off-by: Jun Miao <jun.miao@intel.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

