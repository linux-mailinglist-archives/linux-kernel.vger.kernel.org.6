Return-Path: <linux-kernel+bounces-171249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81498BE1D2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C32328859A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14921156F57;
	Tue,  7 May 2024 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X7UCZjWd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nFTOIi0I"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EDA156F37
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 12:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084171; cv=none; b=VS2LcjjnZZiUE0ZGVjVqAjHm93Jm4kJx+ybupb/T3fnhsba/71rc4LaLOU1P4sVPLGsSddrmdFEvgmB237d06DqwpkW0JbYgR/aOuY9mqM1WszadZ56xfb6uNk/wVIlS1Zb2Tij1iQXs4PpYVhVVivGgtoL++UpBJ/Opq35L8MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084171; c=relaxed/simple;
	bh=yn6EY4L9QHQF9Qi6rYdMXrRWWmhUr+graHI1uNE59kY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s6EkfeR5pouufBuRPGBOJAGoq4mvnegwTHmmdFemMvpwqa0PBgCpkQ8zW1oo8i+GEcDPC9Bow/0ngV7Tt657evhPdMQplfMkOSUzS2/eG+T3h+kpyCKbRZGFXYZnQgvFB6+R3R1dL30bnYPJVy6SuGDWBt2kP73gqzYaRNODrFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X7UCZjWd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nFTOIi0I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715084168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZW8opu3qoaDFkriJzblpb7PWP6Mdk3qACtPXpvLAX9I=;
	b=X7UCZjWd2O5+VsfJIYVuaFBwa4dhrKBo9oi399o54J4Ktkotp25DYSOdmrlBJg9B44tGpv
	33W2zw6QSiOze+7ULxw0YOgkQkWvCc1t/iNBXp5c2l6N+CZ1JNfpe80SSN1+yr6YL0UCqp
	lw6tg0HRRxqk3iTlCsAykp9CGQTIWM1TxJN6/yphClEE7WNgU5an4vkzemwqHtmKNpfj4i
	RdLcyoSDD07rVb+1gpp4Q7uCVX3Z8bbACYG3BZiLSBEIgWUBM/nae4DbWLTcfdEp0JeN55
	2z+gCASYSr7k4kuNkNaJ61thP0MUy9qQZWJZ7f+d3C7cNpPIsZW/M5K2rVGskQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715084168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZW8opu3qoaDFkriJzblpb7PWP6Mdk3qACtPXpvLAX9I=;
	b=nFTOIi0IXXXF3fCyFBc9/nVyd1rEoi7KgBk/6lbKqzJK/bqQ6j1dOtJkFcuy+wfJIRNXaF
	99zwlD7Z9BRyhKDQ==
To: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
 linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
 keith.lucas@oracle.com, aruna.ramakrishna@oracle.com
Subject: Re: [PATCH v3 1/4] x86/pkeys: Signal handling function interface
 changes to accept PKRU as a parameter
In-Reply-To: <20240425180542.1042933-2-aruna.ramakrishna@oracle.com>
References: <20240425180542.1042933-1-aruna.ramakrishna@oracle.com>
 <20240425180542.1042933-2-aruna.ramakrishna@oracle.com>
Date: Tue, 07 May 2024 14:16:08 +0200
Message-ID: <8734qtrf5j.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Apr 25 2024 at 18:05, Aruna Ramakrishna wrote:
>  
> -extern bool copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size);
> +extern bool copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size,
> +				     u32 pkru);

No line break required. Line length is 100 characters. All over the place.
 
> @@ -229,6 +230,7 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
>  {
>  	bool stepping, failed;
>  	struct fpu *fpu = &current->thread.fpu;
> +	u32 pkru = read_pkru();

Please use reverse fir tree ordering of variables:

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations
  
Thanks,

        tglx

