Return-Path: <linux-kernel+bounces-269816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC5494371E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B18C1C211CF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3744A16087B;
	Wed, 31 Jul 2024 20:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H7HsdI36"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FF6148FF3
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 20:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722457785; cv=none; b=i6muu+jb02AvDgj4sTMuuVBeRxxMBkcEQnzH37rejZ1JVmWY/hCOadrg3oQBphhLdndqfXKAOnoiBRm0Bz0CMyfMcviQYK1OLTFY2aXzhvnwnBtoYOihEEfHXWITXNqV6IDPEBIih0MGDwWWWk7xVdH7jde+O7LShu8mFkJ9eEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722457785; c=relaxed/simple;
	bh=FqYVA6k1iLJ0poKNCNzTySZxGfnEvNDdUMDGkm/7lBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y38MsW7PWxukPgGrn0Zcp2w70aP3DrIxEXAGiV69RxLn1GFRSw/DGr04y4dKVHviYFBi+fnVPmo1FLucss1E94GU8yDOx0PUog632DZTZ+cF+6vHvDKcwwEcZNJhHJO147HCMW3JVRx6RxKI/iIMNPX2HKiheQdTlz1Z7iNcK2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H7HsdI36; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-709339c91f9so2579848a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 13:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722457782; x=1723062582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SZR84pufxEJHH9akehyEVjbbV4hh1UfXsmtqulpwvc=;
        b=H7HsdI3655HKZWKn26fhQ2CLdgGdE05XP2gb5MdKoDKXlZjvcfxDk0OoI+RbxhkLRB
         8msU5x/5c0vnJJjl5YY9L29ih7GQHQi3jko7uvlGrmrKghCMBbON+7BJPJ61P1xme1Rh
         JWQ7auhFVEKCJqSxzS2/gUz3riu/TZHQ/7YJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722457782; x=1723062582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6SZR84pufxEJHH9akehyEVjbbV4hh1UfXsmtqulpwvc=;
        b=HdsEXYreziGVHZNNTIxnGfF1axjv5Dk1ZLUn9YMMu/ajACfoK6K3kx2nPjBgiD2Bl9
         Ss551o2Dc2KX6KKGeBQpqyJq2UbxF6jvGC6IHo6gNuN/D8mQcPSk1kdk4FXanHR7o+YD
         sCe3EGo18U/4aQqj1PT1hLI5Odo4dKPmKfmiK5TXPj+tRFcLUMDYmELIQ0wWKqxgJfBc
         Fnhytbqu8WuVj5i0ksV779mH/ALY2nBNBJfVbH3c0IpJBPxsW+SqKj7xyJOpEy6mG7vk
         1mlaY623ZiKZPlpCa9fZeVAuGaQgB4MEGS5Q67+6KSHPLGGYR7rzsaUP4jDe7bc1pRvz
         /oCw==
X-Forwarded-Encrypted: i=1; AJvYcCWgfXyWlpsSL4QSjMcv2YgjlzH8l77uQN8+39Xmy23I2+tM9w2pnjRJ6gjzfyHMFrBt0o5Bp4+9cyDA1VKCzr/48odFQn/LvM9PqzFs
X-Gm-Message-State: AOJu0YzIAkfEBRAdvUtaMxjnMhafwtvyg8OeU8dXnhjUox6i9zEn4O49
	izxtXyzxUi+P0AzHQSqwuG+BNu/2f1Bb2YxL/3xOMPS85dTPMdJNxYjNexRZunspazvPwd8vipk
	=
X-Google-Smtp-Source: AGHT+IHxjsXlefdLdKx4RDFuQw+yKUiuv6CNcsXlDq0psso3Z06IeXNqv43DbSJ2csPSmWgjqTux5A==
X-Received: by 2002:a05:6830:3919:b0:703:6989:5b04 with SMTP id 46e09a7af769-7096b869262mr258658a34.31.1722457781752;
        Wed, 31 Jul 2024 13:29:41 -0700 (PDT)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com. [209.85.160.179])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe82012bcsm62909701cf.66.2024.07.31.13.29.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 13:29:40 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-44fee2bfd28so484421cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 13:29:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWkpt7VjtVeNhRKP+unMFgvOlynyYGl7U5XBrrYiD7d46U8qNddSH1+wsBaNUu1ohA871DwebqQr/qJoBTlBKHdwqoNqqh+x7hVXpc
X-Received: by 2002:a05:622a:13c7:b0:447:f914:8719 with SMTP id
 d75a77b69052e-4504199ef23mr5362921cf.2.1722457779975; Wed, 31 Jul 2024
 13:29:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517170246.1.Ia769fe5fbeaa6aca2edfb01b82eb7df0c6955459@changeid>
 <CAD=FV=Wd4UdjGdFODGCa4acviQG2V_YuM9J8oxi8A--ZmseNUA@mail.gmail.com>
In-Reply-To: <CAD=FV=Wd4UdjGdFODGCa4acviQG2V_YuM9J8oxi8A--ZmseNUA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 31 Jul 2024 13:29:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WqyEo9mWgYyRQjLmhh1pNTNTFM1zwbi2g0n9FMseUtHg@mail.gmail.com>
Message-ID: <CAD=FV=WqyEo9mWgYyRQjLmhh1pNTNTFM1zwbi2g0n9FMseUtHg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: If memdump doesn't work, re-enable IBS
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Stephen Boyd <swboyd@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	Johan Hovold <johan+linaro@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Sai Teja Aluvala <quic_saluvala@quicinc.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 10, 2024 at 4:52=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Fri, May 17, 2024 at 5:03=E2=80=AFPM Douglas Anderson <dianders@chromi=
um.org> wrote:
> >
> > On systems in the field, we are seeing this sometimes in the kernel log=
s:
> >   Bluetooth: qca_controller_memdump() hci0: hci_devcd_init Return:-95
> >
> > This means that _something_ decided that it wanted to get a memdump
> > but then hci_devcd_init() returned -EOPNOTSUPP (AKA -95).
> >
> > The cleanup code in qca_controller_memdump() when we get back an error
> > from hci_devcd_init() undoes most things but forgets to clear
> > QCA_IBS_DISABLED. One side effect of this is that, during the next
> > suspend, qca_suspend() will always get a timeout.
> >
> > Let's fix it so that we clear the bit.
> >
> > Fixes: 06d3fdfcdf5c ("Bluetooth: hci_qca: Add qcom devcoredump support"=
)
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > I'm nowhere near an expert on this code so please give extra eyes on
> > this patch. I also have no idea how to reproduce the problem nor even
> > how to trigger a memdump to test it. I'd love any advice that folks
> > could give. ;-)
> >
> >  drivers/bluetooth/hci_qca.c | 1 +
> >  1 file changed, 1 insertion(+)
>
> Totally fine if you just need more time, but I wanted to follow up and
> check to see if there is anything you need me to do to help move this
> patch forward. If not, I'll snooze this patch and check up on it again
> sometime around the end of July.

It being the end of July, I'm back to check up on this patch. I
checked mainline and bluetooth-next and I don't see any sign of this
patch. Is there anything blocking it? Do you need me to repost it or
take any other actions?

Thanks!

-Doug

