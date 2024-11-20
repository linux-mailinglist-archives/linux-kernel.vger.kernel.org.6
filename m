Return-Path: <linux-kernel+bounces-415146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 569079D31FE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 03:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2B61F239C6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 02:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4952B1E485;
	Wed, 20 Nov 2024 02:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I2j6i5Gx"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16B83D76
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 02:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732068286; cv=none; b=U1jn/2J0f0Rc32hWmdT88dTF2Q3EeJKKDeJ4Tq3Qzj7aKvMnsA0b9w5ID65noFUGeu/xAIEXGP+B/8Lbf2JwKWxQobzXvaiqaruJbeD6ISvCJNrMEMb3U5pUPE3lyWLDANvzejCjkgB+7DCdVEp5OUconzYjy/scgT0mp8yWQGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732068286; c=relaxed/simple;
	bh=wefildTR1uUtAKMhgsElm7TqkOgtnYZuACo7ag2CqBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I14i+rKUxv0ll8X4bFbThfi7mERnRDwP5jg2x5jDT7emLUTD+aDr0YwyGkrGk6ZPvMzqiWhA6ImeOacnKraT7HdtseDejo+vS7gchckiP1g6A/w7PX4dPHZ1QHyhLknRKPIKdfuhdN23J/7d3VRFnqvPrHQfLf69Jnlq+/A9nuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I2j6i5Gx; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53c779ef19cso6241711e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 18:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732068283; x=1732673083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wefildTR1uUtAKMhgsElm7TqkOgtnYZuACo7ag2CqBk=;
        b=I2j6i5GxVtrl3rfnvXRO4AU/r5yxVhqDvS9lYDaSeO4vWZe9yeYSPW9dAdUZdKh/6d
         WkDp/o8Ww0L0qdfow+P0P8nsHe8P52nGuy52NtvGUNRj6t0HgJe4m0tYssB2s1yf29+C
         lps34vRCh60B2poFBaQStqM1jRweoCARQjDdSxM5gehTwrXYJxX9PjCi3YFQc4UqHSpn
         Ughyt8Ge74PVQvC3n3Gxqg0su5UDv8Bl2xI7S+5uSVixmM4gROPqqHQ+UQZxUQbBU+58
         p4kwXaMzr3DvWbVNBWyg7Q46pjDfOSSWHidO76iztjoN7FjL9VC4NVeKGtlKySM0ykhT
         550g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732068283; x=1732673083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wefildTR1uUtAKMhgsElm7TqkOgtnYZuACo7ag2CqBk=;
        b=qJoASgIPIONKyqMZ44fb7s77t/D1X3kX/dhQMKd5V39F7n+zXjNoMzeYhmofnx4hvV
         ILT4o+RUxrVeI7yY7Q2N83cxvQdz2x/NQZdOA2+JaNyjgdnPZNK7EEwpUWwTk/u3SbGE
         O+c2eoHAWdy1dWCF5fRE0zOeC4vCxOA7H/irRUaRgix5DpyJUpt3BYjLg3Uf97ysLLMh
         C2UdaB8yxDZFl0sV5ndJ5tIPg0qWF0+U/NqCqqS9PsjifVlu1pgn4y3tddkcpuXD5qEf
         bsP41ngwl4TpDSoxkrMgob4BL0xHukMuorrI0/yYcx8F5eiANK3cSsisKlaJOi99InKm
         rA7g==
X-Forwarded-Encrypted: i=1; AJvYcCXh6PNizr6pvuUB7Shik5H+nAFIoJv2Er5+qJ6i6RYwFRky1IvoZLqsUHoqqwO6arboeh8hYGapPWhFSBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAU7M9C8PzMrOtXmwUkoWsCpCUKccg0+2O1oWTNA144NEW/ep2
	7rWt2gLFM5LLovzs08slab4iddhWcQRxsvlU8/WqC7JLQw+Kt7YqBWFt9vUcoHoGZnRWQ1+DV+s
	XzfAs561WzE0j/gt3LnmVIkV0R2xBdc2uB4T5
X-Google-Smtp-Source: AGHT+IGb8F+Uqb68QHQ25IRYX2JETNA+AsuOGghRwQkUvYiquguCiLNI3lhbZf6jvGk5rtAPMKBxYmX9oDWf9XyPxFk=
X-Received: by 2002:a05:6512:b0b:b0:539:ea49:d163 with SMTP id
 2adb3069b0e04-53dc132e21fmr223782e87.21.1732068282808; Tue, 19 Nov 2024
 18:04:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030171009.1853340-1-saravanak@google.com> <CAMuHMdWv+x31-3OaKFKHJHJwK+KB0Hi3yJMRUJ3rqEThY=EE7Q@mail.gmail.com>
In-Reply-To: <CAMuHMdWv+x31-3OaKFKHJHJwK+KB0Hi3yJMRUJ3rqEThY=EE7Q@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 19 Nov 2024 18:04:05 -0800
Message-ID: <CAGETcx8hZsm0qbwYDAeX_OztYs2jHPv9dc2ZajVivhEvQ7O6bg@mail.gmail.com>
Subject: Re: [PATCH v3] driver core: fw_devlink: Stop trying to optimize cycle
 detection logic
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Francesco <francesco.dolcini@toradex.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 5:40=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Saravana,
>
> On Wed, Oct 30, 2024 at 6:10=E2=80=AFPM Saravana Kannan <saravanak@google=
.com> wrote:
> > In attempting to optimize fw_devlink runtime, I introduced numerous cyc=
le
> > detection bugs by foregoing cycle detection logic under specific
> > conditions. Each fix has further narrowed the conditions for optimizati=
on.
> >
> > It's time to give up on these optimization attempts and just run the cy=
cle
> > detection logic every time fw_devlink tries to create a device link.
> >
> > The specific bug report that triggered this fix involved a supplier fwn=
ode
> > that never gets a device created for it. Instead, the supplier fwnode i=
s
> > represented by the device that corresponds to an ancestor fwnode.
> >
> > In this case, fw_devlink didn't do any cycle detection because the cycl=
e
> > detection logic is only run when a device link is created between the
> > devices that correspond to the actual consumer and supplier fwnodes.
> >
> > With this change, fw_devlink will run cycle detection logic even when
> > creating SYNC_STATE_ONLY proxy device links from a device that is an
> > ancestor of a consumer fwnode.
> >
> > Reported-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > Closes: https://lore.kernel.org/all/1a1ab663-d068-40fb-8c94-f0715403d27=
6@ideasonboard.com/
> > Fixes: 6442d79d880c ("driver core: fw_devlink: Improve detection of ove=
rlapping cycles")
> > Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> Thanks for your patch, which is now commit bac3b10b78e54b7d ("driver
> core: fw_devlink: Stop trying to optimize cycle detection logic") in
> next-20241107 and later.
>
> > Geert/Francesco,
> >
> > If you want to test this patch, pull it in and compare the output of
> > the following:
> >
> > ls -1 /sys/class/devlink
> >
> > The only device links that should be missing with the patch should be
> > device links in a cycle that weren't detected before.
>
> I gave it a try on all my boards, and compared the output on a few of
> them, and everything looks fine.

Thanks for testing the series Geert!

And no noticeable boot time increases?

Thanks,
Saravana

