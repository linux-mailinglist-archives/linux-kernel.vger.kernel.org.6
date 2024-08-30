Return-Path: <linux-kernel+bounces-308904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 719A5966386
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B07C1F24F12
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AF01B1D79;
	Fri, 30 Aug 2024 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3M58Dtm8"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4D91A7AC7
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 13:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725026239; cv=none; b=WkwrFhe7DQEQpQe9c7K90Omwju/pruMxowS4wN/CnoHaqZ4QwJtSWr0KAoWcilYluoy2xNMgnKMqf5IwjijnUBlxRDNjjDcVVuNmVkNZF+Q0QnP5/P8j2SlcHcrwLoM0niHpwlxVqUfj9YDnHEdXcQH7GVB61lF95Hns+pDUddM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725026239; c=relaxed/simple;
	bh=NUlKGhIyCsQGFAYIgqP91JPxVHe0dLUWSGpMcalpvoU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=apxMb4NFs77aBVaYI4W0kzne3r+iXizQ/HHZDIQzAO5MNqCeRiMZZBwFhSGb20E5oaPYAEi9E3hPPlnwpUEgfqwk7Sj1z9H9dS6UVOjccv+Q1vNpqz4GpeO8CctGxCFkLg7vWbhtuq/FmW48ufknXkzAneeCa5iDJz81MtQGNKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3M58Dtm8; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2052918b4f4so7078605ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 06:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725026236; x=1725631036; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=58CvTL6COAyoekWQp05GB8r3Lb0Xc+vxoLW2O7LrDWY=;
        b=3M58Dtm8nuNnYELdLnsGKD+ir1BUWYX6KMaWNsdRaZlwUBjlODenA7kthE1jBOAUou
         ImtzeOJ2e68tgG+fdGNq2kPdTJvjZAseXOybzuNqxF93qfmN4/SLr4yPdIQ6YQjPTO/u
         5qNdRvUl1NbK8rrNaEQh5uaG4V5R9zepM163/bERDS7YXIB5c0KextBqXF8tfiw0PKNt
         YfVDSkNCbWkVYkZKVDbbgi6oPi8/QFSiypLGtqE2RsKJ06emUyTlX4ZZA1QwVpIfySex
         3oGLPOfa3iwUQR875Zs4igODpfEJfNtvHOEb0Ol2QUeWNE9rnF/OXm56pVsyIICKf8F8
         zyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725026236; x=1725631036;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=58CvTL6COAyoekWQp05GB8r3Lb0Xc+vxoLW2O7LrDWY=;
        b=Q/ijO+0jcrrkZhbxX7QrLC7Sx92oYxw9lrN4HUOkOc8ST99e4PzVBgLBb79kAQZvcc
         u/0vqeGx2jobaX5zLcP7MCSVan7aQJakTHwoxpHm9GvIGHWK0QRGqwdh71ZCSrLLNBQX
         BoIcM9rnjX+W87YhuokWhLJvf//HU7HuN+fwqTJF1POR16t1sPJEs6YvbskpNr9dot9h
         9d1FKVryUrDtmhQK/0GCJVb/llysX5UWFeHBs0Ev5hStwxnB92ji/9w6K7vCKwk36Xx7
         CaXkIaJ8JOEx6WI0k/+WUeuOcDX2KPWiomyPf7fWuc1aFD1kQQwQGxMjPb+FhL6QVlN3
         nMvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe0XAkHkYDx678zbAMRbPZu5ESVreUduFM/ByR4dVYxWnVAs39J2fpQra+DDdrlx+UcAOQxqhnCzG6III=@vger.kernel.org
X-Gm-Message-State: AOJu0YzagnANtqy5nrcvOnwpgGyd1WD4VR072IzajpqoNPOH9Vae071g
	fpFSbZSuO4WRyRrcPLuzxYLh0Rn3l9CASvWflxANcdU4BAPsCPYAATTm5wQgBNXEAk92cXF7M+t
	nHg==
X-Google-Smtp-Source: AGHT+IExGR2RCNKu/4M4z4IiNUcplAydPr67v3iYUD8ZfSJDuu52D1tVexWQwhZuKUP8XxVYEYjpc6MqNEc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:f90b:b0:1fd:9d0c:999e with SMTP id
 d9443c01a7336-2052857ddfamr344725ad.9.1725026235523; Fri, 30 Aug 2024
 06:57:15 -0700 (PDT)
Date: Fri, 30 Aug 2024 06:57:14 -0700
In-Reply-To: <1f037b5604deb5f83f05e709b2edf3063372518f.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240830043600.127750-1-seanjc@google.com> <20240830043600.127750-2-seanjc@google.com>
 <1f037b5604deb5f83f05e709b2edf3063372518f.camel@intel.com>
Message-ID: <ZtHPusyTNkQ_a1Y-@google.com>
Subject: Re: [PATCH v4 01/10] KVM: Use dedicated mutex to protect
 kvm_usage_count to avoid deadlock
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "zhaotianrui@loongson.cn" <zhaotianrui@loongson.cn>, 
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>, 
	"maobibo@loongson.cn" <maobibo@loongson.cn>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"maz@kernel.org" <maz@kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"anup@brainfault.org" <anup@brainfault.org>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, 
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, Chao Gao <chao.gao@intel.com>, 
	"kvm-riscv@lists.infradead.org" <kvm-riscv@lists.infradead.org>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, Farrah Chen <farrah.chen@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 30, 2024, Kai Huang wrote:
> 
> > Reviewed-by: Kai Huang <kai.huang@intel.com>
> > Acked-by: Kai Huang <kai.huang@intel.com>
> > 
> 
> Hmm I must have done a lot for me to receive two credits (and for most patches
> in this series) :-)
> 
> I think one Reviewed-by tag is good enough :-)

Heh, indeed.  b4 has made me very lazy; I just `b4 am` the patches and let b4
grab all the trailers.  I'm guessing something went awry in that flow (or maybe
you acked a previous version or something?)

Anyways, one of Paolo or I can clean this up when applying, assuming we remember
to do so...

