Return-Path: <linux-kernel+bounces-423117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806719DA313
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 408F52840A1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 07:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CD014D2B7;
	Wed, 27 Nov 2024 07:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cNYNnOow"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388501114
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 07:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732692476; cv=none; b=F5roHKM2sZlNzMIy9mMe15I12uj7xQi0SOdRYWw+EF88auBOKyuRynidhM9D29t7VdlBPj2jjJbCS12MuAT3s4c5WDmB6LvS903IloPhYtzxaaadTQek35kuFHmBMW2YIxPHJ5ZlwrV9V6KewmuxkSBezEZkEbDuqv/0MCzwm7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732692476; c=relaxed/simple;
	bh=KuWXTb4LcW8/bpSbKWNdmhYeKVa50JrbQlRXOqHDf6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+pH2Xh1nBCgvq+n34SCsX90N12w6cf2gPEdutM0OtaVUyni0OdK9RA33CAuBuzcM1fsiHVWc0Wfchrq+znEQYAQW/Bro9eiJ+Iy78PwdlDwbwpi/TX0xt8efqJUtLYn18oHbiw/s4WEXyMVzgytH6hzxTg2AC1Xz/vcxY+gGh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cNYNnOow; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53deefc2ceeso1669738e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 23:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732692473; x=1733297273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oZqeCiNDi+VUMlqaFu0Cj3Hfsp6EOFS1u82qR+tNuM=;
        b=cNYNnOowDOJFEhbDGWgSRTF0H7MmjBgwTQsPqzSpbLZakOEvUcuK7JJR3B71RHki8R
         fvhZ6asaa5YeTNnYvjVYKTv9VOkRn1lyymY7dMAINJemRiMnV+NTWKv26TSW5FeD3s/a
         alwa77XZc49lnJZqoMLu+NJQ4ztfZ/aBBwd5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732692473; x=1733297273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1oZqeCiNDi+VUMlqaFu0Cj3Hfsp6EOFS1u82qR+tNuM=;
        b=S0aEpDUWHB59idJHrDyp9xwhsFMA8UefehDc7XMII1Zmg+rXn2gVp+zGW3r7OSek5Z
         TS6GFPoQKB/4HbrjUq6fPsLc+UX/n3fVP32WrxfdZ/zEMMEvGdT9sW0k0l5xqkdDkrpv
         xS1G8MbGV5on7MpAgFysIQ8gxknV2tKaTMcPYZR7G/3Dja7IzJS5D2X3NS/1Uk+eOtbR
         6ArtpZLBydISbAMvkmU/6m1nrF02/FnB5cdgPC6hy9EoQQb+TesDegcXI8PO5bKsSfhC
         0059r+nWgxdW3W7qSj4Pb5PE+LzAjGrAwAqO+534BsVD/TQ9L7Mv7x3buswyskGEJe7Z
         BzFg==
X-Forwarded-Encrypted: i=1; AJvYcCVlNX4GefoZAoDHRNvdBI5E3bNMSJ3F5U37FfhurisTQD/Ex0Skt6FTZTCV0KCKD9yYbcIhkfyEqCntGEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPfs4l5t/6d/hiskMfbikNsZUyq57fVvZcVFRbh8fR01uHiN93
	/CdqLstn4liXsjMw0Xr/6tusvd1ETIGOhGQV85pgN0gjGXSSbBu+dKzh99wlv71SvYYjso34BaK
	PvscL
X-Gm-Gg: ASbGncsHncxF8Je8EXg1UzN+tGdV2pXcuUvWq6kM6gjiOsa2MwRgCRy+hPEibdIte9u
	eKF2Ojiw1PzEnI0XqBVDdrB9XVltqaE3KhlQCOc0669wheZ95OjzB5d9/ibsr1l5ffIhFb4jI7p
	H6a7kedJnVS1T8nzcx/hBTCOdN/44vADmiFQ6O2RX8L+UcVr06Udz9jVz88IlXPbuRt3rWQDtTC
	oGXnN0vWtoacUzgx1YUkoar1dOhMY2Qb6a2XhgDCEacEDWnWhag0ssUBq+kcZ0ml2J5wYAn6eI3
	+/s+h1QwLg+aJi5/
