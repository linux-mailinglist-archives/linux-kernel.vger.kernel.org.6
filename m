Return-Path: <linux-kernel+bounces-301102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D24395EC63
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA811F21483
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F32255898;
	Mon, 26 Aug 2024 08:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lkNMvOxh"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69920286A8
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724662336; cv=none; b=dYcRoI1bywPU7nwpGVGeS33P0WmNc64LOjIyPTxu4iX0QUXxBYhOgQaAYDkUD3HaGrycvE29JYBxGUxVK79aamIGTYX7mdeLGJoxGZ4BP+Jwaird4i6J0vZO6AuOXZPKvxQAPtGmMT3CWU6V83319/ApV0cCHy8SM7fZd5rUg28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724662336; c=relaxed/simple;
	bh=iLPgq4j7K2LiYLxuRxf5ckNN955ctmmarm/caOOsssA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jp7dIJl7CVpGumTiU2f3NxR7dxxcwWyCwKk01Xi7e644e+6DWRHpvM84YoQI3tofR3rOmWg3es5ZE9aMPA0qXUMa8DJW7vhtyGUrSE3cQmMsHNiHJmSu6y/ILVOulvgEN4R4HEccsHN55dwoCnJ3GLb7/+La7wgAI02Gih5HmxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lkNMvOxh; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5343d2af735so2503293e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 01:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724662333; x=1725267133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLPgq4j7K2LiYLxuRxf5ckNN955ctmmarm/caOOsssA=;
        b=lkNMvOxhXIswR4nnZFnAVWjtCk2qP7x27k7mbQQD0h34Aw5Ahyalv4H029ZKjhDKPQ
         EdvLHffOZqCKyvPkm4WYu+CNLKQAnte++YVmBLPXXuZI4WOm6R0LJGKh1lzbKh3d2Psc
         zBYQiQhPmiRnhDMmPQ7v9oyZYE3pnH8dpYRMQvO27Bu9HY89mmJjoP9ovSVZ52Fc08Jh
         AQ2+MNoWF9fI2SJOewN/D0yuDIX271s04926jtON9z9Z08ecwGggN8uBwdqDUcGxF1ZP
         X8SKMmEWUqLxJsuRmOPqfgJz2P+qJlc//URw8b+s6VPetBUtU8CKdUoYHm8WlFT6U9EE
         gJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724662333; x=1725267133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLPgq4j7K2LiYLxuRxf5ckNN955ctmmarm/caOOsssA=;
        b=AM59nNDrB/KPAoa8TNVqNW5i5+UqkLWqG1PauMxrPIey8Dz1wclHVlLvAxi5Qmqvps
         8VCfUGr+1VpmJEAM8cw5HnfluRBlHiTYMlexK6loLXU6ce3nbpuBI0lm97T4bgdK7rHw
         xUhQT+TJw2t64AXZxfvxN28ZSnobfFPYQkPt2ZvBgI1yYN7VeWU+yY+J2Jf+SMtTCkdd
         ZPtuNwoHBCXgT2IxPE8OEaoQb3pQhQzddumF1G7IkNuLrw7WvjE4oXKW+qKgRJTQuPRU
         oLW9DmTBW6lGepj2HMFPW1n0/GnelH47DW2Uj/z6l9MupLsoKLe0Lfq5fPe/TfUYRzYb
         4ipw==
X-Forwarded-Encrypted: i=1; AJvYcCU6ZDlIC+ddP1NhYu06PILRYcyCMb6b8c+gQrk947wTMgkxcrThwdABXU/1ZR46pP0wtmjqPcdhGSlRwZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIYD6N8rjtKPTv9gKjS4De5xHeFxdZ0T/DXZIo+aGf9rfDd++Y
	rKw/eplP1t3oWctpGh4XbFtC1Dlr6RDT0sLOrEp6HgDmVmE7moyVyYjZD7IRIEoOUIQoTXLnZ7a
	4V1PhKVLqv4iCri0Cup39telb0qTbASBcxvzBEg==
X-Google-Smtp-Source: AGHT+IHdurCu1h8I5sDDWlcStXgFvab4u4dfQ3BDVkKhxSBCdaAQCimGjSbIMIoVyf3zCgPHH//JMjG8dg09AgOyRLc=
X-Received: by 2002:a05:6512:334d:b0:534:375f:97de with SMTP id
 2adb3069b0e04-534387bdfc1mr4983010e87.58.1724662333113; Mon, 26 Aug 2024
 01:52:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805014710.1961677-1-dmitry.torokhov@gmail.com>
 <CACRpkdYFc8vuz__7DkFSMFxUC=LSwCJmEun2KXgUvPMq+_e17A@mail.gmail.com> <ZsiygIj9SiP4O0OM@google.com>
In-Reply-To: <ZsiygIj9SiP4O0OM@google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 26 Aug 2024 10:52:02 +0200
Message-ID: <CACRpkdZ_y=2WKCLwi5or-=MasvNw2bcxht6a+bFjV=yAfvQhdQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Remove support for platform data from matrix keypad driver
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Arnd Bergmann <arnd@arndb.de>, soc@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 6:02=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> I'm glad that we agree that we do not want the elaborate merge process
> and instead push the changes through one tree in one shot we just need
> to decide which one - soc or input. I am fine with using either.

I'm also fine with either, but let's take the input tree because the
you're in direct control of it so it will be easier.

Yours,
Linus Walleij

