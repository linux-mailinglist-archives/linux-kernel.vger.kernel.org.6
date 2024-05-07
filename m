Return-Path: <linux-kernel+bounces-171831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6FA8BE939
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1ECB28FF47
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D60516F820;
	Tue,  7 May 2024 16:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T/1Xiq1a"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209CE16F299
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 16:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099540; cv=none; b=LoBQB8juFVccsEBvX2V/7isgaphXpw6hePRSZkJt0inE8VnPov5BQEJT4Qb83/UOiCIEZarA+HJK81mmfbcwRXOPLz4twWMzZP++CjvvcOv7vVDBMAigKlQ7a/kwBzCrtfeCUDVTk3XdLq89ktzmYRX95zdLC0yJdxMOTZX8+kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099540; c=relaxed/simple;
	bh=Ejd2J/LkdHnUAGoIdR+9zZ4NBny/4pYwcFVlGGF3+Y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jp6zSbHL837TUeqklGdU2v7majn1rtVcte+vJjDYWwTencb+HXWachcm+1n+U+t4fjmZVrZ656W76PCeMW7aNACTwpU7SP8++HEUzmtz2rjn5saBQkBij+8nK1n9DXtrY1zJvoG0nC/KN7DS3on6b6XiZ2bPJB6KS+k7d968e1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T/1Xiq1a; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79290021fc6so267559385a.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 09:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715099536; x=1715704336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFavUp82x9+EKSXtviTqGgqyKSS9fBB+WIBnwLG/9Gg=;
        b=T/1Xiq1a9fSEHfWh+dW3tl1/7Pbe2sFSPxhAFfnpmdl2u/Jfv8i72Ywcfi+YawtC8p
         KKRdthYgE/vBDnP0ZEQc+Nu9iYVcnSrqHACSQK8+UGDFzW5N+pqpqwxfHY2EbJG1EeQ4
         C9TjPwHABf9w2cWL76F/Fg0r42GdvT7nLmhRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715099536; x=1715704336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFavUp82x9+EKSXtviTqGgqyKSS9fBB+WIBnwLG/9Gg=;
        b=W+k1YM0GLlkgfZ5H7mYmyfgSS1tJHwxG2OREHDXsJMO3ug+YXd9OII4sL30yagCtij
         bD8ZPd9LiFJTuoyS2EegJi0u40hxhL/E9hOrYY28S7YNqye58d/xoOSij0XUpRwaDxdE
         Ra1O3IR2VzYc1YMwegT+AmqYLrGuU/Em0NO4Hrl1InOJYblWSaRmwCL+jqX9GHI7hJ9I
         By10ACj1Od12L9nPwdOUxlzc2Qk1awAF7wUP+/0EijCgti5rNXPAOFjfszEy5w0kndR/
         nKoB74FKP+dw/rIv/4VKicVfCw2LCzxegOpQXRUwRX/xnX6INUIcKjs9NS6RFC+6LIZo
         qMJA==
X-Forwarded-Encrypted: i=1; AJvYcCUIwLrZA9nSt8431N5xr5UUm1RislzF7CUzKLnqs8F5vMSnF3Skl2vLDC92slIcVoTHWa5lPbMvr6PAREw5iRBnewloXGhco//Ehhp9
X-Gm-Message-State: AOJu0Yy2ETNueMWJcEVzSYqnm44ls4cPqj5rUOSr0nPzwUhbgCCh8jMa
	2/woTNjV3IUP/l99AwygWVDr+6bGWJnVFHFvnzD+FxU7E7nf1ZnGChPNooh7U+Br7XxjzeFcga0
	=
X-Google-Smtp-Source: AGHT+IFz9NZbYWpXPai2yuHurL5Awo5zlN4m8gcP/2YS1F0eBou45PQdsq7RtA37lsjP4984zuPPiQ==
X-Received: by 2002:a05:620a:410a:b0:792:9403:2d84 with SMTP id af79cd13be357-792b2868e07mr20354685a.49.1715099535737;
        Tue, 07 May 2024 09:32:15 -0700 (PDT)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com. [209.85.160.169])
        by smtp.gmail.com with ESMTPSA id dy29-20020a05620a60dd00b0078ede19b680sm5033456qkb.75.2024.05.07.09.32.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 09:32:14 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-439b1c72676so610041cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 09:32:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNthe0BWQpqxTDWtPohvylHIFkumF5I1IQQjQjMWSIESxvE0M8kFktTYU3fvRiNpACBfFaOl9ewG5TypjveZZ+l+gEDKcGkf99bnwo
