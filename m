Return-Path: <linux-kernel+bounces-336149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D69097EFBB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 19:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB85C1F21DCC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBDC19F134;
	Mon, 23 Sep 2024 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1lh51dFR"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105F519EEB4
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727111097; cv=none; b=CGSoTePG+npIL7EwYuwoC81oia2rlI7uJhG9ZLHL7sPmGB2AbODTY8Wvaqv7MjhmmOoYeK7FtG2r90Z3D24ND4yoR82mxLrAsKOLfK6v0zwdePIcdk/FqGom/lqTuRTEuZLQxeL0UsHZsn79OgavNZrsjfv2ulgGv2WgonF+fZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727111097; c=relaxed/simple;
	bh=vJbtWKItKqWE14H3NBVh/niuTdcSm9we5iEkrkOBEac=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ltLZT3wBb+cruA0rwMSpQk8tyqC1yOAMQltw5ZiXE+/lOmAnCDxaNHwtsOj6sZA55ERwo4JG3psZWFjyXz8VaiX84k10tDawPJw4kYo0n+JHTs3DPQPzc1A6OrTOznD0zEKzvokjVi1abaJ7uPEHGiuypiiHXlRet8Qglec1M5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1lh51dFR; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-718e2757e5dso4664078b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 10:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727111095; x=1727715895; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0LTC4QqKWucxBxnk1ZrnUFF7oEi+VhIK6z7a3jLf3KE=;
        b=1lh51dFRBOCPVwpfUnOQMu53PXfEZ1yoG6AD8RODpHlRqc8xusjrfPdFJukDYMMg0Y
         w0fvGlogUtjfFxbsZgfeBsu0OskjjnnwLRRiuPCmbIgTS+4Qpy5R7BEz467KaGQXNx8C
         IhOXNCotukd1+t14ItEKgVTBRYvWRAT+NyBby1hWp/OluFE+GjD5wpWcvNImh/ZRk44C
         FpVLXtcvJ1cm/wN4bfb85D9nuqOBuRgY/UzB0tGsfuG0sPmtu9yW2eyFDJgc6PYPtCMk
         /qC/BUVRTLPLqoPsDFWo8eM5T+jtbO9KznoJrqSyZyFpvq9Oqgh+jm1Lw7OpcMku/REZ
         EjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727111095; x=1727715895;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0LTC4QqKWucxBxnk1ZrnUFF7oEi+VhIK6z7a3jLf3KE=;
        b=A64GTSCpgi5aS3KOUhh1woA6bD6gaaAv382/8WENXh+GVZU2aB9ytowvnwYrP3GV0h
         y2akPpUrtQkhYtlmGeSxXOFRvK4JJSp5N7xWcu7+N4+EJrS1Y+PTmSRndcN3vWKlLuXC
         PxVBWa6eJg4q21i/ZqipnvHHGoKZjlTAsgp3xjwLFYP6qPDz7y2TKYH3voGW2qQdb13V
         JXlwfH1tyNEAcpVOZyjtGPjCP1u5sfrlew0BgFMOzwakgV4VBgxakW/j8tS21AGhe2Xv
         kdNE3cZoAVsb7xPn7Ubz80PAA3ah/IS0blfdM5U9Lw95aCBpAv7Dj4lbmORzn2AzHbIk
         RxNA==
X-Forwarded-Encrypted: i=1; AJvYcCV34/tsEsJpWpb0zSFw/s67KtD66YtU19YzFvXqx59zkuBqQZBC14f1FiWYqQ+2MZbmyTfGFKDeSJAug7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrQLAAwTQEg9KEbTgzH3KP3ok4GBdI1y3Pm0KwOM11ekUvDVi2
	a0v+4swGnwlBGHipY9yixY4KMr1ULT3/u++aF8hGVq+B/nGgtPs2qlOWZeDiGsKoHWmxEEMGEJ4
	JuQ==
X-Google-Smtp-Source: AGHT+IGIWxxwhZLXYVP88tODSZuBGhUt9N+COq1mKE0YgBtKzP2xBkCYCTi8v8lqsj5RFPeLr3njweGVXgo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1d0a:b0:718:de57:dd29 with SMTP id
 d2e1a72fcca58-71afa20c38amr561b3a.3.1727111095079; Mon, 23 Sep 2024 10:04:55
 -0700 (PDT)
Date: Mon, 23 Sep 2024 10:04:28 -0700
In-Reply-To: <20240923141810.76331-1-iorlov@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240923141810.76331-1-iorlov@amazon.com>
Message-ID: <ZvGfnARMqZS0mkg-@google.com>
Subject: Re: [PATCH 0/4] Process some MMIO-related errors without KVM exit
From: Sean Christopherson <seanjc@google.com>
To: Ivan Orlov <iorlov@amazon.com>
Cc: hpa@zytor.com, bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com, 
	pbonzini@redhat.com, shuah@kernel.org, tglx@linutronix.de, 
	jalliste@amazon.com, nh-open-source@amazon.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 23, 2024, Ivan Orlov wrote:
> Currently, KVM may return a variety of internal errors to VMM when
> accessing MMIO, and some of them could be gracefully handled on the KVM
> level instead. Moreover, some of the MMIO-related errors are handled
> differently in VMX in comparison with SVM, which produces certain
> inconsistency and should be fixed. This patch series introduces
> KVM-level handling for the following situations:
> 
> 1) Guest is accessing MMIO during event delivery: triple fault instead
> of internal error on VMX and infinite loop on SVM
> 
> 2) Guest fetches an instruction from MMIO: inject #UD and resume guest
> execution without internal error

No.  This is not architectural behavior.  It's not even remotely close to
architectural behavior.  KVM's behavior isn't great, but making up _guest visible_
behavior is not going to happen.

