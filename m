Return-Path: <linux-kernel+bounces-295704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE99E95A043
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16FAB1C20C9D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775C814C588;
	Wed, 21 Aug 2024 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEA1tPYD"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E7D5FBB1
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724251567; cv=none; b=st1v13DeyG21i7rrDFgxDi1p64We0AuUn8t/+reDOs/E3GSHHjhSlQsJC9wVHQLz8RWG3Rl3FAUEA8CPOFTGZJISEjNNLBREPjJFfA+lruzxzJYDxpDtwvD7ct+JFWpLwMsTgmbGBNIouhs0JE72ngXtL7Eai+MvU/4hQAOm1c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724251567; c=relaxed/simple;
	bh=v+2nH1s6ESTOVI286p64AfePytVHkc9AOY4wRHrLsZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mqeHb/7SpNhX99y+HgrcSAYnc+74BKbThoXkbBkOXxIzAdrLedIoBHo/RA41+ybZ46476HUq+gUlPzUAeBngmcUktr4xqmbaoO0Yv+/Bs6SHkzabhL8QNFBLoyHhgnAaNBDFMUISwk5NNbv42qjD4LjG9vWF+vl65VEeqKkSKSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEA1tPYD; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3db1e4219f8so3831058b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724251565; x=1724856365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kKQ3JKzegouLs/ZAFgxArkZHaNn406HZXh8UEUF1pg=;
        b=bEA1tPYDyxC1VDFGKUpDN0ekfoxi0C/VJzHv9G15dNYvy6HDFGgccNXZN413nxuy1X
         1tfCDQq5x4M0Zkbe5kUhCQij+jAXw/PGJQvA0mS5FICtvK2lLq5GWxp/TCQ7BUleZaAJ
         SXimiWE5Gc04f5VLhgjH4cmt+UqbvUJQl87LVGSy9MMcWhptTZ4ZPNSKtqBI6pEnPMlt
         h3aK5Yj8oHY5hZikZkXRZXcQLKQggMh+D3oIB7iDZ5zo4qRZ0Jx/Y8J/00h0hxEYDcUC
         vmFHDaZGBtNdwHyDbIgumfXeKAESnQj7v3hqBl14A+sJKO1cXQfYrQN2CalTPwOcbOy/
         VBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724251565; x=1724856365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kKQ3JKzegouLs/ZAFgxArkZHaNn406HZXh8UEUF1pg=;
        b=S2NWmesa/vCYxNtVoerpmmkz8xofVy9tHhln9H2iCkZzjfcCqS7IfxkZK2lno56+tm
         WIEOFSQptjeio6ed4fiznrTB49F4dauX11Dy58hplYodcjaa32mz5i/Iv8/wuCrvaHje
         gLcwUqo1MWq9rtG0IIy4xdoKpwFKfZYm6AVBeilXwhT0jXFv7e+AtfH1kw7Rf71b01V4
         xBFrH/b+DOnPJJTxnY3i2VDaBc4HzxEB1l3FjxKJF9HlDoRadCK82yBQgbbyEYywCZSt
         2Tg74QfVU4q94Ca/KTatfdyKkApvrYVojUytechmq8S0bL8xgkHxVOA4xfWUMgieC1NK
         v/yA==
X-Forwarded-Encrypted: i=1; AJvYcCUcvw3lUiQLeJbSabmdRFPgyaFP9DRLvWp3xpamNe1Wf9hgG4JNSQYkJLQ1YUvRiNJ/Wbr80Uoz94Xxblk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy91F376eZvTodjW4DjISzxQFmmpyVforwUUsQ5X3h60i+pvALf
	HFk6s4ukEc1HhV+QGqeHIBq8r+lPfRihqnOks6tujCSmsN8jZVFH43eekY1RyygVSwObtHOYXf4
	6i9lw2sxRpowJBwrcdNT977KiV4D0Ua7I
X-Google-Smtp-Source: AGHT+IHskRyysgaAFafYjBWSxGlW4LgZ9tkgdq6KVwRkKnXjRQbgWGdfuOY52dAsgEG4QdTcqwugfbRrl2Xs80W1TV8=
X-Received: by 2002:a05:6808:2021:b0:3d9:e090:5e1e with SMTP id
 5614622812f47-3de194e0c0emr3143192b6e.7.1724251565309; Wed, 21 Aug 2024
 07:46:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821013901.787555-1-link@vivo.com> <8f577565-69b7-4da0-a7fe-2e94bf37948c@wanadoo.fr>
 <b8e9e59c-6486-478a-bd25-ee13cbcc46cc@vivo.com> <75478278-1f18-4865-9dbf-c929417e1637@wanadoo.fr>
In-Reply-To: <75478278-1f18-4865-9dbf-c929417e1637@wanadoo.fr>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Wed, 21 Aug 2024 09:45:53 -0500
Message-ID: <CABb+yY3drhueGsmBt_JF+ev0rw0J1xkb0xZ5jS3qynOYra_wVw@mail.gmail.com>
Subject: Re: [PATCH v2] mailbox: sprd: Use devm_clk_get_enabled() helpers
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Huan Yang <link@vivo.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 5:09=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 21/08/2024 =C3=A0 09:08, Huan Yang a =C3=A9crit :
> >
> > =E5=9C=A8 2024/8/21 15:00, Christophe JAILLET =E5=86=99=E9=81=93:
> >> Le 21/08/2024 =C3=A0 03:39, Huan Yang a =C3=A9crit :
> >>> The devm_clk_get_enabled() helpers:
> >>>       - call devm_clk_get()
> >>>       - call clk_prepare_enable() and register what is needed in
> >>> order to
> >>>        call clk_disable_unprepare() when needed, as a managed resourc=
e.
> >>>
> >>> This simplifies the code and avoids the calls to
> >>> clk_disable_unprepare().
> >>>
> >>> Due to clk only used in probe, not in suspend\resume, this pointer ca=
n
> >>> remove from sprd_mbox_priv to save a little memory.
> >>>
> >>> Signed-off-by: Huan Yang <link@vivo.com>
> >>> Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> >>
> >>
> >> Nitpick: no need to add this S-b. I just made a comment when looking
> >> at your patch in order to improve it. I'm not the one that suggested
> >> the initial change. All merit is yours.
> > Your suggestion is helpfull, help this patch be better.
> >>
> >> Also, I think that, if used, it should be above your Signed-off.
> > Hmmm, it's neccessary? If so, I'd like to update it.
>
> I don't think it is useful and personally I would remove it, but you can
> keep it if it makes sense to you.
>
I think   Reviewed-by  is appropriate.

cheers!

