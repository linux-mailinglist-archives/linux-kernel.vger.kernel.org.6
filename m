Return-Path: <linux-kernel+bounces-229069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8C3916A6D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED48B1C22B07
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB802170833;
	Tue, 25 Jun 2024 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mVFPbuQo"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E426617082C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325802; cv=none; b=f1e1JQvdfUodK08YAJ/vcsfPt6SdOwMpTmqve+YLUek6vjUZlgDjXIqD4QJIGJeoe2R/PasN0xbJiMRDo6csWy7Z08Fn6lukWz3eRUZKmDxTLXToApTfDx8FEM4zg1viQYYD94bs88oVLG0b3pZjh9QaiLvql8A1EFfO98CrVek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325802; c=relaxed/simple;
	bh=3EIzMljfAaU3wCaMbC7Pba/i+sfkfKx7n6Gz4/CnmUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRc2bZsZ1XoDxxOwG8i4uSO85mzscipHMR1iWx7KC6cwwX62jEirYemT79+FiIxROlWVk+E8fC4wJXicOW9Nl3K4PSMlYipsHR0qG6xhJ3NrU/I7ubYqiDN6CJ1Uxmib+hXxJwRie4dkqnURSYJXl5qAtpoh/cNyqQZvl2rslmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mVFPbuQo; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79c054b65d4so42830285a.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719325797; x=1719930597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rE7xcwL4aw1Y8733YCjFqr/6uCmUd8iYLZuXHEHpnO4=;
        b=mVFPbuQoHRH71lXnb9IAVmFah9JriWC8Nr8Ghb4iP2XyVPguQ8Ij3y5BGEITsbd/+4
         MRPtcSeWTnTnonZ//YJSGydn3Op4vmqpptJfYg2bdK5FFtdLpikCSLbPTZyaDTlz4qlS
         +tBQG5jOW2mg7CRHN2vtBnhIxZXY7p/ig1feg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719325797; x=1719930597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rE7xcwL4aw1Y8733YCjFqr/6uCmUd8iYLZuXHEHpnO4=;
        b=kySEhj0ww0YBHnIe2taxLliwXD94/TowxN8ksFT1RQSW5JnYoJWZ9imemWlA/qxr3E
         8TNCqOKO818H9S8VeYK+wB/0qPKXA1jBtee9FZevJx5mDY7itIj4Ei+wbJ+ET+0aYGBg
         cJ/XHaLlAM9qrPYk5mw81M2bAyxk+btG2J7c+9nVPRhqjJ/KXWifQaRiDuuJoM5VR5xp
         bCI2cCSKLSC9pGuV/zSR8OHvgU7E2cToBUmBe3NiSdIrk8z0naPiC5JfbqP2+bx0LNS3
         P8y/car1OwDVchY+Kh11nUOopuAW9NzUJShENwO77WXaOKRCdWohUVhf483JTsdEQ3wW
         Wcrg==
X-Forwarded-Encrypted: i=1; AJvYcCX1+V1E+5/DiDyMxPEufohdZHY7jZV2g0Zq7FHjliO9mZDQ6spUVl0X/ISMDcicceOD+gG2r1cA84IxViUHTWpiCeR7EjphLqR4sflH
X-Gm-Message-State: AOJu0YzeZ1JOeYUqEyTxMgWfbDqgVVB6CdAcwNmnq35yA1N4JyrYN8eg
	FUfYxIDDXmjFAmCMHCTyBS6/vab6/HKmbFMBcwBNKj1iqicMMEGLETbP538FDjcdvIdwfWH9dXQ
	=
X-Google-Smtp-Source: AGHT+IGCIwl8tXouGEETuCoFYKVXF0S+XKO+e04zch5E5c4sBfkQlO9X5LQJqYcVkE9m1QVBbtEwoQ==
X-Received: by 2002:a05:620a:2942:b0:795:5a3f:3741 with SMTP id af79cd13be357-79be0dc0dfdmr1126904785a.68.1719325796744;
        Tue, 25 Jun 2024 07:29:56 -0700 (PDT)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce89be37sm409403685a.17.2024.06.25.07.29.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 07:29:55 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-444fe7e9f11so153701cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:29:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWwPKEl74GeGk9laQ+MWtN75C5Gvq7K/354P81qs5j2dcZdpUKFeXySk9jWyd3FlUt/E46ZrsIIW4H3IufVTjeAQBxeYxVnBHl+2phL
