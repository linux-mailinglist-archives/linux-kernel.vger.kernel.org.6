Return-Path: <linux-kernel+bounces-308137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE93A9657C0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768B628563B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A0A15099A;
	Fri, 30 Aug 2024 06:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="jToRsgt8"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46651D131D
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 06:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725000128; cv=none; b=cfmpWGZ8RibZnka6mi1ICzQzIVgiPkwfSy5MTj7Bcv1V+IbTJo5anFb+9d/+LxAisFDtU+z2sl4yRG+WhoAIJVBYYJj/dV+kDh18PPFB93SawdgtxwUq2whV5Gp1QV7m0n1Htay3KjpBqpj4OYsyEkKijE6c4a4wdqlBSDUBQdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725000128; c=relaxed/simple;
	bh=SPX2TYWXECL8SZx6jLAaGZ8DQ70DBpQ/cR7EuKTZ+xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbXtDtwixGxgLNzZz9vbKRaqkrH0oL0mrN588TwMAmf/yr+6iatQreO8NmXrCpBtMhXI9nAQP8iPewmUkFic3Jlaz4yDfW1pyEGBNPyzDMsVwqKYAeWhgfg4x+WXnj0gAOuEx83JQ6GkNge3jgvu6257mzxHfdhsWmG8Q60DWoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=jToRsgt8; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5335F3FB5F
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 06:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725000118;
	bh=stViVxHrBBEsBOu5+lfKdQqL1kmTozBEiuazG7uCPrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=jToRsgt8kmwgg4RG5Z47b3XeucXhnKLSs8NRhNR7f5Kd76fp4pJygRAwE9iVq3Rj0
	 +HXzJmqqfx+Gnex1C9ZhiNhNteMYuWoVhxlBUA9S9IWlyztHZXB1P/3ahPm5ye5COi
	 BYeJIYWE5yn+QbdGCtmzjsvhJbuYQoIHnsQvwZQBnpmfHxM6L0+pZBONlBhDEE7hUV
	 J/48MnHz6X4ipgk/nxjJsdEKy0dJuetYF4L0bj1EotClI+9lkHffsBF0d4APq+FYG2
	 epj5ux1861BTYeF5lEhz7hO/BuwLvN7p+VkXDt/Nvu3X6mv69Q9MhLKtHz6R1oJMlU
	 fl5w8l+/bjkvA==
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-714203541e1so1383246b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 23:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725000116; x=1725604916;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=stViVxHrBBEsBOu5+lfKdQqL1kmTozBEiuazG7uCPrc=;
        b=sJW8oPTIIzad8UWGOy8l1fCgHmdcHouPTG5BtHK3oDvYCBGrrONRZmSez0MI9Swt33
         ITbSLKz9g1qMKCGmbBHRzSOZ72xt26S+WSPFKzwpUJ/UT9s7cTiBwFFRxSzl6FF91kJB
         x76858WGwmv9B3yn+LQHvCKIc5IWalqnBuUGwzjqU/EbE8v3LtPqHg9L18zngtftVOxB
         LJ0IH2lgotSrT5/OhV2+FkBrgRqR6cPX3+cqm/L93wV6WzFHjVpWLGhsemYxkZI77ZKd
         3+y7E6qq+0LPDFQr2TfFtQPyYWbli6fa2CbDE8ZDibngElXTELu3s+rpvgTX6SpUUq2g
         9+lA==
X-Forwarded-Encrypted: i=1; AJvYcCXbCr8XQXxeSwQ9xaG42uh1/0cO5jDHSkUl3KIM7jSjfXAopAzbAxtYaiYsMVbgLsh6LCQMiKvNthM6X2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YycZ0lwKgvrU/xlMe6d/wNbQ6lc78uux0vdIHvimP0sGd1fsVBo
	bZ+SKjprHX8WrFHKpmqitcoKJdhcjW2XzJ4zNbX3bowuG2QCY4wbrztkm04QXpn8cHvNIiiRRdB
	hIiapaFP3X/4Zu+TwLUy3Leqrk+vaUY7/OIkR2BzY51iRx4RfXp0AARDkcRGyT12lopgN3Q0ilm
	bbqw==
