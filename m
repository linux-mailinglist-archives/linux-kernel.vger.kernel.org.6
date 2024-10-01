Return-Path: <linux-kernel+bounces-346221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 794BC98C155
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0528F1F22C63
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41491C9EB7;
	Tue,  1 Oct 2024 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S1OfRk18"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27E31C9EA8
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727795694; cv=none; b=uLtGgGZ1yBGSr3/S30i2BsemmjIeTWGe2sXDwh/UqjNT7lF95wBgPrBdBXZ4/clZASM+qkMlvqsyxI2SNivvZd6PHP/3J+LA5fqpim8BrQcY0w3q3rGwCEKk4YvPgM5YxlDpOWxE5Uzqd2JUnx1fX8ZEDbehERPB5sGI2PcXIw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727795694; c=relaxed/simple;
	bh=K7etQLbsdRPA9ww2bgOCB4P1qo2jzjsVUWz7e6BZbX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mBWBPQttLKxfa7vd/6/ofA7uViqK54BW+Mk8cAPDr0viBrxWVDqc5NJwYlARRztx8gTU+F6bkDX5hD48paBqhB/DR8pZbZAmxO+jWyt2zG1Q/5y5EoFYcedzZaZy15A2h/sTg3rbl10vtHf+ueFjbcXcadMQCc0PxMk3394F3sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S1OfRk18; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71b070ff24dso5050209b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 08:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727795692; x=1728400492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXk/gs0HYEU1ezw3ww3vXkMichEEjYvt1gYwWCgyPCc=;
        b=S1OfRk18+pPseAcyuu5l5U+E4eYU2t0YnJNd7ELnZ3qK2ssbxJWKaBSsD1pHm8r67o
         u94evu8R2xSNeejesh8ONH1mIJcz58laE0SVvyD/nKbB10OlflkLHxxKfh9M205+ik9H
         ftYzfvdbWsejWpQQ52DxCxG7yKeR9KRtf1arw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727795692; x=1728400492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXk/gs0HYEU1ezw3ww3vXkMichEEjYvt1gYwWCgyPCc=;
        b=ACdkyhht6Xu3X41XngKW2bzdzLLjZNjjDSlSRGT/DqtFFUwWBjlGjYUDgjwBkMiyRE
         75ioaOU2h3EApCnk6YzD4q1m5NzYJK6CvgsDhpxdxdsGxK23+tZLZ++/AkqgoFfwf6bG
         tYss3mOwQwIcmV94HMuFS7mSkeuZhiwt8o8E+UXnWM1tYBt5qA0gnC6/ClSTxjQV7fJi
         srCkpafuNJhhxz9lyeWU5VI+N4lZA5fj+fMWthG6dnj+NwREy5UMwdCWHt6hVPGqj+WQ
         Os3XZn5gCmhXmHZGD2G169rgcpOD2AtNYutt0icY9y4xrvaUpO4r33ThZSTed7uKVZom
         a5/A==
X-Gm-Message-State: AOJu0YySJmqSzRFjgv49an33qvAkSLMLDU4D+H0HhFPxnIGWEWWJeQm3
	iED/Ki5MKW+qOvph2/EUAwOhznKRjNZLxN+faDZUGSwXkCCp2ZWHBvQe07OSjjfhex3Q1j4RlP0
	=
