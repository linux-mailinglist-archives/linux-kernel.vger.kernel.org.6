Return-Path: <linux-kernel+bounces-406410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2719C5EA9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2309A283D47
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9786F213EE8;
	Tue, 12 Nov 2024 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QrnNtRDq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A852076BB;
	Tue, 12 Nov 2024 17:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431848; cv=none; b=TUAYMb3EeX7IbNEg63FS7p0SbdTvlZx6TrLKqgtIfcOXgElqtKgABPNrN0/NGLlu/vtGffM4yJJmtJOY75ubK2+mB7FgYP2y72VXlvoJnJAYiHnP6LAXLfizxX72tYSMetmZsFdXIk0rVkJEwIkAa28ZOqLh9t8sFbyJGj4L+Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431848; c=relaxed/simple;
	bh=JwYWuXfpSL5AkdZAREAFkweuJZUY7ozAMJNysu17CHE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XZ6v6dXZaffXdhbKAzcCmIYmjwm5weNKVAExtd3YWAhfcm4CgiGt4xV0prz2aMceky1HINKqQQFtIkhYvLMHkHwv9q0C4yWig0OjFSooiUK93FFDxOgS8ko2+YP+rWK3Kq7WzeJqv/wG8gCP/DjfDYTP7c6JSrAyC5foZxrBqrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QrnNtRDq; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731431847; x=1762967847;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=JwYWuXfpSL5AkdZAREAFkweuJZUY7ozAMJNysu17CHE=;
  b=QrnNtRDqfZ9BWGB4im5jO7yjEP1nUWTKMFytUOM6/EcTXJ87xU/ZvHMK
   GtCKr2lT4dXrCHl0d88HdC9gXOlZPoR+4kiN9oQvJEv9GcPdyj5YVONSS
   ouk/9WBREuNGRpDXQw/axWvh4KIzgdGqoTG9jEbpOl76n1rIsVQMyNhGZ
   r/60dSSC4uXNX23gdJGQ/crXLoRZK27T2IBWnhxEe2RILXy5nUOU8JzWD
   a8SVc1A64Vtf7fw6q8odLSlMuxi5SD7jjzGva/me8qWwd2tKVH6+AK3dy
   Y+5h1QmZWuVRy2MDrxSIggjfXUNhPDZHkLRnZeZ3LoM5je2BM7fOFzoUN
   w==;
X-CSE-ConnectionGUID: WVAKl+egSkSKR0ljmWYoJA==
X-CSE-MsgGUID: PiIVNmzgSTu2QnWs/8dKUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="31157146"
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="31157146"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 09:17:26 -0800
X-CSE-ConnectionGUID: k35N3V1lQfye7DmzF1Vj9w==
X-CSE-MsgGUID: oxbK1Tq4T+6eyFQnuLacWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="87141279"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.234])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 09:17:24 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Jorge Lopez <jorge.lopez2@hp.com>, Hans de Goede <hdegoede@redhat.com>, 
 platform-driver-x86@vger.kernel.org, 
 Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241107113543.17137-1-colin.i.king@gmail.com>
References: <20241107113543.17137-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] platform/x86: hp: hp-bioscfg: remove redundant
 if statement
Message-Id: <173143183902.3180.9868160429476963926.b4-ty@linux.intel.com>
Date: Tue, 12 Nov 2024 19:17:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 07 Nov 2024 11:35:43 +0000, Colin Ian King wrote:

> The if statement performs the same action if the strcmp result is
> true or false since there is identical code on both branches. The
> if statement is redundant and can be replaced with just one call
> to sysfs_remove_group.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: hp: hp-bioscfg: remove redundant if statement
      commit: 4ceb681f1822819f78b747ddc189479fead43be2

--
 i.


