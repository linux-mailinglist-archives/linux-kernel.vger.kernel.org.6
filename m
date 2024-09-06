Return-Path: <linux-kernel+bounces-319552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD73996FE6D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 01:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2A21C21831
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 23:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B3315B149;
	Fri,  6 Sep 2024 23:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NQcE9AzM"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDE415AD83
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 23:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725665102; cv=none; b=DP0vs4AU/F+zU16h/1y0t4tEVoIUCCZPhyeHlUnc7vbpu5sFegytiqK4H+Qp0VI+U0VHa1K7byBxP1JrTerib+gzRgYGZbmx7TBKTKZqRVgWgf6eKoOyzLSczoi6LI5X2BmXZHK6njqbYw0mt9A7xLZWCShI1MfbKL2/EhYIIiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725665102; c=relaxed/simple;
	bh=dk6zGwGb5gDaauCu8JG+G+9YPHe7W/gku6czUJ2rzL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sy8CJCVzhySS5Nrja7WPYu5sHuSkGP7LQnBTBNARX+so1JDw7Wx9q189i8GQ7+9w1ZeJq52+J8ILeqU9RjzfcXXUbAZ2yXQw5ieaCYoBXCc1X7XYljv7RTBs0rLPpz0vU4O1XSnnH/9pZzvUUpmrziawf8nltVNne5ViF4e2uMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NQcE9AzM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2gajt9XcT2kfMbhIuLOuQAqLsxeqsQMRH2OB9A85B04=; b=NQcE9AzMHZ3rDNyeMm+fSF4/LE
	sA2hO81L25XHigVMUYSHmerfjPBMJx+Bxz2qNPDS/Ql0iIEProaz8rs3Yxvqwhl6kvusN1sIoO9zI
	SLDnqCbME9wXn8K9TyuvRY7ZIARdj63bJsfdVsNJOO/nblF+RgIanD19RBIuuVCBBcRICjvEgU/LP
	TXbF81ywhXuEIpPMv2XOiroZKnynXdYk0dz34MOZQhUEIwHVgCke3zCNVkIqyIccibLuy35ExiTfS
	83c0Iix32LTe7hCXA2g/aGqBD4HYCj4A/4RZmKvIJ6jUxRoEVgLA7NRgKwk1kkGmX7ZEYcR0AWj0r
	j/gYBtNg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smiK0-0000000DrM4-3m2w;
	Fri, 06 Sep 2024 23:24:56 +0000
Date: Fri, 6 Sep 2024 16:24:56 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, linux-kernel@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH] static_call: Handle module init failure correctly in
 static_call_del_module()
Message-ID: <ZtuPSIFsV8C3UZW8@bombadil.infradead.org>
References: <87cylj7v6x.ffs@tglx>
 <3e158999-c93a-a4e3-85a9-2d6bfc1ccee7@huawei.com>
 <877cbr7qed.ffs@tglx>
 <50551f21-6e90-3556-7a3d-8b81a042f99c@huawei.com>
 <87a5gm5tb3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5gm5tb3.ffs@tglx>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Sep 05, 2024 at 11:44:00AM +0200, Thomas Gleixner wrote:
> Now you at least provided the information that the missing cleanup in
> the init() function is not the problem. So the obvious place to look is
> in the module core code whether there is a failure path _after_
> module->init() returned success.
> 
> do_init_module()
>         ret = do_one_initcall(mod->init);
>         ...
> 	ret = module_enable_rodata_ro(mod, true);
> 	if (ret)
> 		goto fail_mutex_unlock;
> 
> and that error path does _not_ invoke module->exit(), which is obviously
> not correct. Luis?

You're spot on this needs fixing.

  Luis

