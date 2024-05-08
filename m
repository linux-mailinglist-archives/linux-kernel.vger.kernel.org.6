Return-Path: <linux-kernel+bounces-173743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D5B8C04C7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 944A22860F2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E96A130A5D;
	Wed,  8 May 2024 19:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtXNL3/K"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3B01E507;
	Wed,  8 May 2024 19:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715195733; cv=none; b=SyTQebuPpG4MwRI5zvY8ZjFBBYJC8npci2cgIKhVkeMATuzCx2rg/wHEF+3y8qgFx5P2PUXe9kp1gnNQVPEVIXFHu1g2v8cXrws0pxblQu1t1FDVLqF9gVjYDlkWs7T4MzExCYAJk1D6U8jkhTFBK2OlSzvCynv8aPvcTCzB5dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715195733; c=relaxed/simple;
	bh=RhSbY/92CIKP3Dcwy+tLlipMgT+IQsxVR6Q6StuwXXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qZuVt1x4sPVvZ7xnW/uo3YDX9Z+gZOVVgmXl2JoGPzhCjPCkbcv1B5i7KMM2RkSngBWAIG9a777g+RDMWFP3aMSK1sXMpZkAwzwSEXQ8SM9EKPNO3zm/blr7FUl3FVUIPMxVAUHWFSBi44joxnTqs6wtEmvtzsEume4WdZ5RZGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtXNL3/K; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b1ffd24c58so57830eaf.2;
        Wed, 08 May 2024 12:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715195730; x=1715800530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnFBQZ8bl+ybs2X68JMZ+NUByUkUZbKJDs1KtxJ0X5s=;
        b=UtXNL3/KzuhDNG0eie9+mg/TO5NUDoECQu8yery0tQWgTDx8QJe7k7INihdfK02S9c
         qa+XX0biokW62At/Jj2uF8lkWQKmAZMnSuRNviTyNDVbxShdZBM4uljOpYFENwUieJJg
         buasKHONRgB23dCigm5dN2K9Wz6gRNrCAIqFztkiPzST4SHcwc+lBjm2twSklJM6IDZY
         CBwGSFvp5m7VejfPZ1lsytY5iXyNizGCjSFFAfC7uI3rf4O1lgEar8BDBoCADHROBt+o
         Ab6aWiTrcfmtSsWRrg4Tff9aSBMAyM1XU5eCXUgWobUH7szwu/HLG3OQBywHR7W0lNJ4
         DjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715195730; x=1715800530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wnFBQZ8bl+ybs2X68JMZ+NUByUkUZbKJDs1KtxJ0X5s=;
        b=KBll0QaDPPQa9x/l2Gutak6qgP29A5uLBQTgr7lI7HuU6Yss+fQ3NFFV7r8h0lwz5v
         66WqY6zhf1e4C7nh3Y6YwDBUtzuL5L0BG9GAePRKY7e65SaW4v9rge0RlXJCX+Em6B0C
         5lsR+aTGQFn4uOMJcGafJYIuTtmpaNaMhAUlDq2LxkBvvA3AVkrLWAoDJLW4JhrkNS36
         67af9y5BPqi8oW3teVOlCGTncxDeUKwjWLPRt7jFhbZ6z60lMQZGuBDyKGaSM52K8BF+
         k56QzHc8+PzNtqNw+lIEu5n4fIZRu51//KtJ/f83ntSPLg/SQw2frUox6dtEY68e0dbf
         dIHA==
X-Forwarded-Encrypted: i=1; AJvYcCU9Vwue1hVaMpTwkp4c9UbRzmDaF+3oSvLgYs7Q1FYGLDHeUTTGhUM2h5RWZfm1KagDjwqlPkBOTvvDK07Kk/KIKsE/UteLIy2m001npa7U
X-Gm-Message-State: AOJu0Yxvs4i0kurMg/G4BBSpuux3/lE5WYs1sc6AIdHwzHmBfX/3CCPn
	VDR2R0P2pBUGD72Gb2/i0ntE4jRjrTfmtuxFIoW8OsADh0EtPeSTlBvvkYXIGCcApe2OEksXm67
	AjVd+yZ4G94ybYvelfYqr1Y5DVuQ8KlfR
X-Google-Smtp-Source: AGHT+IFHTRj1dO43YyodAbQ1Xb/7ZFIpmwOMIn7PVGMuN75k1HoWYZe3huk5HUDxC8/ex3uyWPwaXQ6S2OFsh81NNsM=
X-Received: by 2002:a4a:ba81:0:b0:5b2:5661:5c61 with SMTP id
 006d021491bc7-5b256617cf0mr2128306eaf.2.1715195730518; Wed, 08 May 2024
 12:15:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506213150.13608-1-ppbuk5246@gmail.com> <20240508172621.30069-1-ppbuk5246@gmail.com>
 <b4156f2a-ea8d-483a-b485-db4b5a80b1fe@web.de>
In-Reply-To: <b4156f2a-ea8d-483a-b485-db4b5a80b1fe@web.de>
From: Yun Levi <ppbuk5246@gmail.com>
Date: Wed, 8 May 2024 20:15:19 +0100
Message-ID: <CAM7-yPRts2tZYGBvC7=eFZzemvFq9p_p4FDpidjq27q55m+9Vg@mail.gmail.com>
Subject: Re: [PATCH v2] time/tick-sched: idle load balancing when nohz_full
 cpu becomes idle.
To: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus.

> * Why did you repeat typos in this patch iteration?

> * Would you like to take the relevance of imperative wordings for changel=
ogs
  better into account?

Sorry for my mistake, I've fixed it but, I sent an old one :(

Thanks

On Wed, May 8, 2024 at 7:38=E2=80=AFPM Markus Elfring <Markus.Elfring@web.d=
e> wrote:
>
> > When nohz_full CPU stops tick in tick_nohz_irq_exit(),
> > It wouldn't be chosen to perform idle load balancing bacause it doesn't
> =E2=80=A6
> > So, nohz_balance_enter_idle() could be called safely without !was_stoop=
ed
> > check.
>
> * Why did you repeat typos in this patch iteration?
>
> * Would you like to take the relevance of imperative wordings for changel=
ogs
>   better into account?
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.9-rc7#n94
>
>
> > ---
> >  kernel/time/tick-sched.c | 6 ++++--
>
> Will further patch version descriptions become helpful behind the marker =
line?
>
> Regards,
> Markus

