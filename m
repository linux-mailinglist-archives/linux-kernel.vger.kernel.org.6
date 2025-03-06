Return-Path: <linux-kernel+bounces-548023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD888A53EEC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234D5167A12
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6682EB652;
	Thu,  6 Mar 2025 00:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EzoGPSBl"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E2A63CB
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 00:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741219857; cv=none; b=VR9yO9WOYtGlU/9nafK8fpaDsgkZKleQNW4AJtieIOfllQxOb5OAzi7irzuE0m+nRYnbyTWMSn2lEf157WpLGoIVGiwwCfxxtvjaLx/w/lcDq/bUWn5O1te0QyIdaNUiOHmpOd+bZtbXPpdZaSZB59R5QUlnxDhPVI6p9LJtMjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741219857; c=relaxed/simple;
	bh=BMP2Cu6ueAsVg5DJpgRqTk8AwwWjlXRp7w4LMew/LV8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bKoTMNXrhLonpWTeC0gtcJ8B3nMw50KPcmOkjGHGVaYREZFG9ooc3DedUZQgjs0W8TKENip1laB1wnzs0KmjESUTEU4MSI4Tx9uNp+o1SA7dKPUmrdNrqjHpWcyoXH1X1aMAVsxZ/WT3Va9g9yzXdW/SMl/D5wshUu9z2N6qhD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EzoGPSBl; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff6167e9ccso367299a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 16:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741219856; x=1741824656; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gkAf3bS5L3Hu0wBjNyDNUVwPUQfV/Y/RYDcUi88Gr00=;
        b=EzoGPSBltRNgWqmAvubPiemJfJKN+oSRo/Lm1vtE4dUTihdF9Vaeo6b1/dvtLRR4i7
         MdwGnkebHX5Qdso3kpe/BU/4ABhN+oUyZzhBI4tsuN1zDcM1Rxr3RaugyPZVUJxgm0bH
         VBlLJR8KzAy/vAyLOwBV9tR05Ehq/aUkWFW012Tc93kiwjXH6yxE6XuIT2sCjWORhTaU
         ALfZlL2W4+k+YIzUfI4CSR27cVgAzgnJn8zhzOvJ+cYwRGzoBG5ZWMrlUhdtfjIUcB69
         6ApH/hCEvQZaqKu/koWbewYH4xr/5RpwOLjIr7POr8+NIus2paLCCwULiYcZGjPiAnc1
         8fsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741219856; x=1741824656;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gkAf3bS5L3Hu0wBjNyDNUVwPUQfV/Y/RYDcUi88Gr00=;
        b=aYtVoYTI+xHeVZpFW8AfTW/w5/tGEGH4Qp896XbN1rHeuSwEToEtDMpsgwmJ2QobW8
         dVPFLW5HGohFTOjkLHoz1KRiL0/Va4UyYmcxPMNeB7WmliR8fD4YFd0YfRWc8nX2h4rs
         aeLNh7PeBX4S2sl2loJMf3sEzpzbTq41yXSP6CVIJNYAkxdfcjNtwwl/eFRKTsA9m0+q
         87oUqx/7jiVsvpMhdP733oq26vWV8KXusCoZEePdqD8XXkY3jHcYbwXmbwy+q9AluQnu
         0v99fTSIYzAC7duympXTTkMrLBLzSw7XvqgNw5c+2XMflWbV24e2h20rBpIMZ00hPVPa
         xwSw==
X-Forwarded-Encrypted: i=1; AJvYcCWwb0yygoX+8hK2o8VW4oSzjai6LQ8rkueiWIfi2imInlVQIzYVXSx2phd/z0pHcB2Y2uhwCWWexxEhsy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAILnW0InfzH3yrwaDjNrdp5yJ37uR82nrk7OhuwJgOzXiDu+T
	Z+tBPJ8JlY5awUdr7efE+gEWyZ+/Xmj1ktabXGcKte/d7obK3IrLejS37wj7MrZ6MHLrwYmHIA2
	1Dw==
X-Google-Smtp-Source: AGHT+IH6mtvWi524iNsh5MnZ9uVRt0uAQkqtI0o5+FBM2OSWGK6g8TOWH1A2818hUQq2ucNbEVa/38GArX4=
X-Received: from pjbqo11.prod.google.com ([2002:a17:90b:3dcb:b0:2fa:1b0c:4150])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2712:b0:2f2:a664:df1a
 with SMTP id 98e67ed59e1d1-2ff4978fd9cmr8922776a91.2.1741219855851; Wed, 05
 Mar 2025 16:10:55 -0800 (PST)
Date: Wed, 5 Mar 2025 16:10:54 -0800
In-Reply-To: <e5f56fd2-b2e2-48c1-bb3d-e00b61807893@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAMEKE0Hd3S0-25afhWQhNNitbc7njp0ftO+Y3QmgS6CyFQh4ww@mail.gmail.com>
 <7a212431-5320-464b-a357-507fa6511586@intel.com> <e5f56fd2-b2e2-48c1-bb3d-e00b61807893@intel.com>
Message-ID: <Z8joDnLe-A3zdwu6@google.com>
Subject: Re: [REGRESSION][BISECTED] Some applications under Windows 11 libvirt
 VM crash since commit 408eb7417a92c5354c7be34f7425b305dfe30ad9
From: Sean Christopherson <seanjc@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Miguel Ruiz <miguelies.ruiz@gmail.com>, ravi.bangoria@amd.com, tglx@linutronix.de, 
	thomas.lendacky@amd.com, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, xin@zytor.com, 
	tony.luck@intel.com, pawan.kumar.gupta@linux.intel.com, 
	andriy.shevchenko@linux.intel.com, jgross@suse.com, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	christian@heusel.eu, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Mar 05, 2025, Dave Hansen wrote:
> On 3/5/25 15:42, Dave Hansen wrote:
> > I'm also cc'ing the KVM folks. I don't actually know how the #GP from
> > the split lock detection will manifest to KVM guests. I'm kinda
> > surprised it crashes the guest app and doesn't do anything more noisy.
> 
> I've got my wires crossed somewhere. It's not a #GP, it's an #AC.

Heh, nope.  Third time's the charm.  It's a #DB.

I've got the fixes queued in kvm-x86 (and tagged for stable@), I'll make sure
they get to Linus' tree this week.

https://lore.kernel.org/all/20250227222411.3490595-1-seanjc@google.com

