Return-Path: <linux-kernel+bounces-520921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0463BA3B133
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 07:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AAE218973AB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 06:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E041BC073;
	Wed, 19 Feb 2025 05:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIJHiHrg"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5623E1B87E3;
	Wed, 19 Feb 2025 05:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739944783; cv=none; b=rpg9TxXdXoVK/fsNKuzmEKkfaLDC/0Yh0ae1hjToXkYZhLGeRd1vECUpxEP2TlsEWvXZ6p7+1FtuiJ3uRP8jH0vYr9fnH3OQvBtZM4aJV65pAwjo0ktfZAyXg2ijhpdO2cnFNg/EGTlkkcqpUzMIY55abkl9dLtBwehUNlRtOp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739944783; c=relaxed/simple;
	bh=uElxjeT4hItqlbW04BTLLQC+G+DPsa6uTID423EAftU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VG8cRU5Ir7UObXsPpgPK/438hxEU/2BNvbd+fjChxQm3RGCec7Ct5BIQrq2GNOa9dKxTU+6TfVgrqOnH7usEq/g9DNK4OuA1pAvz4iW4duYWekyZ1YYoqiYJPr5G5qcJ2d9xLgrl5TigyHPCAf4RPAea84of20lDQU8snMBCrMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIJHiHrg; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5deb956aa5eso8731734a12.2;
        Tue, 18 Feb 2025 21:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739944779; x=1740549579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uElxjeT4hItqlbW04BTLLQC+G+DPsa6uTID423EAftU=;
        b=QIJHiHrgn1yI13xFlezAeThSGtdEtXqx9X7Y2Y6oUSrWL4pyykU3cyjD/BMXGO1wmZ
         5QkM2hxNwx40fZ3vABHiOJ051b7JRHiKwoBR6wnOzTMJIgvWBD6WYoSUkorlvUzlXvE5
         ae6f0giIM3dWATVm6WhWr7FlCPE7g11nDBQj8WWusXtLdobNV6BKcyYD/vxiJXXRer02
         JfTKYFpUGXClQHxohrm2IOUYghUE3UbFQ6RIdVoBkvdkOb1GEfKuPncfCQbiQVl31kU7
         vmCKVZWL/avY4byW3ep77nxzuloa9Mu6htf4KPiWpS+6rakD1RNHprgIPJ5gpO5ruiaV
         XZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739944779; x=1740549579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uElxjeT4hItqlbW04BTLLQC+G+DPsa6uTID423EAftU=;
        b=IRSO612yTqfhsMRPcrVAoGWNek3W+sf+nTeLTPYJyDaTd8kCTHd0pSoCbN7QoHg/ij
         Bq6etp73gObX2NwftILP8HAyXN1QRT9VB8JKPugsx75TiTrfg4d9AuHcIDviSBk8+69S
         ZuSdlKmPNKdVFYdMpJJmOQzRWFTN9fec6HA+e+kkPdkSsfYFoIeD4ooVBodjhg1KIBKq
         ROvz9imxovDv5A3C5ny6kybpIxoBVZD3mMsYbohojz8293ET2/n6+xqclJ1PnyJwLmfF
         Fh0OEYWFcpvAR14+srS61HiSpzhPYBoJOlydS5F3Rk0t99OX0QViyXAErmltFkJ8Ot3r
         p9+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVdBEJ692Tu12kJLF9JUvdQwY3rR1RYk4cdiQqyg+Ny3SO7CVdRVG70Jy/2E4aPL2qgvBmjLYpO1K1HD+4=@vger.kernel.org, AJvYcCXd4yltqkP8Os9Uc/Zvy068/bSiPCRTTtYAOLMHHLkkqoHFk7NU0PQ2cu+yemzXwYQjp8UsHvzSW5/FitTHfQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5H18xA63Q2Pg+t4he6hgzWjrFL69XiCrOVtdC+uwql6LkCufd
	5ZCeT+fhArw6Jb1OFnAxII6qfqWz5IIeMQSZRL7oQfsiikHsfGu+4odHFAjUdlQFubesRVQmj9Y
	48q/E9UWc0c+3hU88MqtA9W01u+o=
X-Gm-Gg: ASbGnct1hQOM5m0tWxmsK2jTlL++yOugZiCwGwpNSU6NwFZ/ITwfCdr6DUwn4HGI9eF
	9yeifPTeGpWcIV+VDG89dswO+Eqjk6SMdgrimkKEkDoHBNG59ok2YGnSyNzc99Hb2qSZcCEE=
X-Google-Smtp-Source: AGHT+IHf4yNl/lSglIrOWZ7tmy7DCI/C6vKYCZbWJ9e/970OUdAdTYVDcnQGlKd463dGyvBmjNpnQe7qZ9a4VXeSxzo=
X-Received: by 2002:a05:6402:430f:b0:5df:b6e1:4690 with SMTP id
 4fb4d7f45d1cf-5e03602e5eemr45126801a12.12.1739944779488; Tue, 18 Feb 2025
 21:59:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org> <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <326CC09B-8565-4443-ACC5-045092260677@zytor.com> <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com>
In-Reply-To: <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com>
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 19 Feb 2025 15:59:27 +1000
X-Gm-Features: AWEUYZnB0Uf80ixJrp1q3PtuTwheEh6E-d43yX7BPT95rhn-uR-FN5lupp-eR5o
Message-ID: <CAPM=9twZYgp4skmHCcpRr4z8pne-3LN=J=Dan-sEAwJEpttXSA@mail.gmail.com>
Subject: Re: Rust kernel policy
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Feb 2025 at 11:00, H. Peter Anvin <hpa@zytor.com> wrote:
>
> On 2/18/25 14:54, Miguel Ojeda wrote:
> > On Tue, Feb 18, 2025 at 10:49=E2=80=AFPM H. Peter Anvin <hpa@zytor.com>=
 wrote:
> >>
> >> I have a few issues with Rust in the kernel:
> >>
> >> 1. It seems to be held to a *completely* different and much lower stan=
dard than the C code as far as stability. For C code we typically require t=
hat it can compile with a 10-year-old version of gcc, but from what I have =
seen there have been cases where Rust level code required not the latest bl=
eeding edge compiler, not even a release version.
> >
> > Our minimum version is 1.78.0, as you can check in the documentation.
> > That is a very much released version of Rust, last May. This Thursday
> > Rust 1.85.0 will be released.
> >
> > You can already build the kernel with the toolchains provided by some
> > distributions, too.
> >
>
> So at this point Rust-only kernel code (other than experimental/staging)
> should be deferred to 2034 -- or later if the distributions not included
> in the "same" are considered important -- if Rust is being held to the
> same standard as C.

Rust is currently planned for non-core kernel things first, binder,
drivers, maybe a filesystem,
There will be production kernel drivers for new hardware shipping in
the next few years, not 2034 that will require rust to work.

Now if you are talking about core kernel code I don't believe anyone
has suggested any core piece of the kernel to be written in rust yet,
when someone does that we can make more informed decisions on how to
move forward with that code at that time, but otherwise this is just a
theoretical badly made argument.

Dave.

