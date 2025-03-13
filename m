Return-Path: <linux-kernel+bounces-559692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E13A5F828
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C449619C3A2B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF4C267F70;
	Thu, 13 Mar 2025 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="AfWHpHnM"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C061267F47
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876205; cv=none; b=iqwfuL2CJK+VdgJW0kPpbFCKtMy4Hoc8sgxwBHMwQneTbwYiX3Il60S9XOWaURZzf0eUVg/NoTFSH7ag8OKR2KvsUwdlXGoOlzhuLcvsl2pzYs0hJMioIDRsL01qB1EDj4AjwszjMifw7ddNoVSK4Y5EcRIEzvEL7G0Px9z3BqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876205; c=relaxed/simple;
	bh=QO0UPfQQymXHeypC5X6LCSQpNz+vVL9uYM6sc2XnAqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugLIMDPWPhcmuPKUMbm15yneTD/ugGKUMUXA/6iMg+kJSZYtSIPt6iqqJzBW70LcLHHUrmnzNAY2wIjU9H9bmpOUhC7v05AYK7H9J0jFH2XS8Z22nfpyYnTmp+HZOBDuu6IESmhfxI8oykVSP2qKSi2MtmbC6T98+Qay6j2Upig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=AfWHpHnM; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Date: Thu, 13 Mar 2025 10:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1741876201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QO0UPfQQymXHeypC5X6LCSQpNz+vVL9uYM6sc2XnAqk=;
	b=AfWHpHnMiCbbj/ZAw5DMFsA65UmLlBmEiN1FW5lL7XwaAsrXmjIsJejDSEnU0GmrquJ4FC
	wYfGhpFUCFdlmP59JRXCIUFmG6CKzgM2zMmOelOSClc+TquVXAy8dh2THLxRLheAr4vYa8
	n11f98diUkhdvseID3pZpsloOj/YiNR8S6x+bYF7gET4fpHl8DOwdBTT9XOJI4F0S71hQy
	hVtse0BcplVegVGgj9WqWcBKPLWIoG+5A3IKElNY5Ffa0bqTXawcPEq26SbviK0WK0xITU
	Lx1SoPKDu0J0dwRwCEGsdrtm/2JsuDE77O+GZ9m2NXVlAMbI0Y9DMN8+fTI2DQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: Aditya Garg <gargaditya08@live.com>
Cc: Petr Mladek <pmladek@suse.com>,
	"keescook@chromium.org" <keescook@chromium.org>,
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
	Andrew Morton <akpm@linux-foundation.org>,
	"apw@canonical.com" <apw@canonical.com>,
	"joe@perches.com" <joe@perches.com>,
	"dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
	"lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Hector Martin <marcan@marcan.st>,
	Asahi Linux Mailing List <asahi@lists.linux.dev>
Subject: Re: [PATCH v2 0/2] Use proper printk format in appletbdrm
Message-ID: <Z9Lr39wuJc80Cnsb@blossom>
References: <F61E0F31-980B-4855-9AA8-D594BEEFEC6F@live.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F61E0F31-980B-4855-9AA8-D594BEEFEC6F@live.com>
X-Migadu-Flow: FLOW_OUT

series looks ok to me. Who is pushing this to drm-misc-next? (I can if
nobody else does)

