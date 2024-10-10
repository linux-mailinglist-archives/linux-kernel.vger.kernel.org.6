Return-Path: <linux-kernel+bounces-360156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A68D899953A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 00:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5251F254DC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 22:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6E01E7C34;
	Thu, 10 Oct 2024 22:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PE6M7PAN"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C431E7C21
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 22:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728599425; cv=none; b=LikqY9XJPBDTfn5UXYslDkPtnUmJZZh4Re5PPiqC9/yVoK8vi0A41aG5UVMv3TlKz1S6ijvAL3u0j0w3Tz5A6YwqymzkIL5K443s+uWITdo8qY+Ak/3eZr142QJd7V8M4iY5fyWMXni1T52Jo40vUw0vhngMExYS5o8/PRyMdgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728599425; c=relaxed/simple;
	bh=CdmSXbDHAWq8dgUJmRamn05jbHQQT0TVNYOiCJ/xXdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krs9dulIJ3vIi3gfPyRKSIGqL58dvS3c/EP98134tnouLm2V7mu3nFdEyRAPgsQDTT/gF/UgbqDcGiCqpjKxtdBNRqoY+XLppVNeZkgHruUIHRtB3Rya77mmobt35nfm7CpV8YxNB7LclnIsSypFUTNSoKOGpEfihX/YLPoAh3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PE6M7PAN; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9951fba3b4so222652566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 15:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728599420; x=1729204220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tjzEcZp4sdEI4rizDgYHU+pcwb4fTKSCVr7AMb0oZQ=;
        b=PE6M7PANLNqAMURMXJVBC6WFAs2aw1PLurVOSZmQkQgRx+Xdx4vlMg298jctGcPQsM
         FUco1B4ECmWEy9bUWmMw8LK1jkBY2QH+LivIYiKw596AwOTsVPztvNGeD6rIVX/axi3r
         o58Lj/WGgPRuahBCl5exBJRntoKgTjIb2SAUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728599420; x=1729204220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tjzEcZp4sdEI4rizDgYHU+pcwb4fTKSCVr7AMb0oZQ=;
        b=ZwuQHdqGzHpRovy6RK5p+4jk66NkvOfffGKny/AsvPo5RQJ/CtYx3rjWGP95uPzLjf
         EDI+fwLvUGncWiK4P6KNBEjj6hDmQ+QqEQJXREbf6BhrLVitNZbMYzzNdqCY1taV2RFX
         m9Uj7uykbw0P2BOIh18dJ9/N7iyiljQZeDtJgV3XebEnvFc6VJYTYkGWUDLtXigVKxCX
         RtZAf62Df81NYXI78enM9aXlfPJfPG0/gYifIe35QpRVJf9zELo+148vsAeke4QK+rdP
         mP39P9UioK1KIKkcEQagZpwWde3BoAunLXeWHTxlphcQ2JQ36xrg9rNu6Hz8EfzzGkRI
         nrNQ==
X-Forwarded-Encrypted: i=1; AJvYcCV985RSexVkidcyBI7ZfqC3WWMYrDxMeDnlWZY824t6fsR+sjUqPmtspLAwHNOsLFSSu9Mnwp4fzkR4O9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqZ+BmE02Ia2H8zmDaJue7T+/+TzGbOOEQ18v5+9hogIbb3aZG
	q6UPMd7DZd8phv58hAbVdCDGOyN1vN+PLNF8nS0RAf1KJog7gx8lfzu9rR1YrC0HtzR4Nx3CCAF
	9fg==
X-Google-Smtp-Source: AGHT+IE0ndBjMuw4ngL24X565wahV9fh2HhhGe/aJCstNFYhOeGZTqB3RNAaVA/FKobAuNKPXPjJ2w==
X-Received: by 2002:a17:907:e65c:b0:a8d:fa3:bb24 with SMTP id a640c23a62f3a-a99b95a5b39mr37651266b.23.1728599420146;
        Thu, 10 Oct 2024 15:30:20 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80bfc47sm142625166b.107.2024.10.10.15.30.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 15:30:18 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d538fe5f2so253392f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 15:30:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXUb9AHXPCHxhZfEwH80YQCKiP9K7nOuLwq3Lj8McBe0wEMIOapzfRB409TTGrmXDMpMkYqiMHHD6UjzIg=@vger.kernel.org
