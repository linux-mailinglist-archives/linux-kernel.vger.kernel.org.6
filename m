Return-Path: <linux-kernel+bounces-379562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E7A9AE07B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2192CB228E9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197BE1B21AB;
	Thu, 24 Oct 2024 09:21:46 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F3F1ADFE6;
	Thu, 24 Oct 2024 09:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761705; cv=none; b=ARLdfFj97ErTYClKrFVa4IWmKWNdbnKLneEF/WhDOeO/AJRfeUUaZKXUaw1z/GN5XnqjsOzPVXg2TZrjPRO8SSKFtteqn6ZBpqL+wXKwsKFls5/JwHJDeiKYxaRgVVgPV5aNd4R43DHpxBY3WBSIqN0VmACwbksXHhVJsn2kXRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761705; c=relaxed/simple;
	bh=99Yrc0L17TG3fMxums1Dkq+SnVpEoYsxEGXOnf+fuGU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sw3DMcXRepMK4DtnY3BUAD6EYu2po90WoS3Qq+dAugxJkHvo8iY4URGCwqbdYqVWMRx8fza50qkgKunCe07nNkNsOd/IHyc7FEx5Sge7OFeE6DeOujuLhuMu+/IGMsptDHE3TDnZrgdlg3JyQaKoF23aCjvKE5v4lZzjJBitLa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6734C4CEC7;
	Thu, 24 Oct 2024 09:21:43 +0000 (UTC)
Date: Thu, 24 Oct 2024 05:21:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Michael Ellerman
 <mpe@ellerman.id.au>, Christoph Hellwig <hch@infradead.org>, Kees Cook
 <kees@kernel.org>, Sasha Levin <sashal@kernel.org>,
 torvalds@linux-foundation.org, ksummit@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <20241024052139.2cf7397f@rorschach.local.home>
In-Reply-To: <CAMuHMdVLsLA97u4AVTA6=YKyfyWNrJOQk7S02s36AFTrFoUM3A@mail.gmail.com>
References: <ZxZ8MStt4e8JXeJb@sashalap>
	<792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
	<ZxdKwtTd7LvpieLK@infradead.org>
	<20241022041243.7f2e53ad@rorschach.local.home>
	<ZxiN3aINYI4u8pRx@infradead.org>
	<20241023042004.405056f5@rorschach.local.home>
	<CAMuHMdUxrULbo=A77DFDE4ySbii3jSMuh8xVvUXaqyCnwEAU-w@mail.gmail.com>
	<20241023051914.7f8cf758@rorschach.local.home>
	<8734km2lt7.fsf@mail.lhotse>
	<20241024010103.238ef40b@rorschach.local.home>
	<07422710-19b2-412b-b8d5-7ec51b708693@roeck-us.net>
	<20241024024928.6fb9d892@rorschach.local.home>
	<CAMuHMdVLsLA97u4AVTA6=YKyfyWNrJOQk7S02s36AFTrFoUM3A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Oct 2024 09:01:15 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:


> On Thu, Oct 24, 2024 at 5:59=E2=80=AFAM Michael Ellerman <mpe@ellerman.id=
.au> wrote:
> > Several thousand build tests, across pretty much every architecture.
> >
> > And a few hundred boot tests, lots virtualised, but some on real HW.
> >
> > A single character typo in an #ifdef your testing doesn't cover can
> > break the build for lots of people ... =20
>=20
> Or a missing "static" for a dummy function.
> Or a plain 64-bit division.
> Or ...

Note, my fixes code seldom adds dummy functions. I like to try to keep
them as small as possible. That's not always the case, so maybe I could
push it. But it will change my workflow quite a bit or burden Stephen
with broken branches.

I'm still not convinced it's worth it.

We are not talking about new development code. We are talking about bug
fixes for code that is in Linus's tree. The zero day bot and my tests
appear to find most issues. Bugs that happened on my fixes patches are
usually other use cases. For instance, cpu hotplug while tracing from
rtla. That's not coverage I get from linux-next.

-- Steve

