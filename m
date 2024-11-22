Return-Path: <linux-kernel+bounces-417637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CA99D56F6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 02:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D00B2824EF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 01:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A43E17C68;
	Fri, 22 Nov 2024 01:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxrBZfB0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD8D7494
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 01:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732237459; cv=none; b=sNLEjIo41isaE3UdHookibAg0Z+U3z1h5WdREU9NhAgVO1yidwrSsZtBzWR1pypU+bbn5VesSkB1Aszl4pma/IO7ieKfPqm8EPTZacH0UxZzKqVHkLnjo3btcLpy0wFhHIB8PdM5HrhvHNH/Z03vSWdQOwaTf2gXEpm7LRBTpGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732237459; c=relaxed/simple;
	bh=w9bPiPzeaX1ctUb+PJzQ8yuATzJlSGzZOfzvZwr5lF4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P0iRvgq9DJlzfrRiooRaWkcvmf0Dy1zvTOtBEUyXdDJ0ZXFEA1k/Qt27WOPYnSdPVFBJJbeG451xIWCL9PsixjJrhgLkJPkawFn6uHxdXKCdxLw81ztC14uK5TaUKPpPoPzJvmKjxxjjIj3pRLqq1WlDZCi/MphzS4h0rWkrUAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fxrBZfB0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732237456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b1yYlsdUE8xMG7/GD4z42ixP0BqO1UCILEBK6vX1sFg=;
	b=fxrBZfB0WvBuLZT+fIm1+FpR3L/GUkHBPl1LsY0Dw1G3xx0082KsWOwTrx4Dr7Q1h6Sdqj
	wfJ2h35e+BgXqlEtmQ6kFSvwWETmD4ENLqx9/XM80u3j4poQ7dmELBttClrvPThtrBtb/E
	RwrXF8pXvmWMslfgTzEH3/eGszZeDow=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-iyrFbNfBMnGzu5EyhHNnuA-1; Thu, 21 Nov 2024 20:04:14 -0500
X-MC-Unique: iyrFbNfBMnGzu5EyhHNnuA-1
X-Mimecast-MFC-AGG-ID: iyrFbNfBMnGzu5EyhHNnuA
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b14cb9f6f5so179269285a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 17:04:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732237453; x=1732842253;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b1yYlsdUE8xMG7/GD4z42ixP0BqO1UCILEBK6vX1sFg=;
        b=BZUv79JrTbO7Q/ukL4cUQElRsbSV2gZDlykN9YCqHmtUq3097/nYpQSNf6QGLmZKP9
         5r/o8qqYyT6KWu6lsw064dHqwSxHZyke0IUO/XpCSUb82Ga0LRmXbBg/HyACcfj2FK66
         TgdLQPYJIDr9dFWTdWqO+1wUKMvYktQ2vm49d5JWwiDGQW/o4UbJ8mpRqOqQQTh0f+a2
         DkX/ncxYVKroFGCwEwIxxhNjDh5izJLaBoAb/JN4TeZhIQTXYKrnFu/lVJS8mREanEQu
         WUzmLmBRVMMsN6AqITvzB9n3mEPp5zWfmIeRu6abR0R7QC42yYSElwp+Yr1l5G3yjYXn
         IVGQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/W8W1GprXtmq5iZ9T4DSOXP1Oqg/csxo73IieiuXgV1Oa88FcdxR2RdTjt4d/Xmhh7+JyJBwKqt3ZJ1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGCpH1enPyBl2f5TGIc2flnHweZBeatbCR/JclpGO0+8HRPJue
	fyS4wni4P6XOxNiMmFoIrmXXFbOMwE6USgvJDFhLrhR+IeHbPdPqQ0VtBmNwvO7/+tqD8UJyOGP
	X6iX+1/Tj3OZGh5zLMRnI+/aHqtkCeDkH5B3TT10p+oRyMjztPsReKHBw8ZFjKQ==
