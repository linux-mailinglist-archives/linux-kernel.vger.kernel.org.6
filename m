Return-Path: <linux-kernel+bounces-560188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86305A5FF1D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C8319C48AD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661441EBFE2;
	Thu, 13 Mar 2025 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpIC1ypV"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EAB189915;
	Thu, 13 Mar 2025 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741890113; cv=none; b=SuWVmnHGDbvG8CgS2hzFr18jZ84qgYF9tUgjWng7PC18GN320KcwCjODTVNcPpb65q+5eDDEyin/hgGbq231yJpx5CbM3PQP6yfKFZGvGslJekGZfSy7Lu8/9Niu02va8mcYSgR/dcy7WdilVKKE74Alq+cpT4Cp68RcVbRmQUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741890113; c=relaxed/simple;
	bh=yQ6Bs1SB0w+9fA5SYKYGHNWa/kfL1De3qp5h3FSgzlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OZvjEwL+myGch327SCl4HFXGvH48m2YVGyC7fKohdbECnE4gaf9xdMujAxs+0z0IPmIuxH9iWuoYR4R4Oktg5vNg9yxz0PChytY+rfbLzM3E8LTLgaUhQ7QaaV5mTcjPT0R5/+y/qVpOY0hgbN1AaavrGd5trnJuFEKmveQjz3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpIC1ypV; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-523effaf7ecso622105e0c.3;
        Thu, 13 Mar 2025 11:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741890111; x=1742494911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CpXrFA/1Gved3JSNXjbX8H6OLkoXNJ2jAdYSQvp3qEo=;
        b=WpIC1ypVM14sGeroesZyYcmTTnyWFng1Wj/qIEOokv4e6OEWLd/k18Za0OT4mtgDFQ
         mylVUBu95iFl4RbbesOjnVKlI6IsrnNqExJeYs6SeZHd2sdMFfLCu5JfjV4f9ObHQO1J
         RMPme4/9J2UB8iQhSEGgVTWRN5HAyNS7W0XYxtsiJb/5CTfauXxugsrqkQdOx7gkfj5d
         cI/rEvNWmSs0QoLa2GHZQCq93MwJFX4BLyR17uNb2VuxCpCcl0LyZr87/0rgg9bBeJgd
         sWO+IgXSPZNJqd1Mr0dN6uSq761RLO+QLEEcWQ0XBbBGvtnMz1vrLww9+oeLu+2SOjFv
         3FQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741890111; x=1742494911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CpXrFA/1Gved3JSNXjbX8H6OLkoXNJ2jAdYSQvp3qEo=;
        b=nivRHW0nf/DGEh9YMP7RzJj/lCIwP62vvGm/7ltoNBcWhgGaH2G+FFdotBAE/vGlrC
         mQ/lCatYbWEfUjD8uyymPzMyYkF2jzflolGiBpa4CRC1P7Sy0FaUOsRWuhWd7t1mwx4q
         VeAmrFX5VKX8tqBLbM+z811S93c/CuI29koz9TC6cbIWT/wljnOixd0MqDQ4aSm4r2MO
         +p/thWjOldZmVaMSkw70oWLm9oq/kBgW8FaR9UkFDEnHrFg22y/1KDn5ZCBlbX2791B5
         lqSw4JedM82N8bfJri+jPrJQauz+/rsCIaUml+HmOHhQoJxbcjqQGd/A86h4D1oxcQS/
         1MYg==
X-Forwarded-Encrypted: i=1; AJvYcCUpnJ0pP5/MIUTAgP450N0PpTapzA1cGlFnNYkMCUhLP9ne74yH0lTbGKV8cdDvFUJn7voE1LG1YFOzbEwyJorGcPSw5w==@vger.kernel.org, AJvYcCXgowbWgDHn9MI501WgqjcJvezYVWu1SQ6YLa+3wLm0Pc8eykzGlRrsO0IPWorO49AiPPre06CSp6aTJZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzld+SA66r/aeRZx/fM3zDtVyT8jAaFyQZIstvX/Vq29f9/Sjrb
	SIS1Wic4AMHKpJJhVzk4mjA7DfO/PfVfsG7KHb4dB/eS+01BhhuVmSIWzOZR3USYJlf1mCI+B/r
	4/5dUPYNBdC1olydwp9z2WfBPz3Y=
