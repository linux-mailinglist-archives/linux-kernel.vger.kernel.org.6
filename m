Return-Path: <linux-kernel+bounces-328225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 718A29780C5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00A9C287210
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6521DA61F;
	Fri, 13 Sep 2024 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ROM8zHz0"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D347D19F415
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 13:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726233047; cv=none; b=IZ1jAM2/fQbt4tGW2niOJPGhLMOhbJUo/F3iQYYemQFRrUllNVfgCfLRJx79Ny3DcoHISokMcHsD9vN1gIV24zl0YmgEGez+UhsX9OkoIBq4LciOgYxouNk2sUWsFG4byo77ycFPBYPRR01ZS9uwFFlRkx5AkbGe2cUbl/dTOu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726233047; c=relaxed/simple;
	bh=OFvq8yke0/IDCXgLS2cPimaSh01efgl5/tIuG8ZgukE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D0ChlVg+sa7Mb1bNVdr//aDDOvarymYcFVgkPWyGSCSD90HGGdUQ1JZnKgSdKYre4NouJgXclXTcgq0OmSxaq5puSlQMzgOpKcFwmREkc1lDaZS1PrxDmHCnlkEE5MHjtQGqHpTQQG0Z0PU9iRyd4MbPE5G7kiJBz46JOKO6GRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ROM8zHz0; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-27b7a1480bdso934076fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 06:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726233045; x=1726837845; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4oKliMfUMVg1aXxzTE0l3neUaGwA1Kbu5Zf+bM+74JA=;
        b=ROM8zHz0yp6LFOywkxRukCaamqf5IHdoUJuMiEq+1r3RgwcPpJgzZ3lFjZXlFMPCFM
         QH+eIhD0RqBoSpwNkcIAEP8ehTARhkj3Tu6sD9yz56bWgwZtoSnRMC2JQwB1AuwAojrb
         /I0P6Rql/XfhyPRp0RnGN5C2+y8qJJ2kI29pkVf5pkIT0kvayUr1wDPtx6NXbPJed9oE
         liBKK6sbW8tSzLyuXt2qXX3m1Nao+r5/kTEx8oozf5eRuySyaboa8r8r+R6AzEcCruHK
         bBxFRnI9KMAEqhgRaAec6bkZ22O63q45sgL74R/mYENUw64Y95x63ytoG7KkY220UJL+
         WfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726233045; x=1726837845;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4oKliMfUMVg1aXxzTE0l3neUaGwA1Kbu5Zf+bM+74JA=;
        b=nTEf6tne4v8Jvd/iC5HQ6VNiV6DHqxUPEtUmsBSmZiJD3WkwpLorKIS1tFdtPTqo+j
         U6tWfOdtQLI1f2+pEK6r0fgAyPSCozGmSL+q2VWqPHzY6uns0QwZEHFrnMUbwc/rRMHF
         J2Z6YbxW8eIezJGcx2W2uozxcjP+qiOavOA6ncO+f5pBW0Qe0Rrqr9jbSAHXIiwoP0t2
         slkelJ1pSKiDuJnLmdJY6J5/pC4FgYeaNJioQ8UVuZLtD9nJWGSpER878SYtYyD/nLgZ
         uiQ+2SHrvIRQniPqZVIyYR+j1c27ZIfppkOIhrQzQVIn8aT8RQR3Kp0RcSRqGgWhR3q2
         u5MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz+HP4bLkIFHGYc2EMMaKe+S+pLqccTSkn2RLmbgqeUQh/my1iqP/dMO484xUzUsNHZJSit5gtGo8Y6Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YySIr0/OFurrnx9x5Jqmqgvgys15aZGWmmKQcUJrLDz5Bh2P6rx
	ni0cxE3/N54QoqYUvmpG+Vt8Dx4NbJ/B37lH+XiPzD3/DDGbKAURL6T/uIedlyxJHEJvBxlatNz
	qrPG9St2XeBMeoygWlCWs8/S1m1v1pgw0oCxUlA==
X-Google-Smtp-Source: AGHT+IFu82D+7Sc8uv+eJuU71zTmpYlaWnT8Mb+zxAE4wtvkLRBCmJGMwnMM5dKbJ1Xc9GGptIhr44VyxZ1NjWdzYu8=
X-Received: by 2002:a05:6870:1952:b0:277:c084:5f75 with SMTP id
 586e51a60fabf-27c3f27160dmr3944492fac.18.1726233044834; Fri, 13 Sep 2024
 06:10:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906202745.11159-1-gourry@gourry.net> <20240906202745.11159-4-gourry@gourry.net>
 <CAC_iWj+uieGoH1ouc6nwdZjirULgjYk+H6YFQQHSHcAySdaFog@mail.gmail.com> <ZuQ2xmXo0FPZpJa-@PC2K9PVX.TheFacebook.com>
In-Reply-To: <ZuQ2xmXo0FPZpJa-@PC2K9PVX.TheFacebook.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Sep 2024 16:10:08 +0300
Message-ID: <CAC_iWjKFmHUV4EzhfJ_OAHOZhrAzH35O8QMzVK_Zs2aTG5h+1Q@mail.gmail.com>
Subject: Re: [PATCH 3/6] libstub,tpm: provide indication of failure when
 getting event log
To: Gregory Price <gourry@gourry.net>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, ardb@kernel.org, 
	leitao@debian.org, usamaarif642@gmail.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Sept 2024 at 15:58, Gregory Price <gourry@gourry.net> wrote:
>
> On Fri, Sep 13, 2024 at 09:59:03AM +0300, Ilias Apalodimas wrote:
> > Hi Gregory,
> >
> > On Fri, 6 Sept 2024 at 23:28, Gregory Price <gourry@gourry.net> wrote:
> > >
> > > If get_event_log fails, at least provide an indicator of this failure
> > > to assist debugging later failures that attempt to interact with it.
> > >
> > > Signed-off-by: Gregory Price <gourry@gourry.net>
> > > ---
> > >  drivers/firmware/efi/libstub/tpm.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
> > > index df3182f2e63a..192914e04e0f 100644
> > > --- a/drivers/firmware/efi/libstub/tpm.c
> > > +++ b/drivers/firmware/efi/libstub/tpm.c
> > > @@ -185,8 +185,10 @@ void efi_retrieve_eventlog(void)
> > >                         get_efi_config_table(EFI_CC_FINAL_EVENTS_TABLE_GUID);
> > >         }
> > >
> > > -       if (status != EFI_SUCCESS || !log_location)
> > > +       if (status != EFI_SUCCESS || !log_location) {
> > > +               efi_err("TPM unable to provide Event Log\n");
> >
> > s/provide/retrieve/ and yes the print is going to be useful.  Do you
> > know if the EventLog is mandatory. Reading at the spec GetEventlog
> > only has 2 return values, which implies you can't return "Not
> > supported", but it's not explicitly stated anywhere
> >
>
> I believe it is mandatory from my reading of the spec - but the
> "Final Event Log" was only added in 2.0.  We report an error when
> 2.0 is reported but the final event log is not supported, so i figure
> we should probably report when the event log fails as well.

Yea I am fine with that, I was just wondering if we should do _err or
_warn. I am fine with the error

/Ilias
>
> > Thanks
> > /Ilias
> > >                 return;
> > > +       }
> > >
> > >         efi_retrieve_tcg2_eventlog(version, log_location, log_last_entry,
> > >                                    truncated, final_events_table);
> > > --
> > > 2.43.0
> > >

