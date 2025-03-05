Return-Path: <linux-kernel+bounces-545893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F6FA4F334
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 02:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3669416E8E4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 01:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A881411DE;
	Wed,  5 Mar 2025 01:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QVNNG/3c"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0311E50B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 01:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741136733; cv=none; b=ncL1WxCamHLQyQT5SEuix0i6kEIcebKIWfmNSC9eBOlbDO5MaRUVvBCXZKQLI9oKTP5AlDcoYTEpT2psdoio6GTz6MtKMeaCR9h1jYumkOqG+tGrt3nN4/fZMMNGH837rVrbGUD+PRTEso74yjlsAQT7kqCC+tmId4PX0dSnHjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741136733; c=relaxed/simple;
	bh=3/a1+KpSKzvgpXffEb1nxllhFmO3m/Iu2qEU34XHXbs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JKucxVyqPPYD6BOu/6Bwj55mZav7gticWquYj8R23+0kLBk2d3oZZyCiGlE7riowKueHcTXTOE1tOLiyFsbUEZMDNRfzfAu/wq0a5K/M7vbqrwepbD6KnnN2q8ZtDXRixJ/Jgy4BUYuc8a9uQ3ON7YTnc0CWcJDSmx4WdFG9Zd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QVNNG/3c; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fede63f32dso11092802a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 17:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741136731; x=1741741531; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=etTNE2hEXte3ED5XpfxiY83NHS/DfFcH3KjaI4ucW8M=;
        b=QVNNG/3cDWG9YBHzqdKmA+bwMdicR9VfGorfO62mgvcdRa3TCQ6wDltMQNKBhKGwU8
         o+8K0lOn6/MHOnIRDOotdlfmraso44Vo68VBlVvfUYpfzTXmnnRP4etD813iQRyeUz3O
         xuhtOuTgpK+oaPoa91GMYFBz3qfjiOpoEudLdjYcpQ+i4JKehXXFwfEvx2E/naQRemKu
         KExlizFrUH5I8HXhbXB5ODTnB46m+GOFbfr++9vWgG62ZIXAsmENijKljlJE7wbSMwAD
         i7nls5Tx+j7bQ0fLtPqyO8hERBgFzzSG634dct4zdR2yNTTppO70ijJTLyvwKOqOOSCh
         Y7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741136731; x=1741741531;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=etTNE2hEXte3ED5XpfxiY83NHS/DfFcH3KjaI4ucW8M=;
        b=sMyH7+eqjmaVXQMYzmsgKE3iu6AEiWolLPKcMnSRTJxOFRDDwmYRQanqQNgG0cxerE
         W2z5Qg/LKo3UOQ/yhS+bcqk12UYp9MG8eMO/uFwQsoD7+NVPHAySTsMbPG5QC63L8Lyd
         TVdQIbRHTjKBjH7HohFqjUrypmKyoQ7JtqkT1dJCAbS60taHe6pk4s4fB/6gclowy1Cg
         Ij/3YscdfehekJFZ96K2BDR/9DLPsXmln/ql33njh4TiBy/H5Xr6TCpjG9y0DsdSkjZG
         jUpX206lPX9kTCxluddiyea0vJOXoEYoAlcZ112nbciw8Wer6R3CvGRGZ3WWhvEvLcLO
         /8yg==
X-Forwarded-Encrypted: i=1; AJvYcCVOBhZeaskn2soFUrsG9zJaVtv7HfQHOo8ZlhUKf41FQZzdu9IZnsHoSwmN7Bg1T/HmrOUJPiWon+Df5lI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpMf7wvx4/hFxnWN4ZbmKBcf85MqPYeC4xcgcQ9SqxoAz1Sl1b
	z4xQCWSft547jNp2QyAqy47UwWVLoOXZ5k7TV3UCZBzNi1pxL//pBiTbbLHqV1mH41DAmL8MHdl
	1FQ==
X-Google-Smtp-Source: AGHT+IFJu4hpYZ/WKyLJ7i2g3oDo/8fXGMeyX68X10asVWrc31mGPCiKp9L73rvY02oMYUtGqw/gUDwVKNI=
X-Received: from pjbpl6.prod.google.com ([2002:a17:90b:2686:b0:2e9:38ea:ca0f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:35c7:b0:2fa:b84:b31f
 with SMTP id 98e67ed59e1d1-2ff49814642mr2172122a91.25.1741136731375; Tue, 04
 Mar 2025 17:05:31 -0800 (PST)
Date: Tue,  4 Mar 2025 17:05:10 -0800
In-Reply-To: <20250228233852.3855676-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228233852.3855676-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <174101674141.3908971.11827388921425650465.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: Fix printf() format goof in SEV smoke test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 28 Feb 2025 15:38:52 -0800, Sean Christopherson wrote:
> Print out the index of mismatching XSAVE bytes using unsigned decimal
> format.  Some versions of clang complain about trying to print an integer
> as an unsigned char.
> 
>   x86/sev_smoke_test.c:55:51: error: format specifies type 'unsigned char'
>                                      but the argument has type 'int' [-Werror,-Wformat]
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: selftests: Fix printf() format goof in SEV smoke test
      https://github.com/kvm-x86/linux/commit/3b2d3db36801

--
https://github.com/kvm-x86/linux/tree/next

