Return-Path: <linux-kernel+bounces-542807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD68A4CDFE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 23:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1155D3AC113
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 22:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800BD2397B9;
	Mon,  3 Mar 2025 22:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xt5PQR1p"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A73239561
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 22:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741040076; cv=none; b=gGnD2oedIHGDV8BlyU0/vSL2nB6JA6yyRfOeb8lWRG2HwMuEQVjDA9k/C7THfwy48o5wPAcPJ5rYlGuTkmG2TfbbS3yR18n96NHJYGlEpV0gmc82s7FvZAbxnT0O/LA8R5jYyYZOZWV2tGWFyYE4t5UtHoI7ly5NzN5Bg530ZNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741040076; c=relaxed/simple;
	bh=5yGRsimMlo/ynCKSEzqe8MIDcA9rMI5J+4JfhPej2dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzR/Ngvw12PMRb7hhEzk1ct3FiXqoITo/9V1HJ3C0smFgaRX0NCSbNUUs0jVMJo0oCwGan9UuGItkb7sHosHDQdDnEHKoicS4OcbRQgHRC4knnmqjhuCEB00o9C9MiVRq8eiabe6OCPMHiGvdERTnms4AyaJfP6JEIj8XY9a/iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xt5PQR1p; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 3 Mar 2025 22:14:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741040071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TNQ4MdmT+tTgwaoSFCiyayCeDumi5ERILVBdb89V8X0=;
	b=xt5PQR1pZST+Ysgl+sU68aDP/D4Uj92wZMn/AgylVr+z7VCu9Js+WsNC7+5RD8Zbtb6Kja
	fDuw6+8YDfx5LCwetsSShaCgk+lUMRKa4DziO9ckx7gMWwcT3UyruAAEkRfes4fLMc6Y2b
	nceywLLA6I7hVW8YBsrCD7pJUMDDIPE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 11/13] KVM: nSVM: Do not reset TLB_CONTROL in VMCB02
 on nested entry
Message-ID: <Z8YpxLONlmy91Eot@google.com>
References: <20250205182402.2147495-1-yosry.ahmed@linux.dev>
 <20250205182402.2147495-12-yosry.ahmed@linux.dev>
 <a70458e20e98da9cd6dd1d272cc16b71bfdd4842.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a70458e20e98da9cd6dd1d272cc16b71bfdd4842.camel@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 28, 2025 at 09:17:52PM -0500, Maxim Levitsky wrote:
> On Wed, 2025-02-05 at 18:24 +0000, Yosry Ahmed wrote:
> > TLB_CONTROL is reset to TLB_CONTROL_DO_NOTHING on nested transitions to
> > L2. This is unnecessary because it should always be
> > TLB_CONTROL_DO_NOTHING at this point.
> > 
> > The flow for setting TLB_CONTROL is as follows:
> > 1. In vcpu_enter_guest(), servicing a TLB flush request may set it to
> > TLB_CONTROL_FLUSH_ASID in svm_flush_tlb_asid().
> > 2. In svm_vcpu_run() -> pre_svm_run(), it may get upgraded to
> > TLB_CONTROL_FLUSH_ALL_ASID when assigning a new ASID.
> > 3. In svm_cpu_run(), it gets reset to TLB_CONTROL_DO_NOTHING after the
> > guest is run.
> > 
> > Hence, TLB_CONTROL is reset after each run and there is no need to do it
> > again on every nested transition to L2.
> > 
> > There is a TODO in nested_svm_transition_tlb_flush() about this reset
> > crushing pending TLB flushes. Remove it, as the reset is not really
> > crushing anything as explained above.
> 
> I am not sure that we don't crush a pending tlb request: 
> 
> svm_flush_tlb_asid can also be called by KVM_REQ_TLB_FLUSH
> and set the flush request in both vmcbs, thus later the nested_svm_exit_tlb_flush
> can crush this request.

How so?

nested_svm_exit_tlb_flush() makes a KVM_REQ_TLB_FLUSH_GUEST request.
svm_flush_tlb_asid() is called when servicing KVM_REQ_TLB_* requests.

So svm_flush_tlb_asid() does not make a request in the sense of
KVM_REQ_*, it sets TLB_CONTROL or invalidates the ASID, which is can
more-or-less be described as "requesting" a TLB flush on VM-enter, but
is not the same thing as KVM_REQ_TLB_FLUSH.

So I am not sure there are any requests being crushed here.

> 
> But the patch itself does look OK to me, although I might be mistaken.
> 
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Thanks!

> 
> 
> Best regards,
> 	Maxim Levitsky

