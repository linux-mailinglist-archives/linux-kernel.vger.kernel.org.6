Return-Path: <linux-kernel+bounces-343706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D63CE989E8C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14AB21C221BD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30D6188733;
	Mon, 30 Sep 2024 09:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mKrhpShz"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8372617F394
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 09:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688982; cv=none; b=mQJDcQiSCNwvkGAeW+pMPUjsLSVvUUuvCt8B0leCD7KxJTI2j/3iARnZwVHhnLUuN9MfAxF6+aoxov5J9NNPjj+Rl8ZTmGa3h2DPkMd2cNL0N67GHpxs5Mn6xR8mjSmzm658tVI7WaLPq75d2ZQPd3jAsP+6aw+0XcAPJibEPgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688982; c=relaxed/simple;
	bh=C9DBoAq2QB/xsAIS/96o45Og/YkTC8oROtndXUYPuLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dsg4G2gT/NvLFyDdTTk4sYH4i6+Ev+LngNhQmqQXrvZzV+zKwrr7IgsiMiAWqiz7TmirZy6bg83urzOgME8e4bs+wOxwqrC8PBNImj/XStOJBZHHkOn+HD6NC58S5A7ZfwBrzSvepYBM5vlEOSDCyWxo0n6cYRGmDY1omstxBFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mKrhpShz; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-84e9dda8266so946002241.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 02:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727688979; x=1728293779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RF8NQ8XlYpxXe/MHG9+i89q1ADBQEDPUKFvH45+J62A=;
        b=mKrhpShzTafopgK0zWYOigMrBr6Ul9NyzexRm6rb7YetLgn6DxXoOAxP3WHzluXWlf
         BbFJdcBFmLNwUvPfqlhIcEoE2bfGwuQGRz7U//3Szlw5w0AZp+IVaMTKLR2udJx0fu8k
         l3Xabg4e+T0WZjM4eeD00JAxyXjnSCPBf37dE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727688979; x=1728293779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RF8NQ8XlYpxXe/MHG9+i89q1ADBQEDPUKFvH45+J62A=;
        b=YFwu8Jvmf+KYDd1J8ailmfcgaRShhRqL3ImYrHw9dKPPLqomMSyFnUbn1rKrkt0y/n
         TrzmtoGmAl7QgEcECNz/NDvE4XIMghz4OARDG5uv67wG1WviXtBkhGVmjZaaJvrkgHnv
         gUaRW8s9KQJ94vga8InqT+atcItk+8TDbpOChLZYaOr98Bh6XlbcL7zGsh5y0ZRoJhS5
         uEoHXtbFSnBOHu6wEpcnUm8Bm5vSBSKSI3m8Z+qbqhRuq4ohewwAJsw6cVvfYmsHU3C8
         UDmWrqLcfSyevzyXzuQD2vGnKbX9r2tewlTGiyZbx91b3GeLSOXnar7wGDD3qStXCV32
         kohQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqBMD1U8TODG9+eqC/7QjjCB3CJNtwJNLap8UjsuDoFiHDkz5A5PmFCgDBpCEQoYtkENw3gxVBSbINNUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwO3g64WDWYfDh3D7H7jMQYEkaMcwcl+CwceyKzpwSTzyjtq81
	dq2sG2X0nOEt9RkkncLSUqsj/dT8Chw0E4DeS57Qrv0YjhshTS19pN4y+skQaCL0TQxzLWiKbCU
	=
X-Google-Smtp-Source: AGHT+IHLMhO8gzXlbgBTg/Lp4NuFyhgmioptpNWfGf+c1SRtJSTxe82uoVc8L0jD1AZFot7mwdnSJg==
X-Received: by 2002:a05:6102:3e93:b0:493:e582:70ce with SMTP id ada2fe7eead31-4a2d7f2bc8dmr6693968137.10.1727688978666;
        Mon, 30 Sep 2024 02:36:18 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-84eb221c28fsm996823241.24.2024.09.30.02.36.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 02:36:17 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-50792ed3ad9so531094e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 02:36:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVa5UC/rENzgdbtzJIagViLhOdLmhrOhH/GtKuDRxH/6F9kCRIBAEa7AbLnmBbmAJrIM2mFsuGxlrFY9Zc=@vger.kernel.org
