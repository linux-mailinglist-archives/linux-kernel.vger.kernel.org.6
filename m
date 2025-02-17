Return-Path: <linux-kernel+bounces-517619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F3DA3833B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E36188515B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9417A21ADD1;
	Mon, 17 Feb 2025 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="cJPYx9Zp"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D324218842
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 12:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739796153; cv=none; b=BJB7YZEU6TE0/GfiwkdRewIBUSK7K2XpxrwcX2ah7dpzwjZ7e83hq6L40RhMh1iMSluLrTCWsRj9TpAuu16Ow1+kRhErVYq7jLu/dRD5i6hbi18vXIteEFBe4PUhmRYAIu6zIyoH6jK93zHSa2z5KqRwi4s6g/ukM0J7Zee7M88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739796153; c=relaxed/simple;
	bh=NbmGLDShUH9XzO69FUadiBXVfCY2xRVRpc4zupKDunc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1mxd2BiUEK7JN5CKEF2q1ngk25aasdYzJJBvsx7PExwhm3a58V38PsbzXQKzPe+W7cv5zna6/JDCGGQLF5poXfw6fmwIRcR3ocbs4LS8MjbBCsLPGQUL+IHq8ymXmJ5XeCjFgnZ3NyStsuAktSxIKC6n50wpdI1R0rT3c8Wuko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=cJPYx9Zp; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5C4953F516
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 12:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739796149;
	bh=l6Kxk+GkIFDTn79tZ2uB28SbPhG15lw/FgLNV6Qqkro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=cJPYx9ZpBdNJQDnEI+zEHbW3AwOo35zgGXSfhIecywUKVxuzpHSrAvHivbXT4YatZ
	 ry0tSUqwDbMzn8SXStoG462B8/rzKfgjeYGy3aoADCjX0ZLsgIsT+5RNyxTrYVFgGg
	 LUAqhkQ3elSDQGSGEMMRZEnoAGbMY8fdHu88VBpXyxIMFZ2oA9+xCenEDTs1IqUfER
	 gqim23Q1W+PbbVGsKnFXay+HgIStMkapPUslhOWuUQV6SvX61oNAk4Gj9eyADnhTQ3
	 tzV7aEaQ+w559vYwwzFx21W5t4wKum4dKfqfGlI+flmI3QI+6D+SpFBdCn1YZdrfC6
	 9aUv+0E23Dtpw==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2f816a85facso8719016a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 04:42:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739796148; x=1740400948;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l6Kxk+GkIFDTn79tZ2uB28SbPhG15lw/FgLNV6Qqkro=;
        b=tkVBdgASSDIPtj2vsUCvCWAHIw2aknwuosnE1ilrSpQEltYaqwtoJel4BKZ3o1mxvG
         u5ukQFmF61BjDJCwpjBHp8TRCc5giEB0f/K3iQR7yrEr05gr5LYeKrGpBJZAgPERvi9c
         GzE81ISBvAQ0iBF2eynlOiofZdh511yI6SVj/fOK8QNhChVTFm0dYSQOqsFtTnJ7nzhF
         lqgaMwotk3p7+Q6iAEly84/LEarEAzcgsPWjQ+fY94VLdXtmxyPXXm6bOOfdMVO8s7kJ
         n47NKtdMp7o5RyVz2x46wqwkqgwkQI5GzIE5hf2NLprBes+SLOyiefzL+CxKTJMvqdQC
         oisQ==
X-Forwarded-Encrypted: i=1; AJvYcCU67aI4Y1gE6epL0kpyvLmXZolDxbsZReL/2eXQt/mEo4TB/wZWXKxj8bPBp7j+kll2ZrcCyCAAzyjKpR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW3Yqu8C7YhFDv0xTubYbzL3jjvKvbjTHfKgUlnz+l4xtKPe7H
	d4YqGZRDqhLZCT68xx2C9j4UZTGyRjiCBp37rYuXKRIzYIWsBGtBQlIKB2d8KfDP1QGtfvqR2Lh
	uAyN4NdzFgOM+8dYoICFzBn5XTPqPcPX3osiPj+JvmtM3NA/5hNgrjBaCBY7BMKwRw5Ck0mTGyn
	NDjA==
X-Gm-Gg: ASbGnctN0v+XOdLKRlFn/c+gxTJVeyxes6lGwecfeZjKZIXnTsi1YQh2FDnbiVN19u+
	yOw2Q+ydBWZvQ9cHpcC/uOVs6xgQtBDtY6qByFKnNbLRxb2kZpVoyU+3SQcfr42RDMa/7b5JPZW
	fkKjQbkByWMn1dH00NTZzxlpBAbmo2FcH6ISCfzaPMee/mnJdrFVWPicnLA1Kb2PrwNd8/LEZNG
	tnNsOMFnocmeeefyucpZXBwfYYURLo/kSCKhWEe3KZdKBTfK9kiLvlDxsSiNIpP1s0SjsFNz2v5
	u9YBEAo=
