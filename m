Return-Path: <linux-kernel+bounces-382746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C14C9B12E7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 00:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DC9E1C2214B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 22:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C28214422;
	Fri, 25 Oct 2024 22:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K7laySyB"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECF3214406
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 22:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895889; cv=none; b=GyF/IMPOQ1cKQCKW155/dwiZChD3RcQGOVPkKLECJ6ZWSqlfsyoMRkkXDd/o7tMnwNP36/94y+zj+1M+WBXZbrjgg5s+vyfxaLcWD9PyPvcUCxN6Ys2bi07QR5cPkCN8xOJF+kA4kL4WxDcFa2yUhz4liaQBrU/zBDouvPjkTgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895889; c=relaxed/simple;
	bh=1RQLaeS1fpsh0dKZaDhkHLAM8AxZ5BEEQNnV0Y/mxKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vtggg+ek8TbViET9iNULnikMfKaB5b+7apIFYNZizCFnhqaC7kecTBD5wz2zq1kV+SypzhnaPa9LGcKRWjv9xM2aztISGKmM8mtcEQJ01cwHp+YI+2VnKdtuqUDzxdHOgNttYKwQ6EN8DMyr5Dga5fVxtuAQtPtY2Cj/8RXP/Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K7laySyB; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539fe02c386so3466950e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729895885; x=1730500685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcHQXK2FfCQQAxtVJ6yAX2GZbwkk9uqOe7ieSVImr1g=;
        b=K7laySyBtFSc7adEIcBAJCqO8Zrk6qT0p/0thTf7PhYkis42uvCteAtP0N8/OAUw/5
         wUpCVz/ebKYjb6YHN3tNCJUukFh5/phxh0/dLfL1YFFPFzJ9yUS20KQlXUtYkyoyB7RH
         y/dr9T8SqAkbhZVlrxI4v+e77ZWxRjbxANtwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729895885; x=1730500685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcHQXK2FfCQQAxtVJ6yAX2GZbwkk9uqOe7ieSVImr1g=;
        b=QfmONqR2v2TDmcxR5tp9vSNySj0sqjUdTclBOC1kntj0tTPeouuWdnHiSMPPUW6JD7
         0Gc7evXfW3dKisbfuLdB1zTJdHxPx7Bja3w97YBPGBbGjP/RKGuVs4Ip56424V79uZZ1
         LxYmQLkf+cuc3Xc1/QrFE6VlMXOp79v6qxEh/C+/cIAdoCRLU+D7OyTJbID9l+dve7hi
         dRKdN4u0tFXph6e3ZbBkYtJMFm/bHAsBhzlNFqVvRiv3XLHEzuxeycvniyzu1zqR4Lye
         wJt6p7X11YBuJPrcKMe6oXRJ84oMUDQZnACXJlfMKhQbHFGTr2RqGeLUC7PipjMHJ1J1
         VDJA==
X-Forwarded-Encrypted: i=1; AJvYcCVMUeqTj3wbEp+cV9YVfx/Ly5XQnn0IClbjva9ivAcRx9NW7Fq1eXOTb5iZxoXnpIOu9VlA9r7f+pkiU8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwjZ40aL53rvq7YWtsllv7rZ0jSojHH4Sr8DcRFy4EmbUsHxsW
	CGimeILj1oTRXL6YNtPIGaROscifIupYSDUME8hFWtuN9aSedMcOh3m/r+Am7uQnch3WoYnvrIy
	FWA==
X-Google-Smtp-Source: AGHT+IHXreWYok7Y75Cun3VoMWQNel9owE6G22UVwx626w+FZEAzpNPZcaespbaL8mssZ3Uv6k76YA==
X-Received: by 2002:a05:6512:3c8e:b0:539:fc1b:36d1 with SMTP id 2adb3069b0e04-53b236a68f7mr2805878e87.6.1729895884589;
        Fri, 25 Oct 2024 15:38:04 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e10a879sm329753e87.40.2024.10.25.15.38.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 15:38:04 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539e4b7409fso2565013e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:38:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGYgiHZkZU/4biLw/vhgcwoHRgKj1uLpA7c9DLV7i3qTZBcLJU3Xjm/kZXpQ4ZA4nR9teRsVM7tPVDOrM=@vger.kernel.org
X-Received: by 2002:a05:6512:31ce:b0:539:e453:d90c with SMTP id
 2adb3069b0e04-53b33ddf703mr362228e87.2.1729895883411; Fri, 25 Oct 2024
 15:38:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022190217.GA846685@lichtman.org>
In-Reply-To: <20241022190217.GA846685@lichtman.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 25 Oct 2024 15:37:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VRwiXFLz98Px_xpV4JLUMq_Ld_BTX8La0Oe5O9-d_=7Q@mail.gmail.com>
Message-ID: <CAD=FV=VRwiXFLz98Px_xpV4JLUMq_Ld_BTX8La0Oe5O9-d_=7Q@mail.gmail.com>
Subject: Re: [PATCH] KDB: Fix missing argument in dmesg command usage help
To: Nir Lichtman <nir@lichtman.org>
Cc: jason.wessel@windriver.com, daniel.thompson@linaro.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 22, 2024 at 12:02=E2=80=AFPM Nir Lichtman <nir@lichtman.org> wr=
ote:
>
> Problem: Currently when running "help" in KDB, it shows the "dmesg" comma=
nd
> as having only a single argument, when in fact as can be seen in the
> implementation of the command (kdb_dmesg) it accepts two arguments
>
> Solution: Add the missing argument to the usage string of the "dmesg" com=
mand
>
> Signed-off-by: Nir Lichtman <nir@lichtman.org>

It's not a huge deal, but above your Signed-off-by you could have added:

Suggested-by: Douglas Anderson <dianders@chromium.org>

...since this was my suggestion [1].

[1] https://lore.kernel.org/lkml/CAD=3DFV=3DVZ61XFb1Ks79BHr1jL1jwf_36wYXryy=
0ZXOz1xTQ9zOg@mail.gmail.com/

One other nit is that the ${SUBJECT} tag should have had the prefix
"kdb:" instead of "KDB:" (AKA not all caps) just based on doing a "git
log" on other changes to that file and seeing what they were doing.
It's not always obvious what the tag should be, but in this case I
think it's fairly consistent.


>  kernel/debug/kdb/kdb_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index f5f7d7fb5936..5f56ade565a6 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -2827,7 +2827,7 @@ static kdbtab_t maintab[] =3D {
>  #if defined(CONFIG_PRINTK)
>         {       .name =3D "dmesg",
>                 .func =3D kdb_dmesg,
> -               .usage =3D "[lines]",
> +               .usage =3D "[lines] [adjust]",

Everything here is just a nit, so:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

If you want, you could post a v2 adding the "Suggested-by" and fixing
the subject, but it's probably not a big deal. If Daniel cares then
he'll either ask you to post a v2 or fix it himself when applying. If
you do post a v2, you'll want to carry my "Reviewed-by" tag and add it
right above your "Signed-off-by" tag.

-Doug

