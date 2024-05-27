Return-Path: <linux-kernel+bounces-191241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BCB8D0894
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 18:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF99028AB9C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B089F15A879;
	Mon, 27 May 2024 16:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="VRGTBMug"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595FF73469
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716827390; cv=none; b=PohLOobQOI8Gyg8j3kI2+H8fu9oVQUbyVa/xJlN2B5X3Zj1/gJznaV5Ulbw3amE8ki/4yaLz3xicxCQXoo5xrhn/vF/fTuaVms73Colx8Vl8xptKsEP6z7sv4DUcCJ5Q+LQwS9FCaXoyfWkiXOHOTr2e7iBC/CZbtP9kRvUK17Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716827390; c=relaxed/simple;
	bh=IZXMCQ1FxdHmcAoyzX6sKL0KJwelX3zrJhQyguv/6zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBIAyQdS1b9iPtQyrikgWbi0WKv4386txG6h8LJiIBdJ+1mqbRu0pc3rR9+hOCL86lso7ylLJjqDeI1h9p34amURdx4ZFRGaYFCWjUJYbCQ9mk7ca4ZClD7iKjqAS7/Dg2Vjt/AHEVGmSizW6fTgRiXiBdhWko0gh3U7B9+s+MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=VRGTBMug; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-420180b5897so46648015e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1716827387; x=1717432187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H2zB37FLsCEU3qcA1K5WX2J0t5s2Si0hkv34drQge/E=;
        b=VRGTBMug1gSv8vjl/tROma6MvCo78uj2HSQn3sHTSWsXLYl6l7hMD9dHoDr2X6WN09
         d+q0nmxqPtS6LgFLlyieBFwdHnpH3pvwQRXsX9DYeOS2L5eKAGroVIVC6pQlpGc8ER0+
         gq7pyVN0obXHDwrVTqg0O/vWN1OPyx2knBTTrbxv69wNLBXQfU/jkGinsNw/0EeUL8S3
         Fqfi8WaLPlwYYYwR2r335tHyKHDBRk81GKiCxlAuQ6nZxMqvoTsI0h7WzLYVEJMCEFIy
         1lMM60M2HltGR80sB1JiwJXE2UUxfiLDiCrYhPVVVGkwDDNh91MQpwh8NsEjRcCzQTrc
         WBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716827387; x=1717432187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2zB37FLsCEU3qcA1K5WX2J0t5s2Si0hkv34drQge/E=;
        b=I86ITW3shwVkyXw3e2TYY7fnjHy1SfgsM776F4859nV7BKRP+BtUZeC1ZHPXFqqIpJ
         M/1oV2EEEnNyORHHDjp+09MUAKh/ICCW5ny+wb6oROdhDNymB1oKynG/jpN1aHwwWZwE
         X1OJXzNxlCDsO2L4+R1QV38On1xkyfU+lTbA4L9fShyDvf0E/xlZcwLGZt5XghUHvMKN
         G0majf3eIu4arbPtkmtNE7fithRXZcwX7EdQ74wSVexTow3PkBtezPeSpTc7VDZl8/lg
         nSHaXKyn5m7oJVYmt14H0VW8hgHGrBkKwFL+u0y6fi2aL26agNIHFnH+hhCWRpb1REGz
         AJnA==
X-Forwarded-Encrypted: i=1; AJvYcCWJNa3AkcLwJXZzZ72ngw52sKjzlWyaTxgjm8vBMgfdzAi91I69oix0DILaWVSAF94w7ODSdZeaACZrnSVqoM29NaEm6xKhzYuNINfY
X-Gm-Message-State: AOJu0YwV01Ez+96B7690WZQfMtlk5u03batKYv50Xzu3+FESfA71geIe
	WXt04NUzvAUCO5eE8NQDFeR7TwQpuedIuq1QpzdOxEz+pADddtSRzGGovSluEvs=
X-Google-Smtp-Source: AGHT+IHINXCkiw2NUljFrgeUFwhaZdwQ+fb2vuaNPpG8uSuGOg50lvCQavB66BSGklf0wD2Hp15QoA==
X-Received: by 2002:a7b:cbd8:0:b0:420:11cd:d302 with SMTP id 5b1f17b1804b1-421089d7682mr64769185e9.9.1716827386761;
        Mon, 27 May 2024 09:29:46 -0700 (PDT)
Received: from localhost ([176.74.158.132])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4210896f442sm113388455e9.11.2024.05.27.09.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 09:29:46 -0700 (PDT)
Date: Mon, 27 May 2024 18:29:45 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, greentime.hu@sifive.com, vincent.chen@sifive.com, 
	cleger@rivosinc.com, alex@ghiti.fr, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 5/5] KVM: riscv: selftests: Add Svadu Extension to
 get-reg-list testt
Message-ID: <20240527-e9845c06619bca5cd285098c@orel>
References: <20240524103307.2684-1-yongxuan.wang@sifive.com>
 <20240524103307.2684-6-yongxuan.wang@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524103307.2684-6-yongxuan.wang@sifive.com>

On Fri, May 24, 2024 at 06:33:05PM GMT, Yong-Xuan Wang wrote:
> Update the get-reg-list test to test the Svadu Extension is available for
> guest OS.
> 
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> ---
>  tools/testing/selftests/kvm/riscv/get-reg-list.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> index b882b7b9b785..3e71b7e40dbf 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -44,6 +44,7 @@ bool filter_reg(__u64 reg)
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SMSTATEEN:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SSAIA:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SSTC:
> +	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVADU:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVINVAL:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVNAPOT:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVPBMT:
> @@ -409,6 +410,7 @@ static const char *isa_ext_single_id_to_str(__u64 reg_off)
>  		KVM_ISA_EXT_ARR(SMSTATEEN),
>  		KVM_ISA_EXT_ARR(SSAIA),
>  		KVM_ISA_EXT_ARR(SSTC),
> +		KVM_ISA_EXT_ARR(SVADU),
>  		KVM_ISA_EXT_ARR(SVINVAL),
>  		KVM_ISA_EXT_ARR(SVNAPOT),
>  		KVM_ISA_EXT_ARR(SVPBMT),
> @@ -932,6 +934,7 @@ KVM_ISA_EXT_SUBLIST_CONFIG(fp_d, FP_D);
>  KVM_ISA_EXT_SIMPLE_CONFIG(h, H);
>  KVM_ISA_EXT_SUBLIST_CONFIG(smstateen, SMSTATEEN);
>  KVM_ISA_EXT_SIMPLE_CONFIG(sstc, SSTC);
> +KVM_ISA_EXT_SIMPLE_CONFIG(svadu, SVADU);
>  KVM_ISA_EXT_SIMPLE_CONFIG(svinval, SVINVAL);
>  KVM_ISA_EXT_SIMPLE_CONFIG(svnapot, SVNAPOT);
>  KVM_ISA_EXT_SIMPLE_CONFIG(svpbmt, SVPBMT);
> @@ -987,6 +990,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
>  	&config_h,
>  	&config_smstateen,
>  	&config_sstc,
> +	&config_svadu,
>  	&config_svinval,
>  	&config_svnapot,
>  	&config_svpbmt,
> -- 
> 2.17.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

