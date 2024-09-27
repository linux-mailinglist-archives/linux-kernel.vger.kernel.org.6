Return-Path: <linux-kernel+bounces-341399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07799987F84
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ABC81C2232E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F3E17BEB6;
	Fri, 27 Sep 2024 07:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="EUCmp202"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D1615699E
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 07:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727422454; cv=none; b=e9eouNhg8msjcNCBkBG+iYwfKPnK8KaA+WXEWeLdpBYpdT3hxeQs31O6GILo7dSsIQlusMHA/1DULmf5hVkIugz/bh+yEGNtkYpruQlkcFWi1jiBSSqLAGT32JDbiQgcZkl40pNcyYw90m/IxxYM1yRPNEiY5/sFtPqCy3HAntc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727422454; c=relaxed/simple;
	bh=im/F4eUutyF7Nm/5zlZw3FmztfxxGxoLo4xKXQENCgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6N2nLkhzSiQQca9A/2A41OEqnNt7qWPQXMcfp9OurW6/nvaSN1GpaaUNPB870PekMCU+oxG/m5xT96JCP1cZQpoM7psdg/7EmUYoQ6K7ziTzXu/dds/3kuM+J29FHzG00FTem2uYNSnqIVGgZBqKD8Sa//ADfTDWEcDuhqu79E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=EUCmp202; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com [209.85.219.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id ACBC43F135
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 07:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727422443;
	bh=7YIljPLfNlEO3FZ2gWZ9IoRY/bMh1BYz9cIWOg32W6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=EUCmp202Z9wTa+jg5+TTAAOxoDKIBIMOEdz3b+MCfTryVxQMwEwfcKQOcqpLTzBH+
	 DpLoXGHpSoLH1PNa4E2Ea3hJcMfiSVn1XXRikpFTabQGMJXv3S81Hrv+k7GYooIQ5w
	 S59zvug/ejl762cKZ196CjTMRrWCepML+PTHyGq1D6wohZZSuIamlgQxNtcYJwUX6y
	 JPxS76MnGeWEbP/pW3J9e0AzmBBlkrG6Ff/w0CgPglspBCGK+DoE2K2eKdROS2frZX
	 SWCdyMw0Omn16eBQ+W68FxiZ6k2K5CmysNZbD80giRXzTMJdartPFNEuYUAsvOwrd4
	 78bMZcQmpsxxw==
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e25d62bfe12so2064582276.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 00:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727422442; x=1728027242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YIljPLfNlEO3FZ2gWZ9IoRY/bMh1BYz9cIWOg32W6E=;
        b=sAyjNY3G7GqtkrCck5RtkBbN3EglX38bH5lR/HBa43GIR3T8avC6JmD8Dz5S6lGQN/
         bPyHSS0W2dmRsIgAt+GEHYEKFIQhzt17fPVuJGdd91HhNxu5eM0yp55Vhi0sr2g6NecV
         xcyUGixYJfw5dF5CV97Ubo674rLsXlWBNqk1R02e5PAQHPdQ9gdqtIAVtVStqkahpJ8y
         Qmk1mZ6hWfvpChpCnQQm5ifp9Wp2Qwzgnaka+FAkipxtcpq6Kf90WonN9z8VHeylEZmu
         w44dVZBQmKC6xARdFx2cFRz+aCesjvxLQSAfztqABstC9gOu8tbSafg+6wjQNNM8VhG1
         5FfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVarVLclGvlwhQozGeGyYxbAIrQWeEv3RlCJKBXyztL7jsyoqxLxx4eeWZh8KziK8OgTmOVZl/yPK0bBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP/ix+Ih/iwM84v7z+VH4yo3D3c1wbmYDDHjEj+2EcsE0scotj
	N5DZV4j4RuQjYb14FSBXJ7goscN/HnLRPSYrVGb9F46xl/NhYcS6G57PFMOkkVyfE396bkCtUTQ
	FdEnnkrviBHyIY/kmijexOVwtHW8mnB5nDAh1N8JQdkY1+WnBWJZEr7SF31No8xP5+Lu0WfynMz
	0/PSnZjLnze7aeBNybsOvDh79n4cK7/rT9XbO31548BVr+Hz+6ErjP
X-Received: by 2002:a05:6902:2191:b0:e20:16b9:ad68 with SMTP id 3f1490d57ef6-e2604c7b4d6mr1606579276.45.1727422442430;
        Fri, 27 Sep 2024 00:34:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGedGnyfsyHzBPotN43JoM7Z1Z/Gr6maiReLknG4Z+OL/BZsgfIw7Ggk33gHsTNGT11RyoJhycmZ2g/8XDM8Lk=
X-Received: by 2002:a05:6902:2191:b0:e20:16b9:ad68 with SMTP id
 3f1490d57ef6-e2604c7b4d6mr1606571276.45.1727422441984; Fri, 27 Sep 2024
 00:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926125909.2362244-1-acelan.kao@canonical.com> <ZvVgTGVSco0Kg7H5@wunner.de>
In-Reply-To: <ZvVgTGVSco0Kg7H5@wunner.de>
From: AceLan Kao <acelan.kao@canonical.com>
Date: Fri, 27 Sep 2024 15:33:50 +0800
Message-ID: <CAFv23Q=5KdqDHYxf9PVO=kq=VqP0LwRaHQ-KnY2taDEkZ9Fueg@mail.gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Fix system hang on resume after hot-unplug
 during suspend
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Lukas Wunner <lukas@wunner.de> =E6=96=BC 2024=E5=B9=B49=E6=9C=8826=E6=97=A5=
 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=889:23=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, Sep 26, 2024 at 08:59:09PM +0800, Chia-Lin Kao (AceLan) wrote:
