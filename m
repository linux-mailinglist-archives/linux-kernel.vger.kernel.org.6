Return-Path: <linux-kernel+bounces-288075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD5A953313
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACCE61F21C4D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A331B1421;
	Thu, 15 Aug 2024 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2QeJnNj5"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEAF1A01DA
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 14:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731043; cv=none; b=pIsUbxeBSgcRl4VEQLOo1kLeXoLX1E6navW0F0oETu4vE/qqhMDmIvNHr6+4cxrxTx9sxGDjvZpJes1swVkagVb76DgFP8etbZuhgwUmsNfsgVlr4478IH3UcMAvE4haHWNteYPp9JOYA2LslkCpT6dTcUm1PAOBIC6H6GcHWOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731043; c=relaxed/simple;
	bh=40j0e3Mvmb7WrK004NVl5blJt92PlmJDef6FrHW+bIk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q9oWzhfSxpGS5bAigOyhBUfJcMX6CxFOiT/va5WJywjCj7yGb4MoI36LsyQsALBQtN5kCOwzpjb6qTIpbF0Nk6P+AWPnqlWKHQ7zVLGuLKXIXUvG4mz+5xFbDFge8OB7gvleHnehpr/RNCDG6WhDqfOuM+g83PSwPDZG517s3Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2QeJnNj5; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b0f068833bso3665737b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 07:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723731041; x=1724335841; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LTkI3wsyLsNDSBAGpuU/HH1hhVHus44TWdwDM7rFWno=;
        b=2QeJnNj5qWG1IXVZSiSRkXyh21zGR7hzYg4xjfYVDgN4p5L7kvpHMxpe6eOuLK6DoT
         VSVBfHX8dFPswd7ag5oYn/55lVA0XYdnSJO0C+fZihXib1Y+0PpSJHsu1ajPTRJRVmt3
         8R+up7qtImIqDta77g/vZJwdLNcp7AUQVgf4E1To0egSRgACAPukZw/hBlfkEau55Mva
         WTlP/m3iCYaLGrnzryeT5/8Inyj3FpmYpIGuCSAcOXNvGAlN2qCRfHHbXYzmVbDR1h0b
         FPpc41GS/jzYqFiND9hRazOR18OsQhBJc1O6Y5ovYgLX8uzIpykCeBHGEF5tU8HuGJ8v
         07vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723731041; x=1724335841;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LTkI3wsyLsNDSBAGpuU/HH1hhVHus44TWdwDM7rFWno=;
        b=eoO+KIOACdmvFkE9tesypTmLMhZmMLsmv6PQ5h7Guj6W2axW3qMzFaDiH/NEFOfbSE
         GT/SlVNSIjjXzzu0kZjwkGB7fHwxCXfsu2sa/20cdPlTLwBDSkfJl1pp21mqmolTLEQ4
         fCeqCPhuW9ZE7GOPCraTsLRBu8S0hALskbdQDm6NQfdUsYwSbMEUV3kSHP/N4kj9cN9W
         tg5J2NzuZjvUGuVXfMiXsnSuQz43+0mUfvYEYOLHQY+w3glml/z3jOfH/6K5l0ndX38i
         eEhAwXeYAZK94RQClXMgW4s1yaBwbHuR4lv2xlDZ8fC3jZ8EBGo2wB0kF1jOI3ZJ1MBD
         ekDA==
X-Forwarded-Encrypted: i=1; AJvYcCVoix4ntdGZmP99TAEQQvowZfsBBZL4xuQQTsKgSvSpnE4uro4jgrLVn8RZssWOwpJngm2iH1aVtQtnajaYOfkwubKunXijbNcrmlsH
X-Gm-Message-State: AOJu0YzFtvPD/72PdLC8ZQ5+0zgZSeMyOXvfm5Pc+lO5irYf+S9QNoy/
	Y4RvW11wlJEiwZD9zRp6e+BvtXaaQjO1TJFvikvyL3lxNDr/8jS8pUgYqi+EI7HQJw3oy4/Yq/y
	OWA==
X-Google-Smtp-Source: AGHT+IH0pTd3rLrKfwZLyotn/tm+cDBf4DXW8g4LPpDZGy112Wj3qEdw67GALP6EM6wTipE3BghmALeKdwk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1801:b0:e0b:dffc:d616 with SMTP id
 3f1490d57ef6-e116cf166afmr56139276.6.1723731041387; Thu, 15 Aug 2024 07:10:41
 -0700 (PDT)
Date: Thu, 15 Aug 2024 07:10:39 -0700
In-Reply-To: <2d485a6a-9665-4bb9-afdc-162b505462f9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240809190319.1710470-1-seanjc@google.com> <20240809190319.1710470-11-seanjc@google.com>
 <2d485a6a-9665-4bb9-afdc-162b505462f9@redhat.com>
Message-ID: <Zr4MX4YdoMaoo-s1@google.com>
Subject: Re: [PATCH 10/22] KVM: x86/mmu: Replace PFERR_NESTED_GUEST_PAGE with
 a more descriptive helper
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Gonda <pgonda@google.com>, Michael Roth <michael.roth@amd.com>, 
	Vishal Annapurve <vannapurve@google.com>, Ackerly Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 14, 2024, Paolo Bonzini wrote:
> On 8/9/24 21:03, Sean Christopherson wrote:
> > -	if (direct &&
> > -	    (error_code & PFERR_NESTED_GUEST_PAGE) == PFERR_NESTED_GUEST_PAGE &&
> > +	if (direct && (is_write_to_guest_page_table(error_code)) &&
> 
> Too many parentheses. :)
> 
> Maybe put it before patch 3 if we decide not to Cc: stable?

Ya, I'll do this.

