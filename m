Return-Path: <linux-kernel+bounces-448339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C1F9F3ECB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 01:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8671716DAD8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187A21F92A;
	Tue, 17 Dec 2024 00:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wrP2M+ww"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F396182BD
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 00:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734395376; cv=none; b=Cpy1N3NrgurDwWhoYx4bErS+qDUiDQqu7w+tUwlruCtlrccnKoym3QJ7S3AW0ZDOve5Hk+tP4u2rxcZ2oM3WVylgAP/LF20bvR/HATPvE+vGXw80gbAs/5fSAZLPMAP0mK49u/7pqkCfpgq5OEKt39+LUmxl1wn/HgAzbADCcvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734395376; c=relaxed/simple;
	bh=tKgUb236+UPmH908Ihb+K0eHexiRBeuza+BHm3B48YY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mdwaoXJkkvszv54qqdIiCh2HS9Ydi61eILWg55RBebA+Z4H4viXEGTOMJoyyNbc58u5JriUdqf9O8ruumFXMSN5gcGalNLrtAVum9uicGkTYraMaV8eKCcIz9K4bpqhiwM9gLLY49BfzkTjg+kllGx2Ku11X42iUJ/jrnm3xPrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wrP2M+ww; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7fd48914d9bso3010388a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734395374; x=1735000174; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Db/ZmD8RsS+Ekv1pMP4d94SEiz9JgoOtJsiGIN6ZfPs=;
        b=wrP2M+ww2GXNXy0EeLfKYbum7tW6pdjMeD33J7j0F1Sq78agC+bNg3W5IRqv4WFlOb
         UT4W7rKDb/XxjWhtqgg5a1vbHDAnAihGFL5X2S94LVloN4Qw5zM2vvlFbWXmAxXirRd7
         T7rMay4+bN3gF6XRJXP7DOYF06I9kXIbySi6mZoXrmPkcmaU0vbOxc97hr3bj8JU7eWM
         E6+9+slkHMIi+ck8fI6QRQ61SJDeY1F4yKy8Obm+EJ189plv1cZTMwUdXgaTvC62cIgZ
         KDZW7CDc9KpcCTVHddexPAxgBohvxl2s1wq7Mi55pUAJP3jnAkhYAXFrq2qbDzhBSuJ5
         TKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734395374; x=1735000174;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Db/ZmD8RsS+Ekv1pMP4d94SEiz9JgoOtJsiGIN6ZfPs=;
        b=EaDhFOcn0fWI/TwEI6K9HmaLntA8Eocmk0NmgJ5L1+CN53mTN8sXTLuBDv6jN69Ue5
         WGjMDhYNkqNwT+UQt31kSMVH2V3zkr8toZkprAZuZ4c/eagq1ec212RZeO2exT+d0sYQ
         S2nVgVmhia6IMfxAo46Fk3EN/24Q0qDc2Yk5LN52aZ3tLAulMsey7CAbcQg+glurn0I9
         3AMckgMT/gomY5BPIr8awcF9qbHAVMhBilFxk1DG1q4TyfHC+dn1ea6pmGPKuwp7VZQA
         DtTLgjiVHFfI6KzjaeAj/rZLpda6daRGNzoIpHa0EYIxoX/tKoRfkg1b6zsjORhVtyyZ
         vzuA==
X-Forwarded-Encrypted: i=1; AJvYcCXZrWd3b1BRcb3mrVF96mScZnRTDi5Zm1ECgYETx2v58cDEzg8r+nCroc9N6x8BGOd6m4RKKOsfHPbKFrg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/upceqCUHSTXee9WjzbMSt63PnY0BXdyg/iHAjA8FC1fN9Cnc
	AY3VHPnEJy9766lAxXxGCY3sHhMf7fjZ7B64uqP8VoWRY7V4Aq2+nCT7+e9SOBZ65C5xLoMQ4hu
	IJQ==
X-Google-Smtp-Source: AGHT+IHjgHrA7xG0NpkEgyerFx4NYRTJeFfDwmp5imjiS4hM3JmM9g8Y/8s0n5IjWFI1IdYyAKTqLOiDHjQ=
X-Received: from pjbsj13.prod.google.com ([2002:a17:90b:2d8d:b0:2ef:79ee:65c0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:6cb:b0:2ea:5e0c:2847
 with SMTP id 98e67ed59e1d1-2f2d7eece3fmr1895400a91.22.1734395374509; Mon, 16
 Dec 2024 16:29:34 -0800 (PST)
Date: Mon, 16 Dec 2024 16:29:33 -0800
In-Reply-To: <20241206221257.7167-1-huibo.wang@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206221257.7167-1-huibo.wang@amd.com>
Message-ID: <Z2DF7UFNt1vayroN@google.com>
Subject: Re: [PATCH 0/2] KVM: SVM: Make VMGEXIT GHCB exit codes more readable
From: Sean Christopherson <seanjc@google.com>
To: Melody Wang <huibo.wang@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dhaval Giani <dhaval.giani@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Dec 06, 2024, Melody Wang wrote:
> Hi all,
> 
> Here are two patches to make VMGEXIT GHCB exit codes more readable. All
> feedback is appreciated.
> 
> Thanks,
> Melody
> 
> Melody Wang (2):
>   KVM: SVM: Convert plain error code numbers to defines

When adding patches to a series, please treat the "new" series as a continuation
of the previous series, and follow all of the normal "rules" for documenting the
delta between versions.  I.e. this should be v3, since patch 1 was posted as v2.

https://lore.kernel.org/all/20241202214032.350109-1-huibo.wang@amd.com

>   KVM: SVM: Provide helpers to set the error code
> 
>  arch/x86/include/asm/sev-common.h |  8 +++++++
>  arch/x86/kvm/svm/sev.c            | 39 +++++++++++++++++--------------
>  arch/x86/kvm/svm/svm.c            |  6 +----
>  arch/x86/kvm/svm/svm.h            | 24 +++++++++++++++++++
>  4 files changed, 54 insertions(+), 23 deletions(-)
> 
> -- 
> 2.34.1
> 

