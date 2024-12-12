Return-Path: <linux-kernel+bounces-442808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A419EE23F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A70ED28291F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E6920E31F;
	Thu, 12 Dec 2024 09:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UY9zbmE1"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE271D8E10
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 09:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733994499; cv=none; b=gs7v0346EvZt9cwwUEV7kZIPeqOTTgnnYB2JPgEYoOgpXfVs/ookKf16vp78DP54uSvqoDExr89G39JvKYyGXPE5kDeEsvWzuB1MzDYXLTiuDrvVnSNaN7zTmPU7akFmwz7UnnsaQfWyP5FkDE1ZWoXq2A0KF1FcAeNT44L6uGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733994499; c=relaxed/simple;
	bh=7mkNhNohCRInUoNEgtBbSXisKCJhOCIqilr1bctY9qQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D2jl0vo9R9TYK9vxuqrymWwJ80QdC8ZoWy9+JQRP3wBUwKS66ntJVKOKd8mlNlkM0jzC8ttxfbrvwgZsIZmoFPKkJd754V/2B+6sOx1mFJ7JPU+g5mNXnMHUZg+P5q5MMml3OPCWsnFxXQl405I/Jmvd4Cz9ac1sCBYXCaW6EpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UY9zbmE1; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so67546066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 01:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733994496; x=1734599296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qy+XHWudhy1v5FQx+HPpD7u/EehmML+tWjPRArge5Pk=;
        b=UY9zbmE1ruDn0cJyFk3s5No7MYdK40/t7SxvnC0MbCorrBZCJk2K+oWpMH3G1NxKS0
         cX6BGCqyM8v0c4ssk88tKeAHa8QzRZBCYEuxT36YQDNH7duWdGbIxV9JHm+nKWbNqnoR
         w/MMliVYdcnIRiKeMEOp52K2zSSpyPvLjYBohIcRjDskjaAOArp7UrAQEcmJ1yUrwGEB
         VeMk1viVs/9XQ+0h4Yc8byYxMoW4BDm5f/XDtkuiwahXxn4oUZBuTniVYArtQUIt+ngw
         V2nsceY40jsbupLgK0co4IncKIpSQkN3zl/S+ZojF5d81o4NboWsEbMwdihwIuEzSRhX
         ogPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733994496; x=1734599296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qy+XHWudhy1v5FQx+HPpD7u/EehmML+tWjPRArge5Pk=;
        b=f/Ih34nPc4Cn7Jh7lEZll9VS7RpWab9F/cd15r8XlEtclohk+d0/uJ16S75l9Hlafp
         OQcO6oRruXrNgaX1KKE+L/H2dcBo+TKfo2B0KC2V0/pfl1GvuGEeUz9+80Zz1N9VS70B
         YZdYyt/4opZ4vfpdyTAs6IlYBnmz8ffgtoGnHN/Nj4MwoqesW8s5+tF/VsEUFOKfkX/I
         +69FQfO2GMCiC5rYhdyQHVfhLtwNouP4Nssa/ryRriIJUy4sz2WWzmQm7g4OAQAestjl
         NTLAWq/TpXNPbCsYxaRIqHrBUpkEK6df7UGEc3WMHXZijOaY+qMdbXsAXPIWJQFBYpiY
         4qQw==
X-Forwarded-Encrypted: i=1; AJvYcCW6d740qtd+PL4RRBs/lVzsLtprIKdR9LXILds/tOWMZZk65uQD45/SBsRxzsM5ed9mJpQ4gqmk0L8phr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv8fHK4BgG1MfQtdKTTraLURFAF9c2jF1TGYwvWQCGJz1Jmgvz
	5sQsY01YHMkIt1AmYdQQoZB8CO03sfEOBJl8Pd0rF5wUHYvL1eeqdQXqtOTUfpw54vJNualo1O1
	GQuc3CyfZRHKgDymzfzwdvYvXfuuCilAjL9uR9Q==
X-Gm-Gg: ASbGncubvMO731BiCItcFRbMstVIG/oQ/pQXyfiAw8Hlp+eGVslh/pxolmygF4u7zov
	vqr9ZVI/Cv8gumpJl97ttGJWAET3xmHvyNLM/
