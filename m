Return-Path: <linux-kernel+bounces-339529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E93ED986673
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 20:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 800B728616D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32D813C8E8;
	Wed, 25 Sep 2024 18:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jLPp/u/Z"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC881D5ADD
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 18:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727289783; cv=none; b=DeIFXevcSmxdJFyzhVi9tinRhPAdQtvvsmxBqOBkDyM2BKmrFoMAWZa/hqyFtAudeBEaV+b5yaE3q2fCI0bt6T6165rFgus51vI8/0UnTpojY0Qvl3QREg4zpilB+1+7s4w2K3Nd4bystBr2wiT5dDraawM24wScL9CyOk/bN24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727289783; c=relaxed/simple;
	bh=EUdOiQG2OleCZQP67Et5LONF0k8kIVl/hMckbwTeXrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n00ooi5NKGoMONYjzA3Lymy19KuLKiPNYtvXUHTzB/2eUbpM3HOKyVDNOpVFknFONkTu8WQQmymDt+0heGTwwLs2qld0DZd/xSwZpOemlZJ7Mnx4dYLSn/kwS4PYwajogkdbnSTDWdxGaGC1sP1o4z/weWyWYYvEiPfkO4KOOUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jLPp/u/Z; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6dbc5db8a31so1670057b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 11:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727289780; x=1727894580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kib0b2E/kIKMUjGNhfGZOFLj7ugQLddvx77Aw1BvvlE=;
        b=jLPp/u/ZIa434mJqrDf3hoCIj4/C3zWxGF6A8MDMUPaUlkm3c4+cveSIm8ncq3m4D1
         RQxbhM2lHa29ulnhcHRT3JyWTyzAL+UGRIWOyUj/atHzFYGA+dOJXlSuh3gm9pI4g8ij
         5WoKwcYQxFsL7kwnopquagblx+j7v6m2dph7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727289780; x=1727894580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kib0b2E/kIKMUjGNhfGZOFLj7ugQLddvx77Aw1BvvlE=;
        b=ieHeK6+FECmtant4H4WPKKKlivGGl7bG5/GPHS8ASshp7xsq9z6yypODTWQLX7epD+
         Cn5t9CBa//VlzTn/XaRrCVdaAlllJMKB2ZRbOUumifKNfG2Tu7t8p5HQOjlZNxkWy8dV
         ihEqrq8vdTAgSf7RlXKAfVYwIuU5yrGwG5cGOvozxxFue6T3aZYF+sznv//6kHpZCoDT
         0t/jXya32JCvadKoLbs9Ett9PJ1JGAJqXsE/eeaOOJuscMpTlAW0uNBUdcXc5AXTi8HQ
         Vk+G6Say08WKdjB9nFXTYMwskFKUCQIc4o4y9/Xzrd7rwJT7g8pX2IM2HmIafbMlmXqH
         CJFg==
X-Forwarded-Encrypted: i=1; AJvYcCXnG+0fsHoWH8yjQxC1bSISFV+ZVVlbCkSm+lDn92eKy27iEnvqUGzcz4/7pFh96DP5OHLf0H5FObC95oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YybzU4O12pdtD+8M3cg7b5vBY7VyPGJBQhfeWFVW9fSP6OmZ0Gd
	ikA+xN9MY5B6+iAkklPnx954cO5l4CFXQRBYtC8/iZv1V+LtcE+kBeWpx/a07yACBxk1qpAnmz6
	+AZNObp7p7VoKGnz4xNtfwaBE4gAkXW2f8Bdy
X-Google-Smtp-Source: AGHT+IF/4YIMeETijQEpwOlOjqS/jrOYf+dKzGmAK1z8lWNh0ngpaNQJlCJQ4fw4U65Ebgc8guTM1aUNL05svIWGyWA=
X-Received: by 2002:a05:690c:700e:b0:6e2:1c94:41f8 with SMTP id
 00721157ae682-6e22edc2088mr7126377b3.10.1727289780117; Wed, 25 Sep 2024
 11:43:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925162513.435177-1-abhishekpandit@chromium.org>
 <20240925092505.7.Ic61ced3cdfb5d6776435356061f12307da719829@changeid> <gqceveqpbvmiv3mg5cs3k3qd4rr6fpb3xksvxvdhkugr52paoj@olks6bqjc436>
In-Reply-To: <gqceveqpbvmiv3mg5cs3k3qd4rr6fpb3xksvxvdhkugr52paoj@olks6bqjc436>
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date: Wed, 25 Sep 2024 11:42:46 -0700
Message-ID: <CANFp7mX0=9qHb8_UotKjDo8rGemA7L+NGp3J+qSzBg_9Pp2CTw@mail.gmail.com>
Subject: Re: [PATCH 7/8] platform/chrome: cros_ec_typec: Thunderbolt support
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: heikki.krogerus@linux.intel.com, tzungbi@kernel.org, jthies@google.com, 
	pmalani@chromium.org, akuchynski@google.com, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 10:13=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Wed, Sep 25, 2024 at 09:25:08AM GMT, Abhishek Pandit-Subedi wrote:
> > Add support for entering and exiting Thunderbolt alt-mode using AP
> > driven alt-mode.
> >
> > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > ---
> >
> >  drivers/platform/chrome/Makefile              |   1 +
> >  drivers/platform/chrome/cros_ec_typec.c       |  29 +--
> >  drivers/platform/chrome/cros_typec_altmode.h  |  14 ++
> >  .../platform/chrome/cros_typec_thunderbolt.c  | 184 ++++++++++++++++++
> >  4 files changed, 216 insertions(+), 12 deletions(-)
> >  create mode 100644 drivers/platform/chrome/cros_typec_thunderbolt.c
>
> This patch looks like nearly exact 1:1 copy of the previous one. Please
> merge both altmode implementations in the same way as tcpm.c does.

It's easier for tcpm.c to have a merged implementation because it
simply forwards VDMs to the internal state machine to handle without
doing anything with them. Our implementation is closer to
ucsi/displayport.c which needs to maintain an internal state machine
for DP and TBT VDMs and respond differently.

I can merge the two but I'd like to understand intent (reduce code
duplication? reduce the number of files?). As it is, keeping the files
separate makes it easier to understand how each alt-mode operates in
my opinion.

>
> --
> With best wishes
> Dmitry

