Return-Path: <linux-kernel+bounces-312791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A06D5969B5C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3F1C1C237F3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7FB1885B5;
	Tue,  3 Sep 2024 11:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpdMmhym"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA5A17DFF5;
	Tue,  3 Sep 2024 11:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725362138; cv=none; b=SD8EzJiiuzoGnOv3OYDVwMgh8MqG0l0vITVzbRbiW536J7fL6bvyVebsDjPuwe27Kqxjg+89IuZSSyyeFzoPzGOVi/9I7G+Xpz1nkWBUstvBv54HzPeqa90GJkqDXEndoh/WsoIZFJvfDogjZLrSl2G/xscbSGWdHlOdAs2oOuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725362138; c=relaxed/simple;
	bh=BqJPlt44MeNTjunDONHtThoDBK8zbPy2hRTgHU608OI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ooci2dV7SIPk2q8XAEoiPiwCKO9hxwNIPlGOn/V2WhhuBU7Di23oxtYNZQKtTnH4oeXRnCtyKNmAw4V4cGe275YgmyiYkn7XDcaab6JL6BKya591S4FLScFBn8Cqxi2KaK70VsWlzJX8arOGD9TiGScJgQHADldJELTFZzvWvzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpdMmhym; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f401b2347dso45632261fa.1;
        Tue, 03 Sep 2024 04:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725362135; x=1725966935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqJPlt44MeNTjunDONHtThoDBK8zbPy2hRTgHU608OI=;
        b=OpdMmhymucEbWBtoidDmKeyVWYSwaefczkvpshg1kIc/qz3iCve1ODkXRp2+fZx0zZ
         r62fe/ujGWTrHx6qXfSPPtnrLKcGTUOP5sHkT4WK1x/yGyIwrhuq0X5KUKJcTyV43c9A
         PTHsdUdf9GsGp8lfioNgudiJRl2SgBtzFzDjADJGYOAJFoVU/NxKgF205xnWfCTBRkr9
         xVGIoD8D85OfPSUHkA+C4BvPT34kV9V0LISp60gxWxO2VgzFF3VhV5b+D7EKOTJIxTHn
         r0byaG1vfVA4ppMC+WvPzFLSXReFNdErovIi/dRC7chZs3pisHcCxA3gRB1hL9Aw/PYv
         P0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725362135; x=1725966935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqJPlt44MeNTjunDONHtThoDBK8zbPy2hRTgHU608OI=;
        b=emccr+g2V8KUQ+cZsNWlbEPYqOx0IZA3ipPqtcwTWCkiaUtPSAgycL9FO7xNmEW31m
         FM1Z3MWbG+4c0nR6/3QRlTBRDPNXW+i/UOnqJCge5l59k+gL/pZiS2FkTTKoacBAeqcb
         /dhazmuMOVwW6D9uN8X000qHItF/JUURbCvh8rTBzROR1HJrLD+R4ug0jaPMEs2SHxjs
         f7FKU0kxE9nXfTLpVPxKU9z3ofKElV+sZgbsIoMqZCddFIgi2D+mlJ7BW9kbCcHQ17Rg
         20aDl35dwGWfm5ABA+lZfq0mQPTHxZCDhLJ/ZXXXrVXmovYQjZ2Q8djCiooyd/vgGKSi
         DbEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsAV85MZNuiox9rsicw8Fc//DTAEZSfN2xszzsQ3kRTrtMGZ4gIHeX8TBK+c7QYieopklx6JbbCMK1ITke@vger.kernel.org, AJvYcCVZEWiNw+N3OkuIBSdZQL97SRd6v+8IUgu4wHSEpMW1TvWKLcaZTuksakxXs+zu0K0m/AKygmDTEAj6@vger.kernel.org
X-Gm-Message-State: AOJu0YyhdHMLZ4LAcA9otB0YapANlLTCF660YSpBefbHQkZ4kkBqvzDh
	+z12NcVBU4rIEi50bQvrLAc7zCNdPIou6m49+F2TfgwipsWhRQvVAkVnHEiYZFDXA/CbIw8SLxv
	06NGwruB5WiL7Gh0fnpK110O1wBs=
X-Google-Smtp-Source: AGHT+IE8SjM0Ms3di5cXWgcpB7iUkzE4YJxI+Ckuk4QQ044JC4VZuODzzCPoUd7IBUnkokoQYv1d6k7FzBjdigKSPYc=
X-Received: by 2002:a05:651c:19a2:b0:2ef:2e5d:3710 with SMTP id
 38308e7fff4ca-2f61299bd88mr59721361fa.3.1725362134721; Tue, 03 Sep 2024
 04:15:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903093911.3235306-1-carlos.song@nxp.com>
In-Reply-To: <20240903093911.3235306-1-carlos.song@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 3 Sep 2024 08:15:23 -0300
Message-ID: <CAOMZO5C_dpYGYvc=KE7ackdJH2RfhrHP6_Z=cxM=9X+hX5W8Jg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx93-11x11-evk: remove redundant "sleep"
 pinctrl in lpi2c2 node
To: Carlos Song <carlos.song@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	frank.li@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Carlos,

On Tue, Sep 3, 2024 at 6:30=E2=80=AFAM Carlos Song <carlos.song@nxp.com> wr=
ote:
>
> In lpi2c2 node, default pinctrl and sleep pinctrl have the same value.
> So "sleep" pinctrl is redundant and remove it.
>
> Signed-off-by: Carlos Song <carlos.song@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