> > Remove unnecessary pci_walk_bus() call in pciehp_resume_noirq(). This
> > fixes a system hang that occurs when resuming after a Thunderbolt dock
> > with attached thunderbolt storage is unplugged during system suspend.
> >
> > The PCI core already handles setting the disconnected state for devices
> > under a port during suspend/resume.
>
> Please explain in the commit message where the PCI core does that.
Hi Lukas,

I found my patch doesn't work.
Let me explain the new findings below.

>
> > The redundant bus walk was
> > interfering with proper hardware state detection during resume, causing
> > a system hang when hot-unplugging daisy-chained Thunderbolt devices.
>
> Please explain what "proper hardware state detection" means.
>
> Did you get a hung task stacktrace?  If so, please include it in the
> commit message.
>
> If you're getting a system hang, it means there's a deadlock
> involving pci_bus_sem.  I don't quite see how that could happen,
> so a more verbose explanation would be appreciated.
I have no good answer for you now.
After enabling some debugging options and debugging lock options, I
still didn't get any message.
It just hangs there while resuming, and nothing could be logged.

Here is my setup
ubuntu@localhost:~$ lspci -tv
-[0000:00]-+-00.0  Intel Corporation Device 6400
          +-02.0  Intel Corporation Lunar Lake [Intel Graphics]
          +-04.0  Intel Corporation Device 641d
          +-05.0  Intel Corporation Device 645d
          +-07.0-[01-38]--
          +-07.2-[39-70]----00.0-[3a-70]--+-00.0-[3b]--
          |                               +-01.0-[3c-4d]--
          |
+-02.0-[4e-5f]----00.0-[4f-50]----01.0-[50]----00.0  Phison
Electronics Corporation E12 NVMe Controlle
r
          |                               +-03.0-[60-6f]--
          |                               \-04.0-[70]--

This is Dell WD22TB dock
39:00.0 PCI bridge [0604]: Intel Corporation Thunderbolt 4 Bridge
[Goshen Ridge 2020] [8086:0b26] (rev 03)
       Subsystem: Intel Corporation Thunderbolt 4 Bridge [Goshen Ridge
2020] [8086:0000]
       Kernel driver in use: pcieport

This is the TBT storage connects to the dock
50:00.0 Non-Volatile memory controller [0108]: Phison Electronics
Corporation E12 NVMe Controller [1987:5012] (rev 01)
       Subsystem: Phison Electronics Corporation E12 NVMe Controller [1987:=
5012]
       Kernel driver in use: nvme
       Kernel modules: nvme

While resuming, the dock(8086:0b26) resumes first and I found if dock
device run through below 2 functions in pciehp_resume_noirq()
    if (pciehp_device_replaced(ctrl)) {
        pci_walk_bus(ctrl->pcie->port->subordinate,pci_dev_set_disconnected=
,
NULL);
        pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
    }
The system hangs when storage(1987:5012) also calls the 2 functions.
Only one of the 2 devices can enter the if statement, dock or storage,
or the system hangs.

To test it more, I found that mask out pciehp_request() eases the issue.
It may be because it calls irq_wake_thread() and is stuck somewhere.

So, I try to get rid of the irq_wake_thread() by replacing
   pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
with
   atomic_or(PCI_EXP_SLTSTA_PDC, &ctrl->pending_events);
In this case, only dock(8086:0b26) will be called in pciehp_resume_noirq().
And the tbt storage will be released after pci_power_up() fails.

Do you think this is a feasible solution?

diff --git a/drivers/pci/hotplug/pciehp_core.c
b/drivers/pci/hotplug/pciehp_core.c
index ff458e692fed..56bf23d55c41 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -332,7 +332,7 @@ static int pciehp_resume_noirq(struct pcie_device *dev)
                       ctrl_dbg(ctrl, "device replaced during system sleep\=
n");
                       pci_walk_bus(ctrl->pcie->port->subordinate,
                                    pci_dev_set_disconnected, NULL);
-                       pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
+                       atomic_or(PCI_EXP_SLTSTA_PDC, &ctrl->pending_events=
);
               }
       }

>
> Thanks,
>
> Lukas
>
>
> > Fixes: 9d573d19547b ("PCI: pciehp: Detect device replacement during sys=
tem sleep")
> > Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> > ---
> >  drivers/pci/hotplug/pciehp_core.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pc=
iehp_core.c
> > index ff458e692fed..c1c3f7e2bc43 100644
> > --- a/drivers/pci/hotplug/pciehp_core.c
> > +++ b/drivers/pci/hotplug/pciehp_core.c
> > @@ -330,8 +330,6 @@ static int pciehp_resume_noirq(struct pcie_device *=
dev)
> >                */
> >               if (pciehp_device_replaced(ctrl)) {
> >                       ctrl_dbg(ctrl, "device replaced during system sle=
ep\n");
> > -                     pci_walk_bus(ctrl->pcie->port->subordinate,
> > -                                  pci_dev_set_disconnected, NULL);
> >                       pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
> >               }
> >       }
> > --
> > 2.43.0

