Return-Path: <linux-kernel+bounces-219646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC86B90D601
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49C74286ED0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD1515B15B;
	Tue, 18 Jun 2024 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WlSGIjgn"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132F9158D99
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718721768; cv=none; b=MU1z0GWIWdn83XSMxfgMaBlWy+AOftAJkvfhy1BwgREqGsF7inFcQpKf0/VQxLsklemKYowdq07DgfcAYQnevIn32Hb1rNI+s8lCP+SDvZqcvfLhC8iN7JUgAOaND3IT8Olz6iHFZotgxrbetdMQzwgUOechjgI8wcQgDUAjJzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718721768; c=relaxed/simple;
	bh=NXi93RHwbSOV2Q0lAqG0v6/Wr5YQ9AqTGkNCwpCWTe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mwNi6npvsYTmL1RpKbEBkchKldExJVwUfvujwxcs/rMxyZXZiywgXAnqjAzRWlk4KK1uvCK9r8LFWWjQUWdc4JvsrA8f0wogNvV+m/UpKM1G4P/2hoZozPEDa4UMQpdHGy4DGNZYSfCbG3lGm0PWOxxApLB8AJ2myyUkBWq6lb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WlSGIjgn; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-44051a92f37so44974321cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718721765; x=1719326565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mf9vRDQj5buX/JWcYXzCfiraRviKrpzpPs7rdFb3Wds=;
        b=WlSGIjgnVu2h/YL83xQ0V9vicTteYBmiT7suLM580lI3GeUi8HgcHPV/cTH6m84Gme
         FEcRPqMnKSEl0L/D6fP57vwx7RY67hwJ2EEem+wSMPDL779iuQptv8mhluWtPY9tJQLA
         R7CjAtBM/gExg870lyRy40xxrzgAT5t8tDl1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718721765; x=1719326565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mf9vRDQj5buX/JWcYXzCfiraRviKrpzpPs7rdFb3Wds=;
        b=ZEFZ9nnBi9fIF+BLudmzNkRWr7R5JbMeBukMTSz1fKW15d0M6Q+NMF/cxJmlzSAT3B
         l2xo5SIbvxuqkmVZrp1wt7IxBLXue5Be6Y+SGWsjbUMewZzcGbaBpVqQxFqdxvUurmWL
         9tEilFoZ3F41BJ2EiY1VSVYT4aJgAiGZGAJ0FolYqQei3LGz87YJ0NbRVxkdHTOwSL4l
         LMMgLY+20P8eJvP9IxQNZBlAF0Gg7JVjVSD1y5/UN/5LJEkONsSOnbaNy2HDx7I1W9iO
         DzSNaEwZX1FLaZl28zLS1j1xuoQMNJgqTWfiFXSx3shqJIjpqrR99m2k7dMagOxT3YnI
         6taA==
X-Forwarded-Encrypted: i=1; AJvYcCXq5aVxSW6u6ih0utFwmfPXvU0fJSqqLlqewU56vmYF9FaXoU9JzD9jpaGLuGyFC6RsLFCxdMiIt+3PnzDf3xY+KPVLSfUJtFrl7Ylz
X-Gm-Message-State: AOJu0YxUpIurTf2yFFTM/CDIfpPOYP1IvYeBpEKAGgMg2iykpHZ3+haZ
	hj880e3aXiQQ8nyaLR8qyt+Cvmx0ho9Gom5yOsIfEwNx2gkVkwyXqNUAfF5r0ncydqiPaRqFG+A
	=
