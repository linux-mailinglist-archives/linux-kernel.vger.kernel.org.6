Return-Path: <linux-kernel+bounces-416383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9759D4408
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3555D2833C6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 22:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DDC1B85C1;
	Wed, 20 Nov 2024 22:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OSfNlOpw"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D6B16EBEE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 22:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732143062; cv=none; b=mtjSDY910r1VVa2vxtqQDW2r6pG6+unKh3kcGnOU4P+4WrnGVnn/IfyKgVUwR9ks4EWg+ykwn8ExfuB2ggS82TRtH2v2HRUKqsiTyeevKChx96QwCHzizKujkZ2a+RTgECF1H1Rs5s0buYQcj5LDRS4et7Izyb5BWhXqIDsffZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732143062; c=relaxed/simple;
	bh=Xq4pUH5YC7kT8weuS7XEdmvcmkSfjecyf3TuJ1rriAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HILgsM814bzsPkP0lXzaknrxXaIUZAFwd6RUleA6ccvyRxhGZNJWhMKokh9S9oGRbsMeAXiC2K92l2MlL3gkgQIUXVlg/HJk6i7eXK5oyOwsYHdDrfNGc+yEdwyPxBZcI6GrY0zvE8DjCmlJr5sVJcdufC+IyNDlxgsyxVhcY7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OSfNlOpw; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a6acac4c3so48434366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 14:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732143058; x=1732747858; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QS2ar3tEHnDP8Hb1PCxc6yuUPXwMY0RHaGXUCLtQX3I=;
        b=OSfNlOpwOW/UNAu6jNnNPjQi/B7hc8M6V9JidrHav6srrjVxoVe/zXsTxOXNKluNxd
         dalQa7GnQJrPLqpb65pHwZQUMj8atoLN7g2WR1PJ69eTmlUXUWxMKv2ZoHpxxngDuacc
         L0h0j7eqOwnchcHbWJ/rDf02gErG5dZF0NXC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732143058; x=1732747858;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QS2ar3tEHnDP8Hb1PCxc6yuUPXwMY0RHaGXUCLtQX3I=;
        b=wQz2L4Yd+zqzj6pUqZtsb5pJCE2cCLPVsaqLxvcCygCjd7Bo7acGu+tU9DVGdKmmMH
         8XQd2b1/6ylA0ynOqEMPhZCrQuNS42EDGqY2wlsiSCT0zNr7ngzELNSrmEQFuTNi9dX3
         FtWfGyYN+jjsJGLqCd+b2o1WtXc1k0adJRQxrcNtasQj4uzu0eZZVycxW1hcVDd54owE
         KAGz5lGIV9fvhNoPq2zdTOG1XQrc9vWQCu45SdNqM9Qy8F9BsCiB1Tg+I3juyHSfDv/C
         b635ydjkBZaP3rqzSqFIVy5/jlRFXviSifjRirrlPVJPkNX0/zFheOPB6+JfVu8Fy3dy
         ckQw==
X-Gm-Message-State: AOJu0YzV9YW1xNmVp1fhKuZ9GT2S0jSTUaixYOzVDN7TFvxM3xUAGvgb
	rdmjS6mtYBtDvZoTY+CAk4NiuAfquWrG3iy92KMFzjU3niAayvIVV7csRRky67dB0CYKZseD60L
	8M4P4tA==
X-Gm-Gg: ASbGncvl/h4phUZ03TNGWcXmSpQ2gVjsVPZNMSCSOa7nGnKh9lqhTwuCDnRBsn2GF/H
	t0WkdZjaIIdc88PcVMP9G0qlKDzZJBSq/KpTb/pllCXE3eF+5G4pKxfK4N5A/KYrc+GoUb5XVy+
	EtAmGVNgb4kXkPwKkNcW8dtCbar1QSKJdRN+vTZG85Y299KI+xwJ4asCjucykfMIoChupVLSxG+
	NerzRrGwJ0AD1Dy4aB6eldKxR6FJ28C0j/oTPIbDdfdOXpmDZPz00BB2vlaPI9Hh0UxTd0HeCVQ
	QMe7YK4CQrPp+Z4xZWgMr3/K
X-Google-Smtp-Source: AGHT+IHG/hYhwh5jHN14EZkHs7cLBCWITzgjwPYGCxDtoMBB1zgyCRBsW1AsvVs2whbFupaLBsnxLQ==
X-Received: by 2002:a17:907:7e91:b0:a99:e4a2:1cda with SMTP id a640c23a62f3a-aa4dd74c86bmr456401166b.56.1732143058117;
        Wed, 20 Nov 2024 14:50:58 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f4318900sm8467166b.139.2024.11.20.14.50.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 14:50:56 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a99f3a5a44cso38843366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 14:50:56 -0800 (PST)
X-Received: by 2002:a17:906:dac2:b0:a9e:45e6:42cb with SMTP id
 a640c23a62f3a-aa4dd55226emr507639866b.18.1732143055922; Wed, 20 Nov 2024
 14:50:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411190900.FE40FA5@keescook> <CAHk-=wgB1L75+C89AU62n4jBEiwKs=e4dvBDOoLQ13rUwJLFXQ@mail.gmail.com>
 <CAHk-=wjPpuThc4Wbtk-aUz4buUSH9-gvsmjT5P3=2tU_Kz8oVA@mail.gmail.com>
In-Reply-To: <CAHk-=wjPpuThc4Wbtk-aUz4buUSH9-gvsmjT5P3=2tU_Kz8oVA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 20 Nov 2024 14:50:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh4k8ks_oq4v=LXxidXZ+r-_er7cORjNzySjDaD8Xc9ng@mail.gmail.com>
Message-ID: <CAHk-=wh4k8ks_oq4v=LXxidXZ+r-_er7cORjNzySjDaD8Xc9ng@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.13-rc1
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Dan Carpenter <dan.carpenter@linaro.org>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Nir Lichtman <nir@lichtman.org>, 
	syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com, 
	Tycho Andersen <tandersen@netflix.com>, Vegard Nossum <vegard.nossum@oracle.com>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Nov 2024 at 14:33, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 20 Nov 2024 at 14:32, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > People: we *have* a filename. It's right there in the dentry. Which is
> > right there as bprm->file->f_dentry.dentry.
>
> ... that should obviously be '...->f_path.dentry'.

One thing to look out for is that dentry->name can be switched around
by renames etc

So you probably want to do something like

        const char *name = smp_load_acquire(&dentry->d_name.name);

under the RCU read lock before then copying it with strscpy(). It
should always be NULL-terminated.

If you want to be extra careful, you might surround it with a

        read_seqbegin_or_lock(&rename_lock, &seq);

        ..

        if (need_seqretry(&rename_lock, seq)) {
                seq = 1;
                goto restart;
        }
        done_seqretry(&rename_lock, seq);

but I seriously doubt we even care that much. If people want to mess
with the executable filename, they can just use links or whatever, so
this is a "politeness" thing rather than anything else.

(And yes, our d_path() code tries to be extra smart and also uses
'name->len' to avoid having to search for the end of the string etc,
but that then causes huge complexities with ->len and ->name not
matching, so it has to compensate for that with being extra careful.
So don't do that)

                     Linus

