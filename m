Return-Path: <linux-kernel+bounces-403674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 207379C38E4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 08:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879CE282224
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 07:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58B8158538;
	Mon, 11 Nov 2024 07:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fGwG/Evv"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488C112CD96
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 07:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731309058; cv=none; b=Wj/453i53YYny8fVbFUYXNGru147gOyuJh5c4LYlEbLhkSH/A6lQN5+0iiXtETyrSbktHJ8TZ0893jqSoA7bq5+oyhvNLp9hR8/Kn3QRm0hYP9Q3Y8YnL5VIBzqyIH0rfE2C37D9znYgyPMVRFKoYM6wnxYcar0FZpInfgaKaeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731309058; c=relaxed/simple;
	bh=oLZPf5qFSOOfM8TF8PHZtrDXfeBOEOuWWRG3wr7DpJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZlEz40xFoSOPRFCDWHR3vag6+Qz3yZA8B39ke9yjtcSL05ilZor6i5VA06jL3ygAjgf7FJjzqXB4CCKGEkxbpb4tiwSjfowR5Ush50ZPc6P519pcDgOl2s3bG8JIFVnljc2ht5mRqGJwx2PStth4+raZ+hIguOmobk3FnIF/RUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fGwG/Evv; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-513de42687dso1722126e0c.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 23:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731309055; x=1731913855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRwmAWT8xPVKbim8r7BKJ41XClJL4X8nd2o/c/Tzn4w=;
        b=fGwG/EvvUhOI2DIl09yQAkp8cf48oDC946FVrygUy7JjDn8gAikvusdZmqHHlNOutR
         Ngr8Xfrwz4qUbsp5utyu9QP9rWkY+K2XfVmp1kSUmWnnztxU0caRxj7bA/r4CYSABS4j
         dgrZhXjvRd6sc58HklXW8Gz94h4UrooAIJgkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731309055; x=1731913855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tRwmAWT8xPVKbim8r7BKJ41XClJL4X8nd2o/c/Tzn4w=;
        b=dUO72/CYfKNAd9LxkNX9kBobGwcxi+1Mc9EOcLhv279F1vB+x0YISZhPLkCQHXzaHZ
         1DNQhLmUOjGPwjdMEwHCe1QybUkkvriQmtiwt4Ix2g4ZK5PxHIVZgwA6rVeJmW8PKGwz
         Mu7YEwCX9Hbz861tGKkMb6McYxSIq6HueCl0+6VwnHPVwvJRZuRI2U2Xl5/a+zhEvfIR
         S+2xOaH3E/h9ea35FL9msFzVJZr3kNHzf1cePugAVRXni3Usjhms7RLTZTIFlZTWzD0k
         wTrRGEk4cDPnc0vRlCJCrlaUQtWbrctwXvC1MtYVUSdXbvoBD4hOA+f9+aWYHrqxF13Q
         jbWA==
X-Forwarded-Encrypted: i=1; AJvYcCX8Y9Hs+xuW0JdRFy84cJx3XW4+K6ihElKGqrZ+1wYHWSnj46FmOjKgOeRcvDve1bUyA1zY4eWVx7gLzb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYRGvZvQ2OeE5T8csJLovDv8Xzw20Cjs9NPCWt5jAF6VwbAZgl
	gEo/a+1riV3NqFAYaWhozCi/6a9CV8WASvMtPaLDrDLNFK9Rv2m4s2XqNBBfiJ0OYD6XfwhGd7Y
	=
X-Google-Smtp-Source: AGHT+IFrXF94qujf49+SDy5D+eJcqSgv8Rb1GZKbpsTWQ/8y4mFMWw3G2KSw3TujzzJLxgihEtctfQ==
X-Received: by 2002:a05:6102:418f:b0:4a4:9416:6a18 with SMTP id ada2fe7eead31-4aae11b3653mr8756125137.0.1731309054954;
        Sun, 10 Nov 2024 23:10:54 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8565556159asm1702073241.8.2024.11.10.23.10.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 23:10:54 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-84fccf51df1so1587950241.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 23:10:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUyV3za0bB1mLVltpkksqVOVQJ4rHmEjNMtKOJS7Ie2Kaz0WNuvvFLQPTTKMexCjH8GJ0h5CmRho35MveU=@vger.kernel.org
X-Received: by 2002:a05:6102:440f:b0:4a4:9541:e384 with SMTP id
 ada2fe7eead31-4aae165882dmr10240215137.23.1731309053523; Sun, 10 Nov 2024
 23:10:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105093222.4055774-1-fshao@chromium.org> <20241105093222.4055774-3-fshao@chromium.org>
 <b66dbf9e-b35b-482c-9eb7-112ef1f398d6@collabora.com> <CAC=S1ngozo11g1vF2jnHjTLcNmP8tOMsQhK+LR0QWqoeXwSJjg@mail.gmail.com>
 <59f4bcc1-c752-4f2f-8e55-349cc2432b8a@collabora.com> <CAC=S1nhhfwHU5K5ZyUhZBhvz38LOZGLnGN-Rc1ZAup_VTfkpvA@mail.gmail.com>
