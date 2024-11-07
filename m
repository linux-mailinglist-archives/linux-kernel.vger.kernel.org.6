Return-Path: <linux-kernel+bounces-399611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F273E9C0194
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8BE31F23ECE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063A11DB54B;
	Thu,  7 Nov 2024 09:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="NaH/jdYG"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909A51EF934
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730973170; cv=none; b=ViKJ1ReD7cWeJStW+rBkQgts+WpttYKhqNsestW0xxTWwMt9+Po3kzGvbzH3Lvx+gOBdln23qVrfbxpxM9KgoSzVrs3a+rpeRTJDvwNyV9PK+IrYI0TudqufwwpmBLD6fzCQ6UyBJxR4efG8GMSPGDV727qDDl+RBV408+dpyCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730973170; c=relaxed/simple;
	bh=lwkS4VJfaJEucEu5sjIf8kNJ80mve52KW6NV0UYNB8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hVi74eAJREliHbU5Jtxqc/wcBwxVv+bjze3nZkx1q9B43webIFClv4aLPn4kD14d/Ia71rFSGMiU7P9jWKY5Gxnmrj79fmjY3m4QIgLw07qScCHoi9yPA/78S0B4+adB2XenIbnZ1yKQ5sT2WBvVrHdq5Ioyahm1Dz5fbhfgnEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=NaH/jdYG; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f53973fdso674588e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 01:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1730973167; x=1731577967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IA66ioYkj3vj3gACNMRiFPoKPNWp3AWQcm6mCZSqbfc=;
        b=NaH/jdYGTYkBmUyJs74b+/ex71quTl5uzSC92GKcZChVf/XxVQRQUeFUaY8Wh557qv
         zV9CX0d/IpapeSwP6N2cu1g08841CnRj0+z+UytkV7FeqkVD60X46jcxMoSVchlnG5lC
         zrqNjLuKaVPFc6WxUX1touZXuXCQruG56nbH0FGrk2TUJJH+HN23IPzJqwiAu28bjSHl
         uF5kwgHeL69CtXCZl0pGOYvHD8oD5loDQAWiEGg6diRyt3Iv7V5sag8Wi8KimSKyR8cn
         Y4UQlr52erRzkMf6qGdBluG2OBr09sfcM1G1+5XXXjbHbAPRkQzDKqMeP4p3E/q+9ZDH
         1nFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730973167; x=1731577967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IA66ioYkj3vj3gACNMRiFPoKPNWp3AWQcm6mCZSqbfc=;
        b=LKTlYeHW2BJcRD23On0zNkEWWR7kj9PlGQ/j2qe60e00k5JGO7t56Ajw09o1cVNYTl
         6gyOuev1fsLpvZNXz2coE1Pr/BsDXQrwDJOZAWRDixH63jISyC5hh3tb0Nr70VAvu224
         tqIhKefOXNdwxGzlOTAlurAJ592OSCLr99aO/TUGih/vkpJr3liWw6RR5StF4tnU0P1Y
         EJT9vIrtanbJ6kW8rsF/y28BOp6fy6Fxj60qXo3yvZKENlgFfbfW1iDIyceijGimWdh8
         v+kSfp/h/RPqAHa88SZ4BUrbeiOj8j+D+Z22/BYpgp4r+REbj690nA4RvJtvnm54WrPQ
         E6Ig==
X-Forwarded-Encrypted: i=1; AJvYcCV579wHujmLuLU84eMffDMWylZX03f6LVSXibWnnkrwrPPtOk1xZgvZl+DshWJUpaJKqCb+GjkNHsJhRLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9l5pmLIo8J3x6SVSO1MUaSKLRbJ3Woh3F2KTpyjNrOHh/ZeNZ
	UiJqMDsi7OXZ1I2yt6kvfj2jTGTb1X/hBf4zDc6SwP9AS2c+VkloWewCBJVOBhGGhwTP7PSUUyH
	YvD6ch9s8JsG7ql7QMVHOL7ZiE2q0rEvsMUv+1w==
X-Google-Smtp-Source: AGHT+IGoIjWDtseFdv8HQtxmB05m0ChWJ9ovwz6pG0rW7iORfMGi+Nv+cmXMOQUFwz4dLK8J9uZOk8L+1MSKQszJKqI=
X-Received: by 2002:a05:6512:230e:b0:53b:48f2:459b with SMTP id
 2adb3069b0e04-53d81994c48mr849244e87.23.1730973166565; Thu, 07 Nov 2024
 01:52:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025-pci-pwrctl-rework-v2-2-568756156cbe@linaro.org> <20241106212826.GA1540916@bhelgaas>
In-Reply-To: <20241106212826.GA1540916@bhelgaas>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 7 Nov 2024 10:52:35 +0100
Message-ID: <CAMRc=Mcy8eo-nHFj+s8TO_NekTz6x-y=BYevz5Z2RTwuUpdcbA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] PCI/pwrctl: Create pwrctl devices only if at least
 one power supply is present
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: manivannan.sadhasivam@linaro.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, stable+noautosel@kernel.org, 
	Krishna chaitanya chundru <quic_krichai@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 10:28=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Fri, Oct 25, 2024 at 01:24:52PM +0530, Manivannan Sadhasivam via B4 Re=
lay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >
> > Currently, pwrctl devices are created if the corresponding PCI nodes ar=
e
> > defined in devicetree. But this is not correct, because not all PCI nod=
es
> > defined in devicetree require pwrctl support. Pwrctl comes into picture
> > only when the device requires kernel to manage its power state. This ca=
n
> > be determined using the power supply properties present in the devicetr=
ee
> > node of the device.
>
> > +bool of_pci_is_supply_present(struct device_node *np)
> > +{
> > +     struct property *prop;
> > +     char *supply;
> > +
> > +     if (!np)
> > +             return false;
>
> Why do we need to test !np here?  It should always be non-NULL.
>

Right, I think this can be dropped. We check for the OF node in the
function above.

Bart

