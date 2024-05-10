Return-Path: <linux-kernel+bounces-175414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 700428C1F4C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06BB1C21234
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 07:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDAB15F302;
	Fri, 10 May 2024 07:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QvyCwmVY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c9xSZ0jX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FEE12AAE5;
	Fri, 10 May 2024 07:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715327467; cv=none; b=aG/Js4jQyAENUAWJroXxVkmZy2uQz+/nng+f0bu47JDY7mwTqyshrQRLmOgWg9mZbuwnSInRq8cx3IW60vCbWtQHqZOwqPMRhVWMxdHTwmPGIo+53D4m20tb/OLlhfRVkqQCbzrWvWjTExefVdjJZzhJf0LSx38FcVzJc12B0l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715327467; c=relaxed/simple;
	bh=VYM7fGJjhmjLymVRv/fDQo6hN8Spqtzfyzs+nbT2mX0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cXHuvT+6tvqE0mYSbGIpDKO+M+M/3Rk43sdJ4QMvWe8bo6YQ/t8luyB7XljMcG9/xBG2QlFDTNaaRnEdyTetsXw5geWxFq2psgioMILqJk69ph0C5gTKQyDjDt/PYgX39TY1UkRKYW+No5N7g/Ay1HPXoWlTyX+2vZ2PH6z0dCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QvyCwmVY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c9xSZ0jX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715327464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bIm1fAKcGzV2+29L6VoKcR07i20QYU5XtuqRPiLw9LA=;
	b=QvyCwmVYbnn0fGMU4flRLFxCJjjGSJGvR5zdOvdujP5QMKsg81ungs2dZBaEbNMxH+eiwn
	S5H8J8w0eF1kkdkqrK1tKWt+Cx9rO9VTz09Lqa8xZhAmY1fsqoIgWTsWyMBfLRber0D700
	nHLs59eFqUdXzRzJaPgRZOLDHovX95mAFrGCO9ltHUgDefI3ABnFxA05+uaWWaezdjOr3P
	yAz7nOVmL4aYtTpqYoksbSJOISxA4qewPzxVt86prQxll7CPzFzjCnrm0Qd00UTYDTZ+/1
	217m3a9tYn3QXcCdkViB4w3Pi98icliXINAqjQbjNslLoTVR4muYQBFdTutq+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715327464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bIm1fAKcGzV2+29L6VoKcR07i20QYU5XtuqRPiLw9LA=;
	b=c9xSZ0jXY56J3+wI1zztvYxMSeM6l3zm6SfKxC0U7J08W4MgONBNXH/ejXbs1UTNWzGYIs
	fUMElEUTmIX3TdCA==
To: Dave Hansen <dave.hansen@intel.com>, "Chang S. Bae"
 <chang.seok.bae@intel.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, platform-driver-x86@vger.kernel.org, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, tony.luck@intel.com, ashok.raj@intel.com,
 jithu.joseph@intel.com
Subject: Re: [PATCH v2 1/2] x86/fpu: Extend kernel_fpu_begin_mask() to
 initialize AMX state
In-Reply-To: <fde6149c-7ddf-488f-98c0-04f336b7092e@intel.com>
References: <20240430212508.105117-1-chang.seok.bae@intel.com>
 <20240507235344.249103-1-chang.seok.bae@intel.com>
 <20240507235344.249103-2-chang.seok.bae@intel.com>
 <f82879a5-f3ca-436f-8c4a-96d4c5d90354@intel.com>
 <7e589b35-4ff8-43fa-99dd-d3b17f56d3ea@intel.com>
 <fde6149c-7ddf-488f-98c0-04f336b7092e@intel.com>
Date: Fri, 10 May 2024 09:51:03 +0200
Message-ID: <875xvmnlzs.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, May 09 2024 at 10:36, Dave Hansen wrote:
> Three lines of code:
>
> 	1. IFS declares its need to own the FPU for a moment, like any
> 	   other kernel_fpu_begin() user.  It's not a special snowflake.
> 	   It is boring.
> 	2. IFS zaps the FPU state
> 	3. IFS gives up the FPU
>
> Am I out of my mind?  What am I missing?  Why bother with _anything_
> more complicated than this?

Right. Keep it simple :)