X-Google-Smtp-Source: AGHT+IF/rWJehoUVH0pyDiSO0j7nClL1eFd0utwOhnLH+Mn+W/RbZk7ylBYUjqHhts5UtzK0c0HJAg==
X-Received: by 2002:a05:6a21:3942:b0:1d4:fb58:e74c with SMTP id adf61e73a8af0-1d5db0e19d5mr189542637.3.1727795691941;
        Tue, 01 Oct 2024 08:14:51 -0700 (PDT)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com. [209.85.215.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264bedf2sm8125992b3a.86.2024.10.01.08.14.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 08:14:50 -0700 (PDT)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so4837540a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 08:14:50 -0700 (PDT)
X-Received: by 2002:a17:90a:b38b:b0:2e1:5a55:a4b9 with SMTP id
 98e67ed59e1d1-2e18456a9a3mr52944a91.2.1727795689370; Tue, 01 Oct 2024
 08:14:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911123507.v2.1.Id08823b2f848237ae90ce5c5fa7e027e97c33ad3@changeid>
 <ZuwfvyiOMAzciZX2@pathway.suse.cz> <CAHQZ30CVM3toTJCki_ao_+_2VkOxmB+a=BU73HF+4WCM0qRbwA@mail.gmail.com>
 <ZvwQiSNEwD6XB0yA@pathway.suse.cz>
In-Reply-To: <ZvwQiSNEwD6XB0yA@pathway.suse.cz>
From: Raul Rangel <rrangel@chromium.org>
Date: Tue, 1 Oct 2024 09:14:35 -0600
X-Gmail-Original-Message-ID: <CAHQZ30DMD9eqN7hFL8z6+XuJ1N_0EfyE8d9F2Vv+CsHn0UBAdQ@mail.gmail.com>
Message-ID: <CAHQZ30DMD9eqN7hFL8z6+XuJ1N_0EfyE8d9F2Vv+CsHn0UBAdQ@mail.gmail.com>
Subject: Re: [PATCH v2] init: Don't proxy `console=` to earlycon
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Huang Shijie <shijie@os.amperecomputing.com>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Yuntao Wang <ytcoode@gmail.com>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 9:09=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> On Tue 2024-09-24 10:05:08, Raul Rangel wrote:
> > On Thu, Sep 19, 2024 at 6:57=E2=80=AFAM Petr Mladek <pmladek@suse.com> =
wrote:
> >
> > > On Wed 2024-09-11 12:35:14, Raul E Rangel wrote:
> > > > Today we are proxying the `console=3D` command line args to the
> > > > `param_setup_earlycon()` handler. This is done because the followin=
g are
> > > > equivalent:
> > > >
> > > >     console=3Duart[8250],mmio,<addr>[,options]
> > > >     earlycon=3Duart[8250],mmio,<addr>[,options]
> > > >
> > > > Both invocations enable an early `bootconsole`. `console=3DuartXXXX=
` is
> > > > just an alias for `earlycon=3DuartXXXX`.
> > > >
> > > > In addition, when `earlycon=3D` (empty value) or just `earlycon`
> > > > (no value) is specified on the command line, we enable the earlycon
> > > > `bootconsole` specified by the SPCR table or the DT.
> > > >
> > > > The problem arises when `console=3D` (empty value) is specified on =
the
> > > > command line. It's intention is to disable the `console`, but what
> > > > happens instead is that the SPRC/DT console gets enabled.
> > > >
> > > > This happens because we are proxying the `console=3D` (empty value)
> > > > parameter to the `earlycon` handler. The `earlycon` handler then se=
es
> > > > that the parameter value is empty, so it enables the SPCR/DT
> > > > `bootconsole`.
> > > >
> > > > This change makes it so that the `console` or `console=3D` paramete=
rs no
> > > > longer enable the SPCR/DT `bootconsole`. I also cleans up the hack =
in
> > > > `main.c` that would forward the `console` parameter to the `earlyco=
n`
> > > > handler.
> > > >
> > > > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > >
> > > It like this approach. It works well:
> > >
> > > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > > Tested-by: Petr Mladek <pmladek@suse.com>
> > >
> >
> > Thanks for reviewing and testing! I know it takes a significant amount =
of
> > time, so thank you.
> >
> > >
> > > I could take it via the printk tree for 6.13. From my POV, it is too
> > > late for 6.12. I am sorry I have been busy with the printk rework :-(
> > >
> >
> > 6.13 is fine. As long as it lands upstream I can cherry pick the patch =
into
> > our forks without any pushback.
>
> JFYI, the patch has been committed into printk/linux.git,
> branch for-6.13.

Thank you!
>
> Best Regards,
> Petr

