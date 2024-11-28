Return-Path: <linux-kernel+bounces-424403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD559DB3F5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A078C165B1F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 08:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C900914F125;
	Thu, 28 Nov 2024 08:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ObczU05z"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32A914C5A1
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 08:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732783366; cv=none; b=hoy5kTSd6Onrv0HUyH5NMR79Z6K7/P09nzYe5IQjPV5idrAbwC47Kp4pxmsvURvpeWw2er9cHgy+MysDr6rvyfBrYuvvCbrirjANdV2xZlsy6mD5Zy3FOcm8HDTWlHw6WhaRTJ+9z0A9uws3TtjyZtyAan0YMLOMxf8YsmggqME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732783366; c=relaxed/simple;
	bh=7ZZDaAfSE8cvMEwpoEXTL1xwZPoGe7nBEVbFQ7QIRF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TclxctX5SsXBAjMDBr8HmNPaiM8dbX7DE7NY0pH45oIq92ELXbxMEGxjJ7CWnIAMvoWmYr9rcxb0feHhnHbSGoHboF53dvXRkG8La1ezkhobIoXtgQVw7b8P9hUAy3PncN6elU+f5BDqBTXHGQns0F6m/QXZUycnj+js0uOyLfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ObczU05z; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa549f2fa32so74347266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1732783363; x=1733388163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pqNO4mcpLsB6nl6y5oYnZ+p9PNe/HBxDvPKQfTS22pA=;
        b=ObczU05zGngT5t+FjOc73Zp0ghg4R1SfPxV+AgBL7wfjC7qjSF0W75ecXrurP6MPAf
         mDT0bGbJCXWwL0ii0Nl9FvaPv/bguLBOqxygXjrN0Y9Z23Y7BMXeEjtPKI8iAhdBkIdu
         hw938N7rXHnektH8rRjiLZ8pQuAJ8h6PQMU26mk5IeL9jd0LfAUu1Lf3xhBlJvTlWZa1
         IrLbL5n+NYkcabUxSyO7qTdTK+Rqx0eizBCMD+1hAne8YNxROQMkq4OQQIqO4ZRWpxke
         OwPw7gQUK0AYTHIbx14DIG6TcIu2qqlzpCRGD0wiIoiXTdkr33pFXHMUe/vUciqoaaqO
         nfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732783363; x=1733388163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqNO4mcpLsB6nl6y5oYnZ+p9PNe/HBxDvPKQfTS22pA=;
        b=d+W8Tl2eC24M4AyHM9agm13RrClIhy4+sM1YWefE+GEdsCm5Se52OQjGC3jn/8fYzs
         2aJ9pYuEMXaImTgeoaCcVZMWxUp0SOMvuBLvB6q3lMBgOVZbpL99gkBejhCgOHGUxNsT
         PrlRO0UEkuxFlWLcEoosiJi7+MtpICDZ1cf1FSGLrDPg+CMKqgsiWRj81GNmYzYuqnkZ
         qHY/iewKa2n73y2BTxTfphjaL1iZuNBrbh1fL0YeFsZCaj1OmHFSzwEvUVAKahTy9GMJ
         aKVhGxU7p6H5iKRJwxSzG+NrE5XtIYr+Q8B7/jBu16FnaRTvUIckXbhPVWckwgGNycE5
         Ra1w==
X-Forwarded-Encrypted: i=1; AJvYcCWpRKAa+SDjiyw5q8vkpJtvV7ObAmY3j7rKpyG7L1a3OcBO/ugukV+EEN3X0VYM7ivvA64owir7qC1oOhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZprNlWRF/Br2YxGDwrlyaXAELVb6oR7G55nakxgvfXHzm1ldU
	9jK95aZnrWwlwIuME5P33LyjTFBXzh4vpc+qulgb9fuuCSWECXedGanxZGyGfog=
X-Gm-Gg: ASbGncuuDb6ekY/+cCW8NHjbemc6Zmv3ovGHuA5xI71syiM4aG0BoPoEMu77kQk/HdV
	50xAhj4OeMvI0XKtszxP1FaYhR+cSu1HnuLW7Jj3Hicg5mhn6cGQk8HMe2cne7Fn/Z0x82dOCzp
	J96YOr5+6JGubeTCZJ6LImWpJJ248s5b9IrhmjLc1n8+ekDLCmYC/TBUSQoDW6CRiEFw/mgn6P6
	9yuTar64cBunyOrOdzymuxHOEF8v5irW69QN/NkD0ctBVQhD1QR+q85C+bJnlSM9fs0Gsg+HaBD
	MbbqTIcS7gAHy/hs0pt/WHk8FyLA8w6MRLE=
X-Google-Smtp-Source: AGHT+IEtMpQZWj4endJlLK3Ilr+mbQxtLK9EL+/Wn1Pn2YYjrHxtBwEvTjmbyjJN4oWe/ENTW6ynRg==
X-Received: by 2002:a17:907:688f:b0:aa5:d1c:3dac with SMTP id a640c23a62f3a-aa580fdd57emr475064966b.36.1732783362949;
        Thu, 28 Nov 2024 00:42:42 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5997ffc1bsm41610466b.83.2024.11.28.00.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 00:42:42 -0800 (PST)
Date: Thu, 28 Nov 2024 09:42:41 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	James Houghton <jthoughton@google.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH v4 14/16] KVM: selftests: Provide empty 'all' and 'clean'
 targets for unsupported ARCHs
Message-ID: <20241128-24a975e227dd4b86393f21ed@orel>
References: <20241128005547.4077116-1-seanjc@google.com>
 <20241128005547.4077116-15-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128005547.4077116-15-seanjc@google.com>

On Wed, Nov 27, 2024 at 04:55:45PM -0800, Sean Christopherson wrote:
> Provide empty targets for KVM selftests if the target architecture is
> unsupported to make it obvious which architectures are supported, and so
> that various side effects don't fail and/or do weird things, e.g. as is,
> "mkdir -p $(sort $(dir $(TEST_GEN_PROGS)))" fails due to a missing operand,
> and conversely, "$(shell mkdir -p $(sort $(OUTPUT)/$(ARCH_DIR) ..." will
> create an empty, useless directory for the unsupported architecture.
> 
> Move the guts of the Makefile to Makefile.kvm so that it's easier to see
> that the if-statement effectively guards all of KVM selftests.
> 
> Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  tools/testing/selftests/kvm/.gitignore   |   1 +
>  tools/testing/selftests/kvm/Makefile     | 336 +----------------------
>  tools/testing/selftests/kvm/Makefile.kvm | 334 ++++++++++++++++++++++
>  3 files changed, 340 insertions(+), 331 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/Makefile.kvm
>

Acked-by: Andrew Jones <ajones@ventanamicro.com>

