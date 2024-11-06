Return-Path: <linux-kernel+bounces-398625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1349BF3CB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81EA02844B2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2781F205E18;
	Wed,  6 Nov 2024 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G9mz4dFg"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F262A205131
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730912345; cv=none; b=P0Z0RY1e+gkrts+TSZglCnliHoKHcRxUO03jTSq2n5sGNOS/AYeYY9vyl9ZVy7RXoxefnhV2fpa4y3AQJ2B7htnAn7X7OVJ8T6hVJ1cQ/R2KLOl5GHz0gIsauCJsRgsjRfSCagSBG33bwO1CIWFXIbFphz18EhI6uoEjRLc0R1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730912345; c=relaxed/simple;
	bh=zz24KO1Xy7Ea1dfAlSGXrFBY4HRdXzwVaZck1Xoj2hY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayMSs9ypa80xZFuiPVutOG3M4IeYA61RFV4UD+rIqq8iesCxjBqyftNw8yqKxVhwjjlMXvDnfpMt5VmrSX1hOG8Pdi+7OTyxY/+WXrKBgC7yhemumbI6M3Bjm/lNujsWdn6IYa1jeXFBCcRJn8XmN7gwDQYZ7dYoBwb5DlY1cTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G9mz4dFg; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cb6ca2a776so10484737a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 08:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730912342; x=1731517142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T2Kg6GaH7gYTnb++jbY4MBBC4c65ettqYa6wLql3FJE=;
        b=G9mz4dFgNPZ85GOSWSRMum8S3DGRvzKqxbBWHPMgHywEhjiTBGRkP9MsMVj4yCuWB0
         Nq2u3a/xHiVgkXcK28kdt2Emz9NKW3IvsUXaFF4JelwSHH3M1h/fLrxD5xU30g7SiRwB
         x87HTAjp73B1uJ7wO5u+fdwBXpXBtS8WfX8ZXGkmbMeszqIlxVTKdrsNN11jq/MDWoYq
         EMtCTvPQalafqIeiV1a6ypKCWnLiRYJs9k2beJje6Qw3SazmCDO8LkuuCtb3tUfJXY+1
         W/p71Ck9SJYpIYfmYF4vArsn7gr3w5UuepXO9L9l1OCyOdQ0UQHkZiHelcwV/2p0MQds
         ICTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730912342; x=1731517142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2Kg6GaH7gYTnb++jbY4MBBC4c65ettqYa6wLql3FJE=;
        b=m9WZcDUBFZpb4uVqJ/ZgUjLd1iWhZ1lCdLhK6i4WaNx0CQCuknW4fM4+EHPPOpBc/0
         KmjEWv9U9dgO5rz9fmYlQ8KwUnvHFGwXewB3Y27XMa85BzifzqCYpeTJH9RRrWQ1VrOs
         HHiFC8tmCZ/MjGULqotXbbMFZrC38vhVSGa3l9Jvrjzh0miAp0KeUqd+VD00KFmpMXw8
         +OPfAMDXa7dP1Xk+Hol2RoRIR0e+TADBrpcXFdIPToPtI4dYLoEdFsQZLF+ameT/aLNt
         jzz58DBhYQRhLvggbHj9RSadK9xSpM49LP3rHButh39GOrZmVokawgDeTJYtxEuYIr5Z
         fNsA==
X-Forwarded-Encrypted: i=1; AJvYcCVNbu8qMv2buGQLIbE8a7bLB/u+is76PdfNpMRaFImGUHss3cAf1kbWc0AMltOeAblhFsFSVS9WByFj4W8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8jMPlIrP3N4k4TaOD24G0i6eIf6uybFbEKPei0jq16Ihgbxox
	Z6uJ+7+Se14N0vwLSZjvA5+3Jl7L5gp4cuVha1xJBBZu0B7N8vyG9NMoPLHwYw==
X-Google-Smtp-Source: AGHT+IGvdZ2IaD+BzOBp7O9t8aJG3Fn8CPmHBQZKasjV9H+9x/GBg968m+XOOjPPD2/pEN1skbtRkA==
X-Received: by 2002:a17:907:7f14:b0:a9a:6855:1820 with SMTP id a640c23a62f3a-a9e3a5a0357mr2809681466b.15.1730912342073;
        Wed, 06 Nov 2024 08:59:02 -0800 (PST)
Received: from google.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb16a1440sm304413166b.31.2024.11.06.08.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 08:59:01 -0800 (PST)
Date: Wed, 6 Nov 2024 16:58:58 +0000
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Fuad Tabba <tabba@google.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Sebastian Ene <sebastianene@google.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/18] KVM: arm64: Introduce the EL1 pKVM MMU
Message-ID: <ZyugUvS5dMwXU5nW@google.com>
References: <20241104133204.85208-1-qperret@google.com>
 <20241104133204.85208-18-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104133204.85208-18-qperret@google.com>

On Monday 04 Nov 2024 at 13:32:03 (+0000), Quentin Perret wrote:
> +bool pkvm_pgtable_test_clear_young(struct kvm_pgtable *pgt, u64 addr, u64 size, bool mkold)
> +{
> +	pkvm_handle_t handle = pkvm_pgt_to_handle(pgt);
> +	struct pkvm_mapping *mapping;
> +	struct rb_node *tmp;
> +	bool young = false;
> +
> +	read_lock(&pgt->pkvm.mappings_lock);
> +	for_each_mapping_in_range(pgt, addr, addr + size, mapping, tmp)
> +		young |= kvm_call_hyp_nvhe(__pkvm_host_wrprotect_guest, handle, mapping->gfn, mkold);
> +	read_unlock(&pgt->pkvm.mappings_lock);
> +
> +	return young;
> +}

I just observed a funny behaviour in one of my tests, the above explains
it ... Can you find the bug? Ahem. I'll fix in v2 obviously.

