Return-Path: <linux-kernel+bounces-392498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 725D59B94E0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14551C21CBF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 16:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9431C9B65;
	Fri,  1 Nov 2024 16:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cJq2VxGQ"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E21B1C82F3
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 16:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730476988; cv=none; b=KCuahhk+S+w6llHkJjI3YHqFxva9FUpU9xY90IaRYAYUSCT/40IEu5dxNu9s7R38ZWcGmxpu5HIwn7rF8kyv4P71tRa9V/5NVBu9Gzo64WcVZmXT993qslG65bmxfXgUvFGfVd0oZKFlWI90Wq5M6twQJ8BeqJqfyf1A/Aef8q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730476988; c=relaxed/simple;
	bh=2zE4LIp6LzR/8lsxkCT8jRwkVycEXFB/gd4/b5EK4nY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kxvpHxWJMrNikKFZGvFXBtTIuTr/N9O3TYbNz39s4RWk8RqBe+rdiYL7yLJmTAHyCxOAq3M7lmkAxH0MIK2ZSXQmAW1GUrg485tREiqCpZpAPRHI+gg/MXoHBQpCBJvkzXOlOUhwJRm5U8VuW9KS4WJ3IALQRyaR3v7CZ6oAZkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cJq2VxGQ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7ed98536f95so1672868a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 09:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730476986; x=1731081786; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gkXDxrcKyT/EOUkmvsZDHOw/g7/SMGoUH3RV1Q0HQWI=;
        b=cJq2VxGQbngG3Wf1Fc+Bg8Zkcl1pUyUyVVsAQw2uTUPibidROIOcLgrPdLOY6DWjS5
         4D1DQgPbyV+vKNg8Sn9CWOy4cxTddjC3ZDjmJ7xrvOMSV6jLHQyQmCFmSbRG8s80BfRU
         nYyu2y7EOmk4D77+wM44EH3vo7jrmEMJZCNM1q08r0L4m3nImg3zqKracFdQZ4HpGqHB
         QNzMrLpMv1BJq7SJLkZQEMhOBlpMfmt0tWli5RAJb0NCul848Nbc1wG13NVnpjQyS+Tn
         sXApKbnZFxKxNJ/NITrYSqL669Kx4FbyABa9dIHlCxjnPh18D8jGaoM+PmjXvl5W/nGg
         aXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730476986; x=1731081786;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gkXDxrcKyT/EOUkmvsZDHOw/g7/SMGoUH3RV1Q0HQWI=;
        b=xA/i4eAXEO6d5EWwlk/HPW/awAUWXHpfwp+IDsCXqSX3XdtzhIjs70RbmTK6e3xFae
         UM9sby7zj1679aaiMlS96vu+V3yanmekrnj69vzEeq5bdUgo++plQtX7NxdGqBv/CHFt
         D+v09MADrz8k1oLmqH/nJNBvmVQ5GoBvgqIsqF4QobAZBGMceqjUveTjHtKF0SQ92xHV
         NJebCncOzlp8OzmK7MyttVEWDxx5YeZlBvJm/sOCms7qVwI/SnsUDKzcBVN8qOR82aeY
         vV1fDh6ZdXpVXpHMFtsu/LJH9zHhPu6a1zZYAzBaUa3hpguoUeP7j4KNGWEr4EwCNQFf
         eI3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzvBg3ICkC8kaI5+FtkkT0RmUY7Vvq+f2JBPX01rHWs4MsJhnOmB3Xj6lpQE889SEHTgrsHZ69YU9UuqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmt6Q3/tUPsS2Pby+Z0aj84QvxTPBPbjfvikV9QvE5wZ6c30vJ
	Z9j/dEmDI5rt9XeflLFg4gMrSyVosW6fmWTyfOs29GooQ13ywX3n3MKAo7Sfj2tTCH/n4709cL6
	6RQ==
X-Google-Smtp-Source: AGHT+IEemKwPqqW6XxcH0slJidqXg+owYm5xIFayZQAlONAYlNEAGYl8zydBRjdg5lQNNZ5zaylBfJa0YgY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a63:1c59:0:b0:7ea:67a0:965c with SMTP id
 41be03b00d2f7-7ee44b1bebcmr9287a12.1.1730476985617; Fri, 01 Nov 2024 09:03:05
 -0700 (PDT)
Date: Fri, 1 Nov 2024 09:03:04 -0700
In-Reply-To: <20241101153857.GAZyT2EdLXKs7ZmDFx@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011214353.1625057-1-jmattson@google.com> <173039500211.1507616.16831780895322741303.b4-ty@google.com>
 <20241101153857.GAZyT2EdLXKs7ZmDFx@fat_crate.local>
Message-ID: <ZyT7uDqK29J46a0P@google.com>
Subject: Re: [PATCH v5 0/4] Distinguish between variants of IBPB
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>, dave.hansen@linux.intel.com, 
	hpa@zytor.com, jpoimboe@kernel.org, kai.huang@intel.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	pawan.kumar.gupta@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com, 
	tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Nov 01, 2024, Borislav Petkov wrote:
> On Thu, Oct 31, 2024 at 12:51:33PM -0700, Sean Christopherson wrote:
> > [1/4] x86/cpufeatures: Clarify semantics of X86_FEATURE_IBPB
> >       https://github.com/kvm-x86/linux/commit/43801a0dbb38
> > [2/4] x86/cpufeatures: Define X86_FEATURE_AMD_IBPB_RET
> >       https://github.com/kvm-x86/linux/commit/99d252e3ae3e
> 
> ff898623af2e ("x86/cpufeatures: Define X86_FEATURE_AMD_IBPB_RET")

Doh.  I think I'll rebase the entire misc branch onto rc5, realistically the only
downside is having to send updates for all of the hashes.

Thanks for catching this!

