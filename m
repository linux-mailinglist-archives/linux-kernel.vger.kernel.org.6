Return-Path: <linux-kernel+bounces-232537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4EC91AA8B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55E95B287AB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950BC19885E;
	Thu, 27 Jun 2024 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UVXkq2M6"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58348196D8F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719500911; cv=none; b=pZHGeghQL0U0oGnhFAraf2AeX3ktFqzH3+cmHPf7TNqbE/AbwteRfCP5j5xnHz6hWAloTigsLIuKFYXCUMjuZ1j9WlAqQDxrFHAxztFWTrqqIlVZQMy4mqCzAK8PRryYoKDGKt0efuSsbTU2TPOnPkZklcxBlngK9NiwUfSPsV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719500911; c=relaxed/simple;
	bh=uyk3FSs1lwk1fumBjvU5yqMjwXEgEW8JXSk9JLXZqa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ua1VFqlfhs5VHxxTVOHEFD1p0ui7iXAkIpDJ+C8DQqECAWAgWM7X0KL/+LcVXgyc/fT1VZTALAlpcWds2JpROIkMtEMx3zufZUilRV4MvfPhxkifOCxFC33gNaJSTlH/iT7+6hJ/YqxC3kvW6I56A86h89GMxr9NEiEPeV/b3lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UVXkq2M6; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fa0f143b85so44201705ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 08:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719500908; x=1720105708; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XlBk62eLW/kjgbzF1XN/AbvScYXzLgjXOoZnGiz7y1U=;
        b=UVXkq2M6rvySHYa2d/JcRt4JizCK2Oq/DvwEvwqWMcQsdqPK3f6W2rLJyCcm+RacRq
         tbXhwajyDAS3DBXte8eTIUQOqw0LO23xN2n2J2KV6Dti2mC29jbFiYst1zraILpOq6tj
         Byxl7X/FgSrwFiVoGIW+6/QeOMQULG/J5SU/0kcqaWdjorWeh66xg0j1LlSzlXv7q/Fl
         NueWC5Hla0c9CAU5ZLMOkbUfcwmcL0xl8K+KrJ42UaBJh/EvGnlgCy73bujEletR9BeZ
         lPuj2A0pzhbjC4QISSC9uYOsMwZv34WVtAzwuDKHjjD8ck6llTWsz3Ns2yD+NB9WzSOl
         I09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719500908; x=1720105708;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XlBk62eLW/kjgbzF1XN/AbvScYXzLgjXOoZnGiz7y1U=;
        b=fyvuZcdfJMPP6ciaL0Wg3uk3gfqYsXmFjCqoTa+Ar/1lo+dZIVj2sYwHFl4DH2e+yx
         UWFAebdpupBTYzx5PwW7K3mcsuVRooQAaa5Vm4mIfrEN09pEpk0rkGYYr5Ky/AzIx9lo
         mick4Nh/Qpla+Oior8csCOui5H6VHdXzXoPVHcWQn/mFJz3Ck6W0OrIZ9ORS2mSyypIp
         5I9N44e6wyv967/laJFqrWPEnK5BT5piUHR7NddNxfNJXafGYMTt5AglIji/JcpnWfMX
         e0taiSuibsZG9sUJWIk0kD9ImFQAU6XSBB7LbITO95q3e2wRCkebozPlDQ2UZjJpPayX
         AEpg==
X-Forwarded-Encrypted: i=1; AJvYcCU7NJQ+IMCHPppk33WxtZ1Bc/eeDAUjfCM75uM9ir9B/b7Kno9Nw6Xg0fcPMHLDEd4FWnsAyZbNt7D8vO9WSp3KfcaYe5Mt0EAx4pgR
X-Gm-Message-State: AOJu0YwSNSABQjcqyDNjINuajj996CJnw8FAwkz4Tea/5N4Gm7z+Y1e9
	yR42+e8/hidOfVP+l6BZ9f5E46XfXdAxmi26cugbP7OqlHvmS39BAYQTMWhhABM1a+Izb8pu2xc
	t422Palsr9RAJKLOm3RaIPt7ENvy/1pHlXsRJgQ==
X-Google-Smtp-Source: AGHT+IG4sxRssQrE3KkksvhzRPbEUpTAN4nLG0tK43Z2W0D0F/3wbeXfMrrZPwet93SF8QRD3aOVYoHaL5scRO2bhuk=
X-Received: by 2002:a17:902:c943:b0:1fa:ab4a:faf7 with SMTP id
 d9443c01a7336-1faab4afe50mr20966755ad.11.1719500908478; Thu, 27 Jun 2024
 08:08:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627-ucsi-rework-interface-v4-0-289ddc6874c7@linaro.org>
 <2024062717-foster-document-eb2f@gregkh> <CAA8EJprAshnt3YchBv0ssi4Vet9b6oMcf3z8nuRkoZVYNBq64w@mail.gmail.com>
In-Reply-To: <CAA8EJprAshnt3YchBv0ssi4Vet9b6oMcf3z8nuRkoZVYNBq64w@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 27 Jun 2024 18:08:07 +0300
Message-ID: <CAA8EJpqCJ8_wOO7yLYA85KYtbLO6hvS-yb7DA6kJ2sH4QH43QA@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] usb: typec: ucsi: rework glue driver interface
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Nikita Travkin <nikita@trvn.ru>, Neil Armstrong <neil.armstrong@linaro.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Jun 2024 at 17:57, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Thu, 27 Jun 2024 at 17:54, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Jun 27, 2024 at 05:44:39PM +0300, Dmitry Baryshkov wrote:
> > > The interface between UCSI and the glue driver is very low-level. It
> > > allows reading the UCSI data from any offset (but in reality the UCSI
> > > driver reads only VERSION, CCI an MESSAGE_IN data). All event handling
> > > is to be done by the glue driver (which already resulted in several
> > > similar-but-slightly different implementations). It leaves no place to
> > > optimize the write-read-read sequence for the command execution (which
> > > might be beneficial for some of the drivers), etc.
> > >
> > > The patchseries attempts to restructure the UCSI glue driver interface
> > > in order to provide sensible operations instead of a low-level read /
> > > write calls.
> > >
> > > If this approach is found to be acceptable, I plan to further rework the
> > > command interface, moving reading CCI and MESSAGE_IN to the common
> > > control code, which should simplify driver's implementation and remove
> > > necessity to split quirks between sync_control and read_message_in e.g.
> > > as implemented in the ucsi_ccg.c.
> > >
> > > Note, the series was tested only on the ucsi_glink platforms. Further
> > > testing is appreciated.
> > >
> > > Depends: [1], [2]
> > >
> > > [1] https://lore.kernel.org/linux-usb/20240612124656.2305603-1-fabrice.gasnier@foss.st.com/
> > >
> > > [2] https://lore.kernel.org/linux-usb/20240621-ucsi-yoga-ec-driver-v8-1-e03f3536b8c6@linaro.org/
> > >
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > > Changes in v4:
> > > - Rebased on top of Greg's tree to resolve conflicts.
> >
> > Nope, still got conflicts, are you sure you updated properly?  Patch 1
> > applied, but #2 did not.
>
> I feel stupid enough now. I rebased on top of usb-next instead of
> usb-testing. Let me spam it once again

Hmm, I see what happened. I had a next+usb-next. Simple usb-next
doesn't contain changes from 9e3caa9dd51b ("usb: typec: ucsi_acpi: Add
LG Gram quirk") which this patch also modifies. I can rebase it on top
of your tree, but then we will have build issues once usb-linus and
usb-next get merged together.

-- 
With best wishes
Dmitry

