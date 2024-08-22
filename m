Return-Path: <linux-kernel+bounces-297995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AADA495C025
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 23:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619241F24AE4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225641D0DFA;
	Thu, 22 Aug 2024 21:24:21 +0000 (UTC)
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A10942A83
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 21:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724361860; cv=none; b=YHupavNMUuNj0Oqnb3Yk67qoFp5tPUYf8QaLe/tsNPq8eKdUglx+eJBrO6Ewfd4iDy8esYKylVoWiS0LDQHKLN257Kz55pEM7hwyd6ooAmKBvwghaakqyrhJllilqmVXYA7JWtTOomezjsUtfdFNvEfVTRN7QDN1erxoy2oVNCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724361860; c=relaxed/simple;
	bh=YjTEVDNMIVAig4+UwbZVBXV/RxCe9AaKtjbOiKpiRog=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpUhGubit8RDtxYiczXvrOSSOeWJspCPXh+e82/SldCkI1pH50BzOgVGtyZE9v1zIHguytbi1n1QIDhoJ9JsrPjbZOJ8ueIldcT0LbEOLjHHPeB5Eop5feVqEbZwXHNMIqqseZR2+VB8JV4m9C9aEU+qW256p064uf/UpqrFTZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id df0b17f1-60cc-11ef-8e3a-005056bd6ce9;
	Fri, 23 Aug 2024 00:24:10 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 23 Aug 2024 00:24:10 +0300
To: Yang Ruibin <11162571@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] lib:Fix the NULL vs IS_ERR() bug for
 debugfs_create_dir()
Message-ID: <Zsesertnqs_KhRd4@surfacebook.localdomain>
References: <20240821073441.9701-1-11162571@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821073441.9701-1-11162571@vivo.com>

Wed, Aug 21, 2024 at 03:34:40AM -0400, Yang Ruibin kirjoitti:
> The debugfs_create_dir() function returns error pointers.
> It never returns NULL. So use IS_ERR() to check it.

>  	selftest_dir = debugfs_create_dir("selftest_helpers", NULL);
> -	if (!selftest_dir)
> +	if (IS_ERR(selftest_dir))
>  		return -ENOMEM;

With this you most likely want to propagate error code to the caller

		return PTR_ERR(selftest_dir);

BUT, we usually don't check debugfs error codes as the program should work
anyway. Does this test case actually _rely_ on debugfs to be functional?

-- 
With Best Regards,
Andy Shevchenko



