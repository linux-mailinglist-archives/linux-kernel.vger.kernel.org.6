Return-Path: <linux-kernel+bounces-169983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 429048BD02D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6A4728B46B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F3313EFE8;
	Mon,  6 May 2024 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vrUEveH+"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096A913E41B
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005320; cv=none; b=DRXQrXClQijP998tGaBdMSxkNT4AvwtuuE+KKgdbZtChWOenIatsOzHC2HlTCESYlR6KDZw1ze7Xz9SDjNlFRebc34IwgUP27u0UtyKy3ZZ7TbXXnQ8+xNENWSjlDnZFoyz0MsX1YOzBN1gEVFaLq1jTj/kXwZrcrwKDjbj0uH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005320; c=relaxed/simple;
	bh=5uhwdi1y3SDOCg/HBqp8e6jB1UB0i90gEw/5RzowvJM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nh3V4acwkDKJndSBQcHKYW6PRryKekpPXUdbvubsCyWla1k8NX50FTcArJT53sfzCc7xjAoxZQ4Ic+RVC6qIw8HzzIIVSYH52gTmlPzx0riCZSbO9XvoCHRlCEza9M2A1EmCM7rvX6S1OcL9weXMIb65EgJUM1pryTjI4PG6BXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vrUEveH+; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1edf507b9e4so13723105ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 07:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715005318; x=1715610118; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0tD0TbCxCaI9AdeqFysPl2S3AZ8t1dkAhioOOzzL9ik=;
        b=vrUEveH+dbuA5Q5+xTI7Kbda01r6wK1iMzYHtdWsKeoAct0iUw/SK/eA3hRq7Kn9IO
         TJwADM+ztefEz4DDTIMrTJSrDCwKoj/ANZDB650JhW9cy4K9iOdB+t0/P01aYHzXEvF0
         rPYoc8PYHcja1EWrvOPOoRjLdjvmWDqO737nH/7HWQSnYi+5jNkmu+ND4DU7kT3ihioM
         KFiorzhU8F5QLmJT0HRMAjW6f4VbQJxykV6/AUrlqjfaD7cbUjlar6D9chdVqI8QRvTt
         pAJIApmlhFJJ2iNUgnfeXyCKk9RW68qF8Hyi7vGrtNwOqu81CrKFP5wIp6sqYL6ZfAF0
         9IFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715005318; x=1715610118;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0tD0TbCxCaI9AdeqFysPl2S3AZ8t1dkAhioOOzzL9ik=;
        b=wgBiiNNJS0PPT/lBkObswv+tpaPRopWot/qtAWLKgOdBaowoSE0zup/pSv39MMG5AB
         L6iXB/VwS2px8Hi9PZzK4z6loRaZQV2gnrjus1Wpu/h+GqDGSlMhqlgGhI6S+2k+AA2P
         I8XKFLO41+Cjx9V23KAwyyRu2v3NEI53id4zSnGh4dXD/i6YhWH5fQqPkIxgsTTE+WP3
         EUPkUe/ZoJf5NckKgfSksSHUe2LZtw/gkQ4v51KpuMSJmGIUC64ubXB6xFtONmVZ9O4q
         HeoBYz4UytNiOwMAOpRNjV3NLmJBKahaJ0wneZ29Begjzx4Wzpa8f22eviEf/ubJkV1+
         o8Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXR5D9+i0QUEn0UwveVuYZmCgjsy8glMdYr4cOpfsaApgYqd8nqKwfTSLJwgIgpHqDolMx5N3j9/dvBUtJ0khW9vhtpx8E8FXBAXQxq
X-Gm-Message-State: AOJu0Yxye8CYHLCJup6sf/C4qf4lhNw9zJXfiLPWdw6CakQ5I3SGuRk1
	ssNxODwBhEfxSvEYYeXQNWuqhY/K2h3R5GtKaD7F2cqJYtm2lda4Wp5MjtpQOe0hcWsGwGf9pAy
	rkA==
