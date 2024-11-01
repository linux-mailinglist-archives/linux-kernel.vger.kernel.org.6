Return-Path: <linux-kernel+bounces-392222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F39D19B9130
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9ACB1F229AB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBD519E826;
	Fri,  1 Nov 2024 12:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R7uKhahJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCC422097;
	Fri,  1 Nov 2024 12:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730464592; cv=none; b=iKFQyJ/gHw7kRo11xp7Rx3XWX743o9u40oKJjZlP2A+93fXWogNjrtP8VXP1hckH9PTBipVYF11u69GRzATH9yScEGdzSBZuxgJIVk6jWvYOND0wNdDsC15f7+qAcFYuQSygkFFarLGI1DtOEppTAhht55+BaXhnYT8Gk3kKE74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730464592; c=relaxed/simple;
	bh=gRP6MN8zkcU6CaP595Krk9eoXpXecFjEFluVBdHI6Dw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iLwzUbsS5dZqYnLvmFw8wlOx8j9VGBPJnmG5XVU+I6JSRogzmqPxQ9u6n8XfStb7ZwOiC7ziRLic2ipF3CQJ8RuqwUPKIsh0xTM+buGxK1NUyDVpcGAxc6zDxkyER+M/seoXaxqjYfXzLb/wMg8dePy2NqRTdS1u3Fq09tZfsvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R7uKhahJ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730464590; x=1762000590;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=gRP6MN8zkcU6CaP595Krk9eoXpXecFjEFluVBdHI6Dw=;
  b=R7uKhahJyPUgwWAMShBxRPUxfZ15oAqBA+HUVaTNreUbpwNPT+4ZxGob
   62gPAzz3zBjfXbOa9kllbFmJ7+rCqxM94Fck0TdC+3mGABk1sgBX7zgUg
   kELqbIeBx0RASmTEsMO1v/ZDi87VLcOvgzRP+u8h4TeMh2MRo6wNDI3Op
   G3ub7+VZ+MTnnN0F97YedlERytxieQdJBqWVJAKnUvFWFurgAOm8P8EZu
   4iUT0rG3UnwqQAjzGwefefQf9yDe6dtYdofGR1XR9LtxB6L54oIiI0HXo
   Fi9k0rJ92zifAXSqo17T06QjBWpWRsjXNT/szmoPc20Omj8nAcQL7bsNi
   Q==;
X-CSE-ConnectionGUID: gSGLJBhJR6K5mUIPTpAS7g==
X-CSE-MsgGUID: n3IhfjNVRDC4XVsfyFmRPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="29647782"
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="29647782"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 05:36:25 -0700
X-CSE-ConnectionGUID: VSxhE1D4Rv6k16aZfJE9gQ==
X-CSE-MsgGUID: ZFqSEMFsQqy8Ka+VNR1QDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="83386198"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.38])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 05:36:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>, Armin Wolf <W_Armin@gmx.de>, 
 Kurt Borja <kuurtb@gmail.com>, Dell.Client.Kernel@dell.com, 
 platform-driver-x86@vger.kernel.org, 
 Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241101110230.3303197-1-colin.i.king@gmail.com>
References: <20241101110230.3303197-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] alienware-wmi: Fix spelling mistake "requieres"
 -> "requires"
Message-Id: <173046457722.1736.12073152593852757455.b4-ty@linux.intel.com>
Date: Fri, 01 Nov 2024 14:36:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 01 Nov 2024 11:02:30 +0000, Colin Ian King wrote:

> There is a spelling mistake in a pr_warn message. Fix it.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] alienware-wmi: Fix spelling mistake "requieres" -> "requires"
      commit: d68cb6023356af3bd3193983ad4ec03954a0b3e2

--
 i.


