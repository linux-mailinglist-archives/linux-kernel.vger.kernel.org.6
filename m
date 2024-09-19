Return-Path: <linux-kernel+bounces-333378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E99E97C798
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 11:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64D1728F5CD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4751A0B02;
	Thu, 19 Sep 2024 09:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZiXkEd/3"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039401A7272
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 09:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726739646; cv=none; b=GYZ5b3/9hkBf2U9uSjfKP1AXzC0Pt9ldJkuQN+PJ6b5wf6POyfiO22xmdWfqRpF/2PbwfYhr/DepVbMmyKAZhLXTELw7PSXMyl32c+9CJkWFEL9gkJSRaJMmUcTqz45tYbIl2i+j0eZ4WYAa9hv8p6YId5WWMyh9nEMJ6uaO10Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726739646; c=relaxed/simple;
	bh=bx6I2LAdbDeJdUGiwYHxM45b7MXSkxLnONqoqI7bgnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgovnElTLIQ/5Sbk6C29PSTnP8k8PadyS3/jywhKcFV6Upv3PaYLqiqnxJY6xhToshjmNauWQwHgFStBU9+vmwkYe8qIkOqCge7pzQh6hwrUYd4Fbj/KdCCg5IoWuSqswMQ1catM88OiAqqQURzX/HE2sMlv+r6I4BDySjEuaXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZiXkEd/3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Bf8cMiPNBm0jrCQy5D7r8naod5Fwmo9wsnhTaIToQ2s=; b=ZiXkEd/3sseVd7Ivx284JkZZyz
	u2VVgMlZq7R92SXWxw3TIkT/eCudvgK1UTGXoCTl880pvf4QA99VdLH32gczozriHawgMckvJkwMg
	AAdIp8PFG46PapGKMqn+sW6FzIJJYS1NzAHjLgOU2hIBjh3obaic9X1mM9L65Q0lVrVcGd6famFZt
	LoNJxqRbuaq5EqRvWUqdhddD+UgWxTST2qswuQzqbMQ/lFYQQynBPwBX4I5/eyZpvs0JLojsLW6EI
	n9bFzC5RvF9MnasF1NPKYN9ss6oroFnVo6T4kK9IMc70ccXIjrg7d9qrMP0DOU0l/1MLgUGB3zagN
	w2ru2/2g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1srDqw-00000009zgU-0Xqv;
	Thu, 19 Sep 2024 09:53:34 +0000
Date: Thu, 19 Sep 2024 02:53:34 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mike Rapoport <rppt@kernel.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, linux-kernel@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH] static_call: Handle module init failure correctly in
 static_call_del_module()
Message-ID: <Zuv0nmFblHUwuT8v@bombadil.infradead.org>
References: <87cylj7v6x.ffs@tglx>
 <3e158999-c93a-a4e3-85a9-2d6bfc1ccee7@huawei.com>
 <877cbr7qed.ffs@tglx>
 <50551f21-6e90-3556-7a3d-8b81a042f99c@huawei.com>
 <87a5gm5tb3.ffs@tglx>
 <ZtuPSIFsV8C3UZW8@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtuPSIFsV8C3UZW8@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Sep 06, 2024 at 04:24:56PM -0700, Luis Chamberlain wrote:
> On Thu, Sep 05, 2024 at 11:44:00AM +0200, Thomas Gleixner wrote:
> > Now you at least provided the information that the missing cleanup in
> > the init() function is not the problem. So the obvious place to look is
> > in the module core code whether there is a failure path _after_
> > module->init() returned success.
> > 
> > do_init_module()
> >         ret = do_one_initcall(mod->init);
> >         ...
> > 	ret = module_enable_rodata_ro(mod, true);
> > 	if (ret)
> > 		goto fail_mutex_unlock;
> > 
> > and that error path does _not_ invoke module->exit(), which is obviously
> > not correct. Luis?
> 
> You're spot on this needs fixing.

Christophe, this is a regression caused by the second hunk of your commit
d1909c0221739 ("module: Don't ignore errors from set_memory_XX()") on v6.9.
Sadly there are a few issues with trying to get to call mod->exit():

- We should try try_stop_module()  and that can fail
- source_list may not be empty and that would block removal
- mod->exit may not exist

I'm wondering if instead we should try to do the module_enable_rodata_ro()
before the init, but that requires a bit more careful evaluation...

  Luis

