Return-Path: <linux-kernel+bounces-395698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C6C9BC1C8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 01:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE63C1C209E8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 00:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5603C38;
	Tue,  5 Nov 2024 00:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="VhMC3Fgm"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889C2370
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 00:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730765073; cv=none; b=YNDK7Ub5hnw00MADvB+yF4w4D5G+SLFMQVFALh3l9wgIkY14ZIPQb6VClgr3w3eMCCglJqvYyyY93pqHILqnsxss5AgUwGnl+AIU5uRnBpNZElPDx6cbhbdrOnzXQ2PH0rhjDgOk3LJk4+etrICWLFvGvUciiRj2kSUCETGEfZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730765073; c=relaxed/simple;
	bh=qeUfMege/AiB/je3hBCsy+mid3QVCDsAnhw/lkw6DEo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=UnzozwiEU3WsyCj8T7Q6+5E7+ls8Zo/92N5l+WrOEH//QXcXHpFNRz1vGGWynh7VGtmnkFs7hnxrIaQKt0hePJYbLZBZjWElXU+YJVq1McWCBffmTsJ07/H4eG+f93jI+2jCCeFCliz1WxUSXy0RGJ2GKxb4SHIyMo2YlI4E/i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=VhMC3Fgm; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4314b316495so41048695e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 16:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1730765070; x=1731369870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sesnMCMP/HStXvO1xZBQzhjE1UZuU9gmGZkAu8bel2Q=;
        b=VhMC3FgmtSq7gLtZYks6R67leqYjsKp/n/0DXFqTDFUJZn0jdhueVQwB3uTdiTjZPy
         yvZ0Jy1oNXNzBuvUj6gcKT6GEQaYjcwOXwNOh0wZPJ01aBedK8Y6LLg/BCI2BCaMCeV9
         GhU+nFSXZXEaU4IMK08pxWT6SKfwuENOLRwlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730765070; x=1731369870;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sesnMCMP/HStXvO1xZBQzhjE1UZuU9gmGZkAu8bel2Q=;
        b=EvMA7llzcsDTBvkioLNoAAM23Sja4/xzOfU0FZZNLCW0pf/bsradyzLMSRnUzoiBnh
         MCUG76rLHzbUsBUgz2BeVFLNQYwDOm/65HMBT5hR6s82qWehYv0j3qRYW2Uv5TYXFmXh
         jU8yp5hVauZIn6bIaxTgzdiIywbsrFJ0ZdPZ1nspntabodmZVg1R+uX8nOFocPWNG3ai
         NJyhPOxtLqzvWOUXFk0e6EszF0FpYT8IkLzBpSdpMsonQ1Ya47OEc8Tij1gLJ1KfsS66
         LyimAtSJDbuk9/QqWt6YjQfnl92TMXJuMxzDqN1UUoU7eusknCGEu8K+t1UQglnHgYtK
         Vdzw==
X-Forwarded-Encrypted: i=1; AJvYcCWi5y96a35pjQQf1rRvIiB0q0q0lVJ6lim11qm4BBs6YvVgJvTVLL/3WbytJ8IE5fjkuAaKNCGFKUILhPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNQx/QfyncZZ/+a0xYKL5r3W/t2hYPFzLT/ULj1vguOzseorMV
	KvT7o9DfL0FyMn5+cI9RWbhHvvjPVqmma1CNMZeHeO1uxUtoap11UWG1ZzMOom8=
X-Google-Smtp-Source: AGHT+IFSNVnW7S8yuwR6GGVHG3ABf/ZPmOmCYAFNEOsMjavp25/AFDw0XQEZg0C9Uwu707CZEs2e/g==
X-Received: by 2002:a05:600c:4ecc:b0:431:3c67:fb86 with SMTP id 5b1f17b1804b1-4327b801f83mr148395835e9.33.1730765069904;
        Mon, 04 Nov 2024 16:04:29 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd74f132sm204043415e9.0.2024.11.04.16.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 16:04:29 -0800 (PST)
Message-ID: <e5463e70-a0a6-4cce-9c2c-4a09c2e622ef@citrix.com>
Date: Tue, 5 Nov 2024 00:04:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dave.hansen@intel.com
Cc: Amit.Shah@amd.com, Babu.Moger@amd.com, David.Kaplan@amd.com,
 Sandipan.Das@amd.com, Thomas.Lendacky@amd.com, boris.ostrovsky@oracle.com,
 bp@alien8.de, corbet@lwn.net, daniel.sneddon@linux.intel.com,
 dave.hansen@linux.intel.com, hpa@zytor.com, jpoimboe@kernel.org,
 kai.huang@intel.com, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, mingo@redhat.com,
 pawan.kumar.gupta@linux.intel.com, pbonzini@redhat.com,
 peterz@infradead.org, seanjc@google.com, tglx@linutronix.de, x86@kernel.org
References: <62063466-69bc-4eca-9f22-492c70b02250@intel.com>
Subject: Re: [PATCH 1/2] x86: cpu/bugs: add support for AMD ERAPS feature
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <62063466-69bc-4eca-9f22-492c70b02250@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> So, I'll flip this back around.  Today, X86_FEATURE_RSB_CTXSW zaps the
> RSB whenever RSP is updated to a new task stack.  Please convince me
> that ERAPS provides superior coverage or is unnecessary in all the
> possible combinations switching between:
>
> 	different thread, same mm
> 	user=>kernel, same mm
> 	kernel=>user, same mm
> 	different mm (we already covered this)
>
> Because several of those switches can happen without a CR3 write or INVPCID.

user=>kernel=>user, same mm explicitly does not want to flush the RAS,
because if the system call is shallow enough, some of the userspace RAS
is still intact on when you get back into user mode.

The case which I expect will go wrong is user=>kernel=>different kthread
because this stays on the same mm.

That does need to flush the RAS and won't hit any TLB maintenance
instructions that I'm aware of.

~Andrew

