Return-Path: <linux-kernel+bounces-531947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF58A44707
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 950127AFA46
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D999433CB;
	Tue, 25 Feb 2025 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VL7kdjDn"
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F83CA52;
	Tue, 25 Feb 2025 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501939; cv=none; b=lKMZTmOx3sIi4AVqNzCaK52u0q2tVJ9kVVM7GvLj5+YWIiAti8W026j3CvcSUgfpOrjoApubQm8y/dgh+/kILr4hgC8xHyOE7CY+osxVJDQggSRkUpGV+7zcBCZonSXIfKt7rZPVhUyRypUufRtImPY9yRt5vcRa2vXKtqLQZ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501939; c=relaxed/simple;
	bh=hwF6kbqLpp3QELXgKHrPeWegET4R6Y1jIN6cmKBZeuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JqmzBn7YFv8AjQPofCaMMtbwpnanpKHPZzBvse1/RUEup/AGAXsR7H7kpCxafB1SqVcW1Mtsn1UpyM9Z+hmTMt+V3EAKPyjul3n1Ii5IohYKptexiYYJVBnz0ImMJemXc0rHzupIl+xoEPf0Er9YvApyMCbfGXXAQS6K+XkEfE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VL7kdjDn; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-5439a6179a7so6499492e87.1;
        Tue, 25 Feb 2025 08:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740501935; x=1741106735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7AjPiUKufcUCuCRwM7KdiACvN7KG8NT17WOPwc4KLM=;
        b=VL7kdjDnO70OCZFfE7bP5JJQcHL2w7TDIBLW/0Fc1FqPNcnG9esHISp7flhHWCtEhz
         zDy1bHsfPi81Rr8NMiUcNIO/BqmtDsyFEfVR76gCWa7PdZ9NMsRqlpGKsW7vMO3x1b/J
         tBkmWCFLCKqxKsl/UepacoNVCDcWavXnvtOqQygQmFzw2s3T9BzVm5m/V7rSsmsWHJk5
         FzCTM30nWdQ7tK82BAeGL5FmeWXt4a7J6dNljFgcU87M8rra+Ea5jpvFwvEZGbtku2Th
         fVUjYh9KdzhRYyAhbXJTyWZIa5/YPjrHisWvPk/gRAP3vbzdBTXWJqF88yciFNZmNIv3
         u6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740501935; x=1741106735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m7AjPiUKufcUCuCRwM7KdiACvN7KG8NT17WOPwc4KLM=;
        b=P56nw8D0LvDO4E0pBbltztpf+tqLba0UJOK6yCrynq4TKg7v88pmboNAv2JLWvWSm/
         qjTHBq8QJYZdxdccGHFxZPw4A9mHRP27z5ycocqt7VyB2oUNwreWiVdB/hUN4edM0YGO
         3tTx6mnkWPASKoaxCTNU6YWry9R/XRMLV3NQqeV3vn79t9JmfAVRMSktNgUl7d12lKur
         A9p0WJZlIGCcLZCBI9q0wjrZexosIVCngr/9BqlkJm1hBq/eHn6qMeB9aXM0mWzuSxyH
         7o4YAQ8lJo7+pjj72vNjbIqqmkac7OWA8ISzkw//iNP9YvtxciWZsGnpSjulh3iaKuDC
         HbkA==
X-Forwarded-Encrypted: i=1; AJvYcCVIvCzXymwTtbwDojPV5QM9kpVNXqK+TRWgaXcNfH5f+PDLfw2DxmKcCtcCOZOAJY4xI+fjSZbGfH2C9X2Plzk=@vger.kernel.org, AJvYcCX63CALXX0/pUSKCPRK4kO+4caHN0fpc0jWtuE+KNBt+WQahXnSSYatMFx5LS3y1d5dfTcVGIqb2aYh9Dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHseCAbPr5F3lCiZslxYf+xdUZFkyT44N09urDmWTWEyFE/R9G
	+IvUfyXrPVYenmnDhLxayic0nW9bVtUfcWkBwWP/Xp7v0sACqIZf+3rBCJUvG3xSKd3TrVHciiS
	gVDF/pqtSW4TAq2uLgLxOqiAFDpI=
