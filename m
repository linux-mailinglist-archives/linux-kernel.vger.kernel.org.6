Return-Path: <linux-kernel+bounces-219883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D9C90D978
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC1B1C22A3C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42416768E1;
	Tue, 18 Jun 2024 16:40:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204072139DD
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718728830; cv=none; b=I/5ltM2FbqtpgKN4b4l5erHjKwoy/rllcntvHLNfAGeud6BRzFe7kIYqw9VHkOdzx/UVm7v8gHb+wIv6i7S03aJRqpUNI4q4fEq93v9snlI8W/FzhyTsJDS3jfAUEelJuhjMYwfRKFKB1+uiVqC7Ov1uBg951y5gPlL4WsB+AOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718728830; c=relaxed/simple;
	bh=N9KrzFNS7b0Rbv3dE4I/iQfsEjfw8rze0C3KkWiq2QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AxiROcTc+NO08mHBb9CK1N7BW9QhHQiXz1kMRThJQCVtIjsmU/ivSg871rLgfLuWZ5jq2Jzo9X7WXwfXUZ0Lh8xyMFPz2U7AfTjtyqWp9fGHieS5vy6GsWt3hn9z0sZO80yTTfUzJnJVkEunNWeqgXhY2J9JpNh71WnulzCq3zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0659ADA7;
	Tue, 18 Jun 2024 09:40:53 -0700 (PDT)
Received: from bogus (unknown [10.57.89.235])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99DC73F6A8;
	Tue, 18 Jun 2024 09:40:26 -0700 (PDT)
Date: Tue, 18 Jun 2024 17:40:24 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Prarit Bhargava <prarit@redhat.com>, lpieralisi@kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, guohanjun@huawei.com,
	Liu Wei <liuwei09@cestc.cn>, catalin.marinas@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	liuwei09.cestc.cn@cecloud.com, rafael@kernel.org
Subject: Re: [PATCH] ACPI: Do not enable ACPI SPCR console by default on arm64
Message-ID: <20240618164024.tehpbscax47jkluj@bogus>
References: <20240530015332.7305-1-liuwei09@cestc.cn>
 <cb4c5fd0-9629-4362-918a-cb044eb9e558@redhat.com>
 <20240618152923.GB2354@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618152923.GB2354@willie-the-truck>

On Tue, Jun 18, 2024 at 04:29:24PM +0100, Will Deacon wrote:
> On Thu, May 30, 2024 at 09:06:17AM -0400, Prarit Bhargava wrote:
> > On 5/29/24 21:53, Liu Wei wrote:
> > > Consistency with x86 and loongarch, don't enable ACPI SPCR console
> > > by default on arm64
> > >
> > > Signed-off-by: Liu Wei <liuwei09@cestc.cn>
> > > ---
> > >   arch/arm64/kernel/acpi.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> > > index dba8fcec7f33..1deda3e5a0d2 100644
> > > --- a/arch/arm64/kernel/acpi.c
> > > +++ b/arch/arm64/kernel/acpi.c
> > > @@ -227,7 +227,8 @@ void __init acpi_boot_table_init(void)
> > >   		if (earlycon_acpi_spcr_enable)
> > >   			early_init_dt_scan_chosen_stdout();
> > >   	} else {
> > > -		acpi_parse_spcr(earlycon_acpi_spcr_enable, true);
> > > +		/* Do not enable ACPI SPCR console by default */
> > > +		acpi_parse_spcr(earlycon_acpi_spcr_enable, false);
> > >   		if (IS_ENABLED(CONFIG_ACPI_BGRT))
> > >   			acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
> > >   	}
> >
> > It's been a while, and the status of arm hardware may have changed. IIRC the
> > choice to force enable this is that most arm hardware is headless and this
> > was a _required_ option for booting.
> >
> > I'm not sure if that's still the case as it's been a long time.
> >
> > Can anyone from the ARM community provide an approval here?
>
> I don't have a strong opinion either way, but adding the Arm ACPI folks
> in case they care.
>
> Having said that, if the only rationale for this patch is consistency
> with other architectures, then I think I'd lean towards leaving the
> behaviour as-is so we don't give users a nasty surprise on their next
> kernel upgrade.
>

+1, I am concerned about breaking existing behaviour on the platforms
in the wild. Also many platforms running ACPI would have already used
console cmdline parameter if SPCR is not their choice for the console.
So I don't see the need to align with other arch default behaviour here,
we can revisit if someone shouts with a real reason as why cmdline option
is not viable.

--
Regards,
Sudeep

