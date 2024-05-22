Return-Path: <linux-kernel+bounces-186670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F588CC73C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 21:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CDF9B219AF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C0B1465BE;
	Wed, 22 May 2024 19:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FYdDU9A0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A607B208C4
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 19:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716406539; cv=none; b=DhDkSoj1hUxsDggOyMbkVLn5YdQYczN36Wr6TenDE5nETPwkDlto8Iyc3DICh7x8KWDFGa2w9VOEq2ZzA0FHH/tvG75HZEhqTHQlkz6JSUEnbcbAStjAEjOW7Ch4unXSoZx8O9yyiIG6Mf6MueV9QS88MmU3rxO1+mG2SPprCGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716406539; c=relaxed/simple;
	bh=xav3iiKSeBipoGj+DLAI3WzYsOvexRoEj8bZu9vP+Gg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S05itRYHlMVGlF0FH4tWpDP+2Zi5Ub3Ae9f2NxkXRnSMfHtd5t8+OeFaXvCpWQIWCwA8e+clLMxFxqPSntya2vtUiJSsyAQk4m+yoSlqR5U5qJDj02fMypuw3ZcvlbMSsx1iFuQUVPKHzx1wcZTvxMHP31kNJBcQt9QaKDpiQ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FYdDU9A0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716406536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I1+GUtmZEMisQFH3yNqOkGsNRPJHqCdk4whL2W9DFJs=;
	b=FYdDU9A0DjYgNfOzDvOBMiEqwP+yKeJiMnooGCcHN4xrj36WIBqOFqzsQfuV/VlSzEhJc/
	Cbf6U5Z0uXXV2tECWh9k2dcVgNtLe9dEpnDc4OTdWTMx0scSW1+zTRtRNOjKGbb/kvfvaJ
	upsSo0B04oxR7nYXUaj1ct4rf+0GJz0=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-cslL7RebNRCmhu0xlSDMdw-1; Wed, 22 May 2024 15:35:35 -0400
X-MC-Unique: cslL7RebNRCmhu0xlSDMdw-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-627eb3fb46cso15353627b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 12:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716406535; x=1717011335;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I1+GUtmZEMisQFH3yNqOkGsNRPJHqCdk4whL2W9DFJs=;
        b=ISeTaUg8OzKuaYRxc0Os9WWdXrAtwXluXrV9lqdMmheIjTbz2yeNJ5b1/SuJ/fFCXO
         9uH21lN6qoGOgrXV9RKMHBTbusPWzi2m0W5DdS6tqcyySlLM+XHbhTa+31SHiWqe0/vc
         1yZjmI1gP0Gu0lFBFl9oy8hDPsWvJVdk7yyhqjUqm0avWeXGLzLPt2s2WvXFp4E8ajXh
         y5HioKhd5xoj5if2PS8jE7IUpCg7Dc2ovQFE2NZPwmOaNGvNjmRbfBZ8ncQ00tmLp7TW
         sD7xz92GJzSkwOgFARIAynRkRfSq80HRMGMWwtgsj2u8Wz6auKoB3lysDA109ZbZhLE+
         i9Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVBEgRmJ1MK0sMgyumYJuld+JHkpE9bRGgaDr0l/kr3mdnX6QJl4Fok65v5zdl91TD1LvhUI1d2dk6530nkq23p62Mq3k0Yr+oPd8VK
X-Gm-Message-State: AOJu0YxObQpbfCDLSRKnPA9RCggEJgrAGbAilhNuqGsy5+7a227p+PMs
	DRzjVL0JZBBhpfJz5ko3ZadC7FxVkMGXFLPJMzS8bYO40EehyEfXlTRet/e/PBJ+b/Fx+TgUIaF
	TYxhJUj/MIykCOinlz4OY1ToI8QMw75wpjZNIgY0/iVxb4wg5Jbz7Kbwpg7i8vw==
X-Received: by 2002:a05:690c:ec8:b0:622:d6af:2555 with SMTP id 00721157ae682-627e46c99dfmr37663627b3.2.1716406534934;
        Wed, 22 May 2024 12:35:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkeKHMpWK8NcbIqif3cn71ot7RxQSe8rSsBapJOvWCPrePt7YrMQWmfal+XiT4DcmQGYyAUw==
X-Received: by 2002:a05:690c:ec8:b0:622:d6af:2555 with SMTP id 00721157ae682-627e46c99dfmr37663307b3.2.1716406534434;
        Wed, 22 May 2024 12:35:34 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c6c:a300:d6d6:453d:2844:4388? ([2600:4040:5c6c:a300:d6d6:453d:2844:4388])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a62014446fsm53408446d6.31.2024.05.22.12.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 12:35:33 -0700 (PDT)
