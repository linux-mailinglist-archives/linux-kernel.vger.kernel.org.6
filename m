Return-Path: <linux-kernel+bounces-315217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA0F96BF6C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 884C2284C2A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0931DC197;
	Wed,  4 Sep 2024 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHV4D2iS"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB9D1DA63C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458344; cv=none; b=RRr9s7hV7VtPhJsSgPkdWGXbbsCWQi40MFhZzgHOWq/rDIyZiThmSfdzrjSz9RMOg8TpJlTPm18Xe6sKm2aIl7FHULNMVXUhvBLGNzlBHQ3PA38pOvmRNwgC5JHg8K2wng+NqFyyr+L4BSl2JEddlEXfOu2y0+FyBharBMe/iBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458344; c=relaxed/simple;
	bh=+so5CZnciMlghWMsUtQFjbbv+X+va7E/m4rVancRyYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDG1I0HUeibbNTHuUASL/bG7Phe04B8VZxlQb8Ns7x9gIGMobE9Gg5jBxAX7wqNSE4MGVNdCnAlHb2tvIoYzvnOBqB4PU6rLr3mLWkEXvSOdvFjavZ0kvRL6wLnrchi9G/nCDV3NCkuXNWzCMSyEI3I2lkrBy5hYJFgGajEjce4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHV4D2iS; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7c691c8f8dcso4405423a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 06:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725458342; x=1726063142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzuwZB67ZbwvVWHFNySgXsna3DJdJL1ydfHKd6Q8NCg=;
        b=AHV4D2iSlIWn2WhDmuSgAsEEEhgRvH9jNsUwaJljlj9ky4YCbdSvzwVrqDy3j9v7Ck
         IpU6Vq4snCrFKU65uxvah+NSjiykiWM3xYTjp1YoDuEQwxgOA2i2b42XIxYqSr09Ev66
         Z3NcAmiNq/5+fHu4O0aQ7M96+RLCIZTw8oXgTFGORqKzVhhmyoYgE6LXydMtxLgOqyuk
         fCkePbtM1uSa3w/gSjYmkfBc2UT0Yf+PajalGqu+gYjlMpmmeianbFSmSciB9iuepx60
         /JSO+gv4dZ5Tlk38UQSMIf+5tqhWqKLFf8MnfVhCoipCvKuwOG4V63i6i8ha5AzfeF60
         VM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725458342; x=1726063142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzuwZB67ZbwvVWHFNySgXsna3DJdJL1ydfHKd6Q8NCg=;
        b=dAvt2QWOhjqx3ilbTd0B9wS+DziERY5+QAH8N6ok8UmgmZZu9HgLxOEBeC75woFlHd
         g3k1VAH0fgoGr/Tm4eRHxT4KdJ7Z1i0qmsqu7MCA1P3NO+79uLB52IH4BkOGNKmGAkEl
         Kbx7gI3/blWEaMU8jEz7g+1hjySiebVy1lCL8Hda14S8ZP2cR4UhOIPFZvvJZbDHOJs4
         xNc6XlajOluvdGOAtEMqy+ti/E89AmJ0EKmbTTGfCMaBUi6j3ApDzVy2Xqm+miKiSJUn
         dEC45cfRmOv1NN3bxTtI58AB0q6YxnhpqWOCf68CIn4GkGfNIlNVtZz9QF7SoeDDiPIg
         2iXQ==
X-Forwarded-Encrypted: i=1; AJvYcCViUB5FLy5RMj0Gy037h/+cFHGVVqAqxx+iH1/vswQMrXgBJfg2CnpEg/ojDYnnOD07PCvi5rtVJrveznw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRDPSdC0GwWU4+rx8SWpMOVkNQT7e30u0Xy3Oww36UK0f3G+uL
	kRRccB5t05SG7x+fNGClsMkIqDhgM45F8tBKkmsycsNRghGNrQVsDFqqC4SULdWnSkUV8ySEpx7
	X9h8p6pYCa0V4WcDiyIINqIGY948=
X-Google-Smtp-Source: AGHT+IFGaTS6SArCxsht9wBh1wBBVhXDuNFvzg032SF31OvneM8th456sv9jYelC6Dp4w0RZDRBdpp7MFDBCEaz5R8Y=
X-Received: by 2002:a05:6a21:4603:b0:1cc:d4c1:29c5 with SMTP id
 adf61e73a8af0-1cece4fcf0cmr15357342637.12.1725458341812; Wed, 04 Sep 2024
 06:59:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904023310.163371-1-aford173@gmail.com> <20240904023310.163371-6-aford173@gmail.com>
 <727803d7-2b0a-449b-97bc-b18fe2378a38@kontron.de>
In-Reply-To: <727803d7-2b0a-449b-97bc-b18fe2378a38@kontron.de>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 4 Sep 2024 08:58:50 -0500
Message-ID: <CAHCN7xL1rgnD_Amebnf+Mx4RrSkGM4+0LxbPSYqwVWT0VHAc0w@mail.gmail.com>
Subject: Re: [PATCH V5 5/5] phy: freescale: fsl-samsung-hdmi: Remove
 unnecessary LUT entries
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: linux-phy@lists.infradead.org, dominique.martinet@atmark-techno.com, 
	linux-imx@nxp.com, festevam@gmail.com, aford@beaconembedded.com, 
	Sandor.yu@nxp.com, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Marco Felsch <m.felsch@pengutronix.de>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 8:44=E2=80=AFAM Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:
>
> On 04.09.24 4:32 AM, Adam Ford wrote:
> > The lookup table contains entries which use the integer divider
> > instead of just the fractional divider.  Since the set and round
>
>                                           ^ unneeded whitespace
>
> > functions check both the integer divider values and the LUT values,
> > it's no longer necessary to keep the integer divder values in the,
>
>                                                ^ divider        ^ table?
> > as they are able to by dynamically calcuated.
>
>           ^ can be calculated dynamically.
>

Wow, I must have been really tired when I wrote this.  I promise that
I wasn't drinking.  :-)

I will fix and proof-read my comments in the V6.  :-)


adam
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
>
> With commit message fixed:
>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>

