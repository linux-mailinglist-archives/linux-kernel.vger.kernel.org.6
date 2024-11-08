Return-Path: <linux-kernel+bounces-402383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA08C9C26ED
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 22:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DCDDB21C0A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 21:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A2A1DF977;
	Fri,  8 Nov 2024 21:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KPmI5tvy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CA91C1F14
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 21:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731100275; cv=none; b=blscpX/aKvqmcgsfrB677aY7nbdXTSsOYe/PxgVemVKyuI9YgCniJheecAQjheUDGJ54kYZgD3Zy38kEAkQ0PSxTuC4udx4UEJhvRUkkWJypDbMzyR98K/UXpH1AmG4bGWVbeGdMjiCBvPvOFwkGfUt4spoTLctTr1ddTw8kgeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731100275; c=relaxed/simple;
	bh=es+bqbmiX3A1GhHLreQT+U9nXd4UOMo2O2/RY9a0oSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMregeocK5h/qs3nqnogjQdFKmYnEEmbEyDXwM06jf18nP551/TfeRWszAibcrzxoMtJkecu9HYiOF34/S7utG8EdSa67k5RBpv8qvJzRICWiuSnBeRrqsKqU5gvwOpw7nUifXNCXMP7wvacLB6Rk00w5RJsYdjz/Eo4FWCEMH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KPmI5tvy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731100272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nRqlXjowIXjJU/wOruO4EV/OIEg8cJDYqC1tZv9nmzc=;
	b=KPmI5tvyxvQMLvm5ynjfUPB8n/6Pdx5nP4UMQLgTAoo2dIsqP7opVdYsK4Yzgh4axWC416
	lLmtVTYKKArj+lqlu8X0yk8QadDPd3H0PgiFAnh1CJvYJHf6CLqs5iAwZ2SuTInWjZ/EEb
	tz3UEWQiQYGu7SOiU1Uy4/Jc80Y9GgE=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-fnkOYiu_M_a_eSs1kDG9_A-1; Fri, 08 Nov 2024 16:11:10 -0500
X-MC-Unique: fnkOYiu_M_a_eSs1kDG9_A-1
X-Mimecast-MFC-AGG-ID: fnkOYiu_M_a_eSs1kDG9_A
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5eb75d21d3eso318986eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 13:11:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731100269; x=1731705069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRqlXjowIXjJU/wOruO4EV/OIEg8cJDYqC1tZv9nmzc=;
        b=sfdKJKM41bie7ZU9VpTfjw23gxtQ2Qwi93HrI9vn5r3gkPw7jJNOXmtucW19LYDRzf
         rfRF9Obmf9e9nMnlneO2eT+W5b/li1cRrvhOvIjvVSmoADELEVnbbDeMdUkAT5n34wLg
         Mya2rpBEU6KXmzo60svwcm5jaoBUusWvURTg/pfQIHGmJJEVS9OCORHJDqvmOhLshZK+
         XCkLmqROjNQRlavT6mG7+7GAC5P41WG5zII3P18GbPAZStwuYy5/0nxln82NGMl0MOtg
         4WuJdmDQab6MqNWJHiRe7c2UuW8LrFI/OGMQf9Ivh/DshXlKARsPcjV/p6cQ8cZAynZ3
         ayTA==
X-Forwarded-Encrypted: i=1; AJvYcCVrqlwlGt9H6AAd4kG9fA5b9/mfym2qnz1+/l+OKO3FoOGXYDSovFfIXWMGwS/Q3Phlee++YSSLalhLfHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YykK74raGEifgUuPwCA8OLoWRFQY0WnuValuoABMK6n+Nd/aQLL
	FLgXU97b+qqB6nU8+s6VuUF9t6fqP2GxmeDDFuYRQOwR2xMbSMuOZXuAIJOEWvOsWICDctR7GeZ
	FlGxLq2YRZJHa9QT6ZNNSMyqr+Ozf2RVCO5USXase3zUKISKJkfOfycjsFxfFyXS8KkOtR3QIS7
	7oWmD/civmHjRD6maXCXMeDgOiL56/FrHzVOX6
X-Received: by 2002:a4a:c70f:0:b0:5ec:1ed0:3849 with SMTP id 006d021491bc7-5ee57c40c98mr435411eaf.1.1731100269585;
        Fri, 08 Nov 2024 13:11:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqh380fjLkQ2+6qUYw/LIIxhyTMmTEiMJpEsuaSUMLQmk08/Vgv54D+6rC2jQTKpUOPaljEGzbAInyxOPQtcs=
X-Received: by 2002:a4a:c70f:0:b0:5ec:1ed0:3849 with SMTP id
 006d021491bc7-5ee57c40c98mr435405eaf.1.1731100269214; Fri, 08 Nov 2024
 13:11:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALE0LRvJ-n77oU=O9__NdSLw2v33zMK+WYkn2LcwWMwHCbohQw@mail.gmail.com>
 <CAC_iWjJEXU+dodjvWQYM9ohPa3P2p0bFG=exGoi-iYFrLLbCTA@mail.gmail.com>
