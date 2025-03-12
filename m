Return-Path: <linux-kernel+bounces-557457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F831A5D925
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CEBA18954DB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 09:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A088123A98E;
	Wed, 12 Mar 2025 09:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Wxk06aPJ"
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CB023A571
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 09:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741771182; cv=none; b=qmbX5GggGIxojMghOSuUje3Xq0Y2M6sGYY/2+R8OMTXAIuiBjIkSW6OF1vRXDtZBLoPTZJ3yfAcNYV53eoeMmtdiN9Hi2wjlVDGByZxEFX+V5T0rE7JDyN7z6GNg7BHPZYDEkSc5B90AHHn8SYjUVhLtvarAbQgJtoIwdsRstGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741771182; c=relaxed/simple;
	bh=oBwEQFoOy8pOpeJ66KbTKgHr7VFOe1vin9j72U5w3HM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pXffhm4AfdSR16zmBkZAE/lwzAXu85Ivjjy4yrbridPbr3x8xi5Vz+OCNhT4l135wQ1YIp+Sq/CDNrF5gUmgDEIpZdo8Y0IFaa2f3IhtDKu2LcXBxgayVpt3LryP/v2Wloz/jFHbNBpmBkqku/T+Jfu1VJYt1T+WYYET8eXhi7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Wxk06aPJ; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1741771172; x=1742030372;
	bh=oBwEQFoOy8pOpeJ66KbTKgHr7VFOe1vin9j72U5w3HM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Wxk06aPJC5cwC/KqcFNSguUqEo1fWtKJ28lendn5eccilWaeg/Z4ZFbky3AL4vP8B
	 xY+FoAImNxGgee7UqLSJ9/eYNdZZUqome5i5Z3Qw4bYQASAhCYacWofWhux+QiOEzH
	 9BY8taYAdnzr+6fofg/e2DcNn0t8wHnWAWf6eZHnMziMpESPoDv+AcL6KA1ObLvsWl
	 MmXCtdpNnVlheXjlK4lo6MXVpANkRMw7MJAMBsDp6q9o+/iiCEG2xtp3sm7s+tIWrv
	 ynWn2mCSEt3tAyHcQH1eDHBUD9g1tN+ByG8+8jsnJg3zFHpVDQex3syVrHX78Ag7mk
	 9oikuojQnQ1gg==
Date: Wed, 12 Mar 2025 09:19:27 +0000
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/4] New trait OwnableRefCounted for ARef<->Owned conversion.
Message-ID: <Z9FRm8qkLRbdXq1F@mango>
In-Reply-To: <CANiq72mR66wn5T7WYCzyyan5dEQDQAyBvtzC381jfWgC6R8K9Q@mail.gmail.com>
References: <20250310-unique-ref-v7-0-4caddb78aa05@pm.me> <CANiq72mR66wn5T7WYCzyyan5dEQDQAyBvtzC381jfWgC6R8K9Q@mail.gmail.com>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: e8545f65ffc08a44b4e27e3f3091440b49be41b5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 250310 1642, Miguel Ojeda wrote:
> On Mon, Mar 10, 2025 at 11:57=E2=80=AFAM Oliver Mangold <oliver.mangold@p=
m.me> wrote:
> >
> > - Squash patch to make Owned::from_raw/into_raw public into parent
>=20
> In this case, given the changes are minimal (and assuming you didn't
> discuss it with Lina), I would have personally used the [ ] notation
> to explain the change from the original patch, and that's it, rather
> than a Co-developed-by tag -- but do not worry about it :)

Sure, I would agree. I was mostly wondering about how the format for that
looks. You say [ ] notation. Could you maybe give an example for that?

> Also, in general, please wait at least a couple of days or ideally a
> week between versions (unless it is urgent etc.). Otherwise, it can
> get confusing for reviewers and so on.

Ok, sorry. New to this, you know.

Best regards,

Oliver


