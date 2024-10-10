Return-Path: <linux-kernel+bounces-358255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C25C997C12
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D46401F24BF7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 04:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5201C19EEC0;
	Thu, 10 Oct 2024 04:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="IH2fxrGI"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3929119D89B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728536350; cv=none; b=IfaSaTcARE13rlxb4jVzwhZGLJ3I93xjIE/25KTfWQzqEoxd3WLKoPA9qGA/EBBcd0Ag1KuS5hOVZbXT4GgnYMc0H3mEY8l4B5lZ+rBRKPg3xjpNHwpjjxtKyNYnZowI/SOi/4a1a34QDfbaFHGT728qxkZjFNysLKDf+UAgJvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728536350; c=relaxed/simple;
	bh=zJXI2DYez1X3sci0YkGbrgs+5tXVO2AmBbY6FOY3sbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z88MR3JBu5uAjwcKzuaxgj7e5UKAHQ9pxCUS3HcoXhF8fbT+GtIfh/Mp0oH+smsDzPA/AfOahGicFJB0uImHyL7s06lAtJOUkYDQMn+KOog+nZso0t0SDMil5IDSXdG/9omiaegzgusa/MEJ6ARAT3v2SNZYPcVSl0bvxTF6gEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=IH2fxrGI; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e3dfc24a80so326079b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 21:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728536348; x=1729141148; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VoU/x6ussxWWJbQQRe+aak+n5cu3oteZEAGlAAF1Mng=;
        b=IH2fxrGI8TvWnBEZuqTKDd2AZ1YZnCmrpCIOwtHx6IU3qrgaQXR5IFx5qkk+UVEIgO
         qmuFjAgGCBBIh8pFYNHzR5lWd33gioRqSDgOA5avDaVvcdVFwpHseTDpNwVi/V6W/CPo
         WZNxBBdpg2BG90zBiP1dpSKmbP4l4fevwZLtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728536348; x=1729141148;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VoU/x6ussxWWJbQQRe+aak+n5cu3oteZEAGlAAF1Mng=;
        b=HCQWK8CyXOM0bJB/ixc2HCqmtCckqyPlVIR6I/Fpj5j7DK+4/VktWEgxGN2h7XFty1
         XCiQbR+6ZN327/0th1rMlzSL8stTl1hTOAT1jf9m1gufewY10yEi6iYwvV7xS9RBtdkn
         1T6edi2Pp5Rn/z8I60CWPYcs4pYsCaEvmTU7qNm5GHTg2JYdTSdm0a3bAiNGDwGJTCdY
         lwngEdeXa6KPSL69SdA3WXhUyoAeHJsurq4svjBDMg9fUqA5aUwXex6wPIBp0dQiCeDB
         xBtokyYGyeLVB2pOCDsLgW4BQ/dQafmVRMz5wzfwUxGAWlPrOMB6S1eVwkMOvcUJisy0
         a68w==
X-Forwarded-Encrypted: i=1; AJvYcCV41g5TL7UEDyhoRO5bss94t5ohDNAa4+5x144AbO0Iyc5gqs78R3rhB2TJjMkSJic1KE9xQp2ZTsPgQfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9wic0W4EXL3czqBcEuGNzIOKU4GZ1CtzoWOS7TEdhjUIE9t4o
	dD5gNxqSFUmkvKzFKOkGVnVOnt1iuxJQBHgX9DDPSrdsOL4Hip9ItPWS5v77nXA=
X-Google-Smtp-Source: AGHT+IEv0O7Nb5eais5i8QxwOLcaw9aRE9xxut8kOh2lLhxTp3ohXV68TchdcBO6zQkEqoEbPW8kbw==
X-Received: by 2002:a05:6808:1918:b0:3d2:18c1:bf35 with SMTP id 5614622812f47-3e4d71beaddmr1948457b6e.33.1728536348313;
        Wed, 09 Oct 2024 21:59:08 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea4496690dsm278239a12.77.2024.10.09.21.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 21:59:07 -0700 (PDT)
Date: Wed, 9 Oct 2024 21:59:04 -0700
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
	bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [net-next v5 4/9] netdev-genl: Dump gro_flush_timeout
Message-ID: <ZwdfGOnyjhTtdR0s@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
	bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20241009005525.13651-1-jdamato@fastly.com>
 <20241009005525.13651-5-jdamato@fastly.com>
 <20241009201440.418e21de@kernel.org>
 <ZwdZQa3nujo7TZ1c@LQ3V64L9R2>
 <CANn89iLNuzv7hr19FF0u8TsJwDbGcxrs24FqKhmvxMxLPUZBbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLNuzv7hr19FF0u8TsJwDbGcxrs24FqKhmvxMxLPUZBbQ@mail.gmail.com>

On Thu, Oct 10, 2024 at 06:45:11AM +0200, Eric Dumazet wrote:
> On Thu, Oct 10, 2024 at 6:34 AM Joe Damato <jdamato@fastly.com> wrote:
> >
> > On Wed, Oct 09, 2024 at 08:14:40PM -0700, Jakub Kicinski wrote:
> > > On Wed,  9 Oct 2024 00:54:58 +0000 Joe Damato wrote:
> > > > +        name: gro-flush-timeout
> > > > +        doc: The timeout, in nanoseconds, of when to trigger the NAPI
> > > > +             watchdog timer and schedule NAPI processing.
> > >
> > > You gotta respin because we reformatted the cacheline info.
> >
> > Yea, I figured I'd be racing with that change and would need a
> > respin.
> >
> > I'm not sure how the queue works exactly, but it looks like I might
> > also be racing with another change [1], I think.
> >
> > I think I'm just over 24hr and could respin and resend now, but
> > should I wait longer in case [1] is merged before you see my
> > respin?
> 
> I would avoid the rtnl_lock() addition in "netdev-genl: Support
> setting per-NAPI config values"
> before re-sending ?

OK.

> >
> > Just trying to figure out how to get the fewest number of respins
> > possible ;)
> >
> > > So while at it perhaps throw in a sentence here about the GRO effects?
> > > The initial use of GRO flush timeout was to hold incomplete GRO
> > > super-frames in the GRO engine across NAPI cycles.
> >
> > From my reading of the code, if the timeout is non-zero, then
> > napi_gro_flush will flush only "old" super-frames in
> > napi_complete_done.
> >
> > If that's accurate (and maybe I missed something?), then how about:
> >
> > doc: The timeout, in nanoseconds, of when to trigger the NAPI
> >      watchdog timer which schedules NAPI processing. Additionally, a
> >      non-zero value will also prevent GRO from flushing recent
> >      super-frames at the end of a NAPI cycle. This may add receive
> >      latency in exchange for reducing the number of frames processed
> >      by the network stack.
> 
> Note that linux TCP always has a PSH flag at the end of each TSO packet,
> so the latency increase is only possible in presence of tail drop,
> if the last MSS (with the PSH) was dropped.

Would you like me to note that in the doc, as well?