X-Gm-Gg: ASbGncv+DRZF41dnMVsndKuJzYaf8LCkdiNy0y6ECysPfdHPG4oXcXW+At3nm8fqPSp
	078yLOahYub2/XBatkTbTNVaBnxc6HyLUuRlEShHklc8zcWhFW+UXb4+17dTJvlGwUdpTvTfUm2
	+c3KI1DTFXjGEF+Xn73KJZt59lzA==
X-Google-Smtp-Source: AGHT+IEm/ParAiCN54ez1970jPWefA5VdlEPNN417j613Rj0hovapLVapcRYbA0lDsOD9TSgceh57CoMG4qtOk+/0rk=
X-Received: by 2002:a05:6122:3703:b0:51f:3eee:89f2 with SMTP id
 71dfb90a1353d-5244612c257mr2180745e0c.2.1741890111066; Thu, 13 Mar 2025
 11:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f5d8b82d-c711-4611-b257-b4297f172bb1@gmx.de> <637B90F3-58C6-43B6-9822-5314C62138C6@gmail.com>
 <eaeaef7a-570e-4738-a420-4d5f61adf0bf@gmx.de>
In-Reply-To: <eaeaef7a-570e-4738-a420-4d5f61adf0bf@gmx.de>
From: Rayan Margham <rayanmargham4@gmail.com>
Date: Thu, 13 Mar 2025 18:21:37 +0000
X-Gm-Features: AQ5f1JowL-n001-0hx5K-AlM8Jv-vjUEka4UA5suUJiIQcGpEqBKiNka1t7I6ls
Message-ID: <CACzB==4QC+khEpw99ekp-DK=jzMebroCw5PeXmgS9GsHmPYfSw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] platform/x86: acer-wmi: Add fan control support
To: Armin Wolf <W_Armin@gmx.de>
Cc: jlee@suse.com, basak.sb2006@gmail.com, kuurtb@gmail.com, 
	hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Could i have the deb package, I can try to install it.

On Tue, Mar 11, 2025 at 9:53=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 09.03.25 um 13:51 schrieb Rayan Margham:
>
> > I=E2=80=99m so sorry I=E2=80=99ve been in a mental health unit for the =
past month, are you still working on the driver I would love to test anythi=
ng you provide me now
> >
> > Bestest regards
> > Rayan Margham
>
> Oh my, i wish you all the best for recovery.
>
> Can you compile the current -rc kernel with this patch series applied? If=
 no then i can give you a .deb package containing the kernel and the
> modified acer-wmi driver.
>
> Thanks,
> Armin Wolf
>
> >> On 5 Mar 2025, at 00:24, Armin Wolf <W_Armin@gmx.de> wrote:
> >>
> >> =EF=BB=BFAm 15.02.25 um 18:45 schrieb Armin Wolf:
> >>
> >>> This experimental patch series aims to add fan control support to the
> >>> acer-wmi driver. The patches are compile-tested only and need to be
> >>> tested on real hardware to verify that they actually work.
> >>>
> >>> I CCed two users who requested support for this feature. I would be
> >>> very happy if both of you could test those patches and report back.
> >>>
> >>> I am ready to help you both with compiling a custom linux kernel for
> >>> testing this series.
> >> Any updates from the two people with Acer hardware?
> >>
> >> Thanks,
> >> Armin Wolf
> >>
> >>> Changes since v2:
> >>> - remove duplicate include and replace hwmon_pwm_mode with
> >>>    hwmon_pwm_enable in second patch
> >>>
> >>> Armin Wolf (3):
> >>>    platform/x86: acer-wmi: Fix setting of fan behavior
> >>>    platform/x86: acer-wmi: Add fan control support
> >>>    platform/x86: acer-wmi: Enable fan control for PH16-72 and PT14-51
> >>>
> >>>   drivers/platform/x86/acer-wmi.c | 298 +++++++++++++++++++++++++++++=
---
> >>>   1 file changed, 273 insertions(+), 25 deletions(-)
> >>>
> >>> --
> >>> 2.39.5
> >>>
> >>>

