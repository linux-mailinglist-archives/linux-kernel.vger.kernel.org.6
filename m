Return-Path: <linux-kernel+bounces-345468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C377998B6A7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72929282C3B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1F319ABC6;
	Tue,  1 Oct 2024 08:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r4YSsT6q"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689A6199FD6
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727770846; cv=none; b=fgwl/76yeS2kyTpKUQff6lP0pUO/M7GdmS1YBg4HNkQVOAyOfHO8p3X03m2E4g0uYRUTHERbMwkLs6ZEBG3UBcmX8j9ZGRWY03vnXGshWoFiZdvtrHe0iv0PcLMCgTQT4ZB2pDkwtf7/Y2S8JXQGkbr2fTZCs1T+qzL+9NQsfnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727770846; c=relaxed/simple;
	bh=4N+ibs1sFppJJYULH32Paj5So960irpOMdhYsZRhbhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sYT4HcUcSCcQ244YyKA61eQTuJ71ckHUV544L+Klpy7tbEGb7ZS6G848PJFPE3GqjI5jOBduxm8Wiq4c1/zUg4Q/ARBw1oLWlxPVFr9NE6EgSpX3Uv7Iz8rL7azsXBLcBm8EXU8qQIoSOtVEp1zGLXrIpY2iuWU5z/bb7H638w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r4YSsT6q; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb58d810eso36976625e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 01:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727770843; x=1728375643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwjqJSGgG+H6oyeqtpNUfZYxj/aohEl0owqW2NF032o=;
        b=r4YSsT6qtHAkYGO6butlfCotkL7AKlufq12Un7TQfcgtRy4iJWkW4QmPS6kouuGOuR
         ZWs0zDfZfHw8r9LxlPvlryF6GuKS1XmKe3DN6WiZlcm+ZT8iTCMOodv3fS+C3x6X95tH
         37lF0p9MQ8Y1+/t+ekAv6OieFaEpsGc4PuDfCD9NkI41k86FABa+3ofiiJlsDgCZ0d+c
         0jBVvFNjU3FO9/wRvEpAwmuMiONOfzyH5KoY5UJd/a9AZJRMhGK/Nhz7Y/5gva9DpOkT
         0w+11t4U7vzMeS41cT6ixYPNjOHBqnbH8XqI4OEEDK4Ps1JFpkq3jDiqqDqTZ82+cAHF
         QX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727770843; x=1728375643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwjqJSGgG+H6oyeqtpNUfZYxj/aohEl0owqW2NF032o=;
        b=IO5xfe+vS53Frp1aGCoH2RQpf1i0UhfmssjZ5sbM3nBXrNRBBnPgk01y8YLbTrS0dx
         uMsb6saViVcbnSam0TBghFuTLUuMlFaiQ/HjKvYokOaFvlFAcwN6pF1q10Ig/MeIZMq7
         05JvrHoKe3eftm4vWF0Tm3HqKpkYzfqtWl3G+e5wP35bS1l9d55eBrtEFok/6gEpPM4J
         Rn3CCfjpNgxpzma/NV0YIpeYSdVxHC4j+q0Xio0GVCmDFl2QKW98IMt5sKADdetejU4U
         jJAUN17wbP8LV6ty3BgpRBGXlbsbmPusjqS9lKLKXCLpyciKkW4Mig3Q/OQUwqDZ/oLP
         JjTg==
X-Forwarded-Encrypted: i=1; AJvYcCVA5bmlo73QT5p2mqDmr07uDtVeE17U/WizkIKVpU/1vRdlpQByaA4fdnDkFhFOELPfteXBF4TW7nQhlcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFxVAWAahgxEWa2XFMGnD8tTiEUBmJRF4OTONa1Xi+kJeFv/nl
	rY5BeyetXUGPr9zg3gWkgNHcLGq1CznRo4U9OrhRhnrQ1d60UXrnomdAB+onjA7TiI0Iuq2T0if
	u/5sFs+MGBfj6rG/RM4KhCwfxg1fUjAq0Pg8Q
X-Google-Smtp-Source: AGHT+IEuz+NLxVqHubfGTHjcpcw7MR71fHOixLslnBUog2WWIigqb2G698IyoTMJG2l/y5i+sVBXfSl/bEc8RDk46kg=
X-Received: by 2002:a05:6000:d02:b0:374:d130:a43b with SMTP id
 ffacd0b85a97d-37cf289b98amr1332507f8f.4.1727770842386; Tue, 01 Oct 2024
 01:20:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926-b4-miscdevice-v1-0-7349c2b2837a@google.com>
 <20240926-b4-miscdevice-v1-2-7349c2b2837a@google.com> <20240926220821.GP3550746@ZenIV>
 <20240926224733.GQ3550746@ZenIV> <CAH5fLgick=nmDFd1w5zLSw9tVXMe-u2vk3sBbG-HZsPEUtYLVw@mail.gmail.com>
 <20240927193809.GV3550746@ZenIV>
In-Reply-To: <20240927193809.GV3550746@ZenIV>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 1 Oct 2024 10:20:29 +0200
Message-ID: <CAH5fLghqptxk5LiY3a+k1WX8pf73kJTLf2VxRJBiOPwxZtNmtw@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: file: add f_pos and set_f_pos
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 9:38=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Fri, Sep 27, 2024 at 08:56:50AM +0200, Alice Ryhl wrote:
>
> > Okay, interesting. I did not know about all of these llseek helpers.
> > I'm definitely happy to make the Rust API force users to do the right
> > thing if we can.
> >
> > It sounds like we basically have a few different seeking behaviors
> > that the driver can choose between, and we want to force the user to
> > use one of them?
>
> Depends...  Basically, SEEK_HOLE/SEEK_DATA is seriously fs-specific
> (unsurprisingly), and pretty much everything wants the usual relation
> between SEEK_SET and SEEK_CUR (<SEEK_CUR,n> is the same as <SEEK_SET,
> current position + n>).  SEEK_END availability varies - the simplest
> variant is <SEEK_END, n> =3D=3D <SEEK_SET, size + n>, but there are
> cases that genuinely have nothing resembling end-relative seek
> (e.g. anything seq_file-related).
>
> It's not so much available instances as available helpers; details of
> semantics may seriously vary by the driver.
>
> Note that once upon a time ->f_pos had been exposed to ->read() et.al.;
> caused recurring bugs, until we switched to "sample ->f_pos before callin=
g
> ->read(), pass the reference to local copy into the method, then put
> what's the method left behind in there back into ->f_pos".
>
> Something similar might be a good idea for ->llseek().  Locking is
> an unpleasant problem, unfortunately.  lseek() is not a terribly hot
> codepath, but read() and write() are.  For a while we used to do exclusio=
n
> on per-struct file basis for _all_ read/write/lseek; see 797964253d35
> "file: reinstate f_pos locking optimization for regular files" for the
> point where it eroded.
>
> FWIW, I suspect that unconditionally taking ->f_pos_mutex for llseek(2)
> would solve most of the problems - for one thing, with guaranteed
> per-struct-file serialization of vfs_llseek() we could handle SEEK_CUR
> right there, so that ->llseek() instances would never see it; for another=
,
> we just might be able to pull the same 'pass a reference to local variabl=
e
> and let it be handled there' trick for ->llseek().  That would require
> an audit of locking in the instances, though...

Okay, thanks for the explanation. The file position stuff seems pretty
complicated.

One thing to think about is whether there are some behaviors used by
old drivers that new drivers should not use. We can design our Rust
APIs to prevent using it in those legacy ways.

For now I'm dropping this patch from the series at Greg's request.

Alice

