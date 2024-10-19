Return-Path: <linux-kernel+bounces-372689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1574C9A4BE5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 09:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C878D2836E9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 07:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C87E1DD0DE;
	Sat, 19 Oct 2024 07:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wiredspace.de header.i=@wiredspace.de header.b="0jsJRIhA"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE8C13C8E2
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 07:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729323935; cv=none; b=E4cw7TlSvdLtqswHvr+zQn9ma1lb2GlUj4u6E3QOt8GbZvIHGAayfF0cpuE3gww5jq2DF0hg3rwtSUHEgtcMNTITwuVppZla3X/xG+cyJRw6S/jbJUZ6sTv191mNGZkNLlpWp+GY/Wch4u+6F7FSUmEAhyrlSM0HGHybrDEnyBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729323935; c=relaxed/simple;
	bh=/XbF/+NCidevXD141bwG221fG8Yh9aYwrgm2ArnaMzY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=G3pbLmee2ehhIDQf/NhM4Ds+latRFGNCJOIqr1YWszwN7e0S4FqcHsJsQC63aEHur4NcfruGvNZ8VR01DqZj3FpFsbsCBT+mUwOMeFy8uS1vBCDWxo8S6cppAZdjYCieLtXMGAwoKrNyHeZI4NbfwPbLgDm6b4WbD4CpmrCjqAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiredspace.de; spf=pass smtp.mailfrom=wiredspace.de; dkim=pass (1024-bit key) header.d=wiredspace.de header.i=@wiredspace.de header.b=0jsJRIhA; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiredspace.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiredspace.de
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiredspace.de;
	s=key1; t=1729323926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jSq9GVLt33+jDNVvC/+rsp4P18o8up9zIaShzUja2qs=;
	b=0jsJRIhAzV1ql6BxLFLvaM9IqtbrWF3vNA9BZT2osQ/shuSsz/CGbwyp5QniC878ccgPjC
	cOK7w1i1v2Q3de6G9LVShaGshvciCU3PNH1rIfo0JBtE8u5wiFPcDh/kxiZVM5BZqPbyje
	7Y9Ey9r4wB58B3EIbMmFAd93X0nxa1c=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 19 Oct 2024 09:45:22 +0200
Message-Id: <D4ZM62F6HHAQ.3TLFSGQ3IU0DG@wiredspace.de>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Jocelyn Falempe" <jfalempe@redhat.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <benno.lossin@proton.me>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <rust-for-linux@vger.kernel.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] drm/panic: avoid reimplementing Iterator::find
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: =?utf-8?q?Thomas_B=C3=B6hler?= <witcher@wiredspace.de>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
References: <20241012075312.16342-1-witcher@wiredspace.de>
 <CANiq72kG0Ai2DHfERD0aPDVuEpLYrZ_2uYdw17=eeHRp+2Q1Rg@mail.gmail.com>
In-Reply-To: <CANiq72kG0Ai2DHfERD0aPDVuEpLYrZ_2uYdw17=eeHRp+2Q1Rg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat Oct 12, 2024 at 1:04 PM CEST, Miguel Ojeda wrote:
> Hi Thomas,

Hi Miguel,

>
> On Sat, Oct 12, 2024 at 9:53=E2=80=AFAM Thomas B=C3=B6hler <witcher@wired=
space.de> wrote:
> >
> > implementing the same logic itself.
> > Clippy complains about this in the `manual_find` lint:
>
> Typically commit messages use newlines between paragraphs.

I wanted to logically group these sentences together, but can also use
paragraphs of course.

> > Reported-by: Miguel Ojeda <ojeda@kernel.org>
> > Closes: https://github.com/Rust-for-Linux/linux/issues/1123
>
> Since each of these commits fixes part of the issue, I think these are
> meant to be `Link:`s instead of `Closes:`s according to the docs:
>
>     https://docs.kernel.org/process/submitting-patches.html#using-reporte=
d-by-tested-by-reviewed-by-suggested-by-and-fixes
>
> In addition, these should probably have a `Fixes:` tag too -- I should
> have mentioned that in the issue, sorry.

Good point, I didn't realise this when I read the documentation. I'll
change/add the trailer as suggested.

> Finally, as a suggestion for the future: for a series like this, it
> may make sense to have a small/quick cover letter saying something as
> simple as: "Clippy reports some issues in ... -- this series cleans
> them up.". Having a cover letter also allows you to give a title to
> the series.

Makes sense, v2 will have a cover letter :)

> Thanks again!

Thank you for the nits, they're exactly what I've been looking forward
to!

I'll prepare a v2 within the coming days as I'm currently limited on
free time, so thank you in advance for the patience.

> Cheers,
> Miguel

Kind regards,

--=20
Thomas B=C3=B6hler
https://wiredspace.de

