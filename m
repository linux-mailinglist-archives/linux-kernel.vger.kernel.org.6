Return-Path: <linux-kernel+bounces-291882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F91795687F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654881C21E19
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F1E161319;
	Mon, 19 Aug 2024 10:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GRLnx3eF"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0930F1607B6
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 10:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724063308; cv=none; b=eXldtjahPgJCIMcJ98JGTzjf5Haz2P83joZJAohMKFc7pgEPXGgnoOwIpAhzrnZULKmsJSYd1nKureGjuMZWnjT1+Crsnztqs9r1XPv4y4O0eUb8TZsiqMBjoZvrPMHtIxxc1lprbvCxPyMpwt6PO3YSenKmOHui8g3Jz23swZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724063308; c=relaxed/simple;
	bh=+h8HIi/gend96fRCd9l2WJq86aZzGE94/3TDyV88XYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQzOv9YAVocXkueld/G0v1AGuhGsNJPzcVl50O62r+W9B6OLU3KB68Ysf3lr8wKOFZxhPDLqG2o0eTr6i5txC/UW0U8qBjHEMB2EnRZONkMokSaCgZjMMJC5nj9b+eb3pElKrdQnj6XK/jMr17SKrhr9+neC/kQVYVfCMRz/2fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GRLnx3eF; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-371a92d8c90so1081841f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 03:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724063305; x=1724668105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HCnYXKbPejxZx0vHdL+PDYgS0GrW5E1HoGp5p5wjmA8=;
        b=GRLnx3eFbhzkfyjI9nqeDzw0+5lgxtz/qPYtoRZfUWWxvqa928/CQRKKnxh3Kp8L6n
         aN6m1hQzcz5Efc3fhVqutH0tGSHua4hec5l3DhMhvrp7yVfo16srocQ8S5gl7lqZU3Rk
         0JjMPf6VhFZMVquxx2IxbfH6z0PbEK8R/LvucQbB7ykW5O7pD5I2xsSGVIkzlPr/tZe8
         RyKG6oQhShj2zNFbDkfsotkz8WdOo4T6dkErDeEOvfpMdecSzBendmafh9binhlDdmP5
         9caLUvY9ibO9jKM+OUtmaLjNpl3rsXDIOcV3hrMsE1cDIGqMPhcOqPvhbmVw7tDWtc6P
         /qxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724063305; x=1724668105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCnYXKbPejxZx0vHdL+PDYgS0GrW5E1HoGp5p5wjmA8=;
        b=NApaVcD++q+ksQVaAoQd49JnIhtBatZxJ6sz/6bKYFQYiUUKH3tGVwDlw0WrCxci2V
         zO2gaaTKlHYQnT6ISO/ck4xkUEGv3hG9Rltp2NfMJ9TDTfjeDEH5X4cnlwcciDkVYyfZ
         nVscGIFs3lD73RWVFt30Ts0JXyO0yhUX/seQFVgRxMl+DkeCFySw+L7WUInNjd6A8gLl
         TWgvylKca0Rt95TdF1MVmk2pkpBhbiqMvtNML6bYSSjTdY068snPJJ/75FOlDcrYTDwQ
         z4bywm2MDrntSK3s7spnJ2Zp0Uj0jen/F2NEtyufkkgH0GNE+7x1wKZVWdebPjlV5KwL
         7byw==
X-Forwarded-Encrypted: i=1; AJvYcCUoajYdG5aV3P5XFKQa7fGguXIT7J6LbWa3Z2aO7DX6oRFQ9Rh23DTGzfNkTB3GkGnkMWbBDeH+P8pKOBK/tdmiyL96Bj2xxaC3c7Rx
X-Gm-Message-State: AOJu0YyTJZZ+D0y2FWCQEDAhy7UBL5DAWtppYYhe9LkMgXGuxDeXRhRW
	qzvPacTfq65vcBifZzEYS2FNqBlfjs7RtZsf+1+g0cyE5Uzjua2aRQ8jU8Hlcg==
