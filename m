Return-Path: <linux-kernel+bounces-271503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FA5944F26
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C020B21DF0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CD21AED30;
	Thu,  1 Aug 2024 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HlNKZDGy"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636851A8C11
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 15:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722526000; cv=none; b=b1Xy8OZRzBqU48YH47esbGp4C/RJl/TYwWUuU7ou93vdRAwESQuogoLP2DTtOgyJIIz5cTmgMCGyzJ7CVX9xfU4Pd7ErS7Hl7zqIkKdB9U4uzapVMrtbbnURHd03aPw+xfwfwTriVD9pI/rBWTU0yernLTXoZ1RcD7pnR4Bn1Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722526000; c=relaxed/simple;
	bh=/Jl6PB4Wp3ANrgC68CItsuYKxii3v6mf1G+8fRnnZTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FaBaB+6xrimyPy582kVDAQJ/pNJO8+sJ7FL5xooyLQqe43hOtHBX1kIR9wZqtl7J6MFY0E//TJaAtcd+OD4e8nJt1yGJWqrd2J0Ue1SZAAEtUujB9ZKOS0tPIjZyK+4+fHfMBmT7csv8EU4r5parWDKPuEeTqSBRrgA++kXpg/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HlNKZDGy; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44fee2bfd28so777681cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 08:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722525996; x=1723130796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJsisVlXsYheO37snVaNoupjzpA6f699hMvkHk44PW0=;
        b=HlNKZDGy2NMA6cFCJQIHJln4JOUhRG7G1krUj5XRXiGYi/tLztPlhD+Y0upMSmtr2D
         G2pGSx3F4y4s4eemlhBjSA0HRzK7uw0a70ih1z1Ll0pplUnTOsqdfeh7FrAPj64tYxfN
         Cc4TPvGhcxuLVOTja6hxbAavfvmB5cTUu7Zp+grkbT0BaPzJzwpIWSvBUDk2uAwFK6+2
         zRqhjzg/HCZWLrT5aDQ+nO+/Aq4TTJhpKoGEDy+koOT6uAPtxRfwJXYjaJVxYdg4FHmZ
         35GB5JrAPiDXWh4K8c2vTwOy913g5Ad1jG57r1cKZYPHYrDHfjqZDLfVWpPbPzb9z6N8
         Hz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722525996; x=1723130796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJsisVlXsYheO37snVaNoupjzpA6f699hMvkHk44PW0=;
        b=FjZn+IkHNV/6kIV85F0p0h7zL8Q4I6zBkcneHwqDF25c0MBiOtLKrK8bZyEsa4HNxr
         OMhAe0loufrb+fVqEmno8X2yeUnSL2KV5RjsdrsRRHyBqTUoAikXb1+49SNdsdpa9jQ8
         0JfOh8h4UknCYXJxldEZ/5zPtS5j+VBb5DGdceueO4To1K01dMrC1hXHPZXoNt9fBVu1
         R1X38hicQ2z1+S3dU4vYSPYcdFJsVYy7xnwGDuJIJXgziJRwlDKRZf0Lb2CmGXgTm3bT
         chvQQ6vqBBf3v0i8zixPH6OjS5soZ6kz3dD5lNA0l+QUxB7967kzxkdSl1Cr2nzyH+8K
         FN2Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/vV8VRhwVEOSbZp432GUDqG1PB74GSXbYtb2GxQCmBSLzEKmL82GO8ukansofWlt+xImS1UWkYCoFmFMX7DEELnP9pHE+O4TQYf38
X-Gm-Message-State: AOJu0Yw4sLHxtl+/5XO+vG1DGTxUYk2JPcrFYxlwJUmgsNppzTWDMtAo
	jUfyk39mqJqYzL/D50yFAMQO9hpVpNCCEqdPs1WNjpSSyarfDEOzlLMae5EZ8ZlAdBRxCj9EwLd
	F9tHb/Mrr8J0oIvCHkUxzsut8uPuCk5/SLoEn
