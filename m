Return-Path: <linux-kernel+bounces-318580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF1696F01D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21A51F28A61
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC351C9DC6;
	Fri,  6 Sep 2024 09:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="avtsywgy"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7788D1C9DDD
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725615955; cv=none; b=hsnLhjItX3Lif7uvuZSsWtdzJjY84JvHZ7Y0kisZjqDzbkawLf8T6EK+VF8Qo2C9roo7Hlm4edTtQWAW1ptpX8OIsSzje3QEpMVNI8X8jcWlUWQWabEI1M+5rgWsKcBV+tyR8hadz4X9tj7hH86s26+rnicFfUic5mU2SCNzb0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725615955; c=relaxed/simple;
	bh=KBFebti0FIgDlSx2JO6w+aS1No738Y2VI11+ki7iz8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XGoteErSniqLsSiASrq7LIX0RKny/no/HmsCbJG8hg95qh6Es+qZh9adO5hiB5FdkyEF5l2em6iv0UndkhESFjxieda05VynKyEwiXSBVfa/9Yx1FllAJdYLBF47KFa8XDTqv3lpPmigX/HoZqZiqJDm0A5fB1dEcgwg7NsKNSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=avtsywgy; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53659867cbdso638310e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 02:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725615951; x=1726220751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9N96X4Y3WZRv8HzIJuhI+PB4v4ZA+Pmo5p2uVjRPw4g=;
        b=avtsywgyDUx6TNEOQPiyvP3eHdgbbsDE12Jc3q60CJSc8rH4wehVDm6CJCAOZhqDEy
         1No2zQp58mnwdNrkRUT9AbmG94cFBxZ2GD8XXL9EvXnNUXLOs9pWl+8wTaDCcj5RC02I
         gYaROz4NrbzBObN44kHDhm0XqpTG+ASoeHYhJaW/iEbKSglcHB6cZyJ8/0Ry5Mjm0jtE
         tbnE8tgEHzbwHWHgUySfgFIpMmYVunYwVjZUbq7kvD56TKehufavYxm9/vXW4uz3SswI
         5KGDuYalsOOR/hCj1nGOPMuHX36NzZG+SucaWNpOGmbijF4337JNLtdiYkLLLmDbCwZZ
         wmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725615951; x=1726220751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9N96X4Y3WZRv8HzIJuhI+PB4v4ZA+Pmo5p2uVjRPw4g=;
        b=ZNvCU0/K8xBfpVAERCpU9dFnMNuaeCwr4WTieFNXLxBcDyMGLZIbeRgwF/Z57JO3Xh
         0MAFGH+MspRftHdyy4Pdzohof3R0naQexsjwf2iHxY8oFaJBvp5QscqHNHp1I9Bz7e8Z
         IXp8BpwqxC0sNwbHXUnghsrckvEGMMPUzMMT2Ijj88qohbR3pRci+iQG++o3LJpef9ns
         P6/bZ8Qn5O1wGq5s9q7/61lKWWBILYnZs4r5OmNaKgllRyjYyEEuZvlGSuXK9q/V+UTz
         bcgVXOG/uHQuenG4elHI9maW0O6TlPmeU+MjT4Er+ARVqXSvh4SzGGm/Uf5+hEXHLnb9
         4CfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYgVlEyJBNMYQOYIaHELlvcEHoOCQfDFDiHl+2zevt+gPLUTYoi2V1ijO5m2Th4W1FzIo9BdXyXW8z5f4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcQ0cTm6+4WOhS7plh4pEB/7iEWO46YBPagy47pPIjqGczp7cL
	7yjzvKb928g6O8nQmEaQ7vpd/gGHp1CEZ3fgf+uzLhRGmY95pUPr+YZqq46YY/4vOHaZcpf2tdv
	5vk6khBvszajeXhq5wCv9N5ha4pXatKRULPdCCA==
