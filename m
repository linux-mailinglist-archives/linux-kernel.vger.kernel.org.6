Return-Path: <linux-kernel+bounces-377989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF039AC9A2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FC3E1C2158A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798881AB6F1;
	Wed, 23 Oct 2024 12:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WTuInVx1"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAFE1AAE3A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 12:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729685023; cv=none; b=E8kiGTdK6ukJxyNbUaND05pScWelusXXO2MDSkTEsCUbYs4OVKk5XvrBdseRL9mWuELQmeQXFSOohWd0NBHZ/TyqJeI+Gm1srK71oI19XDBucQKsk9z8oNdiiFh3s6Lx9vmombicAF6cn9b9sUBtUCjxswuHT+ybOEBpYe4BuhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729685023; c=relaxed/simple;
	bh=CLIQAIVa2hCi7kQiXV32J9M0ftgjDUpQH9PD9PYz8Yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vGGjSs29X1y3AjaObyndq/KPjk63XqAHtm4q7j5Idn/FAYU7DxvsL3i6ImHz9us6gbo9NsngjuAD17U1lDCY0zWumTtcwQnS1O/0VfEljSWa+gcXe+H/ctlnHkm8+5BryuR4hhFtGoGQlrGxUoi+DeqsTYoetEf9VQvseoO/JtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WTuInVx1; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-277e6002b7dso2472338fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 05:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729685021; x=1730289821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8ff/XPdu25+KctImXnG4HbCg/aVpT0E7wYLlC7DsHg=;
        b=WTuInVx1An+vT9r5Uk6ajnfc4agM/GgvY+QWNN050Qcv/14qGceweZl7I2hcUdjHLW
         7trwgONxjpqgllKZoWgEpNGukX0COxTu7fq5j7tmMtYPR5sDX5tpQhHyllfMzrontSB9
         cJzNmEjiWJnBlPL50vFb36E/ciwXTFI/dbrNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729685021; x=1730289821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8ff/XPdu25+KctImXnG4HbCg/aVpT0E7wYLlC7DsHg=;
        b=jFEsz9KIRFgkHk0JI9VNUMKRXa8zwY2OEsgaC80bD84BPuFjhwe9+TAYpEvGCWC9Zw
         6i7ClMxnOoSq+0GyVYza7HGywk1/pxge2HAH94I8iwQ8Z1mcpDuqslr1XMPRgqDM6GMN
         eB8Wt6AOZipG1mbpw/bzP5Ku8h3KKhjGH2gSKfrxtn+SvkyzAq9YrMHN7av+dADAdKpH
         asNg3osr1DA8+J03A2uisHkarcrTWsqtbLFM0tVSVR+eNpBEmeZPzFWtDZv0XBG2S1q3
         8zRnTj7Jv94Ba0Qlp1jwJ2JkRFKMEZUYTUmOnepD0UFSA8ZBKYL7EAud5Lnu96ITWbLC
         SQtQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+aqNMqLunPPt/bygiTPjFdPLizfc96BNJfJX1aVbv5da+4wN5IAwjCuuQAmpcM++h649A5APO8+ZcHIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNZo8ocZtN1PAR04RqntqOcL4jLQR1CfaI+r61aR7sz+AVb6RW
	UTQ+aJKNIe+C+YhSIuDtssxOPuLbPZCAeHl2Qp7FowkGlyQSYIupqMOhLma6tHoVHAfdB/ts72o
	=
X-Google-Smtp-Source: AGHT+IGRB0qVjMLFA7ByuvGASY23FFKeHiytVbFML8XLGFR2hwpg8GvUXKIG+emzzZxkaDSJPUEHeQ==
X-Received: by 2002:a05:6871:798e:b0:270:2abd:4772 with SMTP id 586e51a60fabf-28ccb9efd84mr2039434fac.45.1729685020434;
        Wed, 23 Oct 2024 05:03:40 -0700 (PDT)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com. [209.85.210.51])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-28c79204a3fsm2388192fac.8.2024.10.23.05.03.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 05:03:39 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7180bd5b79dso2260208a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 05:03:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW70H0V3gaD+lH3e7Gj45IFQP6gcjeluZLD1iZ74/V+N4WLrSxNN2VZRcEAEojWd3uhh+8K+tVt/hoZEd4=@vger.kernel.org
X-Received: by 2002:a05:6808:3190:b0:3e6:256a:31cb with SMTP id
 5614622812f47-3e6256a3200mr2294647b6e.7.1729685018925; Wed, 23 Oct 2024
 05:03:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023102059.512352-1-fshao@chromium.org> <9b12aaec-504c-4e3a-a606-240341d8e0d3@collabora.com>