Message-ID: <d4496b4ed8a8a7bb34cf12e4cce65a6ad6705bc0.camel@redhat.com>
Subject: Re: Early boot regression from f0551af0213 ("x86/topology: Ignore
 non-present APIC IDs in a present package")
From: Lyude Paul <lyude@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>, "Linux regression tracking
 (Thorsten Leemhuis)" <regressions@leemhuis.info>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Mario Limonciello
	 <mario.limonciello@amd.com>, Borislav Petkov <bp@alien8.de>, Linux kernel
 regressions list <regressions@lists.linux.dev>
Date: Wed, 22 May 2024 15:35:21 -0400
In-Reply-To: <87wmntkhak.ffs@tglx>
References: <3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com>
	 <20240418082703.GCZiDZVyra7qOQbyqn@fat_crate.local>
	 <fd040809d95b3e12b2fdc78a2409e187716bc66f.camel@redhat.com>
	 <87plumxz4x.ffs@tglx>
	 <abbb7d7ca781f6c664e4c5b1dffc19394ac79691.camel@redhat.com>
	 <87le59vw1y.ffs@tglx>
	 <3a0afe545747e5314a9cb6bbaa9ce90b259ddfac.camel@redhat.com>
	 <87edautcmz.ffs@tglx>
	 <3b1d16e357c1f9badeef405366492f05af26c085.camel@redhat.com>
	 <878r11t8zu.ffs@tglx> <016902d9-3858-4c65-b3ec-f7a5103af63c@amd.com>
	 <51d0dff8-2888-463c-95ab-71b491f12a8f@leemhuis.info> <877cg4ppd5.ffs@tglx>
	 <ea927dad269cc21de1d0baf3d6c9f66ee025b862.camel@redhat.com>
	 <d2c6f335a6eb5892b0d894d5df4a6e713fa013b5.camel@redhat.com>
	 <87jzjxn6s5.ffs@tglx>
	 <d3fe5278e7cd5af6c62b470b281b547b67e3959a.camel@redhat.com>
	 <97bd95480a8b9951edc9ee2d2648d1b9c574e3b0.camel@redhat.com>
	 <87bk58n6le.ffs@tglx>
	 <2fd6009d21d606d13f0c472dbaa754a21f3105d9.camel@redhat.com>
	 <87wmntkhak.ffs@tglx>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Awesome! This patch does seem to make the system boot, thank you for your h=
elp
<3

Tested-by: Lyude Paul <lyude@redhat.com>

On Thu, 2024-05-16 at 15:38 +0200, Thomas Gleixner wrote:
> Lyude!
>=20
> On Wed, May 15 2024 at 19:15, Lyude Paul wrote:
> > On Tue, 2024-05-14 at 10:25 +0200, Thomas Gleixner wrote:
> > >=20
> > > Which one of the debug patches did you use?
> >=20
> > The one you sent on 4/18, when you also asked me for the output of
> > /sys/kernel/debug/x86/topo/
> >=20
> > (I thought I remembered that patch not booting on previous kernels but =
maybe
> > I'm misremembering)
>=20
> It booted with the -rc kernel too. :)
>=20
> I found an interesting and probably related difference in the boot logs
> though. Up to 8 possible CPUs the kernel uses logical destination mode
> for the APIC. With more than 8 it uses physical destination mode.
>=20
> Can you please test the patch below on top of 6.9 and validate that it
> boots w/o any magic command line parameter?
>=20
> Thanks,
>=20
>         tglx
> ---
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index 66fd4b2a37a3..db5e93a7c194 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -1883,6 +1883,8 @@ static inline void try_to_enable_x2apic(int remap_m=
ode) { }
>  static inline void __x2apic_enable(void) { }
>  #endif /* !CONFIG_X86_X2APIC */
> =20
> +int irq_remap_mode =3D -1;
> +
>  void __init enable_IR_x2apic(void)
>  {
>  	unsigned long flags;
> @@ -1915,6 +1917,8 @@ void __init enable_IR_x2apic(void)
> =20
>  	if (ir_stat < 0)
>  		restore_ioapic_entries();
> +	else
> +		irq_remap_mode =3D ir_stat;
>  	legacy_pic->restore_mask();
>  	local_irq_restore(flags);
>  }
> diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/a=
pic_flat_64.c
> index f37ad3392fec..5cc386db3557 100644
> --- a/arch/x86/kernel/apic/apic_flat_64.c
> +++ b/arch/x86/kernel/apic/apic_flat_64.c
> @@ -12,6 +12,7 @@
>  #include <linux/export.h>
>  #include <linux/acpi.h>
> =20
> +#include <asm/irq_remapping.h>
>  #include <asm/jailhouse_para.h>
>  #include <asm/apic.h>
> =20
> @@ -130,7 +131,8 @@ static int physflat_acpi_madt_oem_check(char *oem_id,=
 char *oem_table_id)
> =20
>  static int physflat_probe(void)
>  {
> -	return apic =3D=3D &apic_physflat || num_possible_cpus() > 8 || jailhou=
se_paravirt();
> +	return apic =3D=3D &apic_physflat || irq_remap_mode =3D=3D IRQ_REMAP_XA=
PIC_MODE ||
> +		num_possible_cpus() > 8 || jailhouse_paravirt();
>  }
> =20
>  static struct apic apic_physflat __ro_after_init =3D {
> diff --git a/arch/x86/kernel/apic/local.h b/arch/x86/kernel/apic/local.h
> index 842fe28496be..f633ab6dfa9f 100644
> --- a/arch/x86/kernel/apic/local.h
> +++ b/arch/x86/kernel/apic/local.h
> @@ -22,6 +22,8 @@ void x2apic_send_IPI_allbutself(int vector);
>  void x2apic_send_IPI_self(int vector);
>  extern u32 x2apic_max_apicid;
> =20
> +extern int irq_remap_mode;
> +
>  /* IPI */
> =20
>  DECLARE_STATIC_KEY_FALSE(apic_use_ipi_shorthand);
>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat


