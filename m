Return-Path: <linux-kernel+bounces-527555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5166A40C95
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 03:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A6AA7ACBCE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 02:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A0B13AC1;
	Sun, 23 Feb 2025 02:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="xYX9Z940"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154618836;
	Sun, 23 Feb 2025 02:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740278792; cv=none; b=FSSsxYoj7w79SwG99vUD77PVVpyhCdSj4mz/m/o5eWoStuBAcgctU4ebevDmh5FT7nQW8Fc2wTKJ452MgZ83hnuWv0ZQZYc5weZMp4aF228fTVqDdn7hkMqF/DiOOiW7BVe1V0ayYrSa6nWj0TPpJ3YgYfXqX/NflSkiE2cx4C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740278792; c=relaxed/simple;
	bh=dhYI81vtV3obBhOyd6vtWZA2PuYEd7yu7su4Ec03D9Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=H04cWDWYZiQq25L5Z7llP2KJgoTwSO8KKW+RqUVNfX9OOhVhWWnpsNW6e+fd1NDkeUIKQMANw3jYlHIOZImsQkoCU4HFo5Aklr2uPK0lHM7O7lIUxwM4EFxxeDPzgW5bwhnJr8CjB0cktYzJ8+Xj8kjZqASdGVhPvl8a169AAQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=xYX9Z940; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F49C4CED1;
	Sun, 23 Feb 2025 02:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1740278791;
	bh=dhYI81vtV3obBhOyd6vtWZA2PuYEd7yu7su4Ec03D9Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=xYX9Z940qj9qMlHFAeliNqDDjM6RMZ1xSMUkk8IKicYPc2dqCJMOkZoj1GRFQGNsC
	 pRhoTTAlfDqhTITuQ1z5B0hn6FNgDQKP+FGR7hWVCjOzXxNenojgwlU5y0+v0q6fg0
	 4X5q7lbo6B4Hxq2jEL/IK0PHv4/w6yaQbTRgHsKk=
Date: Sat, 22 Feb 2025 18:46:30 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Thomas Prescher <thomas.prescher@cyberus-technology.de>
Cc: "willy@infradead.org" <willy@infradead.org>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>, "corbet@lwn.net" <corbet@lwn.net>,
 "muchun.song@linux.dev" <muchun.song@linux.dev>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: hugetlb: add hugetlb_alloc_threads cmdline
 option
Message-Id: <20250222184630.1f25865325eced9b0f37eb85@linux-foundation.org>
In-Reply-To: <eeb9d580a41cb314aba6ad21e751b506dc9cc434.camel@cyberus-technology.de>
References: <20250221-hugepage-parameter-v1-0-fa49a77c87c8@cyberus-technology.de>
	<20250221-hugepage-parameter-v1-1-fa49a77c87c8@cyberus-technology.de>
	<Z7iFHkybeT4v8Jbo@casper.infradead.org>
	<eeb9d580a41cb314aba6ad21e751b506dc9cc434.camel@cyberus-technology.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Feb 2025 14:16:31 +0000 Thomas Prescher <thomas.prescher@cyberus=
-technology.de> wrote:

> On Fri, 2025-02-21 at 13:52 +0000, Matthew Wilcox wrote:
> > I don't think we should add a command line option (ie blame the
> > sysadmin
> > for getting it wrong).=A0 Instead, we should figure out the right
> > number.
> > Is it half the number of threads per socket?=A0 A quarter?=A0 90%?=A0 I=
t's
> > bootup, the threads aren't really doing anything else.=A0 But we
> > should figure it out, not the sysadmin.
>=20
> I don't think we will find a number that delivers the best performance
> on every system out there. With the two systems we tested, we already
> see some differences.
>=20
> The Skylake servers have 36 threads per socket and deliver the best
> performance when we use 8 threads which is 22%. Using more threads
> decreases the performance.
>=20
> On Cascade Lake with 48 threads per socket, we see the best performance
> when using 32 threads which is 66%. Using more threads also decreases
> the performance here (not included in the table obove). The performance
> benefits of using more than 8 threads are very marginal though.
>=20
> I'm completely open to change the default so something that makes more
> sense. From the experiments we did so far, 25% of the threads per node
> deliver a reasonable good performance. We could still keep the
> parameter for sysadmins that want to micro-optimize the bootup time
> though.

I'm all for auto-tuning but yeah, for a boot-time thing like this we
require a boot-time knob.

As is often (always) the case, the sad thing is that about five people
in the world know that this exists.  How can we tell our users that
this new thing is available and possibly useful to them?  We have no
channel.

Perhaps in your [2/2] we could be noisier? =20

	HugeTLB: allocation took 4242ms with hugepage_alloc_threads=3D42

and with a facility level higher than KERN_DEBUG (can/should we use
pr_foo() here, btw?).  That should get people curious and poking around
in the documentation and experimenting.