X-Received: by 2002:a05:6000:181a:b0:37c:cd1d:b87e with SMTP id
 ffacd0b85a97d-37d551d50a7mr437367f8f.18.1728599418059; Thu, 10 Oct 2024
 15:30:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001125033.10625-1-johan+linaro@kernel.org>
 <20241001125033.10625-3-johan+linaro@kernel.org> <CAD=FV=UoU5Nd7sW66cjQzor+BP+W_f7uw0MGRaF6y7PH7KRN_g@mail.gmail.com>
 <ZwaO0hCKdPpojvnn@hovoldconsulting.com>
In-Reply-To: <ZwaO0hCKdPpojvnn@hovoldconsulting.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 10 Oct 2024 15:30:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UZtZ1-0SkN2sOMp6YdU02em_RnK85Heg5z0jkH4U30eQ@mail.gmail.com>
Message-ID: <CAD=FV=UZtZ1-0SkN2sOMp6YdU02em_RnK85Heg5z0jkH4U30eQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] serial: qcom-geni: fix shutdown race
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, stable@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 9, 2024 at 7:10=E2=80=AFAM Johan Hovold <johan@kernel.org> wrot=
e:
>
> On Thu, Oct 03, 2024 at 11:30:08AM -0700, Doug Anderson wrote:
> > On Tue, Oct 1, 2024 at 5:51=E2=80=AFAM Johan Hovold <johan+linaro@kerne=
l.org> wrote:
> > >
> > > A commit adding back the stopping of tx on port shutdown failed to ad=
d
> > > back the locking which had also been removed by commit e83766334f96
> > > ("tty: serial: qcom_geni_serial: No need to stop tx/rx on UART
> > > shutdown").
> >
> > Hmmm, when I look at that commit it makes me think that the problem
> > that commit e83766334f96 ("tty: serial: qcom_geni_serial: No need to
> > stop tx/rx on UART shutdown") was fixing was re-introduced by commit
> > d8aca2f96813 ("tty: serial: qcom-geni-serial: stop operations in
> > progress at shutdown"). ...and indeed, it was. :(
> >
> > I can't interact with kgdb if I do this:
> >
> > 1. ssh over to DUT
> > 2. Kill the console process (on ChromeOS stop console-ttyMSM0)
> > 3. Drop in the debugger (echo g > /proc/sysrq-trigger)
>
> Yeah, don't do that then. ;)

The problem is, I don't always have a choice. As talked about in the
message of commit e83766334f96 ("tty: serial: qcom_geni_serial: No
need to stop tx/rx on UART shutdown"), the above steps attempt to
simulate what happened organically: a crash in late shutdown. During
shutdown the agetty has been killed by the init system and I don't
have a choice about it. If I get a kernel crash then (which isn't
uncommon since shutdown code tends to trigger seldom-used code paths)
then I can't debug it. :(

We need to fix this.


> Not sure how your "console process" works, but this should only happen
> if you do not enable the serial console (console=3DttyMSM0) and then try
> to use a polled console (as enabling the console will prevent port
> shutdown from being called).

That simply doesn't seem to be the case for me. The port shutdown
seems to be called. To confirm, I put a printout at the start of
qcom_geni_serial_shutdown(). I see in my /proc/cmdline:

console=3DttyMSM0,115200n8

...and I indeed verify that I see console messages on my UART. I then run:

stop console-ttyMSM0

...and I see on the UART:

[   92.916964] DOUG: qcom_geni_serial_shutdown
[   92.922703] init: console-ttyMSM0 main process (611) killed by TERM sign=
al

Console messages keep coming out the UART even though the agetty isn't
there. Now I (via ssh) drop into the debugger:

echo g > /proc/sysrq-trigger

I see the "kgdb" prompt but I can't interact with it because
qcom_geni_serial_shutdown() stopped RX.


-Doug