X-Google-Smtp-Source: AGHT+IHEeJ3cn9fsQUrmcRwGKGFNz+w9xyhYxVnY2x3y6VbhboijLIDasxIc1jaQaLdp8+eNSrWDe+me41Cfc3kAJW0=
X-Received: by 2002:a17:906:2929:b0:aa6:8096:204d with SMTP id
 a640c23a62f3a-aa6b1141caamr537934766b.3.1733994496399; Thu, 12 Dec 2024
 01:08:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212075303.2538880-1-neelx@suse.com> <ac4c4ae5-0890-4f47-8a85-3c4447feaa90@wdc.com>
 <CAPjX3FcAZM4dSbnMkTpJPNJMcPDxKbEMwbg3ScaTWVg+5JqfDg@mail.gmail.com> <133f4cb5-516d-4e11-b03a-d2007ff667ee@wdc.com>
In-Reply-To: <133f4cb5-516d-4e11-b03a-d2007ff667ee@wdc.com>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 12 Dec 2024 10:08:05 +0100
Message-ID: <CAPjX3FchmM24-Afv7ueeK-Z1zBYivfj4yKXhVq6bARiGjqQOwQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix a race in encoded read
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Omar Sandoval <osandov@fb.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 10:02=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 12.12.24 09:53, Daniel Vacek wrote:
> > On Thu, Dec 12, 2024 at 9:35=E2=80=AFAM Johannes Thumshirn
> > <Johannes.Thumshirn@wdc.com> wrote:
> >>
> >> On 12.12.24 09:09, Daniel Vacek wrote:
> >>> Hi Johannes,
> >>>
> >>> On Thu, Dec 12, 2024 at 9:00=E2=80=AFAM Johannes Thumshirn
> >>> <Johannes.Thumshirn@wdc.com> wrote:
> >>>>
> >>>> On 12.12.24 08:54, Daniel Vacek wrote:
> >>>>> While testing the encoded read feature the following crash was obse=
rved
> >>>>> and it can be reliably reproduced:
> >>>>>
> >>>>
> >>>>
> >>>> Hi Daniel,
> >>>>
> >>>> This suspiciously looks like '05b36b04d74a ("btrfs: fix use-after-fr=
ee
> >>>> in btrfs_encoded_read_endio()")'. Do you have this patch applied to =
your
> >>>> kernel? IIRC it went upstream with 6.13-rc2.
> >>>
> >>> Yes, I do. This one is on top of it. The crash happens with
> >>> `05b36b04d74a` applied. All the crashes were reproduced with
> >>> `feffde684ac2`.
> >>>
> >>> Honestly, `05b36b04d74a` looks a bit suspicious to me as it really
> >>> does not look to deal correctly with the issue to me. I was a bit
> >>> surprised/puzzled.
> >>
> >> Can you elaborate why?
> >
> > As it only touches one of those four atomic_dec_... lines. In theory
> > the issue can happen also on the two async places, IIUC. It's only a
> > matter of race probability.
> >
> >>> Anyways, I could reproduce the crash in a matter of half an hour. Wit=
h
> >>> this fix the torture is surviving for 22 hours atm.
> >>
> >> Do you also have '3ff867828e93 ("btrfs: simplify waiting for encoded
> >> read endios")'? Looking at the diff it doesn't seems so.
> >
> > I cannot find that one. Am I missing something? Which repo are you usin=
g?
>
> The for-next branch for btrfs [1], which is what ppl developing against
> btrfs should use. Can you please re-test with it and if needed re-base
> your patch on top of it?
>
> [1] https://github.com/btrfs/linux for-next

I did check here and I don't really see the commit.

$ git remote -v
origin    https://github.com/btrfs/linux.git (fetch)
origin    https://github.com/btrfs/linux.git (push)
$ git fetch
$ git show 3ff867828e93 --
fatal: bad revision '3ff867828e93'

Note, I was testing v6.13-rc1. This is a fix not a feature development.

--nX

> Thanks,
>         Johannes