X-Google-Smtp-Source: AGHT+IHxeZzgDMekJzqLcQASRKP4Uka/i3cLbNfN6yNHDzALmfzh62+F7SVzaPkMd+mITlHh+ki1uQ==
X-Received: by 2002:a05:6512:3188:b0:53d:e615:7a2 with SMTP id 2adb3069b0e04-53df01171e0mr1197401e87.53.1732692473416;
        Tue, 26 Nov 2024 23:27:53 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fbafsm683896966b.120.2024.11.26.23.27.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 23:27:53 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cfc18d5259so4367a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 23:27:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUY/LerlV5NHzJWo78aHe6Hv4Dx8JoawdQyx0bYworEI3ZINUJ+T48UOzUmuqRb6bHcI43kWKb1c6T/mbI=@vger.kernel.org
X-Received: by 2002:aa7:d80b:0:b0:5d0:3ddd:c773 with SMTP id
 4fb4d7f45d1cf-5d0819b8bf8mr48974a12.4.1732692472728; Tue, 26 Nov 2024
 23:27:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125-mt8192-lvts-filtered-suspend-fix-v1-0-42e3c0528c6c@collabora.com>
 <20241125-mt8192-lvts-filtered-suspend-fix-v1-1-42e3c0528c6c@collabora.com>
 <CAHc4DNKmGA-MjTWdZhKygiaRwN7mHnMCf8UPUxH_V16uZifzFg@mail.gmail.com> <f38e4283-7133-4865-b4fe-eafb6bd30534@notapiano>
In-Reply-To: <f38e4283-7133-4865-b4fe-eafb6bd30534@notapiano>
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Wed, 27 Nov 2024 15:27:16 +0800
X-Gmail-Original-Message-ID: <CAHc4DN+S6mBy_VRTWEqp-uA13zUyadtqPoo+-WZTmwYHofpkcg@mail.gmail.com>
Message-ID: <CAHc4DN+S6mBy_VRTWEqp-uA13zUyadtqPoo+-WZTmwYHofpkcg@mail.gmail.com>
Subject: Re: [PATCH 1/5] thermal/drivers/mediatek/lvts: Disable monitor mode
 during suspend
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Hsin-Te Yuan <yuanhsinte@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Alexandre Mergnat <amergnat@baylibre.com>, Balsam CHIHI <bchihi@baylibre.com>, kernel@collabora.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Chen-Yu Tsai <wenst@chromium.org>, =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 9:37=E2=80=AFPM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> On Tue, Nov 26, 2024 at 04:00:42PM +0800, Hsin-Te Yuan wrote:
> > On Tue, Nov 26, 2024 at 5:21=E2=80=AFAM N=C3=ADcolas F. R. A. Prado
> > <nfraprado@collabora.com> wrote:
> > >
> > > When configured in filtered mode, the LVTS thermal controller will
> > > monitor the temperature from the sensors and trigger an interrupt onc=
e a
> > > thermal threshold is crossed.
> > >
> > > Currently this is true even during suspend and resume. The problem wi=
th
> > > that is that when enabling the internal clock of the LVTS controller =
in
> > > lvts_ctrl_set_enable() during resume, the temperature reading can gli=
tch
> > > and appear much higher than the real one, resulting in a spurious
> > > interrupt getting generated.
> > >
> > This sounds weird to me. On my end, the symptom is that the device
> > sometimes cannot suspend.
> > To be more precise, `echo mem > /sys/power/state` returns almost
> > immediately. I think the irq is more
> > likely to be triggered during suspension.
>
> Hi Hsin-Te,
>
> please also check the first paragraph of the cover letter, and patch 2, t=
hat
> should clarify it. But anyway, I can explain it here too:
>
> The issue you observed is caused by two things combined:
> * When returning from resume with filtered mode enabled, the sensor tempe=
rature
>   reading can glitch, appearing much higher. (fixed by this patch)
> * Since the Stage 3 threshold is enabled and configured to take the maxim=
um
>   reading from the sensors, it will be triggered by that glitch and bring=
 the
>   system into a state where it can no longer suspend, it will just resume=
 right
>   away. (fixed by patch 2)
>
> So currently, every so often, during resume both these things will happen=
, and
> any future suspend will resume right away. That's why this was never obse=
rved by
> me when testing a single suspend/resume. It only breaks on resume, and on=
ly
> affects future suspends, so you need to test multiple suspend/resumes on =
the
> same run to observe this issue.
>
> And also since both things are needed to cause this issue, if you apply o=
nly
> patch 1 or only patch 2, it will already fix the issue.
>
> Hope this clarifies it.
>
> Thanks,
> N=C3=ADcolas

Thanks for the explanation!

Regards,
Hsin-Te

