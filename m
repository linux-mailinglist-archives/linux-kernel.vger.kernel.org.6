Return-Path: <linux-kernel+bounces-438838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2659EA721
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 05:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BE07284449
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 04:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7408912AAE2;
	Tue, 10 Dec 2024 04:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BgfU6gTr"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74E8DF58
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 04:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733804188; cv=none; b=q6J1lUPomolWDGMMmkkz7/BLhP91A1fkhEDEqsJuULV4oK/hFh8nj0eEhU2ZyXbCvtuqbdKSQbikJUCdoup6s6lN67mJbgM5nSYJnmPIIXX6WaODcnCIfdd1/bkQCna5wI5juwxjRUpvhE6BKPf2ti2FrB5tjtI/sH+yW2+474Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733804188; c=relaxed/simple;
	bh=ZIY/w4m8Ra3CLU290svg1elEYBPkVlp9m+9/xmJTBo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fEBBqaWraKwiOp1tPFhvg4+eCvLa5Iz5elUwbMb8DCwHXkqcZhRKNKQfGBt5u3IcTafbOEswk0/T9ZeAgs3T+dmuWmajcbj78KwJ0KHxCrfxOZnsS8fNIZhWwM+386iUep9BSEIG6/n5/czbcyYbSnKac+jHQiTllYw14NsQ2tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BgfU6gTr; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5401bd6cdb4so2044057e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 20:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733804185; x=1734408985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVjyzJNZzUOHZ4xph7lTSEABYq06yQKkLnmVu5Ncc7M=;
        b=BgfU6gTrIfCzSbzUp6DKjQpyoKqvawqmRuRfE0lrUfRU2XaOqWxmSLh1WqBzcut/PR
         Vw5JQXFF6Cvv1pwIeJnVUYHuS8M8MpRljcWGWhjCjGQoj/LTwWB0kV0JPW2qRZQjZ7S3
         fJ4nyaZ2SjFKfgbrzI3/paZ5HTHUPOnypfY+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733804185; x=1734408985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVjyzJNZzUOHZ4xph7lTSEABYq06yQKkLnmVu5Ncc7M=;
        b=M9uBTHs7uMUt6xva+suLHJaMP1Oo86g4urSDmzX1hbr0VOekWSM3B00ZCG8TKwl0Y/
         Wuhi7X3KMO5JU+SRySBSPOXDrNBmaFEF3BpzPygr3+GrCo+kaUoa9d4U+FJC3mzRHCkX
         NnumPOuaTceSbKjIs13GdqZpz8+d2IFJDOCd9jdCGjmWVwO/oRoobY6Bs5VRqNT6xFyi
         ErDonsiTb1tw9sVsLGxK2aWBgk8+ALnihDMPmwIeD4Nq5ZpSK6bdWT7g0+/Yu07pWRJi
         +ZhcpknUiOa8za9qO6Os8F+211CGl14lYertnc4hVBdGCsWZecK6c5yme0OiBca8bTuF
         j3qA==
X-Forwarded-Encrypted: i=1; AJvYcCWu3IZwW8gOSL1JZNHeStg8sKIDegZbViKPlKlOQ54bPmKMj1mKeWd22Lggb6l3ADQGaIOPfMWthSxHs5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWnluLmDMNqHue+9vJUx/9iMzOsljEsF2AfiwWMmNMHG8o9kKm
	anRXlX0bgzh0xCgUFyRwfWjXfIYjTw7GrybZia0+oQ90oA+PlYOeIrfpUkaBEUADOIujqvb+MH+
	wkvcGaPHSvi3TgTX1QsPV2lPwr+zUpQKWSVfu
X-Gm-Gg: ASbGncsQuMv74hEXKzhw9402TSGHLt1qbdBve2aoCN40Gi2v/FTacuAm7E0DftVfsBc
	F9zZccSjm7lyt64No0m2kZOF6b1Kzn1OHz0CDlQWPrKTTQyr6R/oElifXCfpH8ng=
X-Google-Smtp-Source: AGHT+IFLm7BUs8MAU7wTXsZF4FUsJzFdNX0LJUGWf1hGpJQa8BMT4iC8QeVgWREJrgR+EdOW4ukZF7ZP90wiDT03Nq4=
X-Received: by 2002:a05:6512:6cc:b0:53e:391c:e96c with SMTP id
 2adb3069b0e04-540240b0ff8mr1052794e87.8.1733804184782; Mon, 09 Dec 2024
 20:16:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-mt8188-afe-fix-hang-disabled-apll1-clk-v1-1-07cdd7760834@collabora.com>
 <a10dbdf265194e77a69b6e40afa3df9636b3ab14.camel@mediatek.com>
 <a70a0521-985d-43a4-a1fa-36eb733d5ca9@collabora.com> <1d2ee55dde84bcab6f777525042c6789b9f2c1fc.camel@mediatek.com>
 <108d4187-26af-43f6-8b1e-0e48516524a4@notapiano>
