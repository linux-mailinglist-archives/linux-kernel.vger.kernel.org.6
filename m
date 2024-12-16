Return-Path: <linux-kernel+bounces-448033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D349F3A1C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ABE716CCDA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EBB20C49C;
	Mon, 16 Dec 2024 19:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZFPw3/76"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD0414A4D4
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 19:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734378382; cv=none; b=NiUQ+p8JX6fjCVtxHWlW4xSRHWzrQU9vKGbYwYukE3jS27DMkfZh+96WMqOcczACxgY8r609UZx8XPosjlrd3oa5vABynN6aVUrcHu11V0kJ4syH867GUNCm8IjXaz2nzyJkdkglyexRd8GF+gf4U5VxEfQYyqhr9Ddycfrk1lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734378382; c=relaxed/simple;
	bh=j6tAfhrAKfM+BxyKJyBCAECpbjqe9JSVwIYSxNWXM9A=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hKEFJdFG6aaBCjUwiD+ipkLHwo5LH4pdH+Rjk7D6vqBKdyLN+gvRZ0vy/3mzVd5OEmJJ1dSTQA/sem+Xw2b6XVp9ioTjgRl4acMceUxaFggxqnGSpyl0v7HWqtsKXwXet1iPRjxAQm/HrEBvGFBFvwLHy34iwaILExGxqwoI028=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZFPw3/76; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4679d366adeso42902121cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734378378; x=1734983178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dj4MkECiGqrOXQxpuQLD4yCOwjnhMEXT22q3KbMrq/k=;
        b=ZFPw3/76A+yR8hZsJ8MPg7v6Y914MtWiHLvgR2dCVYvNOlQm3YOkHnDApNm+AyVb05
         N8d5RsgitKo2TLqOehTerc1s26A/3RVTI+PiXCEGUXy7Lv8t8ys4eeQGx0ZQFblvtdgg
         iKwS9hZQqj9fk6Ezreu+1DgCvPYCxPj/Mgrek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734378378; x=1734983178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dj4MkECiGqrOXQxpuQLD4yCOwjnhMEXT22q3KbMrq/k=;
        b=RdHDts1R3xiO7MFwJ1XCIoCwWkgIOVw5m7DKecfbwdf4aVRyZq8htXrNSzhoqmx8sP
         g3NM1VUOdX7fvJZGRTGjUPf4Wt4e2/wWC7fvzcoHIteuY+GtfK3Wt9s16raGpgrVi06y
         AywgvjqntueR+7Yx2Zp/xR63GwKYiOhr3pxFpw3LfDQTNmozmypEzyYFDk08KCJ6wHus
         VqCS8x8ubgI4VVXWEC/7disn0m6TvFItFGVN/Jo2N68rFKMS6Rg6nOoFBR/0eRHWqfJV
         YfwtaSGLfPZ2FCoZaoMZRCx5jQ3Iv/5ge02fHvYC3CNKBq99/GpZJaUKPDP4C+XBz+62
         7E1g==
X-Forwarded-Encrypted: i=1; AJvYcCVO4hlFmPcTj2scJIbNwaRvqnKa8+YzXpkFZn6f9g8hZwQEsG5vfFasj205HpYvOibG7Nfmj1acZ7f1sFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBM9/UEICGitkQ+nP9n6QCi5H2Yy4GFIlkzbQeEXBnnITv5tjI
	QWQLPL/3uiK/RcvgkzT9FNzrFLm4U3+rT+FKA40X5zSGn6tpAU/Ibj1MxVXnzOsC9kBNbdM6u29
	QxUM63fHqp1YKGF4J5n6/RKfjCMRfjau88TGm
X-Gm-Gg: ASbGncvjDiRldLUdLt+GyS5o+gjVnNuocLeIttpH0Kp/EHqg6l511g2gNbpHAwDh+OL
	fcOAx+RzEd6WapS54SPPr4voibuHOxU8gEe9XdluQXVzsuhEvzUIMbz/svuwku+RMbw==
X-Google-Smtp-Source: AGHT+IHGV/UEHN7glrKn45Rm7GMxGUJA8r5aYXDp4ruex87I6ZIK8597fD+gsMJMcB3UPXYWmc3P1FV2kT6S+lFHJd4=
X-Received: by 2002:ac8:5a50:0:b0:467:72c1:7084 with SMTP id
 d75a77b69052e-468f8c06fc3mr12036341cf.0.1734378378091; Mon, 16 Dec 2024
 11:46:18 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Dec 2024 11:46:16 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANFp7mU=wjXc6FrdzWT5oe25wtZnxOXvpVmbMqeVhOeEUchpcA@mail.gmail.com>
References: <20241206233830.2401638-1-abhishekpandit@chromium.org>
 <20241206153813.v4.5.I142fc0c09df58689b98f0cebf1c5e48b9d4fa800@changeid>
 <CAE-0n513GoDKW7mA_rjCLsgZZFq=CEb5S8WLYr2rskq8fJW9LA@mail.gmail.com> <CANFp7mU=wjXc6FrdzWT5oe25wtZnxOXvpVmbMqeVhOeEUchpcA@mail.gmail.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Mon, 16 Dec 2024 11:46:16 -0800
