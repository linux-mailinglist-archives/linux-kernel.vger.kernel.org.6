Return-Path: <linux-kernel+bounces-391213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD599B83E0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92239280D29
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F121CCEEF;
	Thu, 31 Oct 2024 19:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NRoDjCQE"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72A41CC14A
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 19:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730404697; cv=none; b=kkC6Cfv3hBJMdpYHzk24/EoTIMDo7EP+x1cwKa3CLOZFQGiXPXWbrURenOQ1fnzxFDfaIYrWWOJ4IMwFmfRIibZSCGgyyKmGpHTiPg1vv79iwoOi7Cf/wp2mOaWXdjMl+fSXl5jYepQDgzOyLuramWavCYVFbuNrokNxZVQsKVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730404697; c=relaxed/simple;
	bh=wfVPuQjg4pTT8nITD0HM856Hwxi07sPDN/CPn9k8zSc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SJABCqfN/3Sv4FXqstxq7M3wsk3GERuIbgo8qP2pY8EpGVURJmSjBpxLplxVDXby4rRs5c5ivXV7lIPjk3+5S0w6cj2WPdFZfujhbMhh2Yn/KeH4dZEekCVQUirxfcw3F90ao+kwBHUv9lnjUs+NL5FzL8PMkaoeiDe2gqBoLbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NRoDjCQE; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2e3321aae0so2136564276.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730404694; x=1731009494; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jNICsHqwMdHeZvWy3hsB3nyNIVlSoJHA3dF6aNeWo6M=;
        b=NRoDjCQEhTKhx38G+bZcns7x0/tFjIyswhiTNXRec00wi5BvTKve4+2UpRf7YhBFnW
         ct+aFR5fcV7iG+4QiNLVmFuT68So3g4KcFructP2V9qmeV+mxr9FFQEax/ReAZbWfHHR
         F47sXnIX8HZfFpDMDVawINY8tPe7AP4lFiSZ6/Vxpb5AiHUdM18KXLcxALT1bLEe9Dtk
         +cYtgFEic3p/Nn89VlHxh1RHQRYu1XAcs+Q/c1cv6L5JnUWBaHws2PgeA3THD3AtYD9l
         5ayNjU3UAL7xzbRLC2e+tFpX9LukrIYw/o2KHF5PyIvpaOpR8Vy9iZ3zEOjEjhScB3GE
         0f4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730404694; x=1731009494;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jNICsHqwMdHeZvWy3hsB3nyNIVlSoJHA3dF6aNeWo6M=;
        b=gYNFWH39kvp3jCIuF+OlZasuiqFro0/oyGB+0QCocB106uGRY/qoC1RgjtMDTgIDY8
         K9Lz+/nYcYPBYX1sIx0M+Rf9ImQt1ZJtT9e1MwGOIQgb6UyjXsIQfi+M/f1qNWI2SfqF
         slGJ42qKrGJwfmqiwGblDNm0DhsXJwJep5Ygy9kxPlmjJHsL9pfxNcLkpLgpFtpLEMeb
         XucaMZqsDe0SAihRmFLKA02sFgrBrHOGNYN3nTgw+2Ae11aCUZ4qw05MbriT8OLwwRfx
         DL+MAoLUk7I1IuE3P97XmmPudnIVF+f5A8nKiwz4Wt3kuqhJSbU7oA6zPKT11D82MkN7
         OsPg==
X-Gm-Message-State: AOJu0YyuvL1Jo6WBB+TFoSjxKcv5J/PIwEK+BjBUR/JCSxyJ2N3eAD54
	LHuYvaMRgq3E2BRDGIzOfPhGycm1hie4YYiLuGHNwWU/NCZoL0CppCzHMaQIdbDmWOoIDdms4Mb
	S6g==
X-Google-Smtp-Source: AGHT+IHIBAudi8+ePUHSP0AIZTVk5T1CCGOPq4+2lkCRsa14EhhW0npTIP2rwAL+igCci0qbI35PHNl2slY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1d1:b0:e2e:3031:3f0c with SMTP id
 3f1490d57ef6-e30e5b0ee45mr2642276.7.1730404694604; Thu, 31 Oct 2024 12:58:14
 -0700 (PDT)
Date: Thu, 31 Oct 2024 12:51:58 -0700
In-Reply-To: <20241014045931.1061-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241014045931.1061-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <173039500886.1507775.1819808332270567216.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: VMX: Remove the unused variable "gpa" in __invept()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, Yan Zhao <yan.y.zhao@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Yuan Yao <yuan.yao@intel.com>
Content-Type: text/plain; charset="utf-8"

On Mon, 14 Oct 2024 12:59:31 +0800, Yan Zhao wrote:
> Remove the unused variable "gpa" in __invept().
> 
> The INVEPT instruction only supports two types: VMX_EPT_EXTENT_CONTEXT (1)
> and VMX_EPT_EXTENT_GLOBAL (2). Neither of these types requires a third
> variable "gpa".
> 
> The "gpa" variable for __invept() is always set to 0 and was originally
> introduced for the old non-existent type VMX_EPT_EXTENT_INDIVIDUAL_ADDR
> (0). This type was removed by commit 2b3c5cbc0d81 ("kvm: don't use bit24
> for detecting address-specific invalidation capability") and
> commit 63f3ac48133a ("KVM: VMX: clean up declaration of VPID/EPT
> invalidation types").
> 
> [...]

Applied to kvm-x86 vmx, thanks!

[1/1] KVM: VMX: Remove the unused variable "gpa" in __invept()
      https://github.com/kvm-x86/linux/commit/bc17fccb37c8

--
https://github.com/kvm-x86/linux/tree/next

