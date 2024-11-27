Return-Path: <linux-kernel+bounces-423653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C429DAAEF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34C42B20C87
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2F81FF7DE;
	Wed, 27 Nov 2024 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kJYSZKt1"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3556328B6
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 15:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732722257; cv=none; b=nFBdzThsJhFmJPQn3MKhFfbYalPX4Rzb8fvjTniSPk9RoRRVCl39GaYUeYjNgQ42NyxO+LLcsXuLZOpQGMTeaBc7+Bv6cfTjY0jnDckJL/5PwTXR7SHVw8+E2S1hpM75EOpjHouIdTikGkSTAzFQ2VE4LXuc5OpMibSK7F8Xpsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732722257; c=relaxed/simple;
	bh=bVT+dpvBwxjyqpQVrhRvKPf3wxf2mZmKZ5jvpYljAyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kt1XjKfV7goHk2vuEVJAYFZT4dqZRMa+Wi75gcD/YQOGMPsszZ9YLTGj4VLQiDbgSR18a5RwyyF7E5jGz23pc4F1cMT8iwWmSlj8DzneYc8TXdecIl84PqGfvlatHOWRNT2rxQxwN+2wt6LQFC39ZTcmQXTbz7I9I5VrmG1e/Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kJYSZKt1; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53df1e0641fso781760e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 07:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732722253; x=1733327053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lb++oae+LfaSjUgB9HTAkHZpSmH52F0dJv7k1k95lEU=;
        b=kJYSZKt1qna1I3uCYII8JcAv1obstigXDdCp9i2HGzPfq79P8iYdwX2P1SI0Ab2vS/
         z9AOmhq8PrOvJgsi+N7nWRMZPONubU8TN+aGD4UG0zseFEcNZPYfrWLpvfN1nRVJqzp6
         6wtqJ7qDNZKcwospInmLc2pubqV7yWTVvnPx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732722253; x=1733327053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lb++oae+LfaSjUgB9HTAkHZpSmH52F0dJv7k1k95lEU=;
        b=ceOvcvuG4IrzFQlkuy8q5KTonwn+j/D6w/MzDYocO7b3YptJSNU+BU25EIaBvUZt53
         3n+j8z9jKOVhMG8OzHCl5czmuKOqIo7dAAodYJuvyfRW+/Ohq5kd2WXtYqzIW5XyJ4ls
         QR607AmZMcw7UGfcJ29/jQPmilfcesFd7/C9wmNdhc6MP1LXQMWYQCf1DJWU3mAruvcj
         VSTjJv155V5cR7axyUI56NVX8/PkCjukhMAhRrtdKZOD5MPj2icmtoMFrm8S26m99ClQ
         0E+zLlU9Awf6au7LNEX3N7+a+ZWaxfJf7GA4SACtNcF9dVAholJ8IrOlf70n6JmRA+Yz
         B25Q==
X-Forwarded-Encrypted: i=1; AJvYcCWe1ICOGMgyVMYpVHhLIgXxCqYsJJJfxxZWck1ksR3gs99WOk80k4Y94KQPFlrO17IaGfrw0ga9rfgx8lE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTa6+lkGnsA1Q2j3Ok3YK18rSeUFOMho/cWhWFxdiDOxv2S0Tb
	EZ47JpQnG7Q5J5bJGB6SUzRMgAkEbVQCYrzB4W2srr2cTHwPLch2RcxIJ+m+DAVE0tR8IC60Sa+
	L8g==
X-Gm-Gg: ASbGnctPJHerUNEppNPa1btj9mOm4BxuCXuU1a1d8O8oT2NEtCHyusPrf4UrxkQli8f
	xTOGVBWpuaWpb77nv8S2MEmAojYx79tkIIKkWZ1k2pkqHJC/LmvB2qGJ2jduIf+Hu/byvlkeM1a
	d/hxVyKG8LX1PjXp5lgjbkqSsWnhP612DLM8Z6aSzqD+8CQaHurVlPT/+K+CVDKvaVJFS+azltY
	6U3s0iXlZhAa8xEDI0bxjSCvoeGZT4Ob3gSN3FUNNYDFztDcLs6YpeDXhgFuphD60fcwqSTNPJM
	8RY9itQx7Kx+/g==