In-Reply-To: <9b12aaec-504c-4e3a-a606-240341d8e0d3@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Wed, 23 Oct 2024 20:03:01 +0800
X-Gmail-Original-Message-ID: <CAC=S1niSXkCTLXeCv-0sQh4AQmv6eKm8OH_3yH=TeDoMVz72OA@mail.gmail.com>
Message-ID: <CAC=S1niSXkCTLXeCv-0sQh4AQmv6eKm8OH_3yH=TeDoMVz72OA@mail.gmail.com>
Subject: Re: [PATCH] soc: mediatek: mediatek-regulator-coupler: Fix comment
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 6:40=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 23/10/24 12:19, Fei Shao ha scritto:
> > Fix two minor issues in the comments.
> >
> > 1. We balance VSRAM voltage based on the target VGPU voltage, so the
> >     comment likely refers to VGPU.
>
> Function `mediatek_regulator_balance_voltage()` refers, as stated in the =
comment
> located at the top of its signature, to "GPU<->SRAM" voltages relationshi=
ps.
>
> So, we're taking into consideration only two regulators:
>                    VGPU and VSRAM
>
> The first comment says:
> "If we're asked to set a voltage (implicit: to VGPU) less than VSRAM min_=
uV[...]"
>
> ...so, I think that you've misunderstood what the comment says :-)

Let me make sure we're on the same page - VGPU never goes higher than
VSRAM (VGPU <=3D VSRAM), is that correct?

[ min VGPU, max VGPU ] ... spread ... [    min VSRAM  ,  max VSRAM    ]
 (min_uV)  (max_uV)                         (vsram_min_uV) (vsram_max_uV)

The longer comment is
"If we're asked to set a voltage less than VSRAM min_uV, set the
minimum allowed voltage on VSRAM, ..."
So VSRAM is the subject here I think? Because we "set voltage *on*
VSRAM" based on its own minimum allowed voltage? We never set either
VGPU min/max voltage to vsram_min_uV?
And it's attached to the line that decides vsram_target_min_uV, with
the maximum of (1) vsram_min_uV (i.e. minimum allowed VSRAM voltage)
or (2) min_uV + max_spread (min VGPU + spread)

That makes me believe VGPU is the correct candidate.
We manually configure VSRAM first (push the ceiling to higher), and
let the regulator core update VGPU afterwards.

In fact, IIUC, there should be other concerns here... it should be
"vsram_target_min_uV =3D max(vsram_min_uV, **max_uV** +
**min_spread**)", due to the same fact that VGPU <=3D VSRAM.

For max_uV, it's not causing any issues because min_uV =3D=3D max_uV since
there's only one consumer... I can update the code in v2 if you agree
with this.

For min_spread part, the reason is that VSRAM should be somewhat ahead
of VGPU, but not way too far, i.e. VGPU + min_spread <=3D VSRAM <=3D VGPU
+ max_spread.
This is required on MT8183 and MT8186 - the spread should be at
between 0.1V to 0.25V (VGPU + 0.1V <=3D VSRAM <=3D VGPU + 0.25V).
The problem is that we don't have a "regulator-coupled-min-spread"
property, so we use the -max-spread property for minimum spread... and
without considering the real maximum spread.
But this is probably not that terrible also, currently
vsram_target_max_uV never goes too far from VGPU.

>
> > 2. .attach_regulator() returns 0 on success and 1 if the regulator is
> >     not suitable. The context suggests a successful return value (0).
>
> The comment is on top of a "refuse" or "error" case - one that wants to r=
eturn 1
> and not zero.
>
> Besides, it clearly states:
> "The regulator core will keep walking through the list of couplers when a=
ny
>   .attach_regulator() callback returns 1"
>
> ...which is definitely true.

... I'm sorry, I guess I really need a dinner break - my brain
translated "when" as "until" so I read it the opposite way.
You and the original comment are both correct.

And I hope my first point still makes sense and it's not my brain
being lacking energy again...

Regards,
Fei



>
> drivers/regulator/core.c
> function `regulator_find_coupler()`:
>
>         list_for_each_entry_reverse(coupler, &regulator_coupler_list, lis=
t) {
>                 err =3D coupler->attach_regulator(coupler, rdev);
>                 [.....]
>                 if (err < 0)
>                         return ERR_PTR(err);
>
>                 if (err =3D=3D 1)
>                         continue;
>
>                 break;
>         }
>
> Is that clear now?
>
> Cheers,
> Angelo

