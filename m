Return-Path: <linux-kernel+bounces-428238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D2A9E0D67
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41774B84940
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD761DE3D4;
	Mon,  2 Dec 2024 19:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xsSWx4Js"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F6876C61
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 19:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166464; cv=none; b=GAN7n9TSxF714+6ewEMlxy274u/0MjvWCF/j02Xy9QM92VlhWpG9Bw4W4+JRMcweQ8aVJKwi+pQY7oRJNi/ave/Y1oj2KnEZ/+x+jTiA6oMhJuboQAa0VsS0UQoFc4s1ygt4aFXVPWyyTrWIt7YiO9M5MSmLsHn8PR5qYVoGQYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166464; c=relaxed/simple;
	bh=eZeUWyQnbISm+A7sbCRv2KxxRc4eAE23QOrYfcw8PlY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jPaYLQ/UNToIKrbiKHkSg1ylUg7RN5394PeKH6Ng+UcA6CkBAwR5tvvMxtv/fUlwR1EPahp/TFbu3zjI3cIzQv8AfET65dS0KcGTpbcy8aKF9AAuKfyTnNzT3yRCXjG0Ab6oHwnpt2deNf8cimYMIkjo11w3cPPTlxWLGC5jxxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xsSWx4Js; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ee76edbb51so2690935a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 11:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733166462; x=1733771262; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cTqwgSFBoFZeln48ZGVBr7xveutEqQ+YeakPJKn979s=;
        b=xsSWx4Jsi6Khul2qEKEMR+YRm38z84GP9TQkPnFOsTdBdt/8K0qALFmNEBWxJHM9ON
         HMe8kQ/HD9P88T2CQc1Dj39y4utmD7nf5uwiTJ0sSlmmJ5J1u/sS70xXAMlaS5tY6D/1
         +YiyaOcQ8E5OQf7TG7/hwQ8WA/6L7+g3OrJZWGO/xZoM6/hHlSrZs6qassHWX4lzkgfK
         XFCreBSqhWIKZtDRNnpBM/38D104GNZJeRUFEmPvwo0yjCAPwDQ3BBF28sSrirkRA2AX
         qgZnLhIgVgldX5MvtOs03m7+Seh1jJi2EYuZYdTRvPXFz2VG2QUEYhdAiTB6ZKm156ZZ
         iwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733166462; x=1733771262;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cTqwgSFBoFZeln48ZGVBr7xveutEqQ+YeakPJKn979s=;
        b=jHcwG6M16YgoBbDMbxgQ0CDjqdWjrmqdurNsURrsQouZg7bTa4U6rcd6RT2M94IEtF
         9Fs9CRm18Ihiek3Dn3+ZFQHXBspfYH0eMW0Tjo8VLicLgoCda1u+maxUV23KoohD0c7e
         Q2SQJlzlIj+CUW0dH4RpxP6cn0sxbtdy5J/kCDNMraDxuSIkmr2Pyk39VeBwBIvK+ePb
         0EyFadM+ycw2uFuq50v9JY6N8mtz6MyA0iRD0D6mvSZG57ODVfzWxCMEkoG+aQAAwGzc
         /OeBMhtGGlz+iKTW12Jv1bbwF0G7dISRp2ZaUlP/rjKknLhzoT2ezCjou2C+98HAKWzL
         v8VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVll/78qYFkyE9PORZcPH337LYKzt1EUAIhbUDwJjITlSe0DH+0/fXd+fDMUurrE74bHs/qPVDmGLQ7i68=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpjmP3oMOzhE+7hnBnY4VHshkMYOjkAfyJ5RUcz4FPH82Z29nG
	NSAEPH22n3fS53nC4K6TKMkUltb1YmnwkWULczrQSpOl3BihK+zoTxTjYsEyBTIHqYMcCRGZn8f
	VZA==
