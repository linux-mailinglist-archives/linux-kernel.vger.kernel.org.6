Return-Path: <linux-kernel+bounces-232881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2CC91AF6C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 21:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAB8EB23C4B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E03A19ADBC;
	Thu, 27 Jun 2024 19:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBE8Aixl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F29D43AA8;
	Thu, 27 Jun 2024 19:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719515172; cv=none; b=cg2alCgf53ibKDzelkGlp7YQPr+KEMp3VoR1MsuCwpRj8BqtQny5Zv9067CPLJ+uhd3xLRjoH1DsdFwEaMUIu09i9MKYZRGJereptF0KSeRi28LY0sGmvQmlTHMnPebiql6P3Dsbf7IkdyO4ZNeoiIJLawtyO5lE8ld6tm/+XBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719515172; c=relaxed/simple;
	bh=qYyuyZyLemINvciwUPmxD+lZf3PlWNhp2SzlF8nutXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQQeWIZeQtITT4Xx4K8Jo2bgh+kP9bAsRzzbxNU7oNXDNuxYz29IvimAaGhrflSUO3FSCRGWptNX+ex7PzR+q41tf2F1BsSJiafx+dHhc9J7xKOeV5XWxbvuQ+owruFYuzjSIc0QwNvdgeIOqHHmXl/zkJYef2jYoMUEk5E/7/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBE8Aixl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5EAC4AF09;
	Thu, 27 Jun 2024 19:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719515172;
	bh=qYyuyZyLemINvciwUPmxD+lZf3PlWNhp2SzlF8nutXY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XBE8AixloLd1iiARrLilV5u0wjswL07nDhMi9g1vb0sBxWovT4cJifI7ElW8qTWai
	 LJCD7d6eqmoE0vW47M0fO7YQS7MKz5LRNLujR+x+GPtP6N+TlGSzysbB2pGp4pcTBu
	 Ir7B9Yt3VsJ6tAdufKXYOQIES8XcQ2f7O1ZDAUsJee/nnQXUdlLiFSBpjR02v3q2Ow
	 vWMfQrVdgGuxAeyB/o8peffcpkXBD/SVkCfuH2DMct7yooJYcMxG+4orPSG0ZS65k8
	 aVukMpUAa9LTKM8m6UGRKdmnd4eShMPddzp2IfypQOPuevUhSjmyrUSUiPSLbFPe1i
	 t0hwGVxlHeFJQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52cdb0d816bso1877389e87.1;
        Thu, 27 Jun 2024 12:06:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWi5cS1Of0lx9Lqcg8ba5eHALXHaHM3uvwbDc7f3wl8YbxpMy2KhLOUWL/vXbAKTPENH3cnXCo3O2e5l4oODH8kd9mGPY2YDPLF8LYZIAY+3X+CyqAhYxzlWR8nZEewKaHhjVn+wNlkxw==
X-Gm-Message-State: AOJu0Yzy+n8BUAC7w64PDsBVbFdIZsyf64ndPNyyF1cTD1pEc6vZGXJ0
	zgzVagFHwflNwYE44RHERaVOC/9ZCnaXShPSiZg3G/sSSJvVMDFbNOueaVkxGQWnqTtFjWNO2ji
	eeyYOIc2golg+VdR17mgU76kC9w==
X-Google-Smtp-Source: AGHT+IGfP9KoRm8CMwkTM1fbQMTanmBRhRy4ZLQAosQsk4uhF1VRbF52kp+LpWwAH6YFqg7QjYtHTnnk8iS3F07Tudc=
X-Received: by 2002:a05:6512:3e26:b0:52b:c14e:3b5a with SMTP id
 2adb3069b0e04-52e703aef94mr955517e87.31.1719515170504; Thu, 27 Jun 2024
 12:06:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528191536.1444649-1-robh@kernel.org> <CACRpkdZznuUSAKZx-BLgt+smaTDt8fVtJ-xRzL_0u7uYMDGJog@mail.gmail.com>
In-Reply-To: <CACRpkdZznuUSAKZx-BLgt+smaTDt8fVtJ-xRzL_0u7uYMDGJog@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 27 Jun 2024 13:05:58 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKAXnu=CDsOAOoxF0sBnzMxaCDVUU4Z+2k8kseTMvc+eA@mail.gmail.com>
Message-ID: <CAL_JsqKAXnu=CDsOAOoxF0sBnzMxaCDVUU4Z+2k8kseTMvc+eA@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm: dts: arm: Drop redundant fixed-factor clocks
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 2:47=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> On Tue, May 28, 2024 at 9:15=E2=80=AFPM Rob Herring (Arm) <robh@kernel.or=
g> wrote:
>
> > There's not much reason to have multiple fixed-factor-clock instances
> > which are all the same factor and clock input. Drop the nodes, but keep
> > the labels to minimize the changes and keep some distinction of the
> > different clocks.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Someone going to pick this up?

Rob

