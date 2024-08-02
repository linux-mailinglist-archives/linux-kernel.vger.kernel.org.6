Return-Path: <linux-kernel+bounces-272673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E04945FBA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F17628252E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 14:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17ACE2101B0;
	Fri,  2 Aug 2024 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GU/nwbpI"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8E51C693
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722610521; cv=none; b=lX3kjc9SPFeDrWk+ZXeSW0dP6UShmrpWvKnF/Haglct3nAfnioON7BaBqOmjjsXrdaAXMQLKOm/cqkuiNYQcPlJcLADutrrW+7PLUMtXHsF2VqLn8dFa/Y4dioWQa9j2p0fJU/TMWhZuwHMg6nJd//oLafrtwY5KDuUq8bi+g28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722610521; c=relaxed/simple;
	bh=sIShp8PygITE34fsiiaEoyWsB81wo/QAF8+dAxPe14o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AJhczeSI+qxzeGb02rjfvCuuLGmwrsV+xNqAReFXxonqmkfSx6eYgSWPk67waNm5Kw8lKWVo/NnUH4vHBUxZ6YeRMTYCdhT5TLhPOeKWAW9PF7giC9KqWbfpk9/doJcAQ1w6QXqh1fuAbNWHTEvee/zNO+7i4Qw1XHoxBHLMTE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GU/nwbpI; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1fd8677380dso75251145ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 07:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722610519; x=1723215319; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k+EldIAhaXOwZDf7ZBJIgAZ18Tox4DVTl3CjOfhylXA=;
        b=GU/nwbpIgiPDQEkalaSYlSdVPA+ZpobhY3uLDVUw7axazg66zLw5yRQKAGkePQz6Un
         6JNP/BvJz4FF9PH0SnuQ2qBsHVRE18tfwk0Loq6pkKLQKVU9pOcc1vUN/Z1+2KqtbPCX
         LWkFx94ZHojsQdICGWaWfO7SthC9T9oU4TRgnKdzqrNAhwkwXlSRXHXpfrWnwsxL0bNZ
         qU9q251+6vASx13p7I2qH55A6XHnJUEkkzWmzlRYaD/JjNHvEvxb3br640wV11hbKECx
         1If2IFtgmTDz3IV9d2bVkRDXLcpMTq9FuyWMFuDaUKxm0SO29AxoC0gm4TkXoWGwIWm0
         b+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722610519; x=1723215319;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+EldIAhaXOwZDf7ZBJIgAZ18Tox4DVTl3CjOfhylXA=;
        b=YnCJuJRAqAByh8BA4wAslooX05zknTwhObvdKc37ttJ+cQlvdI77zN2/WWlxUod/Sm
         8BECMeYiELcND/+ilXwZjl38kPM4DPCD5i/aFG47dBhqksXhz7VUWr/SfrkHdA4DiBst
         eJqBfLhlwPOELLB39RW02FooAfC3SvBXsgzh4pkI/rW5M4VjbS+9sCm3QY9QVXK1H/+x
         ZaDfwaIu/ffO7ujm78zqAqmU70729L9NIi1TFs+M2j+dXGDLF/26wm+xuSTpdV4ovzWQ
         ij022fiMhJa5JnZ+fyjRS+2Jq41Iofb8MZOnW1/J4jKFFVm0LmeLlB6SP47RGFIQvYPb
         TrDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0o1zCLP7rlO4i8cE7QGK3R2EfqASlJ3TIaFWaCRofMP5jCknXYRGcaGWjMY6IKg5PQUffTK9kJOUKiuAnAwXwjcvInbDJvhvhBKH5
X-Gm-Message-State: AOJu0Yyi1QfAcmBnt4RMBVnDCVPq5kXkbug4HWLjbkx1cJFCehEepQry
	AcTAbfb+kehObOOixF8Vl1rLaxeYcjiprMo8n/iGP86HcXmZgGaX46a+xz3Uhan/HLBUNgxc5vK
	JZw==
X-Google-Smtp-Source: AGHT+IGDrBHggFrxqDLcgkFZ6IvfF7sYOmSA66OWPSAnanySGoaTtmAM8Sq2VGr1qCWq8rCIKRKN7O0JKj0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:1ce:b0:1fa:d491:a4a0 with SMTP id
 d9443c01a7336-1ff57291ca7mr3689455ad.2.1722610519056; Fri, 02 Aug 2024
 07:55:19 -0700 (PDT)
Date: Fri, 2 Aug 2024 07:55:17 -0700
In-Reply-To: <30eb7680b3c7ae5370dfbf7510e664181f38b80e.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <1675732476-14401-1-git-send-email-lirongqing@baidu.com>
 <87ttg42uju.ffs@tglx> <SN6PR02MB41571AE611E7D249DABFE56DD4B22@SN6PR02MB4157.namprd02.prod.outlook.com>
 <87o76c2hw2.ffs@tglx> <30eb7680b3c7ae5370dfbf7510e664181f38b80e.camel@infradead.org>
Message-ID: <ZqzzVRQYCmUwD0OL@google.com>
Subject: Re: [PATCH] clockevents/drivers/i8253: Do not zero timer counter in shutdown
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Michael Kelley <mhklinux@outlook.com>, 
	"lirongqing@baidu.com" <lirongqing@baidu.com>, "kys@microsoft.com" <kys@microsoft.com>, 
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, 
	"decui@microsoft.com" <decui@microsoft.com>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 02, 2024, David Woodhouse wrote:
> On Thu, 2024-08-01 at 20:54 +0200, Thomas Gleixner wrote:
> > On Thu, Aug 01 2024 at 16:14, Michael Kelley wrote:
> > > I don't have a convenient way to test my sequence on KVM.
> > 
> > But still fails in KVM
> 
> By KVM you mean the in-kernel one that we want to kill because everyone
> should be using userspace IRQ chips these days?

What exactly do you want to kill?  In-kernel local APIC obviously needs to stay
for APICv/AVIC.

And IMO, encouraging userspace I/O APIC emulation is a net negative for KVM and
the community as a whole, as the number of VMMs in use these days results in a
decent amount of duplicated work in userspace VMMs, especially when accounting
for hardware and software quirks.

