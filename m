Return-Path: <linux-kernel+bounces-219754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD12390D8CF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F750B25769
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA702C19E;
	Tue, 18 Jun 2024 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPJgA2o1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE04D24B26
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724569; cv=none; b=ScdR90HfjLFInTlTdI417vX1DU/v1Qh0HG3yftEjAz3WrJGrQzRQow0Tig4rmKhCXyJfO1bti3gr9HDCk7IguITvMsbj7xYTwsh/q8Tlc94s5rchk3R9LQgCspuuJt8Uw3kXF77fpAalhxJMtUD14Ud76OSGMuP4lVWNCbOLWfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724569; c=relaxed/simple;
	bh=TG21y/qDqCjS/KRsSTEig3GJf7UCaKAZ3Qv9HtDwB50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e73zUnwbiSDEVwYsr/V+n++YusUJujrhba4RVx1azgBUlBmDAHy+HGNUf/zIVWn6COIKr5BwaU2XyDtxurqV4ZU7PZilbfIdandicy8FL5EANwyo7Q8gQW9PD0HPQ6po4fXl+iyMP6C3R/uVxdiQ3VJN0+OSOy5c3aU6gFHfO4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPJgA2o1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A6FC3277B;
	Tue, 18 Jun 2024 15:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718724569;
	bh=TG21y/qDqCjS/KRsSTEig3GJf7UCaKAZ3Qv9HtDwB50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cPJgA2o1NK9yDTJXz0NUaQDmJBzUQL9HjmgWpihepZnBwCm7J0cme55QC8TZHc+Ey
	 ogui/l8cYvnBL/E20T9ZBtVNauA3UPIwZlUNliK92kZxhYAn+VRFwwJgjkK1Z4Aa6Z
	 9bgmSvR/0MopKoXyCGfdqrKfBlpgrZTBbMgA8VtfFGLb5pRS+6CslR0LpYVinCctYL
	 ppyWQYD4IlD3IUenVTuDmCtjaB7ZJS4acC2PKuH7OPz3PrKxEHDNUE9IVj4rpGyGJO
	 7pK3t2A949RjZEnvpXgF219Jn2Kp0v9pXnrkYqLzjHu4aV5VmXQW79THoEyH45ftTs
	 IwzMaoON7tpRQ==
Date: Tue, 18 Jun 2024 16:29:24 +0100
From: Will Deacon <will@kernel.org>
To: Prarit Bhargava <prarit@redhat.com>, sudeep.holla@arm.com,
	lpieralisi@kernel.org, guohanjun@huawei.com
Cc: Liu Wei <liuwei09@cestc.cn>, catalin.marinas@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	liuwei09.cestc.cn@cecloud.com, rafael@kernel.org
Subject: Re: [PATCH] ACPI: Do not enable ACPI SPCR console by default on arm64
Message-ID: <20240618152923.GB2354@willie-the-truck>
References: <20240530015332.7305-1-liuwei09@cestc.cn>
 <cb4c5fd0-9629-4362-918a-cb044eb9e558@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb4c5fd0-9629-4362-918a-cb044eb9e558@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, May 30, 2024 at 09:06:17AM -0400, Prarit Bhargava wrote:
> On 5/29/24 21:53, Liu Wei wrote:
> > Consistency with x86 and loongarch, don't enable ACPI SPCR console
> > by default on arm64
> > 
> > Signed-off-by: Liu Wei <liuwei09@cestc.cn>
> > ---
> >   arch/arm64/kernel/acpi.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> > index dba8fcec7f33..1deda3e5a0d2 100644
> > --- a/arch/arm64/kernel/acpi.c
> > +++ b/arch/arm64/kernel/acpi.c
> > @@ -227,7 +227,8 @@ void __init acpi_boot_table_init(void)
> >   		if (earlycon_acpi_spcr_enable)
> >   			early_init_dt_scan_chosen_stdout();
> >   	} else {
> > -		acpi_parse_spcr(earlycon_acpi_spcr_enable, true);
> > +		/* Do not enable ACPI SPCR console by default */
> > +		acpi_parse_spcr(earlycon_acpi_spcr_enable, false);
> >   		if (IS_ENABLED(CONFIG_ACPI_BGRT))
> >   			acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
> >   	}
> 
> It's been a while, and the status of arm hardware may have changed. IIRC the
> choice to force enable this is that most arm hardware is headless and this
> was a _required_ option for booting.
> 
> I'm not sure if that's still the case as it's been a long time.
> 
> Can anyone from the ARM community provide an approval here?

I don't have a strong opinion either way, but adding the Arm ACPI folks
in case they care.

Having said that, if the only rationale for this patch is consistency
with other architectures, then I think I'd lean towards leaving the
behaviour as-is so we don't give users a nasty surprise on their next
kernel upgrade.

Will