X-Received: by 2002:a05:622a:598a:b0:43a:c1cd:2f4c with SMTP id
 d75a77b69052e-43d9835c8a0mr2999981cf.5.1715099534265; Tue, 07 May 2024
 09:32:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507135234.1356855-1-yangcong5@huaqin.corp-partner.google.com>
 <20240507135234.1356855-2-yangcong5@huaqin.corp-partner.google.com> <171509488827.493449.2668049686067198439.robh@kernel.org>
In-Reply-To: <171509488827.493449.2668049686067198439.robh@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 7 May 2024 09:32:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VNNB=jtyM1BMTUTzyTjOUqDxobWTYz9RAnCmYha-DG0w@mail.gmail.com>
Message-ID: <CAD=FV=VNNB=jtyM1BMTUTzyTjOUqDxobWTYz9RAnCmYha-DG0w@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] dt-bindings: display: panel: Add himax hx83102
 panel bindings
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linus.walleij@linaro.org, 
	xuxinxiong@huaqin.corp-partner.google.com, airlied@gmail.com, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	devicetree@vger.kernel.org, conor+dt@kernel.org, daniel@ffwll.ch, 
	neil.armstrong@linaro.org, "Rob Herring (Arm)" <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 7, 2024 at 8:14=E2=80=AFAM Rob Herring (Arm) <robh@kernel.org> =
wrote:
>
>
> On Tue, 07 May 2024 21:52:28 +0800, Cong Yang wrote:
> > In V1, discussed with Doug and Linus [1], we need break out as separate
> > driver for the himax83102-j02 controller. Beacuse "starry,himax83102-j0=
2"
> > and in this series "BOE nv110wum-l60" "IVO t109nw41" panels use same
> > controller, they have some common CMDS. So add new documentation for
> > this panels.
> >
> > For himax83102-j02 controller, no need 3v3 supply, so remove it.
> >
> > [1]: https://lore.kernel.org/all/CACRpkdbzYZAS0=3DzBQJUC4CB2wj4s1h6n6aS=
AZQvdMV95r3zRUw@mail.gmail.com
> >
> > Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> > ---
> > Chage since V4:
> >
> > - Update commit message and add fallback compatible.
> >
> > V3: https://lore.kernel.org/all/20240424023010.2099949-2-yangcong5@huaq=
in.corp-partner.google.com
> >
> > Chage since V3:
> >
> > - Update commit message.
> >
> > V2: https://lore.kernel.org/all/20240422090310.3311429-2-yangcong5@huaq=
in.corp-partner.google.com
> >
> > ---
> >  .../display/panel/boe,tv101wum-nl6.yaml       |  2 -
> >  .../bindings/display/panel/himax,hx83102.yaml | 73 +++++++++++++++++++
> >  2 files changed, 73 insertions(+), 2 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/display/panel/him=
ax,hx83102.yaml
> >
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/d=
isplay/panel/himax,hx83102.example.dtb: panel@0: compatible:0: 'starry,hima=
x83102-j02, himax,hx83102' does not match '^[a-zA-Z0-9][a-zA-Z0-9,+\\-._/]+=
$'
>         from schema $id: http://devicetree.org/schemas/dt-core.yaml#
> Documentation/devicetree/bindings/display/panel/himax,hx83102.example.dtb=
: /example-0/dsi/panel@0: failed to match any schema with compatible: ['sta=
rry,himax83102-j02, himax,hx83102']
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202405=
07135234.1356855-2-yangcong5@huaqin.corp-partner.google.com
>
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your sch=
ema.

I think several of your bindings patches have triggered Rob's bot.
Please make sure you're set up to test this yourself and make sure you
run it locally before sending out the next version of your patches. In
general you should get in the habit of running 'make dt_binding_check'
locally before you post any bindings changes.

Thanks!

-Doug

