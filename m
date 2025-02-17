Return-Path: <linux-kernel+bounces-512028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE798A332F1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 23:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B5E17A2EC6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 22:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D2821129D;
	Wed, 12 Feb 2025 22:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0+oa/YGN"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76E22036E2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 22:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739400944; cv=none; b=saX+B4IfMc84tYCZ00n1Ycx0MpwfEtpTO0uSAXYi4oFzykfwQjMvhTBEnliSLKRJhzcVsgfkZ0SgP3l+4wLKgDhBrBS+UYzaa3xaTBnA/VMy59Qhme4K1XkXgqCsueVoi9XR9uSZh+3opBHNjdSW5hPrZSqbAtN/EZhKE5tOSAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739400944; c=relaxed/simple;
	bh=M/JEAtm/aKqZQpUcIkbOx1V5MbhNPluJ7A9OR2+JsF8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O0tj4trzwKlFwT5YsZV3sjHzRY/nfNqk665saiv+a0+h7Bby6xqy+C+fllEjt4km1Jgyu1SYp3Qh0U9Y/6vKgOd9BcgknhKye6Q/n2W/b+mv9ekK3P5DwxNWu6STYhGdK1vg3NkdnbZFx6+2lgBjcEd/gjZJl1k3ARG9kiRo80s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0+oa/YGN; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21f022fc6a3so5009065ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 14:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739400942; x=1740005742; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G4pJwe4WBZK7j0Qn81lTWodsKOqME7mNPJqkDCUIDvw=;
        b=0+oa/YGNFhfNfAvc1DakAtTUGsb5fIjUlQ8FgLTRkg4g1oQyavX/X3Goe3VKnShPef
         sathwRfPc14c/SS/26TodPkSpcyzfl3XYEr9eD3+NKhZ05MA8IpZOeWBer9yGZdhkcZg
         vYzPXJsuWtL36f/RQOOZ6ZGR0NpUaTqI7oN/qOUKlOn8bvDfB5QLFBFv0wQAHb7EYZZh
         kMeayyeRT8PqJE3MHyteMkdaI14XvZfIVt0dUvMYtIEAGznLN65J37HiJGuZe3Ih2/nK
         SaRuIN8GhT2SwQG9cLxEL2bY5wKx/5x8+sumghXwYfj0es1OJMTZcsxVPzpCpT8g64ko
         5HHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739400942; x=1740005742;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G4pJwe4WBZK7j0Qn81lTWodsKOqME7mNPJqkDCUIDvw=;
        b=V5uztmNRM1LxwAaQcWFKczPH14P37k+pRx1cIzACdkJkR8l8yuTLHqOhq1+I0KQ1CL
         cAf2YvTMrGuTw9yXdfKVwUv7i/mjg2/qtqbx+hnrmSck99DzvRXEswESkHbTS1V/ps5F
         tkLOtL6f3sfxCMSimH68XqE7naJzuCLCw6Hr9gtnUxIADNgrKVSRy+n0uNAzjjtZYDOu
         WbX+S/Tzceo0EZ1u1KHED9WbPbQgsacU/UllGLE//5pgL1j+0nuggrnkvxNDgOkE6uZT
         VqYCV1FGGdGmEqgibhSrvxS+6/fG9CswLioz4bCz8F4wUddKnwyZt7P0iel6ot7ldPlM
         Egbw==
X-Forwarded-Encrypted: i=1; AJvYcCXPCtVO6Y+3P6VePeRTR4fE4g5h26nGMdRVv53Aa1bq+hIU1O4CvUpPPjNzIKZQnpehycK1FYuk938Lp5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiK50NV5ZsUva7ZAXY5RCWCmH3LwXVtJ1DDwKRoSneCa8kT+MJ
	9oCquf1LH9cxQ8Xv7wog16vTvm1mnI9+4po6yT5uTFuRYYeTMLBZAXcMr2ClP7cjmz+Lizh/ZNH
	dBg==
X-Google-Smtp-Source: AGHT+IFCvprC2FVz2MYwofAu+gOZ+t6GzfO0x6W16EewccF+NjWJufThiJaaDpuXjWvbsRckLewQnEmSOUI=
X-Received: from plbb4.prod.google.com ([2002:a17:903:c04:b0:21f:14cc:68b0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c94e:b0:220:c2bf:e8ba
 with SMTP id d9443c01a7336-220d3528cc9mr11030295ad.14.1739400941927; Wed, 12
 Feb 2025 14:55:41 -0800 (PST)
Date: Wed, 12 Feb 2025 14:55:36 -0800
In-Reply-To: <SN6PR02MB4157DBAF1E3BB0E4FFD2C92DD4FC2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250201021718.699411-1-seanjc@google.com> <20250201021718.699411-17-seanjc@google.com>
 <Z6ZBjNdoULymGgxz@google.com> <SN6PR02MB4157A85EC0B1B2D45CB611FAD4F02@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z6onnUthSBUVAklf@google.com> <SN6PR02MB4157DBAF1E3BB0E4FFD2C92DD4FC2@SN6PR02MB4157.namprd02.prod.outlook.com>
Message-ID: <Z60m6NiOlCmy4-q0@google.com>
Subject: Re: [PATCH 16/16] x86/kvmclock: Use TSC for sched_clock if it's
 constant and non-stop
From: Sean Christopherson <seanjc@google.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Nikunj A Dadhania <nikunj@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 12, 2025, Michael Kelley wrote:
> From: Sean Christopherson <seanjc@google.com> Sent: Monday, February 10, 2025 8:22 AM
> > On Sat, Feb 08, 2025, Michael Kelley wrote:
> > > But I would be good with some restructuring so that setting the sched clock
> > > save/restore hooks is more closely tied to the sched clock choice,
> > 
> > Yeah, this is the intent of my ranting.  After the dust settles, the code can
> > look like this.
> 
> I'm good with what you are proposing. And if you want, there's no real need
> for hv_ref_counter_at_suspend and hv_save/restore_sched_clock_state()
> to be in the #ifdef sequence since the code has no architecture dependencies.

Right, but because they will be local/static and there are no users outside of
x86, the compiler will complain about unused variables/functions on other
architectures.

