Return-Path: <linux-kernel+bounces-539398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63533A4A3B8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9ECE882ACB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2422280A29;
	Fri, 28 Feb 2025 20:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="OzieTcRr"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F1427D776;
	Fri, 28 Feb 2025 20:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773278; cv=none; b=pYygTpoy9z3OezA9AC/39OCD+VhEhS46qYjEqzivThFFm5YfGQ3q7Q5MZsk9knis1DeQGcF2UjDTvbtxqEalHKOf6MWi5+3vYKOxwd8yPirku2VmqVyAmKoH9zU8Cw/Hx/7MCkLV9nYHQ8LCBn21RyqGa32gEg4Q++NFcMrfHKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773278; c=relaxed/simple;
	bh=cAGSg0+FGtnfhP4UTxMeuNYActGA0lN5jUz8YxrsUps=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K4AYPbhPUx0T53D2c8rzsKmnmUzs5LVIt9FFOqwJfvODDT+AWTYeCwkPKhoSkcOtwkRWO2gNzjWZ9K9BjvIjDYZ5fAusz3iiSNMt0KT2295pIXgYZutIugiKJAk+/+v2BjlhgCXqDITlGQt3hqLDRB4W10nmTf6LbfSYkjvfqI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=OzieTcRr; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1740773273; x=1741032473;
	bh=3Alp85hniUiFbuugvKlioTK0d7nrQtfhs3exKYbjYNA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=OzieTcRrrj/kbhJY9QTAYxWrP2erZEPkIkkZVOF9k7jqx3rD789p1xRpRCbjAMErJ
	 jvlphy4xrk/O9GW/xZTq0hJK/Z034N+I1hj5ESIhVbHrzItKt52a2U38YdDgNESov5
	 w7nwa/nbvJ93r7EYeiujeMjythH52KGtp96EuOgja9QCQ2oEv+tXuWaIJoInYthlem
	 ujeXz6AuERiaEPWLZS14fyI/IACy34nHYi0hTbCLyqxNOkEfsMiqzGEa8abjLIN7Lw
	 em3UTSyM3IiQ+W3vlKfMRziiPkMa7kNukJbnMC7fhZ4bdbGjMqlw/A+oS/I0Zmrsbo
	 2D79GZG4NusvQ==
Date: Fri, 28 Feb 2025 20:07:49 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2] rust: adding UniqueRefCounted and UniqueRef types
Message-ID: <Z8IXkL_fWD-LvjIB@laptop>
In-Reply-To: <87mse5lvlq.fsf@kernel.org>
References: <I2EuahEO9YG75qdfIlsanLJ9iOfr0OlKJr6nw_cqOG0rVrZUEZGhdfENkLawNCpSqP8uSGMODCeEmsYv6clgYg==@protonmail.internalid> <sOipp6LTmtfq5A37VN_kCA4Kw9zfclZ2HLIMSJYnOdG4ebnuTKUlXIlT4X3GVRLMXFmwT4IwyIA-eqF69yOhSQ==@protonmail.internalid> <Z8IBiBi6CSRxfxiE@boqun-archlinux> <87senxlwpo.fsf@kernel.org> <Z8IJPzlvioBZaV5M@boqun-archlinux> <IKv622yLvPB8cQqazDuceWqKbX5PKmf2VTjx5wG-nj0X16d3B-xJBwvbDR_bt5EzerCjmCY6aLZM4emv07saVw==@protonmail.internalid> <Z8ILlUMGQ221hLJY@laptop> <87mse5lvlq.fsf@kernel.org>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 873729ad03d58e20d613f2aac7c7ddecacf5fcfe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 250228 2025, Andreas Hindborg wrote:
>=20
> I am using protonmail-bridge for sending as well. I don't think the
> issue is in the bridge, it must be in the way you compose/reply in mutt.
> I am not a mutt user, so I don't know how that works.
>=20
I think I got it now. A rather subtle combination of issues:

- I have mutt configured to use the Drafts folder of Protonmail
  for postponed messages
- Protonmail drops the 'references' header when a mail gets stored
  in Drafts like this
- protonmail-bridge drops the 'in-reply-to' header when there is no
  'references' header

Thus when I postpone a mail and send it later, we see the current problem.

I just configured mutt to store drafts locally. So it should be okay
from now on.

Best,

Oliver


