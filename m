Return-Path: <linux-kernel+bounces-434112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDAB9E61C8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69CC8282041
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F418F40;
	Fri,  6 Dec 2024 00:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="DZJkbx+r"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3814431
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 00:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443765; cv=none; b=rI6PpeBl5Nt9sXM2K0eVp/pF5E34HdF/kUpKCr6oaBcqvhhpmNwViMnSNLl6Rv5Gp9flz3sF42qa9wBB1WOSvTmqsmJtuvQOMSd6TE5V/s6b74wkJen9xFpZ71A85EA+6lyJcsgJ1wvE2l62IX7AhryHFYTYLwA1W74LuU6qpjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443765; c=relaxed/simple;
	bh=dBA47SUie5SwFd03yBmEyKgEIejEfXGA+UqqvehwusI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MdWV8dW1ycCIgq/pQQwHWoaCPEBxF8lENZAw3SXs0UObmlVt5wHYyImu/Xsy3bxFMuMa75KjfxSroMUZ+YkQH2IkkUpvaI+OkYnIfSsQdD8imSYOQQEV9Pw4WSciGasQ7UBn/rawBG2CQX9dtDS6OvTU1rBCJG2hwd2u6xp4rao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=DZJkbx+r; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F0EC73F18D
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 00:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733443759;
	bh=sMurqy6Z4XssLascAqYWalpe3jcOC1OWrus+pdaK60E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=DZJkbx+r3c2bwkUq7M8yywN25GK9LMZCTsCCi5dJIUpUiaU1syMg4BfVM1CPsFShj
	 XP5plInD1FzNL1czpBwuX+llReqrMWSXLw88w/NmK50iPHtZEEFgz5Ck5pVeccyFmF
	 z0I3cxEImvZkgR8w2koU8EdxtCT12U+pi5S35tkXUfete5MSXa/ZOpW9e/51YKWssU
	 y1m9Gi112MpKUYS4Mhg/BI6vVsiVmy8iBCHffB5LBY9JExltbpAiA5JxOa+t3O/JGy
	 HKuTk8el0Y8QfXsuBv9xUqElO+VwXGzmJJeTEAu+acMAcCd82HbH4ZnNrZ8yovf4hR
	 eCR4qNiUUyopg==
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5d126a2affeso1128563a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 16:09:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733443759; x=1734048559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMurqy6Z4XssLascAqYWalpe3jcOC1OWrus+pdaK60E=;
        b=MwgkDLDNEND8AyOvCju71NWYg3msuAFIS6i3i9Sr4tiH/Z8Xzvfl8pSYjsGkezHzOx
         KgBX/jwfl9nb81Bj2C05kQ3tsj9YBkiZ5A+FIT6Dpfbto2PB0YQOsSksekH32Xt8l16s
         HKPWfhmidZTBZBgKHoND7e/Sp7uHrTehHuOoe49+6LiVtaM1CU97etZ8FmeuGRF7w3WC
         iuekqeSkmb/R9E5m3RM1zAv+KMQFFyVhcpdFqyKjPc4zqg78+RyYkKvhIpshziG8+iJJ
         ff6WD/9IFRTIceU4CVLSGP7hLb5gx8ZtVub2xhxo4zq34UKZJmbbry9CI3rpu8ZF7nOH
         Hdeg==
X-Forwarded-Encrypted: i=1; AJvYcCXP80INGlr7L6h2eCO1IL45EsgE5bqyApo985UZdA9Izxc+kdrz10r9iXCOU8e670LP4mPI2bw4qG1pPEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrh9aglqisxCNstuqIDO8vSJRY2mL3Bx7I9wgeKQpb0krUXkMl
	C/sdUzUNx+ooU8VFZQQapMk/0HuACbP7f5pUqE3itW2faVTY12iqyPSTZfPIUdjX6cByVqo7Cnc
	Y0dgNh9zJV79mpuDd2DL32D6+YNye44dJ3UZS1lqvDG2xKpyyFUAONMmNyDPKtmCZZbaK1HOs8n
	G7YxHsIf4K1LXhO0jag5s9t3m2Pj4Rj2kvtAYh/9IfepW0+OxMzvHq
X-Gm-Gg: ASbGnctBnhjhpajngi/zSybRWQYettvQzU67DMHwBKpsQSXd/lfHuP1og41m3hXiWTx
	qSdxDEzQcuB60mhwRi8Tv3OdnVjirhg==
