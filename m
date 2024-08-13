Return-Path: <linux-kernel+bounces-285328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B760950C23
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5028B1F227FF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A341A38D7;
	Tue, 13 Aug 2024 18:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JVLnhzHV"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A25B1A01BE
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723573298; cv=none; b=on9qj1cKKccYQYHsH9O2Qg3tUA8r/tsbX0K1vlIPCemq9oxQSflV68WCujypSQD4N2rQ0lMHhVDqs+jVTIL9cjJRUWjv5ebI5EdEMAzfbewX98xshGt3hE/XjstKaGflxW4i+EOd84O6dKU/b2i2eT3EPzWRAC3iUxMiR++gk4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723573298; c=relaxed/simple;
	bh=edqtHeHV33yy55IQpb6RjSwy85ICUO5/ICExTZhuF94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DlcVQnfEm4gd100OPyhYD90ZuG8dnJHy+PLjnwV7a+4IEUeFDJNK3neyhCBIxIgjmRLHTiP70eI3iPVtLOrkrN2WtGAq6tzrTCkfkUgJNZWUET1mxUd3nznou7bNyL5PafAYFUqIgduITvtPRIrvGCef9m2vEwzbj4wLgTLZHLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JVLnhzHV; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e0e6cbec8caso5452009276.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 11:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723573295; x=1724178095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vIS6qvkd549QuQAxkwdOfwsQhqVYcwCUbZikjqjGEU=;
        b=JVLnhzHVRVqwjVFOpwAcNYtKVywMqHg0abkP8ufNr70tS+ivzIXDWfys+1J7EVRWsh
         EZSySHEEFTPJPBtqodOCWpdMCm0lkfYpEeyUIzPai9YhQBDQSbDRgZj70JxPhMxLtrkK
         rUmyNh/uDkayBsY5aTixaFdZTn+XmMgbeefmwiZdxDafjuJK7AmGJ8YFGvd2HKx8NDW0
         c0l+JHp8GBUHyhv6eefw9KQqTHWjXhH8LcB+4jjiMiWsos8wm6gDkDh2Xogb+9H81vXf
         /w9UvyW7ERcrchWvDMCLYHvQaJDNcIP9hoYFcGo4hdj0FLqunywagtzB4+2ju2M+kdGv
         ISNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723573295; x=1724178095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vIS6qvkd549QuQAxkwdOfwsQhqVYcwCUbZikjqjGEU=;
        b=eR7Xi77L0tlmOwQjMZNZeZege6OFWE1E5Erw2QuIOwdO8bOHTov8TGba0mrA8x3G9r
         xxRuQSAp+bgUirld0qsoU3tzDTKm0hnIl0XCr8dHbETTF8jXi58Ix4CM8ro6k+EatHlC
         7/8jrBAPixnOeM6RVGNJ1vCPiKZMQE4L3T/ieAdGuZ/LG/hUt1Y7VoxZ2unsEgQFtzR6
         4YaXd9/gkLUNz5uUFYhuP78l5HXWtf4f8cznd8y1/PiL2+DC0IY34dYWtsfYhlAFnpgn
         VL19snMh3bhG74i/ipxic2ZZYQOsEoOXOyID74d466BpsFMd7PzS12lT63fPp6J01eNj
         j35g==
X-Forwarded-Encrypted: i=1; AJvYcCUpvKXUDz09U11MYT70kHGXLhLtz5ZeAYmEZPpnSa0Wt4bMmHbbyS0hwaeXm7n6VX2bzUqbKJLhyLrdNHuK3uqnf7ZMa9BsXzrJ9g3b
X-Gm-Message-State: AOJu0YzdcU1bkhHS2CIZpRnXyNPuo+SXLaao857Qcmh9Y1pUse01sZfy
	AeC2hrl1tiMZCxE+J2r9QPSLq/k2o5/GruNj+Z1I4zxpFKnV+ITs5XxgVwE7EmfiHNQfIFDgEW2
	ZpQ0mJNuZayErbh7zI+oZdajsNzExpF3pj+Ui
