Return-Path: <linux-kernel+bounces-192658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5168D2041
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7391C23395
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF55170851;
	Tue, 28 May 2024 15:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZdELZijr"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A2616D4DA
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 15:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909703; cv=none; b=j/BOVNsRYFXbrGEolanL+zBQx+WE8LVWCgpje9Mr65SiYVWT3//sBHyMkizPszipjTTrZuPj2+wbhiC2elL4at1aeeGt5Jt87HR8gHN+2NU62GYx7v8DWtm8XbtvDnysU38v2cI+sNlnsYFJXYZa1hIzv2uyiGY2/AFjESshdEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909703; c=relaxed/simple;
	bh=0Yz2y7QOJfyVBPMZHgZvT/EZ6hOdwvYJIao8t7SoEpc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oZF/U2D9tHUk0/hcUxKKXaFwy2J8ZVxnDCsGwCHManEV93wqj554iJGZjmPev1/1O/KlNMttkqEJIb/nu0BCT2QDdPlq2hV6BuMZlTksqrznrlKHbmnC3wLnBAVxhaPHhEcxlAop/qMR0E+SWbF1Svs2ycDU7UU9OVL47iwS/KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZdELZijr; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-df7721f2e70so4618110276.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 08:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716909701; x=1717514501; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bRBd06u9sCh27O0CX55ErAEywPjabZqaR+RrcX+yUJY=;
        b=ZdELZijrgmbN4vo4vJlQaB7jZlrjKQ8tU4sE3CQEnDrkNcVTUFcaUH1Qh5kPvXiEGk
         rqwd1RUNKiyVXID2bmOq7duAJN1Ma6zfSfBAIwA8sEaANUXS72LTvBvpszIfEDSiffSw
         ZQR8StReqr2wZz1ybHZCwlAgS57al8vX9oyvP6bDTPQ1KrIxmBRbSvDSWzAg4YmLlyFx
         kQ4QALOtdAAhnvrDxZkTJUerhwZanVmDYyEdA8a7QI3duc8wLz3SIlXdeF7F2tNHvOYL
         VXl7pcX0a3QV2/eZkNd0iiSJioPUtU9W13zzvsJjViGMHvIGuW3EXEUWlCBkGkiR8qyl
         d1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716909701; x=1717514501;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bRBd06u9sCh27O0CX55ErAEywPjabZqaR+RrcX+yUJY=;
        b=wuZURgjxTrCI0lZDZcmI6HiRB/jjgJ96J13OlRz+9H5v6WmS5idpX1oAn3ek9tmp9s
         4SPsvuPctcSrnpt3Ppfft6+2geNLn5q1qNjaRBVUEjy72+SHC8M1ve0ipWcN35x9O8Zq
         w5vVw97702TEF6QKfwXqYH51zGYhOhjLxhUt9p5HMc1dA1y9grftYYBRtwNTjEr0dpj2
         JYUeSOZlyccayAiei1aQvE+XrCttSHKOFrwxqizoHVxRYmhlkiJEtlNEETxlKFW8Ib82
         Q2IVtkV3n2ChHLWQ5s1KOl2VxpYGSzuppg83YZ+o6GGUAicilXb++W7bLUy7RoywNToG
         K8ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMZCvfZ5hEDmtvIlwGfMdwjddLRiPSV5oqmUDyXyQ/6PLuGKpG2Fti9P/XfDy2WcF2AwRYAX4LDX+B8uKO5UsvEuqnqBwuBykbxUGA
X-Gm-Message-State: AOJu0Yx48DMNW108VIKF+7/oIbm3Wn/rn3cF583QVUpUl1SYcGxg5swu
	HAJ0bWUns7wucvWOtQdzT1+OqdKhWNa4JaPAP/E8SUAGslqe6nq/5BXA8d7155YE1vDZGacVizV
	yiQ==
X-Google-Smtp-Source: AGHT+IFUg0oBR9pemkRQzM4G8p0w9fg1yaIVZjFK83T1P8hqcQyT058SSgYKhk+6Fyn6cEBObfTSHitNrv0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:f11:b0:de5:a44c:25af with SMTP id
 3f1490d57ef6-df55e78b521mr3033739276.5.1716909701251; Tue, 28 May 2024
 08:21:41 -0700 (PDT)
Date: Tue, 28 May 2024 08:21:39 -0700
In-Reply-To: <9296de25-0d3f-47eb-a98b-e0dcd388cd6b@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com> <20240517173926.965351-34-seanjc@google.com>
 <9296de25-0d3f-47eb-a98b-e0dcd388cd6b@linux.intel.com>
Message-ID: <ZlX2gxki9tw3Uny8@google.com>
Subject: Re: [PATCH v2 33/49] KVM: x86: Advertise TSC_DEADLINE_TIMER in KVM_GET_SUPPORTED_CPUID
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hou Wenlong <houwenlong.hwl@antgroup.com>, 
	Kechen Lu <kechenl@nvidia.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, May 22, 2024, Binbin Wu wrote:
> 
> 
> On 5/18/2024 1:39 AM, Sean Christopherson wrote:
> > Advertise TSC_DEADLINE_TIMER via KVM_GET_SUPPORTED_CPUID when it's
> > supported in hardware,
> 
> But it's using EMUL_F(TSC_DEADLINE_TIMER) below?

Doh, yeah, the changelog is wrong.  KVM always emulates TSC_DEADLINE_TIMER.

Thanks!

