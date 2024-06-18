Return-Path: <linux-kernel+bounces-218547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3FA90C1BC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 04:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21B051C21A99
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12A21C2A8;
	Tue, 18 Jun 2024 02:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BDndtwMO"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9278D199B0
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 02:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718676747; cv=none; b=muNzxWwz64S2XgDW54iasyAdelHjcLKC9xstKMechWhNjsGkhQtqs15h9mPj4wAvadVVUw6kfyvJ2XjWF2OLbDKyvF7FqOnYZrCjxwzyx/WHlvpxY53IhLdHNqvO7DjvmHl0sphePWn+BXFip0BXF2TwTTsDI5HBUShJOFtwJOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718676747; c=relaxed/simple;
	bh=XfsgfTxIbf80Vaj2+gGtTRv2D1VtoN9sVBiv1EbMpe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGCy6KvsQTF+V0EzPPzPNT5Xy4Nl/rSAWUUexwWjfgBTMqj8Ve+hcZJvD8ZlT+oiZY8HznwBYiE5BKpOYtmbbt5t91Zlxt9dbIRqA0K4AzxGWfwHg1MbKNebUXdy3+izl6lleqcvBuYP+3IFtHjo+d2lo7TxuoWeRiPUqfu5axs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BDndtwMO; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43fdb797ee2so24772441cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 19:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718676743; x=1719281543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfsgfTxIbf80Vaj2+gGtTRv2D1VtoN9sVBiv1EbMpe0=;
        b=BDndtwMOPRhaG5ald4kpU+EJ5naZa2bswKenuJHeb/tBzo4R2C7fgYaW7WVLJycyUw
         uimDCvVuxJfKTnq+Yb0CjGcj86KTWOk6TraFYfaSPElYYISe0wQY9vGVJPZS1/KP2AKn
         DhDIsdM1nA/ETNLE4E4LNGGUKCzpb0zYmhVz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718676743; x=1719281543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XfsgfTxIbf80Vaj2+gGtTRv2D1VtoN9sVBiv1EbMpe0=;
        b=uPL9m9G3yjLZ1YYnWXzK4A7hFLDK326TESp1Qr7n1fVmOO8JHcjnrUA/6SO56wUGdV
         iN/BUBzNtG22KFg5AbbS5EXdoR527PoU3YRfaUK/h1J0iYj/cYqTITlt3fIB3c1T7VJN
         HfkLBDDrYNtKFrVVrQYLKaIB/mjiDwz9DUDESKVj3WfzWHmJQfk4QS5jL3oMH4hqmHXH
         pf7e0eTuC/sL8LXbutOl+EuWGR3raJYvAkTnZxuQ1IMBKTe04na6AFMNDeMqRTQIGMt+
         HBV4jiUc+F6sthqzovWgkQlxwW5YMO1LMelnVCUytTo1Udnfzkoo8O7n/9R16SduCwAU
         gcRg==
X-Forwarded-Encrypted: i=1; AJvYcCXl+cujVWiBdE6Gcd4t2wbUrnF/tyyBmNx+kzbcHXfP6TyqxhmKx71P9QUtcNl7O0TO4YLkbgaCum/DCCaf4/qqcjyF61LVnwFO+7bp
X-Gm-Message-State: AOJu0Ywm0h6AxJoL9d5vCSXFVvLx5KwMR8E0DzULrw4a8EQg/Gf/Tjdl
	cOmbgMYrBXOG9OCxoh3u+5AUufm0kjWAaHquSmNdJYsZox0e2sLRvOUuDgpn8yU26Zbg21n5EwU
	=
X-Google-Smtp-Source: AGHT+IFjbGzv2GfWTRgOzow9N5IEdhMRMWhzfMmOh5tF1lzY5vCaJe1OdVI2S5Rw3gVych2RsbY3yg==
X-Received: by 2002:ac8:7f08:0:b0:441:54cd:2752 with SMTP id d75a77b69052e-442169f6b44mr136030831cf.39.1718676743152;
        Mon, 17 Jun 2024 19:12:23 -0700 (PDT)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441f2fcc2a2sm52256811cf.72.2024.06.17.19.12.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 19:12:22 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4405dffca81so64481cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 19:12:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXy40VKn1VwClB5snme4i3An4ujyuT7sUHYLZ03uWwdqFOxHXZl0pObpJIGnEza3ZQOSjN/XwBBJpFJ6ird93TQDziB7g09d7NiyaQg