In-Reply-To: <108d4187-26af-43f6-8b1e-0e48516524a4@notapiano>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 10 Dec 2024 12:16:13 +0800
Message-ID: <CAGXv+5Gi30-GSy_D+DHS_wz-A3F4qxuc7-6KpfBQ-iJwr3POtQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8188: Enable apll1 clock during reg rw
 to prevent hang
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: =?UTF-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>, 
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"broonie@kernel.org" <broonie@kernel.org>, "tiwai@suse.com" <tiwai@suse.com>, "perex@perex.cz" <perex@perex.cz>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kernel@collabora.com" <kernel@collabora.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 4:08=E2=80=AFAM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> On Fri, Dec 06, 2024 at 06:57:00AM +0000, Trevor Wu (=E5=90=B3=E6=96=87=
=E8=89=AF) wrote:
> > On Thu, 2024-12-05 at 13:51 +0100, AngeloGioacchino Del Regno wrote:
> > >
> > >
> > > Il 04/12/24 13:17, Trevor Wu (=E5=90=B3=E6=96=87=E8=89=AF) ha scritto=
:
> > > > On Tue, 2024-12-03 at 17:07 -0300, N=C3=ADcolas F. R. A. Prado wrot=
e:
> > > >
> > > > >
> > > > > Currently, booting the Genio 700 EVK board with the MT8188 sound
> > > > > platform driver configured as a module (CONFIG_SND_SOC_MT8188=3Dm=
)
> > > > > results
> > > > > in a system hang right when the HW registers for the audio
> > > > > controller
> > > > > are read:
> > > > >
> > > > >    mt8188-audio 10b10000.audio-controller: No cache defaults,
> > > > > reading
> > > > > back from HW
> > > > >
> > > > > The hang doesn't occur with the driver configured as builtin as
> > > > > then
> > > > > the
> > > > > unused clocks are still enabled.
> > > > >
> > > > > Enable the apll1 clock during register read/write to prevent the
> > > > > hang.
> > > > >
> > > > > Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.c=
om>
> > > > > ---
> > > > >   sound/soc/mediatek/mt8188/mt8188-afe-clk.c | 4 ++++
> > > > >   1 file changed, 4 insertions(+)
> > > > >
> > > > > diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-clk.c
> > > > > b/sound/soc/mediatek/mt8188/mt8188-afe-clk.c
> > > > > index
> > > > > e69c1bb2cb239596dee50b166c20192d5408be10..fb8cf286df3f02ac076528b
> > > > > 898f
> > > > > d0d7a708ec1ea 100644
> > > > > --- a/sound/soc/mediatek/mt8188/mt8188-afe-clk.c
> > > > > +++ b/sound/soc/mediatek/mt8188/mt8188-afe-clk.c
> > > > > @@ -587,6 +587,8 @@ int mt8188_afe_enable_reg_rw_clk(struct
> > > > > mtk_base_afe *afe)
> > > > >          mt8188_afe_enable_clk(afe, afe_priv-
> > > > > > clk[MT8188_CLK_AUD_A1SYS_HP]);
> > > > >
> > > > >          mt8188_afe_enable_clk(afe, afe_priv-
> > > > > > clk[MT8188_CLK_AUD_A1SYS]);
> > > > >
> > > > > +       mt8188_afe_enable_clk(afe, afe_priv-
> > > > > > clk[MT8188_CLK_APMIXED_APLL1]);
> > > > >
> > > > > +
> > > > >          return 0;
> > > > >   }
> > > >
> > > > Hi Nicolas,
> > > >
> > > > If I understand correctly, APLL1 should be the parent clock of
> > > > AUD_A1SYS_HP and AUD_A1SYS, so it should be enabled automatically
> > > > by
> > > > CCF.
> > > >
> > > > I'm not sure why you resolved the hang issue after enabling APLL1.
> > > > Could you share more details about the solution?
> > > >
> > >
> > > Hmm. Now I see what's happening here...
> > >
> > > Nicolas, Trevor,
> > >
> > > Possible parents for top_a1sys_hp are:
> > >   - clk26m
> > >   - apll1_d4
> > >
> > > ...what's happening here most probably is that after the clock gets
> > > disabled as
> > > unused, it gets parented to clk26m by default as that is parent index
> > > 0... and
> > > something else in AFE needs APLL1 to feed a clock to .. something ..
> > > to allow
> > > register access.
> > >
> > > Trevor, do you know why is this IP unaccessible when A1SYS is
> > > parented to clk26m?
> >
> > Hi Angelo,
> >
> > As far as I know, it should work even though the clock is parented to
> > clk26m.
> >
> > Unfortunately, I have no idea about why APLL1 enabling can resolve the
> > hang issue. I'm also curious about how Nicolas found the solution to
> > resolve the problem.
> >
> > From the description, it seems that the problem is related to register
> > r/w hang. If I remembered correctly, when the mtcmos of ADSP_INFRA is
> > ON, register r/w won't cause the cpu to hang. However, ADSP_INFRA has
> > been configured as ALWAYS_ON in the driver. I'm not sure if it doesn't
> > work correctly when the driver is configured as a module. Maybe Nicolas
> > can also check this.
>
> Indeed, as suggested by Angelo, adding
>
>   assigned-clocks =3D <&topckgen CLK_TOP_A1SYS_HP>;
>   assigned-clock-parents =3D <&topckgen CLK_TOP_APLL1_D4>;
>
> to the afe node also fixes this issue.
>
> In mt8188.dtsi, we currently have
>
>   afe: audio-controller@10b10000 {
>         ...
>         assigned-clocks =3D <&topckgen CLK_TOP_A1SYS_HP>;
>         assigned-clock-parents =3D  <&clk26m>;
>
> So the question is, do other MT8188 platforms need clk26m to be the paren=
t of
> a1sys_hp? Depending on that I can either update the parent on the common
> mt8188.dtsi or on the genio700-evk.dts, which is where I observed the iss=
ue. I
> don't have access to other mt8188 platforms. Trevor, do you know?
>
> As for how I identified this issue, I noticed that when booting with the
> platform driver as a module the system would hang, and that passing
> clk_ignore_unused avoided the issue. Then I selectively ignored some unus=
ed
> clocks until I narrowed down to ignoring unused only the apll1 clock, mea=
ning
> the apll1 clock needed to be left on during the platform driver probe for=
 the
> system to not hang.

I don't know. The AFE driver supposedly enables all clocks that are
required for register access on runtime PM resume using
mt8188_afe_enable_reg_rw_clk().

Maybe try enabling debug printk in sound/soc/mediatek/mt8188/mt8188-afe-clk=
.c
and see what that gives you? There are already debug messages around the
clk enable/disable calls.

Either there's a bug or incorrect description of the clock tree,
or the AFE device node is referencing the wrong clocks.


ChenYu

> Thanks,
> N=C3=ADcolas
>
> >
> > Thanks,
> > Trevor
> >
> > >
> > > That might give Nicolas a definitive hint about how to resolve this
> > > issue.
> > >
> > > Cheers,
> > > Angelo
> > >
> > > > Thanks,
> > > > Trevor
> > > >
> > > > >
> > > > > @@ -594,6 +596,8 @@ int mt8188_afe_disable_reg_rw_clk(struct
> > > > > mtk_base_afe *afe)
> > > > >   {
> > > > >          struct mt8188_afe_private *afe_priv =3D afe-
> > > > > >platform_priv;
> > > > >
> > > > > +       mt8188_afe_disable_clk(afe, afe_priv-
> > > > > > clk[MT8188_CLK_APMIXED_APLL1]);
> > > > >
> > > > > +
> > > > >          mt8188_afe_disable_clk(afe, afe_priv-
> > > > > > clk[MT8188_CLK_AUD_A1SYS]);
> > > > >
> > > > >          mt8188_afe_disable_clk(afe, afe_priv-
> > > > > > clk[MT8188_CLK_AUD_A1SYS_HP]);
> > > > >
> > > > >          mt8188_afe_disable_clk(afe, afe_priv-
> > > > > > clk[MT8188_CLK_AUD_AFE]);
> > > > >
> > > > > ---
> > > > > base-commit: b852e1e7a0389ed6168ef1d38eb0bad71a6b11e8
> > > > > change-id: 20241203-mt8188-afe-fix-hang-disabled-apll1-clk-
> > > > > b3c11782cbaf
> > > > >
> > > > > Best regards,
> > > > > --
> > > > > N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> > > > >
> > > > >
> > >
> > >
>

