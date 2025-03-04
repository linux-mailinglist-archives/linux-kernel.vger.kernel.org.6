Return-Path: <linux-kernel+bounces-544188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6149A4DE5E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE01C1886C7B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878C51FFC74;
	Tue,  4 Mar 2025 12:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pZTVjlAI"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8D4202F96
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741092775; cv=none; b=LF/OiMConbRt2Ytqz36s8gMXgqR0uyj1awAbEHc6Do2vAktLZnSwFRAdXsK8gHs+l4MJ7XzxJ+WnVvRsW1O0OMWYHtrxXT7xZ7mPizLW30qGlYVX1a166rx7mcG0VzdwvGXfF+uoSVlxvE+ONaykzik71wwH4BLZ5/FSbsLysNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741092775; c=relaxed/simple;
	bh=SJXxPUs13IRqlByKgT0V2/LliPxpQNBHnmyeRj7UDLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcNPm4Zh9b1qz30s7imGEmhDgZUZ+zjCRGsFqlf8Q5TpOcwwicqIVHg1nSniWgv3duve+GZYKFEornXOClhsPGABy6zXUmzXF12B5IkYWiPcI3K+ROsVPRInqHKwHrXZueo0l7elx4F/FGA3YeWDIK8WAF2sNM+9es728PkrnXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pZTVjlAI; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43ba8a87643so55015e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 04:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741092772; x=1741697572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ORxBw0PzcDq8GlEftap7G0yXu9YcrPKoI2IIyzWUg2w=;
        b=pZTVjlAI064MEOQoO2H5DgpHKBN6Ye5VqGmZlBg3dYgNm++XMWRZUzgMC0WUbNOUOq
         hZV1evWYACDCG8gFA36trf8nDqISxj2Lm5ztqt6r3LUnULX2dEu91FcoehcX2eDO1giT
         gIYoEOS+kpK4O9/3EeG6iupncwghWpKoo+ElniiMrRHTn9Pyaf9wAUwPRj4zxZfQUsCx
         qP/OZ6caFlkYJy0Ommxqgjz32+LaNmaKH7qQDbVpL4CAXAxpKCMfHSBnk1tTJHeCScs1
         iNnkL3I18vP4lI/8Z/VRzVxZxrxJK8T5cBHWcTXkS38piqa4F9vZz6rq3MwuuWmJLSRl
         2e3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741092772; x=1741697572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORxBw0PzcDq8GlEftap7G0yXu9YcrPKoI2IIyzWUg2w=;
        b=MJX4vTcK+jEBIQO62secuKrRYQjIoqGcCDLM/P2XvURveTf3SJ15QUfz8LH67NrU8E
         EYYI2DLtoOiEKFs0uxYBlyNwu1c3Qn6QNg6HbASBhX5o4nV32z7kVjaAeYeNMb5AxSUF
         V8YpfYhJaaol4Jv1jHDxwVBBb/pHGy5FYxbqbC8K3/69PnPAoUuCgdJoDwp7n4Z/hb3n
         ETAoMn+ITVMOTJKyYAqaIe9byHJAligFQ1DUTssqHAGCIcrBoNZLx6XRxCYQQkYSwkUw
         N0/KTdfc2zmLWO1Ne4szdDemuvjYN7DEyi58u1C8Ebu494TRQi/8ViuXdGtIpHmU7DPO
         unFA==
X-Forwarded-Encrypted: i=1; AJvYcCUk3TcfmrsEkxQU3Vd2GovMurSJB+uIw+LdFmHa3SGm1oXlllLSTzifJWuuJuAy1oMYQE6rJaYUHLrqvAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1s5KS3lny1u3Wo/YAIWHrIiv42cd7xdVCI4Hxb0+ruNwNrDfQ
	RwFoP5xQb6cUNe5srEIy4cB8bWOQVOabPhNjConFblvS7jyl/CTkbWTELdephS1i4wYutFt/5kV
	MBL8O
X-Gm-Gg: ASbGncuqONc1jVnvZWOo1eX70NQX6+OwrOZ1oOeK7xiLGzcTLsFyZ3QAiL/LNTrMyWZ
	pD+IZ/YHXeDkf9hfrPkm9hLG8R0ORUsN4Bu0h5dZh9pSMvGS0Ug14wJ1DXUsvAeCXMwCW9htOLc
	YhYzyE/LHXRWyr3+uQOBERvLzDU3tBToZhdukVvNLyjuD/QEgMNreuFyHOH2KPyug88Zms2Lunn
	d+D6wxrUUpCNMUWLDUCTORQY3J4Fhg4WbVO9mx9DKq7sd0MzhbwBahMKHDecUFYIQBsFVHZl8V4
	FqlpuSkkXhKvKC6/CEEcx8hEnzj/3OkgB2V/Bjf/ZcK1IZ0Iv//lyaxHiPSo1t/WSW7I/snkf6N
	cy+f0
X-Google-Smtp-Source: AGHT+IHmOuSlJRLEt9nfeW0/RxV6Q5K3gZHdZus2MWdEAqPnJ+xAmtrsdSBktkrjD4il5L0UWkyemQ==
X-Received: by 2002:a05:600c:4791:b0:43b:bf3f:9664 with SMTP id 5b1f17b1804b1-43bcbe28d25mr958045e9.5.1741092771539;
        Tue, 04 Mar 2025 04:52:51 -0800 (PST)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b6ce3sm17286057f8f.43.2025.03.04.04.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 04:52:51 -0800 (PST)
Date: Tue, 4 Mar 2025 12:52:47 +0000
From: Brendan Jackman <jackmanb@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Rik van Riel <riel@surriel.com>,
	x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jannh@google.com,
	mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com, mingo@kernel.org
Subject: Re: [PATCH v14 11/13] x86/mm: do targeted broadcast flushing from
 tlbbatch code
Message-ID: <Z8b3n85dpkz_-2ci@google.com>
References: <20250226030129.530345-1-riel@surriel.com>
 <20250226030129.530345-12-riel@surriel.com>
 <20250303114618.GBZ8WWihMDjf-oy8P0@fat_crate.local>
 <7e1ca8c7-6f3e-44dc-9dd8-bd273a03a83e@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e1ca8c7-6f3e-44dc-9dd8-bd273a03a83e@intel.com>

On Mon, Mar 03, 2025 at 01:47:42PM -0800, Dave Hansen wrote:
> >  static void broadcast_tlb_flush(struct flush_tlb_info *info)
> >  {
> >  	bool pmd = info->stride_shift == PMD_SHIFT;
> > @@ -790,6 +821,8 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
> >  	if (IS_ENABLED(CONFIG_PROVE_LOCKING))
> >  		WARN_ON_ONCE(!irqs_disabled());
> >  
> > +	tlbsync();
> 
> This one is in dire need of comments.

I have been advocating to move this to a place where it's clearer. I
also think it needs comments:

https://lore.kernel.org/all/CA+i-1C31TrceZiizC_tng_cc-zcvKsfXLAZD_XDftXnp9B2Tdw@mail.gmail.com/

