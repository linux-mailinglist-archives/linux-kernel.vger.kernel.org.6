Return-Path: <linux-kernel+bounces-401914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC1A9C20FC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B172850FA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFE41F585F;
	Fri,  8 Nov 2024 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SJS/UOdH"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788701F6672
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731080924; cv=none; b=MB8HTlb83QRr5EkSmnOXfWMUtUWb9uUegNgEPzAXTLe+EmTOHXNuFJd5IKhC8Wrsv0U+nMXystUcBkhwFmBl/TEmCnwBlBGtzxaRCI+1gBpElVd8usxB61VkKU6XzV3NltITBddlAQ6wYQaesB6m7XLgaRIyhlcYrno5Hst3clU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731080924; c=relaxed/simple;
	bh=7QA17N/od4sbcewZwd2iYlP32bPFX9QEZoHMZU/b6Hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rnfmo2ibd07RW0LiCWcBs5IdgI9KUzEi1gs6BZ8SCBbV8kewU7gbdo88dbG7rY1af2E2Zs5UaDDYLU/B+ufvK6wJNs2Y2OUi18hg6yU3FPmUlAL1DqLgnp7i7AFwjWme7eThqpp6IwX5Pd2TISS7mDVuPKSTfSzsvn122I+pKRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SJS/UOdH; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea7e2ff5ceso1664843a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 07:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731080922; x=1731685722; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xw86N2iYX57qGc8nq79PlFANOzXfD7Duu0m6WN54d9M=;
        b=SJS/UOdHCh5nxVjWS8m8RSlPcpgQ6GTIMqMrc91zA3UJ77vva7ZFxp9okES4gLiXLS
         1FEH7n/iSw09j0+Az14UBE5MvQtWmwF7jzBYet6JL8oQ+xTRFj61Q5PH+wy/D6IF5t7D
         W6wF3JkeYDw0V4aE/JdDjTqRwOk0drHYkZDKAoRBwcX+BvuYlejuloGHSbCyVGeRcMqV
         cw9l+ubOgyhtbAu8Vld3+HrBGb0q/QHj71BGln+Y5mobgneLjjLe3YIjJ/isTdN3Jmio
         blYMLTIgRu03zgre5O0qJs43CzquaFz7zRKOP9aOqu5PDK/9kbLlqLNcverCQOEIeSDb
         gt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731080922; x=1731685722;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xw86N2iYX57qGc8nq79PlFANOzXfD7Duu0m6WN54d9M=;
        b=JVtILPFJrog7Lod7s5xPw+k5gysnja2Ac6wFVOqZLpcMD6D83sIYjxlgnZElmDg0il
         sxdJ59lFLOkW6YGgOae+TUdUpAUnkrFTBnA5DbC8MQHi4YF0EsGuZlumVJjJKMxdts6E
         Hkv8ZCQ8y6rCUJvs2hXSEZrfqXqYFTvTMmxdT56WbvOOJsb6EXmHXxmrIdQBP280kJ3y
         bCptVG4K0u90IPwnWXV/PbTA6Qxw7vhb9tRwQfdobNKjupjtU2DoMdrPRMkUXmWxvKdg
         82JEWoSYIucouIGsVOzvKA30Quyj/OMsD12rCt9n6QKZBTvAOydOSgUSEponyGqZnaKD
         kksQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkVmkLjhI7QEMfkkDp0GaMuN6ttVh8cv3LnmuOhuYz3yl6EGwKSv5+7BQlDWBnKRkcnuoT7IU4QxsPYzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZFIe7QoE56SIB9wWWumKNe29biv8wFgMBXRGIVnDlgBWuPMKb
	91GNPY5xJBhr7FJ+RrVZw1ZTa37cjFpr5NBd1rM41uURTN6bDkbalOvmSurS09Vt2zI5NEiGqzt
	bfh7Vlu/EoLVA2+vhesskbwDuxGXlu/5MnxZQRA==
X-Google-Smtp-Source: AGHT+IEJSlU2p83YLTbA+mJi+Uych4Hya5wMY9x1p6MnGvfZMWTmJClKKkw978ZNI1ECwUZVj92+bIAzxb8n2MpYNOo=
X-Received: by 2002:a17:90b:1649:b0:2e8:f58e:27bb with SMTP id
 98e67ed59e1d1-2e9b1655850mr4391856a91.8.1731080921787; Fri, 08 Nov 2024
 07:48:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALE0LRvJ-n77oU=O9__NdSLw2v33zMK+WYkn2LcwWMwHCbohQw@mail.gmail.com>
