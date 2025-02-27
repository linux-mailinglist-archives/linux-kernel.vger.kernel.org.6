Return-Path: <linux-kernel+bounces-535904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C56EA478C4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97D9B1885AD7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C5E227BA7;
	Thu, 27 Feb 2025 09:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SXDUfcSD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gyv5+yDJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B037F15DBB3;
	Thu, 27 Feb 2025 09:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740647545; cv=none; b=jZzcINAjQWQ9Gxdp96GIZojqkGdGEmJWIhlLzYwOxbLibNDM1uwGVLFHTpCZh4lBRFWuKgSc8Y0zddrLO2JiGVXMIp7ELiU9OdCcb91yRu487raFJ+IUwFB1vSCBDhwPb5FpV0CZqjdXsBvprHYsxFxePYu++L1e7/ZfJa9J7t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740647545; c=relaxed/simple;
	bh=im/KhgIT27JTLye0HNWO6s3AMwTgWu8CWXVg8AdZNy4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ECFPdxxyiqfRfabtABKSKb7JC+Oinm6pZp6JEcUY5PMXWjO5/wwZiQsiPRKG4BcWHIUr1Ho6wYt7Wc+j+ts1upagvNKdABqLy9teJbJTn4g047q4dG69zORczfcIHIQ0jjXu0mh7gFnUZzHQDtfsHVEUq91EWlkBC4vj4VqrjVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SXDUfcSD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gyv5+yDJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740647541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M6HL09mD6gtvtxUDNjs16icQacl6NdLheRr+sY4qWYg=;
	b=SXDUfcSDJidBiDUoeawE5SkUufrC0pI/dyykfkJhgec3bEbq996Z8qiicgfSqHQyPNzWWQ
	q/advMSQqnKnKLnSJPe8t5SQQxb/AdO8Mu6a8KFIciREciD6+2bvXMexi4H3ikEFBFHQEj
	wxczT8B+dzyKwKUhss9uIybPrg+Vhj3KUt5lDHRZLL2MLPyGjijHjBk9hgoz1ovtlw3jeq
	NItCH9GBGNBSrwJkfTb7o9NTxIvJXAF9thQtanKTqMULE9+V/vIhZeNJEiBIvLKS4YSOSu
	iT0o2CI8AdmykHa6P11LeZtOtmykBKTRdwEMikAxKZFckOzvHHCILooz/zVSgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740647541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M6HL09mD6gtvtxUDNjs16icQacl6NdLheRr+sY4qWYg=;
	b=Gyv5+yDJ1s6M+alf1UVqMrV9JFV/VJ2b689jop0z5eg7KHR6Aoj8LOsWF6enD+9CKwtped
	P8o5d2h7Oy2SKWCg==
To: Frederic Weisbecker <frederic@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda
 <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Danilo
 Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui
 <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida
 <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 13/13] rust: hrtimer: add maintainer entry
In-Reply-To: <Z78-mVAHdSq1zbJr@localhost.localdomain>
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
 <20250224-hrtimer-v3-v6-12-rc2-v9-13-5bd3bf0ce6cc@kernel.org>
 <Z7yT5XU5gAm0ZCZD@Mac.home> <Z78-mVAHdSq1zbJr@localhost.localdomain>
Date: Thu, 27 Feb 2025 10:12:21 +0100
Message-ID: <87h64feop6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26 2025 at 17:17, Frederic Weisbecker wrote:
> Le Mon, Feb 24, 2025 at 07:44:37AM -0800, Boqun Feng a =C3=A9crit :
>> On Mon, Feb 24, 2025 at 01:03:47PM +0100, Andreas Hindborg wrote:
>> > Add Andreas Hindborg as maintainer for Rust `hrtimer` abstractions. Al=
so
>> > add Boqun Feng as reviewer.
>> >=20
>> > Acked-by: Boqun Feng <boqun.feng@gmail.com>
>> > Acked-by: Frederic Weisbecker <frederic@kernel.org>
>>=20
>> Frederic, since you've reviewed the series, and we certainly need your
>> expertise here, do you want to be an reviewer in this maintainer entry
>> (to watch how we are doing maybe ;-))?
>
> Yes indeed! Please include me as a reviewer!

Please add Anna-Maria and myself to the reviewers list well.

Thanks,

        tglx