In-Reply-To: <CAC=S1nhhfwHU5K5ZyUhZBhvz38LOZGLnGN-Rc1ZAup_VTfkpvA@mail.gmail.com>
From: Fei Shao <fshao@chromium.org>
Date: Mon, 11 Nov 2024 15:10:17 +0800
X-Gmail-Original-Message-ID: <CAC=S1nj5PVJ=zwZiBLoOCHzsspaRw9ddAH_dXfPayD=LyW5wNA@mail.gmail.com>
Message-ID: <CAC=S1nj5PVJ=zwZiBLoOCHzsspaRw9ddAH_dXfPayD=LyW5wNA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: Introduce MT8188 Geralt
 platform based Ciri
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 12:11=E2=80=AFPM Fei Shao <fshao@chromium.org> wrote=
:
>
> On Thu, Nov 7, 2024 at 6:37=E2=80=AFPM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
> >
> > Il 07/11/24 07:58, Fei Shao ha scritto:
> > > On Wed, Nov 6, 2024 at 9:19=E2=80=AFPM AngeloGioacchino Del Regno
> > > <angelogioacchino.delregno@collabora.com> wrote:
> > >>
> > >> Il 05/11/24 10:30, Fei Shao ha scritto:
> > >>> Introduce MT8188-based Chromebook Ciri, also known commercially as
> > >>> Lenovo Chromebook Duet (11", 9).
> > >>>
> > >>> Ciri is a detachable device based on the Geralt design, where Geral=
t is
> > >>> the codename for the MT8188 platform. Ciri offers 8 SKUs to accommo=
date
> > >>> different combinations of second-source components, including:
> > >>> - audio codecs (RT5682S and ES8326)
> > >>> - speaker amps (TAS2563 and MAX98390)
> > >>> - MIPI-DSI panels (BOE nv110wum-l60 and IVO t109nw41)
> > >>>
> > >>> Signed-off-by: Fei Shao <fshao@chromium.org>
> > >>> ---
[...]
> > >>> +&pmic {
> > >>> +     interrupts-extended =3D <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
> > >>> +};
> > >>> +
> > >>> +&scp {
> > >>
> > >> Is this SCP-dual or SCP?
> > >> I see SCP, but I also see a SCP-Dual memory region... what's going o=
n here?
> > >>
> > >> Of course, the SCP-Dual won't work if you don't override the compati=
ble string...
> > >
> > > To clarify, the second SCP core is used for MIPI camera in downstream=
,
> > > and I deliberately only describe the first SCP core here since the MT=
K
> > > camera ISP driver isn't in upstream at the moment.
> > > I had a fixup patch for removing the scp-dual reserved memory region,
> > > but likely it was missing during the rebase... let me check again if
> > > it can be removed, just in case there's firmware protecting the regio=
n
> > > and the kernel shouldn't access it.
> > >
> >
> > Hmm... but the second SCP core can still be brought up, even if the MIP=
I Camera
> > driver is not upstreamed yet, right?
>
> Well, that's true... and it should pave the way for validating the
> driver with the upstreamed DT whenever that becomes available.
>
> >
> > That shouldn't cause lockups and/or other kinds of bad behavior, and sh=
ould
> > bring up a core and just never use it, without any particular issues.
> >
> > If we can enable the secondary core, let's just go for it.. as that wil=
l help
> > specifying the exact memory layout of this board (and failing to do tha=
t may
> > create some other issues, that's why I'm proposing to enable that even =
if it
> > is not really used in this case).
> >
> > What do you think? :-)
> >
>
> Sure, that sounds good to me, too.
> I started only with the essential DT bits to ensure the device can
> boot, which it does, so I guess it's time to bring that back. I'll
> incorporate that in v3.
> I plan to fix up the single SCP core node to SCP-dual directly, so
> please let me know if you prefer seeing that as an individual patch on
> top (either option works for me).
>

In fact, I noticed that it seems to require modifying mt8188.dtsi (and
potentially mt8390-genio-700-evk.dts) to support the second SCP core,
but I want to avoid doing so in this series if possible to keep this
as a pure new .dts introduction (if that makes sense).

I can think of 3 options here:
1. I resend this series *with* the single SCP core enabled in
-geralt.dtsi. And then I send a follow-up series to introduce the
second SCP core and update the affected .dts{,i}.
2. I resend this series *without* any SCP cores in -geralt.dtsi. And
then I send a follow-up series to introduce both of the SCP cores at
once, and update the affected .dts{,i}.
3. I delete the parent (mt8188) scp declaration and re-describe the
dual-core SCP structure in -geralt.dtsi. This avoids touching
mt8188.dtsi and mt8390-genio-700-evk but leaves the dual-core SCP
stuff exclusively to geralt/ciri. I don't know if MT8390 wants to
utilize the second SCP core or not.

I guess (3) is less likely what we want down the line, but that's just
for reference. Any preference/suggestion?

Regards,
Fei

> Regards,
> Fei
>
[...]
> > Cheers,
> > Angelo
> >

