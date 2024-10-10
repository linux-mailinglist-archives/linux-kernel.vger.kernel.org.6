Return-Path: <linux-kernel+bounces-358648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5764C9981F2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17A3D2813BE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF44C1C3F15;
	Thu, 10 Oct 2024 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ngcqbccu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559CF1BB6BF;
	Thu, 10 Oct 2024 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551896; cv=none; b=j24ZuGAHzy4vCnVpVKBVydPNM23IuwWbDxAmdy2syl7+v7I6rw/ssEy5wLeTOq/dbxzSGlumDFZ+WwDIjn/ekd+wUevBZd6U+jK8ndrp86KZ/YxvsKmULTI+38fe9HFXk+PCeh2bb+gPrnnhgevMF8uCpMqPg/xD+c2JmO0Ujfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551896; c=relaxed/simple;
	bh=5ZjwbVLjUq1pNlrN8b3jaUaUWq5aTB16JltuEwDStC0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rfm1ZZBY0cJHJLCcJzVwfJi0qsRwFlcUBBGDQI9HV34ieufQAwnrgGD87+ypPnBq3w0QYMsZpH+3RDfutyA02fX6ySzKD5eyqxuwytlOXQ8tXNBAgNRMmQrlfb8CBLxWUDyEvl6n27l7xwa5lUv5bVwpi5W/QCdGYYF5Ju9u6I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ngcqbccu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0E7C4CEC5;
	Thu, 10 Oct 2024 09:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728551895;
	bh=5ZjwbVLjUq1pNlrN8b3jaUaUWq5aTB16JltuEwDStC0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ngcqbccu4VF+Tbj3zFjaLw68jB6Wg0V6Z2Ox2CO4Ap/TOo0z2rQh0ewbPYG1EyhZc
	 QBoXR0dM28hgm9sFBEFgCKWiUOOKjYXQh8huhdsTcD80/jCW+11nY64RTETT90vvg5
	 H7IJ32mKnyDGUIU0f5TRQ7MxrWbxVA3XSAz8TNWqU/PZl9d4XhQBSLTb3DYREiDCCI
	 RmqiVy4T7yDEFRcvIakZItaF9GvbE3n14tmhEqRl6sAV/A2UVU3YffHZgnJjICjlev
	 LB/UwK6Jnwsbrd8Sc0lbhOzt4NlkL5nGswXrOsxw2cwX6Szghw3c+/HAX738HPjxBB
	 jOjHYRYzKmr+A==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
Cc: "Dirk Behme" <dirk.behme@gmail.com>,  "Tamir Duberstein"
 <tamird@gmail.com>,  <rust-for-linux@vger.kernel.org>,  "Gary Guo"
 <gary@garyguo.net>,  "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,
  =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>,  "Benno Lossin"
 <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  "Dirk Behme" <dirk.behme@de.bosch.com>,
  "Filipe Xavier" <felipe_life@live.com>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: remove unnecessary #includes
In-Reply-To: <CANiq72nUT6cFXCGg4jfN07W7UE-8vma=o9a5DQjsRwtNsKUGbQ@mail.gmail.com>
 (Miguel
	Ojeda's message of "Wed, 09 Oct 2024 17:58:31 +0200")
References: <20241009151017.26685-1-tamird@gmail.com>
	<813594ff-b167-4ae2-8105-e2f958ec2cc7@gmail.com>
	<x--jOZgY2fckJNaP-jzH6zCfxC9J6fF5DtOPAtblrs_pGlzEdGu9udVqj0OgVfAbGNwE9zcgDSXrygRiKwAzjA==@protonmail.internalid>
	<CANiq72nUT6cFXCGg4jfN07W7UE-8vma=o9a5DQjsRwtNsKUGbQ@mail.gmail.com>
Date: Thu, 10 Oct 2024 11:10:43 +0200
Message-ID: <87o73smigc.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com> writes:

> On Wed, Oct 9, 2024 at 5:37=E2=80=AFPM Dirk Behme <dirk.behme@gmail.com> =
wrote:
>>
>> * Theoretically the grammer fix in exports.c could go into an
>> independent patch. But if not it at least should be mentioned in the
>> commit message. Let Miguel decide if he wants an extra patch or not ;)
>
> Indeed, in general, one should not have unstated/unrelated changes.
>
>> * Maybe a
>>
>> Fixes: e26fa546042a ("rust: kbuild: auto generate helper exports")
>>
>> tag could be added? Even though Miguel might route it through
>> rust-next as its not urgent for routing through rust-fixes.
>
> I think this is a cleanup, i.e. just unnecessary `#include`s being
> present, right? In other words, there is no "bug" apart from not being
> optimal (one could see cleanups as things that should have been done,
> but I guess we should draw the line somewhere).
>
> Andreas: was there a reason to keep those `#include`s, just in case?

I don't think so, it looks like they should have been removed with
Gary's patch that did the auto export.

BR Andreas


