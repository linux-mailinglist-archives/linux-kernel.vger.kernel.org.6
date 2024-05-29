Return-Path: <linux-kernel+bounces-194285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B169F8D3980
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D44B51C225CC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066F315AAC6;
	Wed, 29 May 2024 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="BaIT6r0n"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9D715920F
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716993584; cv=none; b=bZEgggPDcNvsMkBEiybm0x1JtUR9omucAUXqD3U8rzuA2gt/FUY60oiSVciKSXvj0o1nE2JNB2fmkAxQNQ5O7f4iwSgpK7jRsg33YoVC4vvt4ISDEYPegFzOO6xEMhJWpkIhkRiUbL2IBJKNcj1KVTPWgXtJzkLgkInnMLU317U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716993584; c=relaxed/simple;
	bh=CYWIPjtAFfyJHn7MNTSA22LWGuuvpTO1d03GME6cg9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oCbj8BhoSleZKj9NR1UhxZlVkKPcGPcmCZ3zCIupmZ6VlXM6psdh7+Ug3E35XCQD80xgDlruMSaNOscud+F46JTXqcEwy8FncxsQpENx4z9/7ZNVtg0AIZywpCUUe4bf76E3RaewbpoH/jzriZI7T8RAH3ITPDxjt3eaoy1jxRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=BaIT6r0n; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e9819a6327so25565681fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 07:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1716993579; x=1717598379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUUeqx06PD9RnDkd7RHtSPB5pC0CFZUjyvWsXQJbRlo=;
        b=BaIT6r0nyxRajfpn612La/kkuWYgdNN5ZzORraJmZNTIO8OD8eOBMokq1BJkpBNRM0
         cY1ezjaWI8qoqw+z7VMumumGIbJvPU+0rNAFRbkxKtH1PXij0VC53L698++1aoLgchcL
         nYnGxkB73MegrKt3XO5dqAVUfBD8vfVGAmy4AkpjvbebkOO1l5gj+b+hyy3t//iQEaB+
         TOVT8+oIWV0CcV2xi1CKOAgFlrB+mI9pj8kQAUT2G01xdRHv0sKPyV9FTr6TUKxBjD1I
         TpNOj1eFWtBlUh+k0TO671pocn7MnMcIqoVU9TfNzEJbS5KP5VSyvfRhnIXWzz5dhI7Z
         PZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716993579; x=1717598379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUUeqx06PD9RnDkd7RHtSPB5pC0CFZUjyvWsXQJbRlo=;
        b=nn1ZYLt7QKUcR6RvVDQvBLofSEe45XE6Fl3IHbGM+tTYcoeeORWTaSr/F8lNkaAbs5
         ZrL/XCPUsv9LEZECVH1SH6VptPFf7Q3Ll9bPp0qTMM/y7hD+BcmX2qnQrqZdZmh8EoY0
         +eG3/oPkkZ/PwIvS/7lqnHribAs4uCWP1JZCblmF9zj+KNu/xQARhDTf/MMGHgvkJSm5
         4nHKQv8HHeESdF6BcSzsy8sZBtXRFJ376+axwcEYcu/0Yuv4xuuWg1APJcQWUkGbzb+k
         woZMyzjlBiis35pzE7qps/ClKXA8VCd8mVaHi9BaW3zORUy5iZpW3dUDP1DJPo4fRVkK
         +0mA==
X-Forwarded-Encrypted: i=1; AJvYcCWE8nVR6/OMAs3edw/R8+D0CUu9o9fTGUSPMERwNEc0HnuZyuiMisHDI+afuXV3c0H30s84fxqb755QdgiV4M6ya4C51yEt1koC3lLj
X-Gm-Message-State: AOJu0Yyi1UV05XJt9bBK1swWARDAGIVcevVL84qeswUgb0xjX1rJcgQf
	b/EOpHBsEwpmcYWzd+k536OA1hHxPJOIWBMTO/AR7rI5ywWYgcJ2Wd83mz5U9TAdJG723tJ/ZyD
	o97IPu8GliPzXMH3zFDvztXduDf2l60bmgtz8gh1BWOQu1sPu
X-Google-Smtp-Source: AGHT+IEjlZVDnQ24lkUWp0Sdko93n3669vjAybgG59+MWyamnsin29/ulOH8X8tip6Fh2q5pwCTpEwMYKKFP17ZfiIA=
X-Received: by 2002:a2e:9599:0:b0:2e9:5e2d:2e8c with SMTP id
 38308e7fff4ca-2e95e2d33acmr91830111fa.41.1716993579444; Wed, 29 May 2024
 07:39:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527-shm-bridge-v10-0-ce7afaa58d3a@linaro.org>
 <20240527-shm-bridge-v10-15-ce7afaa58d3a@linaro.org> <8f3f1e88-426d-4254-a31c-afcb88fc08f3@linaro.org>
In-Reply-To: <8f3f1e88-426d-4254-a31c-afcb88fc08f3@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 29 May 2024 16:39:28 +0200
Message-ID: <CAMRc=MdxP5MWPhbq6u8WHRpm04F0iijeTpG0q3D9q52e7xfcsw@mail.gmail.com>
Subject: Re: [PATCH v10 15/15] arm64: dts: qcom: sa8775p: add a dedicated
 memory carveout for TZ
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robert Marko <robimarko@gmail.com>, Das Srinagesh <quic_gurus@quicinc.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Elliot Berman <quic_eberman@quicinc.com>, Alex Elder <elder@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 4:26=E2=80=AFPM Konrad Dybcio <konrad.dybcio@linaro=
org> wrote:
>
> On 27.05.2024 2:55 PM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Add a 20MB reserved memory region for use by SCM calls.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dt=
s/qcom/sa8775p.dtsi
> > index 31de73594839..c183527452d7 100644
> > --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> > @@ -208,6 +208,7 @@ core3 {
> >       firmware {
> >               scm {
> >                       compatible =3D "qcom,scm-sa8775p", "qcom,scm";
> > +                     memory-region =3D <&tz_ffi_mem>;
> >               };
> >       };
> >
> > @@ -418,6 +419,12 @@ cdt_data_backup_mem: cdt-data-backup@91ba0000 {
> >                       no-map;
> >               };
> >
> > +             tz_ffi_mem: tz-ffi@91c00000 {
> > +                     compatible =3D "shared-dma-pool";
> > +                     reg =3D <0x0 0x91c00000 0x0 0x1400000>;
>
> How does that size relate to
>
> +       pool_config.max_size =3D SZ_256K;
>
> in patch 3?
>
> Konrad

Short answer: it doesn't.

Slightly less short answer: this is the limit of *this* specific TZMem
pool which in turn gets its memory from the shared DMA pool. We can
have multiple TZMem pools and they all share this DMA pool.

Bartosz

