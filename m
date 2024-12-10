Return-Path: <linux-kernel+bounces-440244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B527E9EBAA4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4F7283D09
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF02322688F;
	Tue, 10 Dec 2024 20:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eQB1ttjY"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28F08633A
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 20:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733861417; cv=none; b=TRj+rP9ynlWxlx5WGBuTV31KLccXYhaQnrq+nK+MIfWo7iDw0zx70g3b8A+HfbHqRnabw4Wc7c7UESSBv4kvAsetfmyaGZj1F6byTe+9xgRfqMrkjS/7kbgTGnLwf3GZV528AJ1omOQdMJ75x653tpeFRUS2n0KbvZ1ekatxgQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733861417; c=relaxed/simple;
	bh=ArH+BDaYBBobT5PIUMi1jnRalONERI4QUQnKck5+RtY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DxOBKVePyax/Q3NycE3OpzkRAPiOofcM0fgfiLEO/X9YVcnv5FdOdpFR1cyQ7638KTnhL5nWSc4geaxOWFaPTGPxNGlPkYNONH73yWogpBrTJlTmvA2JjIrv0nAV1oqS1c8vmH/2k4v+MmW2bRFnanqtA4BXKKQBjm4e4Mk1P/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eQB1ttjY; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2efa74481fdso2658154a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 12:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733861415; x=1734466215; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4CcZIj8yhvlL/w3reHOFOEqXMEvWzMLZVJVn1HvOF+k=;
        b=eQB1ttjYKU3siMs7d/Kpgye6RWCC4nZrJCfZy96c3Db/uFjwSkNEgi2D5HxTzI8zWq
         iF+X6qhP1FRW6gz2bcvv7XSbhX+6aoiYUvGi3AJBA+ufxj3eNDFhdQ5N67l6Vrd50gqb
         hfjgGURZkkTUhlqKdNLrXMlN0d4g0HPBH6GIkoDu9bKzFU/fV64SXuHpBm6objz7sq90
         5/CRXtheDNG8xU5UAebhTBq0lO7uY5eh1VSaSfeyMQpvtQhqQeNEbD/jhiAgVbx1qY0m
         bdcesJOd+rZVgvshPrewJ//L6XufL32ZRW9YygLWgfC71BgvSiTVWn+vWg8/XDRdEt1b
         WSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733861415; x=1734466215;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4CcZIj8yhvlL/w3reHOFOEqXMEvWzMLZVJVn1HvOF+k=;
        b=SkORHGwFyPg3O9xtrQYxxUoCqlfaGPDH136IpKa9TrZ4YpZ9JPjdQtcADY5fD/AMwW
         WDH7YO+c+y12FkvfDeCQbWmnA0XsahW87ZMuNTP6lJJh/zUsaJBEMb25/E36uYSz1NdG
         YdyWeN/tn19Afl1P1m/D3bxaY0tqzve4GpHtxQBfZT0Hv+fVCFoRuZLJAI6dtdxYTz/5
         mTm4YvUt6Obry/mCJbRI0qJrXLrCp3qMnZfTcR8llgIMlfOgetUMh1y52QwRrhPPO02R
         zGcBR3qS1Lg7D7lNxhmtTYJ++p7ekXYRSO81brOdYF8Cc8mJnd9Jyd4g7/R+q79E3ir8
         rWsA==
X-Forwarded-Encrypted: i=1; AJvYcCX3lGPxyD3d4CLnSobQluqkLW+x2anhTEwQi98waHX/xI+/h82g/PQVzYXX9Cx8BzcE4yLKhf8PiNCh2UY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Q/V3stZIvXPxUNnrCwoaQ+gA055+ivISraHjL0d9aES+utdW
	LUwmwaqelTH4LU3mIJOY+lArOEfpzc0VtUZcRtUr79UBpOqNoYzLry6BwoXmClH5qvTxRUnFa6C
	mlg==
X-Google-Smtp-Source: AGHT+IGdwFwyc/i49yH9lxYKjEfEPyXHxb0toroZJAgwWjp3C6PzPZ+OK/X2WpQK5laCaKj9suPGSlqcsLI=
X-Received: from pjbsj11.prod.google.com ([2002:a17:90b:2d8b:b0:2d8:8340:8e46])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a:b0:2ee:df57:b194
 with SMTP id 98e67ed59e1d1-2f127fdbf48mr395474a91.21.1733861415188; Tue, 10
 Dec 2024 12:10:15 -0800 (PST)
Date: Tue, 10 Dec 2024 12:10:13 -0800
In-Reply-To: <ff1d01ff-5aa3-4ef7-a523-6bf4d29be6b6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128004344.4072099-1-seanjc@google.com> <20241128004344.4072099-7-seanjc@google.com>
 <ff1d01ff-5aa3-4ef7-a523-6bf4d29be6b6@redhat.com>
Message-ID: <Z1igJYxwSxTk_DHF@google.com>
Subject: Re: [PATCH v4 6/6] KVM: x86: Refactor __kvm_emulate_hypercall() into
 a macro
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Dec 10, 2024, Paolo Bonzini wrote:
> On 11/28/24 01:43, Sean Christopherson wrote:
> > +#define __kvm_emulate_hypercall(_vcpu, nr, a0, a1, a2, a3, op_64_bit, cpl, complete_hypercall)	\
> > +({												\
> > +	int __ret;										\
> > +												\
> > +	__ret = ____kvm_emulate_hypercall(_vcpu,						\
> > +					  kvm_##nr##_read(_vcpu), kvm_##a0##_read(_vcpu),	\
> > +					  kvm_##a1##_read(_vcpu), kvm_##a2##_read(_vcpu),	\
> > +					  kvm_##a3##_read(_vcpu), op_64_bit, cpl,		\
> > +					  complete_hypercall);					\
> > +												\
> > +	if (__ret > 0)										\
> > +		complete_hypercall(_vcpu);							\
> 
> So based on the review of the previous patch this should become
> 
> 	__ret = complete_hypercall(_vcpu);
> 
> Applied with this change to kvm-coco-queue, thanks.

I was planning on applying this for 6.14.  Should I still do that, or do you want
to take the bulk of the series through kvm/next, or maybe let it set in
kvm-coco-queue?  I can't think of any potential conflicts off the top of my head,
and the refactoring is really only useful for TDX.

Patch 1 should go in sooner than later though.