Message-ID: <CAE-0n52dZONV2Fj=N4f85ttGRg+yyvOSXQoD50oFc9B7LBgtPA@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] platform/chrome: cros_ec_typec: Displayport support
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: chrome-platform@lists.linux.dev, heikki.krogerus@linux.intel.com, 
	linux-usb@vger.kernel.org, tzungbi@kernel.org, akuchynski@google.com, 
	pmalani@chromium.org, jthies@google.com, dmitry.baryshkov@linaro.org, 
	badhri@google.com, rdbabiera@google.com, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Quoting Abhishek Pandit-Subedi (2024-12-13 10:29:51)
> On Tue, Dec 10, 2024 at 4:08=E2=80=AFPM Stephen Boyd <swboyd@chromium.org=
> wrote:
> >
> > Quoting Abhishek Pandit-Subedi (2024-12-06 15:38:16)
> > > diff --git a/drivers/platform/chrome/cros_typec_altmode.c b/drivers/p=
latform/chrome/cros_typec_altmode.c
> > > new file mode 100644
> > > index 000000000000..bb7c7ad2ff6e
> > > --- /dev/null
> > > +++ b/drivers/platform/chrome/cros_typec_altmode.c
> > > @@ -0,0 +1,281 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Alt-mode implementation on ChromeOS EC.
> > > + *
> > > + * Copyright 2024 Google LLC
> > > + * Author: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > > + */
> > > +#include "cros_ec_typec.h"
> > > +
> > > +#include <linux/usb/typec_dp.h>
> > > +#include <linux/usb/pd_vdo.h>
> >
> > Please include workqueue.h, mutex.h, etc. for things used in this file.
> Done. Btw, is there a script that does this for you in the kernel like
> include-what-you-use does for userspace?

I'm not aware of one.

>
> >
> > > +
> > > +#include "cros_typec_altmode.h"
> > > +
> > > +struct cros_typec_altmode_data {
> > > +       struct work_struct work;
> > > +       struct cros_typec_port *port;
> > > +       struct typec_altmode *alt;
> > > +       bool ap_mode_entry;
> >
> > The UCSI driver (drivers/usb/typec/ucsi/displayport.c) calls this
> > 'override', can it be named the same thing? I also see that the UCSI
> > driver has two bools, 'override' and 'initialized', which seems to be t=
o
> > support a DP_CMD_CONFIGURE that will respond with an ACK and then the
> > next DP_CMD_CONFIGURE will call ucsi_altmode_update_active() to set the
> > altmode as active. Maybe the same method can be followed here so that o=
n
> > older chromebooks where EC is in control of mode entry we can emulate
> > entering the mode?
>
> The reason it's called `override` in UCSI is because the feature is
> called "alternate mode override supported". When this optional bit is
> set, the UCSI method "SET_NEW_CAM" can be used to change what
> alternate mode is active. However, it behaves differently from cros_ec
> because even when override is set, the PD controller can/will still
> autonomously enter a mode on connection. Whereas on cros_ec_typec, if
> you set "ap-driven-mode", the EC will not enter any modes until the AP
> tells it to.

Ok, got it.

>
> Also, the reason the UCSI driver does the DP_CMD_CONFIGURE dance is
> because the UCSI command, SET_NEW_CAM, requires the DP configuration
> VDO as a parameter. Since UCSI doesn't define a VDM mechanism, the
> UCSI driver fakes the ".entry" call and then uses the first
> DP_CONFIGURE to do the actual entry. This also doesn't match the
> cros_ec driver (either ap-driven or not) because the interface does
> not allow setting the DP VDO at all. DP_CONFIGURE will be generated
> and consumed entirely within the EC and all we can really use is the
> mux update to generate a status update for the DP state machine.

Is the 'initialized' dance the fake ".entry"? I want the not ap-driven
(ec-driven?) mode to work with this series, and specifically not print
an error message. I'm guessing that to do that we should fake ".entry"
when the EC is in control of the mode entry. Or is there some way to
jump the state machine forward for the port altmode so that it is
already entered? I think to get the device to show the pin configuration
and mode like "source" vs. "sink" or "usb" we need to spoof multiple
VDMs.

>
> Right now, EC driven Chromebooks will simply report active/inactive
> for DP without reporting any configuration/status info. If you want to
> handle DP_CONFIGURE and DP_STATUS from the altmode driver, you'll need
> to fake the interactions in the port driver in a subsequent CL.
>

Ok. I'd very much like to do that because I need to make the displayport
partner altmode driver work to the point that it calls
drm_connector_oob_hotplug_event(). Do we need to spoof a
DP_CMD_STATUS_UPDATE on mode entry when the EC indicates that DP mode is
entered on a port?

