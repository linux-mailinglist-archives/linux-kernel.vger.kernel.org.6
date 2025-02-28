Return-Path: <linux-kernel+bounces-539629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F154BA4A6B0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 00:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA67189C9F1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50BB1E105E;
	Fri, 28 Feb 2025 23:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ivm9Ihjw"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D041DF74E
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 23:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740786084; cv=none; b=WP17Ks3SeuBRg4Ql/KZ/gZvg+NZodn9A+EyQ5IlUjJAlS27xQqNC4yziv8s6mG/V8PoB2vwJsEvTOzUzBbOivQWquHP5yUNwroCMfaX0qjm2Mx/WTSEmFeAqMU1fZKwpswWIkfJDwlzQaQp0zSFnxgD/Qc9iTLZ439YJPeYcri4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740786084; c=relaxed/simple;
	bh=QENiV6uJu3bB8hqG+D80jQNvN6gBBlGloxAvMhM4jks=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XAoPmD5OmM9m3FvhlUjvq1McL/3oLM5VnVGJ4pC91MOIg3/+D0BIdQjcAurMiS8O6xfbh+ZnSLhiXTyIdEZMuXerSBz7MQKTvMNbT1alsC1UN7sJxmLhcPZk2/2faOQxlwFettJmZQolQ0wz2+C5L/FMIvbc1KcizMWU2zxC6jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ivm9Ihjw; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fec1f46678so3590448a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740786082; x=1741390882; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AwvW0pYFe7VhV+MrYDyqY+sCQ8qL3/J9vUbBaNF7s4A=;
        b=ivm9IhjwhDlaLcvGeJq0IJvs4DUumwvdLRHVOgF2uUXp2YFFj0QkuHCuta9g3CfkwP
         HdTpEgd5bVCJfXJK3tshK2wvUbNeWKjLHAkNv2lIDIp7m6O/R0BwQbf2YhUQBWQpy/Kb
         RBW6V+mZsoWsnPK3WabrawEomCWlaeGjSn6YwCA6F6aXCiKEwY+tw6r9lTE7Xp6Mv5us
         ipbOTlGYr+yR5+B9EF4hN/A0KJ2+qTzSwWhD8tx2oxqWPO/Dmjh69edJHlPcMhiwfQFz
         xsbLPu4OnNVLSJ8V/V9EPb+fyOL4rNPJ0nLhG+Syzg7PMQGk6+5YG0WrVLEUSfqTsOUE
         vQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740786082; x=1741390882;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AwvW0pYFe7VhV+MrYDyqY+sCQ8qL3/J9vUbBaNF7s4A=;
        b=QLTBTWor2/cL5tYuFixK8Qx/2cCWlcgs2BP4I89d7RvZvt1dhgOuVxb+zvAuGp0h6r
         zE+Q1L1eF6FCOUZ+RvcxBeVNg42+Yqhe7Urtpmj4HwymOLlHIq04PWuwN46sjzkAfSty
         eT5Zno6fdc5AK84IXXR2nQygdp/rikJOSvRUDNRWSLIQ3Wj6PiBZeD9oOVgEjz3qdbrE
         FeSpHaZwjKu/tkU5FKSvK+1nnSgY9QV/F7k512IBnAUHj8B37WR8NfB5vVLTPWKZrETG
         Gc5oB+BmJHrX+4ywZcjtxDjqi9jbyD17fSGxHmxfZOfTUlg0lQcb8DOrOWSWESa2a5eI
         3djw==
X-Forwarded-Encrypted: i=1; AJvYcCVP+ExMWeEpVvSYQXSUAoBXbJKTQjCBoarInQx97nOnW/RcMS5+jGOMEYLz9iKYorCJC78eLVbsUmKhMtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxZ5Mk1shQpMT5mPhRdO8Glhj+b1wiy1AicC3AdCOKuh1nIrho
	CKYwe+xtwGzPmcnXOCsbiYbLpd1kwLAMRaiWv0NoDA8Ri5mmPuTxgdngRvs1MJEUKjgMimBxOYh
	b5A==
X-Google-Smtp-Source: AGHT+IGeEvuYcudRjehe/5NlNRZtexUVlBrm2eArt4lglUI3UvicdV6S0d0UrxLJPGNGhfkh6MWcmALP0kA=
X-Received: from pjbsu3.prod.google.com ([2002:a17:90b:5343:b0:2fa:284f:adb2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:37cb:b0:2ee:dcf6:1c8f
 with SMTP id 98e67ed59e1d1-2febab75c98mr9732628a91.16.1740786082172; Fri, 28
 Feb 2025 15:41:22 -0800 (PST)
Date: Fri, 28 Feb 2025 15:40:36 -0800
In-Reply-To: <20250227000705.3199706-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227000705.3199706-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <174076284903.3736676.15512557789337547717.b4-ty@google.com>
Subject: Re: [PATCH v2 0/2] KVM: VMX: Clean up EPT_VIOLATIONS_xxx #defines
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nikolay Borisov <nik.borisov@suse.com>, Jon Kohler <jon@nutanix.com>
Content-Type: text/plain; charset="utf-8"

On Wed, 26 Feb 2025 16:07:03 -0800, Sean Christopherson wrote:
> Nikolay's patch[v1] to drop the ACC_*_BIT defines, plus another patch to
> add proper defines for the protection bits instead of piggybacking the
> RWX EPT entry defines.
> 
> v1: https://lore.kernel.org/all/20250226074151.312588-1-nik.borisov@suse.com
> 
> Nikolay Borisov (1):
>   KVM: VMX: Remove EPT_VIOLATIONS_ACC_*_BIT defines
> 
> [...]

Applied to kvm-x86 vmx, thanks!

[1/2] KVM: VMX: Remove EPT_VIOLATIONS_ACC_*_BIT defines
      https://github.com/kvm-x86/linux/commit/fa6c8fc2d267
[2/2] KVM: nVMX: Decouple EPT RWX bits from EPT Violation protection bits
      https://github.com/kvm-x86/linux/commit/61146f67e4cb

--
https://github.com/kvm-x86/linux/tree/next

