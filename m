Return-Path: <linux-kernel+bounces-213993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7A2907D70
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 22:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDD111C2474F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 20:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9888013B294;
	Thu, 13 Jun 2024 20:25:57 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81F05A7A0;
	Thu, 13 Jun 2024 20:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718310357; cv=none; b=bdCF+feRr7KSj1u2X7jxlTwvf++odHNFun4hX2KXcinNdQGwQmolyFdhrMbfv5qzS2Bchj4EOUAOCoegud1EZOp80hxYa/RZwMdobQTfP3CS+zNQ1wSuARZeVyuWltTzv+KD4LKjCDP58eK/8tD8dNj75ItYlYQRepVz1SynmFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718310357; c=relaxed/simple;
	bh=ULWkbbB/Ba2zTcxEXHNh/JybJCOg3HoCv6YwNpHEtEQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=TPg3M90qs/+tQurFt+ugldENOiaj/WFeS1JdcnvsQYwPEiJnaymcguILc7TafP9gX7hTAiBmtaooMQ7qKMJnptGGEOVfYLUsBbw1JgQgKIxNpImyUE1WNcMWChHVlCCKRiF0WzbFVhU56RMUpT13IWC9TaXPCdIwpYUKorIFspQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 7CB1961966A0;
	Thu, 13 Jun 2024 22:25:45 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Wa49bRMWQqQj; Thu, 13 Jun 2024 22:25:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 1B1DA61966B5;
	Thu, 13 Jun 2024 22:25:45 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id u3JPqG5GZGqO; Thu, 13 Jun 2024 22:25:45 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id D6A5661966A0;
	Thu, 13 Jun 2024 22:25:44 +0200 (CEST)
Date: Thu, 13 Jun 2024 22:25:44 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: davidgow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	tglx <tglx@linutronix.de>, mingo <mingo@redhat.com>, 
	Miguel Ojeda <ojeda@kernel.org>, hpa <hpa@zytor.com>, 
	masahiroy <masahiroy@kernel.org>, 
	Jamie Cunliffe <Jamie.Cunliffe@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	kunit-dev <kunit-dev@googlegroups.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-um <linux-um@lists.infradead.org>, 
	Rust for Linux Kernel <rust-for-linux@vger.kernel.org>, 
	x86 <x86@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	bp <bp@alien8.de>, dave hansen <dave.hansen@linux.intel.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>
Message-ID: <965895223.231524.1718310344716.JavaMail.zimbra@nod.at>
In-Reply-To: <CANiq72mXWERtFSqQRtcgP28aLokwZmXaBiqcrn_zoASawjfdsQ@mail.gmail.com>
References: <20240529093336.4075206-1-davidgow@google.com> <CANiq72mXWERtFSqQRtcgP28aLokwZmXaBiqcrn_zoASawjfdsQ@mail.gmail.com>
Subject: Re: [PATCH] arch: um: rust: Use the generated target.json again
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: arch: um: rust: Use the generated target.json again
Thread-Index: sd4HK7HM+iXRR4lpujN6qFDOxf77yA==

----- Urspr=C3=BCngliche Mail -----
> Von: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
>> Fixes: f82811e22b48 ("rust: Refactor the build target to allow the use o=
f
>> builtin targets")
>> Signed-off-by: David Gow <davidgow@google.com>
>=20
> I guess this should go through UML, but please let me know otherwise

Yeah, that's the plan.

> Tested-by: Miguel Ojeda <ojeda@kernel.org>
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
>=20
> Should this have a
>=20
> Cc: stable@vger.kernel.org
>=20
> too?

Ok!

Thanks,
//richard

