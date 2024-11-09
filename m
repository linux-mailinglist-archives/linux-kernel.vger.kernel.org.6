Return-Path: <linux-kernel+bounces-402887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7499C2E0F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 16:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8727928276F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 15:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8D2199941;
	Sat,  9 Nov 2024 15:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBVGDin9"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9082A155C94
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 15:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731165094; cv=none; b=EE1u71sVki3+pAte1xtPgwsihg0tytn8XSdDRgjKT/SlU41gd8rPzxqNLgQQs7PBSmfLmofCoVY7IlpI6/YsN6u56RAQKQuWoo/nTj6+DP8zKYygzMYGDmtxsn+a3WE0O4imha83wJhd4+RATaLA6JsdtY/R3d//alqtFBCohD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731165094; c=relaxed/simple;
	bh=L0I1JptouAky5IHlFmAMdPRPB4zs5Fga3f00ssotOpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AcsZ9u1iiTQ2KgfTuEg5ww/sv2e6cS/DZZDWBmj9zGrLprApZacFKg8f+iYQN7GHVnQExhpXUiI5B6qVRwRyqPbvLhw0GjcMaLJDBmMSr+VeqKwoO6QZhRmgS3EECPBR74TaiDEQ0js1qCX5MIVmMb7tqefDxrx4WZZ+l9UXgIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBVGDin9; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e7e73740so2927790e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2024 07:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731165091; x=1731769891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9V9hRTWks3Eh0qfSQPZ+ICXvvEjOQTekt51MUUCJnj0=;
        b=TBVGDin9A+m3g6gVlUOI6YPgALi7Pk/B4XlBcUFUgYGSm2h7+F4uhrbCebp3Ki+8Zj
         WPNId3JmJixMXs+TExK/eewuLi+Mr3J3Vo+VDSyuxo0Cw16mNFpjvrM2GdEAdDKeinGC
         pEnu9ppvuTjEHKu2tpFfDpprXE0j2yA4aYcL5hOoifHNCJHgEHjLpREEpgXKwdc/76sp
         faMln3Fs7nlMks3VY61+NJ1vijtZeCH2pQfoIlyuyRcMYsr8kf/oL3XQoZC8YaJouTyK
         30pGXrSN35Td1WEhe2nEENJGy08SszmBPGNmwIQxxh0TYGvTWtC+3+kKBXxjnijQYUdT
         OJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731165091; x=1731769891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9V9hRTWks3Eh0qfSQPZ+ICXvvEjOQTekt51MUUCJnj0=;
        b=IljCFSOguIcp7YfxSsJgls2lT+/qZ5mj299NyyccnY1DYnczf//tvGbB04ugHvFqic
         P0USHR2LxMn5BM42L40A9VYEugi7ouJeotSrzivFAB9ur9YEqu9pYHACOiG6jTl6DImR
         W2uq7XeDf28a+vTPrxtfqAbH2N6Eo607qbQ98Uwc18b9DY85rLkRmagLGj4SCSvLfWeH
         jNy4hbLVI5nNwkGMtF72YD7YXJHVWthK+nGFb9jGQ+iBRK7aB2H+5cJQQKlvQDqp8F0I
         iQgU8yQZpV0oDEDrI2p7udcOTfL1rtMRLVjOh2b4ENHB3b+IrHm+6e+i62yo4pOQVQpA
         fQwg==
X-Gm-Message-State: AOJu0Yw7UQLjlBcJXzCf3faHm9cvBM/jrk/XO+4MbO+/vtlGcNjW5Ya5
	JIhUDJ635Wa8qaYHgjbQePYHoLzjzpNSPynHQEx6+arN+JByX+8+J1yQEl31Nu1pD0oL+m/Kt9C
	qBLbSBOCBm3GPVC9DJrjrbC2Chw==
X-Google-Smtp-Source: AGHT+IG51tVgYwLITpfmjxFbxUxLBfZIAq/M5j7fc7acnngomegcPxiHo5YAWvqy+c1iID+XgVB9hSIZLrZYF6srCxA=
X-Received: by 2002:a05:6512:3985:b0:539:ee0a:4f8f with SMTP id
 2adb3069b0e04-53d8626c670mr3197917e87.44.1731165090323; Sat, 09 Nov 2024
 07:11:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105155801.1779119-1-brgerst@gmail.com> <5b42962e05754c15977a102ccd5cc7aa@AcuMS.aculab.com>
In-Reply-To: <5b42962e05754c15977a102ccd5cc7aa@AcuMS.aculab.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Sat, 9 Nov 2024 10:11:18 -0500
Message-ID: <CAMzpN2h_4cKa7oxPQ0M169xQMKCtZCj9bTggBd4Cyk8j18tf=g@mail.gmail.com>
Subject: Re: [PATCH v5 00/16] x86-64: Stack protector and percpu improvements
To: David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>, Uros Bizjak <ubizjak@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 4:31=E2=80=AFAM David Laight <David.Laight@aculab.co=
m> wrote:
>
> From: Brian Gerst
> > Sent: 05 November 2024 15:58
> >
> > Currently, x86-64 uses an unusual percpu layout, where the percpu secti=
on
> > is linked at absolute address 0.  The reason behind this is that older =
GCC
> > versions placed the stack protector (if enabled) at a fixed offset from=
 the
> > GS segment base.  Since the GS segement is also used for percpu variabl=
es,
> > this forced the current layout.
> >
> > GCC since version 8.1 supports a configurable location for the stack
> > protector value, which allows removal of the restriction on how the per=
cpu
> > section is linked.  This allows the percpu section to be linked normall=
y,
> > like other architectures.  In turn, this allows removal of code that wa=
s
> > needed to support the zero-based percpu section.
> >
> > v5:
> > - Added two patches from Ard Biesheuvel to make stack protector work
> >   properly when compiling with clang.
> > - Raise minimum GCC version to 8.1 for x86.
> > - Drop objtool conversion code.
>
> Is there any actual need to raise the GCC level?
> Isn't it enough just to disable stack protection with older compilers?
> The percpu layout can then always be the new (sane) one.

Earlier versions of this series did make stack protector support
conditional on newer compilers.  That got rejected.  I then added
objtool support to convert the code old compilers produced.  That also
got rejected.  I guess I can't please everyone.

> Is there even a selectable CONFIG_STACK_PROTECTOR?
> Can than depend on gcc >=3D 8.1 for x86-64?

Yes, stack protector support is optional, but practically all distro
kernels enable it.

> I've a slight vested interest in that the system I test kernels on
> has gcc 7.5.0 installed :-)

What distro is on that system?  Is it still actively supported?

Brian Gerst

