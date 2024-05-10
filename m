Return-Path: <linux-kernel+bounces-176306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4194B8C2DB3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 01:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058B4282B3E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 23:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA97178CD2;
	Fri, 10 May 2024 23:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jYK5wXfj"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746BC176FC3
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 23:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715385062; cv=none; b=C0ULri3NN6z2FPMRvVLK+zm7FgL6VYab0hoO2idZy41fG3cBVTeUccxGvmgWP5JBCRYd2KQd+KbMdDM6QsJkUwzSTX3/hCv4YhLA0vINw0fE2FDj8lr2pJUC8skq60+zqbRIh++gK/eq0ZQ4PvSfiaRIyPJZIZQvctyIvc+5z2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715385062; c=relaxed/simple;
	bh=nZEycZxtPiuAGf4oyhutoh+tYkTaBS+4qMYqttTiSIg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VnNeAS+929aDLwwM0ngQlJ4rk07dwO1u0zTuo2KWORi1MNKNVG3K81m2sRlEW8/an4CkiYASbrP52W4Vm/Qgi/i3iW187Cvw/8RgczyWXztkfQ4MQRzRCFTenlPRw/cSYTHNDCdJm1BlaYgGDdT4ZmRxv6uLqHF3sEN3SWUEPWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jYK5wXfj; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62035d9ecc4so45329207b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 16:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715385060; x=1715989860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhXcmv1k83wDK+no5/X9uHny7rFjKrEKCxmTCk9+VLo=;
        b=jYK5wXfjshJMoOJrznIpUeIs3eFxQgy5Yalhzb2Iu7KwMAYYFHyBMoIDJkMt6Ln7++
         pNL7FuO7RTOs7CtDZ5hEca4BPPtcfzLAurmUuXYhHc2ngqRqe4DRv77m5equf998yagq
         A1tIWaUpaM5Sf/7SHTwADZufMu6vIOSjQ/CRAqpF8NNaQqyv/EJe4uk2Ce2MrrVtEyoV
         ZJC0YQP1X71YICH61ohWLOgzQ8HyWgoTW2jq3Gg1c1fb9G1GzYexykQgpQoJKJWKgy1j
         0dWghP9ln6cFbZx62Q7JypSYYjtzsNX35X4OjWey6cxCKW9ZsmbOPkMgL0X6mG5Fjg5H
         WP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715385060; x=1715989860;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rhXcmv1k83wDK+no5/X9uHny7rFjKrEKCxmTCk9+VLo=;
        b=LwXLMUlRfz9vI8VFwihuNXVppzyCIlIxxvkicjdEl2Zz/FuE45+NvwN1tBnxV5cVSC
         YZMkFL7N1tnOmBxy10qHNnelaWs6OZxCm2E4kLTVKkKO6yjEhHtYmTsLCS4TqfrBgW/Z
         4B8XKmiPqaSdWsuoEZ4e8QF33oCCD25fhr3rL6fgef+KOUHXNHIqbyKZGtoX0HHMGBQ+
         pr06QYST3QR32/r/1BYRFkzxKapMGfRiEYH3Nc9ibHEC3j+g2aOKtOhjhYOWpDJibxQn
         ySkJSSPzmqADsmGCadUKbel/LFcKX1G9mhBjpOybLWT108VJFKJDktaw3WJ9+uUUj57P
         0Vmw==
X-Forwarded-Encrypted: i=1; AJvYcCWDpJQSmV58NUVb7Vd7iiqthDbh8Sj3oVt/a5IddmSHcovVtu1A05WqICh03qwyhJEW1wN/PBpotQLCUjE1yaW2IGtXLC7XZGYloI7x
X-Gm-Message-State: AOJu0Yzj9wNrk1cUuTP6IgdGfK4LWCm3t2JaKzQKO9JkR9sB4F8qDp3c
	hpTFH25DXzn1pa6orJpZ3YbC+qpI1MXT7EWJtpVjIwkIOliqrljv5SH3vXHhYqD31UwoZGy0Uii
	O5w==
X-Google-Smtp-Source: AGHT+IEB5DdN7OcsbBnLBO0w7krT5Fe7YWRSuCZCXfMKAhOTMKUqsl39LcxB438afJbzYl7osWEkN7/7wH4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:b96:b0:61b:791a:9850 with SMTP id
 00721157ae682-622b0168adfmr10514427b3.9.1715385060579; Fri, 10 May 2024
 16:51:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 10 May 2024 16:50:46 -0700
In-Reply-To: <20240510235055.2811352-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510235055.2811352-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510235055.2811352-2-seanjc@google.com>
Subject: [GIT PULL] KVM: Common changes for 6.10
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Nothing too exciting, a few cleanups and a fix for GUEST_MEMFD docs.

The following changes since commit fec50db7033ea478773b159e0e2efb135270e3b7=
:

  Linux 6.9-rc3 (2024-04-07 13:22:46 -0700)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-generic-6.10

for you to fetch changes up to 2098acaf24455698c149b27f0347eb4ddc6d2058:

  KVM: fix documentation for KVM_CREATE_GUEST_MEMFD (2024-05-03 15:11:23 -0=
700)

----------------------------------------------------------------
KVM cleanups for 6.10:

 - Misc cleanups extracted from the "exit on missing userspace mapping" ser=
ies,
   which has been put on hold in anticipation of a "KVM Userfault" approach=
,
   which should provide a superset of functionality.

 - Remove kvm_make_all_cpus_request_except(), which got added to hack aroun=
d an
   AVIC bug, and then became dead code when a more robust fix came along.

 - Fix a goof in the KVM_CREATE_GUEST_MEMFD documentation.

----------------------------------------------------------------
Anish Moorthy (3):
      KVM: Clarify meaning of hva_to_pfn()'s 'atomic' parameter
      KVM: Add function comments for __kvm_read/write_guest_page()
      KVM: Simplify error handling in __gfn_to_pfn_memslot()

Carlos L=C3=B3pez (1):
      KVM: fix documentation for KVM_CREATE_GUEST_MEMFD

Venkatesh Srinivas (1):
      KVM: Remove kvm_make_all_cpus_request_except()

 Documentation/virt/kvm/api.rst |  2 +-
 include/linux/kvm_host.h       |  2 --
 virt/kvm/kvm_main.c            | 59 +++++++++++++++++---------------------=
----
 3 files changed, 25 insertions(+), 38 deletions(-)

