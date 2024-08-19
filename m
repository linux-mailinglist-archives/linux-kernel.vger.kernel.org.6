Return-Path: <linux-kernel+bounces-292985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E2C95776F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 00:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 352291F213DA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 22:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA551DD390;
	Mon, 19 Aug 2024 22:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="35UHijop"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F8D1586C9
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 22:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724106508; cv=none; b=Veko2Fjd/pSWNOzQPmNRyQ5Pn2I4G+fv6I13ti6bbGlL5eNptI47Yw/xXKb3QeRrS9szBUlUMd3ciz7AFPesyImRcN73GurjjfLVgQvwPUCAP/qf22D6UuD1jqocyvr0WyBOHURgvXV/w5D3KKkt+rRu5gp3/zJoEiVUdT3bt58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724106508; c=relaxed/simple;
	bh=ZEjJzN9aiAqPDL1MDM5QtbBO0s1MU6UDD1d1MLpYQlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmRTpyeBWg30fcoCqeCFKZJ14iMYIhkm0EsaxWixP9FDXhJQwHV+5dTF4+2VJs2+iTngUJ7AM9takTgWlpJ1X+A2VWIJZQgW7/Tosp4VlNaZNA2h7Se6A1RDTA4F13kIpiW/0zy4rIj1y+ya8Q/Pc7mRajtNCcVh29oItfyQm3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=35UHijop; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e1654a42cb8so4407276.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 15:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724106505; x=1724711305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVv219WT3XFpvaNsrjoStt7h0RDiOidNBPHNrb4LTk8=;
        b=35UHijopsZ65K6087eyY9YAMu9ECP0X0bK04xE3Vlfq8ZORNSJ8Z0lP0jMWIHt9y7R
         edNqv5w8QU6Qsv7OkPDLrREaHrjt9ZbCnUJBJiJDAXCXi6SZOibcw1boy4azMgmxQoxD
         OSDs/sXMQgR2UXfij2pe14kolYVhA1Mwf3BCCkDYjRkpJiALl6tM0jEdZtHDKKlf3NP9
         6dG9vkcuehflpubdtHNMdnwTCI4ZnMgNixmvkkJh0oqV6/tmYLiduKdYc0Ca53Z1o82t
         FIiac4lQnZf1VCnTjwyXl34eC0gG/top0Sgck9RwZwYz7huGCgHuKEHTARzqTeYWxRrR
         tA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724106505; x=1724711305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVv219WT3XFpvaNsrjoStt7h0RDiOidNBPHNrb4LTk8=;
        b=g392FUf87rhqSpW24CMPOgd5gQBTXY01C3nmeFLe6Kz+QfFAf2jdRu00/xCwgu2cEU
         brKfUtbT1xs9+YZ2XRXwWYT3UQLA6iwAsUqruryKfIcZ0eZQnykC+p++kwJfh+QlHDGR
         Un5WyNLrXuUmBsO++h6ahUl1Jk2qE6FBoh+pqKBjpURQQVxvnFK/05cClGJMqigZI5DQ
         wN+uNkMEh21SIQm81dNu7v5GQ2pPCMX6hFlLIGbiA/9ugcr93CGruHUnQbZeQiisX9Uh
         KcN9pERniW4DyugmSslnZcYdD3g8xjtcLm5t5PrGUplcuzwjrdwN0XR+Xxz1xEPZ6yBi
         d5/A==
X-Forwarded-Encrypted: i=1; AJvYcCVIRp/5FqkFoeL8eApAbjd6mCE1RP5FGpjUJt/N+zAx8b/uButYyad7MdMgWmuNzY+IdI2scZL7SxoLELgKjgf2rpSr6dV5JXr758cq
X-Gm-Message-State: AOJu0Yz0f195Qz2KytegDmQ7EO7mYHaL3O4Sv2HP+Vc6vhwDa8SWTI9A
	UJZjAa5QwBbA1zh4V899C4VyJbFEXzAZ8cC6TUyzZPWICx5tJ3MndX9/1j1TX8iFlm0/u0Bw3aJ
	IfX4Dg4vTzJ7I3MFpx7mlfjaUrSEEz9HD1c4v6phbh+ZDjD/Lo2sZQAQ=
X-Google-Smtp-Source: AGHT+IH+o8pbaZCD3DErY0Efy5PIww7+Btqf0rJq8Jo7sTDxiVJ9KJQcxH+l0pzfF1KqLUtx8OZjddc6wIisVj2Z8qo=
X-Received: by 2002:a05:6902:703:b0:e11:5db0:13aa with SMTP id
 3f1490d57ef6-e1180ef27d7mr14209176276.32.1724106504770; Mon, 19 Aug 2024
 15:28:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1723723470.git.kai.huang@intel.com> <20240819212156.166703-1-sagis@google.com>
 <29fba60b-b024-417c-86e2-d76a23aa4d6c@intel.com>
In-Reply-To: <29fba60b-b024-417c-86e2-d76a23aa4d6c@intel.com>
From: Sagi Shahar <sagis@google.com>
Date: Mon, 19 Aug 2024 17:28:12 -0500
Message-ID: <CAAhR5DEEsFNqdxbd62tGh9Cj7ZQMQs6fEjAKs6djkZzgZALOfw@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] TDX host: kexec() support
To: "Huang, Kai" <kai.huang@intel.com>
Cc: bp@alien8.de, dave.hansen@intel.com, hpa@zytor.com, 
	kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org, 
	luto@kernel.org, mingo@redhat.com, pbonzini@redhat.com, peterz@infradead.org, 
	seanjc@google.com, tglx@linutronix.de, thomas.lendacky@amd.com, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 5:16=E2=80=AFPM Huang, Kai <kai.huang@intel.com> wr=
ote:
>
>
>
> On 20/08/2024 9:21 am, Sagi Shahar wrote:
> >> Currently kexec() support and TDX host are muturally exclusive in the
> >> Kconfig.  This series adds the TDX host kexec support so that they can
> >> work together and can be enabled at the same time in the Kconfig.
> >
> > I tried testing the kexec functionality and noticed that the TDX module
> > fails initialization on the second kernel so you can't actually kexec
> > between 2 kernels that enable TDX. Is that the expected behavior? Are
> > there future patches to enable that functionality?
> >
>
> Thanks for testing!
>
> Yes this is the expected behaviour.  If the first kernel has enabled
> TDX, then the second kernel will fail to init TDX.  The reason the first
> SEAMCALL to initialize TDX module in the second kernel will fail due to
> module having been initialized.
>
> However if the first kernel has not enabled TDX, the second kernel is
> able to enable it.

Are there any plans to support both kernels being able to enable TDX
in the future? Either by changes to KVM or the TDX module?

