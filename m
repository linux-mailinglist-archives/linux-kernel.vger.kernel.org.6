Return-Path: <linux-kernel+bounces-546958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC3BA5012F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0D23ABFBA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981AD24A057;
	Wed,  5 Mar 2025 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="CYYBkqM7"
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A3E230BC6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741183145; cv=none; b=ZAetsFpfWDwlJ5Wgf5Fog2iOjOhnYEIP7LhMY21MRieR2eHGqMRK0pJz2CE6SbrfBWC8oys5p48umNBuL6zIDa7SVxyTtgWxKdSqg6zEVfSOjlCeOvy92FpGcyRJXz35JLgzrgAVw4TWKjyNuLgtpkGss8v2wgYF5M4eeYj1vZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741183145; c=relaxed/simple;
	bh=oyXJ/FF9pCzdYnhyE2IfOhy8VspgwA0dC/fOH3+HNfc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ICL1f7GrisI1v++3GSMnDH1QRy8M7bSyko7qsJlv+atXe/XeEPUnx23zfGaNAXDXJW6goeu4NWOcWFLF7Tx/qHB9FsJV72OXGT0bdqV7SJuefd7prUhqJVGo8pj2X26VQoUQZYkYIRGOovcxrkn3SDn2HSRY2IKQWo61SS07D7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=CYYBkqM7; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741183141; x=1741442341;
	bh=oyXJ/FF9pCzdYnhyE2IfOhy8VspgwA0dC/fOH3+HNfc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=CYYBkqM7hDMIoVe7IJIj6hkVhKB5Z9OxNE5HXvD0MEU9sT+ggSsLnHOfBu8m9+2c8
	 Hq0dC71N5v+lcoEZq5oALSylUopeyA5Bx07OmugyIAygVgbL85WU67vBt5Xljzy+Ov
	 dSI+XRGkwmwds6OS03Yi0HyhONE0hp5eMDetEjCP0JdmKOrOtAtaQrhMVflxSXg+Lq
	 1IVlktLmRjorHr4UnTIVASskeqvpHl5JmkDF7hTjL9gHpESQWElXHZmijA9IYsrFtH
	 OUYk7Lopzku9kymCpR/jjB5AtyBgqeOQm9SVlYEvPuvRxiVngK7hYPv/LgWvhOfhWH
	 5IkkWRuDti61w==
Date: Wed, 05 Mar 2025 13:58:55 +0000
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 20/22] rust: pin-init: add miscellaneous files from the user-space version
Message-ID: <D88DWNRRTPCE.27O3I3FGEXNSB@proton.me>
In-Reply-To: <CANiq72=RjmVqvpd-n2uF44UNVvkdkvrKqUJDAbZq8MYjNvXkAQ@mail.gmail.com>
References: <20250304225245.2033120-1-benno.lossin@proton.me> <5Q1xnRAO-CFSBw_RfcJwj_wKB2rd2Qcc2qFiWmrWjueSmkBd3T-BuqlHSyrMrGIu2loBNIJUTRmvwBk2hfoneA==@protonmail.internalid> <20250304225245.2033120-21-benno.lossin@proton.me> <87y0xjaat7.fsf@kernel.org> <CANiq72=RjmVqvpd-n2uF44UNVvkdkvrKqUJDAbZq8MYjNvXkAQ@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: f989164ccd17e1c1224db328b640b3b5f829f318
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 5, 2025 at 2:37 PM CET, Miguel Ojeda wrote:
> On Wed, Mar 5, 2025 at 2:08=E2=80=AFPM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>>
>> But really, if you are already going to sync changes with automated
>> tools, it should be simple enough to have a list of file that are
>> excluded from user space to kernel syncs.
>
> As far as I understand, Benno already excludes some files -- so extra
> files could also be excluded easily.
>
> Not sure about these though, e.g. they could help someone realize they
> need to contribute/develop it elsewhere. On the other hand, we could
> have a custom one in the kernel instead, explaining just that.

CONTRIBUTING.md is also referenced by the MAINTAINERS entry in the `P:`
field. For README.md, I don't mind removing it, as that still keeps the
rules of which files should be synchronized simple (see the other
thread). But I agree with Miguel that it is beneficial to keep in order
to show that it is a vendored library.

---
Cheers,
Benno


