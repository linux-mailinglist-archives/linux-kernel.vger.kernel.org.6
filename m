Return-Path: <linux-kernel+bounces-401316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289C09C18BE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9BE282CA3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6A61E0DE0;
	Fri,  8 Nov 2024 09:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dyTmE3Ni"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585871E0B70
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731056729; cv=none; b=QBATgCcFRNAzMXrK+dg9l9PD3FjRnheRriaWV1mwIaFzX7+HprT0TJzl1K6Y6J5BuEKPME9xCLcVaI2b3drTESi0mh1oa/3p2w2yyLwrSfEVFnWtHtMz4w5qMT75q5ZDM8XCuYgNd4QCTlr9Cv4DxvJRguaq5LSilqSaGhv5lXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731056729; c=relaxed/simple;
	bh=/9i+bLZW6te/f0iYhWbjrbhg4l3hVSSUfE4orLqvC38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4z4056wK7Hh8paJpgdh4FD+kh6CFylatEthTlq7ek9/3UlnIYRfV+BtunC31I6nG89IksRxSz1r5WFDCDa89vOISj1W8eSMrePsBknScg2hfPVhfDq7Q7jBugE27p3N/zS+Crbn6Dn0BeOgsTZX8Wz5G8106YF2pUkewiYqYJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dyTmE3Ni; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731056725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LrElxwqnJR5DH5QdMVYz2iwh68nuYwJL/C3mT8YyNoM=;
	b=dyTmE3NiWWWdTF6966940Og/Lqo2a5eG4Q6hKWqPmOA2XSZ10isjs3A1OgmTlJ1vefr402
	vFcrFkRabKTp9AvmIomdhP84i7vXUY2YWm2W1lyJAkQgbTqFbA0/kO7QVy1mnCX4KSDwkL
	R79a/H3A9nLaVDJEBX+UWomeGN9C0r8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-fnbyoRwBPae0cY3j1p8FIw-1; Fri, 08 Nov 2024 04:05:23 -0500
X-MC-Unique: fnbyoRwBPae0cY3j1p8FIw-1
X-Mimecast-MFC-AGG-ID: fnbyoRwBPae0cY3j1p8FIw
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d4854fa0eso1045969f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 01:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731056722; x=1731661522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrElxwqnJR5DH5QdMVYz2iwh68nuYwJL/C3mT8YyNoM=;
        b=j1Efay7VYcyB6yePQ6sKnkdj7LgQZvFzaBR6Sq5jZmcVExAzh0z5UVT/ubEMA+byW3
         gX0muWuWE1LCIPqfkzzHeVAE92iJdHC8CM730uvxJbzp4IKJUUwtOzhtL8N97gVOHW5j
         wA1sMaRv0hczlXVr22YYn1Gv4olfhd49hO5vhDE/ntsDDAdo9paLvBVpfc4OAUchPDfX
         XfN35vE6ba8g6F9L5kVN5UFDoo/BXzdZ8UpkDJNyklgn9wzlNs0Td/4EBmIks+5+9EX/
         3/F9KXRRQ+yBJCD60QlEZ8mCgMCGEgZuMqFjsvz4pftlwN6MUCTGyPSh5a9w1wZ4/n9I
         PBeg==
X-Forwarded-Encrypted: i=1; AJvYcCVynDLS7j/eXxydzl5otl/1859e3JlSoY6kcWo7k9zr9uYpOmoLRirvavPrEGGHvCwHtFrXSG7S4c/+xPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5E4o8+JggDzVkJBAWR+Z/Sz9Q5Utu8hrOJ6ptlGkCb8SEZiBr
	UKHzZEqmLsB95IQ6qNMpvOVLIvA5qiYRpyuxYri9gHRiSBEyr4vZgUGSgCTIfTRfv8W+ZCCx23Z
	hs+6vFTyyrWr3WMQIpcp1aNm4r909mmr1HN9SMo1O+nJkgn9k/VAJjuWsJk+VDfbJ3ojxfTRkgr
	yg4ANvp1CYa/SdBCFpv1NpcWXDhooK2PrzbIMe
X-Received: by 2002:a05:6000:480b:b0:37d:45f0:dd08 with SMTP id ffacd0b85a97d-381f186731amr1816416f8f.11.1731056722540;
        Fri, 08 Nov 2024 01:05:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAUqJcQr+bA/27fCCgGUP2nub60cseB08K8/4GgQUbkE5m0tGGw43rxa/0FGBd1Ft3SGpNzTEYfwcvTxp7t40=
