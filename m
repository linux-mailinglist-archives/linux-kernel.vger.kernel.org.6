Return-Path: <linux-kernel+bounces-227462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC05591518F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3E0428ABBE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2800419E7EF;
	Mon, 24 Jun 2024 15:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FHQJBe4H"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B287219D083
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241778; cv=none; b=LYf/Mkpe+AIi4Wsw15e4eDYpNPJJyGHnW1gXctlooojLuAJUqLo0h/NTZPNactWpRtY2njYRpdu6KU69l+neLnxVPXn+209XMriW08RE3rkajZo54TL4wGFkteExyfvlXnd7pr7zxoqQxWAGNqj/unKzR1GevxPQYQJAM05gDMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241778; c=relaxed/simple;
	bh=Ibi8sYn7ylQL5y3VEu7Upgb5wJZ1JdA3xJL82aIZMfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CxO45oV1oP7F5JN/ork+hwFT9CVLQpA619hnQVpmhnfSjhSijo5U7GkPmkV+LoKC2AG7yPrupRIY6J/k7pPyHWZTbuSGtGIDCkSos+MuE6aJd2WrTA3RBjrfNAIhhTn3atloFx1+wVzEUHzb/cyxrO2jCOmQng814apKY80bYsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FHQJBe4H; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-63b3a9ff064so40295607b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719241775; x=1719846575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASZd4wKEAiwtqiPptjvJp63/aDvJWAQ0c9DP1WpI4QM=;
        b=FHQJBe4HVSxW5+hmTn3nNtqFZ5VwhPHZ6oHGd0mf52Rrn1zUo7VUwMSLIlqO1NAHmO
         skhz7W6ar00UG2QskuxJoLr5GZlmH/dAoHeA+aM9t+zRF+k+uJUfZZttUzBtr0TEwJwe
         z5VkB80/CMgkLPnCKRbBZvU0ZZolRjX6UeB3vo4ubE+SttK+a+H+ZndLIovGyofYMDZE
         sfZfOiMbLJq0Ewqv2g5MHPTTpUqvyBsL+2QjDgqzCv/BQmlzMENUbkrfukYS34wU7DMu
         FWAKjk7RMT2A0zMAwli6ULGhsAiTp82PUi+Qvzf3kcw3n2aoiQtaBrErbZGsQvLaUslC
         Qt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719241775; x=1719846575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASZd4wKEAiwtqiPptjvJp63/aDvJWAQ0c9DP1WpI4QM=;
        b=iFvAyXioH1zFx+nAUQXcQN7qnbKfLkPwASzoaMjU9YDY+UzFyNV7CZSvCeLv2T8uMp
         fdByKF63qjpTX2JFjuCdheoHFakVAjgHhM1oOgPKXV/Rdm4ZTTe6OIJNVFw9yck0dzq4
         AloKkb1pYReDIOVKqIsNO6BzXTJsrudUjarL6Lr2T0HfYuWDMHKPQOyalkZDZ+p1Y9Gz
         XcBz7sp+ZPfkBgqedmzZjdGa/Y+ffCQgtd/9xR8QCLT+eSskB5qEUIm2C2JqVuNCeNyf
         E+/HBwGWC0FdudQSTlrZ23Xu1sbUqce//Vav+MLIL2ydrH+3h/N1Jn06fs3+0+Mplt6k
         Q/8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+2TUlVGQgP1v7CzoRmQ544So2mFWL7UwI7RZxJaERIMwru1+bMOi4a6gv4kCGUc9x9O4cN1VIE6UUKExgm7HFH2rlikXeozvwIiBo
X-Gm-Message-State: AOJu0Yzro9Zld4V24V0QGy6g3vlYNxtfaiHr86ZSXYNKjvsr4VEArpPT
	qz2WsJTfWnpqEXXQaqz4lBdn5GEklIx53mRBni+gJAE1sJXVsZDNM3pZkE1Q7o/5j371Rn3bhvQ
	f0nC8H5yn8UWvcw2n5E9ZC0WFEfDUe12LeAjCrw==
