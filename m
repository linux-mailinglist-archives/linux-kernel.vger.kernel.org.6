Return-Path: <linux-kernel+bounces-184301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5999D8CA50B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 01:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764A81C2111D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 23:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEC0137C35;
	Mon, 20 May 2024 23:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hNRpjyhh"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4698D3B182
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 23:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716247928; cv=none; b=PDrmHbdSChjzDl0RFxA+k6GwDjbFg+FmZPJ7vFnx8LRK/p/VraFn9/qh0bBg3DTdlus9CgMaSTQki1dGh2nE6CwjWMyA7706xXEFQ2rCeGh0Ao6WJ/gdsck2a5KkBSffE0UsK255U/QyffuplnsBk+i+8UWaMZldXSuhyYGEiz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716247928; c=relaxed/simple;
	bh=ZBuoeLjCXiwjV3rclTemVVqArtOGdRIkGSdSqm05UzQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pQqkaDYo5iq7G4pfYrBa7JArKKWLOEpAeQBRBm6K2OgPQrQtezH1ieM42Po1tnDeDt6h4H/j1wniWm3fVMhxdO7P2OssBNpuF6j4b/cIHAThYcmR8lpU78+07ZX15PuQt2GE6NlLV/Q2l1d5+9O0R8CTl0Xb3cZgdCFX8GLfhxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hNRpjyhh; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61dfa4090c1so191126537b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 16:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716247926; x=1716852726; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aS0XH6Tb4WcsUqiFIaMv84vx9SLp2OhPDgLmCz3P4Jw=;
        b=hNRpjyhhKWbxXIUSbF4n9+qgWfr4M88sroSlyN3PBpmtSHMzqhO7Q9T+Zso2rUlrGw
         p4m0XbPnpFifMma9LVnEsQemMkxV1wkZsF2i33uUoLIwOXdpJjFiZO2x09kBKOZRaY+2
         /6vUW0dt1bhBmJhQC7rQj6OHE+PWVnRN0zRca9UhzP0SwzNv9dG7DoFiuJlxAU5jMluP
         WoWlaumnBrAsGWz/lE07pKDFgqqUrbxAlZ70XIMsUOO+khHsbp0Psgfjv4v87kTV7r7Y
         44K9OJleW4XLg/0NJZwLCmwN+sens0T0+l+2iLz6coQRG/kfiJSHUICHI2nNmT8DDwh8
         VbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716247926; x=1716852726;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aS0XH6Tb4WcsUqiFIaMv84vx9SLp2OhPDgLmCz3P4Jw=;
        b=fxUhaphFMz2YtFSEBYwBS4cI/Bf3AYE7lICvTW25PDiGUCy2wUpLMIbFTT1id7ocpD
         yLbTQIpD30JK571+wTmeytVJQh/pzQiZ4ajpWDBXGRO6f1rR+ZLMLJnbfSBaxUe9JGZE
         EItwi4AOHwTTEPUUcM1Uto68EgntF/1oa9DQe3GUavKfwYwp+BbyChbpnfQR54H6in99
         YsBV8LiwIzirqn8w4fV0h7ygFFx0TR8xj1H/sZL+nzRWQbjHV+7anODUrGIS8tCDSl4t
         LkQbGL3NPAAqUeXazQcSU6Z8yvgQlmPX+C698LLJKVeCMW8aMveJzpJvzzdwCx26Du5S
         u8FA==
X-Forwarded-Encrypted: i=1; AJvYcCWgNqjFAX4sQd4f3WZMgKmU0dASdcRjpPGLjyJMFEzy6Ad+iJ3Wkp+aTNoaX56sjTXs7kwVCBKT1oae5uHG2cPfMbN80oWX4yNEFlcC
X-Gm-Message-State: AOJu0YwaRxHyuGhfLOL0YiVMSl9CAq6ZeqwlZo6oj2BLD8/bdIlRF9Nk
	5sewhj8Dj/pOgEfP3hzrnj94EiAmIoPXaROrYAGkEAHeC1qLjj4Fzj3l3YeQwrqMD0PiIpIVLRG
	0LA==
