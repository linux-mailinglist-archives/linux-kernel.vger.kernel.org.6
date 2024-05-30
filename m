Return-Path: <linux-kernel+bounces-194995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 375768D45C6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587B71C21A8E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 07:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9F84D8B3;
	Thu, 30 May 2024 07:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="eK9yYGJB"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386B84D8A1
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 07:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717052922; cv=none; b=eSR2VRjSEq7CxCl0LMSs/5VT1d3oS/RhYlAksBBzOvu6bk6ISHTvUKpNQ/bK2OolHdcS2oAcO4Nd9Mlnudrt0UxFjTGmLtMbwaop/xbrOixNeIsk1/dDEPMlD8GQdtrnGMANQKyPWzdxB62T21Z9dV/qbewvWrIngAWJnkqLE/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717052922; c=relaxed/simple;
	bh=BniW6rWiN74lvUrkYpNGa9ngKB30V1X82LLmR41ooy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tf22Uny+zumVjID7z0QcoDXxA37dGd2G3CF5H45huXR+ENMFAWadMRcLrseKs5TgwZjggNcHVB3az3LcwGI1Rhk/j5fTqXF09zrWxz7lTYCvKu7XAvbdmhWpQbShfkzKbfLR71owh7iEUEHXw/RI63wQXTZn/gRGqhDydq5BxBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=eK9yYGJB; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 397043F274
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 07:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717052916;
	bh=TRdoJVYUghUxsPDAMk3jETTan44HR4AbMtVfdYZkEqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=eK9yYGJBRX5sjqPb6+A+mXmX0Py81nIwfq8ioDVC3ha+VtaWOqsAG6qSWlHzIc53u
	 cXSoKFrQI6IGmXBFA6Dlf8YWCtMacvnImEYQFlEzsiE679yb0qcm7HGvIlHY22h1e1
	 qqXSO7KHn8otoZBrCOcfEcC8PCFCD+R3xS9MYnAWdg82Q2+Cz2stNjkxkGQrEZzlaI
	 jaRCfP5wCqAV6jJhJO5Rl/LnIhynwHRM7fxEEac480tcY8ejfCcqdVEtX2MWYRnYiR
	 gGOXF2gNN8kX+qMcPGi6fGQmwFvnCKfMcrs5m8J05c+EXbN5p7KvAApnhK1wdEnTQl
	 R2wyPb869ZNbg==
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ea7f0c875fso4175561fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 00:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717052915; x=1717657715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRdoJVYUghUxsPDAMk3jETTan44HR4AbMtVfdYZkEqw=;
        b=afqk4Ts5WtSFHTdeMhPZ42uBtsO7aQHfvqMWj1Z1Ky5vf61gb3ykOha5hiWVkqrBlO
         6ejIhCmOnGQbhwXL+o2TZL/H0J+fu8KExts2YRwlMv4gdZms8w4Li+eV/HoGWTCetxGq
         Eufhd8Y8c88pEEmJuHgl6uKvHigtOxRzYeYO3nfdlZrdFfXizl9MTpOAB0CDh3B+xgmz
         fdFKURkkg38aAzRHCtQb8tmee+yD88ucuQ48XIU030an43CCCU5SEiBM+gkQUgWt/V5G
         YuRUk+CgH31UAo1n7kDG9Yyjpld28vx2yUm5B3CSdp0290X3Tj+Wu0ipsoWu9ay/ZhD4
         QyTw==
X-Forwarded-Encrypted: i=1; AJvYcCWN9F2ANFqvNuy/0x+ByDqrHDllysexUgxHlusonIwKFeyQoSOuiM2ixntYgvfHg+xuUz5NHmOGfqH1GBWQ6rAvzxcb0L1V33IUjO0Y
X-Gm-Message-State: AOJu0Yy7i3yMo0Dejfxf+VHzHDDOQynd16WQx734tC3IS3rPP9PCOrZa
	BLXbE5RIQ0UCiN2CLraNpoprdMH30ipyquQkuNq3jNbnjoyOnj0KGJ2y+IEBXQgWhEvijK+zjsk
	nUU6eYU96YR6Qfff3hR+fI43M8j5aGmFhw8rnyfy3XdBMA3RRvQvdFWfd3m44cQZ8+UobWowCXT
	ZEfYFHXc8NdrtHCVDrNGGCd57FBZqJ2kR5uE2uDbMndzsbkop0tMQN
