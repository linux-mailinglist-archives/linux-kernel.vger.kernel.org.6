Return-Path: <linux-kernel+bounces-538452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43359A498E9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DC681732B5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E149626B96F;
	Fri, 28 Feb 2025 12:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b="KKkjnHB+"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D81626B2D4
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 12:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740744789; cv=none; b=PZg8D4kC5FBctHIQ4Vbb/kdvlGT/S54Z2U+zzzCfB3DLKDi4xTa9KftL2Og4blKtdpi3juh501eePhTb0vCm7it7YejpOe3PzR1NGhd8UQGdnH6B9bzfxHYWakoIRHVxVrbFBt0+EYao/jK2cAVNsn4LzVJtSw5KYpfq1WBi+/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740744789; c=relaxed/simple;
	bh=ZI+Kx0GoBBdGnl/DZVJvV+fahAqx7XY0gMzC1aKOS5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGyHlywUu8PSRZZgRtanQIVqACcKiyCa89B77QpOpFGlRIXkDhaKULMyXSU0bLCsn6vXH06tYZuXMVU1YRnxTcvZ45KAHbHUc5Mn9lJkkivVtpKUou73CLa6oHpoZ39x3QxhEyljmrRm39EEwHOfik8B6+4orrLtZyt7dSUfrrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b=KKkjnHB+; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2c12b7af278so1102182fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 04:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.com; s=cloud; t=1740744786; x=1741349586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTnS4AT3Ykm/+LOlGj0/AefzuBNeKl7EmWjFY3jT+bg=;
        b=KKkjnHB+GiHVskm81i0sfCImOzC23itKxXjAh9EWLkrBl7TWk7ghockbCXO7KLBcLH
         LpWrU+yvulOV1Yv7rRjPc7Cnh67kVR6ne8kHbcaIGnH6cnKen8mUtyvRf1MgSwd+xQLA
         +w84T72FjB+BjXvrI8SKt/hy6jgs7Jd81tkS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740744786; x=1741349586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZTnS4AT3Ykm/+LOlGj0/AefzuBNeKl7EmWjFY3jT+bg=;
        b=PPgLCvNe+DUHifKtQ/1DAz3vfmq5R5XaRYuvpZTnpCc7zTfNCmv3jOv6b/2eVvMBFg
         H05uE8CpuvTm4NI/BlzwxqPV8lt1Ah8YW+gJ7cn4tYjtBtCoiOvhQEiEl26HQmFlQWcC
         6ET8HDW+R39nCj6hPeacOfNqwD4kAHz1npmdx7P4BRVN9iXMGg2vmV4LqTWdHaouuWPE
         6vZlCIhItLjv26seLsOs/E78d68TgvS1SsoszNVrOywKjAKEwyfOGATw1104vScB6Qzy
         XyIXeZ4JhKrtSFUjrTTeTc5UgsVjyi0xUlzot1EHbNeNQlz527fIca4NaOED5KoAbT+p
         4bZw==
X-Forwarded-Encrypted: i=1; AJvYcCXFrye0grm3uk4Ju/Hn407WWtUfArsfPwUsxxwErLctpIujB+fVrLzXsQtiKqWjbmWWYhP6yp9YUVVG1eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuJsLTGTD2MCmwqGgQB4Nul11lR7X8eCFPT+3fTuLClE8bsVlW
	J93hIU9NsrHNMjpZTG7VNrTYo6w2g9MKpbBInyideSBwwXomQ/6XWcAyg+ikIMAEEEueGUBY5RR
	fj9ik6U9UC8rFd65DsjWdXlrEsHd87c9GpE8c6g==
X-Gm-Gg: ASbGncu1wh31kZqD+ANgf9iv6bHHgW5l4g+D5opZFDwCVvsm9Bds+t16uVrmEwluI+y
	VBQjRl54VYE4YWh5AsydMiNWw1dnVeha04bB+SFx7OZmZpSM+4m79ZrCoyMYnNeYu7QZFT33yhn
	zX3gT/
