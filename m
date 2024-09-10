Return-Path: <linux-kernel+bounces-323636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 814D99740EE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361491F22FA9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42BB1A4B70;
	Tue, 10 Sep 2024 17:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wHAPqv9n"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE34A1A2C35
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 17:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725990208; cv=none; b=Zumjrvot5o/TTZY9KGOR/Cbw20BmAiLF4KojBU2KYQDli4IF2GQvK/QoEL6gPbc47W/AMxiFFZlgjSYJKJ8pTmCjEefZQ5XFtlnRxM8fou6p+Xf49OaxQ6cAPlkXoLJpgApDsCWV6xJeZK/8hQLDRH0yxlpjZi0JMF3YLhSglJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725990208; c=relaxed/simple;
	bh=RXcl/kAsbEKEl/dfpdTZ9QHS8OMIR7d7fPwNV2gfULg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aYnODDw31tOt0liQaooI/N3prw7ffijRWFeCY0HvU4W1hJOBHgbuN09l7KNiMeHssAAy1fct0FLyVRXbdxXxFpgYhlj60MwaX6HWamddBBnww/Bs8WySiH4tMcXwf+WLT7e+Zlu2fS2msIcBIKROtpH5iNi+JoxzpK418dv6meM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wHAPqv9n; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7d2159ebf3dso8056289a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 10:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725990206; x=1726595006; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CTDniC8wF1bZnJw5Fse9fWH/u1zUQgOtC2m55BzKXRk=;
        b=wHAPqv9ngSU41U/M1BB/uX/Ey3wZaUTVhD2uzdLLAYlUBCQegfyTCk3qmBvuX+EUb6
         WwzaVyRWULwR60t6sxQ0U6toJdH6/MU70IgttFdUHnMpsV6GN78099sjn3rgoNLhbG8D
         mEB3+jnKk56twLSzlaH4RZaB14Cdrpu4baSU62tlHB95tvpcFni3E3bA/C69QmbK3sF6
         U7lNhASFBdyrVHAEISzkxOtDyGg55jqhkBplx/2WqvfiLEt8DCKZRNFHYgRx/i8xjN45
         mB4Qw0mqRI71Z0k/vl8n9d8Cv4qjJ7/qHxsWFUEQ98iWZyooPXVDTfYPDZurk3PLdbOS
         5IvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725990206; x=1726595006;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CTDniC8wF1bZnJw5Fse9fWH/u1zUQgOtC2m55BzKXRk=;
        b=JtFGEKjaEgpCsCdHjNIukGPyeFGXYt/GxuKk+TZ7osxlPOWQd0ONAGl9MDl1khHVYR
         moKyy5nOYnb81ur9E/ve1aZcl1TnnUjbfxK29EFz6nDT8gWbL3CPvVlQbWekMEFqSLxG
         Q+SDSq4CIgP6cuACtM6PgihXz4QJ6pClNfRuiCteJe47JB9/8USrvzLnz9445dyVz80d
         bw/ePMwnqYAlfY1AOFJrzj5yuxK44gA6WQdzG1PlbpwSIzq8YrhVqypxEluhri9UH3DW
         4w0wPQZi73FXvUt7o6NiOdpVRoRyB9fwV9VLHavLWzJQ+2jJsVEhPjDSJ/rDIgm4eRnH
         E0gA==
X-Forwarded-Encrypted: i=1; AJvYcCUeL64qs8yMqtVADuPqgIaw8PCYOMSAeA93odzoUJck5RB5deNxpSGtFPaxrn4ObzYja/f5Av2WL3F+uT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPMB0Ho+y+kirhUKeqr6IbmBF729EunoG7863cdt5SwxAWXW6w
	ZDsJzowhaohhbGEtAmio7VZ5omgtNMd/85oIgdzd0dPahRQ/FqS58pgj3EUj2ihjPdd68ELoJEZ
	hEw==
X-Google-Smtp-Source: AGHT+IF8Ru/d1LnT7NLCy+WelmbAmaQKqFAMn1yaAVhTmnncNpldw8V1jPJOqLh3McrEjSMTHaePFdnSVNk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2446:b0:206:8f21:2828 with SMTP id
 d9443c01a7336-2074c7c0f83mr1023485ad.10.1725990206004; Tue, 10 Sep 2024
 10:43:26 -0700 (PDT)
Date: Tue, 10 Sep 2024 10:43:24 -0700
In-Reply-To: <20240910162238.GB117481@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240906043413.1049633-1-seanjc@google.com> <172594254948.1553040.1513231357668918094.b4-ty@google.com>
 <20240910162238.GB117481@thelio-3990X>
Message-ID: <ZuCFPIbLl9-AeXUb@google.com>
Subject: Re: [PATCH v2 0/7] KVM: nVMX: Fix IPIv vs. nested posted interrupts
From: Sean Christopherson <seanjc@google.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chao Gao <chao.gao@intel.com>, Zeng Guang <guang.zeng@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 10, 2024, Nathan Chancellor wrote:
> On Mon, Sep 09, 2024 at 09:56:42PM -0700, Sean Christopherson wrote:
> > On Thu, 05 Sep 2024 21:34:06 -0700, Sean Christopherson wrote:
> > > Fix a bug where KVM injects L2's nested posted interrupt into L1 as a
> > > nested VM-Exit instead of triggering PI processing.  The actual bug is
> > > technically a generic nested posted interrupts problem, but due to the
> > > way that KVM handles interrupt delivery, the issue is mostly limited to
> > > to IPI virtualization being enabled.
> > > 
> > > Found by the nested posted interrupt KUT test on SPR.
> > > 
> > > [...]
> > 
> > Trying this again, hopefully with less awful testing this time...
> 
> I meant to reply yesterday but I guess I lost track of time. This passed
> my testing on all my machines, so it is not as bad as last time :)

Mission Suck Less Accomplished!

Thanks much!

