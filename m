Return-Path: <linux-kernel+bounces-560128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 128A1A5FE43
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5604716DCE1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F4D1D5CD4;
	Thu, 13 Mar 2025 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGCd10d6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237FA18A6CE;
	Thu, 13 Mar 2025 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887608; cv=none; b=WH6SC1BJ+jLtmJ/rCKxwG6GbK/e0egF/BV5Fi0fz7rB50AUdHuY6zb/8I7J/dKhIQTSA/j+iPNShLcMLmc3S0qkfKN/Tpx4zuf2pW5bZS8zD50C7A4/Tmb0R5Fp3cR0okpoiIXZWTPolpQ9lfa6Qw8dM/v9bH0baGv6ETyspX64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887608; c=relaxed/simple;
	bh=sMoNdhw6t/4fHOZ+BhebHKDBcl6WdAFfIhyLwLa/Hkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMn0h/CyCrVJDBD5kQs1VxtupeieFrGcl6DonRpFsVhyZXjEEdHJzixNfFDWvkCZfnX6mLn5oiwpEOUOU0z6HTI0uyiRkSoK8c2xLF1eB2Td8RJQ2Xl9CDJPzeR5RTBPjQHHsa7JUHWKmy+dKAx2lJqDilXktP+72S9afUul2Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGCd10d6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAB2C4CEE3;
	Thu, 13 Mar 2025 17:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741887607;
	bh=sMoNdhw6t/4fHOZ+BhebHKDBcl6WdAFfIhyLwLa/Hkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GGCd10d6DJFDskZH7cd22tyTItzmlWKzWIwb0SFAmTXTetera5PQFqBxDXXLLQr/z
	 fDVe9v3w4oAiq6crPpThJoEsVJexkHR40L8P/VpK5clc/46wzB5kprHDzZX86B3PBK
	 PRSNQB996nmnBpQQCHGTn8nsPspZUrnBdphVK2UewpTMWpP3rr44HTKWkQCo91/Uxd
	 GRdya4V+9rksEpmkyEcwjwtvusQjKxo5gGxTy+v5wxd+I6Qex7ReYW0QZOnC5EqvCu
	 tPDSoDMTb0NrQnSHWfDLy6L6MxQ9W9cZnidxb3cakSP20C12L8rKpZCP8UJJLb4RJT
	 ttM8iTwgBZkVg==
Date: Thu, 13 Mar 2025 10:40:04 -0700
From: Kees Cook <kees@kernel.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Aditya Garg <gargaditya08@live.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sven Peter <sven@svenpeter.dev>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Aun-Ali Zaidi <admin@kodeit.net>,
	Maxime Ripard <mripard@kernel.org>,
	"airlied@redhat.com" <airlied@redhat.com>,
	Simona Vetter <simona@ffwll.ch>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"apw@canonical.com" <apw@canonical.com>,
	"joe@perches.com" <joe@perches.com>,
	"dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
	"lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Hector Martin <marcan@marcan.st>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>
Subject: Re: [PATCH 1/2] lib/vsprintf: Add support for generic FourCCs by
 extending %p4cc
Message-ID: <202503131035.A5FEBE32@keescook>
References: <PN3PR01MB959715C19BCEA54426D24934B8D02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <ff3a9c58-5c7a-4c48-8a9e-cc828a43baed@app.fastmail.com>
 <PN3PR01MB9597E5C609290DB1A967263CB8D02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <Z9HgVn-XELC065w0@smile.fi.intel.com>
 <47AE7FCD-0F30-4379-ADE9-090A15ACD58F@live.com>
 <Z9Kb8zMJgmSP-rgD@smile.fi.intel.com>
 <PN3PR01MB959780176C0B16C36FBD59C3B8D32@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <Z9KdzZUxs3vlwp0Z@smile.fi.intel.com>
 <PN3PR01MB9597A8F02423B9E4C585F5EBB8D32@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <Z9K36SRz7Ja_AyQb@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9K36SRz7Ja_AyQb@pathway.suse.cz>

On Thu, Mar 13, 2025 at 11:48:32AM +0100, Petr Mladek wrote:
> So I am fine with this patch:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Tested-by: Petr Mladek <pmladek@suse.com>
> 
> 
> Now, the question is how to get this patch into the mainline.
> 
> Normally, it would make perfect sense to queue it via the DRM tree
> because drivers/gpu/drm/tiny/appletbdrm.c is a new driver...
> 
> But this time there is a conflicting patchset which is reworking
> the entire lib/test_printf.c file, see
> 20250307-printf-kunit-convert-v6-0-4d85c361c241@gmail.com
> And it will likely be ready for the next merge window as well.
> I am going to review it right away.
> 
> It is even more complicated because the patchset converting
> the printf test module to KUNIT depends on another changes
> in Kees' tree (moving kunit test modules to lib/tests/).
> So it might be easier when it goes via Kees' tree.
> 
> And it might be easier when even this patch goes via Kees' tree.
> 
> My proposal:
> 
> I suggest to separate the fourcc_pointer() test update
> to a separate patch and add it later after the merge window
> when things settle down.
> 
> I mean to send the vsprintf.c, checkpatch.pl, and doc update
> via DRM tree together with the new appletbdrm.c driver.
> 
> And update the selftest later when both DRM tree and KUNIT
> update reaches mainline.
> 
> How does that sound, please?

I'm happy to do whatever makes this easiest.

If patch #1 here were rebased onto the "kunit move" tree:
https://web.git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=for-next/move-kunit-tests
then I could just take it there?

-Kees

-- 
Kees Cook