X-Received: by 2002:a05:6a00:1746:b0:732:535d:bb55 with SMTP id d2e1a72fcca58-732617757demr14588448b3a.4.1739796147890;
        Mon, 17 Feb 2025 04:42:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZ9WyvxQvLosanpLyxCpFkSToNb0EAcxqm8OB+Vp5TsImFgf8mCS6a3JMyQtZjkCJuP5wGbA==
X-Received: by 2002:a05:6a00:1746:b0:732:535d:bb55 with SMTP id d2e1a72fcca58-732617757demr14588420b3a.4.1739796147568;
        Mon, 17 Feb 2025 04:42:27 -0800 (PST)
Received: from localhost ([240f:74:7be:1:a6da:1fd8:6ba3:4cf3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273d9fbsm8264081b3a.102.2025.02.17.04.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 04:42:27 -0800 (PST)
Date: Mon, 17 Feb 2025 21:42:25 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, geert+renesas@glider.be, 
	linus.walleij@linaro.org, maciej.borzecki@canonical.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/13] Introduce configfs-based interface for
 gpio-aggregator
Message-ID: <2amalyzhmqblq5rkcqnufpmszkqdlh2kxxmz6cttju5jgzs272@idorzqbkqn52>
References: <20250216125816.14430-1-koichiro.den@canonical.com>
 <CAMRc=Mef-cg_xt_+mEAyxY_9RfK4=qWEbt_GebeT2mu_8GWVxw@mail.gmail.com>
 <qw5epzoexlteotpuulafg4fyjatlsjjko3ldnzjezoumhodgko@a72wjsaw6fgz>
 <dc2w6gxdp3rhlhy6hvwocp76zdjh4jhdljhoijbub5q76f4xgw@ulfvg2s3rvub>
 <CAMRc=McL7XJfbb3h3XO+UUhL77sq0TZodS=rjaQ19uvKJj+NWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McL7XJfbb3h3XO+UUhL77sq0TZodS=rjaQ19uvKJj+NWg@mail.gmail.com>

On Mon, Feb 17, 2025 at 09:12:07AM GMT, Bartosz Golaszewski wrote:
> On Mon, Feb 17, 2025 at 2:18 AM Koichiro Den <koichiro.den@canonical.com> wrote:
> >
> > On Mon, Feb 17, 2025 at 10:07:03AM GMT, Koichiro Den wrote:
> > > On Sun, Feb 16, 2025 at 04:56:59PM GMT, Bartosz Golaszewski wrote:
> > > > On Sun, Feb 16, 2025 at 1:58 PM Koichiro Den <koichiro.den@canonical.com> wrote:
> > > > >
> > > > > This patch series introduces a configfs-based interface to gpio-aggregator
> > > > > to address limitations in the existing 'new_device' interface.
> > > > >
> > > > > The existing 'new_device' interface has several limitations:
> > > > >
> > > > >   Issue#1. No way to determine when GPIO aggregator creation is complete.
> > > > >   Issue#2. No way to retrieve errors when creating a GPIO aggregator.
> > > > >   Issue#3. No way to trace a GPIO line of an aggregator back to its
> > > > >            corresponding physical device.
> > > > >   Issue#4. The 'new_device' echo does not indicate which virtual
> > > > >            gpiochip<N> was created.
> > > > >   Issue#5. No way to assign names to GPIO lines exported through an
> > > > >            aggregator.
> > > > >
> > > > > Although Issue#1 to #3 could technically be resolved easily without
> > > > > configfs, using configfs offers a streamlined, modern, and extensible
> > > > > approach, especially since gpio-sim and gpio-virtuser already utilize
> > > > > configfs.
> > > > >
> > > > > This v3 patch series includes 13 patches:
> > > > >
> > > > >   Patch#1-7: Prepare for Patch#8
> > > > >              * #1: Prepare for the following patches.
> > > > >              * #2: Fix an issue that was spotted during v3 preparation.
> > > > >              * #3: Add gpio-pseudo.[ch] to reduce code duplications.
> > > > >              * #4: Update gpio-sim to use gpio-pseudo.[ch].
> > > > >              * #5: Update gpio-virtuser to use gpio-pseudo.[ch].
> > > > >              * #6: Update gpio-aggregator to use gpio-pseudo.[ch].
> > > > >              * #7: Add aggr_alloc() to reduce code duplication.
> > > >
> > > > Please don't ram this new functionality into an unrelated series.
> > > > Split it into the gpio-pseudo code, factoring out common parts and
> > > > converting existing drivers, then send the aggregator series saying it
> > > > depends on the former. Otherwise it gets way too complex to review.
> > >
> > > Ok, I'll do so.
> > > Thanks,
> >
> > Should Patch#2 also be split off into another submission?
> >
> 
> I'd fold it into the aggregator rework but make it come first in the
> series so that I can pick it up into fixes easily and send it for
> stable.

Ok, thanks for guiding!

Koichiro

> 
> Bart