X-Gm-Gg: ASbGncsVt1LrWw/Dv6aajoEL8FgenbNsj3i/eZAt6kAIhwUiGu5oxQx82/xD5FjbQiE
	T4qEQKtNy+bImSIufBL5udXUwCy632ugAZkb+VTRQHRPNnTYMSg8alVmwVcNl3Ugt6dZyzPA3Yb
	auq30wr6Gj
X-Google-Smtp-Source: AGHT+IGPElTgJGuOIFhoQpvigEoyqAazYmo6oGpLNuo3kczlQ8IZTKJj1630KfSBCVkmPCJZM70leOjvb/aBqpDdaF4=
X-Received: by 2002:a19:641d:0:b0:548:878b:ccb3 with SMTP id
 2adb3069b0e04-548878bd500mr1171731e87.25.1740501934971; Tue, 25 Feb 2025
 08:45:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgRZ1w0ONj2wbcczx2=boXYHoLOd=-ke7tHGBAcifSfPUw@mail.gmail.com>
 <9610C397-39C8-479B-A727-1091BB8548C9@zytor.com>
In-Reply-To: <9610C397-39C8-479B-A727-1091BB8548C9@zytor.com>
From: Ventura Jack <venturajack85@gmail.com>
Date: Tue, 25 Feb 2025 09:45:22 -0700
X-Gm-Features: AWEUYZli3Ui7LBmGdvVD9YHbwR1WaUThZgdEiI6e9ZyhcahuU4aeXJ5WC0fMPyI
Message-ID: <CAFJgqgQZoG8VrLUFtCFaMtodvFZEZV-aeFvugCnF+w7WLbS_qQ@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: torvalds@linux-foundation.org, airlied@gmail.com, boqun.feng@gmail.com, 
	david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org, 
	hch@infradead.org, ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 8:42=E2=80=AFAM H. Peter Anvin <hpa@zytor.com> wrot=
e:
>
> On February 22, 2025 2:03:48 AM PST, Ventura Jack <venturajack85@gmail.co=
m> wrote:
> >>Gcc used to initialize it all, but as of gcc-15 it apparently says
> >>"Oh, the standard allows this crazy behavior, so we'll do it by
> >default".
> >>
> >>Yeah. People love to talk about "safe C", but compiler people have
> >>actively tried to make C unsafer for decades. The C standards
> >>committee has been complicit. I've ranted about the crazy C alias
> >>rules before.
> >
> >Unsafe Rust actually has way stricter rules for aliasing than C. For you
> >and others who don't like C's aliasing, it may be best to avoid unsafe R=
ust.
>
> From what I was reading in this tree, Rust doesn't actually have any rule=
s at all?!

One way to describe it may be that Rust currently has no full
official rules for aliasing, and no full specification. There are
multiple experimental research models, including stacked
borrows and tree borrows, and work on trying to officially
figure out, model, and specify the rules. Currently, people
loosely and unofficially assume some rules, as I understand
it, often with conservative assumptions of what the rules
are or could be, as Miguel Ojeda discussed. I do not know
if there is any official partial specification of the aliasing
rules, apart from the general Rust documentation.

The unofficial aliasing rules that a Rust compiler
implementation uses, have to be followed when writing
unsafe Rust, otherwise you may get undefined behavior
and memory safety bugs. Some people have argued that
a lack of specification of the aliasing rules for Rust is one
reason why writing unsafe Rust is harder than C, among
other reasons.

A lot of Rust developers use MIRI, but MIRI cannot catch
everything. One version of MIRI explicitly mentions that it
uses stacked borrows as one rule set, and MIRI also
mentions that its stacked borrow rules are still experimental:

    "=3D help: this indicates a potential bug in the program: it
    performed an invalid operation, but the Stacked Borrows
    rules it violated are still experimental

    =3D help: see
    https://github.com/rust-lang/unsafe-code-guidelines/blob/master/wip/sta=
cked-borrows.md
    for further information"

There is only one major compiler for Rust so far, rustc,
and rustc has LLVM as a primary backend. I do not know
the status of rustc's other backends. gccrs is another
compiler for Rust that is a work in progress, Philip
Herron (read also his email in the tree) and others are
working on gccrs as I understand it.

Best, VJ.

