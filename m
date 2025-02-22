Return-Path: <linux-kernel+bounces-527044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F1AA406B6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 10:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF943B8FF3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 09:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBEE206F12;
	Sat, 22 Feb 2025 09:11:49 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E382063E3;
	Sat, 22 Feb 2025 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740215509; cv=none; b=oJS9MDXIvUtNbfU5Z8okrxRs4kppo9qr9V7ExKNtbcnNA4f+7Ngl1lJEz8CbUjuiDgvwsp0vAaiy0S6IRdDulq4bVnlBA0RlRcl0sbQkPzkRX+dlz9OITW3mqVLS5ijflRMtCYNYlRzhrC0Y9zgUQokRVJjxKyAu8xLCYtvfD38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740215509; c=relaxed/simple;
	bh=BUjO5GOu/xxfnRUpdXkDqZ4gAiwB8QGdG4O8Sqatxl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJF4Suzvb97BgEOaC7F+EuzwaS3Ft4crxELtHrwkN9Fj7c/aa8WV+VYrYltCgd7lql61/9/nQ6jRfC9LQ4VTpk/Z4nuHSwR3XMAOfU56CCuF0mGQtOMKZ2GYJd4UhShfW9mv3XDbTRE2CB1BC3mKNrB/C/lKlToO4KLO8MElisE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 51M9Bawf013131;
	Sat, 22 Feb 2025 10:11:36 +0100
Date: Sat, 22 Feb 2025 10:11:36 +0100
From: Willy Tarreau <w@1wt.eu>
To: David Laight <david.laight.linux@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Engelhardt <ej@inai.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
        ksummit@lists.linux.dev
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <20250222091136.GA12873@1wt.eu>
References: <2nn05osp-9538-11n6-5650-p87s31pnnqn0@vanv.qr>
 <2025022052-ferment-vice-a30b@gregkh>
 <9B01858A-7EBD-4570-AC51-3F66B2B1E868@zytor.com>
 <n05p910s-r5o3-0n36-5s44-qr769prp69r5@vanv.qr>
 <20250221183437.1e2b5b94@pumpkin>
 <CAHk-=wjF0wjD4ko7MgrZ1wBZ9QOrQd_AnyhDDUJQ1L5+i-o22A@mail.gmail.com>
 <20250221214501.11b76aa8@pumpkin>
 <20250222063210.GA11482@1wt.eu>
 <20250222063730.GB11482@1wt.eu>
 <20250222084112.23eb2856@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222084112.23eb2856@pumpkin>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Feb 22, 2025 at 08:41:12AM +0000, David Laight wrote:
> On Sat, 22 Feb 2025 07:37:30 +0100
> Willy Tarreau <w@1wt.eu> wrote:
> 
> ...
> > Update: I found in my code a comment suggesting that it works when using
> > -freg-struct (which is in fact -freg-struct-return) which works both on
> > i386 and ARM.
> 
> The problem is that you need it to be an __attribute__(()) so it can
> be per-function without breaking ABI.

Yes I agree that it would be better.

> > I just didn't remember about this and couldn't find it when
> > looking at gcc docs.
> 
> I can never find anything in there either.
> And then I wish they say when it was introduced.

Same here. At least on gcc-2.95 it was already recognized and worked fine:

- without:
  fct:
        movl 4(%esp),%ecx
        movl $5,%eax
        movl $100,%edx
        movl %eax,(%ecx)
        movl %edx,4(%ecx)
        movl %ecx,%eax
        ret $4

- with:
  fct:
        movl $5,%eax
        movl $100,%edx
        ret

Willy