In-Reply-To: <CALE0LRvJ-n77oU=O9__NdSLw2v33zMK+WYkn2LcwWMwHCbohQw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 8 Nov 2024 15:48:05 +0000
Message-ID: <CAC_iWjJEXU+dodjvWQYM9ohPa3P2p0bFG=exGoi-iYFrLLbCTA@mail.gmail.com>
Subject: Re: optee-based efi runtime variable service on TI j784s4 platforms
To: Enric Balletbo i Serra <eballetb@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Masahisa Kojima <masahisa.kojima@linaro.org>, linux-efi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, Manorit Chawdhry <m-chawdhry@ti.com>, 
	Udit Kumar <u-kumar1@ti.com>, "Menon, Nishanth" <nm@ti.com>
Content-Type: text/plain; charset="UTF-8"

Hi Enric,

On Fri, 8 Nov 2024 at 12:26, Enric Balletbo i Serra <eballetb@redhat.com> wrote:
>
> Hi all,
>
> I'm looking for any advice/clue to help me to progress on enabling
> TEE-base EFI Runtime Variable Service on TI a j784s4 platforms.
>
> I basically followed the steps described in u-boot documentation [1],
> I enabled some debugging messages but I think I'm at the point that
> the problem might be in the StandaloneMM application, and I'm not sure
> how to debug it.
>
> What I see is that when I run the tee-supplicant daemon, it looks like
> the tee_client_open_session() call loops forever and the tee_stmm_efi
> driver never ends to probe.
>
> With debug enabled I got the following messages.

I assume reading and storing variables already works in U-Boot right?

>
> # tee-supplicant
> D/TC:? 0 tee_ta_init_session_with_context:557 Re-open trusted service
> 7011a688-ddde-4053-a5a9-7b3c4ddf13b8
> D/TC:? 0 load_stmm:297 stmm load address 0x40004000
> D/TC:? 0 spm_handle_scall:859 Received FFA version
> D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> D/TC:? 0 spm_handle_scall:867 Received FFA direct request
>
> And tracing the function calls gives me that:
>
>       tee_stmm_efi_probe() {
>              tee_client_open_context() {
>                optee_get_version() {
>                  tee_get_drvdata(); (ret=0xffff000002e55800)
>                } (ret=0xd)
>                tee_ctx_match(); (ret=0x1)
>                optee_smc_open() {
>                  tee_get_drvdata(); (ret=0xffff000002e55800)
>                  optee_open() {
>                    tee_get_drvdata(); (ret=0xffff000002e55800)
>                  } (ret=0x0)
>                } (ret=0x0)
>              } (ret=0xffff000004e71c80)
>              tee_client_open_session() {
>                optee_open_session() {
>                  tee_get_drvdata(); (ret=0xffff000002e55800)
>                  optee_get_msg_arg() {
>                    tee_get_drvdata(); (ret=0xffff000002e55800)
>                    tee_shm_get_va(); (ret=0xffff000002909000)
>                  } (ret=0xffff000002909000)
>                  tee_session_calc_client_uuid(); (ret=0x0)
>                  optee_to_msg_param(); (ret=0x0)
>                  optee_smc_do_call_with_arg() {
>                    tee_get_drvdata(); (ret=0xffff000002e55800)
>                    tee_shm_get_va(); (ret=0xffff000002909000)
>                    tee_shm_get_va(); (ret=0xffff000002909060)
>                    optee_cq_wait_init(); (ret=0xffff000002e55910)
>                    optee_smccc_smc(); (ret=0xffff0004)
>                    tee_get_drvdata(); (ret=0xffff000002e55800)
>                    optee_smccc_smc(); (ret=0xffff0004)
>                    tee_get_drvdata(); (ret=0xffff000002e55800)
>                    optee_smccc_smc(); (ret=0xffff0004)
>                    tee_get_drvdata(); (ret=0xffff000002e55800)
>                    optee_smccc_smc(); (ret=0xffff0004)
>                    tee_get_drvdata(); (ret=0xffff000002e55800)
>                    optee_smccc_smc(); (ret=0xffff0004)
>      ... continues sending this forever ...
>      ... Hit ^C to stop recording ...
>                    tee_get_drvdata(); (ret=0xffff000002e55800)
>                    optee_smccc_smc() {
>
> [1] https://docs.u-boot.org/en/latest/develop/uefi/uefi.html#using-op-tee-for-efi-variables
>
> Thanks in advance,

The most common problem with this is miscompiling the tee_supplicant
application.
Since we don't know if the system has an RPMB, we emulate it in the
tee_supplicant. How did you get the supplicant and can you check if it
was compiled with RPMB_EMU=0 or 1?

Thanks
/Ilias

>    Enric
>

