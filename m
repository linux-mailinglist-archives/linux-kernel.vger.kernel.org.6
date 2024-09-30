Return-Path: <linux-kernel+bounces-343312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFBF989974
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 05:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B052810C8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 03:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB8115C3;
	Mon, 30 Sep 2024 03:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ND2a+WFC"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6357D2D05D
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 03:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727666870; cv=none; b=T+B6Wfd3FLLAnmWPbhpDIyGtNjvGlI93Ii1rhxf0rgbICpYkstzIEm4sFXFVV1JwnSxe77COYl9u3tsypSAcGxRfX+gjAx+aYCPV4ZugosgfX9mJTcZp3n40r/s0q14jIzPm/S1TeU77zZ0e/CucHamYK9xmK2K6FL0SQmWeV5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727666870; c=relaxed/simple;
	bh=jLI9MMQQmuZUKWNU/xHCFYdL/UPbKyDkOfCbEMNlGo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCcE1KSRlKcCVVBR25Y8IDxJ1DfMEHDfXIrghmdCDdQlQVMOqZoPJqrKqPtQ0rD8Xq7ofWnxQxkGq3/MYakx8XOrhO0q0zOFNQNrdop5lQJos0hSDkTcAm5TUhN1ieA0EKuPbgQR5n+ewUj+wZLLMvV0aGXw3vI4kxMKFX3x/Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ND2a+WFC; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com [209.85.219.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AA0D33F0B5
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 03:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727666860;
	bh=IS7wA0xTn8FCZ6UozFnElcPvTZac7PO47dXlo5uaWuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=ND2a+WFCmpJJUgcE4GkN0M5aofmmw5MTnZnEFapQ+ahsYz+wA+Yzjb0ihbmKiqFF0
	 xu02s/fJEFzPVq2eIjIvpQCGIBXFVaUNDNWV5DgH9/GFpOqgZxdCwE0vg3CNb974MG
	 zjVqv6uKgZtAuWZ1y86yW0J00xZpxyHgn9EIUXig1bWRAaekzLwcXrwadOUD+J6tsj
	 JvapdE8n9llZVX2si7BZLw4bLeEQnckwcLomkLyrjx1LxoRmyY6OnceCU1r5iGfqdY
	 HFlw7BieJJ8k+x7k1PcwOIQxDIBz43k4y1fdVlnWjRVUaHDxCza7IqVrBOyKTl1xdS
	 yCQ/S36f3JQzA==
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e0b8fa94718so6309089276.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 20:27:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727666859; x=1728271659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IS7wA0xTn8FCZ6UozFnElcPvTZac7PO47dXlo5uaWuU=;
        b=ulOJq+XOBGS+yVUwqPulaefbmLV5kjg4rO3PfnUrVFxMm3aQQH7tDvZeejlPe6K++2
         bmcMIAK4LVVHECYFYm5U+q9XQWnsWckWCHsKOYotYOO+eZjATv1pz7TbV2WjoCD6h7/c
         rIdPbIDX+C/QGejByn1QqCV7LdQhva0t2Kldw1xH5XaixPKMiHbI1vaDSKzqNxCik3jf
         bDOMeUBNMl4TJXi46HXp4VqytTpu2JapSVowJ4kz4uUjZTgjT+pvYCO9vGEE5mwCquXN
         VGhJlJNy80ZAEGi9Ma5HXpzO35v1HXAedqx8FJqVT/QPRLJTp2N6KhO3mX2Oe5ouKMpO
         wh3g==
X-Forwarded-Encrypted: i=1; AJvYcCUfkX1q3W/O87tY3bfgJnKSFS6RV0hvNlX+u9g5Umkq0QJJKZHpkO1+CbUOp97zobhy61q740OgyPaqkZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDrGPQ0vf4Sz1dLfYB/Sml/hG9IUPrwB+w3gHouAPds9olRwWW
	8AJog4JHBezH2JGOnDrTIe4tcmD6rGuilp+wjtY3E9D8a1Qptyz0tUTyyh5BLyOEingk0oa/fnc
	F0YUOZ33tn62iZOV5+Q+3O7fYRdHrYvarwMZKeghAvqsRiS2x2tkDjdcPXFEyS8H8r/s9YGH6XG
	IfE40X4si7DHqROd/0WJMb1catlyBuT/feJPVHI46cWnGANsTlaEms
X-Received: by 2002:a05:6902:2b84:b0:e20:2568:e371 with SMTP id 3f1490d57ef6-e2604c7999dmr7922781276.53.1727666859674;
        Sun, 29 Sep 2024 20:27:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5XOqqUSuKwKgB2HAvUTgCkDeBSDixhXLFmsPg1Q7TNFp4VfsxPkK/WOl6EnwJHcT53aw1DXo6+/5jH+FcFlI=
X-Received: by 2002:a05:6902:2b84:b0:e20:2568:e371 with SMTP id
 3f1490d57ef6-e2604c7999dmr7922776276.53.1727666859371; Sun, 29 Sep 2024
 20:27:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926125909.2362244-1-acelan.kao@canonical.com>
 <ZvVgTGVSco0Kg7H5@wunner.de> <CAFv23Q=5KdqDHYxf9PVO=kq=VqP0LwRaHQ-KnY2taDEkZ9Fueg@mail.gmail.com>
 <ZvZ61srt3QAca2AI@wunner.de>
In-Reply-To: <ZvZ61srt3QAca2AI@wunner.de>
From: AceLan Kao <acelan.kao@canonical.com>
Date: Mon, 30 Sep 2024 11:27:28 +0800
Message-ID: <CAFv23Q=QJ+SmpwvzLmzJeCXwYrAHVvTK96Wz7rY=df7VmGbSmw@mail.gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Fix system hang on resume after hot-unplug
 during suspend
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Lukas Wunner <lukas@wunner.de> =E6=96=BC 2024=E5=B9=B49=E6=9C=8827=E6=97=A5=
 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:28=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, Sep 27, 2024 at 03:33:50PM +0800, AceLan Kao wrote:
> > Lukas Wunner <lukas@wunner.de> 2024-9-26 9:23
> > > On Thu, Sep 26, 2024 at 08:59:09PM +0800, Chia-Lin Kao (AceLan) wrote=
:
> > > > Remove unnecessary pci_walk_bus() call in pciehp_resume_noirq(). Th=
is
> > > > fixes a system hang that occurs when resuming after a Thunderbolt d=
ock
> > > > with attached thunderbolt storage is unplugged during system suspen=
d.
> > > >
> > > > The PCI core already handles setting the disconnected state for dev=
ices
> > > > under a port during suspend/resume.
> > > >
> > > > The redundant bus walk was
> > > > interfering with proper hardware state detection during resume, cau=
sing
> > > > a system hang when hot-unplugging daisy-chained Thunderbolt devices=
.
> >
> > I have no good answer for you now.
> > After enabling some debugging options and debugging lock options, I
> > still didn't get any message.
>
> Have you tried "no_console_suspend" on the kernel command line?
>
>
> > ubuntu@localhost:~$ lspci -tv
> > -[0000:00]-+-00.0  Intel Corporation Device 6400
> >           +-02.0  Intel Corporation Lunar Lake [Intel Graphics]
> >           +-04.0  Intel Corporation Device 641d
> >           +-05.0  Intel Corporation Device 645d
> >           +-07.0-[01-38]--
> >           +-07.2-[39-70]----00.0-[3a-70]--+-00.0-[3b]--
> >           |                               +-01.0-[3c-4d]--
> >           |                               +-02.0-[4e-5f]----00.0-[4f-50=
]----01.0-[50]----00.0  Phison Electronics Corporation E12 NVMe Controller
> >           |                               +-03.0-[60-6f]--
> >           |                               \-04.0-[70]--
> >
> > This is Dell WD22TB dock
> > 39:00.0 PCI bridge [0604]: Intel Corporation Thunderbolt 4 Bridge [Gosh=
en Ridge 2020] [8086:0b26] (rev 03)
> >        Subsystem: Intel Corporation Thunderbolt 4 Bridge [Goshen Ridge =
2020] [8086:0000]
> >
> > This is the TBT storage connects to the dock
> > 50:00.0 Non-Volatile memory controller [0108]: Phison Electronics
> > Corporation E12 NVMe Controller [1987:5012] (rev 01)
> >        Subsystem: Phison Electronics Corporation E12 NVMe Controller [1=
987:5012]
> >        Kernel driver in use: nvme
> >        Kernel modules: nvme
>
> The lspci output shows another PCIe switch in-between the WD22TB dock and
> the NVMe drive (bus 4e and 4f).  Is that another Thunderbolt device?
> Or is the NVMe drive built into the WD22TB dock and the switch at bus
> 4e and 4f is a non-Thunderbolt PCIe switch in the dock?
>
> I realize now that commit 9d573d19547b ("PCI: pciehp: Detect device
> replacement during system sleep") is a little overzealous because it
> not only reacts to *replaced* devices but also to *unplugged* devices:
> If the device was unplugged, reading the vendor and device ID returns
> 0xffff, which is different from the cached value, so the device is
> assumed to have been replaced even though it's actually been unplugged.
>
> The device replacement check runs in the ->resume_noirq phase.  Later on
> in the ->resume phase, pciehp_resume() calls pciehp_check_presence() to
> check for unplugged devices.  Commit 9d573d19547b inadvertantly reacts
> before pciehp_check_presence() gets a chance to react.  So that's somethi=
ng
> that we should probably change.
>
> I'm not sure though why that would call a hang.  But there is a known iss=
ue
> that a deadlock may occur when hot-removing nested PCIe switches (which i=
s
> what you've got here).  Keith Busch recently re-discovered the issue.
> You may want to try if the hang goes away if you apply this patch:
>
> https://lore.kernel.org/all/20240612181625.3604512-2-kbusch@meta.com/
>
> If it does go away then at least we know what the root cause is.
Yes, the 2 patches work.

>
> The patch is a bit hackish, but there's an ongoing effort to tackle the
> problem more thoroughly:
>
> https://lore.kernel.org/all/20240722151936.1452299-1-kbusch@meta.com/
> https://lore.kernel.org/all/20240827192826.710031-1-kbusch@meta.com/
v2 can't be applied clearly, so I made some changes.
And this series doesn't work for me.

>
> Thanks,
>
> Lukas

