Return-Path: <linux-kernel+bounces-210750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E70A904842
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421DD1C22D78
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 01:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835904A0A;
	Wed, 12 Jun 2024 01:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rfgMf/Rx"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD61107A8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718155174; cv=none; b=Xu3m9g3KF/swa3aA6UIMJtNu5YwD7BRBAlusdwTDIAwbeOVTPAqDNvzJEXCbYpNorfJGqSokw2+2h8FU/uoNdL7iAL996eZrFz7Eku7nor0yUZp3M8JPqfwHm995mELxRmbSzfCfxo9lL945OquteLlTB9Z1uMBikd/j1zBYRKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718155174; c=relaxed/simple;
	bh=01On2/EVecp/FpY2MPxFsS9f5SUR4JP7vCiq48Sf3QM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dqbMExjI3Ou3RnEaN38NwUShK5F0K+94Qf7Y0yE/MJYyAl/0SsuPHfZE/2SvJvOCJVZ4UfVS9tZYZryKQ3yspmVzrZdAuGY373B1r9fdJ42z3NHK+RjAooE31cuGkh72lQQjtNrK3TqHj0Ni9yjptZN9aHJK88shDr0LHwumNW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rfgMf/Rx; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1f6ea6afba0so2718555ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718155173; x=1718759973; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dpt7pOC6j5Ad67mZsPPp978WnRTmoVaVrsPf3/HpPSQ=;
        b=rfgMf/Rxk0Fw+ii+N0a/TGkL9avtYFr0oawmOfQAImxaVv6qHbuaMCEUqC1HQI9p1k
         /YhsxwW8Id/mCjs7SoYyRBBYtYLeboZYGhYFn+WUTM5hPlhL6LT2eVfKvpMOpHMhMS+5
         Kam1lErtWTWs6wwn0SaNtjnoxoltjE4fqbLA46ADO2HlQPdtuQ8S/BtiuvK7MItZGznT
         5EBHcPa1b2uQD95JNlv6PBFft5d3Wqkt1vhVl8Rj989pBQkcwIfjy84fB/y20akMSS7Y
         ubgtwnPWqJG6L2+3HiYbSAmp4SmQXCjBQIiPjbvRmApCpNQQp9bmNNM1oJTkCvyg5pxo
         TeTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718155173; x=1718759973;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dpt7pOC6j5Ad67mZsPPp978WnRTmoVaVrsPf3/HpPSQ=;
        b=FKPqFe/SvgOBq2pAeNXEcC3LndN6ZtT92mkiqWgoarocpP1Gqmp5yKEdRn0XkwM8uL
         c1JsHXpYm9qrmm3RwPfZdT5mLd9f+tbO47yT5qgLCBIGw8MqVIFFFh1zOlTun1k9tYse
         xlrpPG2kAFRNPqubFlNN2yrMhs8T37mEVvi61a8KODFWR17t7v3Igj3ORGdFos11krni
         WAuMGRz5ZGnVL9M+K4PcyHKBkm3YzSetEaluDpK83ssG50enlXMzn5JYRB7hznnz1t4R
         dgn8mF4hT0dajzJm6ruLXodHi5bKXBZheNbe4zPLzdFJvhKILECb2q/hSo11CGlYFKDf
         LxDA==
X-Forwarded-Encrypted: i=1; AJvYcCXaea0H35/K3FcRE+7g8Eb3K9wAO0KSgjojZcDTO1FBhV1ZUmnJjZlQiwsWCHx9SeST3HWCY4rFitt/9Kqtvs5bDTGMl9rEI1IESqVv
X-Gm-Message-State: AOJu0YxjiVyxKXSR2I1xsNrbTiVV28GoDV0uneSYePAqCS1QcGbHMNGe
	kDXjbXxxjD+FUyzHIGh3XHnww8MnDY2t+BO7lUv4UV252FGUBq6wduA/zId7rxPAD2yr/uFFxvU
	5Uw==
X-Google-Smtp-Source: AGHT+IFacOJgoQzjKofsQnSKGWaTN0dSvkvFf7Msi15ZsbtxDiubwj9jgMosm5e8+6Xxaijsg5R5zHNcy8I=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e882:b0:1f7:1046:d68e with SMTP id
 d9443c01a7336-1f83ad55c76mr214055ad.2.1718155172838; Tue, 11 Jun 2024
 18:19:32 -0700 (PDT)
Date: Tue, 11 Jun 2024 18:18:32 -0700
In-Reply-To: <20240506075025.2251131-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506075025.2251131-1-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <171803734657.3359701.7956342663823858498.b4-ty@google.com>
Subject: Re: [PATCH] KVM: VMX: Remove unused declaration of vmx_request_immediate_exit()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>
Cc: pbonzini@redhat.com, isaku.yamahata@intel.com, xiaoyao.li@intel.com
Content-Type: text/plain; charset="utf-8"

On Mon, 06 May 2024 15:50:25 +0800, Binbin Wu wrote:
> After commit 0ec3d6d1f169 "KVM: x86: Fully defer to vendor code to decide
> how to force immediate exit", vmx_request_immediate_exit() was removed.
> Commit 5f18c642ff7e "KVM: VMX: Move out vmx_x86_ops to 'main.c' to dispatch
> VMX and TDX" added its declaration by accident.  Remove it.

Applied to kvm-x86 misc, thanks!

[1/1] KVM: VMX: Remove unused declaration of vmx_request_immediate_exit()
      https://github.com/kvm-x86/linux/commit/d5989a3533fc

--
https://github.com/kvm-x86/linux/tree/next

