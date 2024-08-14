Return-Path: <linux-kernel+bounces-287320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C675D95265A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 01:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 825732842A5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3AD14D71A;
	Wed, 14 Aug 2024 23:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JQ7d13Cy"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F089C39FE5
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 23:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723679713; cv=none; b=aNVC/QNyF/guRiK65nciVgWb0fgJIMXHkRyWoWS3VQzL06aam6CebPRgjC3uwgLNl/hp8OlapUDwWPyPtzUGgXuj2CkOPazFE1QUFylOJ0LqwMAJIiT65SGwb3yO6W87QfG7gjl/HGFXfFjjBVTowdSy2GqsGHGoDo6Z2Zkod/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723679713; c=relaxed/simple;
	bh=P8eLxh7llwh4LoqmAsThwDf+/XNbKv4mXEFvfQGE1Ms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DbvvBcE1jRHeQUB3jIKL7WPiO2r6oHOLTRZ1gOpzZO/SmZsDrroFzuvPAx0vKGMJSLDor2M/BT4k+Ztb7l3dcsNb+UIY0DjHjFfYT32w8NlwMIjSp0UPoL5L8YTHF0OiqinVbjP5pUiLuMH2g1kC1XHKmEKbOh38ukoI56L4h1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JQ7d13Cy; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f0dfdc9e16so4378381fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723679710; x=1724284510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gKUJ7BgIioQGpheXxO7yFFFZCnz70o6nWdkTjS1DSQ=;
        b=JQ7d13CyjeDTPpUKgcuQ/uWMNLSosT1u2+Z3/s+vT65g2B5tDqaxS9SpdxWtITnHzL
         nobRBVknY3A9h1UtF1kkyqej5J7qBVJ8yXMi3rVBq1LD+rdj+RPgArEoE5nQ08jI2guW
         lxdPP9aAxcJAu8GRDfCi0v1j8UQFfkEv1S+mWioq7MCYqOkm9xpbwjOJq7P3XVylsI60
         PpHWVI5JXHD4Pc39ZQacp5K118zUfnhEZSMY8nBCJnneicy7zlAA/wgDifPGnOfcofSO
         ZfnZW98hpANbgVu+Iq4DUMY0dCDyEHokojBNvSV5g1SpePMUDKMJI4tYlK2BYEMViYxx
         0p9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723679710; x=1724284510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gKUJ7BgIioQGpheXxO7yFFFZCnz70o6nWdkTjS1DSQ=;
        b=H8kyKT8xbeONnWGvjChIDqwdV2oogRv46+CnPAs05mwbtXgw+vl65bRqXVCU/TDdmv
         17ECtt0XxKCoXhte3Onr25X00dqSUKa2Hx41b9JJFqAf3kD5zP3jJ/vg/HQaFsh3caKS
         7CZNGkpkJcxE3tBkDUfZUH3gCV6tpbpQsr3GsvMlW0rMp6uaxQdSKNCS2gqK7DtoR4PM
         Gbd50yYWBC+atstXJim+ngCh1eUPsF+a7wj3QYuLPZtwCkazbOYoQFS7UwtOG/2g+QIt
         LLBddOctcYeWxVptX8kAILbYFzjpf7pOq45DBw27JnjIZwjxpULVCSPGKTj7PXVson3G
         xDPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtsMU1wIG+QNYUE2B6EiXKRukPdtA/8RKQqeGQxtuLxRjYODdiEZf0X664KpKR7mUFDSKtci85RuhjHtE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw65HZ5VzhY3UtThnd/wFa0BGUkLKuFYSRf6GAH7dSUci7WgkhR
	0qG3TssmdpVweDSIoMDMDFCErqM+c7ZOqAIgsqU4sm0Z3wm16Q8BWyQ3QuFD6iW3OMsxvuadoE9
	kAUHDgBZP4WOXfTm4VSMj3mbisBv1jZfk8wqr
X-Google-Smtp-Source: AGHT+IGITCV+NxW2t2FFmiAHXYUgW4K81ddad9LMlv8z9QqkyqSmBsNKPnRt432UsGjq1zcHJYZysBN1xvUbt8V+5jU=
X-Received: by 2002:a05:6512:1243:b0:52e:fcd0:241f with SMTP id
 2adb3069b0e04-532eda81509mr2901467e87.29.1723679709353; Wed, 14 Aug 2024
 16:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805201247.427982-1-yosryahmed@google.com>
In-Reply-To: <20240805201247.427982-1-yosryahmed@google.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 14 Aug 2024 16:54:32 -0700
Message-ID: <CAJD7tkZTFNm3k3OM9G1qtd8-FyjKDvj5C-CPKvuS3AipKb7x8Q@mail.gmail.com>
Subject: Re: [PATCH v2] x86/hyperv: use helpers to read control registers in hv_snp_boot_ap()
To: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 1:12=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> Use native_read_cr*() helpers to read control registers into vmsa->cr*
> instead of open-coded assembly.
>
> No functional change intended, unless there was a purpose to specifying
> rax.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>
> v1 -> v2:
> - Fixed a silly bug that overwrote vmsa->cr3 instead of reading
>   vmsa->cr0.
>
> ---

Friendly ping on this, any thoughts?

>  arch/x86/hyperv/ivm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index b4a851d27c7cb..60fc3ed728304 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -321,9 +321,9 @@ int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
>
>         vmsa->efer =3D native_read_msr(MSR_EFER);
>
> -       asm volatile("movq %%cr4, %%rax;" : "=3Da" (vmsa->cr4));
> -       asm volatile("movq %%cr3, %%rax;" : "=3Da" (vmsa->cr3));
> -       asm volatile("movq %%cr0, %%rax;" : "=3Da" (vmsa->cr0));
> +       vmsa->cr4 =3D native_read_cr4();
> +       vmsa->cr3 =3D __native_read_cr3();
> +       vmsa->cr0 =3D native_read_cr0();
>
>         vmsa->xcr0 =3D 1;
>         vmsa->g_pat =3D HV_AP_INIT_GPAT_DEFAULT;
> --
> 2.46.0.rc2.264.g509ed76dc8-goog
>

