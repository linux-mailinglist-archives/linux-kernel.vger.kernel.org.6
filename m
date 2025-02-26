Return-Path: <linux-kernel+bounces-534377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 191AFA46662
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A07017EC0D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F92621CFEE;
	Wed, 26 Feb 2025 15:59:56 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAB428F3;
	Wed, 26 Feb 2025 15:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585595; cv=none; b=hwUJk6OKHoyfFZdPEmQdlYGW0Ta3FJZEQxZ1OdGDHzmhiGuwyh7lTr3AG2xTeiuEhGe7ENS9n4AOLnHHcPc6ocQ8LgB+CBrhGfW+cucKdJHDLhRVjoGoTlIfHtOGaE9AVodOyRMrSJhD6XzpGw+3/WyoO+zV3ismjF2E7MF89bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585595; c=relaxed/simple;
	bh=8U3HqDiHPY2xjpZ1i9Tfu5CN8cLyRtEgus9/9JMgOvU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H9NqH8fRTuVlHKYrvBItzto3Eja7jVvJNpk2l2dec7WnNt1JgA0mX4D0ebbJ+3dhHEvVEH/T/YEhwSjnWo4FRKmRzNw16FK6wLc64LjfY2PQABBQKAXF5byDnYM2zERs0PW7A9Ny1KEtA9EM/xpQtJIMEW54tLa3FagsihJGogE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB04C4CEE8;
	Wed, 26 Feb 2025 15:59:53 +0000 (UTC)
Date: Wed, 26 Feb 2025 11:00:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>, Ventura Jack <venturajack85@gmail.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, "H. Peter Anvin"
 <hpa@zytor.com>, Alice Ryhl <aliceryhl@google.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Gary Guo <gary@garyguo.net>,
 airlied@gmail.com, boqun.feng@gmail.com, david.laight.linux@gmail.com,
 ej@inai.de, hch@infradead.org, ksummit@lists.linux.dev,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Ralf Jung
 <post@ralfj.de>
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <20250226110033.53508cbf@gandalf.local.home>
In-Reply-To: <16127450a24e9df8112a347fe5f6df9c9cca2926.camel@HansenPartnership.com>
References: <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
	<CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
	<CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
	<CAFJgqgREAj-eP-d244WpqO-9H48ajZh83AxE31GqoONZ=DJe-g@mail.gmail.com>
	<CAH5fLghEMtT663SNogAGad-qk7umefGeBKbm+QjKKzoskjOubw@mail.gmail.com>
	<5E3FEDC4-DBE3-45C7-A331-DAADD3E7EB42@zytor.com>
	<2rrp3fmznibxyg3ocvsfasfnpwfp2skhf4x7ihrnvm72lemykf@lwp2jkdbwqgm>
	<CAFJgqgS-SMMEE2FktuCUimdGkPWMV3HB2Eg38SiUDQK1U8=rNg@mail.gmail.com>
	<CANiq72mOp0q1xgAHod1Y_mX86OESzdDsgSghtQCwe6iksNt-sA@mail.gmail.com>
	<f2bf76553c666178505cb9197659303a39faf7aa.camel@HansenPartnership.com>
	<2025022611-work-sandal-2759@gregkh>
	<16127450a24e9df8112a347fe5f6df9c9cca2926.camel@HansenPartnership.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 09:45:53 -0500
James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> >From some other rust boot system work, I know that the quality of a  
> simple backtrace in rust where you just pick out addresses you think
> you know in the stack and print them as symbols can sometimes be rather
> misleading, which is why you need an unwinder to tell you exactly what
> happened.

One thing I learned at GNU Cauldron last year is that the kernel folks use
the term "unwinding" incorrectly. Unwinding to the compiler folks mean
having full access to all the frames and variables and what not for all the
previous functions.

What the kernel calls "unwinding" the compiler folks call "stack walking".
That's a much easier task than doing an unwinding, and that is usually all
we need when something crashes.

That may be the confusion here.

-- Steve