X-Received: by 2002:a2e:a4c8:0:b0:2ea:8191:ec47 with SMTP id 38308e7fff4ca-2ea84827c6dmr6745561fa.28.1717052915706;
        Thu, 30 May 2024 00:08:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGNzMz5WM60Dn387vCm1QkAb1S8YVIGqyKkJPuQe24YTk1ju3RtdlPlXZO/RYVScKuyUOSO1Z9O623Eurys8w=
X-Received: by 2002:a2e:a4c8:0:b0:2ea:8191:ec47 with SMTP id
 38308e7fff4ca-2ea84827c6dmr6745421fa.28.1717052915311; Thu, 30 May 2024
 00:08:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528100315.24290-1-en-wei.wu@canonical.com>
 <88c6a5ee-1872-4c15-bef2-dcf3bc0b39fb@molgen.mpg.de> <CAMqyJG0uUgjN90BqjXSfgq7HD3ACdLwOM8P2B+wjiP1Zn1gjAQ@mail.gmail.com>
 <971a2c3b-1cd9-48c5-aa50-e3c441277f0a@molgen.mpg.de>
In-Reply-To: <971a2c3b-1cd9-48c5-aa50-e3c441277f0a@molgen.mpg.de>
From: En-Wei WU <en-wei.wu@canonical.com>
Date: Thu, 30 May 2024 15:08:23 +0800
Message-ID: <CAMqyJG13Q+20p5gPpLZ1JYBS6yt5HZox0=gaT87vDyxN1rxRyA@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH] ice: irdma hardware init failed after suspend/resume
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: jesse.brandeburg@intel.com, intel-wired-lan@lists.osuosl.org, 
	rickywu0421@gmail.com, linux-kernel@vger.kernel.org, edumazet@google.com, 
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, davem@davemloft.net, wojciech.drewek@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your reply.

> Sorry for being unclear. I meant, does resuming the system take longer
> now? (initcall_debug might give a clue.)
I've tested the S3 suspend/resume with the initcall_debug kernel
command option, and it shows no clear difference between having or not
having the ice_init_rdma in ice_resume:
Without ice_init_rdma:
```
[  104.241129] ice 0000:86:00.0: PM: pci_pm_resume+0x0/0x110 returned
0 after 9415 usecs
[  104.241206] ice 0000:86:00.1: PM: pci_pm_resume+0x0/0x110 returned
0 after 9443 usecs
```
With ice_init_rdma:
```
[  122.749022] ice 0000:86:00.1: PM: pci_pm_resume+0x0/0x110 returned
0 after 9485 usecs
[  122.749068] ice 0000:86:00.0: PM: pci_pm_resume+0x0/0x110 returned
0 after 9532 usecs
```

> And ice_init_rdma should be moved to ice_rebuild (replace ice_plug_aux_de=
v)
We can defer the ice_init_rdma to the later service task by adopting this.

> You should call ice_deinit_rdma in ice_prepare_for_reset (replace ice_unp=
lug_aux_dev),
It seems like we must call ice_deinit_rdma in ice_suspend. If we call
it in the later service task, it will:
1. break some existing code setup by ice_resume
2. Since the PCI-X vector table is flushed at the end of ice_suspend,
we have no way to release PCI-X vectors for rdma if we had allocated
it dynamically
The second point is important since we didn't release the PCI-X
vectors for rdma (if we allocated it dynamically) in the original
ice_suspend, and it's somewhat like a leak in the original code.

Best regards,
Ricky.

On Thu, 30 May 2024 at 04:19, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear En-Wei,
>
>
> Thank you for responding so quickly.
>
> Am 29.05.24 um 05:17 schrieb En-Wei WU:
>
> [=E2=80=A6]
>
> >> What effect does this have on resume time?
> >
> > When we call ice_init_rdma() at resume time, it will allocate entries
> > at pf->irq_tracker.entries and update pf->msix_entries for later use
> > (request_irq) by irdma.
>
> Sorry for being unclear. I meant, does resuming the system take longer
> now? (initcall_debug might give a clue.)
>
>
> Kind regards,
>
> Paul