X-Google-Smtp-Source: AGHT+IG1Y7TRh4SpIkH/ZIhc+MbUAQn7srZxwuc8tuJmQFXhSSW1T759MFWs1C2rRNRX6k5DPJSZnw==
X-Received: by 2002:a05:6512:a94:b0:53d:d3ff:83c0 with SMTP id 2adb3069b0e04-53df00c607amr1993901e87.12.1732722253571;
        Wed, 27 Nov 2024 07:44:13 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2445a2csm2327758e87.30.2024.11.27.07.44.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 07:44:12 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53df1e0641fso781721e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 07:44:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUFMt3avOYy5ygM7Z2RIBLwObks4WAwPkIEPsYYnGflnTBtjfRfyVE40yBiS9iqu95vegIl7uDMeQNvrWU=@vger.kernel.org
X-Received: by 2002:a05:6512:2355:b0:53d:e5fd:a445 with SMTP id
 2adb3069b0e04-53df00dd3ddmr2419949e87.32.1732722252087; Wed, 27 Nov 2024
 07:44:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127105709.4014302-1-treapking@chromium.org>
In-Reply-To: <20241127105709.4014302-1-treapking@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 27 Nov 2024 07:44:00 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XhDdBJXfC72PZAbgaSpVx4ubtKSRFptock0SMRg=+Miw@mail.gmail.com>
Message-ID: <CAD=FV=XhDdBJXfC72PZAbgaSpVx4ubtKSRFptock0SMRg=+Miw@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: decrease timeout waiting for host sleep
 from 10s to 5s
To: Pin-yen Lin <treapking@chromium.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>, 
	David Lin <yu-hao.lin@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 27, 2024 at 2:58=E2=80=AFAM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> In commit 52250cbee7f6 ("mwifiex: use timeout variant for
> wait_event_interruptible") it was noted that sometimes we seemed
> to miss the signal that our host sleep settings took effect. A
> 10 second timeout was added to the code to make sure we didn't
> hang forever waiting. It appears that this problem still exists
> and we hit the timeout sometimes for Chromebooks in the field.
>
> Recently on ChromeOS we've started setting the DPM watchdog
> to trip if full system suspend takes over 10 seconds. Given
> the timeout in the original patch, obviously we're hitting
> the DPM watchdog before mwifiex gets a chance to timeout.
>
> While we could increase the DPM watchdog in ChromeOS to avoid
> this problem, it's probably better to simply decrease the
> timeout. Any time we're waiting several seconds for the
> firmware to respond it's likely that the firmware won't ever
> respond. With that in mind, decrease the timeout in mwifiex
> from 10 seconds to 5 seconds.
>
> Suggested-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> ---
>
>  drivers/net/wireless/marvell/mwifiex/sta_ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I believe Brian Norris is still anointed as the personally nominally
in charge of mwifiex upstream (get_maintainer labels him as "odd"
fixer, which seems awfully judgemental), so he should be CCed on
fixes. Added him.


> diff --git a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c b/drivers/n=
et/wireless/marvell/mwifiex/sta_ioctl.c
> index e06a0622973e..f79589cafe57 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
> +++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
> @@ -545,7 +545,7 @@ int mwifiex_enable_hs(struct mwifiex_adapter *adapter=
)
>
>         if (wait_event_interruptible_timeout(adapter->hs_activate_wait_q,
>                                              adapter->hs_activate_wait_q_=
woken,
> -                                            (10 * HZ)) <=3D 0) {
> +                                            (5 * HZ)) <=3D 0) {

Given that I suggested this fix, it should be no surprise:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Upon sleeping on the idea, the only slight concern I have here is
whether we'll trigger this timeout if we try to suspend while WiFi
scanning is in progress. I don't have any actual evidence supporting
this concern, but I remember many years ago when I used to deal with
the WiFi drivers more often there were cases where suspend could be
delayed if it happened while a scan was in progress. Maybe/hopefully
that's fixed now, but I figured I'd at least bring it up in case it
tickled anything in someone's mind...

If somehow that turns out to be a problem, hopefully we'd be able to
find a way to cancel the scan or break scans up into smaller chunks
because even delaying suspend for 5 seconds seems like it would be a
big problem.

-Doug

