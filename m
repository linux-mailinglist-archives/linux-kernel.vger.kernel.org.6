Return-Path: <linux-kernel+bounces-227440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A51AC91513F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F7771F21274
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995D919B3D4;
	Mon, 24 Jun 2024 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E6Vfwtm8"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96156144309
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241336; cv=none; b=P6qfUc8FgHpikJYPBWVm6tGMzKoCy1JzEW9pqsT8at5bPr8vxMW1L9jgM/DQmg4p1HTUL4xKquNowiYYG534iB1D6k2fblTk+m8F9DYoXw/1EdTRYGIHUF4DvOMzVaQw1gTgwbtHpBt4RJQ+BRXkJJEE4BbWGnqQhaJH3yUoXzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241336; c=relaxed/simple;
	bh=RWPDDMkBBJI5GXg8+0PX2He/GP0QafCNoivJOEpVWro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XkElwpAtOY4+Kh3HnfphnOUfl22plDqbOm6ikL+f7W8DH6cy6WZQiXtB8DvqMn/IZwniCpxE5fxzckh3EU0Ah8vs2jYiPPg41PvhYOqUVCBF/ifBpuYpf//11OqDWPfxs9zf7FI+l+Q/ONp2qMHcOkEtHrUoywJv82tW0Ngm8m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E6Vfwtm8; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02f7e5be48so4338509276.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719241334; x=1719846134; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l4T/qiCTXUS9baKPXu/a0D1pfkxykAQu3gzK12/3rIc=;
        b=E6Vfwtm87ehpFyIXo+fkOHYO7v3tsnKiXc38gWep7jaywN66pWAHUgbd1gWIg4hzvd
         lQ5U5xYCdJInfvye7ABFsdKCYPnAKYPXYg4K7WHvD5GevKLRHFw2QD/nVbZNGWyZyDtH
         lDTEG7a0ZuMCIWq2pf8j3iZrFPRG6/WNJwH7tHbztWdlejbrZQT4f4hCocxtMEtDNvoA
         1efk/YQOgjsBQKJGt9uJKkcmzOX/OYuaUJF27RoqEj9yG5UFr7TBuO06bsW6trnJxUxg
         p7jdu4e3dGmMUx5sy8FLyMuSTmXTPewMtKifcH6uJOEI42AyVPTz+TOCiDeZG/Z1l2Jr
         84JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719241334; x=1719846134;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l4T/qiCTXUS9baKPXu/a0D1pfkxykAQu3gzK12/3rIc=;
        b=f9v9o9OAOaM9hW+R8KaJDKxwVPGXLqzuucTramL3LZzsE3mrGrzKo0lqCYW3jUl2z+
         6NczzuDG/wSCHjnCChQPCyoMHztbLXet3Nn4PFMj8jp/YHvOc9kNmIGB2oShNVo6nOiQ
         wb+K5KBSsp8cOVs3WBtOUqib+LatOgr0S3/oEcgKp40bw6znTQNBTchHJr5PWzs2Ir/R
         moKrKzu8hLR32T+P1znbwvM1xY2pytumu2r4hP2mI4EJZv4m7ykGWuM1fjGhZCbety59
         SIYzo2p//VGsD9vv6O3bRPSgnIvVhNUoSYj5TIkZ1sOOk93K0XcWcL4mQFd5U6GZhf3U
         XYRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWd1K+GJvrI9of2pS/enzubMWet72/7UdpRJZeFWMkotwicjF8xt9QJgZBb2bcgPgPy7zCOHWI7i/8OzDd6JtGmIfG287P4NHDOcYzI
X-Gm-Message-State: AOJu0Yw3nsSRaobg2QxmxsshF762OcUHkyKffV+J3ShSZHvXZ7hnufxW
	XG3dY1QjFSyUNvykV9X0k1TIs65i8iLVmhFWRLRx89fvmHyEqH5IDlTZZKTBY4SRQNd+CtVbSj8
	NGQ==
X-Google-Smtp-Source: AGHT+IHVuhaaP+AqJkLOnP2nm2zoMNpTnmJWMLB94vD9m0Y86WTHHHaebaE0uZUg+d3sb7uwTDEgx3Svrng=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:102a:b0:df4:d6ca:fed0 with SMTP id
 3f1490d57ef6-e0303f28704mr13386276.4.1719241334515; Mon, 24 Jun 2024 08:02:14
 -0700 (PDT)
Date: Mon, 24 Jun 2024 08:02:13 -0700
In-Reply-To: <545135fe-adbb-bf95-5b60-0646a76afaef@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240621134041.3170480-1-michael.roth@amd.com>
 <20240621134041.3170480-4-michael.roth@amd.com> <daee6ab7-7c1e-45e3-81a5-ea989cc1b099@gmail.com>
 <545135fe-adbb-bf95-5b60-0646a76afaef@amd.com>
Message-ID: <ZnmHeGU29F-iFeNl@google.com>
Subject: Re: [PATCH v1 3/5] KVM: SEV: Provide support for SNP_EXTENDED_GUEST_REQUEST
 NAE event
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, Michael Roth <michael.roth@amd.com>, 
	kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	x86@kernel.org, pbonzini@redhat.com, jroedel@suse.de, pgonda@google.com, 
	ashish.kalra@amd.com, bp@alien8.de, pankaj.gupta@amd.com, 
	liam.merwick@oracle.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 24, 2024, Tom Lendacky wrote:
> On 6/22/24 15:28, Carlos Bilbao wrote:
> >> +/*
> >> + * As per GHCB spec (see "SNP Extended Guest Request"), the certificate table
> >> + * is terminated by 24-bytes of zeroes.
> >> + */
> >> +static const u8 empty_certs_table[24];
> > 
> > 
> > Should this be:
> > staticconstu8 empty_certs_table[24] = { 0};
> 
> Statics are always initialized to zero, so not necessary.

Heh, the whole thing is unnecessary.

	/*
  	 * As per GHCB spec (see "SNP Extended Guest Request"), the certificate
	 * table is terminated by 24 bytes of zeroes.
	 */
	if (data_npages && kvm_clear_guest(kvm, data_gpa, 24))
		goto abort_request;

