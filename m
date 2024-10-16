Return-Path: <linux-kernel+bounces-367994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CA69A093F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64EC0B27AA9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6167C208210;
	Wed, 16 Oct 2024 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K0eQXqYG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136AB204F93;
	Wed, 16 Oct 2024 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729081362; cv=none; b=NOv/DrJG9ReZo/YonFKhjhkVJT2ZxFIVcXupNQNBSr4NdiZeSW10gRbDB3QeFh2emmSnvdnC51+SNR930y+xU6CAh26rHom8OCNYgSUEL6GFec3nr5WoElZ/YqDdlOd1XzPLMXxYERBVX8ctHLyXxjj8FLFVTyzTb/8qSYNXc6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729081362; c=relaxed/simple;
	bh=Q3gsPwkFx0i9sUwkfIaypE2iMgsIe15uMCSscgK9Roo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=X3YvmEFvA9gE9NBx60B5asjCp6mJXi+SkeLqYhvFkUNuwK2H1463gWI4+FNffzsA+9geXQDGXxmiSe6fiYWpC5jJwM4/7P6eiWxc5krnXwG96OK5tkFgo+46xWwgidYtmjiQo0DcmFvav9eRVx6WCcv0WWrg7S+C1OXI5FmBPfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K0eQXqYG; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729081361; x=1760617361;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=Q3gsPwkFx0i9sUwkfIaypE2iMgsIe15uMCSscgK9Roo=;
  b=K0eQXqYGMRj6EetkWydnfOhOO4EmOp+iFK+Nu10dahT376d5KRDozaTC
   qCwVyWi1FLH9NrhQzKtazjJGwUr5+0KiXAGFZ7qdZySWOT0JLB4sXd9fO
   cFG8UBwaRenTXxR6z27BO869zIwoiXP7C3ZPfB9L31+kRzgJLXR48aDWE
   j9PHa7Be2w8YqzpEL+BLMgfIaAwdxy/WEChItMhjZM2nTc8PUmn4PBzLo
   5eCrX5CKYaTv516bC1Q5DmYdeyLj1KHVyoET7/TYuzHipXE5oH35HNxFV
   kNOU1PGIktGPuPAJoug3c7HO5OtwjoQ/Ef4cAEgViSgWX7yf4dri+b2Fu
   g==;
X-CSE-ConnectionGUID: SjyzgMO3S5GXoEgPzgxL6Q==
X-CSE-MsgGUID: GzbaLgZcRXSW0uwlxUiQLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="28653868"
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="28653868"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 05:22:40 -0700
X-CSE-ConnectionGUID: i8af+6zzTniR5WZ6IvC9Ug==
X-CSE-MsgGUID: PV9wDZclQQKI8loOfPg9YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="108953528"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.221])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 05:22:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: jlee@suse.com, Ba Jing <bajing@cmss.chinamobile.com>
Cc: hdegoede@redhat.com, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241014183856.3942-1-bajing@cmss.chinamobile.com>
References: <20241014183856.3942-1-bajing@cmss.chinamobile.com>
Subject: Re: [PATCH] x86: acer-wmi: remove unused mocros
Message-Id: <172908135259.1467.16585768317933583360.b4-ty@linux.intel.com>
Date: Wed, 16 Oct 2024 15:22:32 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 15 Oct 2024 02:38:56 +0800, Ba Jing wrote:

> After reviewing the code, it was found that these macros are never
> referenced in the code and are all set to 0. They should be removed.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] x86: acer-wmi: remove unused mocros
      commit: 7dd1233931271f4c7efd5456aaa6e8bb8f77b5e8

--
 i.