X-Gm-Gg: ASbGncsz/duXwzJ5E27erTwzJ9uQm7gTSBGwL6/oHeh5d9MkemyYVXIbtnMZ+HnInLQ
	1BXKsCxOpnvhm1OuLRSa/++H4VhXhPmcByY791161X7IBqVIUBMpZ1q2HAIL4kJnYJJe5lVsgvJ
	ucKYGKpzmngbmQWAaNjVB4mRGfXmriG4xf5Zx6t+JefbN2WNvHRjl9GSAUooFgPMtwCoKPo/Pjl
	AY+TO7MkeG1O2KURz08NBoxVBClDvH3CUvYAbkKXsOzUit6rQ==
X-Received: by 2002:a05:620a:2a03:b0:7a1:c40d:7573 with SMTP id af79cd13be357-7b5145a6ae3mr127753185a.49.1732237453247;
        Thu, 21 Nov 2024 17:04:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMi9WAXqyjGBhUJc1OOj8HBASbYMPtLh8JD1G2rZsijJCmjLbdQRxzDYkVLF6q9uwODhBebg==
X-Received: by 2002:a05:620a:2a03:b0:7a1:c40d:7573 with SMTP id af79cd13be357-7b5145a6ae3mr127751485a.49.1732237453004;
        Thu, 21 Nov 2024 17:04:13 -0800 (PST)
Received: from starship ([2607:fea8:fc01:8d8d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b513f91e14sm36850585a.22.2024.11.21.17.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 17:04:12 -0800 (PST)
Message-ID: <ef5ad5116b1b39b94a3ba49e9c78edb3a5ebc91a.camel@redhat.com>
Subject: Re: [PATCH v5 0/3] KVM: x86: tracepoint updates
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Thomas
 Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Paolo
 Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, Sean
 Christopherson <seanjc@google.com>, "H. Peter Anvin" <hpa@zytor.com>, 
 linux-kernel@vger.kernel.org
Date: Thu, 21 Nov 2024 20:04:11 -0500
In-Reply-To: <d59b923ebd369415056c80b99ca4e0f75d60fa84.camel@redhat.com>
References: <20240910200350.264245-1-mlevitsk@redhat.com>
	 <d59b923ebd369415056c80b99ca4e0f75d60fa84.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2024-10-30 at 17:21 -0400, Maxim Levitsky wrote:
> On Tue, 2024-09-10 at 16:03 -0400, Maxim Levitsky wrote:
> > This patch series is intended to add some selected information
> > to the kvm tracepoints to make it easier to gather insights about
> > running nested guests.
> > 
> > This patch series was developed together with a new x86 performance analysis tool
> > that I developed recently (https://gitlab.com/maximlevitsky/kvmon)
> > which aims to be a better kvm_stat, and allows you at glance
> > to see what is happening in a VM, including nesting.
> > 
> > V5: rebased on top of recent changes
> > 
> > Best regards,
> > 	Maxim Levitsky
> > 
> > Maxim Levitsky (3):
> >   KVM: x86: add more information to the kvm_entry tracepoint
> >   KVM: x86: add information about pending requests to kvm_exit
> >     tracepoint
> >   KVM: x86: add new nested vmexit tracepoints
> > 
> >  arch/x86/include/asm/kvm-x86-ops.h |   1 +
> >  arch/x86/include/asm/kvm_host.h    |   5 +-
> >  arch/x86/kvm/svm/nested.c          |  22 ++++++
> >  arch/x86/kvm/svm/svm.c             |  17 +++++
> >  arch/x86/kvm/trace.h               | 107 ++++++++++++++++++++++++++---
> >  arch/x86/kvm/vmx/main.c            |   1 +
> >  arch/x86/kvm/vmx/nested.c          |  27 ++++++++
> >  arch/x86/kvm/vmx/vmx.c             |  11 +++
> >  arch/x86/kvm/vmx/x86_ops.h         |   4 ++
> >  arch/x86/kvm/x86.c                 |   3 +
> >  10 files changed, 189 insertions(+), 9 deletions(-)
> > 
> > -- 
> > 2.26.3
> > 
> > 
> 
> Hi,
> A very gentle ping on this patch series.
> 
> Best regards,
> 	Maxim Levitsky
> 
Another kind ping on this patch series.

Best regards,
	Maxim Levitsky


