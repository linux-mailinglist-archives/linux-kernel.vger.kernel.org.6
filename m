Return-Path: <linux-kernel+bounces-225386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D41913007
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 00:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A891C1F253DA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 22:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EAF17D89B;
	Fri, 21 Jun 2024 22:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DAE6TQs/"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CEB17D888
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 22:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719007438; cv=none; b=Y0hp/n3089vj/AzblKM3txOF8VSzZujviKvELvVMBgTJf+29o/xBh1I5BnOMQiDevfwSzHugsiNfrHNRSn9rLIxBfGMuNfj7E+R10GbUoncsjBnrEALPVCmz/ZP1zUcPgfaO4qKzRS0FKLEWovYn62loKiI5NEiKkibBT/ItdZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719007438; c=relaxed/simple;
	bh=VJPBx5efPOq30t+7qwsRircNZM52T3GKxalqnCPh2ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VHKIvKqBorKCiz9SYVQ/7iIvt/1luIf1VvsI4Xz+5RLhxLM199hZ96bCLtB9kxMIa4RlXuUEJV2hoL/J41bfLCdxYOs+/f2mGUbKnj8jO/2SmJhXfmrpFvuPwVVo8hI76p7+gDET6j0uqY9S69fVgnt8Qxz7+8HtISRTZpmCVm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DAE6TQs/; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6fe617966fso1264166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719007434; x=1719612234; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7VevD/tun51OukWgbAoZ4Cm2u23YTJzraHYAs/IYAE=;
        b=DAE6TQs/RQCNJqTW9yXsdCcDGA3UGeh4GUOb6Y9VUM7UPPbdWo2d93fYNmp3wNIahY
         CggDgCYq7v3xH4P6IUoEBFVzOoecUhlHe0jIhOLARSM1SwxvjfV+sX3tNa8hl8SZ4+mm
         i7z7+KJStDA/UTGyELXDRuGDVoCRlsBafX25E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719007434; x=1719612234;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q7VevD/tun51OukWgbAoZ4Cm2u23YTJzraHYAs/IYAE=;
        b=OZ1VG/qZawVAO2eozCzNBZCVEQz4rlWX1fH93kgtMh9O/ew48iS2vg2MmF0qQnAK64
         Ci9Y2Qu0RMLAOqowgF9MOEUzufAgCCLjXh7ALrGp4vPuDxmgCpedqEQV5W3R8f4Bz/5m
         5yNcPMGs9ckG92KdnujMTowS4E0cS8ls4bHKAa9pBjp+ZH158MhLOhHUvkvj1lRpwC1e
         2rljZtHF3sLcueDb5oAz6zJ2Z2wNDnEqRn5XefjS4DVppsyQ33Z/tmEayJwMtFRUKAcI
         YHqNfhcHPhkbjHeiWk0Z8E7PFcBQeP19AHuOvuhWkllFBfVywgqiOh855LVTMl02ntwM
         zSaA==
X-Forwarded-Encrypted: i=1; AJvYcCVTdMagxhZ7zceS1IiTBB8GjN1kDyynePByx8l/WADyXQrqJMfUV5FjT9u71fJa2bacLm1DVyEvC3Hthu+XKDoJFi9qZVU+OP2xnugR
X-Gm-Message-State: AOJu0YzEypbzmUkWJz/ap3p9De9BRgef1lAIEnVIyYDAGz0g++yV1NBT
	JQp8HYkGrQWxxzg7rg/at/IEvbo+MpfjQe39urdw5NLYZzfIpn1i6VWBLkFWaJOyR2xzxz49MJb
	24fxV3w==
X-Google-Smtp-Source: AGHT+IFVSpXNfpmO6FuysIOMzuv9mXJwq3AIxUxD/bdN66yT+TY/eSwGCUpDm7q++8QDgTSZmN7Ekw==
X-Received: by 2002:a17:906:5944:b0:a6e:f646:6fdb with SMTP id a640c23a62f3a-a6fab7d6cf8mr558880766b.72.1719007433933;
        Fri, 21 Jun 2024 15:03:53 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf48b47fsm124921466b.59.2024.06.21.15.03.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 15:03:53 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57d07464aa9so2305553a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:03:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXGARtKJObKoVXyswBQLd9FsnPMqsCNj8lg5mPc6uzHUohTed2rbyb++D7p/0qP3knuNj/AHSUZi1Wu1yUtWTUZRxFURy/2QCsbTvoG
X-Received: by 2002:a50:d613:0:b0:579:e7c5:1001 with SMTP id
 4fb4d7f45d1cf-57d07e6f4ecmr5627181a12.23.1719007432440; Fri, 21 Jun 2024
 15:03:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <317d2de5fdb5e27f8f493e0e0ad23640a41b6acf.camel@HansenPartnership.com>
In-Reply-To: <317d2de5fdb5e27f8f493e0e0ad23640a41b6acf.camel@HansenPartnership.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 21 Jun 2024 15:03:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=whEQRH6eS=_JwanytAKERuWO1JQdzRb4YiLK4omzL2J-Q@mail.gmail.com>
Message-ID: <CAHk-=whEQRH6eS=_JwanytAKERuWO1JQdzRb4YiLK4omzL2J-Q@mail.gmail.com>
Subject: Re: [GIT PULL] SCSI fixes for 6.10-rc4
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Jun 2024 at 14:16, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> Two fixes: one in the ufs driver fixing an obvious memory leak and the
> other (with a core flag based update) trying to prevent USB crashes by
> stopping the core from issuing a request for the I/O Hints mode page.

Honestly, this mode page issue seems to happen every single time
somebody adds a new query.

Can we place just make the rule be that new mode pages are opt-in, and
*NOT* this kind of broken "opt-out several months later when we
noticed that it inevitably caused problems"?

Because if it isn't some mode page that we have already used for
years, it clearly isn't *that* important.

I'd like to note that the wikipedia page for SCSI mode pages doesn't
even mention 0a/05, and I had to go to some SCSI command document on
seagate.com to find it.

The only other hits on the first page of google? Linux kernel discussions.

That should give people a big heads up that "maybe this thing isn't
very common or commonly known about"?

Which in turn should be a big damn hint to not query it by default.

I've pulled this, but let's aim for this being the LAST TIME we add
some idiotic query for a magical mode page that is mentioned on page
413 in an obscure document, and that didn't exist ten years ago.

Because at this point, blaming "some USB devices" for not reacting
well to it is kind of silly. This isn't our first rodeo. You should
have known about this.

Maybe add a BIG COMMENT in sd_revalidate_disk() to not read random
code pages willy-nilly.

Not that people read comments, but maybe it will remind somebody that
we've done this before, and it never works.

I mean, we literally have this comment for just checking the read-only bit:

                 * First attempt: ask for all pages (0x3F), but only 4 bytes.
                 * We have to start carefully: some devices hang if we ask
                 * for more than is available.

and that's a mode sense command that is at least mentioned on the
wikipedia page.

(And no, I don't consider wikipedia to be somehow special or
authoritative - but it's at least a sign of "does anybody know about
this thing?")

             Linus

