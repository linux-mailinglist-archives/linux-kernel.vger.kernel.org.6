Return-Path: <linux-kernel+bounces-575517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91052A70391
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FA56188E27B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7214259CB1;
	Tue, 25 Mar 2025 14:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="vsRan22Y"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888072571A7
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742912433; cv=none; b=oYAaLDZpljt/wctWXxm3fgmaPsqeGjYXr67JDp8QQ8xeyPrulTAd/klhVPCzcD3vVT62e6CwIffdJDUJrJwN53b36stCVlerAPINCZXtArSPfFqHgQ7ONyl+qo8im5VnafiU6k/gv5RvEIrpwhs1U2PXfoDo5qA0o3ieBC7csi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742912433; c=relaxed/simple;
	bh=6R9zA86q92q5KNyTPt/KezT2KM642idnT1llXfBvGGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bxPUcEnHmBNaia61zhdwLZIrvVblH/ez/S5d4x7BCE4lidXUxJlkENTUKjixZnaCb6jmIqyJKKrjVuBWXPJkl+XSSMK8eiSKZUnr3YXVNASJqUh/rfPJCdmoncjqXBBFgFANqc23HkosJ85utRc96Y8oYG7lk519vbzEmk/O2xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=vsRan22Y; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-47688ae873fso57620801cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 07:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1742912430; x=1743517230; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6R9zA86q92q5KNyTPt/KezT2KM642idnT1llXfBvGGY=;
        b=vsRan22Y4qwsj7yKN39U0ifO+/D//+MnwCOwtjNMHJqFDDYu+RMDhq+O40Axj6/Um1
         rQIPN68gNjNB3/ge5b/8vkr++gSgSFwsHUqP0zuNFsXl8lWCh5zoLwDRteM4rMphdK8j
         cc5J1VaKQK4JMKyJGYMhrrMZDIhKG0b6n+fmBpMOvS6sb/p7QytQQz47aWZESqvv0YTl
         0x6jeMJSkFayACKpPoKzesUQBO8fNJAkwbvhZaklupQaHAi8AcRgURw8vEDgyFN5Cx/O
         3ZeBweLhvHEf1pzWbPbymKvhYBAzNnWccownXDGeQFWWElvqnE7ruqcs2tW0gsBfKq1o
         KV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742912430; x=1743517230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6R9zA86q92q5KNyTPt/KezT2KM642idnT1llXfBvGGY=;
        b=Af1Qkh5Sx8Q6rNQS1GursBQthWP5V+eNceqPE2bURMYX9f47Q/3S+58p8GLW1nOG3c
         9FIXnfgHB4B4smn812gzTseqZVBhAEPvM9cf+3WTZVJC0Nrq2hmj8xPL65EqWihfEbKu
         N8KBzbTs9TKIZYL1mwh8pGg463f5Bb1pYMk2YVCblBkZFkNWeYg5iwNG8G1z9qnIHi13
         lvFBujH9Vlh3+zjoy5OGWF3Hknj582gMZduX6/XP2yYVIExiQCpI1ZVGA6CdOLhPSbSw
         7G7uqEJmOgn/422tk8Di5Wq/rOj8yN3wLHZ6ejrqUjPHI29UfkUQ3jRa5fGP5ojLs7UU
         2hkA==
X-Gm-Message-State: AOJu0Yx9SCDN6oYZjZ1l61cG+2PB4BSEnw/wT/VSzSChgmQxIB5Br4TV
	Ittc3+2LUKjY7VkYNwurGEKnZrDOylwKB4ynASfVYzUCxHO4UOUz+1HGXtb37TRHdwCBHm/1itv
	VlPcix5Fseynk+C4TMbzV/atAkIcvGY8J+TQe9w==
X-Gm-Gg: ASbGncsJ0kIcV4jDLd7IfxIjwwNxdPaqrmvb6fBq4AvrUe75JgKrMZ6qE+PcK7A5Cic
	8a2G1tKMKhHlqcPgL7tm+pAgdGv87H2UsE/EDgsY4zQe+kykyYvH6zdNzbj1QpTLIyGL1pLeNyl
	n9lyUK4KvKOqAhpMELYTMQcMAO
X-Google-Smtp-Source: AGHT+IGc+rzcOSqRq1NAurG0wArv+f9TNDXi3NJHkDUdzPbqAqbmujaqTIOq09aOpi8XwtONse7qgR0mbQ4HEgDxOjc=
X-Received: by 2002:ac8:529a:0:b0:477:29f5:53eb with SMTP id
 d75a77b69052e-47729f55467mr169156461cf.6.1742912430244; Tue, 25 Mar 2025
 07:20:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com>
In-Reply-To: <20250320015551.2157511-1-changyuanl@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 25 Mar 2025 10:19:53 -0400
X-Gm-Features: AQ5f1JpBD7J0LGV4vivBPILeYhry8D0ETPzHZusd7bV5-E3dLFdBAyFaK8Fs_Bw
Message-ID: <CA+CK2bDtBk=49hbz+C=fDswz_Nbtj8kVjsY-pTsmBt+O8YPLmg@mail.gmail.com>
Subject: Re: [PATCH v5 00/16] kexec: introduce Kexec HandOver (KHO)
To: Changyuan Lyu <changyuanl@google.com>
Cc: linux-kernel@vger.kernel.org, graf@amazon.com, akpm@linux-foundation.org, 
	luto@kernel.org, anthony.yznaga@oracle.com, arnd@arndb.de, 
	ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, dave.hansen@linux.intel.com, dwmw2@infradead.org, 
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com, corbet@lwn.net, 
	krzk@kernel.org, rppt@kernel.org, mark.rutland@arm.com, pbonzini@redhat.com, 
	hpa@zytor.com, peterz@infradead.org, ptyadav@amazon.de, robh+dt@kernel.org, 
	robh@kernel.org, saravanak@google.com, skinsburskii@linux.microsoft.com, 
	rostedt@goodmis.org, tglx@linutronix.de, thomas.lendacky@amd.com, 
	usama.arif@bytedance.com, will@kernel.org, devicetree@vger.kernel.org, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

> To use the code, please boot the kernel with the "kho=on" command line
> parameter.
> KHO will automatically create scratch regions. If you want to set the
> scratch size explicitly you can use "kho_scratch=" command line parameter.
> For instance, "kho_scratch=16M,512M,256M" will reserve a 16 MiB low
> memory scratch area, a 512 MiB global scratch region, and 256 MiB
> per NUMA node scratch regions on boot.

kho_scratch= is confusing. It should be renamed to what this memory
actually represents, which is memory that cannot be preserved by KHO.

I suggest renaming all references to "scratch" and this parameter to:

kho_nopersistent= or kho_nopreserve=

This way, we can also add checks that early allocations done by the
kernel in this memory do not get preserved. We can also add checks to
ensure that scarce low DMA memory does not get preserved across
reboots, and we avoid adding fragmentation to that region.

Pasha

