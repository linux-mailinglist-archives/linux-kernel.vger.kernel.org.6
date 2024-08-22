Return-Path: <linux-kernel+bounces-296782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB5E95AF23
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0861C22CC0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683C0178381;
	Thu, 22 Aug 2024 07:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="eiRY1gSD"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5572714F9DA
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310945; cv=none; b=czikLDj31rb5ruZk6G9EQm2RxhIqENHL4Ur0Ohxin+WgLAoSl5ooewnEVGVJYHL/yp4VYStKKUR13bQS5ChM0LZeJmMd5LtLsXCYW3/kKmu+bPpXerMSl9/0ba1T/At1l8RjCkb1kKKSxACEn5UD7Zi+dGLKLfwu0tcGk1fW7CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310945; c=relaxed/simple;
	bh=GHMKK28P5WFG9CY73l5UrXowcCT9+qJTTq73QMMe2o8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HUUADWRU2uhoEhvkLxywCidR0tYoIWzVaoPfZ3B/+Q8CMqOGX1Rdw8eoGyy/iiVxVMpoashVm3LD2XOWRLCrXa8YaTYcgQp0gRWARQRjXmUDB1o5hcJBqislKjkYFpbSVhR7riP2zDnaq1QGuOCznWXyH5RarzbzGFnelk7fyQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=eiRY1gSD; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BCE053F2F2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1724310934;
	bh=1x5Vq9E8qun2g1cNXzLviVdr7wWOjdbEml0Dxvdx+jE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=eiRY1gSDEw2Y5KyT751pTv+a7RH94I7OrOQfBRuJAivZ3hAuz5EaNkeLcHh7M3Ltu
	 CMWZ0TbZkzwSKoc9olqewkN4cbcLbfFe1XIT7tKNRhVqLA7yNlqCwAi1DE7eYd3ozC
	 y6VdpX5FlYMcKWpXEfE5d44qtTUlGdbGRIZSxZuPwXSodmNIwnOKN+DgOCcjDkWYi3
	 F4XLOzzsoF6p6PbojcuxXt7Cf5MBAGUWkUm7zVWvZWFy9wUONetBX+c9seMc/zCnNB
	 UnW5vNWQn7lallekTQxMk0rCpUWm4Fu8OGTD6OFgizIeKKsfUnZ8Tv/LoBjaNw0nhj
	 ospnhyUyDC0cg==
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7bc8bb2f6f5so621774a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724310933; x=1724915733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1x5Vq9E8qun2g1cNXzLviVdr7wWOjdbEml0Dxvdx+jE=;
        b=JCNYDpij0KkbawK3XH+ZZzadEM4YzqWMd8qBKBhnlOcvtz+lbJ/wjVAWIoALMLi/r9
         KHcbHqFkZGM2GY09y+OLoHj/1ODsel35bX+3g1FfLyTe9MDbVlfCWCkB+yNNrh3EBh2J
         7Smm1555xE/CLZI3JVVSpxILcHPRWUyatDnD+oVSjqyRkM/sJA0Jau27TO6Fp1Czb3qx
         EDh2En7x/eZBdYOHihiwNkQf3uAbILm1F5C4lOXCQGUCCy3XPIDUoib6g6e4oKlBSgWU
         ONlL2FkDpGi352zPRsbJI7aLuCnqzq1oTzff6M6oPfvqzgXNVaZTSrWRRfuFWEbW4ptx
         0haQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9Jar+P4xSQDgkCywOaX1bBtypNTqg3SZ5d4iUi8xxjWfkBCVo7NtlkMFPJRIAp1rDtsFtbsbdaFqRXKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw+a8R+8DLh+t4Xnz1GU+vvSa+BL67XU8uDBoAkELpW2WoeL6k
	jpoif1rXYBLdt8q/sEmEiuY6TFcwQLou5DlUd1OF/ufavRMSy+Zcrp6+S58luHkP1GChu5yZRGP
	ASTowoEiJXt1vtWtqGGWQbAn90MUQR8HgP5R+noQimHuM5eJEFonJeW+Dlg2Bo1KttmRYsirI2l
	O/Z8Xw5KYthSF+MIvOF/CyYWSArwKFJ/3D99156t1JUpiMBacKsvfq
X-Received: by 2002:a05:6a20:7b1a:b0:1ca:dc1b:319c with SMTP id adf61e73a8af0-1cadc1b31c1mr3963360637.6.1724310932783;
        Thu, 22 Aug 2024 00:15:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEPkh9puTCLERBLO8DJrwBxsq1v7kj7XihgY9K2CgmZv96owv921d7HarOT+cOVzsmPR5oa3p8zGmcGks/n3E=
X-Received: by 2002:a05:6a20:7b1a:b0:1ca:dc1b:319c with SMTP id
 adf61e73a8af0-1cadc1b31c1mr3963348637.6.1724310932487; Thu, 22 Aug 2024
 00:15:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712185418.937087-1-superm1@kernel.org> <789f9bc0-45f4-4602-9f8c-c286fa7b922b@kernel.org>
In-Reply-To: <789f9bc0-45f4-4602-9f8c-c286fa7b922b@kernel.org>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 22 Aug 2024 15:15:20 +0800
Message-ID: <CAAd53p67SR+FrdRro7kmZJbYRXZHw2PToyi6gSJv6+8=jZkyyA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Put XHCI controllers into D3 at S4/S5
To: Mario Limonciello <superm1@kernel.org>
Cc: Mathias Nyman <mathias.nyman@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	mika.westerberg@linux.intel.com, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mario,

On Tue, Aug 20, 2024 at 10:06=E2=80=AFAM Mario Limonciello <superm1@kernel.=
org> wrote:
>
> On 7/12/24 13:54, superm1@kernel.org wrote:
> > From: Mario Limonciello <mario.limonciello@amd.com>
> >
> > When the system is put into S4 or S5 XHCI controllers remain in D0.  Th=
is
> > causes higher power consumption and may compromise energy certification=
s.
> > Consequently some systems consume more power in S5 than s0i3.
> >
> > This affects all PCIe devices, but looking at breakdowns XHCI is the
> > biggest offender for power consumption.
> >
> > This series checks if any wakeups are needed and puts controllers into =
D3
> > if no wakeup necessary.
> >
> > This series is a spiritual successor to [1] which aimed to do this more
> > generally in PCI.  It also accomplishes similar goals as [2], but aims =
for
> > both S4 and S5.
> >
> > [1] https://lore.kernel.org/linux-pci/20231213182656.6165-1-mario.limon=
ciello@amd.com/#t
> > [2] https://lore.kernel.org/linux-pci/9d2f1619-1c61-4e8c-b28d-d4eddefa4=
5c3@amd.com/T/
> >
> > Mario Limonciello (2):
> >    xhci: pci: If no ports have wakeup enabled then disable PCI device a=
t
> >      S4
> >    xhci: pci: Put XHCI controllers into D3hot at shutdown
> >
> >   drivers/usb/host/xhci-pci.c | 17 +++++++++++------
> >   1 file changed, 11 insertions(+), 6 deletions(-)
> >
>
> Hello,
>
> Any feedback for this series?

Does commit 0fab972eef49 ("drivers: core: Detach device from power
domain on shutdown") work for your case?
The commit was reverted because it regressed some DT based devices,
but probably still worth doing for ACPI based systems.

Kai-Heng

>
> Thanks,

