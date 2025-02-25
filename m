Return-Path: <linux-kernel+bounces-532656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B846A4505C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B2E67A5216
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209D122156D;
	Tue, 25 Feb 2025 22:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jKfdjdnf"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CA822155E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740523173; cv=none; b=mKTDdLrkW5FTIf7lnSZNO1KfNBsQZycQCyok6kvfD+St1ahdW3pInF40q8ASbSNU5ifCHGYeYCERAOUYiEoLwxJoKRmNGYtf379vghi2UqsM0h+AOfa37jCnVMJxh6nZSqKuduCmd0QLwIV3o/1painIzmC5KSfTbSXwoNja4AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740523173; c=relaxed/simple;
	bh=p7oGnaWvWXTBzXokZuyHvv8SGeM17iNUeK8uO978Owk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pNk0pEC6vtAWEWNxdbG9dnVLd8Czjio4RWEapM+gv6+t+Vvodn9i8rjEo1xoRfYDO6Onp5TpN5OzuqzrDEVxB3RymHfVFQw6fxCHXno0zX0fRwxwlaiAhIm8MAy1ngITW6UaDPLCmBdSxQpVhad1o7xjSGJWXYtHehmghdwO/tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jKfdjdnf; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc5888c192so11871864a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740523171; x=1741127971; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zh7JWOkY6aMHEwem4sxE2JFtaVUakgwBnhbfU9uucGs=;
        b=jKfdjdnfDPBOLGhfPcWoh8w91vDm2PmtaPKmypW17c0P4yw60Qv9j4oJVgoXoQzC2l
         /+xfE5Svh2htSqZ8a+3JghkLjIqPMbjVgwLkyYgcDA4t50JfQg9EoqEaxA5a5e+7l7pR
         BCkvgI9B3qQTmnqeW5cyEkYSj942GLPjpbbeJ0IyscrojOTH7xyU80H6EY73de5rnEix
         KUXXcQAasLCcLp71ZNAi7I1YWs0kd1JPSdax9N+x4LfaU9NvjLZPyBSq/1qREemkZLJZ
         0dYDmTPVQ9Y+DTgI+usTDpT1HY0vKysPIyRkJBqMyMrlbPIlIr8D4a5HssipRr8krgCm
         qCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740523171; x=1741127971;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zh7JWOkY6aMHEwem4sxE2JFtaVUakgwBnhbfU9uucGs=;
        b=qAaacjN8E2FwN+YregIfEDKYujhqhUbgTP8i6oQcJK0ekr9WHqPssqJS4/mmZ7Km0J
         +B1c1+dKpQxSu/MVmdcwId2vTULADZdms1t9tKq4cE5yLroKFWIqwGnMd84kvIQpnbMN
         SSvGCLhTosyrzKw5ay4i2wOlSR9twpkd4fEL+x9497zYeyTH9PDHf+lhrlSpuctrWbQT
         Pd51TAL4x+jb5OkVidASxI1o+PHN379hjyRqgd9w5fBbQxrtcMLgo4sCyPID7PiMsJdd
         zLAWQXiCxDbDdZFUQ+0G9RS3Bub2XXrqi2u0BY6+7lsI1rDKSEJ2U2XXa5NTVM0aMKoQ
         ATOw==
X-Forwarded-Encrypted: i=1; AJvYcCXzmWnoAHNttPL1eF9Wv+lTI140NEgYTCx/0tgtq4fD9yMlxATcngufpQPb+3m+hLn4PMWKUwI64MAUxGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIHXxYnP8la4QpG9kOCYT6mNVISH1dIGbdqeH33BfJoq/5cin4
	9R9F/3eYzgJ1MaheurscF5HbiDvDBs0adsdl6cm6zSNKqEhiuArHl2OMqTJHp0Ml32Pt6AhWeis
	Zig==
X-Google-Smtp-Source: AGHT+IFih1XaydANV5Xgmoe228nGIMEYPUMEHKoNEF0RFGmWeCQNMBJFR8dzqqODQUEd+6xSMEHR2FrDGqs=
X-Received: from pjx14.prod.google.com ([2002:a17:90b:568e:b0:2ea:5084:5297])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2dd1:b0:2ee:b875:6d30
 with SMTP id 98e67ed59e1d1-2fe7e3163b9mr1809896a91.9.1740523171586; Tue, 25
 Feb 2025 14:39:31 -0800 (PST)
Date: Tue, 25 Feb 2025 14:39:30 -0800
In-Reply-To: <20250225213937.2471419-1-huibo.wang@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250225213937.2471419-1-huibo.wang@amd.com>
Message-ID: <Z75GoiqAHb6sLUEh@google.com>
Subject: Re: [PATCH v5 0/2] KVM: SVM: Make VMGEXIT GHCB exit codes more readable
From: Sean Christopherson <seanjc@google.com>
To: Melody Wang <huibo.wang@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Paluri PavanKumar <pavankumar.paluri@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Feb 25, 2025, Melody Wang wrote:
> Melody Wang (2):
>   KVM: SVM: Convert plain error code numbers to defines
>   KVM: SVM: Provide helpers to set the error code
> 
>  arch/x86/include/asm/sev-common.h |  8 +++++++
>  arch/x86/kvm/svm/sev.c            | 39 +++++++++++++++++--------------
>  arch/x86/kvm/svm/svm.c            |  6 +----
>  arch/x86/kvm/svm/svm.h            | 29 +++++++++++++++++++++++
>  4 files changed, 59 insertions(+), 23 deletions(-)

A few nits, but I'll fixup when applying.  No need for a new version.

