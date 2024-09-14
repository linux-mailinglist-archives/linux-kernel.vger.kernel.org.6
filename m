Return-Path: <linux-kernel+bounces-329412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 495C7979106
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 15:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0120F1F22E2A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 13:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23831CF7BD;
	Sat, 14 Sep 2024 13:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V0nmaUBl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2B71CEAA6
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726320927; cv=none; b=Ow1y6kUjJrea/4Rs35UCv6/1MsS/RvH/1MqXMa7BIhtwWW3rcyMAvlaAdBc83DzRtpQRnHZ0RXn7vpqZvZu47Cgsb3ZPdI5cn81xvdef8inahy6sZe0Z6/K65K1D1Vc8epz9wqbrK6sYj5l2wsgaFpTt0O0r00JrhDxPBYs4zm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726320927; c=relaxed/simple;
	bh=iL2sP6qDwiloz5Ja9a59YqgaEE/yyEL18B1Y0Gzn43I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VuvjeoxDLu2nRmvbIV9FIHYW2eTfufhWXZUxokzv/OJmLyi7IQh1KMH5r2t2Jm0GIKsu1OgkNcKX9J0mVPCSC3/IoiT3U8d5m1S4U8J+0ieC1JrVt4DrOraWVHVPMWxwBVj4qAVf2syqFPXQSSVV6umwQqX2yi5xV+w/GEgs3bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V0nmaUBl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726320924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ld0UP3PRmivVuoJrwDe2lnCU/nD5gTvPPRMst7Yu8i8=;
	b=V0nmaUBl/NYz1czGPInBYX2A4kCWeAoj/P5nigDMI2k/5e2OcxWuNFTdATJr8kJBsFHKqy
	Dg05Wpi/uXVZmBwgfEUVAB4wT/OouRroS2DHVytJZEwofDailsYKLeZTFy+rD+7u1fhxmO
	Nnizvz4/ZSmVvzyWHL9zldmzMWcdZx4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-7LoKHQ8dNC-lDfxhtsh_ow-1; Sat, 14 Sep 2024 09:35:23 -0400
X-MC-Unique: 7LoKHQ8dNC-lDfxhtsh_ow-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb5b01c20so12555465e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 06:35:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726320921; x=1726925721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ld0UP3PRmivVuoJrwDe2lnCU/nD5gTvPPRMst7Yu8i8=;
        b=CWzzYuRnIY8Xv3B4swLBruqDhqAPxoTQmifCz7kQk5mBgt7KUDcRjlMxJVTDzvOAnd
         DPK3guiqRdKh5/0m4fSNtYx6+H9gUFfeHhgdqB/x3BzWPQJAs2bye7Eynu79voOI8fCV
         SUVZCbcMmyMSH3t3k74amCWnPmj/2R+ebuJAZuOaGJZepSTizMOr9E+KCN3v6yii4l67
         P/LPz7lKmTLdSMapQBO7ll+3GQac8EAxxN6gm0aPPkEcxX/VTx0XqkWJ2C0eSJtqJWWZ
         YwchCjiNJG9HK2kwRT1WBULXDfjUF6F0x629tLnfQhwCoHNn1k1XeLFjYF8YSAdnPIe5
         OATQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq8j/l1opm9n3c3RVd1qcHev1FrqWnqJb7yvV/stxThR6tF9EJLCApFhLuOIA+ZSUHX1Ndua81GdJfFUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbJa819m+XDuEj4UbotVeu8z26GhhKlh408NWTdmtB008/fO4Y
	UyUj0px/gbAEqNj4KXkm07dtoQYeRR9DMS3CGAjMp43Es2DoIy+WxJsYzKTySEWdhA4odNCioGU
	GIDNKJC9srfnizVnfPjgd9Af2qDRoun6yh6rXlMnw+zwUb5Uh6DOECgjYhDpFRR7RaT1H/XtZt7
	dDbQaxqT24VGvQNdsJw3Ny9CpHFSUxWpu5JNmrLTWJhu9/YDs=
X-Received: by 2002:a05:600c:1d05:b0:42c:c08e:c315 with SMTP id 5b1f17b1804b1-42d90827159mr52190445e9.16.1726320921117;
        Sat, 14 Sep 2024 06:35:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZa1HkPyf/nXwY2gWJhrKbQjj1W29fkvwKM7sq40Mkj6VbUZM6phKBtQENBljHgDCxGxGqupkWYE2snthe8oA=
X-Received: by 2002:a05:600c:1d05:b0:42c:c08e:c315 with SMTP id
 5b1f17b1804b1-42d90827159mr52190275e9.16.1726320920644; Sat, 14 Sep 2024
 06:35:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240914011348.2558415-1-seanjc@google.com> <20240914011348.2558415-2-seanjc@google.com>
In-Reply-To: <20240914011348.2558415-2-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 14 Sep 2024 15:35:09 +0200
Message-ID: <CABgObfZh0PX5CMa-Jbny82GvSS9oV6uPxYugoi0n7Vrv=yj5Rg@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: Common changes for 6.12
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 14, 2024 at 3:14=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Fix a long-standing goof in the coalesced IO code, and a lurking bug in
> kvm_clear_guest().
>
> The following changes since commit 47ac09b91befbb6a235ab620c32af719f82083=
99:
>
>   Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-generic-6.12
>
> for you to fetch changes up to 025dde582bbf31e7618f9283594ef5e2408e384b:
>
>   KVM: Harden guest memory APIs against out-of-bounds accesses (2024-09-0=
9 20:15:34 -0700)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> KVK generic changes for 6.12:
>
>  - Fix a bug that results in KVM prematurely exiting to userspace for coa=
lesced
>    MMIO/PIO in many cases, clean up the related code, and add a testcase.
>
>  - Fix a bug in kvm_clear_guest() where it would trigger a buffer overflo=
w _if_
>    the gpa+len crosses a page boundary, which thankfully is guaranteed to=
 not
>    happen in the current code base.  Add WARNs in more helpers that read/=
write
>    guest memory to detect similar bugs.
>
> ----------------------------------------------------------------
> Ilias Stamatis (1):
>       KVM: Fix coalesced_mmio_has_room() to avoid premature userspace exi=
t
>
> Sean Christopherson (4):
>       KVM: selftests: Add a test for coalesced MMIO (and PIO on x86)
>       KVM: Clean up coalesced MMIO ring full check
>       KVM: Write the per-page "segment" when clearing (part of) a guest p=
age
>       KVM: Harden guest memory APIs against out-of-bounds accesses
>
>  tools/testing/selftests/kvm/Makefile            |   3 +
>  tools/testing/selftests/kvm/coalesced_io_test.c | 236 ++++++++++++++++++=
++++++
>  tools/testing/selftests/kvm/include/kvm_util.h  |  26 +++
>  virt/kvm/coalesced_mmio.c                       |  31 +---
>  virt/kvm/kvm_main.c                             |  11 +-
>  5 files changed, 283 insertions(+), 24 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/coalesced_io_test.c
>


