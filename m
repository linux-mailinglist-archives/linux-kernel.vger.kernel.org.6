Return-Path: <linux-kernel+bounces-515924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E578CA36A82
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B0FE3B2E7B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FBC1FFC4D;
	Sat, 15 Feb 2025 00:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mdm7AY/A"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669281A3178
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 00:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739581013; cv=none; b=HOH6PCdKXH9X2hJ/MOgABe1wbutMVcSyL72RoWcww7bzVywwWpWGZLfBb3Kpdh6+HLVhlg0PaQxsAsj1/+dy1SEMGt1Cg+EmL6joTFemF324t7unv3SBOYqElxgJ0cQDMjuQ1z3ptiQDHtIJoCu/N2XQfwCmbq2QMQldyE2HUEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739581013; c=relaxed/simple;
	bh=SlXFcJN9gPIXQ7/UHXvc6Ej3/MtxP+TT4NMl74PBaJw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dPGDjlj6yohGrHlkiRoC/K1QUtRBf/4B0MlQkfaofrWkxW0AQ/MU8gAUJXgqXtlKxPsQfONWAlMAAOBZttVXDrmjgB3eo2xr2WebtwK19H4pnN03DYF8vQv8aX84BW3NLjSfqP02T2B7MjLJL85fAjwYQEv47p4vzOSloLGcCgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mdm7AY/A; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22104619939so9361095ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739581011; x=1740185811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XGFU0x6ME31j27M/E1QZf0SjJwI3DZIXAbtz12osBGU=;
        b=mdm7AY/Ahi8cDDpPlXzXCSCMOLctuT/JYL4z8Rd2ze8CT+wqq3WUVph9gJ15C1eDIs
         RreYOpFSZQrgNpaVdVb4XfIFV1j1BVFsvpL6Fe8sTZUl/EwmQD9TNdmGg8TBdnyspGUZ
         6Re+69G3tgqgMJ/c0BsVRvDoF6Ye3xoJcVVxD/XmKOSucu3BbOONj3fXTb+jdd+bKVkc
         X+/nISy/L5gkOAXMKzObhQZ94uLYOQyVszwU7FBJi6AcxQmjoPJPyCAMXzo23ad4yV63
         52C27hojfHiGLc9cpDjbuAzgYKT+C5fuSMvfXkGo50dzIBhg8WlavuQixSQKF/PNKemH
         2e6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739581012; x=1740185812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XGFU0x6ME31j27M/E1QZf0SjJwI3DZIXAbtz12osBGU=;
        b=mjIZm5NnFTXY+cOKgdeHRj/QGtgzEsLcm588nI3XSVOCtwxhj1SE0kCnE2NmzJvr/t
         ytHXZn7sMEmOBAq+03CDJhM3XyapcMMnuMXT1qOWeWwWGcui5x3eKwLmZI6f8MZcWyGp
         Jht5jAAxGrnixRcHUI3PVlLusnKHG5IbyJYNf9iD66X5oFhjV6tQojV9y6Q4t4GW6oEd
         e1xSpIZfQryc90tjUtZxxVkpIi2jbmVrSRqdWG7LOSAchGYhcYSqj5Cucmj8qWa9yTTP
         yquYwXWCVYCBz9dimTycmdQ4+CP4uXXZptzw55dSlgx+XkWwXoxcNOFlCUrrYZ1ZbCnu
         5UOA==
X-Forwarded-Encrypted: i=1; AJvYcCVAomwEN7pDCaIag+XWPlSgrAHUSedwSJuP3Fi6T6FuVnC8BazNIKFCvTZA1I1rnvNQUYWJ+Xb0vKuK7tQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDRTNmaeOBIIGEh5Vl3dBdvlccma1TbRSI+wJeVJQkq/RQAGzw
	4y/Jd8UZwvwwWR+DA30E7FTXPY5CWGf/xcAtsqN8zLBPKC9hDuVGVWM0hT+kB66ZEIN+czTGEe5
	BNg==
X-Google-Smtp-Source: AGHT+IGzjZ4q3ipCJ9H8WgyBye344Mufo5MgNAaVcmrLT+j8+QI69Usa/fdkwZc427X31ScOU5PG+HDtyb0=
X-Received: from pfbcz19.prod.google.com ([2002:aa7:9313:0:b0:730:7bad:2008])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:619c:b0:1e0:c77c:450d
 with SMTP id adf61e73a8af0-1ee8caab780mr2596787637.1.1739581011703; Fri, 14
 Feb 2025 16:56:51 -0800 (PST)
Date: Fri, 14 Feb 2025 16:50:39 -0800
In-Reply-To: <1739241423-14326-1-git-send-email-yangge1116@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <1739241423-14326-1-git-send-email-yangge1116@126.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <173958047445.1191117.9513441851544868586.b4-ty@google.com>
Subject: Re: [PATCH V4] KVM: SEV: fix wrong pinning of pages
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, yangge1116@126.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, david@redhat.com, 
	baolin.wang@linux.alibaba.com, thomas.lendacky@amd.com, liuzixing@hygon.cn, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Tue, 11 Feb 2025 10:37:03 +0800, yangge1116@126.com wrote:
> In the sev_mem_enc_register_region() function, we need to call
> sev_pin_memory() to pin memory for the long term. However, when
> calling sev_pin_memory(), the FOLL_LONGTERM flag is not passed, causing
> the allocated pages not to be migrated out of MIGRATE_CMA/ZONE_MOVABLE,
> violating these mechanisms to avoid fragmentation with unmovable pages,
> for example making CMA allocations fail.
> 
> [...]

Applied to kvm-x86 svm, thanks!

[1/1] KVM: SEV: fix wrong pinning of pages
      https://github.com/kvm-x86/linux/commit/7e066cb9b71a

--
https://github.com/kvm-x86/linux/tree/next

