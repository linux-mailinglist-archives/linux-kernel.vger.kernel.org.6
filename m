Return-Path: <linux-kernel+bounces-571338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAABCA6BBF0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 737603AE585
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A9338FB9;
	Fri, 21 Mar 2025 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="JEshP6ni"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0207CA5E;
	Fri, 21 Mar 2025 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742564821; cv=none; b=f978UE5o9ZLVkLmSrQHRAboZfnD473zIlC444QsRb2ziXZAfWoYYzp0hnPsfoRRTKJtv0ORRj0V8DCGzUUnGgskWDLD2qq4pX1su+Uyv3kApmEozHFugB/0PulcrADRsMHaz+gXSFrz7w3PPROPU1bCd52MRbNUVODOhDBy1XbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742564821; c=relaxed/simple;
	bh=2bzQ39oJ6FKRT59C+Uimbt2z4p+cGnCUiJQU6Ut1RkE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iFwx1mkm8DhiMVIAl9GpHcIhq5X+9/PnhE5n1XErZTanoTZAbEfaW7yvF9yv1rXjVXatGKlxupFiwlkdG5eg4gW3zZSW3Vek3cxi7AB1i9FwmFmseylfD4j/1csQUctjFGI5Pcxe4EFIyKtHEIE1upxBT6Z1SD3RiF8xmTkPYxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=JEshP6ni; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AFB0541061
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1742564812; bh=2bzQ39oJ6FKRT59C+Uimbt2z4p+cGnCUiJQU6Ut1RkE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JEshP6ni6yTLpiaYeOas9Jrjng77WDd/fjCMr/gyDDWDqacAJ+YuUA8xDXXFER0bT
	 skcsq4eOugcFKMrAOhAi5bJelZY5jeMWSuiex8mG+kjmeigm/4eb4IX4uDvZ3rhzjb
	 uTPpLNk55qCifj+0RtgKCO8lr13t4OjPqyVdNXdKWcdpjLB8vdRS7mmYjWkYli1QVF
	 T6JGg6nJ5dp6Iys4YrQyveK3B7Qdrjs1qbajVQPpCSuKoxwQMgI28OvBtX2zxUm4cl
	 YmbNWfFdDGyr3sOosFT031TE7EXwH8N3uAYsRNSTCevKWhC1dLLjJq+wYgtYrWpFIA
	 t+cnjbyGdB9jA==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id AFB0541061;
	Fri, 21 Mar 2025 13:46:52 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Changyuan Lyu <changyuanl@google.com>
Cc: akpm@linux-foundation.org, anthony.yznaga@oracle.com, arnd@arndb.de,
 ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de,
 catalin.marinas@arm.com, changyuanl@google.com,
 dave.hansen@linux.intel.com, devicetree@vger.kernel.org,
 dwmw2@infradead.org, ebiederm@xmission.com, graf@amazon.com,
 hpa@zytor.com, jgowans@amazon.com, kexec@lists.infradead.org,
 krzk@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, luto@kernel.org, mark.rutland@arm.com,
 mingo@redhat.com, pasha.tatashin@soleen.com, pbonzini@redhat.com,
 peterz@infradead.org, ptyadav@amazon.de, robh+dt@kernel.org,
 robh@kernel.org, rostedt@goodmis.org, rppt@kernel.org,
 saravanak@google.com, skinsburskii@linux.microsoft.com,
 tglx@linutronix.de, thomas.lendacky@amd.com, will@kernel.org,
 x86@kernel.org
Subject: Re: [PATCH v5 16/16] Documentation: add documentation for KHO
In-Reply-To: <20250321063356.381646-1-changyuanl@google.com>
References: <87wmcj69sg.fsf@trenco.lwn.net>
 <20250321063356.381646-1-changyuanl@google.com>
Date: Fri, 21 Mar 2025 07:46:51 -0600
Message-ID: <87frj6o5ro.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Changyuan Lyu <changyuanl@google.com> writes:

> However, I think concepts.rst and fdt.rst are not not end-user oriented,
> but for kernel developers of other subsystems to use KHO API (I also plan
> to include the kernel-doc generated from kernel/kexec_handover.c and
> include/linux/kexec_handover.h here in the next version).
> Should Documentation/core-api be a better choice?

Yes, I think it would be.

Thanks,

jon

