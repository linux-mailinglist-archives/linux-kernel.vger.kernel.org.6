Return-Path: <linux-kernel+bounces-405534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 170189C528F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCD661F23555
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAB520FAB3;
	Tue, 12 Nov 2024 09:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAjHOal1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B37420E31C;
	Tue, 12 Nov 2024 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731405535; cv=none; b=fI7Q+MVOWXarXbrl6uhv0WQ4Fl0viERHvg69mealS/ykfUG/ZpFk63Du/brwZxR0QVgzi//SR0LnX8yn5P8Y16KzWE3/Kf0En611bZJl1rrXejQ+u6aX122PML3JH4r9Y3GxASL1LW4D/Qp3u63Z7aDuar0m5bCWto/d0f/R3QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731405535; c=relaxed/simple;
	bh=Z1viKT12L8Y2BLw1uaPLyAgZcHy96ritO3DNvdtjbL8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t6/5AmtuXlHgYe+1zyHctif9Uvr2jmdKdpTTuklCeuXwt5hUeS91lzjwf1jEI/as7wgp8rBwLq9yyJ6Vt8lssSjGm5DwunMQxD3UZunhOzhckh0HU/jiIDK+K/nYgGaAanc26UyzshIikRL7/nKLcrXxwT+bMpB+vyIiZgB21/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAjHOal1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80036C4CECD;
	Tue, 12 Nov 2024 09:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731405534;
	bh=Z1viKT12L8Y2BLw1uaPLyAgZcHy96ritO3DNvdtjbL8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PAjHOal13UfwsfmGlpR8f0QMtnWMaeruStnH4LUN97c89MCInPk8Tb2TqoOY6Rco/
	 LTttx3UYymEXmeRvJ5mViWTuaEEc0G1n50G+vdfpCX31ooBMypOzXcpntN9w7eUhRe
	 7B0LiEwNmV+EBRmVugq5NTTNgWK7VEZN8Df+n9CLociYeUpl7+JxlenQZZQCOa/S2T
	 Ajxu9uCwK0n4K5k5UgnH9IQh5RS0QOo8PXTGW9sQuNH/leH081FIg+XTOFw5O13bjN
	 m8FaJ71FJYLoVJlDTLT8lZf8SMht+cVQyQkkNqwcbjAa4/7geAiCYCd9LSza5Rfvzn
	 /2vzaFmWQggJA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alistair Francis" <alistair23@gmail.com>
Cc: "Alistair Francis" <alistair@alistair23.me>,
  <linux-kernel@vger.kernel.org>,  <boqun.feng@gmail.com>,
  <me@kloenk.dev>,  <benno.lossin@proton.me>,  <tmgross@umich.edu>,
  <aliceryhl@google.com>,  <gary@garyguo.net>,  <ojeda@kernel.org>,
  <rust-for-linux@vger.kernel.org>,  <alex.gaynor@gmail.com>,
  <alistair.francis@wdc.com>,  <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH v3 01/11] rust: bindings: Support some inline static
 functions
In-Reply-To: <CAKmqyKNjjELzVbWgBHaHr8N1XnOJHk-U6RfLyb-FbTJ7h9jPoA@mail.gmail.com>
	(Alistair Francis's message of "Tue, 12 Nov 2024 08:58:07 +1000")
References: <20241111112615.179133-1-alistair@alistair23.me>
	<x6OyXuGQi1xeknAX_pjcl17BOpxRM6OGtLWGhGOH4LUgghJaP29a4ebzCT21QdfxBb88PwZCc2U7zizrTTSzVg==@protonmail.internalid>
	<20241111112615.179133-2-alistair@alistair23.me>
 <878qtqt1n4.fsf@kernel.org>
	<SnLsh8RJ31-mqOVagPGJkEkUNFbHMWOubRf9pTxflqODI9Hf_iCJm2u0hUV5lY0mwT6WqGQ_4uYd12M2kmPYqw==@protonmail.internalid>
	<CAKmqyKNjjELzVbWgBHaHr8N1XnOJHk-U6RfLyb-FbTJ7h9jPoA@mail.gmail.com>
Date: Tue, 12 Nov 2024 10:58:40 +0100
Message-ID: <87iksssrhr.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Alistair Francis" <alistair23@gmail.com> writes:

> On Mon, Nov 11, 2024 at 10:07=E2=80=AFPM Andreas Hindborg <a.hindborg@ker=
nel.org> wrote:
>>
>> "Alistair Francis" <alistair@alistair23.me> writes:
>>
>> <cut>
>>
>> > diff --git a/rust/exports.c b/rust/exports.c
>> > index 587f0e776aba..288958d2ebea 100644
>> > --- a/rust/exports.c
>> > +++ b/rust/exports.c
>> > @@ -18,6 +18,7 @@
>> >  #include "exports_core_generated.h"
>> >  #include "exports_helpers_generated.h"
>> >  #include "exports_bindings_generated.h"
>> > +#include "exports_bindings_static_generated.h"
>>
>> Generating `exports_bindings_static_generated.h` depends on `exports.o`,
>> which depends on `exports.c`. Does this not create chicken-egg kind of
>> problem?
>
> It is a bit confusing as there are a few levels of autogeneration, but
> Make happily handles it.
>
> `exports.c` depends on `exports_bindings_static_generated.h`
>
> But `exports_bindings_static_generated.h` depends on `extern.o`
> (extern not exports).
>
> `extern.o` then depends on `extern.c`
>
> `extern.c` then depends on `bindings_generated_static.rs`, which is
> generated by bindgen.
>
> So there isn't a chick-egg problem and this happily builds from a clean t=
ree.

Right, I think I mixed up exports/extern.

Anyway, it does not build for me. I applied it on top of `rust-next` and
I get:

..
=E2=94=82  CC      rust/extern.o                                           =
                                                                           =
                                                                           =
                                                                           =
                                  =E2=94=82
=E2=94=82/home/aeh/src/linux-rust/helpers/rust/extern.c:1:10: fatal error: =
'/home/aeh/src/linux-rust/helpers/bindings/bindings_helper.h' file not foun=
d                                                                          =
                                                                           =
                                  =E2=94=82
=E2=94=82    1 | #include "/home/aeh/src/linux-rust/helpers/bindings/bindin=
gs_helper.h"                                                               =
                                                                           =
                                                                           =
                                  =E2=94=82
=E2=94=82      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~                                                               =
                                                                           =
                                                                           =
                                  =E2=94=82
=E2=94=821 error generated.                                                =
                                                                           =
                                                                           =
                                                                           =
                                  =E2=94=82


I am doing out of tree build - maybe that is the culprit?


Best regards,
Andreas Hindborg



