Return-Path: <linux-kernel+bounces-287504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81969952889
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 06:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B661F2350A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 04:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66923B182;
	Thu, 15 Aug 2024 04:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X4Ua0H7n"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD14C2A8E5
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 04:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723696400; cv=none; b=Y26fTFjSPdJiREa/9I9rhJk1CE9liGdfyKaLgHAcja5k9aXqT+LxbOPCrYoSnT7tPgy+49NAdn0DQmDgboM/ZeK6pwoT/ShGfC7i1D43ZEcsz/Ux3iU5sI5DgIBilC1UamTCWkx8FzglciN9lSdFlnMiX4fHQTyT2Q69gvNni7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723696400; c=relaxed/simple;
	bh=PHkFHT7aXgDsIO27iXXdIhiAjWMTlwp+vnPJOk/XSzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rL05O7tZw/FHjRVYBLa6vKP4lXLH9rJdt+9PCRLSVeDt8FOv4UZaEKMs/YvBiCXCXJNcqurDTuTek+RFc8OVCe/0/MLTH+ndBg0qrVd/jm+ZkfYLz0tuHgUtzW1RTt+nOxqCSTU6uRQAFp5W2lS13gml7HlYlmvOFvQjXOajeXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X4Ua0H7n; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a20b8fa6dcso33972285a.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 21:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723696398; x=1724301198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mL7lVxheOuOGYib+u42mSKDtfjugmG5E83SSWvNp9o=;
        b=X4Ua0H7nIelBfyePLimYO7Td497gMyRtv/JuYjxlR3RyFDnLAacExhAqL4Qd9ZMJdB
         rPy7MciFNiSCqixg9o0VSkXZ4nKfXw4ezZ4gAsidkxhgXSn7MjmkIndbVD7TjCFcBg6k
         QgEq541KsLN7Wlt18X+6gtP3lPc+xLMfDWutRwOcSMoRvJ9laeeCMwkKtL7H1toZLCvl
         DHKoXr6wy7GkttoHpJ3GCPTSyYAuBpFpBE9QOBWkwUB9/0z311sxM8v3Z5LzH7KCWa+h
         C1DNGuEO+wQpwQqNK2o3kb8D8Ze6aC0iC81CXSGqzpz8RUMBKZZr1PuU9pchadKBHVHW
         3H+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723696398; x=1724301198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mL7lVxheOuOGYib+u42mSKDtfjugmG5E83SSWvNp9o=;
        b=d2uVZlVBZeJkR2GtvWamL3kzh6JlkIkdPO21oEIfInGO130cLxi+PDsjBxxDu/44LS
         G5clb/I2MJtP3RGE+Vpg9ApwPPgKcjQqe5gRkvpXHSeLF8mgmyqyuqwPmBTQVrDKafS2
         vjBTVLJAlU1bsFipPXQaEKmZfcnHGEesoV6QJZMpWp8SkCYYkG5gV2GafyBwfnE6sbIw
         enXxxa7lIOzSuur0e2vVOjtFGb+/B9VDswFWvvC2NKvDN4p987gwqocIWJ/G9vFXHOKk
         5YhSCnkGQnYEXR/p7Ap50diNqPUZIdwi4oq+UVsMGZSQS2bt7bFGnr8I0qSlExT2lo9K
         WzOg==
X-Forwarded-Encrypted: i=1; AJvYcCVYr6n/nGCj10qZ+U4HQ8dqD96DFL/g7TJM1kEMdHPGAImG4UePDpW3/rWVdaI62oKMzRzAtjHkkabfsh78Ys/XXsxHWDyz3DqU+nqX
X-Gm-Message-State: AOJu0YwZ66IZ2C+Y6ZtGLqwSygmlooy5BLCKA3ukIG4UuglI656Jyjb+
	VFvf/KiE5zXVB8IYie8fDd9tms4ffV52j1X5WNsLz3L65ZX63LRNVLYMhVqR9DJk5TQIdee11bc
	DmdnNah/xrq+0GPuUyCP0c6dskyXTs6uvgVux
X-Google-Smtp-Source: AGHT+IHp0Mv0umuwx4M7j9iBHKv4L2D7jjyHbT0rsHN9Fp+h3T+KIQJZ6zUxV73fDUj4HBH+tKjmCgBON3DJRI6T8YM=
X-Received: by 2002:a05:620a:4489:b0:7a1:dc97:5a51 with SMTP id
 af79cd13be357-7a4ee3e4e08mr565255985a.58.1723696397516; Wed, 14 Aug 2024
 21:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710074410.770409-1-suleiman@google.com> <ZqhPVnmD7XwFPHtW@chao-email>
 <Zqi2RJKp8JxSedOI@freefall.freebsd.org> <ZruSpDcysc2B-HQ-@google.com>
 <CABCjUKD2BAXzBZixrXKJwybEPoZvkmSPfy-vPKMbxcAt0qk0uQ@mail.gmail.com> <ZrzOxxu1_-f5ZZ1m@google.com>
In-Reply-To: <ZrzOxxu1_-f5ZZ1m@google.com>
From: Suleiman Souhlal <suleiman@google.com>
Date: Thu, 15 Aug 2024 13:33:06 +0900
Message-ID: <CABCjUKAkBDCs6knb34sDxOsXT7JwCS_jcknmu9rainx=eM_4zQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Include host suspended time in steal time.
To: Sean Christopherson <seanjc@google.com>
Cc: Suleiman Souhlal <ssouhlal@freebsd.org>, Chao Gao <chao.gao@intel.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 12:35=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Wed, Aug 14, 2024, Suleiman Souhlal wrote:
>
> > With the proposed approach, the steal time page would get copied to the=
 new
> > host and everything would keep working correctly, with the exception of=
 a
> > possible host suspend happening between when the migration started and =
when
> > it finishes, not being reflected post-migration.  That seems like a
> > reasonable compromise.
>
> Maybe, but I'm not keen on sweeping this under the rug.  Ignoring issues =
because
> they'll "never" happen has bitten KVM more than once.
>
> At the absolute bare minimum, the flaw needs to be documented, with a sug=
gested
> workaround provided (do KVM on all vCPUs before migrating after suspend),=
 e.g.
> so that userspace can workaround the issue in the unlikely scenario users=
pace
> does suspend+resume, saves/restores a VM, *and* cares about steal-time.

I can write a comment in record_steal_time() that describes the
scenario, mention it in
the commit message and add something to the steal time part of
Documentation/virt/kvm/x86/msr.rst.

-- Suleiman

