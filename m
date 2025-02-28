Return-Path: <linux-kernel+bounces-539132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA62A4A15B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B723B14E7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47E926E62D;
	Fri, 28 Feb 2025 18:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="FTHA1HOM"
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C148127002E
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740766995; cv=none; b=hbrxeOrCVq3XoDwJ6OT/OWY33fil0rzPywQW+TGmKRMgyQWWXQZ0MHAwaKOQ580hkyln/R0TGBOuJ4nwCfL/R4JSdblyzXAOdI+52cO9oF2Cr7Dylpl21OJU2i/PZQ7my/FkB3pHdgiJudDgbbjshPoTiWMF9kb298oFoILnPRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740766995; c=relaxed/simple;
	bh=/CnRoMB+LCczUBFwmSaxEVVcowjVHB085OtbP4ezScY=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZUTkORYoz1P19YuWv+m+7aBLf/lRJx9spRA7Pl0jj9mUvVLLtsOcJYHR06VRBxboUtgu2oplKdYVCwovYJfyp7cv7OQppLcNB3IX2J8CwUe3iuIJgtlA7/aLdFCDz/qGTRWaZjlSRefl21vvLKnNmFe0w7N3LTDq1zJ5DSFnbQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=FTHA1HOM; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1740766986; x=1741026186;
	bh=/CnRoMB+LCczUBFwmSaxEVVcowjVHB085OtbP4ezScY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=FTHA1HOMuJE6zbJMEOKmeGLBlID7QowdmkxD3WLt2ALpIlr7qfxv7KQbhBMCxomQb
	 dVkpAThO9XZsVE/v9NDf1kpK0p7W2L6v4rXnB3r6lCWu2NpDqUTDe+LIxI9aker/DH
	 n1Y5gDumJTj6pQ8BLHq7N7KRumahmfipAy0CAsHKBdRqqP6qoww7Sl77U9QBb+7wAj
	 gmLrjLYTQ1qn00j86Ffa+zIIxxkbw5COS/nel8AbvVrAdQHJXw2JVvhKFgIJQt2Eux
	 U+N8/mhxghcqofE2VzZQO8KdfcAa9uRYjJKndohUPai+8LMpwxBiff4ij5AEt+dA6+
	 XN5dcFTq7XPbQ==
Date: Fri, 28 Feb 2025 18:22:58 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2] rust: adding UniqueRefCounted and UniqueRef types
Message-ID: <I2EuahEO9YG75qdfIlsanLJ9iOfr0OlKJr6nw_cqOG0rVrZUEZGhdfENkLawNCpSqP8uSGMODCeEmsYv6clgYg==@protonmail.internalid>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 87b5d704ecb0e36a3d8ee0c6a58af99f9c9cee7f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 250228 1009, Boqun Feng wrote:
>=20
> Please add the "# Examples" section as I requested:
>=20
> =09https://lore.kernel.org/rust-for-linux/Z8HcHVtPiG-X6ujP@Mac.home/
>=20
> I also would like to know why do you think it's OK to ignore my previous
> comment, thanks!
>=20

I intend to. Don't worry. I totally have it in mind that, this is missing.
As said, I will do it in a couple of days. Sorry if the update
caused confusion.

I am aware this won't be the final version, but I thought
I still post this one correctly formatted, as Miguel requested.

I assure you, I'm not ignoring your comment and request at all.

Oliver


