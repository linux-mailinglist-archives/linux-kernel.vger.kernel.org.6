Return-Path: <linux-kernel+bounces-574479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65733A6E5D7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA5E6171B12
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CE01A23B1;
	Mon, 24 Mar 2025 21:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="j3HaoXx7"
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD091DB128;
	Mon, 24 Mar 2025 21:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742852407; cv=none; b=s3EeaKJHJbAbeR67wxinMitXR190OdYrhLr9qu0rKECNEt7rmrnyAg/3QXWqa309z52Muwjj+TI4hxljUBokCp5ivFN7zZiASMOK1egHbU5f40pvNSr1bIvn2VQtPNRB8AQHbhHwyNXqiMkQT9FGnYYX2NAdWFowC+otpluPyXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742852407; c=relaxed/simple;
	bh=Ff9vxzQFsYYmBP7mNUmZ7VaYGCldUsK729tH4hqpcYM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=csgoAGr1YLbqloTHInrCDXcEDRbbucdPkTuhQdExexGWDHdz14qNLyY0/PbgIiLiWlszCUvUkKnAxg4sx2mDwq6rendcOQjCkYwi94rchPe3RCcUv3R2Jvt6nIij4Y63DbC4a7nSDY6aPgCqXGl1uGpKJAnQVYYPMyareAe3HiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=j3HaoXx7; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742852402; x=1743111602;
	bh=Ff9vxzQFsYYmBP7mNUmZ7VaYGCldUsK729tH4hqpcYM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=j3HaoXx7jRjDWDhMQy0JlOXly+RPP8IaiVGOwMS1F3JvPWlPAeVkyFdJeOmECHQXW
	 olGM5gTx20Bltw7BQqTtxi3Q12QOLoSCd7WliKRAb+XoAvE5LkGXk4wIZ0whsfXH7L
	 pHsDnVNCmS4RTSJkmd/m+9EJVaMfOvsdbiDKKA//CILir1KiTRc5FkEqIQCFQTJ84o
	 U5CEFhZlDLbifQD0yml59rmwK53JIo640qtorg7oBDpEsj4U7o1RKjwXIjOIX6zBX9
	 tKaEvZwWcdcgdnQgR2i/wl0QcSLDr2w4ecPlhM4ba2QJ++RnbH/fH6MEa85Iff+IJi
	 4/SPpDZrK4urw==
Date: Mon, 24 Mar 2025 21:39:56 +0000
To: Tamir Duberstein <tamird@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 0/6] rust: reduce pointer casts, enable related lints
Message-ID: <D8OTLYD0HE5G.NJBV7DIDWHAM@proton.me>
In-Reply-To: <CAJ-ks9=sGRYAEs4eBCqwHPTvfL6Fa4_3fcrXCohHp6PsJsM1Fw@mail.gmail.com>
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com> <D8ORTXSUTKGL.1KOJAGBM8F8TN@proton.me> <CAJ-ks9n-z0SETz+zBfJmda6Q_vJDeM2jmDXx48xX9qpMmR-mdQ@mail.gmail.com> <CAJ-ks9=sGRYAEs4eBCqwHPTvfL6Fa4_3fcrXCohHp6PsJsM1Fw@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 03eb1378f1412e8ddf65999c54a4e62369fca92a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Mar 24, 2025 at 10:16 PM CET, Tamir Duberstein wrote:
> On Mon, Mar 24, 2025 at 4:55=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
>> On Mon, Mar 24, 2025 at 4:16=E2=80=AFPM Benno Lossin <benno.lossin@proto=
n.me> wrote:
>> > On Mon Mar 17, 2025 at 3:23 PM CET, Tamir Duberstein wrote:
>> > > This started with a patch that enabled `clippy::ptr_as_ptr`. Benno
>> > > Lossin suggested I also look into `clippy::ptr_cast_constness` and I
>> > > discovered `clippy::as_ptr_cast_mut`. This series now enables all 3
>> > > lints. It also enables `clippy::as_underscore` which ensures other
>> > > pointer casts weren't missed. The first commit reduces the need for
>> > > pointer casts and is shared with another series[1].
>> > >
>> > > The final patch also enables pointer provenance lints and fixes
>> > > violations. See that commit message for details. The build system
>> > > portion of that commit is pretty messy but I couldn't find a better =
way
>> > > to convincingly ensure that these lints were applied globally.
>> > > Suggestions would be very welcome.
>> >
>> > I applied the patches to v6.14-rc7 and did a quick pass with
>
> So I rebased this on rust-next and fixed a few more instances (in
> addition to enabling the extra lint), but I realized that rust-next is
> still based on v6.14-rc5. I think we're going to have the same problem
> here as in the &raw series; either Miguel is going to have to apply
> fixups when picking these patches, or we have to split the fixes out
> from the lints and land it over several cycles. Thoughts?

One option is to pick the patches early in the cycle and then ask
authors of patches to rebase. We did that with the alloc changes in the
past.

---
Cheers,
Benno


