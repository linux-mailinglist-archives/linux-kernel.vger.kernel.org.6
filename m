Return-Path: <linux-kernel+bounces-196172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5CA8D5865
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 03:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEBAB284E1F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE6B524D7;
	Fri, 31 May 2024 01:52:32 +0000 (UTC)
Received: from smtp.cecloud.com (unknown [1.203.97.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842626FB8
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 01:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.203.97.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717120351; cv=none; b=Zp3VbHNbl2OvRgeETTXzFiPm8Heu+2hYxny2TlNaeDgrE+M6xRqdXvTJBLA8ldsjinKxJ7s3TB3FJ6+0BZrnaZhsUvtxucmFD1kk26N/33WnegTg8wvztB+Bu5upv9s1Tub2HYGgbzH6+HqRMp9HoJ/ctrGG01kn8TlcBoH+Dlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717120351; c=relaxed/simple;
	bh=bUDgZ5NKzkWAq/TYx2si92h4CMQih6Yz/n9hN43R3Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UdiXmM3/I1Io1jj53RrWy1Pi+cPaWkYrtDkk1xhyuM5KoIj+2JDzQXq5aPTlqCOOgejlmanN1zP3APXcweI4z2lHCQXRJtU4sPJXObjTlbr+fvRYiP4JFtc/kAkBYgD+05FRX6VjNe70COPUgO6aVdCslNMs6J31rxrzaA4dKxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn; spf=pass smtp.mailfrom=cestc.cn; arc=none smtp.client-ip=1.203.97.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cestc.cn
Received: from localhost (localhost [127.0.0.1])
	by smtp.cecloud.com (Postfix) with ESMTP id 8C10E90011B;
	Fri, 31 May 2024 09:52:23 +0800 (CST)
X-MAIL-GRAY:0
X-MAIL-DELIVERY:1
X-ANTISPAM-LEVEL:2
X-ABS-CHECKED:0
Received: from localhost.localdomain (unknown [111.48.58.12])
	by smtp.cecloud.com (postfix) whith ESMTP id P894637T281472896332144S1717120342486087_;
	Fri, 31 May 2024 09:52:23 +0800 (CST)
X-IP-DOMAINF:1
X-RL-SENDER:liuwei09@cestc.cn
X-SENDER:liuwei09@cestc.cn
X-LOGIN-NAME:liuwei09@cestc.cn
X-FST-TO:prarit@redhat.com
X-RCPT-COUNT:6
X-LOCAL-RCPT-COUNT:1
X-MUTI-DOMAIN-COUNT:0
X-SENDER-IP:111.48.58.12
X-ATTACHMENT-NUM:0
X-UNIQUE-TAG:<666a897c7f365ab69d3846c267c805c7>
X-System-Flag:0
From: Liu Wei <liuwei09@cestc.cn>
To: prarit@redhat.com,
	Liu Wei <liuwei09@cestc.cn>,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: Do not enable ACPI SPCR console by default on arm64
Date: Fri, 31 May 2024 09:52:08 +0800
Message-ID: <cb4c5fd0-9629-4362-918a-cb044eb9e558@redhat.com> (raw)
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240530015332.7305-1-liuwei09@cestc.cn>
References: <cb4c5fd0-9629-4362-918a-cb044eb9e558@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Prarit Bhargava <prarit@redhat.com>

On 5/29/24 21:53, Liu Wei wrote:
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
> It's been a while, and the status of arm hardware may have changed. 
> IIRC the choice to force enable this is that most arm hardware is 
> headless and this was a _required_ option for booting.
> 
> I'm not sure if that's still the case as it's been a long time.
> 
> Can anyone from the ARM community provide an approval here?
> 
> P.

Though most ARM devices are headless, with the increasing number of ARM servers
or desktops, if the SPCR table from ACPI is still used as the default console 
on ARM, the console behavior on ARM architecture will differ from other 
architecture servers.

A similar effect can be achieved by adding console=tty0 in kernel cmdline, but 
I think it is important to ensure consistency among different architecture 
strategies as much as possible.

Thanks for your patient explanation.




