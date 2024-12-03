Return-Path: <linux-kernel+bounces-430337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1B09E2F7D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 00:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9E6282C12
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 23:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9E1205ACE;
	Tue,  3 Dec 2024 23:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nI2b5BaJ"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAD78460
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 23:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733267117; cv=none; b=LCRSR/GB/rJpSj44z86iUp/bdUZ3KY5VLLP3xyLKQZoxVbARdhPbK6Z4ojKSDstsDEPf15DsqgIVL/RiEVXkgFrNbyPufKg1vKnE31SPbYINvveHA8GpPMi2zpdIdXoBmEo2Q1YuCmyNZytn+/7/nm15lbT5gff2ioawqrNfaik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733267117; c=relaxed/simple;
	bh=tCCvWq1dmiUGYNc6XoLfwju1glhutvBWzNPcvqslXxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rEGfTzMCQIhKnDP7uWwSZZ0lIh8UYt/DunZJ3pT1VAS7pcI1zPCM2/bB5lkrPUGXqYwY0yp5o1vxh6bwmmzLdR+3EGN/ArzYB6SGlSERnY1rlRuhmnfKK1LJ/Gl5Y7rtn9ofRY6HZ6RVWI5qrsmCF1Tzt0yUnNi8Wq+UiaYoHjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nI2b5BaJ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7258cf297d4so146756b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 15:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733267110; x=1733871910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuVSzwilGDWOKulMLoLFDmD1T0xJ+EejpQ1nF1fWuWk=;
        b=nI2b5BaJAFCuRQ36i32vS70RtMenOsw2RT3LYEmIS0Sm4I4kgg0e6JrX+ZEh571pzZ
         78fmpdgxP4DPn5sJ1d8sHQgPHPKbhhWJ+ms2zIXI8AcxMxrgOOcWcdWAhSYqAeQWouhA
         6TcUcOqjVMZMLMHuL/Muw688RO4cgIbBfF6kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733267110; x=1733871910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuVSzwilGDWOKulMLoLFDmD1T0xJ+EejpQ1nF1fWuWk=;
        b=w3yiKolBZkhig4O+izfczOpY0T+Ki55mQT4V0cX/oEeAb2cFQCjCwe4Op04jE9CSXv
         QbtcSxWCxUul0nFlGxzNZWVCnA/KnOcWdAsKAeg73EyrCVEVggNmNKZEIog24JLMfs0F
         FrDdna65iTzyYOfeBw5+I8Z94nEP4V1gZ5rkIsPdJelnSUJ0DjY/uugmQSXbNugHl0MZ
         bYb4P8vlbzFRAAI5nXsxpv+U19Xs73zPy5tEsNF1mKLuiJJ0/BssNQbvbGBcEYpfApgl
         A8WD607Ea1O8GtNuJ0zOuMar7ShGRa/8PrwuTdgoRQtQFen01eW7PTL1cRk3rVFNjZIp
         tlSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw8ujqH06oiQfF2F2SL0NEwHQXb1b+0G5LKBLhdbk7LPoSDYbm7wQy0ZA+kaE3u1vOqtDO73QWGsulgdE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdbjc6Qjv4opSR1vv3S2piv+t2kd4rm2grqPdxyHF6KnfuJn0a
	7K0OMf9so7H0hAtOnx4vUvEaLvuG5WMZ5UqlllWz5XXsZz0jjATrPEjbm+X0fhZBdPVM0znfn24
	=
X-Gm-Gg: ASbGncsF1r0t78yA+6SX7ZgL+cLwdcWiWz+eLazqDQAryxlSwyWhsT2i6h5PP6Rsjer
	rp29RRKpyjhHPh5RNKm/vIA7yvqT065LrKjjZhcWMG/1MxOnMpiJyl7C0PvFP0xrP5GVGZ97t7p
	yaMK47M2874jORM+WKtgndq9/B6T7vuwHN4d3Ly6CKM66Ph3ZhfFhMhC0PJeGFXcGn6J1awZNhJ
	+7n8CjbdQuQJsdh66hv5NL/TLvsrEYng7ODJeLa/qju1t6A6skqdSp+ojQUXhSek43D90nuXKbD
	gcHlu+OQr0zeefiW1zmflg==
