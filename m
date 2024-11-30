Return-Path: <linux-kernel+bounces-426396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9BF9DF28C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 19:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCE81B21105
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 18:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1541A9B59;
	Sat, 30 Nov 2024 18:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qw1HbeTW"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB071DFF7;
	Sat, 30 Nov 2024 18:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732990745; cv=none; b=GsT+kw9Coyb3VMm1TQ8N1v1OGi1h8HQV7+QUGjUkO5Cn76ix5251gmpKuVtbj6qT1hlhfmO08uRIg0TaMoD2BuhpkAJ0gWRB4DzcB43QoS8VP+SDgkdujQD3JC9kGAmFSzKoCfSS3AS4gWBWe8OTK0KaHSP+Gq/UJDQ/wJVrFTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732990745; c=relaxed/simple;
	bh=AUF+Kc3UOmI807pEizjpwazBZf6mZrD1duRR4hMR5U0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rQRVFd2gi/hLaBKPr0x+w50iPXvXIPjiJ41Vd5tSruMfDy/AzLvhOw9BtVuGjwFk/LmV9HVnPYH9joAUBzUThjtK7ImFi0+r7E6UMQrppdQUjNY/JZH3rA7jE3O4fYZ7cUQP6QbELV+Z/YkY4712nt0yuAAFoXhOEBa5OHYeWLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qw1HbeTW; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7eadb7f77e8so197278a12.1;
        Sat, 30 Nov 2024 10:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732990744; x=1733595544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUF+Kc3UOmI807pEizjpwazBZf6mZrD1duRR4hMR5U0=;
        b=Qw1HbeTWtIpeHeEJqPDN2dV0MqKz51A8606sD7w7Gsh6QoiPSh8rDjWikIAB8/eqy8
         5FC4k/oD96+An4wNVI6e/atyrrmHc22/5kD5Qv3EP86XHb3Xe8msDBh31cS0xD25qiYZ
         bQBrzZK/F9/W7OYk2mF1WpRsE/DQTROJPi3W9haYqGYjwhIEOD4QpRRkLZk/TEDbX+as
         m1cBxNhbksHbMPfFK0wZD0WgFerfgWoWAkFWRQoJDzpuG5c9mG5NG+KvayP9r7ZMKfYX
         hrPJXaZwxW7fGyuvim4Q0AciMgA9FmpY6ck/1qgEGiBtS2iYDPQcFzxy/JIRp6CJuM6L
         pDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732990744; x=1733595544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUF+Kc3UOmI807pEizjpwazBZf6mZrD1duRR4hMR5U0=;
        b=K3kzMwVcxijliFZ6794VrJciUifRjmGc/SU/Fua4vTh59iu2dMJcy8SAp8n9Z1RBD4
         wiC5bvT7fGUAxc3zNKBYjyu4sSeBT/M6cA5sDSXfX7BaR+6amA7F4atTGUrF8oddcLT0
         K7S++bUYOZ3xDXwjQ0yjwOMNXNu1fwMh+1spH+uKRrtVpY11rRkoqNhOPKfM4Ux0yjbT
         c+yA2zzOmHYvqIqeJ4Modu9h7eW0t2nNk+NIPylymWOOccH4JprXUNox1i3+q5L5XaFG
         XqCjSFVessmGL5caAURa5GXoFS/8isiywdbOY7l/qHnmp3bBhD+qAmMh19XUZOEVv+ZJ
         U4ZA==
X-Forwarded-Encrypted: i=1; AJvYcCW1+Si+YRo6vk9rwJZtlRx1aUP1RHlRon8K9CjJHNl0ZYhQ4lUIGhMvD41yehE12khyZui75Uz6Il67+QNQHmU=@vger.kernel.org, AJvYcCXHlhd8/qiijZ6sqTqLvlIybpnGi9Y3AmZi9tWGBqdxMZn44oFb8IHfhuOIIV7kTv2j8KaTDYktp55TeiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YylkNMBaVrYHDpGEsZlTIcJutOv4KlyBIeDNlWztPI4dkpexDMA
	SHU5+UBoHFIqLod0hYvwgtSWUmdIytUeMZ6lqIkQV40tig03oTwP/QIvhfspE3IOVMPdJ7I3NTU
	Itk8DoqhfGC0akxGL3RmOgLubouw=
X-Gm-Gg: ASbGnctqF46ryfWBkfuyyksTrH+fxLB2iqkXic6GkTRUf4tCT2dKeoysefxKcjXlQxP
	t2H0WwxDBdinRc3RdpBwSBoKqtVc8+kI=
X-Google-Smtp-Source: AGHT+IHVGuoLdkKSmlWFs03/PbkI1AcNCeyRcOgI856xQLmUnwS1WVfoRDNbv/idSxXdpOOLoSSuk2izgCp2YeclvPs=
X-Received: by 2002:a17:90b:1648:b0:2ea:5c01:c1a0 with SMTP id
 98e67ed59e1d1-2ee08ea8cddmr8808873a91.3.1732990743720; Sat, 30 Nov 2024
 10:19:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126-pr_once_macros-v4-0-410b8ca9643e@tuta.io>
 <20241126-pr_once_macros-v4-3-410b8ca9643e@tuta.io> <CANiq72m-dY0b7UiBiWOg8g1SFPqLxuhkDdWwNh8g8OBk-Tjz=w@mail.gmail.com>
 <OCjLJ1h--F-9@tuta.io>
In-Reply-To: <OCjLJ1h--F-9@tuta.io>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 30 Nov 2024 19:18:50 +0100
Message-ID: <CANiq72=A9=uzSt9DOZBvw3sHwf4vqX2+6MBDKO5FokZUyt1V3A@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] rust: error: Replace pr_warn by pr_warn_once
To: jens.korinth@tuta.io
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Rust For Linux <rust-for-linux@vger.kernel.org>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Dirk Behme <dirk.behme@gmail.com>, 
	Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 9:39=E2=80=AFPM <jens.korinth@tuta.io> wrote:
>
> Tbh, I am not 100% whether this should be here at all. The bug is not her=
e, it's
> at the call site. It should probably be a `try_from` instead, to raise th=
e error
> there?

Do you mean removing the function altogether? i.e. migrating all
callers to `try_from_errno`?

Cheers,
Miguel

