Return-Path: <linux-kernel+bounces-210078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAE1903F15
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9142D1C23128
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BC8125A9;
	Tue, 11 Jun 2024 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmixNAO3"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A421CD2B;
	Tue, 11 Jun 2024 14:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718117138; cv=none; b=j38oZzz8v+2iIbZQ7peXsllSYQtK6gh4Gg4k8M1bZ+Kw42UAR9Z6C1vDzSv3uj9KFyf4bvN4jfBFcG01pWnD7HRfMtO6BQH2eJXjH+aHQgLqWZYZVs12RPqUvu2+c00nO3U2XU1/yhu3rhy0FL2tHEbOSyv+RYRLptdryvxZWj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718117138; c=relaxed/simple;
	bh=/H9XWnYs0Gk9ZeqHTnYujfKVyliogBQwwJWeAfHwh98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q6wxpCU4nASVbcUmKFDtR01Lv3LyB2zIRcs0FmEis+uS0ZurjgiU1fWzjN9ZTCewLSig3waHa37Kmi8xskO8ErkLGKd7v4L8cs9g6LCc0qfG7RfdRRiFz/fqsnvskacdirlN1OCOHtdIlwgaINHChzZykQQtYxuODI/zM5dmexw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmixNAO3; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57c83100bd6so3012020a12.3;
        Tue, 11 Jun 2024 07:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718117135; x=1718721935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDmcQfJiJg3AhnNDskLBlCw1R+pPrp3kDPPVyHiSs34=;
        b=FmixNAO3O1YHsSEWlGUa8WiSiUhz4+org9mTv2BvJHGls82Ie0d1QH15vBw83RWO+q
         gQxuH1tMJ6VWhohRIu7DFM772BfkMTcpPT8FLJPjy1EhcGSreL1Xi1soghw7p7EEB5je
         rq7Y7gYFDF3ikhRzMZc72q2JqBF6M0ceAfPRqR+wpzW5Ba4ciG6bWMz+r6TzeD6bDE2J
         wFMAdU4UzNMiwBMs/qV7Oro8+RoATZ4d9+XqNJKREpaOfSE42YRCyqP5i7U5ccFyjyPn
         L8OdkbWzxz0wQTdfy5sG3XYFOHRozf3d0iUkPyvsRWuUAlixhPHs6ufjBxcarGT64HI3
         AZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718117135; x=1718721935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDmcQfJiJg3AhnNDskLBlCw1R+pPrp3kDPPVyHiSs34=;
        b=n5hY09PCY7I2Kn+G6G33ejnKq9y7rGW9EDPgR9gGOZuGgvJdOLvzdvQWU2cMdUBrTw
         v2cgJ93C62dbPVbLCZ5yHtY8HWRWzb1b2NLV3oZLLSLBLahHZxGSUfPFCSIMMh90MSC+
         8BgYnRDZl4PKlpavr0a5kBi1WSpxdcswewah97KkX+j1TPnLCeZqccLu4EaRIEFOyE5S
         flD1QESbp6zD6a3vYDTBVfp5CeDOAO+VTEZIZ3yWr72G4rywZOmyyKdrxXNAbxbuInnq
         3MDz6kCM7Jmp/k7c7EAvANysfbVnapecIzLucw6san1FRloMvi/tygd7ozMRkFJDN7g2
         ryYw==
X-Forwarded-Encrypted: i=1; AJvYcCX5EJLYIRci5+SOconfn80861dm0w1OMljKLRUE3vmuY9dvsQrdUY7rHMXNYhBWCcfyHovEDtT1Du7ocK3EdIeMmKwSBYvKFFvxBV6VsXD2n8t9vr3ZMStzGwNHGE/gR4rkOADVDndb
X-Gm-Message-State: AOJu0YxTsQjLUAmkzscFjUqAhXA8Djp7d3S/XhKkRUMXPANevG9r/L8G
	Lhkc9pdKMV5lB8GH4AxQvu+n0BFCaS3+5P/904AzrreaqjCHMOmEiWgrpSWiTp0pejZZ7E6taUg
	tZXIAVM/QzCs4xb9PtYo5om2i6z0=