In-Reply-To: <CAC_iWjJEXU+dodjvWQYM9ohPa3P2p0bFG=exGoi-iYFrLLbCTA@mail.gmail.com>
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Fri, 8 Nov 2024 22:10:58 +0100
Message-ID: <CALE0LRtUz8hd4pdR9sX2Sb6tOn=K4wkRnGG9B7f72qU8JFQSYQ@mail.gmail.com>
Subject: Re: optee-based efi runtime variable service on TI j784s4 platforms
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Masahisa Kojima <masahisa.kojima@linaro.org>, linux-efi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, Manorit Chawdhry <m-chawdhry@ti.com>, 
	Udit Kumar <u-kumar1@ti.com>, "Menon, Nishanth" <nm@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilias,

Thanks for your quick answer.

On Fri, Nov 8, 2024 at 4:48=E2=80=AFPM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Enric,
>
> On Fri, 8 Nov 2024 at 12:26, Enric Balletbo i Serra <eballetb@redhat.com>=
 wrote:
> >
> > Hi all,
> >
> > I'm looking for any advice/clue to help me to progress on enabling
> > TEE-base EFI Runtime Variable Service on TI a j784s4 platforms.
> >
> > I basically followed the steps described in u-boot documentation [1],
> > I enabled some debugging messages but I think I'm at the point that
> > the problem might be in the StandaloneMM application, and I'm not sure
> > how to debug it.
> >
> > What I see is that when I run the tee-supplicant daemon, it looks like
> > the tee_client_open_session() call loops forever and the tee_stmm_efi
> > driver never ends to probe.
> >
> > With debug enabled I got the following messages.
>
> I assume reading and storing variables already works in U-Boot right?
>

Reading and storing variables to the RPMB partition in U-Boot works,
that's using the mmc rpmb command from u-boot, But setting
CONFIG_EFI_MM_COMM_TEE=3Dy in u-boot I end with a similar behaviour
(although I'm not able to debug at u-boot level) What I see is that
u-boot gets stuck
when bootefi bootmgr is invoqued. I can also reproduce the issue with
bootefi hello.

=3D> run bootcmd
  Scanning for bootflows in all bootdevs
  Seq  Method       State   Uclass    Part  Name                      Filen=
ame
  ---  -----------  ------  --------  ----  ------------------------
----------------
  Scanning global bootmeth 'efi_mgr':
( gets stuck here)

or

=3D> bootefi hello
(gets stuck)

To debug I disabled CONFIG_EFI_MM_COMM_TEE to not get stuck and bypass
the error and go to Linux. My understanding is that
CONFIG_EFI_MM_COMM_TEE is only required to read/write efi variables at
u-boot level but OPTEE is running the StandaloneMM service. Am I
right?

> >
> > # tee-supplicant
> > D/TC:? 0 tee_ta_init_session_with_context:557 Re-open trusted service
> > 7011a688-ddde-4053-a5a9-7b3c4ddf13b8
> > D/TC:? 0 load_stmm:297 stmm load address 0x40004000
> > D/TC:? 0 spm_handle_scall:859 Received FFA version
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> >
> > And tracing the function calls gives me that:
> >
> >       tee_stmm_efi_probe() {
> >              tee_client_open_context() {
> >                optee_get_version() {
> >                  tee_get_drvdata(); (ret=3D0xffff000002e55800)
> >                } (ret=3D0xd)
> >                tee_ctx_match(); (ret=3D0x1)
> >                optee_smc_open() {
> >                  tee_get_drvdata(); (ret=3D0xffff000002e55800)
> >                  optee_open() {
> >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> >                  } (ret=3D0x0)
> >                } (ret=3D0x0)
> >              } (ret=3D0xffff000004e71c80)
> >              tee_client_open_session() {
> >                optee_open_session() {
> >                  tee_get_drvdata(); (ret=3D0xffff000002e55800)
> >                  optee_get_msg_arg() {
> >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> >                    tee_shm_get_va(); (ret=3D0xffff000002909000)
> >                  } (ret=3D0xffff000002909000)
> >                  tee_session_calc_client_uuid(); (ret=3D0x0)
> >                  optee_to_msg_param(); (ret=3D0x0)
> >                  optee_smc_do_call_with_arg() {
> >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> >                    tee_shm_get_va(); (ret=3D0xffff000002909000)
> >                    tee_shm_get_va(); (ret=3D0xffff000002909060)
> >                    optee_cq_wait_init(); (ret=3D0xffff000002e55910)
> >                    optee_smccc_smc(); (ret=3D0xffff0004)
> >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> >                    optee_smccc_smc(); (ret=3D0xffff0004)
> >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> >                    optee_smccc_smc(); (ret=3D0xffff0004)
> >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> >                    optee_smccc_smc(); (ret=3D0xffff0004)
> >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> >                    optee_smccc_smc(); (ret=3D0xffff0004)
> >      ... continues sending this forever ...
> >      ... Hit ^C to stop recording ...
> >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> >                    optee_smccc_smc() {
> >
> > [1] https://docs.u-boot.org/en/latest/develop/uefi/uefi.html#using-op-t=
ee-for-efi-variables
> >
> > Thanks in advance,
>
> The most common problem with this is miscompiling the tee_supplicant
> application.
> Since we don't know if the system has an RPMB, we emulate it in the
> tee_supplicant. How did you get the supplicant and can you check if it
> was compiled with RPMB_EMU=3D0 or 1?
>

I'm using the tee-supplicant provided by the fedora package which is
built with ` -DRPMB_EMU=3D0`, I think that's correct, right?

Thanks,
   Enric

> Thanks
> /Ilias
>
> >    Enric
> >
>


