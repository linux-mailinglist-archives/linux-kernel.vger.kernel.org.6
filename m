Return-Path: <linux-kernel+bounces-262795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900E993CCD1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 04:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE588283120
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 02:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0934B210E4;
	Fri, 26 Jul 2024 02:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBn9ogBt"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30B114277;
	Fri, 26 Jul 2024 02:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721962761; cv=none; b=uGuLv+Sq04OUtB5gi9FuPdejPj611s0ZfUY9T2ArSF66B7oRpW7Q2rwMjH9gcSoDyjN0PHI2K5LPGFXizpRg69acy4ZitcLvyW2/JqO88VRXkIk6oJ11o/j6SGwlZz73d7O1VTc1X57IsepWnFebtZF8U1ZcGjUwXtQkWLxj7u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721962761; c=relaxed/simple;
	bh=mdaQrzs5F4H3PBQjrlBYekO99CiFB9rta+bNo1NLeuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nq0o25ZA/D00clsuyksuvgkSLMahkI6OgA+yYU8vfVcP4JdXn0wUDH93rR4be/dPG3F6g1WuWYyXzhtrNiaSOM4Nk5455POxwgJrGtf1UbemdZ5WNNu+OuY641NccntKtF8BtevY16HYafdfrHP43jF7HgxxKcnWj7KUIAqGu08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBn9ogBt; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-81f83b14d65so36739039f.1;
        Thu, 25 Jul 2024 19:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721962759; x=1722567559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAG6m8GVy4zQ4SaaDLkjqsZUfXchlgKCP4XydJj+zwM=;
        b=ZBn9ogBtjaciL6DKaSezEyzfj6Zx+2JoF2QBBsuUHsj6nTowHKWUMvPzKqk6VXh4oE
         jEYo7f7zf8EzoFw/sHJkFz0icNjL2myO6kz3OdITRKx9AaHDH919q5oLE5NlvCQmzOjN
         wIQZvoBKS/TtaBLE2Jo4gGGwgEnBBf4BfkHOlVZ8nwYNKThrIWYtXjFN5S91fmBSbppZ
         vSkOZb2UmrslizZfR5fojcoc25NAHO6LZSgKLsnmgwdFJyhugLMab24RCoL/hviw/XKZ
         RCdjWyYrjodEpGxnjLesXyD7RYeRy8uAzaWQ11hvLiY1T19QYVbBQehs0h1bc2DXxUJ/
         rGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721962759; x=1722567559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XAG6m8GVy4zQ4SaaDLkjqsZUfXchlgKCP4XydJj+zwM=;
        b=VoA8dBczyYo248jgZudCMNMfDeYYfmARwVPnpxmxvwer3JcM+zMlJoKn8T8KgRXlFz
         V+gi8tfsYn2NWMAUACcXFf/F5iTuKVZeAlOfHIbujUMKZDUJjxFZiyZ7kW23qnnxOjAV
         m68afBmfLGVSe1Y//v21iO6MXeRQTGioo5pq66J6Coj0a8GsPnFHuO1V23zOHiVkMlWf
         JLoGDrzIg7jK6/8/avS+/5yN/MPDyRofdC3Ya4GkFmPNGeSQe+E7dhwN4ZwaKErQXlEA
         jC/b66tBUuEx1pKF+3iFuZu+qSPUd8XMtDAAtIkoheqTpgGo2kVo6apIHbVG/Rj6rA40
         a9lw==
X-Forwarded-Encrypted: i=1; AJvYcCU9BRre/0XcHxbCC0XG7E9RK0Ba+0f0fPbj1jcymAKrUtBbd3tbMctf5ZOixjBk7iHr6IynRATz+J7TU63haP3cKfzziGbqaDTx7kYTUBgiKVr6pi13Aj1UUXj9Tc+UGvjEkBqyqnyvIw==
X-Gm-Message-State: AOJu0YxahJQZaL5ytU76HkAvVHYLsud5tWPKOTS49txgfNxq+I5SMeRH
	hX5Ivpmrfkcnx6oEN39LpoVpOuDmEb2wr9w25XvzN7MpLMyFakFUY6z6TZEMcl35vqs9wRz1B4X
	Li1OC4GRrIQvZxpAsjr1b5GAdJnrqaQ==
X-Google-Smtp-Source: AGHT+IGe38xa98LidgErrEd/jZiGTKI7e77Z4yBvenP47PnotqH6csARIouNzaqnIbVKeCTPTIxsxqeyNLwHbcDpq2Q=
X-Received: by 2002:a92:c543:0:b0:397:75a:39b9 with SMTP id
 e9e14a558f8ab-39a217f42abmr57961565ab.16.1721962759028; Thu, 25 Jul 2024
 19:59:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1721897948-6306-1-git-send-email-shengjiu.wang@nxp.com>
 <1721897948-6306-4-git-send-email-shengjiu.wang@nxp.com> <57020795-0b37-4640-967e-4fe3619d744a@linaro.org>
In-Reply-To: <57020795-0b37-4640-967e-4fe3619d744a@linaro.org>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 26 Jul 2024 10:59:08 +0800
Message-ID: <CAA+D8AO0ZZASJck+RDSy2TRjL_N+BBj5-TMfMXiOfpv=nX-S2g@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: imx93-11x11-evk: Add audio XCVR sound card
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-imx@nxp.com, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 7:33=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 25/07/2024 10:59, Shengjiu Wang wrote:
> > Add audio XCVR sound card, which supports SPDIF TX & RX only,
> > eARC RX, ARC RX are not supported.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  .../boot/dts/freescale/imx93-11x11-evk.dts    | 40 +++++++++++++++++++
> >  1 file changed, 40 insertions(+)
>
>
> >  };
> >
> >  &adc1 {
> > @@ -469,6 +482,19 @@ &wdog3 {
> >       status =3D "okay";
> >  };
> >
> > +&xcvr {
> > +     #sound-dai-cells =3D <0>;
>
> Why this is not a property of the SoC? This applies to other patches as
> well.

I think you mean it need to move to imx93.dtsi.
Ok, will do it.

best regards
Shengjiu Wang
>
> Best regards,
> Krzysztof
>

