Return-Path: <linux-kernel+bounces-177820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029658C44FD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C342869EE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20136155353;
	Mon, 13 May 2024 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KNqmLJSG"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4269014D2BF
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715617254; cv=none; b=idNtCAn+wM+qpmiMFq5Y028K4iDwWeD6W45qIjV0bn/ckySJ9JGe3fISURvQlC/OK3OJxrtPJtiHr2vkG11NHsOPbppcUkDtYfj62nSc0ZTfypJgLDfSj5XH8l1mdymE6u8fbXk/OW7rz9Kof23dT6tEHf6fzomyjfPkRotPfTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715617254; c=relaxed/simple;
	bh=BdY/cBLngQnlcwyixvI71fNjSSKMQrGCPriZ2LpM/Ic=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MrTf5tVpn0A8G6NbvFtLku6BNa7yW4TMTRbp8vIOQWVAHSupXMbJofY1vVQmb7WBtUW1eNoq/HXSt5jakudTEbic2WPWh9JY79veNqS0fK1i2EP3zF1YzTsUFtW3aEzb2zTh6OXhw/rSQJ2zOWl3ImLgo3ZaWH/NSSgmQ+QAzGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KNqmLJSG; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b432dfdcf6so3876102a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715617252; x=1716222052; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zgt+w/nU1JjUrZ0GRJPLjZLIv1xcz6lTgN5YKDDkzT8=;
        b=KNqmLJSGpLRA+dQx83K8Sr37612TC3IE4T2huVpE6xzee8kFLmHl+q+Vfw8InNTvIr
         ErmhgUtLq4hpc6iwAmUR3XxQxIwYybcNVDBYuhvECqof78EpEqoFWoaPgJVBr5eJd6xO
         nviPf3KbcM/8aK6PrYHsCDfi1qGnoDkY8ZhWV4HAc3HMnSkdjXKTAVf/EX/uQ8nFP3Gh
         IG8tp3WdJB5gtwbCnvyOulGJM+ZCP0J1HGv4Gd8F4Olxb8UgBNXFTzzG6IhkIGEDUH0i
         pjQ5nx9r+MgNN/Z959gSonbKSTu7O/y6ZrphF/RNn1qPtpQYY0rgIFaqwiYUly8gunis
         pb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715617252; x=1716222052;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zgt+w/nU1JjUrZ0GRJPLjZLIv1xcz6lTgN5YKDDkzT8=;
        b=hcbAhb23F8Rd55keDWi7HekfHA9OiRLhoYF4YNZXsnPfCC4uExdFSb7/X4D0klw7GZ
         fqvkKhuZW3G0s/ueJ6d4Wyg0FwuWtyVA/KS12sexR6hkXnGoXn75qBANkU8MZ6ZBlIEB
         NUc4/7vEfka5RVxdwrKAEJlUlc2tFiWnkihnQj+zTHfQ7iLPoKpcRZrW/n/X3LK3wKMJ
         oX+s9yp084Hp12QWwKyXX9Dd61AfDJt3kRyKmKsZOxXuySjAZ2RbT44OT33BqSXPoMgj
         gBcDBYv//dwiYOQDXdNuisnCi1jlTaLuhuum3TdsKeFZcC6/NoUD/4NOTelpfznp4WwH
         IlqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfwrhVOWNeZet1QwcmL5/1vvVsx9rzHRnlx9eCZnxevZYXLoEF033nD9vc/6S5MbgAWkzS8codc9H1mCOsfrkKm8rCm463FaJTuU7n
X-Gm-Message-State: AOJu0Yz176jPgMbVkw97n8E25wo5keVjCr5sRK5Ype6zKJQkyHTCIKGo
	TL5pqKwe/vnsuf+k9BjyTJDsY+sob9VQH0p1XjU4ZtmImsYGFABxnuIfWPERBZx1Wz66Tb3r7QA
	IJA==
X-Google-Smtp-Source: AGHT+IFHnrXdTgKbPjNIvcthWplF4GAmm0C+xXuTvFWx+kW05nR4GtvDbz0e+nNcsaVMkxBWnlqwf3ezKV0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:350f:b0:2b4:32ae:483e with SMTP id
 98e67ed59e1d1-2b6cc03bd09mr29750a91.2.1715617252422; Mon, 13 May 2024
 09:20:52 -0700 (PDT)
Date: Mon, 13 May 2024 09:20:50 -0700
In-Reply-To: <4f2112f3c4f62607a1186faa138ccc06f38ee523.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240425233951.3344485-1-seanjc@google.com> <20240425233951.3344485-5-seanjc@google.com>
 <4f2112f3c4f62607a1186faa138ccc06f38ee523.camel@intel.com>
Message-ID: <ZkI94l9rcfBSH0pV@google.com>
Subject: Re: [PATCH 4/4] KVM: Rename functions related to enabling
 virtualization hardware
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, May 13, 2024, Kai Huang wrote:
> On Thu, 2024-04-25 at 16:39 -0700, Sean Christopherson wrote:
> > Rename the various functions that enable virtualization to prepare for
> > upcoming changes, and to clean up artifacts of KVM's previous behavior,
> > which required manually juggling locks around kvm_usage_count.
> > 
> > Drop the "nolock" qualifier from per-CPU functions now that there are no
> > "nolock" implementations of the "all" variants, i.e. now that calling a
> > non-nolock function from a nolock function isn't confusing (unlike this
> > sentence).
> > 
> > Drop "all" from the outer helpers as they no longer manually iterate
> > over all CPUs, and because it might not be obvious what "all" refers to.
> > Instead, use double-underscores to communicate that the per-CPU functions
> > are helpers to the outer APIs.
> > 
> 
> I kinda prefer
> 
> 	cpu_enable_virtualization();
> 
> instead of
> 
> 	__kvm_enable_virtualization();
> 
> But obviously not a strong opinion :-)

I feel quite strongly about using __kvm_enable_virtualization().  While "cpu" is
very precise, to me it implies that the code lives outside of KVM and isn't purely
a helper for kvm_enable_virtualization().

