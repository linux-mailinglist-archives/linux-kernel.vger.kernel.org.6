Return-Path: <linux-kernel+bounces-299769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 984F295D9DA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 01:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 413D31F249C6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 23:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19CD179AA;
	Fri, 23 Aug 2024 23:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ADoCk1pm"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC19C149C4C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 23:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724456883; cv=none; b=Prz4T8mwuPRi0+nCRnMAlg6GM3rHTtnUsKnCFbhVB8kvB0IiAF+UDwD5I6/98FGET8KRQohzprBz34WD2oI5nHd83s/6LLROzstKIEskp9vK/D5H8VRruW8Ne0jesqWMUUn40xDFeAg2Mx/g3QFx9wEInexre9Ha/dF6pxWwrvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724456883; c=relaxed/simple;
	bh=5XmtJ+ttxT4Nha4VWrlkTnwO0YvxeSg3ElrNh99k48A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mfi3knZvW99rLcqPO5E8s2rNtTn3PUyA3YfFc/kPH0AtjLIz3LTdzWFyVqCr+OVegLjTg6RLZ1tCPzAV6bVtiMpcf2LXCxwFn3n2keZxoyx4bQqhVGFVQEVrl1y7nOQ9/WrQ2em+6ku/ejukRt2ufXTGovGlbtRvbz2o14c2iJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ADoCk1pm; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7c6a9c1a9b8so2287023a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724456880; x=1725061680; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QWl9TNT1aQv8v1R1jPYvMONnU3dZkO4ks1eiFaeIIxQ=;
        b=ADoCk1pmFykDiyfEwtbtYxu8PtoAB6fP91J+Z2cZlUoxMSiX2yvxxQ3LzKEyVWx0ip
         9j83cOpmW24VjGvsKhGN+G8/ITLrHVndg4f2uZ4gFGJ7/JiQpTOm4Na6oJrZXWKuMk2F
         c1ENcOKg7eZ+Ekxm9ywtTN8Qx0n/AS1QhDqp8oQlvtAujvddX08OpEWTap/JzsoqRLH6
         PtRaIsSbxRY8P5bFa2HTCFGurYZYiRlYDaqAFMEmodf6IbhBGDCBvGEBeZF7pKG9/AGB
         w8VmrjhQEaCG7dhEGw649ayunTLBN1UDWSoppbXsyIoQ2MMTDYnNinGwNXiaQ1jRbu5G
         AqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724456880; x=1725061680;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QWl9TNT1aQv8v1R1jPYvMONnU3dZkO4ks1eiFaeIIxQ=;
        b=hsPzMjOxREeKTipC1KG40nWmWKD6B0to6iZi/PZl1iW5R72JhjriPNdkbH2+jq5VaG
         8DWpE4nN1/fr3YCo7eeVwqc5S/3CL541j7fcTt13mXQeapIt5921n/Q1WWC315pp29nQ
         09CWndSxCg8c6TDJAZq7Ay0O46b6YY8LYWHQqHs/7/RKVkd3HlzNjC/OumAmh9raxi9m
         rM02mcFP612h57hdD2OF5wV2bSKJR/nCjYIJHoYMx7SjJPJ9IONwQwpRHVQFfDJNPhVQ
         +/QXkM2nYfL8dHlpQ/q9ljUovy62ClL59BX0NJUQLhoSU1VyBYCfiHnZvnWM1g3RTuWU
         IO/w==
X-Forwarded-Encrypted: i=1; AJvYcCVWOT+JYC7i+hkThjmBawStQuY+6GNiTtackcXOz5X2KtJwqm2wUhQ7BTcbyU8ocfp1Sw7wxgi+H+zg20s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu50OESn+HQjmHQ899EpdER+XTVH/BROxRUsvsuebFIGq1pTBs
	wp0G/pq3h7+82f3UHT0q7ELreZEZFHJlKmqrTcrEXmzp7Jokc9VIo88nnZiPXrwKHQnI9XkcQVV
	0UA==
X-Google-Smtp-Source: AGHT+IF2N1obNYfDZfwu5m+pmo9znzxpNwbLxyRSQf9o3PYyvEV1svuRtClslNgdxG2L20PJVpMD0UgmoPI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:6910:0:b0:7cd:712c:b65c with SMTP id
 41be03b00d2f7-7cf54eb7a3amr5875a12.10.1724456879752; Fri, 23 Aug 2024
 16:47:59 -0700 (PDT)
Date: Fri, 23 Aug 2024 16:47:35 -0700
In-Reply-To: <20240808062937.1149-1-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240808062937.1149-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <172443900380.4130468.16617420818094069311.b4-ty@google.com>
Subject: Re: [PATCH v4 0/4] x86/cpu: Add Bus Lock Detect support for AMD
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, pbonzini@redhat.com, thomas.lendacky@amd.com, 
	jmattson@google.com, Ravi Bangoria <ravi.bangoria@amd.com>
Cc: hpa@zytor.com, rmk+kernel@armlinux.org.uk, peterz@infradead.org, 
	james.morse@arm.com, lukas.bulwahn@gmail.com, arjan@linux.intel.com, 
	j.granados@samsung.com, sibs@chinatelecom.cn, nik.borisov@suse.com, 
	michael.roth@amd.com, nikunj.dadhania@amd.com, babu.moger@amd.com, 
	x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	santosh.shukla@amd.com, ananth.narayan@amd.com, sandipan.das@amd.com, 
	manali.shukla@amd.com
Content-Type: text/plain; charset="utf-8"

On Thu, 08 Aug 2024 06:29:33 +0000, Ravi Bangoria wrote:
> Add Bus Lock Detect (called Bus Lock Trap in AMD docs) support for AMD
> platforms. Bus Lock Detect is enumerated with CPUID Fn0000_0007_ECX_x0
> bit [24 / BUSLOCKTRAP]. It can be enabled through MSR_IA32_DEBUGCTLMSR.
> When enabled, hardware clears DR6[11] and raises a #DB exception on
> occurrence of Bus Lock if CPL > 0. More detail about the feature can be
> found in AMD APM:
> 
> [...]

Applied patch 3 to kvm-x86 fixes, thanks!

[3/4] KVM: SVM: Don't advertise Bus Lock Detect to guest if SVM support is missing
      https://github.com/kvm-x86/linux/commit/54950bfe2b69

--
https://github.com/kvm-x86/linux/tree/next

