Return-Path: <linux-kernel+bounces-390258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4A89B7799
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96659B23322
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8731E197A6C;
	Thu, 31 Oct 2024 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ke17hcOn"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0320194C8F
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730367274; cv=none; b=qu8pXaX61NJlHnhgxaJ16nn7ksQNkyegAaSiUjrUaMugFW8MkUtivzvWhHJp6yr30Y6v5wg8wdxqhduMdruXRvi//PGhyBseic1SDT/8SZjnuVvnS4laCeNvRup3+eN8OnyEzqamdhe5Kh3jl+m4bRlVBF/iqAFWfaO2a5yMllU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730367274; c=relaxed/simple;
	bh=InN1xFa4g9RMlT4oK3tOjutPsAyzphU02LuhXMsZALM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ioHdsQFNQBopD8YL0YZlNT2Fk8KaDILuwo2MARrCx3lhf83/ry7YLiDIh4b/ItbrgntgWshi4zE47duIKNDoBoIVESMwmGzT1Fm9qsHrA0hHdAAMDwjntuw9RA0w5pVEO4m5vXRJOgQKKavYjKPCq6Te9Mod+ZXpGcaBjD3NACg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ke17hcOn; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539e4b7409fso717485e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 02:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730367270; x=1730972070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InN1xFa4g9RMlT4oK3tOjutPsAyzphU02LuhXMsZALM=;
        b=Ke17hcOnDzJiqjA9Uny7rwHvWTv8vj/X5J/DQSrtPlwqWJaWdjWjTm8rnSsfHd9iTV
         sGn5HhFJmjp2fXjWm4r8dWOkJ/Eb2HhKYE9JeGkGSZSdTnDJaJ6hVA6mB4KdeQ3BnHr2
         3kz031oqrT/PvXLwdS1IT4aZMz3By3hNLQiVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730367270; x=1730972070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=InN1xFa4g9RMlT4oK3tOjutPsAyzphU02LuhXMsZALM=;
        b=FnZsGoKil2Jt1z86I0exGEZ9NEDoVmHIKtnvTWj4u8nVS8/xzALuOTTov/dpJ492E7
         gEo15rEGwXujCNGaqLr/jka4Zl4xBCg8qccC6JCZ86azSbH1YFjokZ2saVxKg7KefSDu
         55MlhCGoTwNFC3aQDr9rgXL4tgdRQpEA16qlOHK3HjU1zOQJ8IHB7pAkboADLtIqJiU/
         PursyKFgDDt+lJihmWMwMa9gHX85gxdhobKEVTlITBKK7MRC1nnn0dwPwUT+V7a7rUrb
         So5+GA+/euEt9Mjg/IxfOu96lnaEJ1BqBPbidwS85X7mq9dedrvhr6NL5yhchahbLCJa
         Yw2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVnbVeMhcELis+R9d6jKlCnjUQCotKRtQutwKaJ45g5m6c926OZezBZ1CYXxjDAIDkB2HJuyz2nrxXvl3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBrG6d+U54nmRjWw5HjY9axjIn2K5oRPtpghvFFsiaim+PWVmY
	j/H+tcGu0FoJU5TgV+7aI/exjZ31wH7VCs0p7xMHcjCL9d0CR5BOAqEqKpMmn/XHNi4+17Zsqoz
	gYilXLmMgxn2Nc+QNvbFf/fVrEl5oTKHYETib
X-Google-Smtp-Source: AGHT+IHX8IaTSony3Ug7y1qw915U2fjctGRizSyZJqMGGKqXUXcFSb5o6pqwOsBeJtryiF2PWRQTbhcS2j/8glKC0bU=
X-Received: by 2002:a05:6512:3d10:b0:539:fd75:2b6c with SMTP id
 2adb3069b0e04-53c7bc369b8mr554550e87.21.1730367269718; Thu, 31 Oct 2024
 02:34:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029111309.737263-1-wenst@chromium.org> <d9177ba80fc78b1f74dc54260c0c43440ec5a804.camel@mediatek.com>
 <20241030-hot-peridot-falcon-57bdbb@houat> <0cfba5bdc9443fb4b9719c47ee93c2a467cc66bd.camel@mediatek.com>
 <CAGXv+5EWyGGKYo+NNQ3Ykd3QUUO2cOManSnhZQaVhhCnupNx=Q@mail.gmail.com> <20241031-turkey-of-astonishing-reputation-d1de20@houat>
In-Reply-To: <20241031-turkey-of-astonishing-reputation-d1de20@houat>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 31 Oct 2024 17:34:18 +0800
Message-ID: <CAGXv+5HkxbjTH6oidYMYo9vQafev2S+a-+Yrs=+TNqs9sSUtZg@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Drop dependency on ARM
To: "mripard@kernel.org" <mripard@kernel.org>
Cc: =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>, 
	"simona@ffwll.ch" <simona@ffwll.ch>, 
	"ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>, 
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, "airlied@gmail.com" <airlied@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 5:30=E2=80=AFPM mripard@kernel.org <mripard@kernel.=
org> wrote:
>
> On Wed, Oct 30, 2024 at 04:52:17PM +0800, Chen-Yu Tsai wrote:
> > On Wed, Oct 30, 2024 at 4:48=E2=80=AFPM CK Hu (=E8=83=A1=E4=BF=8A=E5=85=
=89) <ck.hu@mediatek.com> wrote:
> > >
> > > On Wed, 2024-10-30 at 09:25 +0100, mripard@kernel.org wrote:
> > > > On Wed, Oct 30, 2024 at 03:30:34AM +0000, CK Hu (=E8=83=A1=E4=BF=8A=
=E5=85=89) wrote:
> > > > > Hi, Chen-yu:
> > > > >
> > > > > On Tue, 2024-10-29 at 19:13 +0800, Chen-Yu Tsai wrote:
> > > > > > External email : Please do not click links or open attachments =
until you have verified the sender or the content.
> > > > > >
> > > > > >
> > > > > > The recent attempt to make the MediaTek DRM driver build for no=
n-ARM
> > > > > > compile tests made the driver unbuildable for arm64 platforms. =
Since
> > > > > > this is used on both ARM and arm64 platforms, just drop the dep=
endency
> > > > > > on ARM.
> > > > >
> > > > > Reviewed-by: CK Hu <ck.hu@mediatek.com>
> > > > >
> > > > > I find this days ago, but I don't know there is someone who apply=
 it.
> > > > > Let this patch go through drm-misc tree which already has the bug=
 patch.
> > > >
> > > > If you are ok with this patch, why didn't you apply it yourself?
> > > >
> > > > I think that's very much the expectation, so it's probably took a w=
hile to merge.
> > >
> > > That's ok for me to apply it if drm-misc has no plan to apply it.
> >
> > I'm confused. The culprit patch is already in drm-misc. So this one has
> > to go in drm-misc as well.
> >
> > I can try to apply it to drm-misc myself, or have a colleague assist wi=
th
> > that. I'll let it sit for another day in case anyone has something to s=
ay
> > about it.
>
> Sorry, I was under the assumption that CK had drm-misc commit rights? It
> should go through drm-misc indeed.

CK has always maintained a separate tree on git.kernel.org, so I don't know
if drm-misc commit rights were ever granted?

ChenYu

