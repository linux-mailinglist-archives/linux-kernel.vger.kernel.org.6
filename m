Return-Path: <linux-kernel+bounces-268040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C1C941FAC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383031C22E7F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C65F1A08AD;
	Tue, 30 Jul 2024 18:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ua6ywGZl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OtwcKJTU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F73194C73
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 18:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364464; cv=none; b=fYlpTx3TDGFf0rxG92Lf+BEp5iVj+1nLBeSrfZCpEwST344r7ULfml23iJ5KlfM98xXUtefaWf28xrMNiVYoU1cygx3sJFf6rHBqQaBcBjaeU+qteNqPLJMVrnlP/3J0l2LTGeDbJFXDtXAYF0MMyVn+pdEZYrrSVg/UsY1HWi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364464; c=relaxed/simple;
	bh=oXO9zK4DJofW7Gc9HWpBQCj6D0+AQp2IgkTsVxOvMqg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SlLTmhgkSVHWVUMcF4XXRPnhbwVAJ8/k5Z9PTFRXRS5z0N+CxocLTCRc0518nHJ2ADyV2QRuuVWCnrwpe5sQAYyCkmhC21Ai6AOL1kK/HpE2KBs5CLsK31PVPxztB+HJ5aexiN6TvAj01ivMj2/YfgIOGSRbwta5FrO2pzhCm8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ua6ywGZl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OtwcKJTU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722364461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qYoE+fCfT01BDytyITgNBvQBrIQtcp/c97WRqlmeXbc=;
	b=Ua6ywGZlJzIDIiERR8/IrUTZFdeWMEknf54cC6l33L3gXR5LIPeDYlNgkQuXQs/yXl8sNp
	4VcrsC3M/MLDYuye0OmJ4i/RHU6/RikPnT0oIlBy98KUSZ/9Oeh9D8oai6OFuqXdUgRZQY
	rZF+yI5D3hxICaMthkzy/pt9AEMGa5FSvndqzpXWt0KEgh+Y8TOoY18NCILwmZ8c5adohJ
	DAm0YSTL8u73h/v63MY7LarQrOVnieCPfY41F2jH/xhtHzVIoK1CTVrcdME96zf0wMyX7Z
	VHXroHuWtw+lidmjha12rw/NxooNQmlPgezVHXcmLOEuuS4ndzKgQfQt5dDTkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722364461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qYoE+fCfT01BDytyITgNBvQBrIQtcp/c97WRqlmeXbc=;
	b=OtwcKJTUF0uI3eyqGxnH44OF0Lsrf6sYJNuvVBwxjJaQxW3e29j4aFFx0/LBBdTdgXvxDe
	CJ3gQp+HIdF43XBQ==
To: "Alexey Gladkov (Intel)" <legion@kernel.org>,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton
 <akpm@linux-foundation.org>, Yuan Yao <yuan.yao@intel.com>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Yuntao Wang <ytcoode@gmail.com>, Kai
 Huang <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, Oleg Nesterov
 <oleg@redhat.com>, cho@microsoft.com, decui@microsoft.com,
 John.Starks@microsoft.com
Subject: Re: [PATCH v1 2/4] x86/tdx: Add validation of userspace MMIO
 instructions
In-Reply-To: <855a5d97f0e76373e76c5124f415d3abd7ae3699.1722356794.git.legion@kernel.org>
References: <cover.1722356794.git.legion@kernel.org>
 <855a5d97f0e76373e76c5124f415d3abd7ae3699.1722356794.git.legion@kernel.org>
Date: Tue, 30 Jul 2024 20:34:21 +0200
Message-ID: <877cd27mqa.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 30 2024 at 19:35, Alexey Gladkov wrote:
>  
> +	vaddr = (unsigned long)insn_get_addr_ref(&insn, regs);
> +
> +	if (user_mode(regs)) {
> +		if (mmap_read_lock_killable(current->mm))
> +			return -EINTR;
> +
> +		ret = valid_vaddr(ve, mmio, size, vaddr);
> +		if (ret)
> +			goto fault;

fault is really the wrong name for the label because it's the general
return point of the function. 'out' or 'unlock' perhaps?

Thanks,

        tglx