X-Google-Smtp-Source: AGHT+IFFVh9YGBEeKwHEfD3REmiUjn/lvIsvTfra5ng1tQZa2T4ufXv3eepyTv4FpUyqHLUi36PUxRZC6NyNbSXHyfA=
X-Received: by 2002:a05:6902:27c7:b0:e0b:28ce:6156 with SMTP id
 3f1490d57ef6-e1155bcfa6cmr351533276.55.1723573294857; Tue, 13 Aug 2024
 11:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhQpX-nnBd_aKTg7BxaMqTUZ8juHUsQaQbA=hggePMtxcw@mail.gmail.com>
 <873b04da-7a1e-47b9-9cfd-81db5d76644d@roeck-us.net> <CAHC9VhTd0MKVXsZ7J_b_Mmr2vP+RMJtxzfsgpH1rZ_hoHY1D3A@mail.gmail.com>
 <779dfb7f-d690-432e-8461-b26935974ac6@roeck-us.net> <0673d2b2-ad78-46f4-93b2-73ea3acd70f7@roeck-us.net>
 <CACYkzJ63DRLtDy6DAsGhz8_mM1pUSaC-DjbCtTBtEMP0c-=yRg@mail.gmail.com>
 <d9fc949a-6945-4c41-83de-c3717d536c15@roeck-us.net> <CAHC9VhRGt-b8PmtR-hZwOWB1zfmuhfftoppjacqrjq60tm0mag@mail.gmail.com>
 <8061553f-6bfc-4ee6-a8f1-e3741cf5ae6c@roeck-us.net> <CAHC9VhSKzxknTgKQu6ODoyxhc3skcjh_h11wSQrEvWb_vP5Ziw@mail.gmail.com>
 <CACYkzJ6NuGQchRaj-QD_XzQWNT8c3zb0ZEBXWjzjAckQdNDCWw@mail.gmail.com>
 <CAHC9VhQjCHBii=CwMMnbs0hiiN-Dy49S+3gpDvaXp-YQyEHTGw@mail.gmail.com>
 <CACYkzJ7vC7OJWdgm6LbOL82eO=27cn7Gh8i6-HOp_A94-SU-gA@mail.gmail.com>
 <CAHC9VhQPHsqnNd2S_jDbWC3LcmXDG1EoaU_Cat8RoxJv3U=_Tg@mail.gmail.com>
 <CACYkzJ5J8K2D8xqT+CCrbvp57P=GbCB+XYXkAaKXojsFhuaWEw@mail.gmail.com>
 <b3c04f8a-b7e9-4dc7-849e-aeaed508b8cf@roeck-us.net> <CACYkzJ4eZWh2R_ZoeiNLLKFARWJOWo7Hkdp015fHEnmYLJaHGQ@mail.gmail.com>
In-Reply-To: <CACYkzJ4eZWh2R_ZoeiNLLKFARWJOWo7Hkdp015fHEnmYLJaHGQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 13 Aug 2024 14:21:23 -0400
Message-ID: <CAHC9VhT+6PV+2YMfJnYn8oEzvEFDRbF-KdQTg1++N5+PD=T6-w@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
To: KP Singh <kpsingh@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bp@alien8.de, sfr@canb.auug.org.au, 
	peterz@infradead.org, ink@jurassic.park.msu.ru, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 11:56=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrot=
e:
> On Tue, Aug 13, 2024 at 6:08=E2=80=AFAM Guenter Roeck <linux@roeck-us.net=
> wrote:

...

> > A somewhat primitive alternate fix is:
> >
> > diff --git a/security/security.c b/security/security.c
> > index aa059d0cfc29..dea9736b2014 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -156,7 +156,7 @@ static __initdata struct lsm_info *exclusive;
> >    * and a trampoline (STATIC_CALL_TRAMP) which are used to call
> >    * __static_call_update when updating the static call.
> >    */
> > -struct lsm_static_calls_table static_calls_table __ro_after_init =3D {
> > +struct lsm_static_calls_table static_calls_table __ro_after_init __att=
ribute__((aligned(8))) =3D {
> >   #define INIT_LSM_STATIC_CALL(NUM, NAME)                              =
          \
>
> I think it's worth making it aligned at 8 byte, a much simpler fix
> than the arch change.

Agreed, although please make sure it is well commented about why the
alignment is important.  It sounds like that's already your plan, but
I just want to make sure we're clear on this :)

I'd also suggest using the __aligned() macro from
compiler_attributes.h instead of the long form
__attribute__((aligned(x))).

Further, while an alignment value of "8" is generally easy enough to
guess at, especially when Alpha is concerned, it might help to further
hint at the reason by using sizeof(u64), e.g.
`__aligned(sizeof(u64))`.

> Paul, I will rebase my series with these
> patches, better descriptions and post them later today.

Great, thanks.

--=20
paul-moore.com