X-Google-Smtp-Source: AGHT+IG7CIRLR+hJ7GJps0P7xxR9z8sOBVvX+i3dYJEQm0KFaH57K3LlfTaYAM4fsZpZAwb91tP+V4bjqE7cM6tk0YY=
X-Received: by 2002:a50:8d5c:0:b0:578:3335:6e88 with SMTP id
 4fb4d7f45d1cf-57c506bf7a9mr8912411a12.0.1718117133955; Tue, 11 Jun 2024
 07:45:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601120640.73556-1-joswang1221@gmail.com> <1662c9c9-7330-4794-843a-940f05802021@linux.intel.com>
 <CAMtoTm1u+8ynBRaWgCMVgaR+dBoZfNGhzGqmvooBSDxZm5Qx+g@mail.gmail.com>
 <c9430561-ecfe-5b36-9574-73a946410eea@linux.intel.com> <CAMtoTm1xYUuaV1rO3dZexS=q_5Xf61+QAZ1++VvzK10VtGHexA@mail.gmail.com>
 <2521588d-30a6-0224-c7c9-3015e9cc65a3@linux.intel.com>
In-Reply-To: <2521588d-30a6-0224-c7c9-3015e9cc65a3@linux.intel.com>
From: joswang <joswang1221@gmail.com>
Date: Tue, 11 Jun 2024 22:45:26 +0800
Message-ID: <CAMtoTm2G-w+yRjechji7scJO-JZo6N==VK6Wun3ATRc7do9rEg@mail.gmail.com>
Subject: Re: [RFC 1/1] usb: host: xhci-plat: add enable XHCI-AVOID-BEI quirk
 by dts
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	joswang <joswang@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 6:01=E2=80=AFPM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> On 6.6.2024 17.08, joswang wrote:
> > On Wed, Jun 5, 2024 at 6:31=E2=80=AFPM Mathias Nyman
> > <mathias.nyman@linux.intel.com> wrote:
> ...
> >>
> >> I was thinking of turning XHCI_AVOID_BEI behavior into the new default=
, so no
> >> quirk flag would be needed:
> >>
> >> Currently without the quirk flag:
> >>
> >> - ISOC TRBs trigger interrupt if TRB is the last in the TD
> >>
> >> Currently with XHCI_AVOID_BEI quirk flag:
> >>
> >> - ISOC TRBs trigger interrupt if TRB is the last in the TD
> >> - Interrupt is additionally triggered every 32 isoc TRB (initially).
> >> - if more than 128 events are processed in one interrupt then the
> >>     32 is halved, and we trigger an interrupts every 16th isoc TRB, an=
d so
> >>     on, 16 -> 8...
> >>
> >> I would remove the quirk flag, and make all controllers interrupt
> >> behave as if it was set. i.e. interrupt at least every 32 isoc TRB
> >
> > Thank you for your detailed analysis.
> > Excuse me, I have a question, do you mean to set "Currently with
> > XHCI_AVOID_BEI quirk flag" as the default behavior?
>
> Yes, unless it causes some issues or there are strong objections
>
> >>
> >> Is there an actual real world case where interrupting every 32nd ISOC =
TRB is
> >> too often?
> >
> > I mean that if the XHCI_AVOID_BEI quirk flag is set, an interrupt will
> > be triggered every 8 TRBs, which makes the interrupts seem to be quite
> > frequent.
> > Thanks
> > Jos
> >
>
> It should start with interrupting every 32nd isoc TD, not 8th
>
> #define AVOID_BEI_INTERVAL_MAX   32
>
> ir->isoc_bei_interval =3D AVOID_BEI_INTERVAL_MAX;
>
> Thanks
> Mathias

As you mentioned=EF=BC=8Cif more than 128 events are processed in one
interrupt then the 32 is halved, and we trigger an interrupts every
16th isoc TRB, and so on, 16 -> 8...
xhci_handle_events()
    ......
    if (event_loop++ > TRBS_PER_SEGMENT / 2) {
         if (ir->isoc_bei_interval > AVOID_BEI_INTERVAL_MIN)
              ir->isoc_bei_interval =3D ir->isoc_bei_interval / 2;
    }
    .......

Thanks
Jos Wang

