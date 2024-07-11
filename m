Return-Path: <linux-kernel+bounces-248957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4C992E465
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69085B214D8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB9315B12D;
	Thu, 11 Jul 2024 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t4Pb4xmu"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D673158D96
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693233; cv=none; b=HfwBSwSOxGjplaaoJVep4RvnxmGDwkExyAEhUWnidI8189dV0cTM5skc9jz7oPl23Po6/LxJrmnaioy4MBT3vn53tNnMPh/JIut/ZF5i2fG+X2gWeN20ChVnebYpGlkZhQibpta3xGFXZfi7l6AL8QC13GDJF2gQDZwkJxtMzeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693233; c=relaxed/simple;
	bh=atFigx0T1LVGe14ZAvm1oql6R4jmd8118+NKg9FdPio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jfv5f6x+ArVy1IFI+hZPXYSGYPY31y2dACHm8ynP5oMTvd0NP9zS8ATnUwtxEk2L7UALOtZqYo2zn7jToaSOROY150nVARi3SOd42IddRgFARbhQ9jCpuqGuB5t5rvyX2cWhGVJIB2hcExRGXuX94my7MgKMGuyHggYu7X8TP7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t4Pb4xmu; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e04f1bcbf84so740909276.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 03:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720693229; x=1721298029; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wx798dgzG8dNc2c2k8oAMTgPjHa/fzRaZJmr2infrms=;
        b=t4Pb4xmuSY5alFYOA8oE1QyVdRFxmh2bC5/n2kXQ/l8cuRPp80OqEt4IkvkTl7KrbD
         KsDDlWbQ9jHgVVAIyvS2m+ABUIPQ1iNjh18lxNouIqCuR0KIPRv2Ntp0tT3u8CHYwaGW
         EY/YG1niDPSwFRevNFSAlccl8koVImHZ8S/ZU9WjXXPQ63hob6UmQV6diMUNgoiSMv6v
         Y+PaxgSy7OXkNJpWoUttWt9c4O5Znh7FpAUzkdO4v5xQfsgUt3aL/1aTPGp8Lc+FnJ2A
         aa0XNHMqj/Byg1O08VJoltZRac8w5lQqRSNEwDhzabknF4tiXF1bODdUUUwZDAHUFw87
         pfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720693229; x=1721298029;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wx798dgzG8dNc2c2k8oAMTgPjHa/fzRaZJmr2infrms=;
        b=BLEuzKmUrc0xqnskMbCG5eYtawWWhRtvXOVy5Sqg8zydazwp8Bl5R7gmMtRZ5WQR4s
         Ttal8BAzZ+9RsUsDXVDPqUNDLg43wy6RaASQ3PrxSyX0R1oqHmPsYBJhKbtGVqHqyHWZ
         bITsGi0lCDw6z+mLWmrNb22BEIY+LKEvcY9hNtiBYUW9jQDQHJGFvgplRvvhe6tjkuSp
         yQDM0dJQTL9aFpGYTNCYeUmo53elHZ26SCdE/a8tc7of0nhx18wXBUf3Q5B2c5dHe2gM
         3bX4px4rUu9ZB/d6KGRbc+B2hpjalD+yVJQV+8WbrTe6FclcIMCo8A/LU+rgUMus9+Sy
         pH8w==
X-Forwarded-Encrypted: i=1; AJvYcCW3IOya0ACvSc4iTmbvttQyrElA7ULmDm89P0iFmoXGcGujqnKLvEu5tLanFTf3ZKRVcrHvx11nbo9nNfpy0y99XSkt3k0/VGqr54Rg
X-Gm-Message-State: AOJu0YwxDv333OPlBtPCZIPCgUtpjfASjMYF3Qml/pylsPoGtqRCvIpL
	KQc7amJk5HS7F7OWgmwdoRLFLb0S2CaVmthacIICMfeU3MVAY8chzsf+ikARqvWmJ1FLMK6CgcI
	2mExALbWqp1lTdJl0MNsHs6GwZH5BJhJdqnU6xg==
