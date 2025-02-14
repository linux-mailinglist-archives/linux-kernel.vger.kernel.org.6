Return-Path: <linux-kernel+bounces-514820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BD3A35C1F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20FD43A5EE6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BB225D527;
	Fri, 14 Feb 2025 11:05:13 +0000 (UTC)
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBAC186E40
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739531112; cv=none; b=f1/YGwz5Ao03sc4JunzvFfgaUAIvlvnaVVFMDqrK5NufMSTQJwEnAin27hpeNoONtIJ7jQPdOy5u0ha8r+rkAdrHc6LRwYyhrLFNp5PmNZa3oAATz57Zm5eQDsHapQeICUBEywg/EIN6PcMgFZSKFqcM5wmdUYdXn05uMTmbA7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739531112; c=relaxed/simple;
	bh=EOZeC2qW3tBDxODk6SdrQdSgbgk94gMrwuSWMSP+hQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBUpD5a665jgkZERBzFWj5xHRTBhP0v5yOb9IMZH0yeWXtWGU4yqqGuZtyfnrHQA6EljRBmxTC2ihfVPt2XgnauGf786bOKlilSTgKn+ZLzZ9VhJ9689CqVD99VrCGfywXlF9DHIlx/MLkIh0KLUBAmeE50/kbkVzm3JlZvrUPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 25BD972C8CC;
	Fri, 14 Feb 2025 14:05:09 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 15DEF7CCB3A; Fri, 14 Feb 2025 13:05:09 +0200 (IST)
Date: Fri, 14 Feb 2025 13:05:08 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Dmitry Vyukov <dvyukov@google.com>, Oleg Nesterov <oleg@redhat.com>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
	Ard Biesheuvel <ardb@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/31] ARM: Switch to generic entry
Message-ID: <20250214110508.GA19194@strace.io>
References: <20250212-arm-generic-entry-v4-0-a457ff0a61d6@linaro.org>
 <20250214010325.GA12626@strace.io>
 <CACRpkdZJYFUhmPg3EWJeU42fzJMzWm7Sgn3XfELB2-PSCf6Ssw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZJYFUhmPg3EWJeU42fzJMzWm7Sgn3XfELB2-PSCf6Ssw@mail.gmail.com>

On Fri, Feb 14, 2025 at 11:47:30AM +0100, Linus Walleij wrote:
> On Fri, Feb 14, 2025 at 2:03 AM Dmitry V. Levin <ldv@strace.io> wrote:
> > On Wed, Feb 12, 2025 at 12:22:54PM +0100, Linus Walleij wrote:
> > [...]
> > > - Tested some ptrace/strace obviously, such as issuing
> > >   several instances of "ptrace find /" and let this scroll
> > >   by in the terminal over some 10 minutes or so.
> >
> > Could you also run the strace test suite, please?  Given that it used to
> > catch quite a few regressions in the past, it could be useful in this case
> > as well.
> 
> Sure, where can I find this test suite?

It's a part of strace, you can find it e.g. at
https://github.com/strace/strace

To build and run it one can roughly do
./bootstrap && ./configure && make -j`nproc` && make -j`nproc check


-- 
ldv

