Return-Path: <linux-kernel+bounces-401611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45179C1CE6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDB24B21846
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C301F1E7C03;
	Fri,  8 Nov 2024 12:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cjj0205a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFE71DED55
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 12:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731068790; cv=none; b=JPnIX/41WYCC96qYtGN7vQHEWv3pm+47n4tT3dlZ6JORtBFt1Ud585ohaPR1dyq5r6T0mRhzIardnut/EMTk/N1ujpbKt9qtNae1m5q1JsMFtmTxSVFAQO4r4qbI5/xcjpUirDVNqJKjV/pvdizObsPnVnwtFiJsT5qeFjJwBcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731068790; c=relaxed/simple;
	bh=bRCGf/Wgy4FWDjxjm3445qpC2UR9lA5sk1A8y9SMWRI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qUSEES/Ly5U2qzVDPrdE2XTEj3TzLgDw5il4/Ualaj0smViqNnzUJ0GZR641+h82yBBCFjc2N5TavONrRzDM/gvbSakLa3pmhUBckDRbV0zTJgRQ73WdOwJ0WhRfOeTCx70/padIsjiEyUIINDyo2aLVCNDclzm5Qm1/DHbkX/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cjj0205a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731068785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=zXwAvU705aOAOAu5VxWMi2RxSodq3/VIqQ5cCCgEPB4=;
	b=Cjj0205aVIU/y1opilXowBQvUuu1B4pHgi2TmqFomlIKHhoaHS15M+BVqSeSkDx80f1tEM
	wd4U/kcl2wrykZ2ZtpyqMgUfCZ8kah82oB4vgD87HhDbg6FQ5N7wQoSIFQ2xIlunBEkG/M
	aXNnwndr7KPfjlas81dkT/xjmmviVNg=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-tLYGAydvN7CFwEgBvzAikg-1; Fri, 08 Nov 2024 07:26:24 -0500
X-MC-Unique: tLYGAydvN7CFwEgBvzAikg-1
X-Mimecast-MFC-AGG-ID: tLYGAydvN7CFwEgBvzAikg
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3e65ee7154bso150964b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 04:26:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731068783; x=1731673583;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zXwAvU705aOAOAu5VxWMi2RxSodq3/VIqQ5cCCgEPB4=;
        b=qBRMEvQDcjxziZcKlQWJCQsEn1xO2YOZfCREhlLE6Zol1S3TGjpIKtlfZeoKTRLsF4
         S8Jqt4qP1o6LHmUTMK55A9ksF55V8g1zv/ykR9qtIp2OYg3kzOp72k/PrUsJKqM+Qt20
         05Gv5d4xDzQIvxdi+aCwU+ufqsRNKH30Xwq23c2K6lr75SOIXunWX2r+GC13xQIFhiMJ
         MzgEYCpRCAzu2JvvzRisdLXjXH3yYJEGytIS4D8tYGtd0/gOpRpldqzR3VN1e6v3j0oI
         f8qIyvRBO/ELjWVLhmWk5PAFDDBOq1rUf5aJSlcLsLlOXOlaujIh2IGIYvcf9ttKERtS
         tmNg==
X-Forwarded-Encrypted: i=1; AJvYcCUn25UoACXQLe4VXrLmiNEwV3pqGgKjqFcuQokwHE1oC1p8ytkE2yr+SvtC1sUrdlR4SxUlJgZ2n3vHano=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ETAlKgTAYbO6JSfnAvxTwSftuKz3kSSvW4Pwp9wqc2SHKpqi
	5bnv/hzk1c9epJo/UJxNA41xn72YGPYbz7U5jgL4g0P0Q9fGPDyUVO0uWPayDa8o7NpkLUDaQ+t
	R1wdPKYXuOmCZtBK+18Gmb8BIc4R3/ehkpISh4L45192jGNfb3Vg4x2EQtS5UMwUxA3eQ1GCn+b
	DDajv7lgn1CYcGZu+OUEgl2zegD8M1nO2PsAm38CvD65oZxW4=
X-Received: by 2002:a05:6808:bd6:b0:3e6:49e0:f16b with SMTP id 5614622812f47-3e79464ffbemr561215b6e.1.1731068783036;
        Fri, 08 Nov 2024 04:26:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDh9xZLbDlbWxWwt0Ee/VQnmLbaHr7eXwqcgUZluZ+iMr9vgrajudEgifQ9sAYdMtcBXTBSmyV5BbZCxOsCjU=
