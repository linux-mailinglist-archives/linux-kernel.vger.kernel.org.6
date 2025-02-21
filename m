Return-Path: <linux-kernel+bounces-525660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 402A6A3F2D7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33A13BEB24
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09706209F30;
	Fri, 21 Feb 2025 11:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="BG8jRtix"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AC9207678
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740136829; cv=none; b=CG5zWWcgr4M6aaA1arkQ+DibBK9cQMS94lolHwM0qi4xZjYTO1EhL/nV01XNazdgEwRRG0q3cv0tbeb33mmSj5qXlZrjVKDuEnJG++xW2+K7R2iEYDs3McFvx09DpscmvL3kNgEhurbQF4zWu8m/60DET/x9tgKZyzrOBauhBaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740136829; c=relaxed/simple;
	bh=/pbYDQsdMkkBtnnoTRy7xBhScDSjhEI5StrW7iHtyB0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=EX50R0Hjok0hNibENrfwqjFXMzombYcLTT141tPQ9jrzVUmu9EP2MKyY0TAUoFb1hcLtPnLZxy5vh2WbPI1UmM8zPBtG7BVPf8/E+EUb3cPg9zOwtc4YXtxLvckbhb7ArR1tr3lQm+cBTJuDK9/MX9rqI64EdB5DXnHz0Gl1nYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=BG8jRtix; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38f333c5d35so92189f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 03:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740136826; x=1740741626; darn=vger.kernel.org;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVNBNWqXlEkHBpelyjOliwzjP+Z7atB2V59Z13O6URI=;
        b=BG8jRtixo/SwDR5fnTcwKI8QTWUNx1ixK007Hg9fYM1UZnUdjflcaa5+QrE2OWz4he
         TmyY6w60Z4BLfxssVPz5RXqZCgiiCR9Gzmi/6P3b6KKQ52M/dzEnIYgRyKwijaah3YtG
         zx+4/so2nvZ2mMmmomqBTloAcb8jKi4FsuMsYN+GaxPQYaSzLQBFSFNRq2ion9QFjBFc
         Zpx/n5BXmF82B6lFRtlhvuHmeN0tdwb+GomN6BUoakTgIjnwYF14DjkAMlQry+GBgpZ6
         9tPZ4Ov3TwZ8gjvFegyC1HyvGn45kUa3SJMaqNPGBf6T1nbrR1Tmyd1Ief63xKjiVPEA
         YVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740136826; x=1740741626;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HVNBNWqXlEkHBpelyjOliwzjP+Z7atB2V59Z13O6URI=;
        b=lhwGlhRdduoo1nWLmsr4gqBfozLkJkOZT02W2CrlKRELmMgGJSFk+MfuF4JO9bEKuo
         wEzkvu9qiDr+8l+EJASwL/oIqLdLrrWSFGlSKJLeHhPRLHlvbt3o1wy3kma16C/AmLjR
         SSSuvKLzTWDv0qsUmMqSpM9RzYpz7BEH8tH6aqcC0V19KWX2nFaDYt3Msnrs3fDT5Hhe
         dG1xy94z0cNz7sJ/BgbKeIRdC00gIRT56LiNhavSE4dQHSmLQ9oCcHyoRKxeuD07nhv2
         BQYkzDbFMRr1PIDEfd3nEJACwlhBePBqvtRRWy22y7MmnKgofxobdsi+EbIObKtxJ9ny
         OS3A==
X-Forwarded-Encrypted: i=1; AJvYcCVmc8xxgqAsoJO3UHa2JJOPbdln5DHdbDtPMpLChE13KD7Ek1OYYkaHxKDOQSGKFT1dXYpwMcXqNCacrFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YysoBVnlnUwhDGHmRS9zodgcTdTPYdIS3+BeI7+5fmnJhVWSCpM
	8Vsv5kvx22Jm1d+ncz/QSHTiTEpV+qyRvdVhyB+aNi4yjqLOC/yzKaHie9ki8mQ+qaP2fKCpq85
	zWZY=
X-Gm-Gg: ASbGnctshRvMZ4xyrt1RKqeT9YxvcGS1pgfvn9wcCfNIcoodIOKU/dmuoJuBqYHw8zh
	zB4u2BU7qisk0qk8Td2ZdfTs7hrEI6X6wcQYKUtHwlpFm9+kOJyzjei1IJpL2MCNVKyrwyD+K9Z
	uMh2Aa1QtPFYxBw03MeM5xA4fjs5f3vujMu3QtZPtLsVjHbg/azKYIUBQoM8Yq9JundhQUYaA6a
	wKibbkRX8n/i1XPD1Ow0Mb5cDL1KvpmpPDeaUEwTonUD4c01OIctktWNaSA/f5lxwxECQs9yfi7
	gyjvTc+EFvReMMa/L778O0q3u8vnOvX+KBOjHrAOuDMgtWsBSRbMr3SRax5Zs5dQrw6hOHMwo9z
	art6XJQ+BLHnEBxo=
X-Google-Smtp-Source: AGHT+IH7K+hzKcKXQTAM1MJlY9T9odHfHdYNa2eoNCcz78onWDZURLkgur4LeY451LSe8tRmqDN2LQ==
X-Received: by 2002:a05:6000:2a0c:b0:38d:cab2:91dd with SMTP id ffacd0b85a97d-38f6e95f74bmr899043f8f.6.1740136825868;
        Fri, 21 Feb 2025 03:20:25 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-c955-d4da-b5fa-7bb3.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:c955:d4da:b5fa:7bb3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d94acsm23492868f8f.75.2025.02.21.03.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 03:20:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Feb 2025 12:20:25 +0100
Message-Id: <D7Y30THD6TSI.113LHMD3DBBCP@ventanamicro.com>
Cc: <ajones@ventanamicro.com>, <kvm-riscv@lists.infradead.org>,
 <kvm@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <atishp@atishpatra.org>,
 <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>
To: "BillXiang" <xiangwencheng@lanxincomputing.com>, <anup@brainfault.org>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
Subject: Re: [PATCH v2] riscv: KVM: Remove unnecessary vcpu kick
References: <20250221104538.2147-1-xiangwencheng@lanxincomputing.com>
In-Reply-To: <20250221104538.2147-1-xiangwencheng@lanxincomputing.com>

2025-02-21T18:45:38+08:00, BillXiang <xiangwencheng@lanxincomputing.com>:
> Remove the unnecessary kick to the vCPU after writing to the vs_file
> of IMSIC in kvm_riscv_vcpu_aia_imsic_inject.
>
> For vCPUs that are running, writing to the vs_file directly forwards
> the interrupt as an MSI to them and does not need an extra kick.
>
> For vCPUs that are descheduled after emulating WFI, KVM will enable
> the guest external interrupt for that vCPU in
> kvm_riscv_aia_wakeon_hgei. This means that writing to the vs_file
> will cause a guest external interrupt, which will cause KVM to wake
> up the vCPU in hgei_interrupt to handle the interrupt properly.
>
> Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
> ---
> v2: Revise the commit message to ensure it meets the required=20
>     standards for acceptance

Nice, thanks.

Reviewed-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@ventanamicro.com>

