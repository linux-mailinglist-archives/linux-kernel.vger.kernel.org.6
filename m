Return-Path: <linux-kernel+bounces-442795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A08E9EE1F4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE207188546C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4D420E337;
	Thu, 12 Dec 2024 08:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SbEVLHWc"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05CA20E034
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733993614; cv=none; b=vGiH0JpPPxAap7OurB4pfdjset5lTCfFa+CJiX07iJhmvUfQBN1ChEsubmGwNPhdHPxdb/Ne5PebjfoHk4fWweiRgoOOUm6dX5R/pQE1ib09A5SRUtM4V9PhfF1zI1TBYx0QDTQ5LAk7prDOy/g5ioFMZjUzmzRLeOzzlv0Pw+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733993614; c=relaxed/simple;
	bh=w3b8p5pId723s8apGEqRiRPGF/XIl9RTYQEEC3QeUe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJbJUe7Cw0JhAkoiMklW4UNyI55/F/p9NYEEreqsjbSeMMc0lWqKzcDOnJepjqhuAQT66zHWGT4LxRzYdDlkmKQF9d+ALsNTFw3VqJIm2aLICyPRjbcZzLG9ZnTS31BBYnOb1Y0q/PC7vJ9HGfIFDm1wfboHTYYtz5Bv0Z0HLIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SbEVLHWc; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa5f1909d6fso54171966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 00:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733993610; x=1734598410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3b8p5pId723s8apGEqRiRPGF/XIl9RTYQEEC3QeUe4=;
        b=SbEVLHWcXutoigyl/7qXFyQbT9DylN3xupgNoOdAyxSOu7lxnUeZOm/sbZ+bAK5OMS
         RNWJDzQLkm/2cU8qndkclgdG3yWjolK81TcHofz6AaaAd7MuAciAilWXlCt25V1SQzFz
         +LSv6P56rlX8tYvBEJv1B86Eazlnfzn9sFwLy01CuzEqBYehCHairzWLZB0Y6jOXw3eY
         Z7sWw5UodWisPWnEJdra0+JSGDt8W5HMKJIigVklB9QSL4eTo3pZWTn42RlusnFC+HIl
         1Pnzp6leWr0IWIYKAoketeoqhUkHmRznLaJuive/OAyiGLamBSs17e7N6Nv9cyK+jal9
         Iurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733993610; x=1734598410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3b8p5pId723s8apGEqRiRPGF/XIl9RTYQEEC3QeUe4=;
        b=OmOXsMEkBilT/qiot24XTju+ZEXQIIb4FcFiKGKxlJ+3EO7uhD6pW7Q9x3jgPmmaI3
         JsrV8ohNfw86vVeVI82jlRCF17ccCRivYXjyW89N6Sp/B5ofKxwWt0Bn93uOjJc7rpis
         E7jyoRxylPK+UhenbBNFeXV0REMOESYBuy6A0s3XahdjHkVFHfwCydt2KkB7Mv96elGi
         QSX/9eAX9vAwlv/5b2OAMgmCGTUR7OQ4G6U995apKhBd1m9RTs2vRPfzzP9tHkc+d3B4
         FAvBomknzrNIP1sYnL1y7OZSZyaAz2jDPfntB9inMrqTmrRDm0zMA0scMyP78P4RxG7c
         v1rQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhg0vAztdkHx9wIjEjoqh9NZDoKFnUblxxEBN1yiBjsSq9vRDsY4htaG362O9pLiZHZGHB6mHhmpHhLBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpGlcoA9LAzAODqTttSxVawIb2LqBHKxnU8kw8b4XiHFig/xe4
	LC4LTQT4+/nEIDsv+Dj51zIkpwhKt5YA8VmttPGScm2/xXw9ZTIm7T85PggJzOQtLDkVbLaDLjZ
	rzQeouaZMjW/lXtfipJ63ZrNGmSWvXguQSvo2Bw==
X-Gm-Gg: ASbGncuOBkENe0xrR/34sBrc48+aCn6cZGHBHEUShC9uyetLtqW6iEaEI2sYCGPHI2a
	YmVBDHvQ/SnYb7A7nbiVeiCdVMcmQJYu4oENg
X-Google-Smtp-Source: AGHT+IGfU6rtOHJOHdj57SSVfLI9f6Fq/2KuTXoPZHJiIsnpZhdomXumhthcwf+ID3geTKkQc3OpcXoAOkvCd9M9EK8=
X-Received: by 2002:a17:907:b8f:b0:aa6:a9fe:46e5 with SMTP id
 a640c23a62f3a-aa6b13d1a29mr485360666b.53.1733993610333; Thu, 12 Dec 2024
 00:53:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212075303.2538880-1-neelx@suse.com> <ac4c4ae5-0890-4f47-8a85-3c4447feaa90@wdc.com>
In-Reply-To: <ac4c4ae5-0890-4f47-8a85-3c4447feaa90@wdc.com>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 12 Dec 2024 09:53:19 +0100
Message-ID: <CAPjX3FcAZM4dSbnMkTpJPNJMcPDxKbEMwbg3ScaTWVg+5JqfDg@mail.gmail.com>
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

On Thu, Dec 12, 2024 at 9:35=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 12.12.24 09:09, Daniel Vacek wrote:
> > Hi Johannes,
> >
> > On Thu, Dec 12, 2024 at 9:00=E2=80=AFAM Johannes Thumshirn
> > <Johannes.Thumshirn@wdc.com> wrote:
> >>
> >> On 12.12.24 08:54, Daniel Vacek wrote:
> >>> While testing the encoded read feature the following crash was observ=
ed
> >>> and it can be reliably reproduced:
> >>>
> >>
> >>
> >> Hi Daniel,
> >>
> >> This suspiciously looks like '05b36b04d74a ("btrfs: fix use-after-free
> >> in btrfs_encoded_read_endio()")'. Do you have this patch applied to yo=
ur
> >> kernel? IIRC it went upstream with 6.13-rc2.
> >
> > Yes, I do. This one is on top of it. The crash happens with
> > `05b36b04d74a` applied. All the crashes were reproduced with
> > `feffde684ac2`.
> >
> > Honestly, `05b36b04d74a` looks a bit suspicious to me as it really
> > does not look to deal correctly with the issue to me. I was a bit
> > surprised/puzzled.
>
> Can you elaborate why?

As it only touches one of those four atomic_dec_... lines. In theory
the issue can happen also on the two async places, IIUC. It's only a
matter of race probability.

> > Anyways, I could reproduce the crash in a matter of half an hour. With
> > this fix the torture is surviving for 22 hours atm.
>
> Do you also have '3ff867828e93 ("btrfs: simplify waiting for encoded
> read endios")'? Looking at the diff it doesn't seems so.

I cannot find that one. Am I missing something? Which repo are you using?

--nX