X-Google-Smtp-Source: AGHT+IH29AZnz1h0T1T38pt3izR9PAR4PDYKW5YJTXZhxJwmI5d0SQZeuuiLw0/+rgopZIybK6w00Q==
X-Received: by 2002:adf:a35d:0:b0:368:319c:9a77 with SMTP id ffacd0b85a97d-371946535f5mr5589469f8f.29.1724063305033;
        Mon, 19 Aug 2024 03:28:25 -0700 (PDT)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898498e1sm10186667f8f.41.2024.08.19.03.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 03:28:24 -0700 (PDT)
Date: Mon, 19 Aug 2024 11:28:19 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Sebastian Ene <sebastianene@google.com>
Cc: akpm@linux-foundation.org, alexghiti@rivosinc.com, ankita@nvidia.com,
	ardb@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, james.morse@arm.com,
	mark.rutland@arm.com, maz@kernel.org, oliver.upton@linux.dev,
	rananta@google.com, ryan.roberts@arm.com, shahuang@redhat.com,
	suzuki.poulose@arm.com, will@kernel.org, yuzenghui@huawei.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v8 5/6] KVM: arm64: Initialize the ptdump parser with
 stage-2 attributes
Message-ID: <ZsMeQ8nAZLDhsBmA@google.com>
References: <20240816123906.3683425-1-sebastianene@google.com>
 <20240816123906.3683425-6-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816123906.3683425-6-sebastianene@google.com>


[...]

> +static int kvm_ptdump_build_levels(struct ptdump_pg_level *level, u32 start_lvl)
> +{
> +	static const char * const level_names[] = {"PGD", "PUD", "PMD", "PTE"};
> +	u32 i = 0;
> +	u64 mask = 0;
> +
> +	if (start_lvl > 2) {
> +		pr_err("invalid start_lvl %u\n", start_lvl);
> +		return -EINVAL;
> +	}

It looks like a duplicate of the if below.

> +
> +	if (WARN_ON_ONCE(start_lvl >= KVM_PGTABLE_LAST_LEVEL))
> +		return -EINVAL;
> +
> +	for (i = 0; i < ARRAY_SIZE(stage2_pte_bits); i++)
> +		mask |= stage2_pte_bits[i].mask;
> +
> +	for (i = start_lvl; i < KVM_PGTABLE_MAX_LEVELS; i++) {
> +		strscpy(level[i].name, level_names[i], sizeof(level[i].name));
> +
> +		level[i].num	= ARRAY_SIZE(stage2_pte_bits);
> +		level[i].bits	= stage2_pte_bits;
> +		level[i].mask	= mask;
> +	}
> +
> +	if (start_lvl > 0)
> +		strscpy(level[start_lvl].name, "PGD", sizeof(level[start_lvl].name));
> +
> +	return 0;
> +}
> +
> +static struct kvm_ptdump_guest_state
> +*kvm_ptdump_parser_init(struct kvm *kvm)

nit: I guess it's more a "create" than an "init" as we allocate the memory.

> +{
> +	struct kvm_ptdump_guest_state *st;
> +	struct kvm_s2_mmu *mmu = &kvm->arch.mmu;
> +	struct kvm_pgtable *pgtable = mmu->pgt;
> +	int ret;
> +
> +	st = kzalloc(sizeof(struct kvm_ptdump_guest_state), GFP_KERNEL_ACCOUNT);
> +	if (!st)
> +		return NULL;

return ERR_PTR(-ENOMEM); ?

> +
> +	ret = kvm_ptdump_build_levels(&st->level[0], pgtable->start_level);
> +	if (ret) {
> +		kfree(st);
> +		return ERR_PTR(ret);
> +	}
> +
> +	st->ipa_marker[0].name		= "Guest IPA";
> +	st->ipa_marker[1].start_address = BIT(pgtable->ia_bits);
> +	st->range[0].end		= BIT(pgtable->ia_bits);
> +
> +	st->kvm				= kvm;
> +	st->parser_state = (struct ptdump_pg_state) {
> +		.marker		= &st->ipa_marker[0],
> +		.level		= -1,
> +		.pg_level	= &st->level[0],
> +		.ptdump.range	= &st->range[0],
> +	};
> +
> +	return st;
> +}
> +

[...]

