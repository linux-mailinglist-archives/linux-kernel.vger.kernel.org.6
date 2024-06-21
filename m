Return-Path: <linux-kernel+bounces-224250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B574F911F65
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B3628D1FA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549C116D9CA;
	Fri, 21 Jun 2024 08:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="aN/6VRiO"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3568B16C856
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718960017; cv=none; b=sYV+3/5QQa92B5OONdeD8IUAFiwYOVrth6W/JUveEOGB7QeR2DxCL27JIrQSnIsbGdqmi90Sjt4MWtqhS2vzMfrftmg7FEBO5bIDcLjiU9wPPYjGRCxADY5Z5SlY0pe78hH+vVA+YPj7TiOOt5Y99LCUApHMPbXkEQmpf6X3+eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718960017; c=relaxed/simple;
	bh=SIpWqkNa7EJeNFdbr+PQ/hPGHfJPvIwqRgf+d2kpABI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Km1ZksNy6DKgVb+rdviCHiGacQatTVJ+r429lUgPOAN22S1+ZMV5hLpyiHgFtP5/Dod058v2gSRqVfrXoa2nfOy05Nnl01NCBJnjLQCj3wHCmKbr7PskretQa9pG0q1ssQ7TPeU1PKOwgkOL8fZBcM4Ph+kLbosLYWzKArDAEik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=aN/6VRiO; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6f04afcce1so204843766b.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 01:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1718960013; x=1719564813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wHbob/VjuwQy7mgeQNSOdhI4orkGQDAEUkxEcv4Rw3I=;
        b=aN/6VRiOCNLSxcAEh0P0f70JbmYMkW6Yw2qPEQj8n3rMElAPkWQTPBja9bLCOtcupe
         HJB+g+tqiQUUNoEz4BJ4RqQZ7sdzIM1hq1ND/Yi1eW5mZYcPl/TnXkG1Knn8VRh98YQh
         s3Sjm+rJXMvxMaFImuDyu2lo/qdc2yfDxBfFFPZb4oL7ThexRybPuDto39GIbpGmJKDM
         O0gl1qkKgF+yRaA3QsoIwNDyta7D0oYJMQZYAJsPQlFxFLs6blbBnF9x8bYLu/usTMVK
         80pCms+W3wlVk7fbPsIFsiSdAiY0H+Jjq08ODEM3fc09imwkDGYTF2WzWnXKKoUb5gNt
         1udg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718960013; x=1719564813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHbob/VjuwQy7mgeQNSOdhI4orkGQDAEUkxEcv4Rw3I=;
        b=OnZDdVzWuKS1ySkJJU3s5ms8PYb1ff5uXtB+XnpaeHzL9hGMT44YQ1SUIx3rlWc2cc
         HrPk8FLTYF6Bkb7bffGH7M2Grjz9+3MhcCjj2TsPNwcWET4ADQiMMxjMBJvbXj/Xb9p9
         5EtQY6zgWMfpJ4+bI3hbbs+a5VNfTTUK185LJj/UxliMwh88eMb09cyzhRmvME5pC5Ic
         MY4m++Gd7MKQuoTF6k2eHwNS/Ie8bGVJT4CzTEVhBq3633d5jAxIkBzk4CPV9KyoNXsa
         +LQDUeclbVBgvLKX2wYAoZs8intyHEzK4/QcLKwneJmkUvjuEMOjd5GTax2KZTwuEb6k
         amsQ==
X-Gm-Message-State: AOJu0YxHOGS/IvvJ+rUqmYSbbW5P/5cYtB8rPClZwvyz9NA673o8J7Op
	fGPjNa+BlzRm9qE8re26HIYmY9xeiM1yTkt9DGefBUEdhqn/i1P3NgmAfWwR8uU=
X-Google-Smtp-Source: AGHT+IHkm/oNBDIDLkuaQ777H0KNvj0PKQQ8b7Mc9eNVWoGzQpZxRs7ccJxtYM++XnYbEFlLwFFDDA==
X-Received: by 2002:a17:907:1b0b:b0:a6a:ab5:6f2a with SMTP id a640c23a62f3a-a6fab60a12fmr716591066b.11.1718960013134;
        Fri, 21 Jun 2024 01:53:33 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf48b4ddsm59093666b.67.2024.06.21.01.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 01:53:32 -0700 (PDT)
Date: Fri, 21 Jun 2024 10:53:31 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, apatel@ventanamicro.com, alex@ghiti.fr, 
	greentime.hu@sifive.com, vincent.chen@sifive.com, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 4/4] KVM: riscv: selftests: Add Svade and Svadu
 Extension to get-reg-list test
Message-ID: <20240621-f02c058395f929dfac9f3883@orel>
References: <20240605121512.32083-1-yongxuan.wang@sifive.com>
 <20240605121512.32083-5-yongxuan.wang@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605121512.32083-5-yongxuan.wang@sifive.com>

On Wed, Jun 05, 2024 at 08:15:10PM GMT, Yong-Xuan Wang wrote:
> Update the get-reg-list test to test the Svade and Svadu Extensions are
> available for guest OS.
> 
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> ---
>  tools/testing/selftests/kvm/riscv/get-reg-list.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> index 222198dd6d04..1d32351ad55e 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -45,6 +45,8 @@ bool filter_reg(__u64 reg)
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SSAIA:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SSCOFPMF:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SSTC:
> +	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVADE:
> +	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVADU:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVINVAL:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVNAPOT:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVPBMT:
> @@ -411,6 +413,8 @@ static const char *isa_ext_single_id_to_str(__u64 reg_off)
>  		KVM_ISA_EXT_ARR(SSAIA),
>  		KVM_ISA_EXT_ARR(SSCOFPMF),
>  		KVM_ISA_EXT_ARR(SSTC),
> +		KVM_ISA_EXT_ARR(SVADE),
> +		KVM_ISA_EXT_ARR(SVADU),
>  		KVM_ISA_EXT_ARR(SVINVAL),
>  		KVM_ISA_EXT_ARR(SVNAPOT),
>  		KVM_ISA_EXT_ARR(SVPBMT),
> @@ -935,6 +939,8 @@ KVM_ISA_EXT_SIMPLE_CONFIG(h, H);
>  KVM_ISA_EXT_SUBLIST_CONFIG(smstateen, SMSTATEEN);
>  KVM_ISA_EXT_SIMPLE_CONFIG(sscofpmf, SSCOFPMF);
>  KVM_ISA_EXT_SIMPLE_CONFIG(sstc, SSTC);
> +KVM_ISA_EXT_SIMPLE_CONFIG(svade, SVADE);
> +KVM_ISA_EXT_SIMPLE_CONFIG(svadu, SVADU);
>  KVM_ISA_EXT_SIMPLE_CONFIG(svinval, SVINVAL);
>  KVM_ISA_EXT_SIMPLE_CONFIG(svnapot, SVNAPOT);
>  KVM_ISA_EXT_SIMPLE_CONFIG(svpbmt, SVPBMT);
> @@ -991,6 +997,8 @@ struct vcpu_reg_list *vcpu_configs[] = {
>  	&config_smstateen,
>  	&config_sscofpmf,
>  	&config_sstc,
> +	&config_svade,
> +	&config_svadu,
>  	&config_svinval,
>  	&config_svnapot,
>  	&config_svpbmt,
> -- 
> 2.17.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

