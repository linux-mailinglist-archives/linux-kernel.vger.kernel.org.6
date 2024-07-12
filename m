Return-Path: <linux-kernel+bounces-250249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A846292F5A9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 08:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D12B283517
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 06:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EFA13D533;
	Fri, 12 Jul 2024 06:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AHMvc0aH"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2898339B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 06:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720766912; cv=none; b=su7x/zpih3eutCl6L0F+tc4Qy6bgNUvbR0hQC5OTuEktdm22w+QbjdpdZcVmDeUYrP2/YLvh7zcxhyE/nRALs8zafcd528aamfzQgkOV6UYlkqIstmpoeVEkzEQ1SLDoTZdJfdBY+byN+vdVeXt+xUXYcCem/ogsfpLBZfLtMLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720766912; c=relaxed/simple;
	bh=xMV/z33NFOqMzM8JfcQjaOoMBKUPMqBIE+lUrEw52mE=;
	h=From:Date:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W7Qks+WcA3f4hH5eH3MkNMSZv3wJh3WfqVrscn4LNRDRz3zKHQ974K83zaUKBgWMQJ/rEKt16DWZAt97qeKnimYAQyWZWOqtbxG1XAClaynDf0YyEKCENelRoHj6sMExXgGTBcQL5ABbzYgIvJ3a5IkDJ/i0V/W/SYTAmi9EhlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AHMvc0aH; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52ea929ea56so3242470e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 23:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720766908; x=1721371708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMV/z33NFOqMzM8JfcQjaOoMBKUPMqBIE+lUrEw52mE=;
        b=AHMvc0aHgPq7Y9HYk50YMCWVNOm9G8MDpaQuSapvXGbxoZ5CNBcIwePQuca0Ob1fOX
         QIQ/UeKsi5hXNLklD5442bmfrNnRrl3rVHHH3rss8cczxjOijVeVxT4nUBMfaqfB7uvW
         7+d0/SWj8YhfH8UN0889k9NyAG/MPpD+nPqAKyQRiUS3ZjBafoTGRz/uNRGWO/W4cdCn
         UtTeK31p8w7AMi+BRnuClXUlE9pXtX/vN28Axa5Q0EG+1MavLUQOvm80nOxfXs/cMmqU
         M8iI5MRPR4s6RTjjBUL5zwP2P1OSohQpUfmAf87kWSq/+CBZh2fZFEVoNVp8Eblb+pOI
         3Unw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720766908; x=1721371708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMV/z33NFOqMzM8JfcQjaOoMBKUPMqBIE+lUrEw52mE=;
        b=fRXlaKcMpJ2SN//nIlZaPaGowtGVnJUppc85fOka/pZnGkJVkPckZeqqqAcXPeoi0L
         jPwUrlR17vx5CnRLe1yW50Piijabq1gqsuZ14YfN6oMn7CWDT5a5TtX6PNHawAU3e1LN
         NX2QgPT4jcjvAiRUq2MJxfN6EtKbwBajtnDGoXs4EbCXnMS+88WPv+PkI0aBCn1zScX9
         gPgEKyT56/STOxT+2avUdpO5T/P6zuDrQOkjr+6ZWIRtr3CxGHrkV4gGTNyg/3cFFJXv
         GbGy9fU/7nGE9T8bsQthbd1MWaU9EkBcW6whIYocFHVXqHFrLzxUkwWHmyuHYT4KXPVR
         MUbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj/7fbKRRmK9dHupjtIwl+GUHYxicF1kHVCBzvFEKOOuJyccNkvRhD82sewy9G2GEMq7prijWHMd1ZFpMi6jn8sJKxj2hafWfZrpYL
X-Gm-Message-State: AOJu0Yxmy1bd97h59tpBSnXpUFX2jUp3ws9im+fnM1jlTxYhK5A6iawe
	azMY9GRoK+PpQHdcdB+Su3eeXIvn+RLbjVEc370pTUvuJ+21ikeCFB/s+g0QT3Q=
X-Google-Smtp-Source: AGHT+IHTtmtrVLLE7aDfY6kkhvZrmZsV2MnTKBQLikl9TyOMWMFZLyZQL7bTaCQtck/kvBawPV6jfQ==
X-Received: by 2002:a05:6512:3499:b0:52e:936e:a237 with SMTP id 2adb3069b0e04-52eb999b382mr6496264e87.16.1720766908188;
        Thu, 11 Jul 2024 23:48:28 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a872002sm314623966b.211.2024.07.11.23.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 23:48:27 -0700 (PDT)
From: Petr Tesarik <petr.tesarik@suse.com>
X-Google-Original-From: Petr Tesarik <ptesarik@suse.com>
Date: Fri, 12 Jul 2024 08:48:26 +0200
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Petr Tesarik
 <petr@tesarici.cz>
Subject: Re: [PATCH] sysfs/cpu: Make crash_hotplug attribute world-readable
Message-ID: <20240712084826.3128cba2@mordecai.tesarici.cz>
In-Reply-To: <06c0d61f-8dcb-46f6-8710-db1c6163907b@linux.ibm.com>
References: <20240711103409.319673-1-petr.tesarik@suse.com>
	<59d88de7-369a-44e8-a965-109c8690869e@linux.ibm.com>
	<20240712082124.272e079f@meshulam.tesarici.cz>
	<06c0d61f-8dcb-46f6-8710-db1c6163907b@linux.ibm.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Jul 2024 12:01:29 +0530
Sourabh Jain <sourabhjain@linux.ibm.com> wrote:

> Hello Petr,
>=20
> On 12/07/24 11:51, Petr Tesa=C5=99=C3=ADk wrote:
> > On Fri, 12 Jul 2024 10:00:09 +0530
> > Sourabh Jain <sourabhjain@linux.ibm.com> wrote:
> > =20
> >> Hello Petr,
> >>
> >> Just want to mentioned few points about the commit message. No strong
> >> opinion on changing the commit message.
> >>
> >> On 11/07/24 16:04, Petr Tesarik wrote: =20
> >>> From: Petr Tesarik <ptesarik@suse.com>
> >>>
> >>> There is no reason to restrict access to this attribute, as it merely
> >>> reports whether crash elfcorehdr is automatically updated on CPU hot
> >>> plug/unplug and/or online/offline events. =20
> >> Now, it is not just elfcorehdr; there could be multiple kexec segments
> >> based on the architecture's needs.
> >> For example, on PowerPC, it is elfcorehdr and FDT. =20
> > Right. I am even working with a PowerVM LPAR on an L922 system now. ;-)
> >
> > OTOH I was just too lazy to invent my own description, so I took it
> > from Documentation/ABI/testing/sysfs-devices-system-cpu. That one
> > could be improved. And a couple of other places... Expect a patch. =20
> Thanks for point it out, I will send a patch to fix the ABI document for=
=20
> crash_hotplug and other places in the kernel. Thanks,

Oh, I was planning to do that, but if you want to send a patch
yourself, I won't duplicate efforts. There are other cleanups on my
TODO list.

Petr T