X-Received: by 2002:a05:6000:480b:b0:37d:45f0:dd08 with SMTP id
 ffacd0b85a97d-381f186731amr1816400f8f.11.1731056722162; Fri, 08 Nov 2024
 01:05:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106160425.2622481-1-seanjc@google.com>
In-Reply-To: <20241106160425.2622481-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 8 Nov 2024 10:05:10 +0100
Message-ID: <CABgObfb5E2WTt50eCx8R6TWD+o+CnOhx3zHGmeB9Xd3EA+sgUw@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86 and selftests fixes for 6.12-rcN
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 5:12=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> Please pull several fixes for 6.12, and to save us both effort, please al=
so
> apply several fixes that should probably go into 6.12 (the selftest fix
> definitely needs to land in 6.12).
>
>   https://lore.kernel.org/all/20241106034031.503291-1-jsperbeck@google.co=
m
>   https://lore.kernel.org/all/20241105010558.1266699-2-dionnaglaze@google=
.com
>   https://lore.kernel.org/all/20241106015135.2462147-1-seanjc@google.com

Done.

> And while I have your attention, I'd also like your input on a proposed "=
fix"
> for Intel PT virtualization, which is probably belongs in 6.12 too, if yo=
u
> agree with the direction.
>
>   https://lore.kernel.org/all/20241101185031.1799556-2-seanjc@google.com

Yep, pulled it as well.

Paolo

> Note, this is based on v6.12-rc5 in order to pull in the necessary base f=
or
> the -march=3Dx86-64-v2 fix.
>
> The following changes since commit 81983758430957d9a5cb3333fe324fd70cf63e=
7e:
>
>   Linux 6.12-rc5 (2024-10-27 12:52:02 -1000)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-fixes-6.12-rcN
>
> for you to fetch changes up to e5d253c60e9627a22940e00a05a6115d722f07ed:
>
>   KVM: SVM: Propagate error from snp_guest_req_init() to userspace (2024-=
11-04 22:03:04 -0800)
>
> ----------------------------------------------------------------
> KVM x86 and selftests fixes for 6.12:
>
>  - Increase the timeout for the memslot performance selftest to avoid fal=
se
>    failures on arm64 and nested x86 platforms.
>
>  - Fix a goof in the guest_memfd selftest where a for-loop initialized a
>    bit mask to zero instead of BIT(0).
>
>  - Disable strict aliasing when building KVM selftests to prevent the
>    compiler from treating things like "u64 *" to "uint64_t *" cases as
>    undefined behavior, which can lead to nasty, hard to debug failures.
>
>  - Force -march=3Dx86-64-v2 for KVM x86 selftests if and only if the uarc=
h
>    is supported by the compiler.
>
>  - When emulating a guest TLB flush for a nested guest, flush vpid01, not
>    vpid02, if L2 is active but VPID is disabled in vmcs12, i.e. if L2 and
>    L1 are sharing VPID '0' (from L1's perspective).
>
>  - Fix a bug in the SNP initialization flow where KVM would return '0' to
>    userspace instead of -errno on failure.
>
> ----------------------------------------------------------------
> Maxim Levitsky (1):
>       KVM: selftests: memslot_perf_test: increase guest sync timeout
>
> Patrick Roy (1):
>       KVM: selftests: fix unintentional noop test in guest_memfd_test.c
>
> Sean Christopherson (4):
>       KVM: selftests: Disable strict aliasing
>       KVM: selftests: Don't force -march=3Dx86-64-v2 if it's unsupported
>       KVM: nVMX: Treat vpid01 as current if L2 is active, but with VPID d=
isabled
>       KVM: SVM: Propagate error from snp_guest_req_init() to userspace
>
>  arch/x86/kvm/svm/sev.c                          |  7 ++++--
>  arch/x86/kvm/vmx/nested.c                       | 30 +++++++++++++++++++=
+-----
>  arch/x86/kvm/vmx/vmx.c                          |  2 +-
>  tools/testing/selftests/kvm/Makefile            | 10 +++++----
>  tools/testing/selftests/kvm/guest_memfd_test.c  |  2 +-
>  tools/testing/selftests/kvm/memslot_perf_test.c |  2 +-
>  6 files changed, 39 insertions(+), 14 deletions(-)
>


