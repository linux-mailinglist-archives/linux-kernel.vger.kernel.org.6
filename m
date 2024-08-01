Return-Path: <linux-kernel+bounces-271048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 039BE9448D9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35D8D1C21388
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784E6170A3D;
	Thu,  1 Aug 2024 09:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a/dBYzSf"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7D6170855
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 09:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722506031; cv=none; b=PF2Ez+YQi4bBgYx2igXA1TyR9yajGAGX4NKf9p0COIN+wcTaOygP77vkm7bU8hdK0iMy7aFfHByZZTxN9nkCKiQsB12vzvQS4xumbDEDl6iHwX/16bvv+/VmiSt0V0yhiDYvSJ7yMsqI0gg1CENbgWYcpVM8F4D2HN5ql+yw2do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722506031; c=relaxed/simple;
	bh=RZpvv9TExV/YqUUjMHmoW7U1MADjmJXiZRuzMf5dgoY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EMkSRGi2uKC7+K7Rte30hxiRpafQd+7aqmrjIDM/zSVE3CTLkL7U0kz9uAFV8HeajtK14Vb3Ob/6kWfIgdsYFzbkr948lePeWsS2BKHh6nZia6h/koW/xXS2ov8jvx9/oZx+3avsjZnRSAFv4vnE+Ah0+oJWbx+ITREDEutRrAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a/dBYzSf; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a2ffc34722so3551485a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 02:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722506028; x=1723110828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8MGDW2w0EUrwnI4S//nT3S+vOipXyZxOwDlAdIY1JMk=;
        b=a/dBYzSfBpI5enxqoUMWB2ZrcLecJ4RQ07xZsqTfvEPG8y+iKY2WVjBSKf4EuQJj7b
         +kfVWQuiDXL+kzXPPy30oqezNnRWzLLGKYjKkEj9CwvMB8XYTeBmLtvW+Q18B3jMHTZa
         XXWX3sW3xscqS+SnCKXW63ftbUrlwmUx7fCq3nO10Bh+isizaBNn4ohdO5/MsBMljJqP
         lYe7xmgv4RTftKlNKJtZO/k6u/pHgk14GYqsXx/5LAlCT3+6PA6NJLqw9P2FMaxgcmZj
         vdqa9kwjs16uWwoIoOj9h6OskhpUPIC2eVO5PzEyzLfH4Hc2GSDR+bRsnkXg5234SDbK
         o1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722506028; x=1723110828;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8MGDW2w0EUrwnI4S//nT3S+vOipXyZxOwDlAdIY1JMk=;
        b=VZaZdeFOtMF0TcxMWvvDoh5c89aPiNBKZATwriHYambiv+EAq3MyITKH808/YLg4NR
         z6GLR624sOh0ApmrSFGCSxU58goHLB7nydYpmYB6PUjzYl+TS6iSWybPZKOiItC1LrzJ
         7Cm4aJHxKZTazc3wTyeqoQWvZbR+w55yRIT90oX64Pnx7GDhJLo56FxueUbvYtdpPqNr
         uGG8UF5kpDsJfYWZTRiRFMDPidbmAyYZg8UcVYADLW5t8eL7Dv8sLQoAUveLlZzSxSJs
         1BdO0UvzXgfkgybQuwSSanFozU0v1xWMyqQKkPBzzWb2Y+nioZFMXb88vads/2hoRpoU
         00wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWTA5cXt3MvhVF0gb/DS3Y09lWNjU8MEN1nrVhMtxIYh3cRkBy7sNl1PvyRUEBKYRvFzHIJr91bNmfkdUCog9vigg115aL8dax2tLa
X-Gm-Message-State: AOJu0YyFGyX67w6U/5HcCZLjucdnspB94LgAlm3D5ugGEnQrs0M2gQC1
	RIuVmBqFuA/Fq0kCLEVFaCOS/hH6VBu/5NZ5OJUMvbR8TawDrKwjFVr9qW+NrQ8=
X-Google-Smtp-Source: AGHT+IHNrw29WKyolinu6cyXHFfq+0WsM6WXcBxZ1/oFvQaGEtI1aOWo6VY84S/JlZwJgkWdM0qlVw==
X-Received: by 2002:a05:6402:440d:b0:57d:5442:a709 with SMTP id 4fb4d7f45d1cf-5b778dc53f8mr879162a12.0.1722506028149;
        Thu, 01 Aug 2024 02:53:48 -0700 (PDT)
Received: from draig.lan ([85.9.250.243])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b5257f39adsm2866327a12.96.2024.08.01.02.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 02:53:41 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id CC0595F80C;
	Thu,  1 Aug 2024 10:53:39 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Marc Zyngier <maz@kernel.org>,
  Oliver Upton <oliver.upton@linux.dev>,  Tianrui Zhao
 <zhaotianrui@loongson.cn>,  Bibo Mao <maobibo@loongson.cn>,  Huacai Chen
 <chenhuacai@kernel.org>,  Michael Ellerman <mpe@ellerman.id.au>,  Anup
 Patel <anup@brainfault.org>,  Paul Walmsley <paul.walmsley@sifive.com>,
  Palmer Dabbelt <palmer@dabbelt.com>,  Albert Ou <aou@eecs.berkeley.edu>,
  Christian Borntraeger <borntraeger@linux.ibm.com>,  Janosch Frank
 <frankja@linux.ibm.com>,  Claudio Imbrenda <imbrenda@linux.ibm.com>,
  kvm@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  kvmarm@lists.linux.dev,  loongarch@lists.linux.dev,
  linux-mips@vger.kernel.org,  linuxppc-dev@lists.ozlabs.org,
  kvm-riscv@lists.infradead.org,  linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org,  David Matlack <dmatlack@google.com>,
  David Stevens <stevensd@chromium.org>
Subject: Re: [PATCH v12 24/84] KVM: Use plain "struct page" pointer instead
 of single-entry array
In-Reply-To: <20240726235234.228822-25-seanjc@google.com> (Sean
	Christopherson's message of "Fri, 26 Jul 2024 16:51:33 -0700")
References: <20240726235234.228822-1-seanjc@google.com>
	<20240726235234.228822-25-seanjc@google.com>
Date: Thu, 01 Aug 2024 10:53:39 +0100
Message-ID: <87le1gefh8.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sean Christopherson <seanjc@google.com> writes:

> Use a single pointer instead of a single-entry array for the struct page
> pointer in hva_to_pfn_fast().  Using an array makes the code unnecessarily
> annoying to read and update.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

