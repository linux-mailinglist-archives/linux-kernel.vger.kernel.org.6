Return-Path: <linux-kernel+bounces-347164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616B698CED7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D3A1C211DE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1556B195F3B;
	Wed,  2 Oct 2024 08:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ZQT3jP/E"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE4D194C67
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 08:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727858214; cv=none; b=CpkYVWPqemxrhzCs/hKbQcxbHaHwdIdglw9rRmZW3uPr8O/cRZ4Zbtl5sSjZXQOC93exiJ+P8wXQt9rkIZ7NIbw/pTAFQAL5q2eUYl1acDlQHxzg9wDNbhlUdPDZ+GzefBWubN7vFOjElJSpvMpgRIQcjp9e2HDSNVYodzqiTcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727858214; c=relaxed/simple;
	bh=Kz1UVtOUTVUjEIHMrXYuXMpSckfGWVji2w2c3RF+s3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ang00WsQEjKlb61z5fiz+VbJTDfAuFKpngndt9Y3jSk4bMlPJ4Ddr/EAPML2lD0x7+LYWfp1lR7J5gAyfChXkormYU4DnUqCn14SyKSZurAsx6xljdB834Twv5vVrRsLuXctBJSL5wpRUm0YIm64N7udkw6DhDSyDpAAHvsyOGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ZQT3jP/E; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539908f238fso4008321e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 01:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727858210; x=1728463010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCwGxVwnX05r3odrsF+5f2+QdmRHgG0vxcWaDgA3/HY=;
        b=ZQT3jP/EJ1hr+8v37uN/X3KmiGUsqIf9xRoECfFWmKEqVBLqIwPGYYZGU7HMDJHVwK
         pVbUXtjC2k0z3I7RBdJESOgbXP0QTDq3dhbQBvwfF3K5xTjpuoN7Abx63U6lD4lfzAGM
         AlvfylzUzYr5KNWWsr58qtJbNWKJPYrdEkwzPI4sVZJ3GSDXu27O1ncHIuDpmQnx415w
         Z2ySQCRSdC5rWWjqhf38QGVzZwbvYQULQO/FEZ2GzqLuiuk/wSKXyH/yLpzn8H/zdz/o
         t13rkZlDE6yGX8E8uU/vB/fNSUzN01QrgEBcYqir9bKlBaYLfUQ6svhB7tgWt+4tQtBS
         BYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727858210; x=1728463010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCwGxVwnX05r3odrsF+5f2+QdmRHgG0vxcWaDgA3/HY=;
        b=Ow1vPAuplA3kLArzmS6nU4EIs9WK6ki7X9YxOH05WhTNaC/WtRF+YbliRU6D4EFVWA
         3C7pggrvg8RUApaZJwa6RzgFupdUkNIYFE/paKYakQmEaQxajzkLTF7D+X8Oo7leeDvY
         d7wvaJZOSJRPDhtXv6iJ8C2vEpvf40II4WHugeirBEgOXrEI3Mjf3Qe9ILQ3baH3wXc+
         QCSvvdJcamF+GmFb4E5qqmBGb+zUnlPqcaDZyQeqX2yBxum9tOyiK/2ToydS1dYc+ZNW
         Lb34PT5m587BbaYIIy7vZ9kCS4iKA4V/lqk6gKb8hoxf5cwSoBi0n4h3GxKFu1Lex6Za
         LWVg==
X-Forwarded-Encrypted: i=1; AJvYcCWvibhe4ihwyRfyU5mz4ASazmdY0QV1Sw71hP4nFHRJoMfpuWPrGjS3sbXaqGUKZoPsK35NqPC8hJnf6bo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl/+8Vko+8VZlHu4X1y2IG8T9lvotvJYXhvfTscaym5PuC4orF
	tVBPYbKWwSUEPi00oXErxcgLg3KalDZw7zXMAV6rGmarc8koDqu6qo11UvnOYs3AVR1Pf0FinS7
	wDNogvhTxJ5BD2c/xGcx+zF2wE+y/F00TWdynrQ==
X-Google-Smtp-Source: AGHT+IElUbrNFhUPOrrE4avyHFZguuGiMLH/RK0oSsezCiUZJOf6asLTGSaej1klx9C+YG41cXDCjUehQvn5Mz0MI5k=
X-Received: by 2002:a05:6512:400c:b0:534:5453:ecda with SMTP id
 2adb3069b0e04-539a0664febmr1154979e87.23.1727858209462; Wed, 02 Oct 2024
 01:36:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926130924.36409-1-brgl@bgdev.pl> <20241001211102.GA227022@bhelgaas>
In-Reply-To: <20241001211102.GA227022@bhelgaas>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 2 Oct 2024 10:36:38 +0200
Message-ID: <CAMRc=MeFww5wyj8XmUMT0zkD-D_EUS+4+7xNQYwgzsMaZ4zXBQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: take the rescan lock when adding devices during host probe
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Konrad Dybcio <konradybcio@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 11:11=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Thu, Sep 26, 2024 at 03:09:23PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Since adding the PCI power control code, we may end up with a race
> > between the pwrctl platform device rescanning the bus and the host
> > controller probe function. The latter needs to take the rescan lock whe=
n
> > adding devices or may crash.
> >
> > Reported-by: Konrad Dybcio <konradybcio@kernel.org>
> > Fixes: 4565d2652a37 ("PCI/pwrctl: Add PCI power control core code")
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/pci/probe.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 4f68414c3086..f1615805f5b0 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -3105,7 +3105,9 @@ int pci_host_probe(struct pci_host_bridge *bridge=
)
> >       list_for_each_entry(child, &bus->children, node)
> >               pcie_bus_configure_settings(child);
> >
> > +     pci_lock_rescan_remove();
> >       pci_bus_add_devices(bus);
> > +     pci_unlock_rescan_remove();
>
> Seems like we do need locking here, but don't we need a more
> comprehensive change?  There are many other callers of
> pci_bus_add_devices(), and most of them look similarly unprotected.
>

From a quick glance it looks like the majority of users are specific
drivers (controller, hotplug, etc.). The calls inside pci_rescan_bus()
and pci_rescan_bus_bridge_resize() are already protected from what I
can tell. I'm not saying that the driver calls shouldn't be fixed but
there's no immediate danger. This however fixes an issue we hit with
PCI core so I'd send it upstream now and then we can think about the
other use-cases.

Bart