X-Google-Smtp-Source: AGHT+IEm6IbulDTE1svAVO40UvUE8Xw0rYsY3e4ltHNeUcUIV6DAfdno5Vg20hfgW40ddVsySb1LMg==
X-Received: by 2002:a05:622a:110b:b0:444:a44d:10bb with SMTP id d75a77b69052e-444a7846a84mr1708441cf.4.1718721764693;
        Tue, 18 Jun 2024 07:42:44 -0700 (PDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441f30f427dsm55991391cf.92.2024.06.18.07.42.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 07:42:44 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-443586c2091so474051cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:42:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjNY/rRhYUYS+L+d7ZkV9dcn/25ErAJQz7dZVRYCb8AhhO/Y73mlMpSBL4NIl4/0NNBjZ797kcGWUa46QhTd8/PmftXvbnEVaEiV7w
X-Received: by 2002:a05:622a:15cd:b0:43e:295:f160 with SMTP id
 d75a77b69052e-4449c71abfdmr3212491cf.24.1718721763326; Tue, 18 Jun 2024
 07:42:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618003546.4144638-1-dianders@chromium.org>
 <20240617173426.6.Ia1d546061f9430a90df0e7521097040e0e939c58@changeid> <20240618113754.GD11330@aspen.lan>
In-Reply-To: <20240618113754.GD11330@aspen.lan>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 18 Jun 2024 07:42:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X6kzg4ySwWtTQkatNmSJAFpWYZqJuc_p7e+BjXz0zNhg@mail.gmail.com>
Message-ID: <CAD=FV=X6kzg4ySwWtTQkatNmSJAFpWYZqJuc_p7e+BjXz0zNhg@mail.gmail.com>
Subject: Re: [PATCH 06/13] kdb: Remove "mdW" and "mdWcN" handling of "W" == 0
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: kgdb-bugreport@lists.sourceforge.net, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Jason Wessel <jason.wessel@windriver.com>, 
	Thorsten Blum <thorsten.blum@toblux.com>, Yuran Pereira <yuran.pereira@hotmail.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 18, 2024 at 4:38=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Jun 17, 2024 at 05:34:40PM -0700, Douglas Anderson wrote:
> > The "mdW" and "mdWcN" generally lets the user control more carefully
> > what word size we display memory in and exactly how many words should
> > be displayed. Specifically, "md4" says to display memory w/ 4
> > bytes-per word and "md4c6" says to display 6 words of memory w/
> > 4-bytes-per word.
> >
> > The kdb "md" implementation has a special rule for when "W" is 0. In
> > this case:
> > * If you run with "W" =3D=3D 0 and you've never run a kdb "md" command
> >   this reboot then it will pick 4 bytes-per-word, ignoring the normal
> >   default from the environment.
> > * If you run with "W" =3D=3D 0 and you've run a kdb "md" command this
> >   reboot then it will pick up the bytes per word of the last command.
> >
> > As an example:
> >   [1]kdb> md2 0xffffff80c8e2b280 1
> >   0xffffff80c8e2b280 0200 0000 0000 0000 e000 8235 0000 0000   ...
> >   [1]kdb> md0 0xffffff80c8e2b280 1
> >   0xffffff80c8e2b280 0200 0000 0000 0000 e000 8235 0000 0000   ...
> >   [1]kdb> md 0xffffff80c8e2b280 1
> >   0xffffff80c8e2b280 0000000000000200 000000008235e000   ...
> >   [1]kdb> md0 0xffffff80c8e2b280 1
> >   0xffffff80c8e2b280 0000000000000200 000000008235e000   ...
> >
> > This doesn't seem like particularly useful behavior and adds a bunch
> > of complexity to the arg parsing. Remove it.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  kernel/debug/kdb/kdb_main.c | 5 -----
> >  1 file changed, 5 deletions(-)
> >
> > diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> > index c013b014a7d3..700b4e355545 100644
> > --- a/kernel/debug/kdb/kdb_main.c
> > +++ b/kernel/debug/kdb/kdb_main.c
> > @@ -1611,11 +1611,6 @@ static int kdb_md(int argc, const char **argv)
> >
> >       if (isdigit(argv[0][2])) {
> >               bytesperword =3D (int)(argv[0][2] - '0');
> > -             if (bytesperword =3D=3D 0) {
> > -                     bytesperword =3D last_bytesperword;
> > -                     if (bytesperword =3D=3D 0)
> > -                             bytesperword =3D 4;
> > -             }
> >               last_bytesperword =3D bytesperword;
> >               repeat =3D mdcount * 16 / bytesperword;
>
> Isn't this now a divide-by-zero?

Dang, you're right. It goes away in a later patch, though, since we
stop re-calculating everything until the end when things are
validated. I'll plan to reorder this patch to be after the patch
("kdb: In kdb_md() make `repeat` and `mdcount` calculations more
obvious").

