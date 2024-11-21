Return-Path: <linux-kernel+bounces-416704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FBF9D4906
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E5C728254C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 08:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846721C9EDC;
	Thu, 21 Nov 2024 08:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="UxrFv0f0"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1A613BC3F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 08:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732178439; cv=none; b=cX+811rXaY9m5dkr3zo4a2hAjLo8hoH1s6WbSmLc/npvCXLFrHvNS3DgjYo05i9Ngv8/mTsscnVcCru13AD1Eo8L6As+4I/KLUEOQwgANbZ8Rsqfz8Dhs+Gcw+RuAFlQm7Tuq0/e4PNvAPuh2sFiThg49EwUXzVeaQAfcnihCAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732178439; c=relaxed/simple;
	bh=I4eBaZaVx6nes8q0hwKUpkYL2IV6pUfZfirvBunVQdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W4csUj4aMgS3kU3Q+3V0MVWmOfM2zPo8rrfus7hrBn8yF7W9fRLXBj1Y2zr1wKQqfjwmTu42250ew0BUsYWygbHLTIPAtT6w7EcL2obBi9EMRYAAm3DeWS1ecKH77IWLGjaHOtXLkl5uisEau1KOdImcp11be7OczZx5q+JOuZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=UxrFv0f0; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cfb971de0dso91875a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 00:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732178435; x=1732783235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4eBaZaVx6nes8q0hwKUpkYL2IV6pUfZfirvBunVQdc=;
        b=UxrFv0f00zYFQyAvJYufghBse4xOgeSft73FoehKDvkWFul/rlrCWb7cDjrnCGU9qq
         QWAPTqySA+fodGXeuaTeqj18a4XK1vZqKbJtLFfLpWPs6ebXvROs7bULSp/UpRi4v64X
         ETNaEdknkoufofH7/4/FqE1ifNgNK0eo0XMQOAGGKrbKccUsQ7YNk1qTk9bqDYVuqYQ5
         9xUbWBmOglQg8KxWYHYo1jkJ32Ji3fk99PzV0+5mi1yvlU7q2Esz4vIEjf+XLTtfOda6
         jAV/oXw2b7dCdg6GsV2pXUy+Bu3Zqo6ZJVYVQ/cRdCc4T1h2nl2JgmE664d7z0J7b5zM
         jJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732178435; x=1732783235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4eBaZaVx6nes8q0hwKUpkYL2IV6pUfZfirvBunVQdc=;
        b=D/w+2CkftT27PBzYIEKI4VrHqrZZtUZLnbTljb5L2ePL1t0Y2xM/ic1d1XQKlEIo5n
         CEcAdHISbdxNNHtUXstJujSj4wEwmpg3+013dnL7UX9gRMojdmE+d4kv/UnR95NbF8iM
         zobh33S6vsvBQzWvSe6rswXtmKUD/ljatF5Cn8AgZUOO0bAiHtVy/Hd6vS/Jmf9cFLDx
         MCe879bYaRjPEdXq2PPLv+yErDLpHAdg6+0NSao+FtSGhjyFVTpUdy45bK0IqlCNkAfG
         Ud3fri0HjlggLXBysid6LZtrrkswS8tLdjXO5LpzJArKZqmM2thyfuzAnyU3ylZCTCyH
         gGkA==
X-Forwarded-Encrypted: i=1; AJvYcCWFvpNSxbDKoS4x4ypJ8Mqljd3nR6XaMyDETnhNLpFFv5WH/dXD1TnWwwQY6mFkqZ0DBBgFVMuWnzNF4IY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNtY3dZ3R+PYaom3CcXlM0NyA9ACuOPuAHtSS+WkLMrf4Yu977
	ZYtppbbCHKwLrBcD1YIgY9HfnBEwM/FpqD+XMazKEw+NKHfbcnlaWJt4EowfempGrt9Q8NQvtqx
	zpBTWRzvMZ7vQjcnj/oWfnsznqwm6ExL2EyezI8zRNAjvtkweNA0=
X-Gm-Gg: ASbGncts6iRabeB9iddapBzN3vKHRcAv1AlNDxTfHL0i+haYY5PVJM4QSzmbbAdlQHF
	6byZfw/k3XW17LZX0Yh941XTwkmqxDbQ=
X-Google-Smtp-Source: AGHT+IEwNtBFHJJTYnKmgvScRjsEoF81IE7XkBqTTKtS39lBY1EKm8X0tj3K0Chi00aViPvYAvJ1SmIrbUFKUwYdQZg=
X-Received: by 2002:a05:6402:35c8:b0:5cf:4549:ade7 with SMTP id
 4fb4d7f45d1cf-5cff4b341a8mr1740156a12.4.1732178434897; Thu, 21 Nov 2024
 00:40:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adf796b9-2443-d29a-f4ac-fb9b8a657f93@huaweicloud.com>
 <20241119152939.158819-1-jinpu.wang@ionos.com> <CAMGffEkODwo19u0EjKojQ0WaWVkvOOB8aRR8R3NXn+oC6TFQWQ@mail.gmail.com>
 <d456368e-cff5-5476-238e-4cc97f016cfa@huaweicloud.com>
In-Reply-To: <d456368e-cff5-5476-238e-4cc97f016cfa@huaweicloud.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Thu, 21 Nov 2024 09:40:24 +0100
Message-ID: <CAMGffE=hKeWTJzna8gFi=Q9wSuY9SLFScftdGVqc5MNW_jxQ4Q@mail.gmail.com>
Subject: Re: [PATCH md-6.13 4/5] md/raid5: implement pers->bitmap_sector()
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Haris Iqbal <haris.iqbal@ionos.com>, linux-kernel@vger.kernel.org, 
	linux-raid@vger.kernel.org, song@kernel.org, xni@redhat.com, 
	yangerkun@huawei.com, yi.zhang@huawei.com, 
	=?UTF-8?Q?Florian=2DEwald_M=C3=BCller?= <florian-ewald.mueller@ionos.com>, 
	Christian Theune <ct@flyingcircus.io>, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi
On Thu, Nov 21, 2024 at 9:33=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2024/11/21 16:10, Jinpu Wang =E5=86=99=E9=81=93:
> > On Tue, Nov 19, 2024 at 4:29=E2=80=AFPM Jack Wang <jinpu.wang@ionos.com=
> wrote:
> >>
> >> Hi Kuai,
> >>
> >> We will test on our side and report back.
> > Hi Kuai,
> >
> > Haris tested the new patchset, and it works fine.
> > Thanks for the work.
>
> Thanks for the test! And just to be sure, the BUG_ON() problem in the
> other thread is not triggered as well, right?
Yes, we tested the patchset on top of md/for-6.13 branch, no hang, no
BUG_ON, it was running fine
>
> +CC Christian
>
> Are you able to test this set for lastest kernel?
see above.
>
> Thanks,
> Kuai
Thx!
>
> >>
> >> Yes, I meant patch5.
> >>
> >> Regards!
> >> Jinpu Wang @ IONOS
> >>
> >
> > .
> >
>

