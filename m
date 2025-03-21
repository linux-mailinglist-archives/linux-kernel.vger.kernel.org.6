Return-Path: <linux-kernel+bounces-570970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4ACA6B729
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 598717A5EA8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB4A1EFFB7;
	Fri, 21 Mar 2025 09:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Ehdgzc9d"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31776374EA
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 09:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742549040; cv=none; b=Pxpzw6N2+1P/RyFTYXcZ/nLN2PmbjTr5zaWODaMaHXZXTldc/U8zG8kt1PKioDogQzcvI+B6UIRatTwWkDt5AU+b8tJ+rQEsFvFgy0VZkMp7OX84RcVhJU7psoLPhdGDYEdnhYfqvl8t74Ry7EEz3XaOXfelSqj1Yv3aDaouG3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742549040; c=relaxed/simple;
	bh=h1jw/a/az+IQZ3iNVBmt94kRXQ4qbh4zs55yXqznB14=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tpKPdktahhFt96DzX5dxJibaJD363BXliAC8R4u5Qoiap8TPYfDYaYJIfYUcop2/c/3HRIVKc9Ex5G8bLqD9oeE2oBMjTuKJlCAv6N5d6B2r4MfFNZr8eHyGJiTdrFWX1RveA8tVa8EqaU+JOFBTfW9Qa/iMKZiuGy6Gym9+azc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Ehdgzc9d; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742549036; x=1742808236;
	bh=tAlTidaL9ZFX/5CreHBohcgLbQEVfvTPKzW8H/kKXzY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Ehdgzc9dXWfdvFOTHWGz1GJoEJ6lOXuYgmQCCS6pzMhS43QpkS94HVB0cjWfcH1Ov
	 pg/wiLnW67t+kB9HrjJK4DM1KXz10LJKS/EO6t+VbAna1030qleUi69VfJAcrk0Oy1
	 RGq3vmvjViu/mX5bwlXMSR8cGjiV/W9OtDfKMIsBEs33fSfTyHrnqk51WJPIpwULWw
	 lfseV3eitLfnRTYgccgWSETXuCW4dhwhNUwpRPDR1+q7l4BKK8DpDHCGTVKZXpdGk5
	 6ZxykmJUtm0PjRubrGvb8v6HJ1N7g17IOE7uInsLYJO17NZacFIEEogi6ivuR8aaOJ
	 2XOmmAfX6U5Vg==
Date: Fri, 21 Mar 2025 09:23:51 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] rust: alloc: add Vec::pop
Message-ID: <D8LU2SGJ1T4U.1JPJWNV09A5UT@proton.me>
In-Reply-To: <Z90YyLPhil2vBTc_@google.com>
References: <D8LFRQ5IX33R.35U012LFZ06W0@proton.me> <Z90YyLPhil2vBTc_@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: becb8d096c475d5cd085bca86a8335a4a15aaeb3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 21, 2025 at 8:44 AM CET, Alice Ryhl wrote:
> On Thu, Mar 20, 2025 at 10:11:09PM +0000, Benno Lossin wrote:
>> On Thu Mar 20, 2025 at 2:52 PM CET, Alice Ryhl wrote:
>> > +
>> > +        // INVARIANT: If the first `len` elements are valid, then the=
 first `len-1` elements are
>>=20
>> Please add spaces around `-`.
>
> I can do that, but does it really read better?

That's how rustfmt would format it and I do think it improves
readability for me.

>> > +        // valid.
>> > +        self.len =3D len_sub_1;
>> > +
>> > +        // INVARIANT: This invalidates a value in this vector's alloc=
ation, but the Vec invariants
>> > +        // do not require it to be valid because `self.len <=3D len_s=
ub_1`.
>>=20
>> I don't think this should be an `INVARIANT` comment. Maybe we don't even
>> need it.
>
> I can drop the INVARIANT: prefix.

Sounds good.

---
Cheers,
Benno