X-Received: by 2002:a05:6402:380f:b0:5d0:849c:71c3 with SMTP id 4fb4d7f45d1cf-5d3be466d4fmr1063015a12.0.1733443759490;
        Thu, 05 Dec 2024 16:09:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXpaP6nHDJsgYgKmHtFKSLgJ8MxPTVUzP/aApdPIDtegMmgfU+nkDdyPlw7Ek4gZHguQ66qgFYOTW+lnJYTqI=
X-Received: by 2002:a05:6402:380f:b0:5d0:849c:71c3 with SMTP id
 4fb4d7f45d1cf-5d3be466d4fmr1062984a12.0.1733443759183; Thu, 05 Dec 2024
 16:09:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHTA-uYp07FgM6T1OZQKqAdSA5JrZo0ReNEyZgQZub4mDRrV5w@mail.gmail.com>
 <20241126103427.42d21193.alex.williamson@redhat.com> <CAHTA-ubXiDePmfgTdPbg144tHmRZR8=2cNshcL5tMkoMXdyn_Q@mail.gmail.com>
 <20241126154145.638dba46.alex.williamson@redhat.com> <CAHTA-uZp-bk5HeE7uhsR1frtj9dU+HrXxFZTAVeAwFhPen87wA@mail.gmail.com>
 <20241126170214.5717003f.alex.williamson@redhat.com> <CAHTA-uY3pyDLH9-hy1RjOqrRR+OU=Ko6hJ4xWmMTyoLwHhgTOQ@mail.gmail.com>
 <20241127102243.57cddb78.alex.williamson@redhat.com> <CAHTA-uaGZkQ6rEMcRq6JiZn8v9nZPn80NyucuSTEXuPfy+0ccw@mail.gmail.com>
 <20241203122023.21171712.alex.williamson@redhat.com> <CAHTA-uZWGmoLr0R4L608xzvBAxnr7zQPMDbX0U4MTfN3BAsfTQ@mail.gmail.com>
 <20241203150620.15431c5c.alex.williamson@redhat.com> <CAHTA-uZD5_TAZQkxdJRt48T=aPNAKg+x1tgpadv8aDbX5f14vA@mail.gmail.com>
 <20241203163045.3e068562.alex.williamson@redhat.com>
In-Reply-To: <20241203163045.3e068562.alex.williamson@redhat.com>
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Thu, 5 Dec 2024 18:09:08 -0600
Message-ID: <CAHTA-ua5g2ygX_1T=YV7Nf1pRzO8TuqS==CCEpK51Gez9Q5woA@mail.gmail.com>
Subject: Re: drivers/pci: (and/or KVM): Slow PCI initialization during VM boot
 with passthrough of large BAR Nvidia GPUs on DGX H100
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I submitted a patch that addresses this issue that I want to link to
in this thread:
https://lore.kernel.org/all/20241206000351.884656-1-mitchell.augustin@canon=
ical.com/
- everything looks good with it on my end.

-Mitchell Augustin


On Tue, Dec 3, 2024 at 5:30=E2=80=AFPM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Tue, 3 Dec 2024 17:09:07 -0600
> Mitchell Augustin <mitchell.augustin@canonical.com> wrote:
>
> > Thanks for the suggestions!
> >
> > > The calling convention of __pci_read_base() is already changing if we=
're having the caller disable decoding
> >
> > The way I implemented that in my initial patch draft[0] still allows
> > for __pci_read_base() to be called independently, as it was
> > originally, since (as far as I understand) the encode disable/enable
> > is just a mask - so I didn't need to remove the disable/enable inside
> > __pci_read_base(), and instead just added an extra one in
> > pci_read_bases(), turning the __pci_read_base() disable/enable into a
> > no-op when called from pci_read_bases(). In any case...
> >
> > > I think maybe another alternative that doesn't hold off the console w=
ould be to split the BAR sizing and resource processing into separate steps=
.
> >
> > This seems like a potentially better option, so I'll dig into that appr=
oach.
> >
> >
> > Providing some additional info you requested last week, just for more c=
ontext:
> >
> > > Do you have similar logs from that [hotplug] operation
> >
> > Attached [1] is the guest boot output (boot was quick, since no GPUs
> > were attached at boot time)
>
> I think what's happening here is that decode is already disabled on the
> hot-added device (vs enabled by the VM firmware on cold-plug), so in
> practice it's similar to your nested disable solution.  Thanks,
>
> Alex
>


--=20
Mitchell Augustin
Software Engineer - Ubuntu Partner Engineering

