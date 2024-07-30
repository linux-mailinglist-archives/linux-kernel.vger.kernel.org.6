Return-Path: <linux-kernel+bounces-267044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4724C940BB5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C65A0B23B90
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406A8194AC1;
	Tue, 30 Jul 2024 08:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HkAvdWRk"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01071922F3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722328192; cv=none; b=PcpHHI026mwJP437RnFRevC+h8CKPBP89DlXEZbMjffXvQapwtZxY9Ty+HKQXIgRk0nlbTNFjujfvK47hpB5y8Cr92gJo1b8zWhdR6SwXHoOAaL17QAv4V+NTbkM0D6kfY7sEPM0Zk+D2wbmGM957CRuUdwoHsWnByVgkbEGbjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722328192; c=relaxed/simple;
	bh=uEjRig76MWzeTHtFr46u/rAVO/lVm1Zjrac7c3up3Jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hwzkLAtlARGVqLA3M2Uv/Ujde5PGdivDLr/vBotZ8nO263LnzlSj/zoG9fO532nE/2tfzMcHEm9ubltheSNl6QaEoUyLYOjTPiX3+l1KXMuvYoSyz/vPXBN11NNrofDOS7GLd7BRUUGDoOQxiCDJqwUliRtt9RTGMuTwEETFhQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HkAvdWRk; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-58f9874aeb4so5737987a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 01:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722328189; x=1722932989; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bvctSTCxXDG9vkXCPJRFSO2OwM56i0h+SX57avLe2Sg=;
        b=HkAvdWRk9qMB+6bQbKXhI/MuxEMCb1mHkyndGvAxk6ZMyfF2la4iH3QRIQAWsHhcac
         73NFoxcaK+bWDBjr5v38SPyODp2GXJMiGzeLQqIviNtJRJvutWTsxSMXl10hJhq2iLKn
         jC4kuKAjG4009mo+VGMALmIq/SCcfv56HKtU9cL7f+qH/EZDtIg2/ZgLex+6OooSXmWm
         qqh4g+aHpJKO/KHDxKkWaxbge8Ena2QVzaiFSfJRCpRAHvOp9w3BIY7FERh3lTRVbxdt
         7WpUzeDnK7htlf+/EPypzmywgUR3ulr7aOxclhMSSHo/L/ObTKhu5TnymwkvMJIoeCu1
         5klQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722328189; x=1722932989;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bvctSTCxXDG9vkXCPJRFSO2OwM56i0h+SX57avLe2Sg=;
        b=CSuxrbmUZtgAvVfZqKFQLxBJa7sW5gNYL9zxt9nHI772smVZi82qOhc5IXQlv9ntzj
         RZUORObIMpqKFxbqCbtIZTqbACOPUDAOr1zI+Prf/awYNG07Xkmhk4JjUOQCJpQ0bM96
         Hjs+taXos9CrVm86eWhkDQykKXjwFppyHR5wg8hgd0+Hy98Au/1gnRh7knKpw0n0k4J0
         cT6yXz32/R+1Nf1AokChX1p6KT0E6IJnhnuW/u225uJDFaySrtnj48rqZm8Vcsn47LGE
         ccb8S7ihWaLI/RBKH/Uas+HvfjWGz2xVSM0PjBraVdXI0IJrtFtDOT79fNxyeB2hwYzF
         5WdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgjs1QNFsOn12F+PrmTrZwpcjc020Wzcql2KLDH87mhmTvL1vfiMGneB+qpusjJ2c/hXjo8D9eX6IqSn7AFnMOIf75yqwXj/t+0Fqm
X-Gm-Message-State: AOJu0YzKJRnCZGELJavbMCV1LzmxQH+WgfcLLKSYof3Jo13MgIXPwpDB
	C1pdgKb7gG0oHEjivi2EtUkRdyHwRek1Nw8/xo9TaGjCWvd3hC1s08FPqW61IGMrBsbl8T3GgDk
	5cpr9NsUbaMFWN9FfHeqxsVV+DNt2wjMktjXKXQ==
X-Google-Smtp-Source: AGHT+IErCc8jLnL94ZNnMfdPeD4RlLQ0Wtssx5HIgjIRj8h1yZKWV6ZokNRGFXEBilq3W+viB6Om7wZ7Cday52qL5Gg=
X-Received: by 2002:a50:a411:0:b0:5a1:7d68:62d8 with SMTP id
 4fb4d7f45d1cf-5b022c81f43mr5928071a12.38.1722328188753; Tue, 30 Jul 2024
 01:29:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
 <bf8367bddfdc95e378b5725c732533c3ba20d388.1721630625.git.mchehab+huawei@kernel.org>
 <20240730092549.6898ff3c@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240730092549.6898ff3c@imammedo.users.ipa.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jul 2024 09:29:37 +0100
Message-ID: <CAFEAcA8VWc3eQZqfJP9k5LYF-9aLChHQ+uS9UBfGV6nvybDxqQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] arm/virt: place power button pin number on a define
To: Igor Mammedov <imammedo@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
	Shannon Zhao <shannon.zhaosl@gmail.com>, linux-kernel@vger.kernel.org, 
	qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jul 2024 at 08:26, Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Mon, 22 Jul 2024 08:45:53 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
>
> > Having magic numbers inside the code is not a good idea, as it
> > is error-prone. So, instead, create a macro with the number
> > definition.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index b0c68d66a345..c99c8b1713c6 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -1004,7 +1004,7 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
> >      if (s->acpi_dev) {
> >          acpi_send_event(s->acpi_dev, ACPI_POWER_DOWN_STATUS);
> >      } else {
> > -        /* use gpio Pin 3 for power button event */
> > +        /* use gpio Pin for power button event */
> >          qemu_set_irq(qdev_get_gpio_in(gpio_key_dev, 0), 1);
>
> /me confused, it was saying Pin 3 but is passing 0 as argument where as elsewhere
> you are passing 3. Is this a bug?

No. The gpio_key_dev is a gpio-key device which has one
input (which you assert to "press the key") and one output,
which goes high when the key is pressed and then falls
100ms later. The virt board wires up the output of the
gpio-key device to input 3 on the PL061 GPIO controller.
(This happens in create_gpio_keys().) So the code is correct
to assert input 0 on the gpio-key device and the comment
isn't wrong that this results in GPIO pin 3 being asserted:
the link is just indirect.

thanks
-- PMM