X-Received: by 2002:a05:622a:18a9:b0:444:ee24:8dc8 with SMTP id
 d75a77b69052e-444f2566c83mr3834021cf.22.1719325794420; Tue, 25 Jun 2024
 07:29:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610222515.3023730-1-dianders@chromium.org>
 <20240610152420.v4.8.I1af05e555c42a9c98435bb7aee0ee60e3dcd015e@changeid>
 <Znlp1_F1u-70D3QQ@hovoldconsulting.com> <CAD=FV=XmuKUKvCq7gG+wM-jAAgHLHnYw4NteFEKz5Fmczd=U7g@mail.gmail.com>
 <ZnqoKDnUMxqf7QRy@hovoldconsulting.com>
In-Reply-To: <ZnqoKDnUMxqf7QRy@hovoldconsulting.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 25 Jun 2024 07:29:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ux+ro90xnEEnALiwtjnOk+LT_qaHmE8jS7adWgBPSDbg@mail.gmail.com>
Message-ID: <CAD=FV=Ux+ro90xnEEnALiwtjnOk+LT_qaHmE8jS7adWgBPSDbg@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] serial: qcom-geni: Rework TX in FIFO mode to fix hangs/lockups
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Yicong Yang <yangyicong@hisilicon.com>, Tony Lindgren <tony@atomide.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Johan Hovold <johan+linaro@kernel.org>, 
	John Ogness <john.ogness@linutronix.de>, linux-arm-msm@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Stephen Boyd <swboyd@chromium.org>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 25, 2024 at 4:21=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Mon, Jun 24, 2024 at 02:15:07PM -0700, Doug Anderson wrote:
> > On Mon, Jun 24, 2024 at 5:43=E2=80=AFAM Johan Hovold <johan@kernel.org>=
 wrote:
>
> > > As I mentioned last week, the slowdown from this is quite noticeable
> > > (e.g. 25% slowdown at @115200), but this may be the price we need to =
pay
> > > for correctness, at least temporarily.
> > >
> > > An alternative might be to switch to using a 16 byte fifo. This shoul=
d
> > > reduce console latency even further, and may be able avoid the idling
> > > UART penalty by continuing to use the watermark interrupt for refilli=
ng
> > > the FIFO.
> >
> > I'm a bit confused. Right now we're using (effectively) a 64-byte
> > FIFO. The FIFO is 16-words deep and we have 4 bytes per word. ...so
> > I'm not sure what you mean by switching to a 16-byte FIFO. Do you mean
> > to make less use of the FIFO, or something else?
>
> I meant switching to using one-byte words so that we end up with a
> 16-byte FIFO where we don't have the issue of adding more data when the
> last word is not a full four-byte one.

Ah, I get it! I guess I would have described it as 1-byte per FIFO word.

Certainly that seems like something that's worth trying but, at least
in the past, I remember getting noticeably worse performance with it.
We used to be in that mode when kdb was enabled which I run with most
of the time. Depending on what you set the watermark level to you may
either end up spending a lot more resources servicing interrupts or
you might end up back in the case where you're stalling the transfer
because you couldn't service the interrupt fast enough. At 115.2, each
byte is about 87 microseconds, and draining a 16-byte FIFO is about
1.4ms. If you set the watermark at halfway then you'll get an
interrupt every 8 bytes or ~8x as many interrupts as with my patch
series. You'll also stall any time your interrupt latency is worse
than 694 microseconds. Hopefully that's not too often, though the
slowdowns you measured below make me worried.


