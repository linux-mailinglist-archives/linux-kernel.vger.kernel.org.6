Return-Path: <linux-kernel+bounces-234681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E21E91C965
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 00:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FACD1C22C5D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C3113B792;
	Fri, 28 Jun 2024 22:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PFF8aZdt"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F1C824BF
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 22:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719615439; cv=none; b=Y3AKKakqKdHLRi0sqo/l8xsb66YEEczcBX14mSa24fnCWiFqaBbduZ5ks3nsnhioz6w2jDbWrqdFsSTK0G+iY91csOE3XqwBLBvFRCLruUuKFc7/P7DmW1ok7RFcrUYcrLvIL45FMjmOrLuhgdzJG+HV7EFjMlUIBspaX2+Cv/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719615439; c=relaxed/simple;
	bh=0N53I7IvRtVI5T7cB3Re4x7De5UnRlFbk0KmzGPmLZU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JCeU7rVBcv/E0Rgg/S3CgZyKmlAJJ0oYmH5a+itCDXpCDcOMpwZP32S32agrYDe2ESDuC/bzJ8La4aGYEFA//8W8Tdf6hiORrWgyCjbHWePBpRTNSd+nMyoudXb1HH9yEsVKHMNmxaAny4KOWrvMZTQ2dq3vxV2HG9lpqcLAYa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PFF8aZdt; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-64ad9545c5cso19778107b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 15:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719615437; x=1720220237; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NeiKLTeYecaI7blKhL4eUGMIebS7L/6ZmCgbIaIBrbU=;
        b=PFF8aZdtdDHdwZclPsytdYsRwPq9kEszqWGUMGNfB2v2U0MUNzxjTEdc5weF/g0tIM
         swcTcAS15iLTyKyLd3XaXxGCYKgjZcZPWBNkH+XjNsy/SkIpRJ6UXRolXwWIJAc3Wh6D
         RCXHB3r+pI8/r6+2NSCNdsm7b9+h68C7ILkfAxjWoAnmx+HsmSqKhS/EuJKMz0XMBndV
         Rj/0Gy3ToMq4DCoTv+C5BZktgZ7SF4eSaD43Rp5DwlnVyQJqV4B5LAnEyNF8x+3N9QFr
         VR3XyPanZq56tKYMHzFggmGvn9weaxmKDjJ5ZtRqBFN/7PTgwaKVu1KErGmLv56j9436
         gDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719615437; x=1720220237;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NeiKLTeYecaI7blKhL4eUGMIebS7L/6ZmCgbIaIBrbU=;
        b=SNrqC94eg28q/JWybJUXgfr4wukoK04H2lhUIi3dW3E4xCBLzqby/9rIR+lGGy9Nce
         hslsz2f9PxPejJA5K/cbOO4Hga/+kfiE6QbURIoZxqwaBcaITIYxQK7Nvlu45IyhBdpe
         T1+uchvz9N1k/p3RJM7r5rZrA9XkWPSP4z1uHc+bbgJrLWW7vp70BrdPnWd+utAOOXyw
         XbcizWm+N2CLn31Uia2kYDK8/8WptwtgzjAVKFTdlHvdnc6A8qDCgLMhwGswxeGsTNdO
         gmHuUFYvRKUaXs7Lcqs9hbkL73yDvS7hM2e+Xb5MRGganILCoPb/q7XNV2dEQQvbpr7K
         w48Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9YyUIuz2zdEAAyULp7DTtkHk/Cl91geWMYe25OkkyIXAYaq4N0wbCjcpVC4y0lr34LH2CEfqz3mlMyEXiepyxtn/FwKtGlI/TbR1m
X-Gm-Message-State: AOJu0YyODXviD3V0oACAgXf62VzOyqKf7DWUS/H2n+la+eZm+awcqRXm
	FoEc0tAnYRnumXtiWWa5P3qwk9kHif2HTBJJ3YvXe3skYP5PAexk5u8JFgrmJTqCziNjrI2udyV
	GzA==
X-Google-Smtp-Source: AGHT+IHONDjsFi0Y4/UOoJE5S0o2N3JrCbgQstm+BXqMj/B4A4H59R0KqKFAZMVr5qhs563ZYaSpVwz8eqc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:18d4:b0:e03:5a51:382f with SMTP id
 3f1490d57ef6-e035a513a82mr239884276.8.1719615437498; Fri, 28 Jun 2024
 15:57:17 -0700 (PDT)
Date: Fri, 28 Jun 2024 15:55:36 -0700
In-Reply-To: <20240627010524.3732488-1-kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240627010524.3732488-1-kai.huang@intel.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <171961446436.238031.3450027759536844841.b4-ty@google.com>
Subject: Re: [PATCH] KVM: VMX: Switch __vmx_exit() and kvm_x86_vendor_exit()
 in vmx_exit()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, Kai Huang <kai.huang@intel.com>
Cc: pbonzini@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, 27 Jun 2024 13:05:24 +1200, Kai Huang wrote:
> In the vmx_init() error handling path, the __vmx_exit() is done before
> kvm_x86_vendor_exit().  They should follow the same order in vmx_exit().
> 
> But currently __vmx_exit() is done after kvm_x86_vendor_exit() in
> vmx_exit().  Switch the order of them to fix.
> 
> 
> [...]

Applied to kvm-x86 vmx, thanks!

[1/1] KVM: VMX: Switch __vmx_exit() and kvm_x86_vendor_exit() in vmx_exit()
      https://github.com/kvm-x86/linux/commit/92c1e3cbf0d0

--
https://github.com/kvm-x86/linux/tree/next

