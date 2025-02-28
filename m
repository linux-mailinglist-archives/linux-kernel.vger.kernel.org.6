Return-Path: <linux-kernel+bounces-539626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B8DA4A6AB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 00:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91305189C3C6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E432E1DF271;
	Fri, 28 Feb 2025 23:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qot7tse1"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA621DFE13
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 23:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740786065; cv=none; b=MvT6YA5MAipupiByB6IQu2fyTtEq5Kl/k8Wl9OgFS2CIkAuofvPQo+3V5wmv//mLDODzkcBLFDaPV0nCJ1e1Y51rl6nK2T2dVklmmThwDd5ATReXiuj2j+x/8d1e+C6bxUma451RkDZvDXlxYYfN/d+CJ3ja3iH3nibb6/gYKVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740786065; c=relaxed/simple;
	bh=czHtOKFbuWT4IFwIXGB3dzoMikaoJb8csCThNc+R2Tk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WtGvd9Z6JqeOAE7lH4hfscHM9lwN6Pl7m6yfndl83N2ut9yviZ3DTTO0YiEuoL4NuqH4zcQxyqmiJ5ToJrSuw7p3RAjBPv03FF05/NTFgKyW1tf2moDiN+qE2nFJSTf8SgZgrC3s440YSHgnRnPvOkTgOwvG3qchJxJXVjUzVb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qot7tse1; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fed5debb85so425362a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740786062; x=1741390862; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Rd2zkA90OfrPC56kZ5TgBkpFyoSsKiSMEhRKLUnwKE=;
        b=Qot7tse1Mzw2ETR/1mp9X6jcUp3fC+TzmauBU+FMS/A0f65iDRuWYD1LCpZ1K9oVDR
         GrMlgrZlt7755lqwkJHquj/f59KFVmaYV7JDFxWSfk2CUBEUvVPfYMnLldrs/wKCWFZP
         /1zaWQkSapYbGWlPOXGjPwyNhS3m8RLgLjNaDWKJgVT1LNiLVbJSv4GJfMmLnwMj8mwp
         DUQyQtouu9TRfoVvXxd1Fsckj6BM1ZkV/Fid5MX0c5tXcqllCFAKy5T2UJYZILKNQIp0
         XQD8SZMM8I1Ovzqdz0TOhOXo7Ki5kH5JD4CNYOsNCBUtleB9W/AZcHyYEig+onmi191p
         a85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740786062; x=1741390862;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Rd2zkA90OfrPC56kZ5TgBkpFyoSsKiSMEhRKLUnwKE=;
        b=AMhbbGKlpACWTXXscpr59LN0kGJI9S3j+hsS0ars9dgEyfexVqSwcSkv54ff5uSNfr
         sxCFyCXavY6ITYWQiC2on4Q0VWAd1NHzq3JuZhRWBhhaIGLZMIM+S1yIGH21KLIN9IzR
         WjzQ7p+OWTxxQbv+pgkav2CbIfC9zAMtOnTBYvYkt4XJ1YIGk5nfniC15l7duBcVQFRk
         lJ9gLLLWG82BXN3+zpt10fwYC1ds8CxinCqlqAojAK3AhGuX9oACBaHnygkNGI3EZ8T7
         04NbvjHlvA2cuFcXZRfPczIP7C3eRq2EU8qv2VsZLsVWuPO29+0WZJmU3NYMnrxC7fHn
         7EOA==
X-Forwarded-Encrypted: i=1; AJvYcCVa73Rxg/yN9kTePM4zX40gHsysAkqVYOVKAyoDtwQkr82WrTu+OaxxqlTmpOOIfTrYjNXViLZkiQWeW/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5mmiYbwloX11e0QchBqNCL0Ho6OuLnpU1WO2GtOxLB2QocD66
	wzaxHA5s5zhVV/OJ0fQz+BtJpJqsic7gGUwRXccGJ9i9UsNiVky5ziapefYVNxpebBhY89h0Dnl
	8qg==
X-Google-Smtp-Source: AGHT+IG7CvYyko2UbVPuAkNZZPDFMXpjB4wXlD6Ru8cf7no7JS4XUdhwodgR3HqRriolKmpqFez0BPUdclk=
X-Received: from pjblb1.prod.google.com ([2002:a17:90b:4a41:b0:2fc:1158:9fe5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4acb:b0:2ee:a583:e616
 with SMTP id 98e67ed59e1d1-2febab3e417mr8593663a91.9.1740786062022; Fri, 28
 Feb 2025 15:41:02 -0800 (PST)
Date: Fri, 28 Feb 2025 15:40:30 -0800
In-Reply-To: <20250227220819.656780-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227220819.656780-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <174076278043.3736049.13548260851648046331.b4-ty@google.com>
Subject: Re: [PATCH]][next] KVM: selftests: Fix spelling mistake
 "UFFDIO_CONINUE" -> "UFFDIO_CONTINUE"
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, 27 Feb 2025 22:08:19 +0000, Colin Ian King wrote:
> There is a spelling mistake in a PER_PAGE_DEBUG debug message. Fix it.

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: Fix spelling mistake "UFFDIO_CONINUE" -> "UFFDIO_CONTINUE"
      https://github.com/kvm-x86/linux/commit/75418e222e30

--
https://github.com/kvm-x86/linux/tree/next

