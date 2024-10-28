Return-Path: <linux-kernel+bounces-385583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3069B38FD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B3C9B225E4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB731DF981;
	Mon, 28 Oct 2024 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tc5d8MxS"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8E21DF254
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 18:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730139626; cv=none; b=OPOO3Gv4M+hGmNjLxTMNUO2KVZWoDRFAmSa29uB8zn0KJLJrnoURvqlpp9nPCZFSWSEclrrvmGUlF1c1GCUJVbb5sskBRy8207Vdeg2LsKkT34vWwqQS/Ox0EZx5K9iR0W1KzTlncJMP9Gioriy4D+0Idm1kYOBOTt3Wtc+LZ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730139626; c=relaxed/simple;
	bh=lH79W0uMbqi4yKZO5aZMPWy4AfJYjDaphUfhMP+ya0k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qdguelNgQaS/17z1Y8LsJFgtkwMa3SHZqytFvf0hk0NCoCME/D/Df4QzM2qMy8du2JpkhdFH2iqxwxTa8odq54al/inJB4CcrPlWzHjSfHg3lA/+7/f3yBmEjCGSiatiCUpewTTV+2S6j6MeOSeA8LjU8ENH0VtgGu3dO/7Ngk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tc5d8MxS; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e29135d1d0cso7538974276.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730139623; x=1730744423; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nJX4y1SwBFlqpYhxsuhY42rX3MFJuIm/9BwAllYm8WA=;
        b=Tc5d8MxSoPIPgtRt+NJfUjdH4drZjGt+EMhYgbPW8f/eh2y+BOS5S12GL2TIW2hYxe
         zJDqJF3ZFPI9kIPKB5u7R3Wf07hTkrm2AusSRkW1IA9Cj/DQX+dcBknwAE1q8oiB0aRw
         k2HReaYW4eZLP9UYRtwXgKMHhzNHEk+APJxtPimEPqLZv5VMQBLXxNp14M4MP+aSe7HK
         8X9oY4kino0jWxkrpLAcRjgOaccYDnxjNbuNwRBpsaDWstHXmd8MRoFCSR4weHZj6J1Q
         4w924rhxpGjUdw+DOLjzqHqgSQr5l4zVqb/9E+iQhtX2GyYgHXAcCaJcpz+HZCY7ZlFU
         zGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730139623; x=1730744423;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nJX4y1SwBFlqpYhxsuhY42rX3MFJuIm/9BwAllYm8WA=;
        b=A9Cjqf2aLmoenaznwp9DJuuqM0lI/WnnTMcrHgRvlmLvg+2AwuenayfGXg/fotHDlR
         CV5iad7fIakr7118blXvxbcZ/PydXM849+QYuhdZBqBG/tquZDqNDLcfqWf42M9GmtvO
         bmbP1N3wtVl550FR1FREV/aY5bn98Y2jvHHWuO967InLFvXhoqepX6EEB1cBLHoPJCQS
         twTvgXntM3O0qHSpTWm3T8zyq2tmIZRFS7y7q7TPeTePeh+/I2K3J1kXKwGJEq/6n46c
         enyYEcR/hPgVJ3gnBkIigYqvteq0ZC/dpA/sLi0kXZtK5HGtLjPhUJWCX9GKHS2UHj1R
         fx5A==
X-Forwarded-Encrypted: i=1; AJvYcCXZnGtrEToH3YU1ytZyP2fP1xn96DDK3f0EnzK0nsNT7XattR4fgrBZY9yR5Vz/+gjsprVCNmGdP6FaC2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Km4i8u9yA/dGOFankdEgnIt72821LLwpRWufPCs8v0G/kn5y
	zOaU9meFEWilcrRoJ4oPdusWp5+8+PA7R1QkfOOWIgAxRfNCaZ9ldY531H3xdNrrDjHIB4J90dV
	+8g==
X-Google-Smtp-Source: AGHT+IFXrnGi8zCOlqbG2xXq8xFgLUpq2KxOh8G6ohInFjQzOCfOhTsZHU2ciqujNv6S3Xkjq8hOwwr3c9g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:844e:0:b0:e30:b813:ca60 with SMTP id
 3f1490d57ef6-e30b813d0a8mr995276.1.1730139623094; Mon, 28 Oct 2024 11:20:23
 -0700 (PDT)
Date: Mon, 28 Oct 2024 11:20:21 -0700
In-Reply-To: <CAAH4kHZ-9ajaLH8C1N2MKzFuBKjx+BVk9-t24xhyEL3AKEeMQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240621134041.3170480-1-michael.roth@amd.com>
 <20240621134041.3170480-5-michael.roth@amd.com> <ZnwkMyy1kgu0dFdv@google.com>
 <r3tffokfww4yaytdfunj5kfy2aqqcsxp7sm3ga7wdytgyb3vnz@pfmstnvtuyg2>
 <Zn8YM-s0TRUk-6T-@google.com> <r7wqzejwpcvmys6jx7qcio2r6wvxfiideniqmwv5tohbohnvzu@6stwuvmnrkpo>
 <f8dfeab2-e5f2-4df6-9406-0aff36afc08a@linux.intel.com> <CAAH4kHZ-9ajaLH8C1N2MKzFuBKjx+BVk9-t24xhyEL3AKEeMQQ@mail.gmail.com>
Message-ID: <Zx_V5SHwzDAl8ZQR@google.com>
Subject: Re: [PATCH v1 4/5] KVM: Introduce KVM_EXIT_COCO exit type
From: Sean Christopherson <seanjc@google.com>
To: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: Binbin Wu <binbin.wu@linux.intel.com>, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org, 
	pbonzini@redhat.com, jroedel@suse.de, thomas.lendacky@amd.com, 
	pgonda@google.com, ashish.kalra@amd.com, bp@alien8.de, pankaj.gupta@amd.com, 
	liam.merwick@oracle.com, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Chao P Peng <chao.p.peng@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 13, 2024, Dionna Amalie Glaze wrote:
> We can extend the ccp driver to, on extended guest request, lock the
> command buffer, get the REPORTED_TCB, complete the request, unlock the
> command buffer, and return both the response and the REPORTED_TCB at
> the time of the request. 

Holding a lock across an exit to userspace seems wildly unsafe.

Can you explain the race that you are trying to close, with the exact "bad" sequence
of events laid out in chronological order, and an explanation of why the race can't
be sovled in userspace?  I read through your previous comment[*] (which I assume
is the race you want to close?), but I couldn't quite piece together exactly what's
broken.

[*] https://lore.kernel.org/all/CAAH4kHb03Una2kcvyC3W=1ZfANBWF_7a7zsSmWhr_r9g3rCDZw@mail.gmail.com