X-Google-Smtp-Source: AGHT+IFk7ZptCfvr3I0bCaSAgeH41ekniw2KW5iMHWyieVMoyZ19l2fUERsJJEo6b9A6UwAFeBQR0LS33DKM2r3otCI=
X-Received: by 2002:a81:6e54:0:b0:63c:486a:289e with SMTP id
 00721157ae682-643abf3cbd5mr46006067b3.32.1719241774654; Mon, 24 Jun 2024
 08:09:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621-ucsi-yoga-ec-driver-v8-1-e03f3536b8c6@linaro.org>
 <2024062411-neutron-striving-f16c@gregkh> <CAA8EJppDtmNxfjc-f9MA1Za=jvZFqahKtM+FA66jG6Dg=zp1Cw@mail.gmail.com>
 <2024062400-stimulant-barn-2daa@gregkh>
In-Reply-To: <2024062400-stimulant-barn-2daa@gregkh>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 24 Jun 2024 18:09:19 +0300
Message-ID: <CAA8EJpqNd45CF+hw-fqXzUT51+6wmxYy3R8UBxzH+9C3AcgO+g@mail.gmail.com>
Subject: Re: [PATCH v8] usb: typec: ucsi: add Lenovo Yoga C630 glue driver
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Andersson <andersson@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Nikita Travkin <nikita@trvn.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Jun 2024 at 17:43, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 24, 2024 at 05:37:05PM +0300, Dmitry Baryshkov wrote:
> > On Mon, 24 Jun 2024 at 17:25, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Fri, Jun 21, 2024 at 01:21:26AM +0300, Dmitry Baryshkov wrote:
> > > > The Lenovo Yoga C630 WOS laptop provides implements UCSI interface =
in
> > > > the onboard EC. Add glue driver to interface the platform's UCSI
> > > > implementation.
> > > >
> > > > Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> > > > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > ---
> > > > Add driver for the UCSI on the Lenovo Yoga C630 laptop, as implemen=
ted
> > > > by the Embedded Controlller of the laptop.
> > > >
> > > > Support for this EC was implemented by Bjorn, who later could not w=
ork
> > > > on this driver. I've picked this patchset up and updated it followi=
ng
> > > > the pending review comments.
> > > >
> > > > NOTE: the patch depends on the header from the platform driver. Ilp=
o
> > > > J=C3=A4rvinen has created an immutable branch based on v6.10-rc1, p=
lease pull
> > > > it before merging the patches:
> > > >
> > > >   https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-dr=
ivers-x86.git tags/platform-drivers-x86-ib-lenovo-c630-v6.11
> > > >
> > > >   platform: arm64: add Lenovo Yoga C630 WOS EC driver (2024-06-14 1=
2:51:30 +0300)
> > >
> > > I have that branch, yet when building this driver as a module I get t=
he
> > > following errors:
> > > ERROR: modpost: "yoga_c630_ec_unregister_notify" [drivers/usb/typec/u=
csi/ucsi_yoga_c630.ko] undefined!
> > > ERROR: modpost: "yoga_c630_ec_ucsi_get_version" [drivers/usb/typec/uc=
si/ucsi_yoga_c630.ko] undefined!
> > > ERROR: modpost: "yoga_c630_ec_register_notify" [drivers/usb/typec/ucs=
i/ucsi_yoga_c630.ko] undefined!
> > > ERROR: modpost: "yoga_c630_ec_ucsi_write" [drivers/usb/typec/ucsi/ucs=
i_yoga_c630.ko] undefined!
> > > ERROR: modpost: "yoga_c630_ec_ucsi_read" [drivers/usb/typec/ucsi/ucsi=
_yoga_c630.ko] undefined!
> > >
> > > So something went wrong :(
> > >
> > > I'll unwind that branch pull now as well and wait for a fixed up vers=
ion
> > > to be sent.
> >
> > Could you please share your .config? I could not reproduce the issue
> > here. The EC driver has all the necessary EXPORT_SYMBOL_GPL()
> > declarations.
>
> Sure, attached.

Thanks! Fixed in v9, drivers/platform/Kconfig issue.

--=20
With best wishes
Dmitry

