Return-Path: <linux-kernel+bounces-520908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72899A3B0EC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 06:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63C4A1890CF3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 05:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60621B4F21;
	Wed, 19 Feb 2025 05:27:09 +0000 (UTC)
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA0F1B424F;
	Wed, 19 Feb 2025 05:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739942829; cv=none; b=XOs+JODTA49KI3kKbLsI3wbaxv8CFtHPhsZ5HoFbHAhZyjuIZy1LrdWxMKetGPyJ9Nfkcie4sb5B9KAJ5hjb2yKGagToWFlBK3K0EVZKQglbOHBIxuNhiB89ICzWLMQHJUGHGGExIx3cf7jSpw3GzA+vVarl6vNRLohlFmUGQio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739942829; c=relaxed/simple;
	bh=zOtklbXj1MZ6z0i6CsShg2jHvMNpAoDXL2gvDpNBTl4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=NeT8wRskj9oAolgB0tc+S5wpw9eYGTpTYLCSoQf9MHHENUbg4eQZd6QCyT5DlqQhzRmaFO2UIA3pAlg/G2bxOIHUx4z0worHle8XXy/E8g76nbxefG1JcmKUfmTxrZ0aiMI+GB7vKBVh1cy+fbzGY8bu6sjsshTPOItXRzgDvSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1tkcJL-00630d-UN;
	Wed, 19 Feb 2025 05:07:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Boqun Feng" <boqun.feng@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
 "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>,
 "Christoph Hellwig" <hch@infradead.org>,
 "rust-for-linux" <rust-for-linux@vger.kernel.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Greg KH" <gregkh@linuxfoundation.org>, "David Airlie" <airlied@gmail.com>,
 linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
In-reply-to: <Z7VKW3eul-kGaIT2@Mac.home>
References: <>, <Z7VKW3eul-kGaIT2@Mac.home>
Date: Wed, 19 Feb 2025 16:07:51 +1100
Message-id: <173994167131.3118120.16887445524155129088@noble.neil.brown.name>

On Wed, 19 Feb 2025, Boqun Feng wrote:
> On Tue, Feb 18, 2025 at 04:58:27PM -0800, H. Peter Anvin wrote:
> [...]
> > > > David Howells did a patch set in 2018 (I believe) to clean up the C c=
ode in the kernel so it could be compiled with either C or C++; the patchset =
wasn't particularly big and mostly mechanical in nature, something that would=
 be impossible with Rust. Even without moving away from the common subset of =
C and C++ we would immediately gain things like type safe linkage.
> > >=20
> > > That is great, but that does not give you memory safety and everyone
> > > would still need to learn C++.
> >=20
> > The point is that C++ is a superset of C, and we would use a subset of C++
> > that is more "C+"-style. That is, most changes would occur in header file=
s,
> > especially early on. Since the kernel uses a *lot* of inlines and macros,
> > the improvements would still affect most of the *existing* kernel code,
> > something you simply can't do with Rust.
> >=20
>=20
> I don't think that's the point of introducing a new language, the
> problem we are trying to resolve is when writing a driver or some kernel
> component, due to the complexity, memory safety issues (and other
> issues) are likely to happen. So using a language providing type safety
> can help that. Replacing inlines and macros with neat template tricks is
> not the point, at least from what I can tell, inlines and macros are not
> the main source of bugs (or are they any source of bugs in production?).
> Maybe you have an example?

Examples would be great, wouldn't they?
Certainly we introduce lots of bugs into the kernel, and then we fix a
few of them.  Would it be useful to describe these bugs from the
perspective of the type system with an assessment of how an improved
type system - such a rust provides - could have prevented that bug.

Anyone who fixes a bug is here-by encouraged to include a paragraph in
the commit message for the fix which describes how a stronger type
system would have caught it earlier.  We can then automatically harvest
them and perform some analysis.  Include the phrase "type system" in
your commit message to allow it to be found easily.

Thanks,
NeilBrown

