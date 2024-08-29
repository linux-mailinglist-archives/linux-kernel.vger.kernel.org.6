Return-Path: <linux-kernel+bounces-306114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3224D96396A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96021F23F53
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 04:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D6E1494A0;
	Thu, 29 Aug 2024 04:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="rbmKd8Hv";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="ThoSdptK"
Received: from mx-lax3-3.ucr.edu (mx-lax3-3.ucr.edu [169.235.156.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EFC148FF0
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 04:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724905837; cv=none; b=fpmQcJQER3Wri4KsrCNRQYTHiLWKeqElO+mX4FucEui6A4o4XqBTBpj1/qYJiodhio09UhCJs0AFH7BtOoMVDg+M5Hu15mzs2atC5Dm+KD9i/0XkeoJXVFjmeYuOrEEw/0+/FZA6Of72rLBI6fhNYoMEApHXsbYNJR9BxqHLhyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724905837; c=relaxed/simple;
	bh=Hm8X6G7US76DjH1BlXkmp5j9VJxJk6hQZ6v/aVdZfiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=boor/FMOnB7UwWFV6HmDpPgAKCWENH+/0ptTDmV5B0wMjPmUzQlbMg+83a0sSa9Gsw9C6UO+i9/RTinJFWjBjdimles39f7yU8Mw8EHl3MEspcByRAI3gd/LKtC9U93C7K+fHqwrQz55IRJiR5ZCcAz/HrJ7R64GYyisOw94B54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=rbmKd8Hv; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=ThoSdptK; arc=none smtp.client-ip=169.235.156.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724905836; x=1756441836;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:references:in-reply-to:
   from:date:message-id:subject:to:cc:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=Hm8X6G7US76DjH1BlXkmp5j9VJxJk6hQZ6v/aVdZfiA=;
  b=rbmKd8HvpTFufzmqd/eouKO9vUASwmUb4XqlG9rV8HNuB4KwrK9Wowze
   JRpz8nk4MTwTOqaLXWJq6kxCaYpswt3y2XemOmMX3g9j3fKiSYomvCtwa
   RJDY2ywj1+q+9MUaA+Y0QdvONBdPz/2X4+qs/ot33fBtitblIWDZhrbj1
   d6n+ZTmxXcXToNOoEFrMu7ftJFhQryx6VG1uLGJOMdfnObI8D1r0r8Vjl
   zc69rfdLd15TPtWHTk8DEoiXQcE8ZEEfgqT5s5Uw+g7pMkWEnsvputnko
   oXGwZD1+j5cPMmsgmvqoqQTd3zFx8jWCGOzwesqyM1SFiY9t3s8+I8Ex8
   w==;
X-CSE-ConnectionGUID: nLbnykgXQnSX59Gsf+R5/Q==
X-CSE-MsgGUID: 0yUxqq1ISHy7SO9VTfuPfg==
Received: from mail-io1-f72.google.com ([209.85.166.72])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 21:30:35 -0700
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f87635cc1so33714139f.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 21:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724905834; x=1725510634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dihk3etWk++rvq6e35hR7jF9/0aw2VkPe9Rvva2gqnA=;
        b=ThoSdptKzuerrehahMwcfSitbKdbUq5w9XwhAWOwb0hOVERjzLxqKJXlwtODsc9HwO
         akdev3IvSgpBTvensKy/kAVOciJQf/T14ksXQwKOKAlax7iCGuMzJAFcIuw9VdezNExX
         71W9ew6/oZdhygbru6XXgtKh9JcRvZmhTh8ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724905834; x=1725510634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dihk3etWk++rvq6e35hR7jF9/0aw2VkPe9Rvva2gqnA=;
        b=J4PrvD6CK/M3Hvi8XtW7nerSP6E6cbGhSKdDZ5ccRL3CdgENDEZ6jrJ/whNtMVRvhg
         liyn8bLONUAV16mcnY9caDqtc2zTSYNZKkK3lQ2A/FgtDhZfmNn+RrinCD6WWiOCqMPG
         WAgSat4x1/LYpFLpC4uOJgclEZkDp969JbBIQcmDd+CL3siCTBtMlncrET4ENTRICPBS
         id96g+ZnoMfgMVIkrSZkB6TSIP8XUzrjLmux/TDRipXyXwrW5r63s5x67Fs7hdwdGF5O
         fy9lsVwNHav4YRB6UpJkotYPe5BowHzD5Nwb4bTskdiYRTaVXUkREIEqjLXUtGPLfMap
         nHhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXswXf1RBLp0hIYGeGuLjRY7RbYSxsiEmFYH79GxMOQVf2sT7Vf3y1AcYUHYgvuyiBmkhegaFkc71j6Jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJp5Me6ZLDfntSU7cu27g6ua18JJ5MY6QhRCdUuJrdeTZPTSiT
	Xbp2Fjb30S3+0byaYfZ+dPEE6dFWn8Yt/BBCLEsDw3xld22E5VUbSiuKRygidZOLcIvPVAAX9Cm
	ZCRuRC+hyzScmJan8ysGuFWnOjS6S/ygGvqg1BGFxSc/5S3F0HDtpawt4XpuVfUqT13TZJKJGD2
	FmU4m3OeD5CegLPLki6vHxW9GYLP5jtczp1Bo7TA==
X-Received: by 2002:a05:6e02:1607:b0:374:a781:64b9 with SMTP id e9e14a558f8ab-39f3780c6f7mr24796655ab.13.1724905834304;
        Wed, 28 Aug 2024 21:30:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ8G4yBQZl8uMVmbjN2GKvaVb134BrRd4Eeb8qtEDfsvzBlguVr1+MIJ/adcXERyfRH9HRB6shu5q79ziNrk0=
X-Received: by 2002:a05:6e02:1607:b0:374:a781:64b9 with SMTP id
 e9e14a558f8ab-39f3780c6f7mr24796515ab.13.1724905833918; Wed, 28 Aug 2024
 21:30:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALAgD-7C3t=vRTvpnVvsZ_1YhgiiynDaX_ud0O6pxSBn3suADQ@mail.gmail.com>
 <13617673.uLZWGnKmhe@bentobox>
In-Reply-To: <13617673.uLZWGnKmhe@bentobox>
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 21:30:23 -0700
Message-ID: <CALAgD-7AOA0At+y0BR2MZ0WXPFM03tQneRbeGZQqiKy6=1T0rw@mail.gmail.com>
Subject: Re: BUG: general protection fault in batadv_bla_del_backbone_claims
To: Sven Eckelmann <sven@narfation.org>
Cc: mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	b.a.t.m.a.n@lists.open-mesh.org, Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Which line would that be in your build?

Somehow, the bug report does not include the line number in my end.

At the moment, I am unable to reproduce this crash with the provided
reproducer.

Can you reproduce it with it?

Sorry. The above syzkaller reproducer needs the additional support  to run =
it.
But here is a C reproducer:
https://gist.github.com/freexxxyyy/0be5002c45d7f060cb599dd7595cab78

On Sun, Aug 25, 2024 at 9:24=E2=80=AFAM Sven Eckelmann <sven@narfation.org>=
 wrote:
>
> On Sunday, 25 August 2024 06:14:48 CEST Xingyu Li wrote:
> > In line 307 of net/batman-adv/bridge_loop_avoidance, when executing
> > "hash =3D backbone_gw->bat_priv->bla.claim_hash;", it does not check if
> > "backbone_gw->bat_priv=3D=3DNULL".
>
> Because it cannot be NULL unless something really, really, really bad
> happened. bat_priv will only be set when the gateway gets created using
> batadv_bla_get_backbone_gw(). It never gets unset during the lifetime on =
the
> backbone gateway.
>
> Maybe Simon has more to say about that.
>
> On Sunday, 25 August 2024 06:14:48 CEST Xingyu Li wrote:
> > RIP: 0010:batadv_bla_del_backbone_claims+0x4e/0x360
>
> Which line would that be in your build?
>
> On Sunday, 25 August 2024 06:14:48 CEST Xingyu Li wrote:
> > Syzkaller reproducer:
>
> At the moment, I am unable to reproduce this crash with the provided
> reproducer.
>
> Can you reproduce it with it? If you can, did you try to perform a bisect
> using the reproducer?
>
> Kind regards,
>         Sven



--=20
Yours sincerely,
Xingyu