X-Google-Smtp-Source: AGHT+IFMASjGXKSuF0FnLFzbAgMwMf9+e1XvKKegyCNSTZDeHUACfQPHE9S5FaA15pCyPsL9NbtKplB7rSftZhJoQzg=
X-Received: by 2002:ac8:7d8c:0:b0:447:d7ff:961d with SMTP id
 d75a77b69052e-45181e6e4f1mr2046151cf.9.1722525996159; Thu, 01 Aug 2024
 08:26:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719115018.27356-1-eric.lin@sifive.com> <20240729181927.1712841-1-atishp@rivosinc.com>
In-Reply-To: <20240729181927.1712841-1-atishp@rivosinc.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 1 Aug 2024 08:26:24 -0700
Message-ID: <CAP-5=fUJh6zzpiFcYwxMjxk7O3eOZWTVvzOB_zt+twcbnZMYXA@mail.gmail.com>
Subject: Re: [v2] perf arch events: Fix duplicate RISC-V SBI firmware event name
To: Atish Patra <atishp@rivosinc.com>
Cc: eric.lin@sifive.com, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	peterlin@andestech.com, dminus@andestech.com, locus84@andestech.com, 
	jisheng.teoh@starfivetech.com, inochiama@outlook.com, n.shubin@yadro.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Samuel Holland <samuel.holland@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 11:19=E2=80=AFAM Atish Patra <atishp@rivosinc.com> =
wrote:
>
> > Currently, the RISC-V firmware JSON file has duplicate event name
> > "FW_SFENCE_VMA_RECEIVED". According to the RISC-V SBI PMU extension[1],
> > the event name should be "FW_SFENCE_VMA_ASID_SENT".
> >
> > Before this patch:
> > $ perf list
> >
> > firmware:
> >   fw_access_load
> >        [Load access trap event. Unit: cpu]
> >   fw_access_store
> >        [Store access trap event. Unit: cpu]
> > ....
> >  fw_set_timer
> >        [Set timer event. Unit: cpu]
> >   fw_sfence_vma_asid_received
> >        [Received SFENCE.VMA with ASID request from other HART event. Un=
it: cpu]
> >   fw_sfence_vma_received
> >        [Sent SFENCE.VMA with ASID request to other HART event. Unit: cp=
u]
> >
> > After this patch:
> > $ perf list
> >
> > firmware:
> >   fw_access_load
> >        [Load access trap event. Unit: cpu]
> >   fw_access_store
> >        [Store access trap event. Unit: cpu]
> > .....
> >   fw_set_timer
> >        [Set timer event. Unit: cpu]
> >   fw_sfence_vma_asid_received
> >        [Received SFENCE.VMA with ASID request from other HART event. Un=
it: cpu]
> >   fw_sfence_vma_asid_sent
> >        [Sent SFENCE.VMA with ASID request to other HART event. Unit: cp=
u]
> >   fw_sfence_vma_received
> >        [Received SFENCE.VMA request from other HART event. Unit: cpu]
> >
> > Link: https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/src/ex=
t-pmu.adoc#event-firmware-events-type-15 [1]
> > Fixes: 8f0dcb4e7364 ("perf arch events: riscv sbi firmware std event fi=
les")
> > Fixes: c4f769d4093d ("perf vendor events riscv: add Sifive U74 JSON fil=
e")
> > Fixes: acbf6de674ef ("perf vendor events riscv: Add StarFive Dubhe-80 J=
SON file")
> > Fixes: 7340c6df49df ("perf vendor events riscv: add T-HEAD C9xx JSON fi=
le")
> > Fixes: f5102e31c209 ("riscv: andes: Support specifying symbolic firmwar=
e and hardware raw event")
> > Signed-off-by: Eric Lin <eric.lin@sifive.com>
> > Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> > Reviewed-by: Nikita Shubin <n.shubin@yadro.com>
> > ---
> > Changes since V1:
> >  - Add "Fixes:" tag for every patch that copied firmware.json
> Reviewed-by: Atish Patra <atishp@rivosinc.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

