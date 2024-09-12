Return-Path: <linux-kernel+bounces-327040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4703977017
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B29E1F25503
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FA81C0DEF;
	Thu, 12 Sep 2024 18:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b="ReVJK29g"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8871C0DE0
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726164353; cv=none; b=ffvBjVRaqaKjmyeGj74ab0l3zVPzGIE+OxtVxAwPQfncN4CkUXqOPyruDUQmFjPTNDKpxNljxFr8ATBytQKZHea632U8eK6QKBUh5EuefswDgoCUFF+GQVNbhQp82mIGv8nki99iMBwiWUDl9VNOmeHyr8P3XrhI/wT6baZpYXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726164353; c=relaxed/simple;
	bh=olTrvHiz4KPiLxG/N5QL7yQelkVg8xnB+5OT2HkD6Nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QpeV+gZd66HHLOVGD8oWyEqEnIdh/ADUd0h8CKCQNUQ+WzJxdl1e3aKaH2rFBXK67YDGJ6augV80dmPuB8IBzlA/g691QqeZYuFcIu01N3xLl21c9lCalI1HjKiskmjghGCxzNNntr3PdzOpK3rGdRC/Aci9VGX0TNO5XknlIy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com; spf=none smtp.mailfrom=kutsevol.com; dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b=ReVJK29g; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kutsevol.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-456757d8871so7141331cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 11:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kutsevol-com.20230601.gappssmtp.com; s=20230601; t=1726164351; x=1726769151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NK9FkR6ngNXCNLDvRA6BhKO34/vHY4NrRcmqCfwOcD8=;
        b=ReVJK29g0gso+5+iSIdYHpgGaW/r2CoP/1q/dRxPwy8I2QgRSdJui00ypfMSVn8CHb
         zb/9TKrsQ1113cXYsQgyeJHVHxWdq3eIQBTMIXsLOcZjSix4KQS8QttDo4ySKG41mv4I
         6hd9yf27i7QkGDa3BD3eUfdpLGdyX5TVAfFJuBu4EubguPug79X72eb+/cJMi91GiBUw
         YKoeGBhEkturQ9vakv0+EyNBAVSuR2O894ZQ0MJpyJ/OuyUzjXQai1E7zJ9OyxZkzF1D
         SMVAiTyEdQW++odifxW6se7nD0MjvoHdtZIBa9cNdyH80+mAgpMRgfacwyC0+SmTohgz
         EwQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726164351; x=1726769151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NK9FkR6ngNXCNLDvRA6BhKO34/vHY4NrRcmqCfwOcD8=;
        b=Nn5Zkg3Cgck/W/iHz15w43yi9POiHWkcWmb7MP1ouCHrrwZ1frm5bLtC6+YVkeJC+B
         SDVO98mxCpEPk7bW3ngBHihUUFeMDuj0oPnzQI9HAQJ8UtHSt3YdTS4Ky+yngR7gaajZ
         wqOzWkDaKscgszQreDHIQDta04Imqduha9hG2+WFzPYy8m3BBGbLrfp5LaAbkwmPmDOB
         RT+LbRY41ov3lmoL070zZM72Cm2Yvs7U/gY7/uJIwQFkdn5VgHbVkD/cwuXrAR80+H0K
         5SyuolMnYX+TcAI9KWBI2k2Ws/yVaDqCj7959ZbYGodSF9+Y8YdGcZ8Vqq7rXEf9RzHc
         W3pw==
X-Forwarded-Encrypted: i=1; AJvYcCVQQjzCb+mUHvCgR3QmUuPGgDrfA4cEUJecwLl62/FJhVwTWRIOnZ9dzWIk0QxDg4VGZ1FO4b3Nb2FbfhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUxs1ayLes5ZoQ909kiQWzOxbzNgBGJWnEw8dL2NqpD+naPWv2
	eHmgUyWck3UGOgM9nXVfgc00UFhcsSl16Zd2KQ5E+OjeqOoA9i8dTeFc5BOC81CJbdhdYVkSAic
	9nRMC/YxVaYzqcqEdDMEsaETISgyM6Qrz3C4CsQ==
X-Google-Smtp-Source: AGHT+IHtrLsNmHj12916dGwLnM5FGqBguHMebdoCckR/HpmzxRE2SBrnnjrQvihzCBYsnvA+PipzYFZhNA1TaqosEqI=
X-Received: by 2002:a05:622a:1aaa:b0:458:5482:c528 with SMTP id
 d75a77b69052e-4586029c4dfmr69539461cf.8.1726164350680; Thu, 12 Sep 2024
 11:05:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912173608.1821083-1-max@kutsevol.com> <20240912173608.1821083-2-max@kutsevol.com>
 <20240912-honest-industrious-skua-9902c3@leitao> <CAO6EAnWOrzOhHNURLct1tsxLL_gaNT+nWttTk4oPcD66h-xAZg@mail.gmail.com>
In-Reply-To: <CAO6EAnWOrzOhHNURLct1tsxLL_gaNT+nWttTk4oPcD66h-xAZg@mail.gmail.com>
From: Maksym Kutsevol <max@kutsevol.com>
Date: Thu, 12 Sep 2024 14:05:40 -0400
Message-ID: <CAO6EAnVgob_8HZFjH8=JA=jhZBxQtEsqQE0d4+PHLU2vKvpz_Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] netcons: Add udp send fail statistics to netconsole
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alex Deucher <alexander.deucher@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 1:58=E2=80=AFPM Maksym Kutsevol <max@kutsevol.com> =
wrote:
>
> Hey Breno,
> Thanks for looking into this.
>
> On Thu, Sep 12, 2024 at 1:49=E2=80=AFPM Breno Leitao <leitao@debian.org> =
wrote:
> >
> > Hello Maksym,
> >
> > Thanks for the patch, it is looking good. A few nits:
> >
> > On Thu, Sep 12, 2024 at 10:28:52AM -0700, Maksym Kutsevol wrote:
> > > +/**
> > > + * netpoll_send_udp_count_errs - Wrapper for netpoll_send_udp that c=
ounts errors
> > > + * @nt: target to send message to
> > > + * @msg: message to send
> > > + * @len: length of message
> > > + *
> > > + * Calls netpoll_send_udp and classifies the return value. If an err=
or
> > > + * occurred it increments statistics in nt->stats accordingly.
> > > + * Only calls netpoll_send_udp if CONFIG_NETCONSOLE_DYNAMIC is disab=
led.
> > > + */
> > > +static void netpoll_send_udp_count_errs(struct netconsole_target *nt=
, const char *msg, int len)
> > > +{
> > > +     int result =3D netpoll_send_udp(&nt->np, msg, len);
> >
> > Would you get a "variable defined but not used" type of eror if
> > CONFIG_NETCONSOLE_DYNAMIC is disabled?
> >
> Most probably yes, I'll check. If so, I'll add __maybe_unused in the
> next iteration.

No, there's no warning. As it's used and then optimized out by the compiler=
.

