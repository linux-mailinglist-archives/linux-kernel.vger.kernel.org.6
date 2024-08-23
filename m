Return-Path: <linux-kernel+bounces-299782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7BF95DA0A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 01:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFA1B1C21910
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 23:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51E31CE6F9;
	Fri, 23 Aug 2024 23:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GGP5nXbj"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80B81C9EC5
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 23:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724457511; cv=none; b=nsn5hWNvOumn3mByNkS4aO6Vm2iAMeFcq2yOV0E073SVgj+7Ap7djLVC7F7EMhrf2B74IESx9ct6cH4WKIWkBLbzPQRx13AWb/iDBO79PekZXrFAAlrbysnR2IWBAWenPwzilWtRshXKZAXcmmIgXjWMH+YK0L9HqK6KIi38OhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724457511; c=relaxed/simple;
	bh=v47cMim12xGCbtay23cP5VLRErgymcIhgqx1BYA+4BY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=my1wL07d2J6JywWhMgZEp+kR3YLKXrBqgJWOR2m8JATKWdghWCscYMtdN/qFkup64zmRoRE4ijL1+e3ncvs8CwSetad/lz0mijk1UYGbP7epiaXAq98X2wO+N+0nQZuP55zzSDJVgg0+kk4FIbdMOVrvQ3dwNFTQdmuiwXU5S8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GGP5nXbj; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2021ab2b5e6so23672435ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724457509; x=1725062309; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7GWlCMO6AkbDftXU/EsUVboI3/s3WOg/Va9k2DUqgk8=;
        b=GGP5nXbjMwY7tZRNTfhNYFeK0xj9DDVhTKF7GmDQ4aO1jSTszVAK2wmD1+PKjAU8VO
         +p7Ol+fp2TQMljnoanK6d4Hs9uN/SMhstbL4lDMhUdHD8g6gi5eTbz/DqwFxNOlOwP/C
         h6LOrMuJhhpUmQYIevB25nUbS99eU27vgxtpVjJ3+7HpuDCbPhSuOXvjqlPX0EDlFQ2v
         YJLleVDtSxYYrkrMxSTj+JGOqENj2pqzYqmuqcZKu5j/FcuOm8zL+Pj396PZW7FO27x2
         zUFL44AEVALKcwhtHO2mbuM3ZqKtXKMDIjHtFcbf1dx7TeBJwZWkeNJOD9tBM9O+11qr
         KGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724457509; x=1725062309;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7GWlCMO6AkbDftXU/EsUVboI3/s3WOg/Va9k2DUqgk8=;
        b=g8sfraz5NiE/IHyGPKe6n0SEa7OsMa7xC1IdeAlSe5deRyAtSp+he0g7m70X9fLZTX
         cLVlXoSOvvJvg8JWZ80Kx7NhjV5Ut9j49SK0fU+IJoDR5sL3uRt/mxdukfGtTrZKZbO9
         6yj0IQtBeZvnHIPV5GZRsOBfjIvifiWakqI1K3cl6GkwdrvulviIRUnUSv9TJM7B8K3P
         PFDpJl8jEYV5jvN6WjbJFk0Ats40a9/HlA/iPJJa92GYPd/mpXvDl334QSA4UAgF2y17
         x8RJ32KGXDnkFtaGEXE3phK8uUCsv4O0sApqzISE4RzNcp6nuc+hOI8W8lNR69UN6gIU
         VRyA==
X-Forwarded-Encrypted: i=1; AJvYcCUzQtgCOhQm2+UL/5vrPhRsR/roe0zhM7sH3Yb5bAyMrfQKfXU4afsR9ed2E2eKtqsGWwO0OuqyoZV8Lr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YycEG35JpQolRt74thVL62pPW6QL+kwB5pfrA40M3yvCRKnwMk2
	hlqYDKGpo+73F98wmSkHX9vpnksG/Rrhqg46g/4AKN7usJQiXHwdkKsQJlCd25WP7rWedfPe5KY
	U2w==
X-Google-Smtp-Source: AGHT+IHAagkZYqZDNBZEX1vxs4jXWVFnw2+pknrbLouNz+RFfE5IplGlJrPoMmRIgO2vBGynEBYqnlmWUK8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ea04:b0:202:232b:2dc6 with SMTP id
 d9443c01a7336-2039e49d2dcmr81495ad.5.1724457508972; Fri, 23 Aug 2024 16:58:28
 -0700 (PDT)
Date: Fri, 23 Aug 2024 16:48:05 -0700
In-Reply-To: <20240725175232.337266-1-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240725175232.337266-1-mlevitsk@redhat.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <172443880691.4128502.17704045067981306299.b4-ty@google.com>
Subject: Re: [PATCH v3 0/2] Fix for a very old KVM bug in the segment cache
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, 25 Jul 2024 13:52:30 -0400, Maxim Levitsky wrote:
> Recently, while trying to understand why the pmu_counters_test
> selftest sometimes fails when run nested I stumbled
> upon a very interesting and old bug:
> 
> It turns out that KVM caches guest segment state,
> but this cache doesn't have any protection against concurrent use.
> 
> [...]

Applied patch 1 to kvm-x86 vmx, thanks!

[1/2] KVM: nVMX: use vmx_segment_cache_clear
      https://github.com/kvm-x86/linux/commit/41ab0d59faa9

--
https://github.com/kvm-x86/linux/tree/next

