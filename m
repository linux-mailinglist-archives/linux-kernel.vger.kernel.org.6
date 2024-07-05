Return-Path: <linux-kernel+bounces-242579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9417D928A16
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 15:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7F361C24367
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC6D152E0E;
	Fri,  5 Jul 2024 13:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmV1Fl1n"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C311A149DE4;
	Fri,  5 Jul 2024 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720187209; cv=none; b=HHUB7s3SZnII3YZG2PgIXC0/UDKmMVpXPkn7Ls9X7pUPs78ICYh1p0xPjOIozDnRs3YOf3ROQwfcFtU9y0Lg0On4f/Wj4BqueMNtmoO3XtO0Ij0MyoNCA4vTha3aP/xIzoiHfE2weF/VJavRFahtf0Av3rgcN0JjUIhaOhcoatI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720187209; c=relaxed/simple;
	bh=l+1Y1+caxhVchzhr4BCyG+RAbZ2ux/UMlynAtjvAZC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gVqiMySFTL6qzFoVALmwXzSNSdZVW9GA0H6gfdcvj1my8ReBBxmJbozkPnXUlTpxumK2QO/Vn9gaX5XPGrTQCDdXw7uh96suwct4wDCIpHxZRCP557uPIWMLXNqVro0DLM9oMtmdRx/r7ZnKGduveQ1VtVY96hpTjLDCaBqHkLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmV1Fl1n; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c8e422c40cso1077504a91.2;
        Fri, 05 Jul 2024 06:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720187207; x=1720792007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+1Y1+caxhVchzhr4BCyG+RAbZ2ux/UMlynAtjvAZC0=;
        b=AmV1Fl1nwcrV8oELAiQx/rij0+1/82Ra3n4cNRQsdFMwBZLbbUU/WG/CzRZwfdkj9Y
         ju70Ws0JNaOjncBJ+EdOEjKXE8WhepY7/t8DwHN4NsAaDBn6iJ1aC23GUYDscFDuOw7h
         4yvGwLSMFt0gzO2mhDSF5LSiVTFvVCXx4Ji7W5I9oqbDps/zx/6k553NZq8r7BuOwAXv
         eIlFpUaCuDXxIKcTXyR8nijqxZ1FwOeY/N3Vw2/NmJ5dGFPXy/ugYWSFANKC6pgiYF2K
         O5r8DisXjpoo5Az8hiUZmHzRzlIFHPRD3XzKzWfqxwLG5meMDfkvq1s9VC7K/z/hBjfV
         imXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720187207; x=1720792007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+1Y1+caxhVchzhr4BCyG+RAbZ2ux/UMlynAtjvAZC0=;
        b=l9GDcPEG1vCkboMlc3/E7SPqHrk1lzh2ufygI8OPg3kzcRs34Vp6nDJrjmxp9XCvkY
         lyQ5CdDeXyV4cQorsVZrhcpopARFVyThg0cC//1Hfm+G/A/Ot9vED36KIq0T+iuj7RF9
         widploej1/e28mcQHnvZ9ZE6Tx2NNay1lzEMInIH8rZefnWNeL4oqOAQfWIz5V/SwSnw
         iXTYfQb2MHOuq5cuAwDV3aBu1F6qFDOLlo7fkb7h8eas3rHN+AbdbiU28ZjvX+pxMWas
         eF7HZtAxBJc9zmv287Tc+QCtidaKlet4CkaChjSkCz79LNhqnFwSoWxkQn7Fj4v7XBxt
         hDvw==
X-Forwarded-Encrypted: i=1; AJvYcCVZd+Dfnkl1KiE2subm962X6togtSO2oKKARglLkL0PNEyEjfEjTQhMM37ZkN8eXKl8+MsREtRxPqxatFqZx6SXn9h7USEqtglKg4DgLBxnlJ8NBZ8C0qY3uEnXLGiczSXgKDDcp3GsHQ6pFlxa7cTxneulWai6pEhgzTc7JDu7gJvDYsnHJsI/5QWBkG09UC1GAqXcpOi06GkrjU6PBxg9WBY=
X-Gm-Message-State: AOJu0YwzGqZjwnJl9Hv6Paf53WoQDnsnPSIBZ5P/gh4oTkIdGBnlrD+2
	vEE0t8JZiCbLIcdL8qqPqDOWF98gscLW6NNudwn1W1Nar7KxQtA8o9tzz3b8S4LLX8THtuNnrE7
	Z1Z/WK6+XH7mKx91aLpeYwTNCNOY=
