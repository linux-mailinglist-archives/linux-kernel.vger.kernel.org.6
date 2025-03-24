Return-Path: <linux-kernel+bounces-573408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1282A6D6D0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 10:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 527EA16F049
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6CA25D8FE;
	Mon, 24 Mar 2025 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8W3imgH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B11BA36
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742806830; cv=none; b=cYjy7NKk8Bj7DL/e97OSnVVXaiY9GP/s7sM40Gv4zHKplGvbK9WAqTUYRuXjDgGSav8O+TQ/u5xkq3s8KPMwqVwGGIGJ36FWbDRNX/i9j3osJmvCGVCBrY7fR3Fl7FjQJPP/K+2f+fkB7vlFSZdiIlbihf1S/ga5Ujd14WWpq3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742806830; c=relaxed/simple;
	bh=VtQd7ZzM47zcnMCUYhBnsvT1LXfPEQwzDz8Bh3c7XCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dCNGdbsOwI/I8Wi9AilHJTeyI+LCXmVSkDqV3CY6VEw0SNXLjpgilzXjbl+CqoWfr/muiNTpQTC6XzY1176VRkq2yikzSH/6RsaQxsHiwNGtC0aFXQeEwLHbLDeeMM4CGanhqmmXr8QL9zu1+saJJjk5VH7EV1smvbiWY+cAjw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f8W3imgH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742806827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VtQd7ZzM47zcnMCUYhBnsvT1LXfPEQwzDz8Bh3c7XCo=;
	b=f8W3imgHQDwXw0i2P5OswevKLG1hVDs2Unv13e0zditilNjh+tGmJ5URsUEegD1faWWJBF
	WXLhtR7ekTaXp65/BQ3pX/3IBNit6/WsDBVJJ9XeCu1FkqNeHJhk9qTRPVY3l041wCkyUs
	PKCqzhZAdBKHoAYeBsK+i9EVv7kVlLw=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-yy-ICBgxMmmxUKjCNE3yUw-1; Mon, 24 Mar 2025 05:00:26 -0400
X-MC-Unique: yy-ICBgxMmmxUKjCNE3yUw-1
X-Mimecast-MFC-AGG-ID: yy-ICBgxMmmxUKjCNE3yUw_1742806825
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-6fecf913cb1so51215777b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 02:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742806825; x=1743411625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VtQd7ZzM47zcnMCUYhBnsvT1LXfPEQwzDz8Bh3c7XCo=;
        b=Jc5NBIgf8trtmvpIEPT1jrYlxOvFFwoFcpGt587I86O2Fcj8XwLfxign9kWQ6MomGl
         yQhhIqIYCg2xPNykTp/3iRY9Q3hpQuexUnezX3mH3pF3JNLddwGkDN0F63mgZqYNhEBi
         6Hq71CYBY727UNvsviaIwQtkKHZ6Fxz+ty6w3Ck2zp8Mri5V5P7YqmkZotSiGS5QSfTx
         4SsCKUCpILZJN1Hv2s5P1EPMixGCLfM/qOVb3HrsYFpNzRuf1lL3fOgprajTyPI77WAj
         vyP0lflpCypmXgoPPKQQoJ2kkBGNLwEZxSfAshgdBCHLQpENyAyHAfCGyAm/HfJWFhPV
         ieZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV10E6bAPZmATrZEmLzJiLH9j7OubIq3Bj6DRwI46nNo+okEjJhKtxUSD+WfHWcX6CTEWXr7Tb4wH7RQrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YytJhts2Opl12p3QaJnijivTH7OpLACGssMUcirB2DKErOA1aRk
	35ybjcaOzH8qKTOnYEHd5v+g8g5oC5VouURpcZ5a6zw4A0jlHBF7yqWgB9xBfjQ2rE4hVgJ7bJu
	PzKKTMHygQjFdTYC5MHfs9wLd6FTXCvNMGJ8qhQFOgE1kg2bib5APgWJrRyD8ZFezzopzd6XC2w
	AesSZktH6sojVcS5ibXcIhp6mYpm4ZT7OueIYI
