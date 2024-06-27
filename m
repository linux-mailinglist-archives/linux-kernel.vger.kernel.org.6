Return-Path: <linux-kernel+bounces-232510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A19F891AA0B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5825828614F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDF3197A69;
	Thu, 27 Jun 2024 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rPDAQeut"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD4F13A259
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719500265; cv=none; b=G2DybRSs/HGyhOrLhFBIC+MtAEJ+nDcyC1wI6xmjYcy0Z6BY5T4GOOkE94rWpMmAmSGHVUp2+NDoWOcxfKD1oG/n+JFGCvT1YNuVihMvl80gpzJ2Uns0CkSTUl550WHJ9ue57uOo92+AamlCfsGuNJ2ow4/K/vz+OBilN7DKx84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719500265; c=relaxed/simple;
	bh=8bfhVpFtKte0q0LpK6Z+2fZ0kVuSuHR8xlPRmGLhw34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UphTBw6eIN6ArynmmS6OJqKkdB5ervC1WfgH9NYDBhTRxaQiHQ+XMl2Jv92DqR8tN+KfNZzfcVUHv6NHEzXtD5cVLYlB2hdbh31Mr+XmbNsJPbetGIBNNOEY8ABycLvAZ3XGlMcZzyjeUxhCeu1ykwCLAVotnA6Z/L1a1ZwSgTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rPDAQeut; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-718354c17e4so4383023a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719500263; x=1720105063; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y6zgDkxzVTCfp8FYBsiMFrOvxs4mrOqUQpxmdnl71g0=;
        b=rPDAQeutUjKIoaTCnoEUv6J1nnRNo8hGYEf/EiqP7IjMpmKx6BixUAs62KWXSZkfZy
         OLsPe9eC2/H/oDhJ9WkIiOeiyA/Q1X6iahJ8idDPJmAGwTOP1XMCSf54gOvH5L9khyd7
         3hc947UXOwTZgWsKX5BEt76oxHpsDg7Ng0CuNCDOejSmwul9vLDiq10hqJXHRPXhvgk3
         ZjwxM/YUWJv9aElVdof3z9ilzQjHNoYlIIjmUdadpArY9/C+GISae+ydgi6TeuYmElmh
         68fa0sWSg++/50Osh8SzoXWDNZ+SAyllIjtExInKDrIqXFm0OphN4a8vO7uWTWrqZ1J4
         YcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719500263; x=1720105063;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y6zgDkxzVTCfp8FYBsiMFrOvxs4mrOqUQpxmdnl71g0=;
        b=r6ldsXIu2Dro2OLyzPPAj/TwT8nVQFOHKM8r+hmgfl179UZEzt3ErzqSx7tkFcQ8o1
         sHd2RumFD6b5K+M5lDmwvVlpHdDN77ZLsWVp3ecJP5qkcua4UaD13Uoxqmah85Gaq0NZ
         0mtP9tnRdu9FYe8hdis8ug2ik8qtIkvcQK+aH0+Hz9JpDMmWIVY4gFoYAHR4W/ns7jwO
         OjHjAubRDhhvOAW5+nE+zYSBDR3MTTBCURqUo7MDHRAhDYcRY3df1cWPnV17oL2ze5bu
         kk5igUA1yAiYQMXJ3PlAQRELDv5EGlbIOZJ1mwmPGAT4Rf5dU+ks5cKTLOFb6g8Z5ml7
         F+5w==
X-Forwarded-Encrypted: i=1; AJvYcCXZ+Rb6Yj8bywl9CSW+02PTyxdQZSSpzkLR/tVBWNt27XO0+xytd8+YYzTIYMhdfav5lQd2eTM5qqnI0qrAC0z/NQtI6xrY7e6z8zsq
X-Gm-Message-State: AOJu0YzpshMywi2lDVPfr7eQW+nD8YgJn11SlBoH9j1RH5R9LcVEFdny
	i91/OCfIEV0z6ZdV6459tTKX/j8gMNcLaiphL2N4JUMx30pqQ6EYHMcw74N2mZeAETa7GBMVtiZ
	rvPtgAEV12gHWAEgjDzs7EDNDZbaTLJdv6I4BYQ==
X-Google-Smtp-Source: AGHT+IGNBAyVWF3V0HW17I0OZdNRl6+47JMbaP/xlj33W1liN9Mo6xOSEbxabe4bXHVGH7BG/VewhSmaNEbyO6I8V/k=
X-Received: by 2002:a05:6a20:6521:b0:1bd:2358:8c8d with SMTP id
 adf61e73a8af0-1bd23588dc9mr6921778637.29.1719500263272; Thu, 27 Jun 2024
 07:57:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627-ucsi-rework-interface-v4-0-289ddc6874c7@linaro.org> <2024062717-foster-document-eb2f@gregkh>
In-Reply-To: <2024062717-foster-document-eb2f@gregkh>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 27 Jun 2024 17:57:30 +0300
Message-ID: <CAA8EJprAshnt3YchBv0ssi4Vet9b6oMcf3z8nuRkoZVYNBq64w@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] usb: typec: ucsi: rework glue driver interface
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Nikita Travkin <nikita@trvn.ru>, Neil Armstrong <neil.armstrong@linaro.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Jun 2024 at 17:54, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jun 27, 2024 at 05:44:39PM +0300, Dmitry Baryshkov wrote:
> > The interface between UCSI and the glue driver is very low-level. It
> > allows reading the UCSI data from any offset (but in reality the UCSI
> > driver reads only VERSION, CCI an MESSAGE_IN data). All event handling
> > is to be done by the glue driver (which already resulted in several
> > similar-but-slightly different implementations). It leaves no place to
> > optimize the write-read-read sequence for the command execution (which
> > might be beneficial for some of the drivers), etc.
> >
> > The patchseries attempts to restructure the UCSI glue driver interface
> > in order to provide sensible operations instead of a low-level read /
> > write calls.
> >
> > If this approach is found to be acceptable, I plan to further rework the
> > command interface, moving reading CCI and MESSAGE_IN to the common
> > control code, which should simplify driver's implementation and remove
> > necessity to split quirks between sync_control and read_message_in e.g.
> > as implemented in the ucsi_ccg.c.
> >
> > Note, the series was tested only on the ucsi_glink platforms. Further
> > testing is appreciated.
> >
> > Depends: [1], [2]
> >
> > [1] https://lore.kernel.org/linux-usb/20240612124656.2305603-1-fabrice.gasnier@foss.st.com/
> >
> > [2] https://lore.kernel.org/linux-usb/20240621-ucsi-yoga-ec-driver-v8-1-e03f3536b8c6@linaro.org/
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> > Changes in v4:
> > - Rebased on top of Greg's tree to resolve conflicts.
>
> Nope, still got conflicts, are you sure you updated properly?  Patch 1
> applied, but #2 did not.

I feel stupid enough now. I rebased on top of usb-next instead of
usb-testing. Let me spam it once again


-- 
With best wishes
Dmitry