X-Google-Smtp-Source: AGHT+IFIfK+eqnhmcLSPMAG/2/9f1SQvL+KnYDknKQLvZL6gpVpiqXrA/TZdD9ucj2QznvP7LERttljKVPg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2352:b0:1e4:5973:dbdc with SMTP id
 c18-20020a170903235200b001e45973dbdcmr410280plh.7.1715005318377; Mon, 06 May
 2024 07:21:58 -0700 (PDT)
Date: Mon, 6 May 2024 07:21:57 -0700
In-Reply-To: <ZjiE+O9fct5zI4Sf@chao-email>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1708933498.git.isaku.yamahata@intel.com>
 <f05b978021522d70a259472337e0b53658d47636.1708933498.git.isaku.yamahata@intel.com>
 <Zgoz0sizgEZhnQ98@chao-email> <20240403184216.GJ2444378@ls.amr.corp.intel.com>
 <43cbaf90-7af3-4742-97b7-2ea587b16174@intel.com> <20240501155620.GA13783@ls.amr.corp.intel.com>
 <399cec29-ddf4-4dd5-a34b-ffec72cbfa26@intel.com> <ZjiE+O9fct5zI4Sf@chao-email>
Message-ID: <ZjjnhfI1vvhdRWGK@google.com>
Subject: Re: [PATCH v19 101/130] KVM: TDX: handle ept violation/misconfig exit
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, isaku.yamahata@gmail.com, 
	Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com, Sagi Shahar <sagis@google.com>, 
	Kai Huang <kai.huang@intel.com>, chen.bo@intel.com, hang.yuan@intel.com, 
	tina.zhang@intel.com, isaku.yamahata@linux.intel.com
Content-Type: text/plain; charset="us-ascii"

On Mon, May 06, 2024, Chao Gao wrote:
> On Wed, May 01, 2024 at 09:54:07AM -0700, Reinette Chatre wrote:
> >diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> >index 499c6cd9633f..ba81e6f68c97 100644
> >--- a/arch/x86/kvm/vmx/tdx.c
> >+++ b/arch/x86/kvm/vmx/tdx.c
> >@@ -1305,11 +1305,20 @@ static int tdx_handle_ept_violation(struct kvm_vcpu *vcpu)
> > 	} else {
> > 		exit_qual = tdexit_exit_qual(vcpu);
> > 		if (exit_qual & EPT_VIOLATION_ACC_INSTR) {
> >+			union tdx_exit_reason exit_reason = to_tdx(vcpu)->exit_reason;
> >+
> >+			/*
> >+			 * Instruction fetch in TD from shared memory
> >+			 * causes a #PF.
> >+			 */
> 
> It is better to hoist this comment above the if-statement.
> 
> 		/*
> 		 * Instruction fetch in TD from shared memory never causes EPT
> 		 * violation. Warn if such an EPT violation occurs as the CPU
> 		 * probably is buggy.
> 		 */
>  		if (exit_qual & EPT_VIOLATION_ACC_INSTR) {
> 		...
> 		}
> 
> 
> but, I am wondering why KVM needs to perform this check. I prefer to drop this
> check if KVM doesn't rely on it to handle EPT violation correctly.
> 
> > 			pr_warn("kvm: TDX instr fetch to shared GPA = 0x%lx @ RIP = 0x%lx\n",
> > 				tdexit_gpa(vcpu), kvm_rip_read(vcpu));
> 
> how about using vcpu_unimpl()? it is a wrapper for printing such a message.

This isn't an "unimplemented" scenario in KVM, this is a "hardware is broken"
scenario.  Just WARN_ON_ONCE() and move on.  Or I suppose since EPT misconfig
needs to do something as well:

		if (KVM_BUG_ON(exit_qual & EPT_VIOLATION_ACC_INSTR, vcpu->kvm))
			return -EIO;

