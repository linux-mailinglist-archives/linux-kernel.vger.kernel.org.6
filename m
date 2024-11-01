Return-Path: <linux-kernel+bounces-392455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948B59B9466
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 16:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5911C216C4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 15:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D51F1C6F70;
	Fri,  1 Nov 2024 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hwid8Gan"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A461A3031
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730474999; cv=none; b=Qt8OyVnd3ATnQt0tYQag5L5fuQSfTLrZh1y91UvBxb8TTVC1Sutr3BwdQI68YmaqogBQ51a3APycFjxWwD1Z3Bnq6+SFk3m4Qg177opI1WhKOHeewS1ithTPeM7KKtFVI+FhEn6St6zzy81jyA5aflOfB+UAuAqM2dWGk3keMsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730474999; c=relaxed/simple;
	bh=8eWssj8XOHnsPulzVSgBpzo65ZkRFYfYnCn06lFF15o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8jx+NgPKA0QCRqMvdbgHjZjTQAyoIOfCwPRj7gSkSKpnhJJafbvurLdq+2H47F4NBygfnYJw7YS6G0yFkipGL2A5avu5D+vn86p0VUZdxNXNXoFVSAZY6hD2fJuyOIbxDZgY+Ha0sloBNokCANwNp0rwe/dHorOAjYxtQtKIvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hwid8Gan; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539f2b95775so2489725e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 08:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730474995; x=1731079795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8eWssj8XOHnsPulzVSgBpzo65ZkRFYfYnCn06lFF15o=;
        b=hwid8GanK/+Dd4xkwWCxvh6gKh7jOJ9pXEXkhpmtA6nlMfu/9QOdqc1OoUMdTdZ4w+
         ssYEYShlBRMszYH0Z7lFndpfjdrb1uu9a3qojfgKd2Ni9dM0TuSzvyMKO0N0OO4rIufu
         YXiXrtE5gRUHqCU9vymc+nY6MJsCFfjqivdzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730474995; x=1731079795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8eWssj8XOHnsPulzVSgBpzo65ZkRFYfYnCn06lFF15o=;
        b=nWGX7ShHBmaNL/vGDjBXAEJpnFWpTgD3bS1r8UGYvmG4SaIJZaBWAXx3J7KYSYGWkv
         yx8hCBfzViO3i5iu8w7PPW/NkRpe7fQkgRkI3r9wDMYkuuU0KXiMYHk9ctJDf7zfGBE7
         pf3CONeilQIQKjnSKVVSQ52XX9Ms2I+jQbmnn/qmGv3ZjHVIIcCxVm1/wFmF+QOGp5k2
         KWu7ee3uoyFUejCr7xHaNIGBlE07jxUnYscv/Wc+b1rbxWfvtIEdqm+skhJejZDik7G/
         7ug8/6jksbiTop8HxH8CoXEWCtX9bVu5Fm6pOxq3e/DWkhzNVA0GY74sIAafb1C0yz7N
         RDUw==
X-Forwarded-Encrypted: i=1; AJvYcCVR54ZnVFFemrSVX42Ss6ah9+GXPLn3c0mcrWnTCMuKh7mPl6y+3SB+ZbrffPtnYT9krRtQ8BwePRL9i3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3lY3/2Vit/s5VA+oIQpmFIzdg8TiyNDykKrFFkFQAqKe/o50S
	W7hfTL9VCrQcwUVltBFDHApONqZrOlAmOHUnhliST+eKG4RmHvm4XuKcUJYGYJ+yrqfnAtqxMVm
	4q/Cm
X-Google-Smtp-Source: AGHT+IG7B9dBXmTrWgnRV1+mZLJJuSV8iVdnukPqdqbC4kzTyLXyJMueqzry63e+4MhwoDQPVuogPQ==
X-Received: by 2002:a05:6512:ea8:b0:536:7377:7d23 with SMTP id 2adb3069b0e04-53d65e0a8a9mr3815731e87.40.1730474995251;
        Fri, 01 Nov 2024 08:29:55 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc95a82sm588463e87.35.2024.11.01.08.29.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 08:29:54 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539fb49c64aso3084822e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 08:29:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWsfsw5jZmyqj8gNn/iRP7KsefCcI7rU5ZNA5PgaYfop/DamtUH4W1U+Vryde7fJ85injxxWNXt/az85Mc=@vger.kernel.org
X-Received: by 2002:ac2:4c56:0:b0:535:6a34:b8c3 with SMTP id
 2adb3069b0e04-53d65dca63dmr4119418e87.5.1730474993987; Fri, 01 Nov 2024
 08:29:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031192350.GA26688@lichtman.org> <CAD=FV=WC-ce14rgrYsVbg75dNX5tL6Saj5T8YqpAWm2ndLGdXA@mail.gmail.com>
 <20241101002612.GA29456@lichtman.org>
In-Reply-To: <20241101002612.GA29456@lichtman.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 1 Nov 2024 08:29:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V+EJf--J29YM7XuHbNO0fFzLgOYBhBA5VsnnMTG-LArQ@mail.gmail.com>
Message-ID: <CAD=FV=V+EJf--J29YM7XuHbNO0fFzLgOYBhBA5VsnnMTG-LArQ@mail.gmail.com>
Subject: Re: [PATCH] kdb: Fix incorrect naming of history arrow keys in code
To: Nir Lichtman <nir@lichtman.org>
Cc: jason.wessel@windriver.com, daniel.thompson@linaro.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 31, 2024 at 5:26=E2=80=AFPM Nir Lichtman <nir@lichtman.org> wro=
te:
>
> On Thu, Oct 31, 2024 at 04:06:03PM -0700, Doug Anderson wrote:
> > >
> > > kdb doesn't react to ctrl p and n, and following the code flow with G=
DB
> > > reveals that these values map to the up and down arrows.
> >
> > Really? kdb reacts to "ctrl-P" and "ctrl-N" for me. It also reacts to
> > "ctrl-F" and "ctrl-B".
> >
>
> Interesting, how do you run kdb? I use the kgdboc=3Dkbd kernel boot param=
.
> I haven't checked with serial as the console since I work with the keyboa=
rd,
> but if serial does go through this using ctrl+p/n then the code in the
> current state is misleading since the keys change depending on the I/O me=
thod.

Wow, I've never used the keyboard method since I've never run kdb on a
machine that supports it. :-P


> Evidence in the code for usage of arrow keys in the case of keyboard can
> be seen by examining kdb_read in kernel/debug/kdb/kdb_io.c, in the /* Dow=
n */
> and /* Up */ cases the values 14 and 16 can be seen.

Right. Essentially the logic is converting the Up and Down sequences
to the characters Ctrl-P and Ctrl-N. ...so by the time we get to
handle_ctrl_cmd() the characters really are Ctrl commands, not arrow
commands. Thus handle_ctrl_cmd() is correct as is.


> Do you suggest to keep as is or to work on a patch with a more generic na=
me that
> would fit both?

IMO it's a bug that the keyboard code isn't properly reporting Ctrl-N
and Ctrl-P. Does it handle other Ctrl characters? Ctrl-A should go to
the start of the line and Ctrl-E the end. Maybe you can track down why
this isn't happening?

-Doug

