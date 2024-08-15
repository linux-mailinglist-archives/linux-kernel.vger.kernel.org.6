Return-Path: <linux-kernel+bounces-288658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91398953D32
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 00:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D62A3B2463A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 22:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D5A154C07;
	Thu, 15 Aug 2024 22:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="El6QmRwZ"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75261547DE
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 22:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723759884; cv=none; b=Y3AEsVMZiB/Tlh9W0hcwxBqJlxZPuZMPNSvjRID3DspsMwF+HxKIm7DEyHdk5GQns+1MW+ckkYkGOIMuXJ8gyREusjW/0ERUwXLSEy1EYoGR/4V0VSzjxMJKqNuEnwk0MVgP0nusVeyrDN0I1PSh8cwoIMhcvpTsuF2loSqfbI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723759884; c=relaxed/simple;
	bh=OUrB7jjq0zzcJBlRNS5gBbkoim1wQkYk3hv5MCVg2jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EwTMgx0iJ130GR8HAxWkHpBoTgvrrANm/qJ+fZlRrCJ4qcnsc3lDueaEqkym99IE1YKcEVJfnZkl8hsomiHvYXXh2E+qCDjgzgi0rNfXZYsLawerDH88PhIOhXCNhhWu7PYW/HLbW3BPcqz7t5ZjZd7+k0qAxPH5PbEMhB8pJ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=El6QmRwZ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5bec507f4ddso2792a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 15:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723759881; x=1724364681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0EbhLIoeNQ2r+xrZ9UdYSTABXF+0gbcRVGeJ3HRC5U=;
        b=El6QmRwZjMbszOdQrKGOyaQhjWzVwtfA3x0BU/TWnfb5OFnlpv9HylMSxHJIICfISh
         NCD1OoplTRM8KClLAPUgvHnnjC0LqiiANTwdgNKQC4C4200zht8/mq67v3gc4V1begsO
         0fFhe0wy4fOmOoTXaI8gM2jo4w248iCcrbTDA8RGVfBAWbQutuieYYb+Tu4niZlvewtM
         Rcx4S1+cM8AExiKEFlUdL5kwecMrs9jaCT8/oc8/8w0G7AnE/6w1k1iNuk9xGHehJjsw
         1ycm0/mKPJjqN+tR6pOil0x2o3FAgBHd7JxO3EapGIR9zOr7Ol8lEXL4cJ6JvysJ2kA8
         WTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723759881; x=1724364681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0EbhLIoeNQ2r+xrZ9UdYSTABXF+0gbcRVGeJ3HRC5U=;
        b=l5qVOvULrXwPfQamvUi+7g1bD3HCaJ4fVjkOowcFNuZFz02hdrVCDOthf2/N8pjVOd
         GUxGmdrs44xQ0pVZMzSm9bFEMCL/dGu3h5SMiRzhwkfUIsLmNK5VshaNZFNE5EAIGBZ6
         /6GxbFy295Tv6Uau8UH5tHq34hgTYjYop1GqhJXLlcXqgkYfkLbdVH4qSsO3yFDEqzQO
         PPBp4OWVGhnj7N9APxjk9PXAngg4ulpa3TJTFRONxPSuSFGN2FbSG3T/9Q4nKn4vDFMz
         E7/1jt/tukR/3xlFfvGIpxTzNklVhW7GZa9dBC9GBvAmEksNgWVzDrUVrIEFZFojO35E
         bD2g==
X-Forwarded-Encrypted: i=1; AJvYcCWg9VZ9Izu4gGkhPhyD4uDVKWX2U8NtQO1xrL2w0WklVcBJN/UTcZJINHQv+dpHysUO041wjUMSqXR5eTImY2lt3Ih86zvsFbZ5pBZ6
X-Gm-Message-State: AOJu0YwL/4/le/rjnkYvhlO88ajl9NqYVnkcEHpPcNbaJ+DFwccCiVE5
	Wr/M13r3lDLFGLoggNvxBDUtki7I28ygaLuD0zOsM7KKUcWtXFn4/cJp2eeC1l03t0Ggx/1nHXS
	grBYnG5sFE52GtQ4dOFnTUnCCdmuKOUZ1DB0aSD0ZS+009YLZhgxHMro=
X-Google-Smtp-Source: AGHT+IHnL6ZPj0JywgJ6DAhMXWPxpocgbzFPs+YcLitYohDgiihNIv3VjQgAC2NO/FExipns+1pkK+rBnkU66YasC0c=
X-Received: by 2002:a05:6402:280d:b0:5be:9bb0:1189 with SMTP id
 4fb4d7f45d1cf-5becb3e5a03mr28885a12.2.1723759880647; Thu, 15 Aug 2024
 15:11:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1723680305.git.fahimitahera@gmail.com> <d04bc943e8d275e8d00bb7742bcdbabc7913abbe.1723680305.git.fahimitahera@gmail.com>
 <CAG48ez2Sw0Cy3RYrgrsEDKyWoxMmMbzX6yY-OEfZqeyGDQhy9w@mail.gmail.com> <Zr5y53Bl6cgdLKjj@tahera-OptiPlex-5000>