X-Google-Smtp-Source: AGHT+IFoC5JZOWc1WhrzvGf/ZhvbLVUcjNnF8kIi0EhQzpdVsfrG6OS+XFRLxFDVnE+JcStJoQAtJmvVxTsuwQG/A6A=
X-Received: by 2002:a05:6870:d08:b0:2b8:5a6a:6f5f with SMTP id
 586e51a60fabf-2c1558aac6fmr3403069fac.19.1740744786443; Fri, 28 Feb 2025
 04:13:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225140400.23992-1-frediano.ziglio@cloud.com>
 <20250227145016.25350-1-frediano.ziglio@cloud.com> <a14c6897-075c-4b2c-8906-75eb96d5c430@citrix.com>
In-Reply-To: <a14c6897-075c-4b2c-8906-75eb96d5c430@citrix.com>
From: Frediano Ziglio <frediano.ziglio@cloud.com>
Date: Fri, 28 Feb 2025 12:12:55 +0000
X-Gm-Features: AQ5f1JryDg2N2hATeuCkNPfGX9h6MK4TS1xPsoZVRgxsUphCag4t-Oo4DcEbAQQ
Message-ID: <CACHz=Zj-PKj_svJaLe0DMW9U0FTvea3Es8n1ku_Fp4qzxi4zxQ@mail.gmail.com>
Subject: Re: [PATCH v2] xen: Add support for XenServer 6.1 platform device
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 3:41=E2=80=AFPM Andrew Cooper <andrew.cooper3@citri=
x.com> wrote:
>
> On 27/02/2025 2:50 pm, Frediano Ziglio wrote:
> > On XenServer on Windows machine a platform device with ID 2 instead of
> > 1 is used.
> >
> > This device is mainly identical to device 1 but due to some Windows
> > update behaviour it was decided to use a device with a different ID.
> >
> > This causes compatibility issues with Linux which expects, if Xen
> > is detected, to find a Xen platform device (5853:0001) otherwise code
> > will crash due to some missing initialization (specifically grant
> > tables). Specifically from dmesg
> >
> >     RIP: 0010:gnttab_expand+0x29/0x210
> >     Code: 90 0f 1f 44 00 00 55 31 d2 48 89 e5 41 57 41 56 41 55 41 89 f=
d
> >           41 54 53 48 83 ec 10 48 8b 05 7e 9a 49 02 44 8b 35 a7 9a 49 0=
2
> >           <8b> 48 04 8d 44 39 ff f7 f1 45 8d 24 06 89 c3 e8 43 fe ff ff
> >           44 39
> >     RSP: 0000:ffffba34c01fbc88 EFLAGS: 00010086
> >     ...
> >
> > The device 2 is presented by Xapi adding device specification to
> > Qemu command line.
> >
> > Signed-off-by: Frediano Ziglio <frediano.ziglio@cloud.com>
>
> I'm split about this.  It's just papering over the bugs that exist
> elsewhere in the Xen initialisation code.
>
> But, if we're going to take this approach, then 0xc000 needs adding too,
> which is the other device ID you might find when trying to boot Linux in
> a VM configured using a Windows template.
>
> Bjorn: to answer a prior question of yours, all 3 of these devices are
> identical, and exist in production for political reasons (bindings in
> Windows Updates) rather than technical reasons.
>

Hi,
   we got some internal conversation here at XenServer trying to
understand a bit the history and situation of these devices. I'll try
to sum up.

Devices 0001 and 0002 are both "Xen Platform" devices
(https://gitlab.com/qemu-project/qemu/-/blob/master/hw/i386/xen/xen_platfor=
m.c?ref_type=3Dheads).
Devices 0001 and 0002 are mutually exclusive. Usually on XenServer
templates for Windows present device 0002. In other words the xen
platform device is either presented as 0001 or 0002.
Device C000 is a "Xen PV Device"
(https://gitlab.com/qemu-project/qemu/-/blob/master/hw/i386/xen/xen_pvdevic=
e.c?ref_type=3Dheads)
which is mainly empty being a placeholder for Windows updates.

Back to this patch, as C000 is just for Windows update purpose, I
don't see the reason why Linux may care about it (I may be wrong). On
the other hand, if device 0001 is missing Linux will crash so it
should consider also device 0002 as an alternative.

I'll try to post an update for device reservations
(https://xenbits.xen.org/docs/unstable/man/xen-pci-device-reservations.7.ht=
ml)
to xen-devel.

Frediano