X-Google-Smtp-Source: AGHT+IFvZaXS5R4+YL5P8F90a0gHK8ukdEgUfBNaMMZaxZ+sJVdo1cLhCMNldopfKaP88TmNE5ekFBPgF9g=
X-Received: from pjbse8.prod.google.com ([2002:a17:90b:5188:b0:2ea:479a:6016])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d84:b0:2ee:9b09:7d3d
 with SMTP id 98e67ed59e1d1-2ee9b098047mr11743154a91.19.1733166462433; Mon, 02
 Dec 2024 11:07:42 -0800 (PST)
Date: Mon, 2 Dec 2024 11:07:41 -0800
In-Reply-To: <b36dd125-ad80-4572-8258-7eea3a899bf9@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241121201448.36170-1-adrian.hunter@intel.com>
 <20241121201448.36170-8-adrian.hunter@intel.com> <Zz/6NBmZIcRUFvLQ@intel.com>
 <Z0cmEd5ehnYT8uc-@google.com> <b36dd125-ad80-4572-8258-7eea3a899bf9@intel.com>
Message-ID: <Z04Ffd7Lqxr4Wwua@google.com>
Subject: Re: [PATCH 7/7] KVM: TDX: Add TSX_CTRL msr into uret_msrs list
From: Sean Christopherson <seanjc@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chao Gao <chao.gao@intel.com>, pbonzini@redhat.com, kvm@vger.kernel.org, 
	dave.hansen@linux.intel.com, rick.p.edgecombe@intel.com, kai.huang@intel.com, 
	reinette.chatre@intel.com, xiaoyao.li@intel.com, 
	tony.lindgren@linux.intel.com, binbin.wu@linux.intel.com, dmatlack@google.com, 
	isaku.yamahata@intel.com, nik.borisov@suse.com, linux-kernel@vger.kernel.org, 
	x86@kernel.org, yan.y.zhao@intel.com, weijiang.yang@intel.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Nov 29, 2024, Adrian Hunter wrote:
> On 27/11/24 16:00, Sean Christopherson wrote:
> > On Fri, Nov 22, 2024, Chao Gao wrote:
> >>> diff --git a/arch/x86/kvm/vmx/tdx.h b/arch/x86/kvm/vmx/tdx.h
> >>> index 48cf0a1abfcc..815ff6bdbc7e 100644
> >>> --- a/arch/x86/kvm/vmx/tdx.h
> >>> +++ b/arch/x86/kvm/vmx/tdx.h
> >>> @@ -29,6 +29,14 @@ struct kvm_tdx {
> >>> 	u8 nr_tdcs_pages;
> >>> 	u8 nr_vcpu_tdcx_pages;
> >>>
> >>> +	/*
> >>> +	 * Used on each TD-exit, see tdx_user_return_msr_update_cache().
> >>> +	 * TSX_CTRL value on TD exit
> >>> +	 * - set 0     if guest TSX enabled
> >>> +	 * - preserved if guest TSX disabled
> >>> +	 */
> >>> +	bool tsx_supported;
> >>
> >> Is it possible to drop this boolean and tdparams_tsx_supported()? I think we
> >> can use the guest_can_use() framework instead.
> > 
> > Yeah, though that optimized handling will soon come for free[*], and I plan on
> > landing that sooner than TDX, so don't fret too much over this.
> > 
> > [*] https://lore.kernel.org/all/20240517173926.965351-1-seanjc@google.com
> 
> guest_can_use() is per-vcpu whereas we are currently using the
> CPUID from TD_PARAMS (as per spec) before there are any VCPU's.
> It is a bit of a disconnect so let's keep tsx_supported for now.

No, as was agreed upon[*], KVM needs to ensure consistency between what KVM sees
as guest CPUID and what is actually enabled/exposed to the guest.  If there are
no vCPUs, then there's zero reason to snapshot the value in kvm_tdx.  And if there
are vCPUs, then their CPUID info needs to be consistent with respect to TDPARAMS.

 - Don't hardcode fixed/required CPUID values in KVM, use available metadata
   from TDX Module to reject "bad" guest CPUID (or let the TDX module reject?).
   I.e. don't let a guest silently run with a CPUID that diverges from what
   userspace provided.

[*] https://lore.kernel.org/all/20240405165844.1018872-1-seanjc@google.com

