Return-Path: <linux-kernel+bounces-404448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BA19C43FE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ED85B2B287
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6924A1AB523;
	Mon, 11 Nov 2024 17:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7Az3cCg"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E2714D283;
	Mon, 11 Nov 2024 17:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731346568; cv=none; b=ic4umGTaJykGV6QTrk5NJVXVtBvEA2MC5F9cQf9OO/djDyy0lfyWCTZAK8rUaUZBxb7XdsS2zCVnu5tpfwrAmDftlvxLi7CmTRbZ2oLG1x0IzNCEfbTRFj41PkG0WpYtOVDvYtDpxj8FswSYd2Ek59E6r5ekxknq7ZwFEEa/3DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731346568; c=relaxed/simple;
	bh=DDma2PapfUFytkNcxJqct7OZPuMgn7Hx71HJK4FxWDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VpPfxG8XTc0ORcrCkHYSaF8V80fOocKy2u0sYI79+q9TJ7Xx4cXI/IB9Z6pdQ4XHbtIh0qkqfrOGa5w9FTxg5PYtgoYzKEB7q6VxXjq4M7Nr32GKR85NEE2N0sR//jyxGeNSUautg4zGgskQHiz5yuhAjMkh/69lSpCWFpHyMcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7Az3cCg; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53c73f01284so5796377e87.0;
        Mon, 11 Nov 2024 09:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731346565; x=1731951365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2c764UU6STgTT422edipNWYZyPutZdigq5PB4kq38AY=;
        b=Z7Az3cCgnMnD0O5rDWIzAjQhkdCWQ5+CyrShQ3SX40W0RSKqGLjj1S8fbTryYf5DJa
         okoMrOgSSKKD3msKun+t6lgIV5/a/barjzgjnS3HTSV9Env3yTyzrLkHoXFJw+tt4r9s
         HwZYES4NBcJojOtoEPpLAtyPU4xX+7UKG/frRbnlnYQgdnKH7MvcDK0JL+zLfpCSi3xw
         CbUYKLHQnCnDVPG4eWmooeHhEi9eBnq4fiZzYDNYJ0RV2VNVT5+hWWU7MjX+J/nOmlFX
         rCwI7JZJSoQmZwOh56ii8mX6uA8SkUmDMTlrLwJ4ZWMj2fTZDtJpS5k0E3XwbYLYbOJu
         ps3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731346565; x=1731951365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2c764UU6STgTT422edipNWYZyPutZdigq5PB4kq38AY=;
        b=uj4G7iXx3mm8aTLBaNPlQxI7WEN6Asw33aWKB4TyJRjncLQj+QsOukpbfHC0nkry0Q
         l2XOkly0CvikNirZCvrS/27V6A3O/maqFdaNKGl/3oiewwANrqmp1vkVUsUgjCwgvU9p
         RK547OHMGXJKA354tWY7+AR7WFWyEoe2O7WB91kDaGkldXoK/J4ym5TWE03NZBXuneJf
         547xcDBAgDbyifGegVzebqrtS3TlWfCxSxE2CygKnHLbCtdZAvVWVMBC8oFcpLOqKFqH
         k3+VBeHueN5lKBSkcQvGDOPLdNUMZoTXffNVF833FI+NJb8r+06j6JoOjrjbkMGSCUIZ
         FSow==
X-Forwarded-Encrypted: i=1; AJvYcCVLKX4trEaZNJ+5Ma0vXAsrqMPjfNFwli+zEfK9XlPDe3FWu+TBOVicNl4oI4d7FSspYuswjQ2wWLc=@vger.kernel.org, AJvYcCX4OjaT/DaBel0Bm88lip9lKfMs6eUbuZG9ZoEu0O3cTsSzjfFY+wwvnsM6Uwywi9/VVykfj2+Dho6Rq26P@vger.kernel.org
X-Gm-Message-State: AOJu0YxI/bO08ogoPZdtn2HqtrwGrpbg71ERtjPvMPUCGyo3puWS5Taj
	qPASLKDwwaH+e0iIn7wBIIyTI9CYRSpxiMcOFy+ObmeOOQYIE1iFQTjH0gq+CF4J7PjeYQgdm+P
	H2vYAvM7DWKX+mC8Pe183RZ5kKCU=
X-Google-Smtp-Source: AGHT+IHCnY0iWOiEpwLi7dbWSUyVq1CnYowY9AZWUWC7W8w0aC7/t+HPuJLgPG77+WPDuzI2A9PIPlQ31/RCnaaGtiU=
X-Received: by 2002:a2e:9549:0:b0:2fb:6465:3198 with SMTP id
 38308e7fff4ca-2ff201e6deamr59125901fa.5.1731346564935; Mon, 11 Nov 2024
 09:36:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106235217.94718-1-yesanishhere@gmail.com> <8dee409f-4b38-4168-9316-1fd15c97fc89@baylibre.com>
In-Reply-To: <8dee409f-4b38-4168-9316-1fd15c97fc89@baylibre.com>
From: anish kumar <yesanishhere@gmail.com>
Date: Mon, 11 Nov 2024 09:35:53 -0800
Message-ID: <CABCoZhBpqN1W=Rgw0z97nDAjgQpvPBoXz-m-S_4-KSSMDLnCDQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Documentation: devres: add missing mailbox helpers
To: David Lechner <dlechner@baylibre.com>
Cc: corbet@lwn.net, broonie@kernel.org, u.kleine-koenig@pengutronix.de, 
	Jonathan.Cameron@huawei.com, pstanner@redhat.com, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 8:58=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On 11/6/24 5:52 PM, anish kumar wrote:
> > mailbox api's were missing from the devres documentation.
> > This patch adds them.
>
> I've been wondering... Is it really that useful to have all
> of the devn_ functions listed in the documentation?
>
> My opinion is no, we can grep the source code for these if
> we want to find them and we should just delete these lists

Agreed.
> instead of spending effort trying to keep them up-to-date.
>
> Or if the consensus is yes it is useful, maybe we should
> add something in checkpatch to avoid missing these like
> we do for MAINTAINERS?

excellent idea, checkpatch can warn if a corresponding devm_*
variant is available and the patch is not utilizing it.
>
> >
> > Signed-off-by: anish kumar <yesanishhere@gmail.com>
> > ---
> >  Documentation/driver-api/driver-model/devres.rst | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documen=
tation/driver-api/driver-model/devres.rst
> > index 5f2ee8d717b1..8350a098f81f 100644
> > --- a/Documentation/driver-api/driver-model/devres.rst
> > +++ b/Documentation/driver-api/driver-model/devres.rst
> > @@ -346,6 +346,10 @@ LED
> >    devm_led_trigger_register()
> >    devm_of_led_get()
> >
> > +MAILBOX
> > +  devm_mbox_controller_register()
> > +  devm_mbox_controller_unregister()
> > +
> >  MDIO
> >    devm_mdiobus_alloc()
> >    devm_mdiobus_alloc_size()
>