X-Received: by 2002:a05:6808:bd6:b0:3e6:49e0:f16b with SMTP id
 5614622812f47-3e79464ffbemr561207b6e.1.1731068782692; Fri, 08 Nov 2024
 04:26:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Fri, 8 Nov 2024 13:26:12 +0100
Message-ID: <CALE0LRvJ-n77oU=O9__NdSLw2v33zMK+WYkn2LcwWMwHCbohQw@mail.gmail.com>
Subject: optee-based efi runtime variable service on TI j784s4 platforms
To: Ard Biesheuvel <ardb@kernel.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Masahisa Kojima <masahisa.kojima@linaro.org>, 
	linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
	Manorit Chawdhry <m-chawdhry@ti.com>, Udit Kumar <u-kumar1@ti.com>, "Menon, Nishanth" <nm@ti.com>
Content-Type: text/plain; charset="UTF-8"

Hi all,

I'm looking for any advice/clue to help me to progress on enabling
TEE-base EFI Runtime Variable Service on TI a j784s4 platforms.

I basically followed the steps described in u-boot documentation [1],
I enabled some debugging messages but I think I'm at the point that
the problem might be in the StandaloneMM application, and I'm not sure
how to debug it.

What I see is that when I run the tee-supplicant daemon, it looks like
the tee_client_open_session() call loops forever and the tee_stmm_efi
driver never ends to probe.

With debug enabled I got the following messages.

# tee-supplicant
D/TC:? 0 tee_ta_init_session_with_context:557 Re-open trusted service
7011a688-ddde-4053-a5a9-7b3c4ddf13b8
D/TC:? 0 load_stmm:297 stmm load address 0x40004000
D/TC:? 0 spm_handle_scall:859 Received FFA version
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request

And tracing the function calls gives me that:

      tee_stmm_efi_probe() {
             tee_client_open_context() {
               optee_get_version() {
                 tee_get_drvdata(); (ret=0xffff000002e55800)
               } (ret=0xd)
               tee_ctx_match(); (ret=0x1)
               optee_smc_open() {
                 tee_get_drvdata(); (ret=0xffff000002e55800)
                 optee_open() {
                   tee_get_drvdata(); (ret=0xffff000002e55800)
                 } (ret=0x0)
               } (ret=0x0)
             } (ret=0xffff000004e71c80)
             tee_client_open_session() {
               optee_open_session() {
                 tee_get_drvdata(); (ret=0xffff000002e55800)
                 optee_get_msg_arg() {
                   tee_get_drvdata(); (ret=0xffff000002e55800)
                   tee_shm_get_va(); (ret=0xffff000002909000)
                 } (ret=0xffff000002909000)
                 tee_session_calc_client_uuid(); (ret=0x0)
                 optee_to_msg_param(); (ret=0x0)
                 optee_smc_do_call_with_arg() {
                   tee_get_drvdata(); (ret=0xffff000002e55800)
                   tee_shm_get_va(); (ret=0xffff000002909000)
                   tee_shm_get_va(); (ret=0xffff000002909060)
                   optee_cq_wait_init(); (ret=0xffff000002e55910)
                   optee_smccc_smc(); (ret=0xffff0004)
                   tee_get_drvdata(); (ret=0xffff000002e55800)
                   optee_smccc_smc(); (ret=0xffff0004)
                   tee_get_drvdata(); (ret=0xffff000002e55800)
                   optee_smccc_smc(); (ret=0xffff0004)
                   tee_get_drvdata(); (ret=0xffff000002e55800)
                   optee_smccc_smc(); (ret=0xffff0004)
                   tee_get_drvdata(); (ret=0xffff000002e55800)
                   optee_smccc_smc(); (ret=0xffff0004)
     ... continues sending this forever ...
     ... Hit ^C to stop recording ...
                   tee_get_drvdata(); (ret=0xffff000002e55800)
                   optee_smccc_smc() {

[1] https://docs.u-boot.org/en/latest/develop/uefi/uefi.html#using-op-tee-for-efi-variables

Thanks in advance,
   Enric