X-Gm-Gg: ASbGncuggQvpGAW6aso4AXuDDXgedBrYjxKp/n+F3knalEeLHzoytfzRFbmMUd/vw6a
	FbuorVdoRSUZyPZanR9PUQegFwCRD0a+O0+z6C4KHZAuxBchxHqrtWSkS+M5bL4WCuPki8Q==
X-Received: by 2002:a05:690c:3588:b0:6fe:b109:6973 with SMTP id 00721157ae682-700bacfba94mr158095927b3.24.1742806825340;
        Mon, 24 Mar 2025 02:00:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrUHGJpHADoIDbX/Sou896YczE/U5d5SAf7THitdTqPnQR8uE2GhDufDdh/tsFnucbOoNKGD29uDDAHCwOw5c=
X-Received: by 2002:a05:690c:3588:b0:6fe:b109:6973 with SMTP id
 00721157ae682-700bacfba94mr158095497b3.24.1742806824797; Mon, 24 Mar 2025
 02:00:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311094225.35129-1-sgarzare@redhat.com> <20250311094225.35129-2-sgarzare@redhat.com>
 <d7e5a1d2-5fcc-bf7f-a67d-7871a1627c98@amd.com> <Z9glWp6U6vyEmKQa@kernel.org>
 <7kuhiyy7gj4py323g5n2vy3ddlg666zwhtx3mjcklebgtlstdc@xgdyeecifwei>
 <Z9wuLVeP726Cssqp@kernel.org> <20250320171619.GOZ9xNY4W54avW2a-u@fat_crate.local>
 <Z9xQw8QpRKk26G6R@kernel.org> <rspkz663fg7i7jomvg5ehv3ldr6ayehttb7vgwwzsfsxafzb5y@uhqcadvsmw6f>
 <20250321220520.GFZ93ioO0JtfhXCb1n@fat_crate.local> <Z98av2cbURhSy6Rk@kernel.org>
In-Reply-To: <Z98av2cbURhSy6Rk@kernel.org>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 24 Mar 2025 10:00:13 +0100
X-Gm-Features: AQ5f1Jq8rkzGdhbXeWVtUWD697l_-G9Y-_hvBqVxJBnsvHw0N0RMVXOA163V3KQ
Message-ID: <CAGxU2F68_3nAzgPNj0m1SX-RPumuM2utX6B0-s4GDvFixJmt7g@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] x86/sev: add SVSM vTPM probe/send_command functions
To: Jarkko Sakkinen <jarkko@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Peter Huewe <peterhuewe@gmx.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>, 
	Dionna Glaze <dionnaglaze@google.com>, linux-coco@lists.linux.dev, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"

On Sat, Mar 22, 2025 at 10:17:03PM +0200, Jarkko Sakkinen wrote:
>On Fri, Mar 21, 2025 at 11:05:20PM +0100, Borislav Petkov wrote:
>> On Fri, Mar 21, 2025 at 10:01:17AM +0100, Stefano Garzarella wrote:
>> > Just a note, patch 2 adds `include/linux/svsm_vtpm.h`, that file is
>> > basically a translation of the AMD SVSM specification into structures and
>> > functions used to communicate with SVSM in the way it is defined by the
>> > specification.
>> >
>> > I realized that the file does not fall under any section of MAINTAINERS.
>> > How do you suggest we proceed?
>> >
>> > Should we create an SVSM section to maintain it, including the TPM driver
>> > and future other drivers,etc.?
>>
>> This all belongs to the TPM drivers, right?

For now yes, we may have other devices in the future, but we can think
about that later.

>>
>> I.e., drivers/char/tpm/
>>
>> So I guess add that header to the TPM DEVICE DRIVER section if the gents there
>> are fine with it...
>
>It's fine for me but I'd suggest to rename the header as "tpm_svsm.h".
>Then this will already provide coverage:
>
>https://web.git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=a2fbcecc7027944a2ce447d4dd72725c5822321f
>

Great, I'll rename it and send v4.

Thanks,
Stefano


