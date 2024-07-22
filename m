Return-Path: <linux-kernel+bounces-259270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7644C939349
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05FDE1F20FA0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E191016F0C2;
	Mon, 22 Jul 2024 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="paTEZkxY"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5F61401B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721670127; cv=none; b=hz5NVL3nwANUlqJVuO6ebe0ZKOGRO0USFUzEKAhdom6btkFkCI1Fst4Scbu6debZI+4EoPEEFPmHPESNK4S/NDuWmDVgohB4bTA55ljfFr0Jo2G4MIhbSdW8td7nNVjgN4YBcpUnOCdTikv6D/i8Qn6YqDoS+aAIRE/mZZIrbB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721670127; c=relaxed/simple;
	bh=ugor9w5E1mjhIPRTlWtgixZzPX0NqkshVh+YsIeluos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OG/Wry/1kXgPS1wH4Zsutya3skGMrbL+Pl3awi54YwnGFkKTh2iwCQ8EgQt92EUtB9lGVPDn0VskrvHsttLgXh3tRWWZpJ6gAkX/PbYneN2ZXhy9jx2+i2Zspjn6P0Ig9t0Pd5xFu+aUzIZZhm/eqGAKwckf5qwmV9Ylyd/bNDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=paTEZkxY; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.harvard.edu
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-664ccd158b0so45531827b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1721670124; x=1722274924; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GEAsfep1o9bHfuVcReQXlWhCpCPBZX/z+vcGE41Ain8=;
        b=paTEZkxYSt7I+TVvHCcf+cG5Ttrag7DgIl4cZBYjlLk+dpYuYmUiuA8KbUGaTGLIaK
         VzgjmAce1n9PalHB+8AKdYvOlBBOAD/P/0XFkG/FxG2jKPxXEDRZ2aKkdiughOvxXAuF
         DINQzhiMgVUW9oerS290WLshnq4ry/zaHwzpsPXkV99QxCYZvThj783DZJeKBgTqoHaf
         xIMb8NDkflriruhA3TQ018UdfkFWJEfH82JfyZ7nZO76e+Qc5wdBhH8QyNN1BPcnLOfO
         HW0AJG11EaIA3ndZT3pWv8StByDEOITeEXSMFMVgd8hOOFplW3dt9gmZYA5O4kHInyQo
         PQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721670124; x=1722274924;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GEAsfep1o9bHfuVcReQXlWhCpCPBZX/z+vcGE41Ain8=;
        b=jS68rDBRT4TpYfQXOxmQ3S+Rjzimg/QQdei6/RROs+xhvDNjrJBsWjPw6ynai75GU+
         5/GxQTScUJ/uQbtoGL5NIuD9nW/OseBoM6rThdulstushXwj8uFsbHuI3qRKMPBcZYrI
         SAqlqYh1tBup9l8jWZYUTvyoRBRsDv+7rfhff6S0V260GXmVr+9jDpGbJcqs7EwL8BXL
         Q4PNOmuL9MFm50JjBAx77A5d/0KdvjqeG6mPWT5vzqG696n+DJVuNyzqfdWiQv1lZ7nl
         J0SCdyOcaylRewvjUnTtlGDHJgnYqTaGsD/mpDgjcRlqgR2C9HFEmEvLImSJFlnIiqMF
         e7cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBkLm+yTGzErqlwUU4E/2p8Vf0KW9ZiG6g3wevjLiYoyYKw3DyTWdIaHEEQNbl84F4ZoGpOGVSEyq5DDUfm6voC3i5W/qk7vDQ7qda
X-Gm-Message-State: AOJu0YxieJbtf8GsVHLhMYofK6InaBKuBQu3JXQL4K3Sh4izsh47b37G
	zPbnsLUc1uHyoOk4hRqsxL72VKsq2f8GpCAguF91RRum27YOLlmW8EbBseNF6A==
X-Google-Smtp-Source: AGHT+IHj+m1AO569rZQrG4jvehlr1DtinQEuf9uup9u3ryjKrg2R5yTBlWyPsl8/KQkTrF2H/4zZkw==
X-Received: by 2002:a0d:cd82:0:b0:62f:a250:632b with SMTP id 00721157ae682-66e4b8e155cmr5726207b3.8.1721670124661;
        Mon, 22 Jul 2024 10:42:04 -0700 (PDT)
Received: from rowland.harvard.edu (iolanthe.rowland.org. [192.131.102.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a19905a8f3sm383032885a.80.2024.07.22.10.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 10:42:04 -0700 (PDT)
Date: Mon, 22 Jul 2024 13:42:01 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Chris Wulff <crwulff@gmail.com>
Cc: linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Roy Luo <royluo@google.com>,
	Krishna Kurapati <quic_kriskura@quicinc.com>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	yuan linyu <yuanlinyu@hihonor.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: core: Check for unset descriptor
Message-ID: <97672e7a-edb4-4a00-b404-c5891319912e@rowland.harvard.edu>
References: <20240721192048.3530097-2-crwulff@gmail.com>
 <29bc21ae-1f8a-47fd-b361-c761564f483a@rowland.harvard.edu>
 <CAB0kiBJYm9F4w5H8+9=dcmoCecgCwe6rTDM+=Ch1x-4mXEqB5A@mail.gmail.com>
 <b35e043d-a371-4cf9-b414-34ba72df1ccc@rowland.harvard.edu>
 <CAB0kiBKDB=1kF4YRXckph4QG7tQbDdBMsOtcQh9+p1jtyokdPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB0kiBKDB=1kF4YRXckph4QG7tQbDdBMsOtcQh9+p1jtyokdPw@mail.gmail.com>

On Mon, Jul 22, 2024 at 01:11:01PM -0400, Chris Wulff wrote:
> On Mon, Jul 22, 2024 at 9:38 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Mon, Jul 22, 2024 at 09:00:07AM -0400, Chris Wulff wrote:
> > > On Sun, Jul 21, 2024 at 9:07 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > >
> > > > On Sun, Jul 21, 2024 at 03:20:49PM -0400, crwulff@gmail.com wrote:
> > > > > From: Chris Wulff <crwulff@gmail.com>
> ...
> > > The previous check was also hiding the error, and introduced a panic.
> > > I could add a printk to that error case, though it would be unassociated
> > > with the gadget that caused the problem. This function does also return
> > > an error code when it fails, so the calling function can check that and
> > > print an error.
> >
> > Okay.  It wouldn't hurt to print out an error message, even if there's
> > no way to tell which gadget it refers to.  A dump_stack() would help in
> > that regard, but it won't be needed if the guilty party will always be
> > pretty obvious.
> >
> > By the way, how did you manage to trigger this error?  None of the
> > in-kernel gadget drivers are known to have this bug, and both the
> > gadgetfs and raw_gadget drivers prevent userspace from doing it.  Were
> > you testing a gadget driver that was under development?
> 
> I am working on adding alternate settings to UAC1/2 gadgets, so this really
> was a case of trying to make the failure in development easier to deal with.
> I don't believe there are any problems with existing gadgets causing this.
> 
> I will add an error message and submit a new version. Perhaps
> WARN_ON_ONCE would be appropriate here to get that backtrace
> instead of a printk?

That sounds good.  You should also mention in the patch description that 
the purpose is to prevent undebuggable panics during driver development, 
and no existing drivers will trigger the warning.

Alan Stern

