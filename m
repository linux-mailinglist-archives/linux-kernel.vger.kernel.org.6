Return-Path: <linux-kernel+bounces-220462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C363390E212
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 05:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 496591F23D36
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 03:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC56B5588E;
	Wed, 19 Jun 2024 03:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="yNSygeqS"
Received: from smtp.cecloud.com (unknown [1.203.97.246])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971342914
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 03:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.203.97.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718768949; cv=none; b=fIaDKQLLyB4cDsyybI3yob5OFP5yB4RwkOKk/BA5iIqBMQBdQ/icYUVw6foDIhepLyqjxlm2VhuglvcXgsvVrT/1ppfNKUhJXaO6HYddQ7GYJ7sEDPKn32giPWEqq1b0ts2M/m12Ir8EGLJzYvgrB94lkGKojkXaz57B1QJxD1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718768949; c=relaxed/simple;
	bh=0wu43ss5MZxU6auseVgUcpp02zVtPRgsQ2zs5rmjFlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=o0UlAeoX2Rays/GKgwz2rXKHjYvB/WpXRho3yAiJwHq9MpkaUHiPvDOmDapvyTvGsa5ocI4QMhfs/ru5g8UwQQT2HAetbWw4rgWZiDTCC74++uco4Dh0FGDsY+PFGZRXTjSlfhNFWsKBHYFwjfK1acdXscRxEVucO25d1lFkqew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn; spf=pass smtp.mailfrom=cestc.cn; dkim=fail (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b=yNSygeqS reason="signature verification failed"; arc=none smtp.client-ip=1.203.97.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cestc.cn
Received: from localhost (localhost [127.0.0.1])
	by smtp.cecloud.com (Postfix) with ESMTP id E561E7C0112;
	Wed, 19 Jun 2024 11:43:34 +0800 (CST)
X-MAIL-GRAY:0
X-MAIL-DELIVERY:1
X-SKE-CHECKED:1
X-ABS-CHECKED:1
X-ANTISPAM-LEVEL:2
Received: from localhost.localdomain (unknown [111.48.69.245])
	by smtp.cecloud.com (postfix) whith ESMTP id P2702681T281466040545648S1718768612546527_;
	Wed, 19 Jun 2024 11:43:34 +0800 (CST)
X-IP-DOMAINF:1
X-RL-SENDER:liuwei09@cestc.cn
X-SENDER:liuwei09@cestc.cn
X-LOGIN-NAME:liuwei09@cestc.cn
X-FST-TO:sudeep.holla@arm.com
X-RCPT-COUNT:10
X-LOCAL-RCPT-COUNT:1
X-MUTI-DOMAIN-COUNT:0
X-SENDER-IP:111.48.69.245
X-ATTACHMENT-NUM:0
X-UNIQUE-TAG:<c586e26224d9f0c4143127ebe1860d4b>
X-System-Flag:0
From: Liu Wei <liuwei09@cestc.cn>
To: sudeep.holla@arm.com,
	Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com,
	guohanjun@huawei.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	liuwei09@cestc.cn,
	lpieralisi@kernel.org,
	prarit@redhat.com,
	rafael@kernel.org
Subject: Re: [PATCH] ACPI: Do not enable ACPI SPCR console by default on arm64
Date: Wed, 19 Jun 2024 11:43:21 +0800
Message-ID: <20240618164024.tehpbscax47jkluj@bogus>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240618152923.GB2354@willie-the-truck>
References: <20240530015332.7305-1-liuwei09@cestc.cn> <cb4c5fd0-9629-4362-918a-cb044eb9e558@redhat.com> <20240618152923.GB2354@willie-the-truck>
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133]) (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits)) (No client certificate requested) by smtp.lore.kernel.org (Postfix) with ESMTPS id 41841C27C4F for <linux-arm-kernel@archiver.kernel.org>; Tue, 18 Jun 2024 16:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help :List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type: MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To: Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date: Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner; bh=0yJM0ovOkN6GK5Bd8SBBgPGoyqQCrIxqepYNCbNI5Is=; b=yNSygeqS9A/PB8UajuVNFuKbMc fjjRiRUe4vxdoI778yxuyban3Pzx7uxXDDxm1MOjkW5oXuhWpzP50DBGebGmzz8LY2fJvkBmFtjEJ OGg+e2cXGYc58UgZiBCxGSGenwMVBRNHZrzjSWMxOQNLjLK3e+uHL2TlzPS8Ek87uzcDxqNEfutVK utK5pyzu8ITAigz7WmiTh+JARzIG8+TGNxXrvlAwBG2wmWNdk2ZyFxVmMdeE66zQTLTYAe83jgr1I zdKNyM/bceJFxfgYGGaspZ7rvV32uP+IemZDR9QjE+BxBNqgSq+N5ExfrtT45Z4YLE8tclPf9bZUE AKYVwc1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org) by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux)) id 1sJbsq-0000000FtAJ-3GCl; Tue, 18 Jun 2024 16:40:36 +0000
Received: from foss.arm.com ([217.140.110.172]) by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux)) id 1sJbsk-0000000Ft9T-0WP6 for linux-arm-kernel@lists.infradead.org; Tue, 18 Jun 2024 16:40:33 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14]) by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0659ADA7; Tue, 18 Jun 2024 09:40:53 -0700 (PDT)
Received: from bogus (unknown [10.57.89.235]) by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99DC73F6A8; Tue, 18 Jun 2024 09:40:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=archiver.kernel.org@lists.infradead.org
Content-Transfer-Encoding: 8bit

