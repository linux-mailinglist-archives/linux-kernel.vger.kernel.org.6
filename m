Return-Path: <linux-kernel+bounces-296161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BD795A668
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747681C22637
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 21:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C529175D30;
	Wed, 21 Aug 2024 21:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bNjkjQei"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE76170A36
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 21:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275155; cv=none; b=C/dYgiTpNKC51p/ZbXjYA6vr8n7TNDJ4wkDX9JAAqpwHcKZCD26YsRC5F9tWgT3a6AP9XDpPRDeuW9lHfQ3/4GXGJAzr2D+I9AE9FZvfmHhaH+tN/JKWxXjHi0+mXzwAHJf/zXHIRYqTlbxOMN/z8Xx3Yi+FBl5JTGWi4Alu84Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275155; c=relaxed/simple;
	bh=hwIqym5Mq22k+IOcOcKfcjl1vWN3BDhdby9UJo1dl0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qpAGZlger+JlTgTqOBo6nrVBOvsU1Vq97II1EpvApyvClOL8R1q1I5tSu26p6MZEPZ/WnN4mem/VRBtEWm2ptq51LUOshWgugmyHfAROuTB6/Z6bwRD6ZBEOKciUVrJMvzGaHpNAWlpXAX/pBJIVZpclOb7bjwaTUKrXxXq5PK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bNjkjQei; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a1d5f6c56fso11595385a.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724275151; x=1724879951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mMqsV426iAd7wqkB5gTGvJ52fuCD5N8hcVLuM2nRtU=;
        b=bNjkjQeiVDuLAo5yWpJaLdDvRGtdOhNqKKf54ToDK/RxIUHDeFPzn+uGT0uulYfyrp
         OxVTKFzWW9zDqezNoYhAVVLuB4mwNwKWHVsaVbP+nwjmE8Xq3T3wyp8p+Ws0pzTwJQ5n
         3Ypv32J72rHCuXWxVng9z1L9PoY4gW8P/+Gj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275151; x=1724879951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8mMqsV426iAd7wqkB5gTGvJ52fuCD5N8hcVLuM2nRtU=;
        b=FZlnPwQWnaucdpwauEL/TO1ASkI4ZYrB3SL4TwiYomgmPw912qlASdjiujA7yYySRY
         0kc9A0TNhTX6ryr6ZkK2KSKjlBNe+8XalQWP5RHF8jqCbUvFmY0BEhBs7RnwlhZBgr4L
         AjrhvgA4cTjfm+wIWq2qa4VvHV6puLyiVnvqqwM42owiIam11ZGQKzomtf9bktIQ6mNE
         GPQuAz4ouAqT43XIHXyHp8tWSRFG2ww/39oSXnRazseLQDxlGRMPBnotMFCcjj+bPx46
         W3EzGHEGEOTtP535tXDc/nG5cTb6EbHHn9GBGtTlXz6HgK1wy47SQtU7Z9Z7eIr+5mCA
         /UDA==
X-Forwarded-Encrypted: i=1; AJvYcCVT4yar+m5J6TYZHYwtRfbDv37nGiSAFZY8rANBxZI36jC1+juz6JCaRrbgZoOO4lwoNlSvmO0SeB8GMTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvluX3bsgou9fRknIVkX0hhqpxHwZn0ckNbjuJ9Wx/9jzdroZJ
	kUoU1ShzNgZNZ8DSTS1ILONluiOIY0bDALGKIE4+NqDJE5us2W854FMTjRZfFQ7j2pVdB6Gj7TT
	+9w==
X-Google-Smtp-Source: AGHT+IEp6AOP0X/s9d3CbBg3Qund+b0ubZNtvrD9jQNkzSFm5owRMl71qyoBOusVGn4+cM2ULB6fwA==
X-Received: by 2002:a05:6214:4613:b0:6b7:d793:ae71 with SMTP id 6a1803df08f44-6c155d91e19mr51595346d6.25.1724275151562;
        Wed, 21 Aug 2024 14:19:11 -0700 (PDT)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com. [209.85.222.181])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162db1e9asm881386d6.80.2024.08.21.14.19.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 14:19:10 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a1dd2004e1so10670785a.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:19:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWnmdd1TG56SwH54bD4dDiRLYVYNAMi5gg47mckOckslh21KNA0ujW/nFaECu1bbbjtvmkAkxFU95shwYU=@vger.kernel.org
X-Received: by 2002:a05:6214:4301:b0:6bf:786d:45cf with SMTP id
 6a1803df08f44-6c155d8bf66mr46298786d6.22.1724275150045; Wed, 21 Aug 2024
 14:19:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517170246.1.Ia769fe5fbeaa6aca2edfb01b82eb7df0c6955459@changeid>
 <CAD=FV=Wd4UdjGdFODGCa4acviQG2V_YuM9J8oxi8A--ZmseNUA@mail.gmail.com> <CAD=FV=WqyEo9mWgYyRQjLmhh1pNTNTFM1zwbi2g0n9FMseUtHg@mail.gmail.com>
In-Reply-To: <CAD=FV=WqyEo9mWgYyRQjLmhh1pNTNTFM1zwbi2g0n9FMseUtHg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 21 Aug 2024 14:18:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VKogUZEhON5D9zM7hrLKzfBro-HPVuNqdy0HNozDJmaQ@mail.gmail.com>
Message-ID: <CAD=FV=VKogUZEhON5D9zM7hrLKzfBro-HPVuNqdy0HNozDJmaQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: If memdump doesn't work, re-enable IBS
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Stephen Boyd <swboyd@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	Johan Hovold <johan+linaro@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Sai Teja Aluvala <quic_saluvala@quicinc.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 31, 2024 at 1:29=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Mon, Jun 10, 2024 at 4:52=E2=80=AFPM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Fri, May 17, 2024 at 5:03=E2=80=AFPM Douglas Anderson <dianders@chro=
mium.org> wrote:
> > >
> > > On systems in the field, we are seeing this sometimes in the kernel l=
ogs:
> > >   Bluetooth: qca_controller_memdump() hci0: hci_devcd_init Return:-95
> > >
> > > This means that _something_ decided that it wanted to get a memdump
> > > but then hci_devcd_init() returned -EOPNOTSUPP (AKA -95).
> > >
> > > The cleanup code in qca_controller_memdump() when we get back an erro=
r
> > > from hci_devcd_init() undoes most things but forgets to clear
> > > QCA_IBS_DISABLED. One side effect of this is that, during the next
> > > suspend, qca_suspend() will always get a timeout.
> > >
> > > Let's fix it so that we clear the bit.
> > >
> > > Fixes: 06d3fdfcdf5c ("Bluetooth: hci_qca: Add qcom devcoredump suppor=
t")
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > > I'm nowhere near an expert on this code so please give extra eyes on
> > > this patch. I also have no idea how to reproduce the problem nor even
> > > how to trigger a memdump to test it. I'd love any advice that folks
> > > could give. ;-)
> > >
> > >  drivers/bluetooth/hci_qca.c | 1 +
> > >  1 file changed, 1 insertion(+)
> >
> > Totally fine if you just need more time, but I wanted to follow up and
> > check to see if there is anything you need me to do to help move this
> > patch forward. If not, I'll snooze this patch and check up on it again
> > sometime around the end of July.
>
> It being the end of July, I'm back to check up on this patch. I
> checked mainline and bluetooth-next and I don't see any sign of this
> patch. Is there anything blocking it? Do you need me to repost it or
> take any other actions?

I feel like I'm shouting into the wind. Am I following some incorrect
process for submitting this patch? Can anyone suggest something I
should do differently to get a response here?

Thanks!

-Doug

