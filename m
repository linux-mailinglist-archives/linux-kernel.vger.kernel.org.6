Return-Path: <linux-kernel+bounces-201545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD87B8FBFD2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582E21F23E03
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA6414D713;
	Tue,  4 Jun 2024 23:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FAHOwFPB"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D085814D43E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 23:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717543785; cv=none; b=eGu0s8DQAp9YX4cxlTmsm9LDKYDxUz0SGmXzT/EpqbMEQxIFZ9YN/QqhhmB1iI2cJKRjvO2e42C6Wj49iADZBEwARiYFLfgxrZe0bAiOiv+mllGEFg+lr1+Z7ADdDx7bGE2H24+b/Ak5dpl5Ff4T2xVT79dGGgXInJOuYLrkqKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717543785; c=relaxed/simple;
	bh=NTOSuMKNlZjh5qgetQbTZmcQQXwN7LKuEZ9U+ZAncjc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M3zabt0Kh4awONyb/DHB+N11w1jiSQo0r+RTjX5elwPmtqmgHVElXE7BoHNDc5Sr8mLuj1A2yHbLJw3iR4YNbxa/sbjZDkWqodrVDVywt43uc+N8y21i25EBvsEYTf5uut/GWmgZzptY8G0i1vrAqM7MIdhhYCmS+TEW/8FIbvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FAHOwFPB; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2c1e6a08555so314390a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 16:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717543783; x=1718148583; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+x51aoZ4NK0amIZazvXbm1aes7UfC8U/R8eR/ud4gNI=;
        b=FAHOwFPBpFt4TnuPBq4x4DChftVHBms+jadKmPC/+JjLOBKc+YJ/WDB9renFGVBPtP
         HlOvJ3AQJ6OSLe0PsyPbBkzSeM6YC6QRD6QJ8pVRhw3/bTYgPFoSZPw+VDBGExIWSbk7
         dmpjYgD7aJ560Em5MhmYcnuEcbGMBGEXmGYF3oYsLi8szgSgyJ2eiVIHk4f1SL0d9eIs
         bB3Hy9gr/PII+4W6a2sW/6IV2N4SNkTOdI+9j+Ao4kev7d5t+B1dgROw97CjEik69iRd
         BjrpRUcQlBv1mG4k5FutNbJcEIfI24IrOLCXYYtyC0bbgvw5ZLEk/IjG7v32xY/UF19o
         vCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717543783; x=1718148583;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+x51aoZ4NK0amIZazvXbm1aes7UfC8U/R8eR/ud4gNI=;
        b=DWsoMA4fd5lAKlO0tEOhDzltkgxW9epBwlNZKTOaleCMoAzaqmylYAUpvpDI93tDdG
         LyB1WAjoDj19TiUXiB8b/mk9qgJ+EIP6tasDE9MXJNIdd6FZKW7WsVKZ1etCxYpm6eD9
         6SdVSXRSv4W+8P3xQDoAZeDmGSJwASixyM2uQDq1a/1RWWaMllsRnPctsbSaEKXwBE2Q
         GyumIqqQIy0AHykDUSxnCZk/Q0FYKLaHd7uodirSAm5zxIGuDIsqeu0WLeHwAPJ79sOE
         vy2hajudfvtOobrdQSmVYcuMNUbh+y9MK3bU0i20rdTndHTpp+aBJg39bAPOish7rxEz
         oDUA==
X-Forwarded-Encrypted: i=1; AJvYcCURonmsgMBgXHo2xej3iQ6FAMTLf5pFty2NKvZZ9tYiK3TVri8Mk+b9biQBFYbKVROgh3BSkAsZm218XBQSwW5SAe70dkSEFLaHdiiW
X-Gm-Message-State: AOJu0YzhGhdb0MtAETw4Uo3M0QXE1XG1/6sUXScTUfu1r8WQRuqv58H6
	gdmh+jN6QU5YNkn4S36KYShxJl+7Up7Catu8k8EoU9G9E9ywKYFgzUNTbiYb1rlRDinR62N/Q0W
	kmQ==
X-Google-Smtp-Source: AGHT+IExrVGyDj4SjTJZG5rOMmcDDREj9vNkffe0To8EYFE5NS2MHwZ2u6aszqpJQHooWRE6WzCHGDpCCg0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:2309:b0:2b4:32df:9b7b with SMTP id
 98e67ed59e1d1-2c25300652fmr48774a91.1.1717543782991; Tue, 04 Jun 2024
 16:29:42 -0700 (PDT)
Date: Tue,  4 Jun 2024 16:29:17 -0700
In-Reply-To: <20240523154102.2236133-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240523154102.2236133-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <171754270332.2777568.8736329166014206290.b4-ty@google.com>
Subject: Re: [PATCH][next][V2] selftests: kvm: fix shift of 32 bit unsigned
 int more than 32 bits
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, 23 May 2024 16:41:02 +0100, Colin Ian King wrote:
> Currrentl a 32 bit 1u value is being shifted more than 32 bits causing
> overflow and incorrect checking of bits 32-63. Fix this by using the
> BIT_ULL macro for shifting bits.
> 
> Detected by cppcheck:
> sev_init2_tests.c:108:34: error: Shifting 32-bit value by 63 bits is
> undefined behaviour [shiftTooManyBits]
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/1] selftests: kvm: fix shift of 32 bit unsigned int more than 32 bits
      https://github.com/kvm-x86/linux/commit/9a68cefe9f05

--
https://github.com/kvm-x86/linux/tree/next