X-Received: by 2002:ac8:598b:0:b0:441:62e9:98b with SMTP id
 d75a77b69052e-4449cc66d3cmr1351231cf.10.1718676741668; Mon, 17 Jun 2024
 19:12:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617103018.515f0bf1@endymion.delvare> <xd2yybtxvzte7gwqwg2vudzvhoekqao2dle6zsuduzjzi3rsay@xhahwof2prph>
 <20240617132348.5f20bf89@endymion.delvare> <vsrsvmrkqnmxs3ncqv5m2gevzefiq55tr2iolxlmoehsvgcfkn@hyx37vax6r5e>
 <20240617201814.73a07702@endymion.delvare> <jbqbn6zaqq7j5htxuqxb34tjrf5lnqabkh5ywtnklhd4owyc3h@ztvolr6hjrti>
In-Reply-To: <jbqbn6zaqq7j5htxuqxb34tjrf5lnqabkh5ywtnklhd4owyc3h@ztvolr6hjrti>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 17 Jun 2024 19:12:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X4qVDTOdMFQeEiJi2DD=tuEj66vP35XQKrSj5-r_YADQ@mail.gmail.com>
Message-ID: <CAD=FV=X4qVDTOdMFQeEiJi2DD=tuEj66vP35XQKrSj5-r_YADQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] drm/display: Drop obsolete dependency on COMPILE_TEST
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Jean Delvare <jdelvare@suse.de>, dri-devel@lists.freedesktop.org, 
	LKML <linux-kernel@vger.kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Andrew Morton <akpm@linux-foundation.org>, YueHaibing <yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 17, 2024 at 3:26=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Mon, Jun 17, 2024 at 08:18:14PM GMT, Jean Delvare wrote:
> > On Mon, 17 Jun 2024 14:55:22 +0300, Dmitry Baryshkov wrote:
> > > On Mon, Jun 17, 2024 at 01:23:48PM GMT, Jean Delvare wrote:
> > > > Hi Dmitry,
> > > >
> > > > Thanks for your feedback.
> > > >
> > > > On Mon, 17 Jun 2024 12:57:19 +0300, Dmitry Baryshkov wrote:
> > > > > On Mon, Jun 17, 2024 at 10:30:30AM GMT, Jean Delvare wrote:
> > > > > > Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"=
), it
> > > > > > is possible to test-build any driver which depends on OF on any
> > > > > > architecture by explicitly selecting OF. Therefore depending on
> > > > > > COMPILE_TEST as an alternative is no longer needed.
> > > > >
> > > > > The goal of this clause is to allow build-testing the driver with=
 OF
> > > > > being disabled (meaning that some of OF functions are stubbed and=
 some
> > > > > might disappear). I don't see how user-selectable OF provides the=
 same
> > > > > result.
> > > >
> > > > Historically, the goal of this clause *was* to allow build-testing =
the
> > > > driver on architectures which did not support OF, and that did make
> > > > sense back then. As I understand it, building the driver without OF
> > > > support was never a goal per se (if it was, then the driver wouldn'=
t be
> > > > set to depend on OF in the first place).
> > > >
> > > > Some of my other submissions include the following explanation whic=
h
> > > > you might find useful (I ended up stripping it on resubmission afte=
r
> > > > being told I was being too verbose, but maybe it was needed after a=
ll):
> > > >
> > > > It is actually better to always build such drivers with OF enabled,
> > > > so that the test builds are closer to how each driver will actually=
 be
> > > > built on its intended target. Building them without OF may not test
> > > > much as the compiler will optimize out potentially large parts of t=
he
> > > > code. In the worst case, this could even pop false positive warning=
s.
> > > > Dropping COMPILE_TEST here improves the quality of our testing and
> > > > avoids wasting time on non-existent issues.
> > >
> > > This doesn't seem to match the COMPILE_TEST usage that I observe in
> > > other places. For example, we frequently use 'depends on ARCH_QCOM ||
> > > COMPILE_TEST'. Which means that the driver itself doesn't make sense
> > > without ARCH_QCOM, but we want for it to be tested on non-ARCH_QCOM
> > > cases. I think the same logic applies to 'depends on OF ||
> > > COMPILE_TEST' clauses. The driver (DP AUX bus) depends on OF to be fu=
lly
> > > functional, but it should be compilable even without OF case.
> >
> > The major difference is that one can't possibly enable ARCH_QCOM if
> > building on X86 for example. Therefore COMPILE_TEST is the only way to
> > let everyone (including randconfig/allmodconfig build farms) test-build
> > your code.
> >
> > On the other hand, if you want to test-build drm_dp_aux_bus, you can
> > simply enable OF, because it is available on all architectures and
> > doesn't depend on anything. No need for COMPILE_TEST.
>
> I'd probably let Doug respond, what was his intention.

Is this me? This looks like a straight revert of commit 876271118aa4
("drm/display: Fix build error without CONFIG_OF")

I don't personally have anything against removing COMPILE_TEST for
this given that I wasn't the one who added it, but make sure it's not
going to cause randconfig issues.

-Doug