In-Reply-To: <Zr5y53Bl6cgdLKjj@tahera-OptiPlex-5000>
From: Jann Horn <jannh@google.com>
Date: Fri, 16 Aug 2024 00:10:44 +0200
Message-ID: <CAG48ez1PcHRDhRjtsq_JAr5e6z=XNjB1Mi_jjtr8EsRphnnb2g@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] Landlock: Adding file_send_sigiotask signal
 scoping support
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, mic@digikod.net, gnoack@google.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bjorn3_gh@protonmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 11:28=E2=80=AFPM Tahera Fahimi <fahimitahera@gmail.=
com> wrote:
>
> On Thu, Aug 15, 2024 at 10:25:15PM +0200, Jann Horn wrote:
> > On Thu, Aug 15, 2024 at 8:29=E2=80=AFPM Tahera Fahimi <fahimitahera@gma=
il.com> wrote:
> > > This patch adds two new hooks "hook_file_set_fowner" and
> > > "hook_file_free_security" to set and release a pointer to the
> > > domain of the file owner. This pointer "fown_domain" in
> > > "landlock_file_security" will be used in "file_send_sigiotask"
> > > to check if the process can send a signal.
> > >
> > > Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> > > ---
> > >  security/landlock/fs.c   | 18 ++++++++++++++++++
> > >  security/landlock/fs.h   |  6 ++++++
> > >  security/landlock/task.c | 27 +++++++++++++++++++++++++++
> > >  3 files changed, 51 insertions(+)
> > >
> > > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> > > index 7877a64cc6b8..d05f0e9c5e54 100644
> > > --- a/security/landlock/fs.c
> > > +++ b/security/landlock/fs.c
> > > @@ -1636,6 +1636,21 @@ static int hook_file_ioctl_compat(struct file =
*file, unsigned int cmd,
> > >         return -EACCES;
> > >  }
> > >
> > > +static void hook_file_set_fowner(struct file *file)
> > > +{
> > > +       write_lock_irq(&file->f_owner.lock);
> >
> > Before updating landlock_file(file)->fown_domain, this hook must also
> > drop a reference on the old domain - maybe by just calling
> > landlock_put_ruleset_deferred(landlock_file(file)->fown_domain) here.
> Hi Jann,
>
> Thanks for the feedback :)
> It totally make sense.
> > > +       landlock_file(file)->fown_domain =3D landlock_get_current_dom=
ain();
> > > +       landlock_get_ruleset(landlock_file(file)->fown_domain);
> > > +       write_unlock_irq(&file->f_owner.lock);
> > > +}
> > > +
> > > +static void hook_file_free_security(struct file *file)
> > > +{
> > > +       write_lock_irq(&file->f_owner.lock);
> > > +       landlock_put_ruleset(landlock_file(file)->fown_domain);
> I was thinking of if we can replace this landlock_put_ruleset with
> landlock_put_ruleset_deferred. In this case, it would be better use of
> handling the lock?

I don't think you have to take the "file->f_owner.lock" in this hook -
the file has already been torn down pretty far, nothing is going to be
able to trigger the file_set_fowner hook anymore.

But either way, you're right that we can't just use
landlock_put_ruleset() here because landlock_put_ruleset() can sleep
and the file_free_security hook can be invoked from non-sleepable
context. (This only happens when fput() directly calls file_free(),
and I think that only happens with ->fown_domain=3D=3DNULL, so technically
it would also be fine to do something like "if (domain)
landlock_put_ruleset(domain);".)
If you test your current code in a kernel that was built with
CONFIG_DEBUG_ATOMIC_SLEEP=3Dy, this will probably print an warning
message in the kernel log (dmesg). You're right that using
landlock_put_ruleset_deferred() instead would fix that.

I think the right solution here is probably just to do:

static void hook_file_free_security(struct file *file)
{
  landlock_put_ruleset_deferred(landlock_file(file)->fown_domain);
}

Alternatively it would also work to do this - this code is probably a
bit more efficient but also a little less clear:

static void hook_file_free_security(struct file *file)
{
  /* don't trigger might_sleep() for tearing down unopened file */
  if (landlock_file(file)->fown_domain)
    landlock_put_ruleset(landlock_file(file)->fown_domain);
}

>
> > > +       write_unlock_irq(&file->f_owner.lock);
> > > +}