X-Google-Smtp-Source: AGHT+IGdqmJqEM6tDa5d4rTT5TPkFnaxrsqm5h+AU1l6QHBWxsck+6kt6T46eRpAVVKt8Aq1OX8jRw==
X-Received: by 2002:a17:90b:1848:b0:2ee:d63f:d8f with SMTP id 98e67ed59e1d1-2ef011f682bmr5321613a91.13.1733267110379;
        Tue, 03 Dec 2024 15:05:10 -0800 (PST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com. [209.85.214.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2705d42dsm108588a91.8.2024.12.03.15.05.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 15:05:09 -0800 (PST)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2154dc36907so26385ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 15:05:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVmOSCjU6wbhMFrKoM2NhByslwshUOl/dLSyorEMhjN2BswL3qAIn+DqR86pNRaXehxecb8H2eiCpXEdww=@vger.kernel.org
X-Received: by 2002:a17:902:cf41:b0:215:3a16:6f82 with SMTP id
 d9443c01a7336-215d6c43a68mr851995ad.4.1733267108611; Tue, 03 Dec 2024
 15:05:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127105709.4014302-1-treapking@chromium.org> <CAD=FV=XhDdBJXfC72PZAbgaSpVx4ubtKSRFptock0SMRg=+Miw@mail.gmail.com>
In-Reply-To: <CAD=FV=XhDdBJXfC72PZAbgaSpVx4ubtKSRFptock0SMRg=+Miw@mail.gmail.com>
From: Brian Norris <briannorris@chromium.org>
Date: Tue, 3 Dec 2024 15:04:56 -0800
X-Gmail-Original-Message-ID: <CA+ASDXPXiyga6mKLBacupCXa0wsBbXCrmq20RFo7T2eSF8kbzQ@mail.gmail.com>
Message-ID: <CA+ASDXPXiyga6mKLBacupCXa0wsBbXCrmq20RFo7T2eSF8kbzQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: decrease timeout waiting for host sleep
 from 10s to 5s
To: Doug Anderson <dianders@chromium.org>
Cc: Pin-yen Lin <treapking@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, 
	Kalle Valo <kvalo@kernel.org>, David Lin <yu-hao.lin@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 27, 2024 at 7:44=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
> On Wed, Nov 27, 2024 at 2:58=E2=80=AFAM Pin-yen Lin <treapking@chromium.o=
rg> wrote:
> > In commit 52250cbee7f6 ("mwifiex: use timeout variant for
> > wait_event_interruptible") it was noted that sometimes we seemed
> > to miss the signal that our host sleep settings took effect. A
> > 10 second timeout was added to the code to make sure we didn't
> > hang forever waiting. It appears that this problem still exists
> > and we hit the timeout sometimes for Chromebooks in the field.
> >
> > Recently on ChromeOS we've started setting the DPM watchdog
> > to trip if full system suspend takes over 10 seconds. Given
> > the timeout in the original patch, obviously we're hitting
> > the DPM watchdog before mwifiex gets a chance to timeout.

The Kconfig default is 120 seconds, and it's hidden under
CONFIG_EXPERT. What makes you think 10 is a good value? (It sounds
pretty small for triggering panics.) The smallest I can see outside of
ChromeOS is 12 seconds, although 60 seconds is much more common. I
also happen to see other WiFi drivers have hit similar problems, but
they settled on 20 seconds (assuming a 60s timeout on other distros):
https://lore.kernel.org/linux-wireless/20230329162038.8637-1-kvalo@kernel.o=
rg/
https://git.kernel.org/linus/cf5fa3ca0552f1b7ba8490de40700bbfb6979b17

Technically, this Kconfig lets you set a value as small as 1 second. I
don't think we should work at reducing all timeouts to fit that
target.

I could maybe approve lowering this one, but I'd also recommend
reconsidering your timeout value. And more questions below.

> > While we could increase the DPM watchdog in ChromeOS to avoid
> > this problem, it's probably better to simply decrease the
> > timeout. Any time we're waiting several seconds for the
> > firmware to respond it's likely that the firmware won't ever
> > respond. With that in mind, decrease the timeout in mwifiex
> > from 10 seconds to 5 seconds.
> >
> > Suggested-by: Doug Anderson <dianders@chromium.org>
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > ---
> >
> >  drivers/net/wireless/marvell/mwifiex/sta_ioctl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I believe Brian Norris is still anointed as the personally nominally
> in charge of mwifiex upstream (get_maintainer labels him as "odd"
> fixer, which seems awfully judgemental), so he should be CCed on
> fixes. Added him.

I tend to see mwifiex patches even if I don't get CC'd, but thanks. I
wonder why get_maintainer(?) picked up Francesco properly but not me.
*shrug*

> > diff --git a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c b/drivers=
/net/wireless/marvell/mwifiex/sta_ioctl.c
> > index e06a0622973e..f79589cafe57 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
> > @@ -545,7 +545,7 @@ int mwifiex_enable_hs(struct mwifiex_adapter *adapt=
er)
> >
> >         if (wait_event_interruptible_timeout(adapter->hs_activate_wait_=
q,
> >                                              adapter->hs_activate_wait_=
q_woken,
> > -                                            (10 * HZ)) <=3D 0) {
> > +                                            (5 * HZ)) <=3D 0) {
>
> Given that I suggested this fix, it should be no surprise:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> Upon sleeping on the idea, the only slight concern I have here is
> whether we'll trigger this timeout if we try to suspend while WiFi
> scanning is in progress. I don't have any actual evidence supporting
> this concern, but I remember many years ago when I used to deal with
> the WiFi drivers more often there were cases where suspend could be
> delayed if it happened while a scan was in progress. Maybe/hopefully
> that's fixed now, but I figured I'd at least bring it up in case it
> tickled anything in someone's mind...

Scans should essentially have been canceled by now, but IIUC, the
driver doesn't really force the card to stop if it's in the middle of
a scan (I'm not 100% sure if it's possible). So it's possible that
pending scans could delay this step.

I wonder what the distribution of (successful) timing is today. I'd
assume this typically take on the order of milliseconds, but do we
commonly see outliers? What if a system is fully loaded while
suspending? Can you try testing (and gather timing numbers) when
suspending soon after initiating scans? It's hard to judge what the
lower limit of this timeout should really be without any numbers, just
like it's hard to judge whether your 10 second watchdog is reasonable.

Also, for the record, since we might have to field regression reports
for other systems: what hardware (chip variant, FW version) are you
seeing problems on?

Brian

