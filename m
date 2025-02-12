Return-Path: <linux-kernel+bounces-511442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 871D5A32B20
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36587188B9F6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C818721D00B;
	Wed, 12 Feb 2025 16:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KHBef9CA"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4042214A8F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739376293; cv=none; b=uzfy8yVfKKaak5CYdkulSqf072OD49+uddXgK5c9nvoHDcloTHxiEpB5MJmqn1tagHAVuni7V04qQ+G1t0dcnt2/O2wN2h7ABEx/SVOWsupg4LVybc12EDCrxmDHKmzJYJ4+nTbOejbXamCbAz8dQ4bPreZpRY8Tfq4rAgWn4N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739376293; c=relaxed/simple;
	bh=NmzLQzFKXvhFskOCjjqBKviihBT9AfHk++iD0dssIzo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UQqNxGy+UWxniSZGfqZ+cIZs9fH4t8piU0lU9w8tFmkURqzfijCAD4J+sWLUEErDyg9TrmUrhYroKCj7jqHjwKutvIrDmdHsI1hE1LIq4AGdvIdqMeCqoVBc3TYpqui7XRehm3OJUGQWcEXbfvurZ4+WovLtdqBLMaRCZ0+OmnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KHBef9CA; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc0bc05afdso373250a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 08:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739376291; x=1739981091; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mxDpwzF3oSIYBs9IOM30KyF5GcRmnvWFEjcXTbytzeo=;
        b=KHBef9CA6fqVDCBKAwbx/5j/6eo/L9LUqZ2K1LQ1pWjw6fHhV3h8ClUVrrF/9R8Dvd
         /+VQCWxxg2hBUa4B0O03QE1uRgX3/GBJoiE21PM2vS9FLT71EBvuXEvO+5CE8gEpO2EC
         rFGm9+YB2bbFWNrLrEpROF3SUQKdH5JMqr7qtGavyMvGkLDVhw+A32xZskXU2UZr95NT
         XXUOzkIxyfxxbyQgrSnW/XwqyYbaiLKsq9CMLHzTIVjmRbxecxeeBj17XhRM6fAAp9mm
         5rN80yaVICvKAgV1DEUx65qHlmtnfoGROZegqSFTz7uWlY3Exn1C//fmXSbyGbIS6Ci2
         aflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739376291; x=1739981091;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mxDpwzF3oSIYBs9IOM30KyF5GcRmnvWFEjcXTbytzeo=;
        b=f2Bq6DjNG7rSsoyLXLgaRhxK+edX8PuhtS4wUzAzXcpuPOLTWTYCuK91qvlkI1m5t1
         SqmUxq1vFaFX6xbjq3uqNhhBO2E34QFiIsbqqih1r2KyFxSmpJoBsy+0JlAxlGRDKh+a
         ny8fQjMIaA+vl8JYO1zv3k/YaD7IfgVNC5CTQ9iUpG5n378pMMETCG5K4Evo+mcmHlFx
         AaXpwDbeaOAxbjMvef68lSpIfbR7doBkEtU3mvQ4/N7KSj2tg6IA/H51j5c8h7BfLw+n
         qf8SrbqKYniJtL0XHiJRXWe+Ve5jIOXdvMr23m6sVimy5jXfnO6Ie9A9Q5qAR255gEfE
         Ou3g==
X-Forwarded-Encrypted: i=1; AJvYcCXDrt2Ma54bLS+n8tTr+hSpZ8lm0wye5JGUsHX9RbrdajcnJpG5cSmKYA4r7OC3F5L1mwRqpYwCNZO8SIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnLXoghI0XJOeCxn7A3/2L9xXa3xtHp6cljqhEp7mxTziE57rl
	jiXjdy+gnPYU1iivExuRToGNxGladAtLt101vBhFXnp5d9YpL1HdqbZMuObBrt+4czIo9oq71uk
	tfA==
X-Google-Smtp-Source: AGHT+IEmRAJyV/ANd8QfM7g0vUcfibZGzEn9vZOPuIVFLpYIO0OpS5hr9zHniIsO7EEhFmPhtZLhxzxG7p4=
X-Received: from pfjg17.prod.google.com ([2002:a05:6a00:b91:b0:730:7708:d63e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1910:b0:730:8d0c:1064
 with SMTP id d2e1a72fcca58-7322c411b6bmr5933258b3a.18.1739376290965; Wed, 12
 Feb 2025 08:04:50 -0800 (PST)
Date: Wed, 12 Feb 2025 08:04:49 -0800
In-Reply-To: <Z6xX6PCjW0PZe59D@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250211025828.3072076-1-binbin.wu@linux.intel.com>
 <20250211025828.3072076-2-binbin.wu@linux.intel.com> <Z6xX6PCjW0PZe59D@intel.com>
Message-ID: <Z6zGoXjONvY8wOgG@google.com>
Subject: Re: [PATCH v2 01/17] KVM: TDX: Add support for find pending IRQ in a
 protected local APIC
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Binbin Wu <binbin.wu@linux.intel.com>, pbonzini@redhat.com, kvm@vger.kernel.org, 
	rick.p.edgecombe@intel.com, kai.huang@intel.com, adrian.hunter@intel.com, 
	reinette.chatre@intel.com, xiaoyao.li@intel.com, tony.lindgren@intel.com, 
	isaku.yamahata@intel.com, yan.y.zhao@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 12, 2025, Chao Gao wrote:
> >diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
> >index 7f1318c44040..2b1ea57a3a4e 100644
> >--- a/arch/x86/kvm/vmx/main.c
> >+++ b/arch/x86/kvm/vmx/main.c
> >@@ -62,6 +62,8 @@ static __init int vt_hardware_setup(void)
> > 		vt_x86_ops.set_external_spte = tdx_sept_set_private_spte;
> > 		vt_x86_ops.free_external_spt = tdx_sept_free_private_spt;
> > 		vt_x86_ops.remove_external_spte = tdx_sept_remove_private_spte;
> 
> Nit: I think it would be more consistent to set up .protected_apic_has_interrupt
> if TDX is enabled (rather than clearing it if TDX is disabled).

I think my preference would be to do the vt_op_tdx_only() thing[*], wire up all
TDX hooks by default via vt_op_tdx_only(), and then nullify them if TDX support
isn't enabled.  Or even just leave them set, e.g. based on the comment in
vt_hardware_setup(), that can happen anyways.

https://lore.kernel.org/all/Z6v9yjWLNTU6X90d@google.com


