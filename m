Return-Path: <linux-kernel+bounces-395943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E789BC527
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 07:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916371F21CFA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B591D5CD4;
	Tue,  5 Nov 2024 05:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PnIUvlqf"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E231B6D04
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 05:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786223; cv=none; b=OusNVMKP4r9xAcgRV1/fd0zKPDrU3P57R2kFLWBt0uTLflh8ZqVFbGiP1pqD0t48vikNkW8Yd0CGX5JWICebPrYqhanBOis+bH8IMFtOde6QQ22/SX1m3Iu8DfP5jSj7SnXCOUd+64YzV9zofzW2g4clVZ7jVm9fD+zEu/cx5X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786223; c=relaxed/simple;
	bh=KGs871fzX1EXE2qkazuNkjeNwAp4J3sb4bqjcPOPIj0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oUi0kNtwxexr+qnReS1lCDCUHpa36Q1ZaKX1PzhZ1iil0QlMnYulu/xdHKsQy+lh74/G3MpNdL0O0k60lsIZ4hcII3hSsOsJe1y5Y3qTXVcHD55I9xB/1zYc9SuIPW/u6YEkhABUdhgpJfJK/YbmCE3qCR5pkFzSgJ5xYGPmYFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PnIUvlqf; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e32ff6f578eso5984794276.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 21:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730786221; x=1731391021; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tnJjG3ugyGSlqpe2tsDrKIvf+wNpMgv9bSmhDQwEX38=;
        b=PnIUvlqfqDMR8Io24xJrq3ZF1h1KAV3H0wNkAldzLQ+lW+RIckj8UJUk/hoFEC2kmh
         OdOqKf5j1WVn+6Ub79VNmwbs6Ks7Y5cXGue5Hy4mnuUSiy6IQK4kDU11qWNhXuYrtNuC
         c1fIo96s+Fag0G449zkquMsQ57FSn54miOpkW/YY0N39fs0/q/zkPgysDM+opzUgRT9u
         yFpRoIIjAY36ux1qqQlbOj5xM/jAeu76cOltGnx3ROyK9lBpsyNzkK4N4dngPVhdjtyp
         QMmRvy8XFTTj5JBGQK8HrIhQ4l6xhLNkWTE9RMm6Wx86wpFp8JdrcK6o5CvOBhLYwhwx
         BDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730786221; x=1731391021;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tnJjG3ugyGSlqpe2tsDrKIvf+wNpMgv9bSmhDQwEX38=;
        b=Cd/RtXPPz3qZ2mMihTh0+KGUeTbj5okdBrLD6eL61b/lneI5xdW0PAtmSnzfJNHr+4
         RVWino7gtPQ1z7cvkYxUhZM/oYZ6azJEB8SaUdXii2rY1iIA9n4OpL5O5iaIg7PBAUgP
         ExDd9fpb6I9gyPsATSNFGwG05iD1OHJ9zMB+qiPCehddudnpBam3V0w8YoQDqPJFNHuf
         Nq1Tmc6E51dqvNNkJDEONtQzh51DE6EE0Z6rbGB6xwAZMvb0SqY/AhFo1f4NIQjzC5MD
         JFDKwVRP3uu74hP0yi0n8ZCb7jnUZ3+mwMNm+91jGiCLfYjODxkQsK8HSQg6dvP4t96Q
         N6/w==
X-Forwarded-Encrypted: i=1; AJvYcCVARrXreEZ3Yyw+9jRsHxeNLEgTD2HSJ121sQe4R2tPAMT6IekXjwJ2ARu6g/uEmDGwuIoKgXrMKmJqqqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl576dV3cV2IMgBt6hHsNGnFFDqZKXKyASHBjZhrhDofE9czBQ
	Zxn1ymkoYpwP5qIjACjzbyxDzwYvqO+ZA+qu21phbgWVPcW1HqmJAHfIl8iaH8TFL0biHu19Cdz
	m3A==
X-Google-Smtp-Source: AGHT+IEf24ljD4sPhcD5TaDheSmL0780TLkVcJeewWVsyqKd7BentSSs76PQjbmT0ISyhOQ3O7kTONMrp6w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1801:b0:e30:b89f:e3d with SMTP id
 3f1490d57ef6-e3328a15f4emr25622276.1.1730786220286; Mon, 04 Nov 2024 21:57:00
 -0800 (PST)
Date: Mon,  4 Nov 2024 21:56:00 -0800
In-Reply-To: <20241031202011.1580522-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241031202011.1580522-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <173078282454.2039346.17723469953189171218.b4-ty@google.com>
Subject: Re: [PATCH] KVM: nVMX: Treat vpid01 as current if L2 is active, but
 with VPID disabled
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Like Xu <like.xu.linux@gmail.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 31 Oct 2024 13:20:11 -0700, Sean Christopherson wrote:
> When getting the current VPID, e.g. to emulate a guest TLB flush, return
> vpid01 if L2 is running but with VPID disabled, i.e. if VPID is disabled
> in vmcs12.  Architecturally, if VPID is disabled, then the guest and host
> effectively share VPID=0.  KVM emulates this behavior by using vpid01 when
> running an L2 with VPID disabled (see prepare_vmcs02_early_rare()), and so
> KVM must also treat vpid01 as the current VPID while L2 is active.
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: nVMX: Treat vpid01 as current if L2 is active, but with VPID disabled
      https://github.com/kvm-x86/linux/commit/2657b82a78f1

--
https://github.com/kvm-x86/linux/tree/next