> > Overall the big problem I found in all my testing was that I needed to
> > wait for a "command done" before kicking off a new command. When the
> > "command done" arrives then the UART has stopped transmitting and
> > you've got to suffer an interrupt latency before you can start
> > transferring again. Essentially:
> >
> > 1. Pick a transfer size.
> > 2. You can keep sending bytes / using the FIFO efficiently as long as
> > there are still bytes left in the transfer.
> > 3. When you get to the end of the transfer, you have to wait for the
> > UART to stop, report that it's done, and then suffer an interrupt
> > latency to start a new transfer.
> >
> > So to be efficient you want to pick a big transfer size but if there's
> > any chance that you might not need to transfer that many bytes then
> > you need to figure out what to do. If you can handle that properly
> > then that's great. If not then we have to make sure we never kick off
> > a transfer that we might not finish.
>
> Right. But with a 16 1-byte word FIFO, we may be able to kick of a
> really long transfer and just keep it running until it needs to be
> kicked again (cf. enabling TX). The console code can easily insert
> characters in the FIFO while the transfer is running (and would only
> have to wait for 16 characters to drain in the worst case).
>
> Effectively, most of the identified issues would just go away, as
> there's basically never any need to cancel anything except at port
> shutdown.

Yeah, though you'd still have to make sure that the corner cases
worked OK. You'll have to pick _some_ sort of fixed transfer size and
make sure that all the special cases / console / kdb work if they show
up right at the end of the transfer.

I was also a bit curious if there could be power implications with
leaving an active TX command always in place. Perhaps geni wouldn't be
able to drop some resources? Do you happen to know?


> > I'd also mention that, as talked about in my response to your other
> > patch [1], I'm not seeing a 25% slowdown. I tested both with my simple
> > proposal and with this whole series applied and my slowdown is less
> > than 2%. I guess there must be something different with your setup?
> > Trying to think about what kind of slowdown would be reasonable for my
> > patch series at 115200:
> >
> > a) We send 64 bytes efficiently, which takes 5.6ms (64 * 1000 / 11520)
> >
> > b) We stop transferring and wait for an interrupt.
> >
> > c) We start transferring 64 bytes again.
> >
> > Let's say that your interrupt latency is 1 ms, which would be really
> > terrible. In that case you'll essentially transfer 64 bytes in 6.6ms
> > instead of 5.6 ms, right? That would be an 18% hit. Let's imagine
> > something more sensible and say that most of the time you can handle
> > an interrupt in 100 ms. That would be about a 1.7% slowdown, which
> > actually matches what I was seeing. For reference, even an old arm32
> > rk3288-veyron device I worked with years ago could usually handle
> > interrupts in ~100-200 ms since dwc2 needs you to handle at least one
> > (sometimes more) interrupt per USB uFrame (250ms).
> >
> > ...so I'm confused about where your 25% number is coming from...
>
> I didn't do an in-depth analysis of the slowdown, but I did rerun the
> tests now and I'm still seeing a 22-24% slowdown on x1e80100 with rc5.
> This is a new platform so I compared with sc8280xp, which shows similar
> numbers even if it's slightly faster to begin with:
>
>                                         sc8280xp        x1e80100
>
>         rc5 full series                 61 s            67 s
>         rc5 last patch reverted         50 s            54 s
>
> I have a getty running and cat a 10x dmesg file of 543950 bytes to
> /dev/ttyMSM0 from an ssh session (just catting in a serial console gives
> similar numbers).

That's really weird / unexpected. Your hardware should be fancier than
mine so, if anything, I'd expect it to be faster. Is there something
causing you really bad interrupt latency or something? ...or is some
clock misconfigured and "geni" is behaving sub-optimally?

...although it wouldn't explain the slowness, I'd at least be a little
curious if you've confirmed that you're running with a 16-word FIFO
depth. See the function geni_se_get_tx_fifo_depth() where newer
hardware can actually have larger FIFO depths.

Just in case it matters, I'd be curious if you have
`CONFIG_IRQ_TIME_ACCOUNTING=3Dy`

Oh: one last thing to confirm: do you have kernel console output
disabled for your tests? I've been doing tests with the kernel console
_not_ enabled over the serial port and just an agetty there. I could
believe things might be different if the kernel console was sending
messages over the same port.

-Doug