From: Sudeep Holla <sudeep.holla@arm.com>

On Tue, Jun 18, 2024 at 04:29:24PM +0100, Will Deacon wrote:
> > On Thu, May 30, 2024 at 09:06:17AM -0400, Prarit Bhargava wrote:
> > > On 5/29/24 21:53, Liu Wei wrote:
> > > > Consistency with x86 and loongarch, don't enable ACPI SPCR console
> > > > by default on arm64
> > > >
> > > > Signed-off-by: Liu Wei <liuwei09@cestc.cn>
> > > > ---
> > > >   arch/arm64/kernel/acpi.c | 3 ++-
> > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> > > > index dba8fcec7f33..1deda3e5a0d2 100644
> > > > --- a/arch/arm64/kernel/acpi.c
> > > > +++ b/arch/arm64/kernel/acpi.c
> > > > @@ -227,7 +227,8 @@ void __init acpi_boot_table_init(void)
> > > >   		if (earlycon_acpi_spcr_enable)
> > > >   			early_init_dt_scan_chosen_stdout();
> > > >   	} else {
> > > > -		acpi_parse_spcr(earlycon_acpi_spcr_enable, true);
> > > > +		/* Do not enable ACPI SPCR console by default */
> > > > +		acpi_parse_spcr(earlycon_acpi_spcr_enable, false);
> > > >   		if (IS_ENABLED(CONFIG_ACPI_BGRT))
> > > >   			acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
> > > >   	}
> > >
> > > It's been a while, and the status of arm hardware may have changed. IIRC the
> > > choice to force enable this is that most arm hardware is headless and this
> > > was a _required_ option for booting.
> > >
> > > I'm not sure if that's still the case as it's been a long time.
> > >
> > > Can anyone from the ARM community provide an approval here?
> >
> > I don't have a strong opinion either way, but adding the Arm ACPI folks
> > in case they care.
> >
> > Having said that, if the only rationale for this patch is consistency
> > with other architectures, then I think I'd lean towards leaving the
> > behaviour as-is so we don't give users a nasty surprise on their next
> > kernel upgrade.
> >
> 
> +1, I am concerned about breaking existing behaviour on the platforms
> in the wild. Also many platforms running ACPI would have already used
> console cmdline parameter if SPCR is not their choice for the console.
> So I don't see the need to align with other arch default behaviour here,
> we can revisit if someone shouts with a real reason as why cmdline option
> is not viable.

For varying privacy and security reasons, sometimes we would like to 
completely silence the serial console output, and only enable it through
cmdline when needed.

On ARM, it is difficult because SPCR is enabled by default.

Thanks for your patience,
Liu Wei

> 
> --
> Regards,
> Sudeep