X-Google-Smtp-Source: AGHT+IGZOs2YQ/b6VBK+7ovrdW/UGc4y8hc8WH2631JZBGR1pTalNb6hX5PKOlyh8um1udj4MEJKOm/AfkJedCuLViA=
X-Received: by 2002:a05:6512:3d17:b0:52c:9877:71b7 with SMTP id
 2adb3069b0e04-53658818bf9mr1118897e87.59.1725615950424; Fri, 06 Sep 2024
 02:45:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905122023.47251-1-brgl@bgdev.pl> <20240905122023.47251-2-brgl@bgdev.pl>
 <6vikrqhdnkefzpahhhtz2hpi62jvcwnzclm7touwtnpxdzvgrf@uc7r6a7bbjek>
 <CAMRc=MeijX2by+MS_vq_OVx25JO6z=zNfymta35h11mbm=vmtQ@mail.gmail.com>
 <CALT56yOP+un5nkxuirJVg=gr7fo4Hqjt1ew3z-=F2J_Y_RcTqg@mail.gmail.com>
 <CAMRc=Mci-8R1Oe3Fe+1E+K-7khzwBPgn_8SQSUPXthpE4032Pw@mail.gmail.com>
 <d6d5a943-ab29-4034-b465-b62d9d1efa61@kernel.org> <87v7zagcyf.fsf@kernel.org>
 <ywn7bq6j6jgokwmm3vsumkuwijplezmery5tr6z5yeblnpyjh7@djkwdbt4sl3q>
 <CAMRc=Mfj3gpgV0N__oB8kF5pk4PrDwP1CqeUgUbvTwyo7p=7bQ@mail.gmail.com> <CAA8EJppi5Zy82=ZUZ67DW-40Qm7aMerNLu_Mzh3HiUBWqPiHVw@mail.gmail.com>
In-Reply-To: <CAA8EJppi5Zy82=ZUZ67DW-40Qm7aMerNLu_Mzh3HiUBWqPiHVw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 6 Sep 2024 11:45:39 +0200
Message-ID: <CAMRc=Mf--M9d-awzQcs=W8frBwNfkjyvyCrmHAc3MofQo-qp1Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] arm64: dts: qcom: sc8280xp-crd: model the PMU of
 the on-board wcn6855
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Kalle Valo <kvalo@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <dbaryshkov@gmail.com>, 
	Johan Hovold <johan@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, ath11k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 11:37=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Fri, 6 Sept 2024 at 10:45, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > On Thu, Sep 5, 2024 at 9:26=E2=80=AFPM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On Thu, Sep 05, 2024 at 09:41:44PM GMT, Kalle Valo wrote:
> > > > Konrad Dybcio <konradybcio@kernel.org> writes:
> > > >
> > > > > On 5.09.2024 3:00 PM, Bartosz Golaszewski wrote:
> > > > >> On Thu, Sep 5, 2024 at 2:56=E2=80=AFPM Dmitry Baryshkov <dbarysh=
kov@gmail.com> wrote:
> > > > >>>
> > > > >>>>>
> > > > >>>>> As you are going to post another revision, please also add
> > > > >>>>>
> > > > >>>>> qcom,ath11k-calibration-variant
> > > > >>>>>
> > > > >>>>
> > > > >>>> I had it in earlier revisions. The only one we could add here =
would be
> > > > >>>> the one from X13s as QCom has not yet released the data for th=
e CRD.
> > > > >>>> Johan and Konrad were against adding this here if it doesn't r=
efer to
> > > > >>>> the correct one so I dropped it.
> > > > >>>
> > > > >>> As Kalle usually merges data with some delay it's not infrequen=
t to
> > > > >>> have DTS which names calibration variant, but board-2.bin doesn=
't have
> > > > >>> corresponding data. The driver safely falls back to the data wi=
thout
> > > > >>> variant if it can find it. Als  usually it's us who supply the
> > > > >>> calibration name.
> > > > >>>
> > > > >>
> > > > >> Johan, Konrad,
> > > > >>
> > > > >> What do you think? Do we know the exact name and should I add it=
 or
> > > > >> should we wait until it's in board-2.bin?
> > > > >
> > > > > If we can agree on the string identifier with Kalle in advance, w=
e can
> > > > > add it even before the boardfile drops
> > > >
> > > > There have not been really any naming rules for the variant string,=
 it
> > > > just needs to be unique so that it doesn't conflict with other vari=
ant
> > > > strings. What have you been thinking?
> > >
> > > QC_8380_CRD (following DMI / Windows name) or QC_X1E80100_CRD (follow=
ing
> > > marketing name). Or maybe QTI_ instead of QC_. WDYT?
> > >
> >
> > Is there any central authority listing these names? Or are they just
> > agreed upon on the mailing list? I honestly don't know where they come
> > from.
>
> I think on ath12k these names come from ACPI tables. On all previous
> devices it is just being agreed upon. Kalle is the central authority.
>

Kalle: is "QC_8280XP_CRD" fine for you for a board called sc8280xp-crd?

Bart