X-Received: by 2002:a05:6a21:1304:b0:1cc:ecfc:4e19 with SMTP id adf61e73a8af0-1ccecfc5080mr2120881637.21.1725000116142;
        Thu, 29 Aug 2024 23:41:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaXyUn2dop9Ka0x8wrhn0wVdTWTZjUwZ/SlkcBN7yWlQ1nrIciaeWRmtziG4HoZZ26ik1ehQ==
X-Received: by 2002:a05:6a21:1304:b0:1cc:ecfc:4e19 with SMTP id adf61e73a8af0-1ccecfc5080mr2120843637.21.1725000115369;
        Thu, 29 Aug 2024 23:41:55 -0700 (PDT)
Received: from kylee-ThinkPad-E16-Gen-1 ([122.147.171.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2051556a712sm20796435ad.307.2024.08.29.23.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 23:41:55 -0700 (PDT)
Date: Fri, 30 Aug 2024 14:41:49 +0800
From: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
To: lijiang <lijiang@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, Will Deacon <will@kernel.org>,
	HAGIO =?utf-8?B?S0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	ardb@kernel.org
Subject: Re: [PATCH] arm64/vmcore: Add pgtable_l5_enabled information in
 vmcoreinfo
Message-ID: <ZtFprQX-UzyqnKTH@kylee-ThinkPad-E16-Gen-1>
References: <20240826065219.305963-1-kuan-ying.lee@canonical.com>
 <20240827122459.GA4679@willie-the-truck>
 <Zs5Xo5eVUvGMbtSv@MiWiFi-R3L-srv>
 <CANU+ZydbFPiSnCRr3qQ52GjUQQmU3ZO62c6hRkoLM147+u5u8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANU+ZydbFPiSnCRr3qQ52GjUQQmU3ZO62c6hRkoLM147+u5u8w@mail.gmail.com>

On Wed, Aug 28, 2024 at 05:37:07PM +0800, lijiang wrote:
> On Wed, Aug 28, 2024 at 6:48 AM Baoquan He <bhe@redhat.com> wrote:
> 
> > On 08/27/24 at 01:24pm, Will Deacon wrote:
> > > On Mon, Aug 26, 2024 at 02:52:02PM +0800, Kuan-Ying Lee wrote:
> > > > Since arm64 supports 5-level page tables, we need to add this
> > > > information to vmcoreinfo to make debug tools know if 5-level
> > > > page table is enabled or not.
> > > >
> > > > Missing this information will break the debug tool like crash [1].

Sorry, the above line was mistakenly expressed.

Currently, the crash tool doesn't support 4K page with 5-level
page tables (LPA2), so I initially planned to add this
information to implement support for 4K page with 5-level page
table in the crash tool.

> > > >
> > > > [1] https://github.com/crash-utility/crash
> > > >
> > > > Signed-off-by: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
> > > > ---
> > > >  Documentation/admin-guide/kdump/vmcoreinfo.rst | 6 ++++++
> > > >  arch/arm64/kernel/vmcore_info.c                | 3 +++
> > > >  2 files changed, 9 insertions(+)
> > >
> > > In which case, wouldn't you also want to know about pgtable_l4_enabled()?
> >
> > That is a good question. I guess it's deduced in code, mostly needed for
> > different PAGE_OFFSET, how to transfer virtual addr to physical addr,
> > etc.
> >
> >
> Thanks for the information, Baoquan.
> 
> If I understand correctly, for arm64, currently, the crash tool determines
> the levels of the page table based on page size and va_bits, and then
> decides how to translate the address, such as calculating it in conjunction
> with other values, e.g: kernel pgd, offset, etc.

Thanks for the information. I will then try to use VA_BITS to determine
if it is a 5-level page table.
Let me investigate further.

Thanks,
Kuan-Ying Lee

> 
> For more details, please refer to this one:
> https://github.com/crash-utility/crash/blob/master/arm64.c
> 
> 
> Thanks
> Lianbo
> 
> 
> > Add Crash utility experts here.
> >
> >

