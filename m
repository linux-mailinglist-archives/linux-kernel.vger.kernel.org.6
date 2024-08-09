Return-Path: <linux-kernel+bounces-281361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1BE94D5FB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46FDE1C21928
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F68515665D;
	Fri,  9 Aug 2024 18:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FMXJs3rO"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0D2146590
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 18:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723226757; cv=none; b=L3LEDLqO9jeUuh0vIh3jt/KNeaI3VNKyjM+QIwefPLySeGT1Imhitt6pWx1UmiFy8vAe9coRDXcvLZQWAflEr9kz5Gq52ZHv+P5kDDRGd78vY/z/CQGWAPcUvtv2vEsT1KybHqgCaJiWnLkBXFHjmmwWjFVPBU9HnwHGW0RcMR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723226757; c=relaxed/simple;
	bh=sRnKhLz2AeGCC2PqyrO9v57fiuhWRGyHN825C4D2zFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGcRZU+fhABHCRqeiQL/ziCjui9luWJEkf4PM8f+wD7e/w5voZyAkLo5KlXQFVmlBkT8VcHl8n7vuZRpQOkcG2snPlmFJf468fjItA0hmOdt5eYlfPDGCGrhXKG4bqbi5goVm5sEd8n2kHuVh5+bn/fCleREtjxR4CsKYR3cAHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FMXJs3rO; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 9 Aug 2024 11:05:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723226754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pz2evepGO64BL8beVTJ2lT3wejzMqrFi7TquISVjiq8=;
	b=FMXJs3rOce+8GZCfDadeI/GvLRLkTHqGt5e63ZIf2YwlugietLLi9xMy49CG+s0/F2Z8k2
	Sx2Mr6D4TZABXNuK4lzARakfklVZR7vnVC2ms+9YZ6PhJdA3eyRygSOjbtU3IHoAeoQWgX
	2NDuA5kkMb0sbtzE10RUStj0pazoDPs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steve Rutherford <srutherford@google.com>
Subject: Re: [PATCH 2/2] KVM: Protect vCPU's "last run PID" with rwlock, not
 RCU
Message-ID: <ZrZafa66bRxoVc0Z@linux.dev>
References: <20240802200136.329973-1-seanjc@google.com>
 <20240802200136.329973-3-seanjc@google.com>
 <ZrKqrCnNpNQ_K_qi@linux.dev>
 <ZrK4x4LLz1wlwGQN@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrK4x4LLz1wlwGQN@google.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 06, 2024 at 04:59:03PM -0700, Sean Christopherson wrote:
> > Can you nest this lock inside of the vcpu->mutex acquisition in
> > kvm_vm_ioctl_create_vcpu() so lockdep gets the picture?
> 
> I don't think that's necessary.  Commit 42a90008f890 ("KVM: Ensure lockdep knows
> about kvm->lock vs. vcpu->mutex ordering rule") added the lock+unlock in
> kvm_vm_ioctl_create_vcpu() purely because actually taking vcpu->mutex inside
> kvm->lock is rare, i.e. lockdep would be unable to detect issues except for very
> specific VM types hitting very specific flows.

I don't think the perceived rarity matters at all w/ this. Beyond the
lockdep benefits, it is a self-documenting way to describe lock ordering.
Dunno about you, but I haven't kept up with locking.rst at all :)

Having said that, an inversion would still be *very* obvious, as it
would be trying to grab a mutex while holding a spinlock...

-- 
Thanks,
Oliver

