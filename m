Return-Path: <linux-kernel+bounces-546002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC39EA4F50B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 04:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAAAB1655E0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70E0746E;
	Wed,  5 Mar 2025 03:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2vR4jVe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A76B2E337F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 03:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741143691; cv=none; b=cbZIeD0YN5an/MVSWD4hzTBnxJGt0nPPfXkznt47s1F6AZUS+2rWN6u3OQfk7lN5yTcRoIMOwzIi59MmyS17dZrQnkXwfQYVVNxqNfyfZY2lqKeSQruKHJGFbyMcewhF+IguVEDi8foy8Obeyxw81KRfpAdsI31TwbkTBYMp+P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741143691; c=relaxed/simple;
	bh=SQDr5ldeyrak0fqcgofevKyTUAamPcCphiDxThQmsj0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=avIGKUPUxF9diD3ojGhD0fGDiM6rV1uTQXOjPLCLqmpjsHflvmZApwKwdIjob+5HS7zjeVcf0XHqhmSEDu0oTXCEEa5KCosyjHC9J+MW22DpfKDgOVuz4ZMYIWTHMwKCCkKfcIMpSiiPPPt820K/m0JkT+nE///h+LZlwq+Hwfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M2vR4jVe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741143688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LXFMmu1EgcReOCw6/NPEyCwNwAPUOuUmwhoOj3Bw9K4=;
	b=M2vR4jVe0gpvAHQSBptqcX+txSnLf0mxRPa58K6sUDEH313KX5DIpHmQj/F34dBC9Rw+5g
	HbHHTU+aF5bs0BRDIn48YHPnW3KSjoLUSobn7trI7WJCz3bjRalODBfTiVMSlco4gmDrfy
	Ttw6BPKl/QuOJWVcuzW5zr3FGemsbr4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-tZdNvPoPN1KwUeqgcbKGlg-1; Tue, 04 Mar 2025 22:01:27 -0500
X-MC-Unique: tZdNvPoPN1KwUeqgcbKGlg-1
X-Mimecast-MFC-AGG-ID: tZdNvPoPN1KwUeqgcbKGlg_1741143687
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c0a8583e60so1219307585a.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 19:01:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741143687; x=1741748487;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LXFMmu1EgcReOCw6/NPEyCwNwAPUOuUmwhoOj3Bw9K4=;
        b=ZX5//ou+qt9I2bY6RyrDdVSLnxTHEVQ4U/N/L1HXz7dvwDnzg3A1rYaA6hZSvIjQgj
         VBnKAMzMZpWbaNAR2YSnqzJtTO3LyIjIpmooQ5NmkXb0w9Evi0abqmNuYLO3UO4JF0Vi
         IJs3arConLohY7IgYNQtal0cMvVu/DK3zdjE9StqxucpnHdC/LQjtPg/F0tBdjlJwVYF
         phMv6CkhNQZqPoiBJW3zFAOBJHLE/BxyfUCt23nMg1HPFmc54Fe4pFNAfinozC2ksNPg
         PyR0dDM8Rmc9ECQlxE4grlof5fIT+rqbim8V2/Hx4kEk6paCInffaXztUCi9Ctl6F6jn
         Iv8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLVJliEn9HIEWB2LwRp6DCRphA/ipJFKtGnWq1IV4Ln4c69JasgUsaErajtaL+KOVGi3ttESUsYdvDti0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw64BVCPMuT//NVwwMlksBsPVDpV5gnLazfmzt0fSxqBj0Zj/X7
	+Pds6UdpiCKXzYuBQ6+W0TbtDdHkkvUEKa+ut3G4alF2qoqrp3vyfU9nNj/72+397nyXLp5sVpM
	RQaF5f0svWm++gpCDBAZlY0wXzb4q+Y3OMVq4CxCNN8dBmL/Kx2r24GAI0PHKiVmgRxq6MQ==
X-Gm-Gg: ASbGnct2gGMfCroU3YuJshMMgjCKYp5g4QP3QMy4JQgKj+y5Qc4EKMkMlqFKvLcDwDu
	YQXWQeoVIFJKfNjWciN2oeGCvcTUhPd0Txzk/WCcpRT4pX7Wq5tR6lLoFKA/TufiXs7BJAlNBnd
	lbo8yS5X25xDbmqtyZJxxGiz9FpFvqslyKh/Wz/B4u7hAhLLOeKxS7cDPLIwQmtJNapmvfwGkSc
	XbAM+4ep3AEQawIHgeh0/kcfWn+0tWA/S45hwZwZR/3ostISj72wEQEdKnNZ+GFMbwWfntp1lJD
	zvoYh6kTplnLz/0=