X-Google-Smtp-Source: AGHT+IFGTZUKBH76h5uq4mjZBsgTm0ziinY4pRCuByE2zxYdVCK/mzXjbYiNoXBWXVtpl0KBz7KVFr7oFeDOJY8Bfro=
X-Received: by 2002:a25:d882:0:b0:dc2:5553:ca12 with SMTP id
 3f1490d57ef6-e041b059302mr8762819276.14.1720693229469; Thu, 11 Jul 2024
 03:20:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619140849.368580-1-ulf.hansson@linaro.org>
 <20240619140849.368580-4-ulf.hansson@linaro.org> <20240626063321.3x4cvyj7yiks5f3p@vireshk-i7>
In-Reply-To: <20240626063321.3x4cvyj7yiks5f3p@vireshk-i7>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 11 Jul 2024 12:19:53 +0200
Message-ID: <CAPDyKFqY_mNnaT8j4vCXxYtARkGb_bkvcwKkyXcLPwW+gutO8Q@mail.gmail.com>
Subject: Re: [PATCH 3/7] OPP: Rework _set_required_devs() to manage a single
 device per call
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Nikunj Kela <nkela@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Jun 2024 at 08:33, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 19-06-24, 16:08, Ulf Hansson wrote:
> > @@ -2494,36 +2495,68 @@ static int _opp_set_required_devs(struct opp_table *opp_table,
> >               return -EINVAL;
> >       }
> >
> > -     /* Another device that shares the OPP table has set the required devs ? */
> > -     if (opp_table->required_devs[0])
> > -             return 0;
> > +     /* Genpd core takes care of propagation to parent genpd */
> > +     if (opp_table->is_genpd) {
>
> A genpd can have non-genpd devices in the required OPPs and so this
> isn't sufficient. What we were ignoring earlier was genpd having
> another genpd as required opp.

Unless I am mistaken, I don't think that is a scenario we should care
about here.

_opp_set_required_dev() is being called for a device that is about to
be attached to its corresponding genpd.

Yes, in some cases, we attach a genpd provider's device to its
genpd-parent, but that is not to control the required-opps.

>
> > +             dev_err(dev, "%s: Operation not supported for genpds\n", __func__);
> > +             return -EOPNOTSUPP;
> > +     }
> >
> >       for (i = 0; i < opp_table->required_opp_count; i++) {
> > -             /* Genpd core takes care of propagation to parent genpd */
> > -             if (required_devs[i] && opp_table->is_genpd &&
> > -                 opp_table->required_opp_tables[i]->is_genpd) {
> > -                     dev_err(dev, "%s: Operation not supported for genpds\n", __func__);
> > -                     return -EOPNOTSUPP;
> > -             }
> > +             struct opp_table *table = opp_table->required_opp_tables[i];
> > +
> > +             /*
> > +              * The OPP table should be available at this point. If not, it's
> > +              * not the one we are looking for.
> > +              */
> > +             if (IS_ERR(table))
> > +                     continue;
> > +
> > +             /* Move to the next available index. */
> > +             if (opp_table->required_devs[i])
> > +                     continue;
> >
> > -             opp_table->required_devs[i] = required_devs[i];
> > +             /*
> > +              * We need to compare the nodes for the OPP tables, rather than
> > +              * the OPP tables themselves, as we may have separate instances.
> > +              */
> > +             if (required_opp_table->np == table->np) {
> > +
>
> We don't keep such empty lines in OPP core generally at this place.

Yep, let me drop it!

>
> > +                     /* Cross check the OPP tables and fix it if needed. */
>
> Copy the bigger comment from_opp_attach_genpd() here too. It helps
> understanding why required_opp_tables entry is getting replaced.

Right, makes sense!

>
> > +                     if (required_opp_table != table) {
> > +                             dev_pm_opp_put_opp_table(table);
> > +                             _get_opp_table_kref(required_opp_table);
> > +                             opp_table->required_opp_tables[i] = required_opp_table;
> > +                     }
> > +
> > +                     opp_table->required_devs[i] = required_dev;
> > +
> > +                     /*
> > +                      * Add the required_dev as a user of the OPP table, so
> > +                      * we can call dev_pm_opp_set_opp() on it directly.
> > +                      */
> > +                     if (!_add_opp_dev(required_dev, required_opp_table)) {
> > +                             dev_err(dev, "Failed to add the device to the required OPP table\n");
> > +                             return -ENOMEM;
> > +                     }
> > +
> > +                     return i;
> > +             }
> >       }
>
> --
> viresh

Kind regards
Uffe

