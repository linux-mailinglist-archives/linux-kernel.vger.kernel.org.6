Return-Path: <linux-kernel+bounces-415412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1329D35B7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810F31F25C1F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE59189BBF;
	Wed, 20 Nov 2024 08:43:23 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC8818952C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 08:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732092202; cv=none; b=qgH+F7YZxH330i0WAH9qiSswYvH2w/VvYFIBx04tw5WejX5yuLBM63pHqDvX1tRufrd4Qs29uZgATEcj0Mu478Reu2MrwxpkUsPyJERwDa2QiwiljBwk4uxoz6IA80wxW4BExvTPzg0Tjx/JnR7NjvTZiwScXo9l/RWlvacq4cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732092202; c=relaxed/simple;
	bh=8ABrIhJtTtJvyGf9fJCEFrwE5rc5vP1sGaxb2AVTnKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QSMJ45ABc11AueGrXi2UwXXlNfAmdKIRvzPEEVeNFEDm9I9fYxBwAiRxV55WpOLiDIfcY8bQUFt5LTm4Ka5GqjTumoO3ZvyXd2Z/AxaZKpM0o7d+9hvdvCdqrDAV61l2c4IdB8Dk4PEMnfA52oT+kssqbV3BV8Y5BYRkdr5hoBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6eeb741c26eso14353177b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 00:43:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732092199; x=1732696999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TTPn9AsBcQNU4dqArDVuNmYIjZAypZecXjeABYJZVto=;
        b=Ag/bQ9L7fShhHrzG6AKQKyksI4130kgxmXQYtxo7HFMtB+4+yxYVqsZzd8zwe0+fZp
         luw3xrWyEwfiBCWyOUM55niNfkwj+jbOvBCcTJ34iSURWeJQY9BzvO8ienqPdgJh3g+h
         BfDyFSQLKkfuml8Xn3IWdZ+cxB6W4LwfpmfQbuzyH7wWBzUOhQVpuBOxU+2yu8m402NW
         inw4JI83AAaYKBDlV86D0qzYBGkr2AZnN/zxWgIw1AXeYQ0+DnuRbd96vWmpb5858JM3
         FyEdrAZy9msb9x2Vg/idEPAI4txH4bCliYPKj+0/vgZcqand+aDEzH2+c0ghGF37KsiK
         B2bA==
X-Forwarded-Encrypted: i=1; AJvYcCWq12B0Ex5KboXbqg3TdhXwpU7KH2KsTyW8bz+WOgNiqmn1jk2rCjZgO27hy3mmdz8dMFqPZresexthcmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgMSSjUN96nyVHlu7lvoYSSX2pWEFm3A9Am+Sf51Tq4oZ9QENZ
	FbQG3B+crwfB/2hzPsU0LJAqqYnU5sdq3w3eMQKscRuVhUDmFhPR31xYhc0K
X-Google-Smtp-Source: AGHT+IEdyJzeeLkr0XAL9wKUZgapU2VFpHt4lPLE3jAHcimH6gSP942RKaWmrKNr/dt0MTsfZ4Me+g==
X-Received: by 2002:a05:6902:2491:b0:e38:b27a:37b3 with SMTP id 3f1490d57ef6-e38cb728681mr1361534276.49.1732092199140;
        Wed, 20 Nov 2024 00:43:19 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e387e75edcdsm2918752276.31.2024.11.20.00.43.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 00:43:18 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ee7b886b5fso37782457b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 00:43:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWxfNUIGzgqbF5livwVjHuDJZEWZCC5HuFUobFzsQSR3w0QdY+dmBeZuzxArLTjl/yAFMOGOQbh8peRSUw=@vger.kernel.org
X-Received: by 2002:a05:690c:6c87:b0:6ee:60ca:9d8e with SMTP id
 00721157ae682-6eebd0de490mr21884067b3.8.1732092198530; Wed, 20 Nov 2024
 00:43:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030171009.1853340-1-saravanak@google.com>
 <CAMuHMdWv+x31-3OaKFKHJHJwK+KB0Hi3yJMRUJ3rqEThY=EE7Q@mail.gmail.com> <CAGETcx8hZsm0qbwYDAeX_OztYs2jHPv9dc2ZajVivhEvQ7O6bg@mail.gmail.com>
In-Reply-To: <CAGETcx8hZsm0qbwYDAeX_OztYs2jHPv9dc2ZajVivhEvQ7O6bg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 Nov 2024 09:43:06 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUo1fV-O9x6C578G8+WdES2bH7yQjO56PErFwSu2LNNkw@mail.gmail.com>
Message-ID: <CAMuHMdUo1fV-O9x6C578G8+WdES2bH7yQjO56PErFwSu2LNNkw@mail.gmail.com>
Subject: Re: [PATCH v3] driver core: fw_devlink: Stop trying to optimize cycle
 detection logic
To: Saravana Kannan <saravanak@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Francesco <francesco.dolcini@toradex.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Saravana,

On Wed, Nov 20, 2024 at 3:04=E2=80=AFAM Saravana Kannan <saravanak@google.c=
om> wrote:
> On Tue, Nov 19, 2024 at 5:40=E2=80=AFAM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> > On Wed, Oct 30, 2024 at 6:10=E2=80=AFPM Saravana Kannan <saravanak@goog=
le.com> wrote:
> > > In attempting to optimize fw_devlink runtime, I introduced numerous c=
ycle
> > > detection bugs by foregoing cycle detection logic under specific
> > > conditions. Each fix has further narrowed the conditions for optimiza=
tion.
> > >
> > > It's time to give up on these optimization attempts and just run the =
cycle
> > > detection logic every time fw_devlink tries to create a device link.
> > >
> > > The specific bug report that triggered this fix involved a supplier f=
wnode
> > > that never gets a device created for it. Instead, the supplier fwnode=
 is
> > > represented by the device that corresponds to an ancestor fwnode.
> > >
> > > In this case, fw_devlink didn't do any cycle detection because the cy=
cle
> > > detection logic is only run when a device link is created between the
> > > devices that correspond to the actual consumer and supplier fwnodes.
> > >
> > > With this change, fw_devlink will run cycle detection logic even when
> > > creating SYNC_STATE_ONLY proxy device links from a device that is an
> > > ancestor of a consumer fwnode.
> > >
> > > Reported-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > > Closes: https://lore.kernel.org/all/1a1ab663-d068-40fb-8c94-f0715403d=
276@ideasonboard.com/
> > > Fixes: 6442d79d880c ("driver core: fw_devlink: Improve detection of o=
verlapping cycles")
> > > Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> >
> > Thanks for your patch, which is now commit bac3b10b78e54b7d ("driver
> > core: fw_devlink: Stop trying to optimize cycle detection logic") in
> > next-20241107 and later.
> >
> > > Geert/Francesco,
> > >
> > > If you want to test this patch, pull it in and compare the output of
> > > the following:
> > >
> > > ls -1 /sys/class/devlink
> > >
> > > The only device links that should be missing with the patch should be
> > > device links in a cycle that weren't detected before.
> >
> > I gave it a try on all my boards, and compared the output on a few of
> > them, and everything looks fine.
>
> Thanks for testing the series Geert!
>
> And no noticeable boot time increases?

That's a bit hard to measure, as the serial console output easily takes
ten seconds.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

