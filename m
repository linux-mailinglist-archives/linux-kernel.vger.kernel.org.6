Return-Path: <linux-kernel+bounces-538758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 319A2A49CBC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5365B189A64C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AC31EF369;
	Fri, 28 Feb 2025 15:02:37 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046211EF360;
	Fri, 28 Feb 2025 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740754957; cv=none; b=VK6fbv1fo6sPtZJQv7lCzLATnf4v/AsIU6cDq9irXfQqdfLUcPMCIfm5rOcry+mUkNSRwUalz4R8Jp8evGWxaYAVSyetCZQvTiFjswSOUPzEkcSv6thPDY9qEViAoYWsiVyL9Vak9eK/Hmr0K9hRxM0hfguvEmsAcFvujhZQVuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740754957; c=relaxed/simple;
	bh=6nrJ9zZe3Dfp9Hs287X+B1HADF4QbPQlhsZlZF/7tM4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dSFksvyNv5wZZSH/o9Ld4RCM5sXTjesULasau/cQ/PpSw0ATscVfjmeTITaBWc9lYzAh4Z8ZI6sVqfIo0yOF8F5XS6nCLvz8OwFCZK23pVjDqErK92UNQkUa/SEnFa+VbeJECxMZS+W/rnOxUwhoYn/Hw80rD6TdWA27z1zcLWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CDFC4CED6;
	Fri, 28 Feb 2025 15:02:34 +0000 (UTC)
Date: Fri, 28 Feb 2025 10:03:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Aditya Garg <gargaditya08@live.com>
Cc: "pmladek@suse.com" <pmladek@suse.com>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, "senozhatsky@chromium.org"
 <senozhatsky@chromium.org>, "corbet@lwn.net" <corbet@lwn.net>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "apw@canonical.com" <apw@canonical.com>, "joe@perches.com"
 <joe@perches.com>, "dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
 "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hector
 Martin <marcan@marcan.st>, "sven@svenpeter.dev" <sven@svenpeter.dev>, Janne
 Grunau <j@jannau.net>, "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>,
 "asahi@lists.linux.dev" <asahi@lists.linux.dev>
Subject: Re: [PATCH v4] lib/vsprintf: Add support for generic FOURCCs by
 extending %p4cc
Message-ID: <20250228100319.10f6bb9e@gandalf.local.home>
In-Reply-To: <PN3PR01MB95972518DA57C43F01769B83B8CC2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <DB7F502D-1477-49C9-A36D-1DEE408ED23C@live.com>
	<PN3PR01MB95972518DA57C43F01769B83B8CC2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Feb 2025 14:09:48 +0000
Aditya Garg <gargaditya08@live.com> wrote:

> > -    *p++ = ' ';
> > -    strcpy(p, orig & BIT(31) ? "big-endian" : "little-endian");
> > -    p += strlen(p);
> > +    if (pixel_fmt) {
> > +        *p++ = ' ';
> > +        strcpy(p, orig & BIT(31) ? "big-endian" : "little-endian");  
> 
> Do we need strscpy here?

Why? The size of what p points to has already been calculated to hold this:

	char output[sizeof("0123 little-endian (0x01234567)")];
	char *p = output;

Unless you changed something, it will not overflow.

-- Steve

