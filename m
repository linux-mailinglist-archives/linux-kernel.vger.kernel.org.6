Return-Path: <linux-kernel+bounces-288176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C6A9536DE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0BE71F21A28
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559771ABEAB;
	Thu, 15 Aug 2024 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FfT6r+Uc"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF301A4F1C
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 15:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735001; cv=none; b=qkuXO0ZyaZ7FvvSOsNoyeK4luIOvXX3bFTmGysi4BIW+oTihefndOgUmej9sQtSTBzzVCDY4eg9petPrs32HQSMHANGf4faTsuKz7O+bhmOlb2l/HUaped5eWtTw2gHyxQ4ZjJ1Gr/QY0YW5fS05uMB8X0XdRQU3OKkzg7FS+zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735001; c=relaxed/simple;
	bh=p41m5YvSjQgQm0tkYUYL+QWq1GHejmaKGY1AgryhcvY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gUN6WzqZsngg1kVwFt/eiSmWHlc+Wg2S4djo1Skr59ncubxWq71wpYVhuyJrIrg/0iJc4DJzKADHNsm+MM7wFD0I6nBuJQzBV+TwzN9+hCUbzOCPCt6cWnDJg2z4Yg0zjaE0/hEvfmd0yU404lpTALRNCVwpwnJG0vP+7WdoBGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FfT6r+Uc; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e035f7b5976so2159200276.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 08:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723734999; x=1724339799; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p41m5YvSjQgQm0tkYUYL+QWq1GHejmaKGY1AgryhcvY=;
        b=FfT6r+UcQKRbDGDpXZVInCWT+bvz8y/5VravLXNilCiXc9SEPhdOfUPXiV/l95mIS8
         n87pfIsw4zW2PNFrrE0OE9gs/LgZYmBXrVcQGrebSoz0bH5by+9z3DoAtrXAoWVX5uhF
         zSQ3XBVXhQHnFa4dfl2EOiZcIqVRKUlZMfMVsFuPXuOycAScZ/PnQ6MRfSEFuG1UxCpQ
         oGtinl8D/SAGb0rxH6F6jBlatWOxi187HS9Ohda5YEdTi+Qz+O49CvQVsAFolT7YPSR9
         itwURHhYcbFGsXU9PfOq2M7nPl7mi+YD5kjM0wQje7JLm2foqgu2DOECOrFyKKCAMdBx
         Dt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723734999; x=1724339799;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p41m5YvSjQgQm0tkYUYL+QWq1GHejmaKGY1AgryhcvY=;
        b=b9r3gj5oGMxsqLtxp7Aln9i2xYUD4+6XJb23+5d47X1bO3f5iDqm0/sf2X9wx5c6AK
         QAWsEseXgCT6Zk4RclneQCIMv+9G4XscIHwrqCbtc72Ijtbz1xyEkfkDmmZXuqjfprrx
         PFJP8uNv/S0IlJ3Q5+C0I7ssHYRuYK5LOwYCl2L5axw34ZasttRMrxWtn7VN7a5B7nk3
         +bcK/vmtTzoBtEZzI3nIN1fmQZ6rsNFoaxQXThf3O4tJCEQ9THqUCn7ztd6tIHkKZJOt
         sU2tUonoZSgIIcJAxRRswQJqk0vekXp5r+peGQ2Eq3fO6wCd8Et4eydhk+uwy1Gcr71h
         FFLA==
X-Forwarded-Encrypted: i=1; AJvYcCXxenOgb7hpyRL/zop7Ok331Ok1eL0Aem+GDfj7V999ro64zSJNlUZDdmA/EsG0lVKTZcAe34iAacnnr6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLTFI22jfZtgcQC9vWDkWfIP3eOktZu6a4CqwLSqNER9Xo1COM
	8pFCTs9ZOhMpKfmVL7XrZ/5u9of8coUU+gHsKwH4gAZ3rk+Rya1NfSzWwTqQ9AcyY3aMv7gP5iO
	fbg==
X-Google-Smtp-Source: AGHT+IFFoxTCAf/VBwvpKjOPtp780LvH6h9NZi2W1UhdqbZyI4z9u0aCzY3G15g7VdYrZSLAaSVeTd6UZGw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:910e:0:b0:e0b:a34d:f223 with SMTP id
 3f1490d57ef6-e116cecab95mr69092276.5.1723734999238; Thu, 15 Aug 2024 08:16:39
 -0700 (PDT)
Date: Thu, 15 Aug 2024 08:16:37 -0700
In-Reply-To: <20240731143649.17082-1-john.allen@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240731143649.17082-1-john.allen@amd.com>
Message-ID: <Zr4b1bpccYKpMUDA@google.com>
Subject: Re: [PATCH v2] KVM: x86: Advertise SUCCOR and OVERFLOW_RECOV cpuid bits
From: Sean Christopherson <seanjc@google.com>
To: John Allen <john.allen@amd.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, thomas.lendacky@amd.com, 
	bp@alien8.de, mlevitsk@redhat.com, linux-kernel@vger.kernel.org, 
	x86@kernel.org, yazen.ghannam@amd.com
Content-Type: text/plain; charset="us-ascii"

s/cpuid/CPUID

On Wed, Jul 31, 2024, John Allen wrote:
> Handling deferred, uncorrected MCEs on AMD guests is now possible with
> additional support in qemu. Ensure that the SUCCOR and OVERFLOW_RECOV
> bits are advertised to the guest in KVM.

To host userspace, not the guest.

Please add a paragraph explaining (a) what these features do, (b) why
KVM doesn't need additional enabling, and (c) why KVM can't emulate these features
in software (though this can be omitted if it's quite obvious from (a)).

