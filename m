Return-Path: <linux-kernel+bounces-327232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1306597729E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 836BAB2315B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888101C0DF3;
	Thu, 12 Sep 2024 20:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oEh2Oiyl"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BA76FBF
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 20:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726172164; cv=none; b=hy7MTS/jqd6W/d6WydeP90lorpxwXV8xweKTCSZuhgPVyNZBnbPyAE26/wH3eZt8zMxFegEVd0y1JyboRHhKoUGOYl1isECP6sX5eDEMs8qcrX3UNRNrYAYa2631fK/pNBoTNB9tOlqJk66G6QX4LtaneRzFPFPYoZZAR9eR1A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726172164; c=relaxed/simple;
	bh=hHoQQyYyg4nYi15hTtxasl5id2V0+j+p7ZvGXRW5XH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nsj/4Mfs5jI3WC7GsdenAqzbqbvz2qTk7WZOoyvYHr1KhKzU3+/l+BZVIjCM5Z5zAVnGwufoXGc0OzKZGPCQKaogThfCNo/644v0/hxZiLz4OtfnNe9SH3SMxqekIyXt5dVGhzVj9Bwo2Fkj/unskdH7YGZR/Vv4uhYlVBDDNfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oEh2Oiyl; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53659867cbdso309450e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726172160; x=1726776960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OcTdr1oD21bDFlWgrDP94oUO7BjSI12VKiNlN7J8IY=;
        b=oEh2OiylrfGxB8wzckgyh/y5aUB20gsmcd/VLuT6Apr/WYfO8u1ZaLEJxGvwiJncNo
         JHfL71OA10rMLkq6M4C0RKo55Rom9IJJ5RcXhX8HkBQamUMILVKMruvbjb/Bc8stlwnd
         ALMQWBG5MLT8dwK3PlaxvEzGqRikTHj2o2z5lQYZCMKMLedhQDVlAGROqdRSK/DhTTyC
         /lb+eGCMQKUQZQWSfHZM+JyGbCG4jpWL3AvL5Hjp4PgEXDP8XRN6Ny6eisqQwdRlDsnB
         OH5ccONZb9NCLqhlpxgMFzuL9LL6TRcY50CkM+PNtJ74wUF/kWnm2aIKCnHDsy8dxAGL
         WFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726172160; x=1726776960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3OcTdr1oD21bDFlWgrDP94oUO7BjSI12VKiNlN7J8IY=;
        b=kivDEAd0qC2AhEgNrNNSYOghlhqT7T3FFWKXL0wDJ+EDlNNasCIoMfpNcN826iL8a9
         LSNmu7g1Mkllhm1eBY9XKWbbAyvWm3KL0rRj0UkcReBE5kbD7NZD8PpTP+1Styk/8luV
         jJ2nsEaWZPHZAWMpWiYFle40QLrAXshloOExeyAQWmK6x0jfZF1SqrsZaXZLg3VFk/HI
         S8Fg2vXKAF7Kc4R33mAtZr6B3uKWrxEKY2GWQ8HGy/vsDErgs2HXqTkigbhEhVpL92QD
         UfIUxFMl3qE279b83DeXnZxhEaUgHz8eRssDbIE1D6oBDY05dosQRxxRrXsRNBZwtfIx
         bRJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr5++RxnLj8idRFMIp61i/psToCELp7Gb0gt4ezDVDicEDbi/o5r6ukIzegJ0Kdw+q/ymHsUwVojBmkbw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3SYkGI21ltsNry2Abso3YcJH1Syzrd6+E3k4wpDDo3584sYk1
	ZNS7QddD8sfBQSgfWnSfpYEmI/5ZHGAqTbsgt22OoV1rcqEjzAlVgrHyptYSKde3Fe8cCgLxHY3
	0xS1zAdm4LThAYwLWRt0E8CSyUDk3m2RFXwE=
X-Google-Smtp-Source: AGHT+IFmGbLe7NzaH3EJuurC1RFXKVf3MQbr9jwudg2Gy6okgYnei1JNov9IGPgqos7iOnHDL5Kegj48KEr6vIYkmXY=
X-Received: by 2002:a05:6512:2812:b0:533:3fc8:9ab9 with SMTP id
 2adb3069b0e04-5367fef18femr305656e87.34.1726172159944; Thu, 12 Sep 2024
 13:15:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912-mgtime-v2-1-54db84afb7a7@kernel.org> <CANDhNCrpkTfe6BRVNf1ihhGALbPBBhOs1PCPxA4MDHa1+=sEbQ@mail.gmail.com>
In-Reply-To: <CANDhNCrpkTfe6BRVNf1ihhGALbPBBhOs1PCPxA4MDHa1+=sEbQ@mail.gmail.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 12 Sep 2024 13:15:49 -0700
Message-ID: <CANDhNCrfzMZj8T-mCKd9RAF4D6-EBAtmkffvP5-WMJbgQHdztw@mail.gmail.com>
Subject: Re: [PATCH v2] timekeeping: move multigrain timestamp floor handling
 into timekeeper
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 1:11=E2=80=AFPM John Stultz <jstultz@google.com> wr=
ote:
> So initially I was expecting this to look something like (sorry for
> the whitespace damage here):
> {
>     do {
>         seq =3D read_seqcount_begin(&tk_core.seq);
>         ts->tv_sec =3D tk->xtime_sec;
>         mono =3D tk->tkr_mono.base;
>         nsecs =3D timekeeping_get_ns(&tk->tkr_mono);
>         offset =3D *offsets[TK_OFFS_REAL];
>     } while (read_seqcount_retry(&tk_core.seq, seq));
>
>     mono =3D ktime_add_ns(mono, nsecs);
>     do {
>         old =3D atomic64_read(&mg_floor);
>         if (floor >=3D mono)
>             break;

Apologies, that should be
         if (old >=3D mono)
             break;

thanks
-john