X-Received: by 2002:a05:620a:8082:b0:7c0:7eab:64a1 with SMTP id af79cd13be357-7c3d8ef3013mr310968485a.48.1741143686738;
        Tue, 04 Mar 2025 19:01:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiUQqBZbHKRH29Clw9QqtOwZBLjg2B9QS4anWF5COImXioekphqyo3RllkC40LZOUKPHUGWA==
X-Received: by 2002:a05:620a:8082:b0:7c0:7eab:64a1 with SMTP id af79cd13be357-7c3d8ef3013mr310963385a.48.1741143686408;
        Tue, 04 Mar 2025 19:01:26 -0800 (PST)
Received: from starship ([2607:fea8:fc01:8d8d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3c880f022sm246398085a.3.2025.03.04.19.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 19:01:26 -0800 (PST)
Message-ID: <6345e31c7973a2ec32b11ed54cede142a901044e.camel@redhat.com>
Subject: Re: [RFC PATCH 11/13] KVM: nSVM: Do not reset TLB_CONTROL in VMCB02
 on nested entry
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 04 Mar 2025 22:01:25 -0500
In-Reply-To: <Z8YpxLONlmy91Eot@google.com>
References: <20250205182402.2147495-1-yosry.ahmed@linux.dev>
	 <20250205182402.2147495-12-yosry.ahmed@linux.dev>
	 <a70458e20e98da9cd6dd1d272cc16b71bfdd4842.camel@redhat.com>
	 <Z8YpxLONlmy91Eot@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Mon, 2025-03-03 at 22:14 +0000, Yosry Ahmed wrote:
> On Fri, Feb 28, 2025 at 09:17:52PM -0500, Maxim Levitsky wrote:
> > On Wed, 2025-02-05 at 18:24 +0000, Yosry Ahmed wrote:
> > > TLB_CONTROL is reset to TLB_CONTROL_DO_NOTHING on nested transitions to
> > > L2. This is unnecessary because it should always be
> > > TLB_CONTROL_DO_NOTHING at this point.
> > > 
> > > The flow for setting TLB_CONTROL is as follows:
> > > 1. In vcpu_enter_guest(), servicing a TLB flush request may set it to
> > > TLB_CONTROL_FLUSH_ASID in svm_flush_tlb_asid().
> > > 2. In svm_vcpu_run() -> pre_svm_run(), it may get upgraded to
> > > TLB_CONTROL_FLUSH_ALL_ASID when assigning a new ASID.
> > > 3. In svm_cpu_run(), it gets reset to TLB_CONTROL_DO_NOTHING after the
> > > guest is run.
> > > 
> > > Hence, TLB_CONTROL is reset after each run and there is no need to do it
> > > again on every nested transition to L2.
> > > 
> > > There is a TODO in nested_svm_transition_tlb_flush() about this reset
> > > crushing pending TLB flushes. Remove it, as the reset is not really
> > > crushing anything as explained above.
> > 
> > I am not sure that we don't crush a pending tlb request: 
> > 
> > svm_flush_tlb_asid can also be called by KVM_REQ_TLB_FLUSH
> > and set the flush request in both vmcbs, thus later the nested_svm_exit_tlb_flush
> > can crush this request.
> 
> How so?
> 
> nested_svm_exit_tlb_flush() makes a KVM_REQ_TLB_FLUSH_GUEST request.
> svm_flush_tlb_asid() is called when servicing KVM_REQ_TLB_* requests.

I am probably missing something but:

Suppose KVM_REQ_TLB_FLUSH is raised and then processed while ordinary L1 entry is happening,
but nested state is allocated.

(KVM_REQ_TLB_FLUSH can be raised anytime MMU wants a 'big hammer flush everything')

In this case svm_flush_tlb_all will call svm_flush_tlb_asid on both vmcbs (see patch 8),
and that will set TLB_CONTROL_FLUSH_ASID in both vmcbs.
In particular it will be set in vmcb02.

Later, maybe even hours later in theory, L1 issues VMRUN, we reach nested_vmcb02_prepare_control,
and crush the value (TLB_CONTROL_FLUSH_ASID) set in vmcb02.

I think that this is what the removed comment referred to.


Best regards,
	Maxim Levitsky

> 
> So svm_flush_tlb_asid() does not make a request in the sense of
> KVM_REQ_*, it sets TLB_CONTROL or invalidates the ASID, which is can
> more-or-less be described as "requesting" a TLB flush on VM-enter, but
> is not the same thing as KVM_REQ_TLB_FLUSH.
> 
> So I am not sure there are any requests being crushed here.
> 
> > But the patch itself does look OK to me, although I might be mistaken.
> > 
> > Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> 
> Thanks!
> 
> > 
> > Best regards,
> > 	Maxim Levitsky



