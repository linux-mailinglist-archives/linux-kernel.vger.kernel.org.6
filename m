Return-Path: <linux-kernel+bounces-382296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D32FD9B0BFD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1096B1C208B5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F271206505;
	Fri, 25 Oct 2024 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XQGGVJXe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D904370815
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729878124; cv=none; b=X9MgC3cO+7EBc2as50Mwy+IHOAH+lZwLm3EhgSKaPBZnJ/u2qBuo2X1hNIsJ6+98hw2VrCpzZzUTG6LjPvA5lYZdVGD29XN0vJFz4ic/m8wbV1uB/8ZEtvhybfTVX1sUEoaUapx+FKTIeUTC0bP1rGWM/ZGLPrPDZ44g8L0MOT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729878124; c=relaxed/simple;
	bh=luHPkXcmkzXARAD1k+1siQ/blVliFRMh2F/pQQLu2Pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UnlZgZboN1gBIxgAa/iA3kkYdrulJkId4J7LrMmVlyTm7DCTjUYiK3qLLhM70hstiPdr/D9ou/SFrE5pftc+qR65TrpC1TtxA5g4JM1uyJJ9wUxKS3CTbCITi3PFtamZAHS9lnsaD5ZcEaABuBVR3YUIppkL/WatyYHbSEwDz84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XQGGVJXe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729878121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=luHPkXcmkzXARAD1k+1siQ/blVliFRMh2F/pQQLu2Pw=;
	b=XQGGVJXeAqgRjC3t0U6B0LMNCdt5GhZVZ2bLsaP1SlUZO2pdkbcocWjW59I9Lt2mao9VeW
	iDxGVx310gWIbkxW7TOWuq0ThGCfh3vbfdldMFqMTmb6f7BXD+4Jpy7yB2hqFQbt0xo+o8
	Bfez7gpa1CaXOLMdEzaE8XwHePNMOQI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584--d6oPOSKMEqO-SWDHG61Dw-1; Fri, 25 Oct 2024 13:41:59 -0400
X-MC-Unique: -d6oPOSKMEqO-SWDHG61Dw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4315ad4938fso16017185e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729878118; x=1730482918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=luHPkXcmkzXARAD1k+1siQ/blVliFRMh2F/pQQLu2Pw=;
        b=Q+tpV/FCqi6bmTGbtBHTTp/N0tAxxeDEoT0PE5PmhyPvUBs7PvQbyl5CWy4z5qc+lY
         1W/u12iDQV9SeLXxIDDkE+Yf+kxqMGpWeh+QW5LHcmhOQIJci0TeFRChNjdNlup3MSWj
         4frE1hoAUTDDYMoS1/o8KFYn61K4xmMnfRGkVBpijNIjxN4XyJV/Dm1peO7b8Bgh9Hib
         TWIQLEqrVR0ODAWmFTJ7irWtIj9lsVt5U7nQ+jdEOTyIvTX2VTZxc8SrH87ZxiNXLhF3
         u7uyPCPwUTqORUHGV5yErlxZam4oBmB0YVLilEqCrr9zqUOgx9fQO3xzAqyg4ISZqzIc
         gF6g==
X-Forwarded-Encrypted: i=1; AJvYcCX4XScKVhfKENVQ9xrB9ATrxvm+DGbHh5L9VkUpVgwU6ewGUatAT1BwxY+a/852pzKZcRO8h+RSZC83S44=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxhlWylQIhls9q5hzrzGv7YsiiFhV/qwzwu0UrQLJayvPCIdsN
	7KMtBEilbknalwcdc0mswM/2Vvgimyr8V1lvEwwbgUadnFkyhwnK5/odFskqzKdCsyceoEZxkSq
	RXhn17YCJMFal+/IBhn5oifEwXSTTflhZFZeT6xNURj4WGtIGbR+la7VPvPJgx8lopBnUY9zXEn
	qxLbr0UoMh8oIbxdi1jlIFmLc0vKOmolcjXo7k
X-Received: by 2002:a5d:410d:0:b0:37d:5436:49b with SMTP id ffacd0b85a97d-3806113a07emr163655f8f.13.1729878118146;
        Fri, 25 Oct 2024 10:41:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJirsSaLOjUEz6kn7HmxOjIyhE9ZfBrB9GAGHgNcgNSBUFOeNbcRoyDDrANp8n6mxM4gCIddwEWDqpYot15qQ=
X-Received: by 2002:a5d:410d:0:b0:37d:5436:49b with SMTP id
 ffacd0b85a97d-3806113a07emr163639f8f.13.1729878117761; Fri, 25 Oct 2024
 10:41:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010182427.1434605-1-seanjc@google.com> <CABgObfbQW-3vp=mNcR4giUGZ_gxhuRykvKj8gzBDY7pOg6xdBQ@mail.gmail.com>
 <Zxbw9XcFCHYR1Ald@google.com>
In-Reply-To: <Zxbw9XcFCHYR1Ald@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Oct 2024 19:41:45 +0200
Message-ID: <CABgObfayH1x3qFjOiM=rQjxiui5tXJXObgR_qOGV5Hn_2QLEJQ@mail.gmail.com>
Subject: Re: [PATCH v13 00/85] KVM: Stop grabbing references to PFNMAP'd pages
To: Sean Christopherson <seanjc@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Yan Zhao <yan.y.zhao@intel.com>, David Matlack <dmatlack@google.com>, 
	David Stevens <stevensd@chromium.org>, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 2:25=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
> > Looks good to me, thanks and congratulations!! Should we merge it in
> > kvm/next asap?
>
> That has my vote, though I'm obvious extremely biased :-)

Your wish is my command... Merged.

Paolo


