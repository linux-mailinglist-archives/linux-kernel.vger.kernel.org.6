Return-Path: <linux-kernel+bounces-238241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DC3924756
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 20:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C344728793C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DD11C8FCA;
	Tue,  2 Jul 2024 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="zef7oasD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C18D158DD1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719945356; cv=none; b=nzvromTr5FYnKxv/ESwPVYXsovs6agFuCRdsY6wpDeuf0k8Su8X5j0yZ+wjatKJhR6hBF1kKmaRJ6B8GsCGuM+huzdb5M2WZA5908bf5ZQ4aZUq39u5Zua2fCODnaGn4fu74TL4GybiansQaW2jZF6cdANFrIlg6gMBlZorcIwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719945356; c=relaxed/simple;
	bh=LQa0boYAjyiQy2XLCVd6hOtBE8EViR0thVWazO0ORBE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jGQ8mQOMRbnGOt50IoLjGb9Cpe4TIJZFjNr1ubEgRRs5kv6HudontP4b9uDEt5T9CUTppY3Ae3GRkexpdi4FegN85d2g4j7Gzohd3B3XSoXt+PKOWQmiQtscnZUbkKZdb5lxKLO18NMKZPDEnSplH3XYsZuXBgvtQKSbpAdgB6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=zef7oasD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE57C116B1;
	Tue,  2 Jul 2024 18:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719945356;
	bh=LQa0boYAjyiQy2XLCVd6hOtBE8EViR0thVWazO0ORBE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=zef7oasDBBFb8JoFScauVEm3d31GuSk9PSFVdwIdGlqkzeoqssuhuGZVKJF59/a3z
	 XiI4qE9zGQyfOMiYSRRBwZ5h5EOrBlp1BUtYABxU57cIgZ7bKctUMrg4FC12YMnVvD
	 g2Lrf9YduwMjgojynKmmrIryRaYjPiwTu4I7fezM=
Date: Tue, 2 Jul 2024 11:35:54 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy
 Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v3 0/3] x86/mm: LAM fixups and cleanups
Message-Id: <20240702113554.2471f000055f3c717fced4f5@linux-foundation.org>
In-Reply-To: <CAJD7tkb7=sBdxXTmcqxe3+UWsTT7R6-rKGBhkEfgEAdTY+5jCw@mail.gmail.com>
References: <20240702132139.3332013-1-yosryahmed@google.com>
	<20240702103628.61879ef17b9b01305515c634@linux-foundation.org>
	<CAJD7tkb7=sBdxXTmcqxe3+UWsTT7R6-rKGBhkEfgEAdTY+5jCw@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 2 Jul 2024 10:39:03 -0700 Yosry Ahmed <yosryahmed@google.com> wrote:

> On Tue, Jul 2, 2024 at 10:36 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Tue,  2 Jul 2024 13:21:36 +0000 Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > > This series has fixups and cleanups for LAM. Most importantly, patch 1
> > > fixes a sycnhronization issue that may cause crashes of userspace
> > > applications. This is a resend of v3, rebased on top of v6.10-rc6.
> >
> > "Crashes of userspace applications" is bad.  Yet the patchset has been
> > floating about for four months.
> >
> > It's unclear (to me) how serious this is.  Can you please explain how
> > common this is, what the userspace application needs to do to trigger
> > this, etc?
> 
> I don't think it would be common. The bug only happens on new hardware
> supporting LAM, and it happens in a specific scenario where a
> userspace task enables LAM while a kthread is using (borrowing) its
> mm_struct on another CPU.
> 
> So it is possible but I certainly wouldn't call it common or easily triggerable.

But when people run older (or current) kernels on newer hardware, they
will hit this.  So a backport to cover 82721d8b25d7 ("x86/mm: Handle
LAM on context switch") is needed.

The series doesn't seem to be getting much traction so I can add it to
mm.git's mm-unstable branch for wider testing, but it's clearly an x86
tree thing.