X-Received: by 2002:a05:6122:2210:b0:4ec:f6f2:f1cd with SMTP id
 71dfb90a1353d-507818a201bmr5969368e0c.9.1727688976487; Mon, 30 Sep 2024
 02:36:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925110044.3678055-1-fshao@chromium.org> <20240925110044.3678055-6-fshao@chromium.org>
 <b3842173-7074-4bcb-80f4-1f6f8cb38a52@collabora.com> <CAC=S1nhs4EUR78HunNnz=Z-cG4GgAZ=7JFyJmj6he96Z=GuxOQ@mail.gmail.com>
In-Reply-To: <CAC=S1nhs4EUR78HunNnz=Z-cG4GgAZ=7JFyJmj6he96Z=GuxOQ@mail.gmail.com>
From: Fei Shao <fshao@chromium.org>
Date: Mon, 30 Sep 2024 17:35:38 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhAr2vMYUnhw973RuCe1JzefKdugp-Ls1HktZdsnDTEuQ@mail.gmail.com>
Message-ID: <CAC=S1nhAr2vMYUnhw973RuCe1JzefKdugp-Ls1HktZdsnDTEuQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] arm64: dts: mediatek: mt8188: Move vdec1 power domain
 under vdec0
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 6:42=E2=80=AFPM Fei Shao <fshao@chromium.org> wrote=
:
>
> On Thu, Sep 26, 2024 at 4:33=E2=80=AFPM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
> >
> > Il 25/09/24 12:57, Fei Shao ha scritto:
> > > There are two hardware IP blocks in MT8188 video decoder pipeline:
> > > vdec-lat and vdec-core, which are powered by vdec0 and vdec1 power
> > > domains respectively.
> > >
> > > We noticed that vdec-core needs to be powered down before vdec-lat
> > > during suspend to prevent failures. It's unclear if it's an intended
> > > hardware design or due to power isolation glitch. But in any case, we
> > > observed a power-off sequence here, and it can be considered as an
> > > indirect dependency implication between the vdec0 and vdec1 domains.
> > >
> > > Given that, update vdec1 as a sub-domain of vdec0 to enforce the
> > > sequence. Also, use more specific clock names for both power domains.
> > >
> >
> > As far as I know, yes, there is a sequence:
> >   - Cores (mtk-vcodec-core) gets suspended first
> >   - Then the LATs gets suspended (mtk-vcodec-lat)
> >   - Finally, the LAT SoC gets suspended (mtk-vcodec-lat-soc)
> >
> > ...but you checked that downstream, and your downstream misses the lat-=
soc HW
> > instance, and only has the lat one.
> >
> > Are you sure that this is not the reason why you're getting this issue?=
 :-)
> >
> > Otherwise, I feel like we must ask for some clarification from MediaTek=
, as
> > I'm mostly sure that the two cores are independent from each other (but=
 I
> > might, of course, be wrong!).
>
> Yes I think I should... this is actually based on a downstream patch of t=
heirs.
> My understanding is that LAT SoC is not always in the vdec pipeline
> for every MediaTek SoCs. Although the MT8188 and MT8195 have much in
> common, I have a vague impression that MT8188 doesn't have a LAT SoC
> HW, so the downstream video decoding works smoothly without describing
> that in DT... but still, I could be wrong, and things just happen to work=
.
>
> Anyway, I'll find someone on the MediaTek side for clarification. The
> datasheet I have doesn't seem to contain such information.
>

MediaTek confirmed that MT8188 doesn't have a LAT SoC block. Its vdec
pipeline is (mostly if not exactly) the same as MT8192 which is
composed of Core + LAT only.
Also, there *is* a hardware dependency between Core and LAT's power
domains in both MT8192 and MT8188.
And for reference, MT8192 DT described that dependency correctly. That
suggests how the power domain tree should be like in MT8188 DT.

I plan to send a v3 of this series to include more fixs I found last
week and exclude the invalid patch, and I'll refine the commit message
of this patch all together. I'll also update the bindings to document
the information above so people can reference that easier in the
future.

Regards,
Fei