X-Google-Smtp-Source: AGHT+IGn9pRs0VGDTMIiD7gHdJZujUU/p8nn7qMARSQbH4hdHR+SWMvpQUQdYXZvJ5a7xvLZzY8hKk5A4Nt/5wtWCgc=
X-Received: by 2002:a17:90a:d795:b0:2c8:f3b4:425 with SMTP id
 98e67ed59e1d1-2c99c6a3198mr3417780a91.23.1720187207178; Fri, 05 Jul 2024
 06:46:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701183625.665574-1-ojeda@kernel.org> <20240701183625.665574-14-ojeda@kernel.org>
 <ZoeQVYda-AZN6PYy@gpd> <2qwdfogh6jd5uixxjzlagmtfvnykk3x4ztqrn4j2v6qoref5rx@ooj6gq27bq4z>
 <CANiq72n6bYt0AKNxad2+gjwHKQ1RiDxAbjm-2u20L8TcSZE-9Q@mail.gmail.com> <huatx5giw7r357zeecxngkqboiq3lfqndjjrcivxllurqpjvbi@4y5ejgwxhztm>
In-Reply-To: <huatx5giw7r357zeecxngkqboiq3lfqndjjrcivxllurqpjvbi@4y5ejgwxhztm>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 5 Jul 2024 15:46:35 +0200
Message-ID: <CANiq72=A-PZ6LoUiVQuOvN2hMVvd5pJ42OKPW61FXNrnYU+WBg@mail.gmail.com>
Subject: Re: [PATCH 13/13] docs: rust: quick-start: add section on Linux distributions
To: =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?= <debian@fabian.gruenbichler.email>
Cc: Andrea Righi <righi.andrea@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	Jan Alexander Steffens <heftig@archlinux.org>, =?UTF-8?Q?Johannes_L=C3=B6thberg?= <johannes@kyriasis.com>, 
	Josh Stone <jistone@redhat.com>, Randy Barlow <randy@electronsweatshop.com>, 
	Anna Figueiredo Gomes <navi@vlhl.dev>, Matoro Mahri <matoro_gentoo@matoro.tk>, 
	Ryan Scheel <ryan.havvy@gmail.com>, figsoda <figsoda@pm.me>, 
	=?UTF-8?Q?J=C3=B6rg_Thalheim?= <joerg@thalheim.io>, 
	Theodore Ni <43ngvg@masqt.com>, Winter <nixos@winter.cafe>, William Brown <wbrown@suse.de>, 
	Xiaoguang Wang <xiaoguang.wang@suse.com>, Zixing Liu <zixing.liu@canonical.com>, 
	Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 3:09=E2=80=AFPM Fabian Gr=C3=BCnbichler
<debian@fabian.gruenbichler.email> wrote:
>
> right now it is updated whenever its rdeps (firefox and chromium in
> stable) need newer versions. once e.g. a stable Debian kernel has
> similar requirements, I guess the same would apply there. I am not sure
> upstream kernel development on Debian stable would be enough of an
> argument to update it (or provide similar packages), but I am not a
> member of the teams that would make that decision.

That is reasonable.

> as discussed off-list, -backports might be a better place for providing
> more recent toolchain packages on Debian stable, and independent from
> this thread, I have pondered providing them there in the past already.
> backports would only ship one version as well though, and at most the
> one in testing (so it would also be affected by the freeze period, just
> like unstable and testing).

I imagine that could be useful for some (kernel or not) developers on
stable, even with the freeze period.

Thanks!

Cheers,
Miguel

