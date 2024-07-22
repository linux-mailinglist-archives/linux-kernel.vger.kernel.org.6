Return-Path: <linux-kernel+bounces-258597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B805938A4C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D43D1C210EB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 07:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5C31428F1;
	Mon, 22 Jul 2024 07:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="GC/XY2OC"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4DC12B63
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 07:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721634106; cv=none; b=Qagh5vFun8FkYbUOf91O6otK+T4cXbRNGbK+VIBwTjhVzbd1FuIjmA/VyVegmbqKosp/moY7OrZamp1kAoboj5+4K1otqKxjtHFrni/4COJ1vA4GdhtJ/2ulp7XdsHNWLzUVz6sn3KdMdI4HndV/c7nIo6ebGUKtad1hNwkEMCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721634106; c=relaxed/simple;
	bh=esKhJZYkK5yy370gyJUYX533J8F+lQBS2H7SLPRUTfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMWd83EgP4YOoth7y+3QcxUua10d0yQ18tbx6kyY90/7l33OZ+VLE908ZffTUJvTxx2KQArraJCoR9RuGzjHFmbKi/O1lUvvqM8CcYd+pgXNzl7YlZQJ1hH3+zHGvFhO3wW2uHdyznIk8s9dg29EoVEYJutsj188fq8MlbCu7dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=GC/XY2OC; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1721634097;
	bh=esKhJZYkK5yy370gyJUYX533J8F+lQBS2H7SLPRUTfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GC/XY2OCmQHDfL9Enw+oCVHxHf8Ul2hbiGs3TC1zU6CcQrsnDe4tqgiHmKauLkqGj
	 SPqsecScm9mzx4FxiuYhScEZ2N+obgceGqYdJjoHBS4hM0X7EIhyyxgi9lwExpYJN8
	 AjIxHNt4Rs5m5hdrHdMng2VtLTDkNEZkKMbDC8uA=
Date: Mon, 22 Jul 2024 09:41:36 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Joel Granados <j.granados@samsung.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sysctl: treewide: constify the ctl_table argument of
 proc_handlers
Message-ID: <8a48b4d3-94ca-4a42-bf59-c340d7316603@t-8ch.de>
References: <CGME20240619100941eucas1p25d522dca3b74c899434b97b0c0dc78a0@eucas1p2.samsung.com>
 <20240619-sysctl-const-handler-v2-1-e36d00707097@weissschuh.net>
 <20240715202319.mccb6jlsa6dkynap@joelS2.panther.com>
 <f7489470-b0da-406b-a8dd-0ae7aaeceec8@t-8ch.de>
 <20240716152705.juet6srejwq5o6je@joelS2.panther.com>
 <cdf0831f-f9af-4aa7-a3a0-970efeec1def@t-8ch.de>
 <20240717195748.fe5ttokbibcsw2ca@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240717195748.fe5ttokbibcsw2ca@joelS2.panther.com>

Hi Joel,

On 2024-07-17 21:57:48+0000, Joel Granados wrote:
> On Wed, Jul 17, 2024 at 05:26:44PM +0200, Thomas Weißschuh wrote:
> > On 2024-07-16 17:27:05+0000, Joel Granados wrote:
> > > On Mon, Jul 15, 2024 at 10:58:10PM +0200, Thomas Weißschuh wrote:
> > > > On 2024-07-15 22:23:19+0000, Joel Granados wrote:
> > > ...
> > > > > The merge window is now open. I want to send this patch on the Wednesday
> > > > > of next week (jul 24).
> > 
> > <snip>
> > 
> > > > > 2. Does it still apply cleanly against the latest master branch?
> > > > 
> > > > Not against mainline master, but against next-20240715.
> > > > To apply cleanly (and compile) on mainline master it still requires the
> > > > net/ and sysctl trees to be merged.
> > > > Otherwise some modified functions are missing, leading to (trivial) merge
> > > > conflicts or the preparation commits are missing, leading to compilation
> > > > errors.
> > > 
> > > Understood. I have just sent Linus the changes for sysctl-next, so those
> > > should land in master soon (baring any issues with the pull request).
> > > 
> > > These [1] and [2] are the two series in net-dev that are the deps for
> > > the constification treewide patch. Once these two go into mainline, then
> > > we are good to go. Right?
> > 
> > Right, but...
> > 
> > It turns out the preparation patch for mm/hugetlb.c [0] is also still
> > missing. I missed it in all the errors triggered in net/.
> > But as far as I can see this patch will be part of Andrew's PR for mm.
> 
> Thx for the heads up, I'll Add that one to my radar of things that need
> to be in master before we send the PR to Linus. Will check these three
> dependencies on Wednesday next week and send your V2 [3] if I see that
> it applies cleanly.

All dependency PRs (sysctl, net, mm) are now merged.
My compilation tests all succeed now.

> > <snip>
> > 
> > [0] https://lore.kernel.org/lkml/20240518-sysctl-const-handler-hugetlb-v1-1-47e34e2871b2@weissschuh.net/
> > 
> > > [1] net: constify ctl_table arguments of utility functions
> > >     https://patchwork.kernel.org/project/netdevbpf/list/?series=856252&state=%2A&archive=both
> > > [2] bpf: constify member bpf_sysctl_kern::table
> > >     https://patchwork.kernel.org/project/netdevbpf/list/?series=854191&state=*
> 
> [3] https://lore.kernel.org/20240619-sysctl-const-handler-v2-1-e36d00707097@weissschuh.net

