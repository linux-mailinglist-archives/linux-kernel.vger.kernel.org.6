Return-Path: <linux-kernel+bounces-358245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B9A997BF5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F44283C06
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 04:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBD02AD29;
	Thu, 10 Oct 2024 04:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jYRLmCSw"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADDC188CCA
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728535529; cv=none; b=lWu4cCvP9piP5i5BeaFKl/Qj9HIz/q0NMfko6fAb6ISZJ1+mwtn+s4aUKx72T6wBb7beTbngCmidoYTBVkThCXB6RpgydEF1oD5iAVAgaev09I4EAjnIaHJ2zZWivgtpKAViRdkJ9dPMvwB5qKBGhQ7VCywGGWtxnk/+1Hh4Neg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728535529; c=relaxed/simple;
	bh=qeqVSj+foHrqmId5V4DAqrwCe7nyd6XGNpNIE9BMPC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Nf4NyFbL7o1ugus5ZlX1eH6EAPL/4cWToy353eEz+WHnsYLR4s71vN/NDYt780Tvm60EpSocvpYLOiKyHb25lKkiHhc8yv5hShvBZGq6wvIXuGGTLWovsf8AKmYNNBFalsp6ifVBic+WFnsMYb1Vrmy+XG70Hj7wg0x73mfxjh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jYRLmCSw; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5398a26b64fso377830e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 21:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728535525; x=1729140325; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQ4mTQeQlT/IBs4bBe8CmdelCtZw/FBnzyvtwRGqheE=;
        b=jYRLmCSwEHSmX9mnsWVJnJAoajB5nwPcF+Bzp0Nxw3Pp7cX14Y3uIjYAIK/z0xaOBV
         8mPlWGH3eNnf+pA+5uWOF45ConP6gu42YWd9SOofk3f+K3Nhrjjn44nNgGHtP+vbiLvt
         vvQfxzo4ja8oe5vJBExl87zWzESvIDSOYlJ3PU8WsVGkvc5OSlXGiRaG95VptsyDek0y
         Mq0c5uUTcTcA5+yphc6H4p8tjrZldV41QF80l0Qr6/yVeM153mPfs/DU1QGUF/X0h4Yr
         R/JokdQoS9xjOUGd/jtMPWR7ojCZsNGks1GgCm1DmYj5dyfA+RUG11zVj7EiJwQ3A9Wu
         8O+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728535525; x=1729140325;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQ4mTQeQlT/IBs4bBe8CmdelCtZw/FBnzyvtwRGqheE=;
        b=PWZ6BOAiynsEReb3LaNwT6l7ZKxt4vLsYYs7G/X2auKdrrdj0lU83fhycnLEvvfyMK
         Ao0gFpZUltzj382XiEXZ5x/IgoM8pl+5Yvj2UrHx1k75HLNEcrXAQopdyjOW8ykVGfFm
         CPBVdNro+bOSogDCv5ln35qpfn4Mf+iFnyJVOGg/+cR6KqUFCuNzmz8cF6PaM7S0cwUn
         66RNe1Tro/v7ESrhd5ig2OxUIljbpfgYgtiH08YSg0w+wqwiZw3VVQ8E4KF0DaWOYcPB
         CwAgBAATCry0ynkuLE9oYuFy6SVY9Dea5LtbNMJIiZ5okkma6zohfGn3qY4c8NOVV2YI
         eWNA==
X-Forwarded-Encrypted: i=1; AJvYcCWxq7t6jfSPy+iN6X0m7itnToe/kz7J387hBdFpG3lrHPBbiQXoY6v6nnMrZlKymry8fAIDMnlfjXDAfy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzECRolNerHd/sEONLtPoZtJKao434moVFaFiWoTNpmAP6sNzys
	tSfSC0U9aunVJXozAmXceE77fpwu3A6SfglSBAhJgHLO+7jiXRUsu8yiLhpGCRe2t/U63VYGA81
	OeCqYrdxKUXQBWW+w+eJo54vcytY2X4RSAH4c
X-Google-Smtp-Source: AGHT+IEKYDHv1tvhcViUPwRvnlBwvRUAI+7UfugiVD8Nb0Lj7UFE8c61PinHgou5VxeZDcIPzEF8QQjUWq4lUZfdBd4=
X-Received: by 2002:a05:6512:e91:b0:539:9527:3d59 with SMTP id
 2adb3069b0e04-539c4966984mr3354314e87.52.1728535524985; Wed, 09 Oct 2024
 21:45:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009005525.13651-1-jdamato@fastly.com> <20241009005525.13651-5-jdamato@fastly.com>
 <20241009201440.418e21de@kernel.org> <ZwdZQa3nujo7TZ1c@LQ3V64L9R2>
In-Reply-To: <ZwdZQa3nujo7TZ1c@LQ3V64L9R2>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 06:45:11 +0200
Message-ID: <CANn89iLNuzv7hr19FF0u8TsJwDbGcxrs24FqKhmvxMxLPUZBbQ@mail.gmail.com>
Subject: Re: [net-next v5 4/9] netdev-genl: Dump gro_flush_timeout
To: Joe Damato <jdamato@fastly.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me, 
	bjorn@rivosinc.com, amritha.nambiar@intel.com, sridhar.samudrala@intel.com, 
	willemdebruijn.kernel@gmail.com, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 6:34=E2=80=AFAM Joe Damato <jdamato@fastly.com> wro=
te:
>
> On Wed, Oct 09, 2024 at 08:14:40PM -0700, Jakub Kicinski wrote:
> > On Wed,  9 Oct 2024 00:54:58 +0000 Joe Damato wrote:
> > > +        name: gro-flush-timeout
> > > +        doc: The timeout, in nanoseconds, of when to trigger the NAP=
I
> > > +             watchdog timer and schedule NAPI processing.
> >
> > You gotta respin because we reformatted the cacheline info.
>
> Yea, I figured I'd be racing with that change and would need a
> respin.
>
> I'm not sure how the queue works exactly, but it looks like I might
> also be racing with another change [1], I think.
>
> I think I'm just over 24hr and could respin and resend now, but
> should I wait longer in case [1] is merged before you see my
> respin?

I would avoid the rtnl_lock() addition in "netdev-genl: Support
setting per-NAPI config values"
before re-sending ?

>
> Just trying to figure out how to get the fewest number of respins
> possible ;)
>
> > So while at it perhaps throw in a sentence here about the GRO effects?
> > The initial use of GRO flush timeout was to hold incomplete GRO
> > super-frames in the GRO engine across NAPI cycles.
>
> From my reading of the code, if the timeout is non-zero, then
> napi_gro_flush will flush only "old" super-frames in
> napi_complete_done.
>
> If that's accurate (and maybe I missed something?), then how about:
>
> doc: The timeout, in nanoseconds, of when to trigger the NAPI
>      watchdog timer which schedules NAPI processing. Additionally, a
>      non-zero value will also prevent GRO from flushing recent
>      super-frames at the end of a NAPI cycle. This may add receive
>      latency in exchange for reducing the number of frames processed
>      by the network stack.

Note that linux TCP always has a PSH flag at the end of each TSO packet,
so the latency increase is only possible in presence of tail drop,
if the last MSS (with the PSH) was dropped.


>
> LMK if that's accurate and sounds OK or if it's wrong / too verbose?

I do not think it is too verbose.

>
> [1]: https://lore.kernel.org/netdev/20241009232728.107604-1-edumazet@goog=
le.com/T/#m3f11aae53b3244037ac641ef36985c5e85e2ed5e

