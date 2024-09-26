Return-Path: <linux-kernel+bounces-340440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB160987373
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 564A61F273A4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484AF178362;
	Thu, 26 Sep 2024 12:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JOjTuC4P"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D41114E2CF
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727353231; cv=none; b=aRvwkvo2VFSy5MtR2ol+SewNe5KgLkuY5TkE/H/nBKCXV2AYHeWHQ5/PSxZVUl9KUZ5XeUziyMoMXpq8YycJwOJiLINQmhlEe6FVvcoiWuNqJMNPrCbWalLkuZEu3kvCSoRy1Pqo5YrDRW6qgm8hZInozOr7xBRQZkke8/XPX/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727353231; c=relaxed/simple;
	bh=vOTpzB5vd/CwIsuye/jBaiRBDbMI1JUdjxFFIctmwEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MV+FDqIVJl/51XeqXTsm1IL8ts4CsRIbASgOMSw4jmgFqedfVvbAxEaa74u6Cvk/MMqW8nyULiv3Td6HtZcS5Wm7RiRSoiphe4HRcpQyApMESI0hLyDl1ad3uemS6xfMEimhsBW5tTZ50/G7KTLFyxHktEE4Z+q2wwd7U6gfdvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JOjTuC4P; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e25c5ed057dso917536276.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 05:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727353229; x=1727958029; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/chIijZxfaJZTmXeHsE7W1Ywlan6j7i6j6yboptQjwE=;
        b=JOjTuC4Pg3j/gHHx9Uy+VfdebUOaxqcoEbibnDgwFfk9/CpyX6esgGmH9oHWNriWwZ
         tpYwRVh+cYtx2TxWAEoZBuHlgurVXYQ0HlAq4VhmWRqX1VYj/aqJc40inEZ8SAG5bh2e
         sCZT+gmzPRTfee6eXi2UwDxZpjR+V5SBJXPOdWwqSadizel+jfiPCzgpZGrjB6TmRiGo
         h7C3KicEWiDV4NQWpqBnGU1POP07aw5T+J7sBu47ZTMsLSkZZPvH0bXsSHUjh2cSGgqL
         XCbQ2+brdwq9U66sbzQIF9Gk6kQskpCsfxScVeGw80LPW9oV8JNNK04ZUm+G9pXlTnUA
         pMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727353229; x=1727958029;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/chIijZxfaJZTmXeHsE7W1Ywlan6j7i6j6yboptQjwE=;
        b=jAdqQ1OEjF4bdK8I0WNxC+DY7L1VtlE8v1evh5L8tQP+y+boDYCTxU7dUu6c1hS44Z
         1JlSKNAdIMNmM82P29uH8kJ+uVu6vr0BR9av+FSgmj5YaqNhh4MTU2RJKNbYgzK5gxxr
         NfW4rL3SgNjhSYarSW3eSMItqO5DgfSFKLTqE02dIbpat6ydNiB+SAD13QPKd62+4Q/3
         RnbPhfG8I3InB59Vm/vpbZcsUv5+sVKEeFZzfgDMWnplTc9aesiW8DQeKULTeKi4Uiil
         StThqh5vu0QbN/Wqjc12/0V2KQADKj+32HETp2uTmJlgl0fDpoPw1bpEqh7jCHvt2MQ3
         QNTA==
X-Forwarded-Encrypted: i=1; AJvYcCX5sud4xpRhimP5l8XuyR4BdRz9Vhs/hcCvQkf30CLfhcheSw1x2gHwlXYRded7OJrWk4GPdV7ay2uZiNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3R2wukiy9bKG/NrxSy7SHqV7i4SF8N8NucNeMLV5RozckCRjM
	vlSsF2AdkiHEZkI4zMW2oCxITfKcRtSMiEhuzHBlTvbFAp0XbUDQvWUBiEZNRlnOUcjmbvJLVa9
	9I7OoB1bEtzZG+xhoNwZr754RRdfjDQi0kiheRg==
X-Google-Smtp-Source: AGHT+IFYe6avJXcb20Z3oY/wCbFOgqRRn6CzbS+mU2MwuBkHglhoEJHCWq1HMAvQiZOvmabxdtU+nRUUoxytEl305oc=
X-Received: by 2002:a05:690c:5c03:b0:6b5:5042:2c9d with SMTP id
 00721157ae682-6e21d848317mr47670397b3.24.1727353229221; Thu, 26 Sep 2024
 05:20:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b890361e-e99b-43da-8571-7478b5eab475@web.de> <jjsbnitbajdw7dc4plkbb55ezl2cdbnrfws7hnoigbzasvdzua@puhrwwlu4lvv>
 <ZvVPlInCFajkeFy9@smile.fi.intel.com>
In-Reply-To: <ZvVPlInCFajkeFy9@smile.fi.intel.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 26 Sep 2024 14:20:19 +0200
Message-ID: <CAA8EJpo0Q0Wn-GzqmPeNFfG_Hr-o8E7F_VuO47EbxKx=0OQhyQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] usb: typec: ucsi: ccg: Adjustments for common code in
 two functions
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, linux-usb@vger.kernel.org, 
	Ajay Gupta <ajayg@nvidia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Haotien Hsu <haotienh@nvidia.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Utkarsh Patel <utkarsh.h.patel@intel.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Wolfram Sang <wsa@the-dreams.de>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Sept 2024 at 14:12, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Sep 26, 2024 at 12:26:24AM +0300, Dmitry Baryshkov wrote:
> > On Wed, Sep 25, 2024 at 07:31:04PM GMT, Markus Elfring wrote:
> > > From: Markus Elfring <elfring@users.sourceforge.net>
> > > Date: Wed, 25 Sep 2024 19:19:01 +0200
> > >
> > > A few update suggestions were taken into account
> > > from static source code analysis.
> > >
> > > Markus Elfring (2):
> > >   Use common code in ccg_write()
> > >   Use common code in ccg_read()
> > >
> > >  drivers/usb/typec/ucsi/ucsi_ccg.c | 15 ++++++++-------
> > >  1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > For the series:
> >
> > Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
> I believe there is no-one to take it,

I guessed so.

> but in any case the thing is that kfree()
> probably can be done using __free(). Then PM runtime handled differently.

That's a separate cleanup in my opinion.

-- 
With best wishes
Dmitry

