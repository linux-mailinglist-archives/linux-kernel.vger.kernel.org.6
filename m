Return-Path: <linux-kernel+bounces-336671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A1B983F0C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1FE1F2133F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A875C145B22;
	Tue, 24 Sep 2024 07:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M43dNRPO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C093142E9F
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727162713; cv=none; b=HLYnrYtiGaTFnTjeZIF4nX/+MEBl73FfyngMIFOi1BWMBllot9eaHf82VQQsHz88XFaqdobKPI483ojV+7sFYnplH6ftZ6X5rkgBCncEzzspmN002DdpMR9GFIfZMo4aCE+Kz6VWyTidJJnfWFeUs3hI7jFyjtaWLtmIa1pKAFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727162713; c=relaxed/simple;
	bh=zWgWLNxr/ZBAMKCeXmf0mjEdKqz10YcSHKUA7MvAkQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThcFuGNEH8E7Zl+zJSrd+rpNR81ZxP3JyMj0CFZPb5VanwK+Vr++uYj+Uzd+Qw7ZVZZRekqFyIQ73eEuBLezxfTTL0oaTpYTK8sfRCFJ0PZ7Nr0iZ2mIin8F9D9xRM5v8PQDhCjD5qKNeu7YfwOAGPP2WjHu/g4V2ETkFdhnwDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M43dNRPO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1897C4CEC4;
	Tue, 24 Sep 2024 07:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727162712;
	bh=zWgWLNxr/ZBAMKCeXmf0mjEdKqz10YcSHKUA7MvAkQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M43dNRPO/KgrOPJF2BUYyYB0U1xLWO6/n/dlUZgMKSJjbVdJ5qS5JofsO4WbQKeVy
	 ECm/PDFWvrPV4vjIysvr9CP9DQqWsAz/NhvqigKcRbuZMFVMyyniR++Wc6oyAXE1zk
	 A9fycO9fPew8AQVhMHevfWf0DAnDKB4AORm8A+LEI8VK3bKHMDwsL1PLoZWvIYQUDY
	 3QOPd/wy19wpeGadXk2mwXKt/0HJUO9Z7ick3jfb8gXRujKQA1YPlJZXfg6HOoQuvu
	 nYK8jYZ27PgCLr+JEzftBES9B/K1/S8jeHsEPiEzwTbr2CnaYUUtAzQYt5QX6SHsYv
	 P0xEN30A0Xhwg==
Date: Tue, 24 Sep 2024 10:22:02 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jinjie Ruan <ruanjinjie@huawei.com>, linux-kernel@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH] static_call: Handle module init failure correctly in
 static_call_del_module()
Message-ID: <ZvJomuNWjtHYDcsW@kernel.org>
References: <87cylj7v6x.ffs@tglx>
 <3e158999-c93a-a4e3-85a9-2d6bfc1ccee7@huawei.com>
 <877cbr7qed.ffs@tglx>
 <50551f21-6e90-3556-7a3d-8b81a042f99c@huawei.com>
 <87a5gm5tb3.ffs@tglx>
 <ZtuPSIFsV8C3UZW8@bombadil.infradead.org>
 <Zuv0nmFblHUwuT8v@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zuv0nmFblHUwuT8v@bombadil.infradead.org>

On Thu, Sep 19, 2024 at 02:53:34AM -0700, Luis Chamberlain wrote:
> On Fri, Sep 06, 2024 at 04:24:56PM -0700, Luis Chamberlain wrote:
> > On Thu, Sep 05, 2024 at 11:44:00AM +0200, Thomas Gleixner wrote:
> > > Now you at least provided the information that the missing cleanup in
> > > the init() function is not the problem. So the obvious place to look is
> > > in the module core code whether there is a failure path _after_
> > > module->init() returned success.
> > > 
> > > do_init_module()
> > >         ret = do_one_initcall(mod->init);
> > >         ...
> > > 	ret = module_enable_rodata_ro(mod, true);
> > > 	if (ret)
> > > 		goto fail_mutex_unlock;
> > > 
> > > and that error path does _not_ invoke module->exit(), which is obviously
> > > not correct. Luis?
> > 
> > You're spot on this needs fixing.
> 
> Christophe, this is a regression caused by the second hunk of your commit
> d1909c0221739 ("module: Don't ignore errors from set_memory_XX()") on v6.9.
> Sadly there are a few issues with trying to get to call mod->exit():
> 
> - We should try try_stop_module()  and that can fail
> - source_list may not be empty and that would block removal
> - mod->exit may not exist
> 
> I'm wondering if instead we should try to do the module_enable_rodata_ro()
> before the init, but that requires a bit more careful evaluation...

There is ro_after_init section, we can't really make it RO before ->init()
 
>   Luis

-- 
Sincerely yours,
Mike.