X-Google-Smtp-Source: AGHT+IGaoW/2hokO/MC516axosurqiUtR/W8NYPK1SWbi3CPeHN5ZuAb4i88WwS40Pjq01PeOQ+2rJObaVY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:83c2:0:b0:de5:78:34d2 with SMTP id
 3f1490d57ef6-dee4f35c14amr2922883276.6.1716247926369; Mon, 20 May 2024
 16:32:06 -0700 (PDT)
Date: Mon, 20 May 2024 16:32:04 -0700
In-Reply-To: <iqzde53xfkcpqpjvrpyetklutgqpepy3pzykwpdwyjdo7rth3m@taolptudb62c>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <58492a1a-63bb-47d2-afef-164557d15261@redhat.com>
 <20240518150457.1033295-1-michael.roth@amd.com> <ZktbBRLXeOp9X6aH@google.com> <iqzde53xfkcpqpjvrpyetklutgqpepy3pzykwpdwyjdo7rth3m@taolptudb62c>
Message-ID: <ZkvddEe3lnAlYQbQ@google.com>
Subject: Re: [PATCH] KVM: SEV: Fix guest memory leak when handling guest requests
From: Sean Christopherson <seanjc@google.com>
To: Michael Roth <michael.roth@amd.com>
Cc: Michael Roth <mdroth@utexas.edu>, pbonzini@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ashish.kalra@amd.com, thomas.lendacky@amd.com, 
	rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="us-ascii"

On Mon, May 20, 2024, Michael Roth wrote:
> On Mon, May 20, 2024 at 07:17:13AM -0700, Sean Christopherson wrote:
> > On Sat, May 18, 2024, Michael Roth wrote:
> > > Before forwarding guest requests to firmware, KVM takes a reference on
> > > the 2 pages the guest uses for its request/response buffers. Make sure
> > > to release these when cleaning up after the request is completed.
> > > 
> > > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > > ---
> > 
> > ...
> > 
> > > @@ -3970,14 +3980,11 @@ static int __snp_handle_guest_req(struct kvm *kvm, gpa_t req_gpa, gpa_t resp_gpa
> > >  		return ret;
> > >  
> > >  	ret = sev_issue_cmd(kvm, SEV_CMD_SNP_GUEST_REQUEST, &data, fw_err);
> > > -	if (ret)
> > > -		return ret;
> > >  
> > > -	ret = snp_cleanup_guest_buf(&data);
> > > -	if (ret)
> > > -		return ret;
> > > +	if (snp_cleanup_guest_buf(&data))
> > > +		return -EINVAL;
> > 
> > EINVAL feels wrong.  The input was completely valid.  Also, forwarding the error
> 
> Yah, EIO seems more suitable here.
> 
> > to the guest doesn't seem like the right thing to do if KVM can't reclaim the
> > response PFN.  Shouldn't that be fatal to the VM?
> 
> The thinking here is that pretty much all guest request failures will be
> fatal to the guest being able to continue. At least, that's definitely
> true for attestation. So reporting the error to the guest would allow that
> failure to be propagated along by handling in the guest where it would
> presumably be reported a little more clearly to the guest owner, at
> which point the guest would most likely terminate itself anyway.

But failure to convert a pfn back to shared is a _host_ issue, not a guest issue.
E.g. it most likely indicates a bug in the host software stack, or perhaps a bad
CPU or firmware bug.



> But there is a possibility that the guest will attempt access the response
> PFN before/during that reporting and spin on an #NPF instead though. So
> maybe the safer more repeatable approach is to handle the error directly
> from KVM and propagate it to userspace.

I was thinking more along the lines of KVM marking the VM as dead/bugged.  

> But the GHCB spec does require that the firmware response code for
> SNP_GUEST_REQUEST be passed directly to the guest via lower 32-bits of
> SW_EXITINFO2, so we'd still want handling to pass that error on to the
> guest, so I made some changes to retain that behavior.

If and only the hypervisor completes the event.

  The hypervisor must save the SNP_GUEST_REQUEST return code in the lower 32-bits
  of the SW_EXITINFO2 field before completing the Guest Request NAE event.

If KVM terminates the VM, there's obviously no need to fill SW_EXITINFO2.

Side topic, is there a plan to ratelimit Guest Requests?

  To avoid the possibility of a guest creating a denial of service attack against
  the SNP firmware, it is recommended that some form of rate limiting be implemented
  should it be detected that a high number of Guest Request NAE events are being
  issued.

