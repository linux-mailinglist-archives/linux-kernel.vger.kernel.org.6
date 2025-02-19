Return-Path: <linux-kernel+bounces-522659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CBFA3CD04
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4253B72E6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAFB25E467;
	Wed, 19 Feb 2025 23:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3jbNt2ud"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994DE25B66C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 23:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740006225; cv=none; b=dvdI1+/OqHUL0fkSP+T30V3K1HYwjyTcQ0NO5+VLkOV7UZ1hBg1dkH8v16LoBRv0SRVydfWvapZPRDOA670KtoGZ2+AsdK9ZR7heGR9eGWoBNTeaUG+S+wo6NxtH88ryBbv2FWNz/1xSwZesDE6Pbfugy8wPIOIC301ShWsFUfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740006225; c=relaxed/simple;
	bh=vxlKsPB9fA1eRwdZ3+WVJ8oGahvk3txj7pQxG+ivZBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ElOJEoM+izZOJS1/JcPabNnICpWjEhmNOidEszyGWrVLZWuOc+VOpB6l8bW5xGXzcPt5infTK5enjl1j1mFrYv5Sc+7f8yt/r9N6Mu/5u03RX6FEr2n/5yEHC9Oz1NTVXoFob2dhVKpxVO+Rk7kRPDhwBoBr2JIJ36kgGPQp+a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3jbNt2ud; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-472098e6e75so55571cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 15:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740006222; x=1740611022; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ftoSX9xYRr/sVzCgjZPkFj1DBXhNwozrL+YAzY6rdbs=;
        b=3jbNt2udWqBygz/9QMU25WASsD6H8BDqF3QzGXc70VdpFNj8lUAbhMAaEEXA7RNY5h
         hUEU2TUzyGm4EPbPLmtH8waIBZT0buMfMmhrUCOl/5moRe/14pfuCwP1cfr6UTi8d6G9
         DQO7JOgOL8teL5Vm/CTziUsidvU6cpLgD5KEV7HQFvd4Y85zjb+CqIKNnxt5aSpyrzTo
         5OWpbgZyrhMJZFr6Oz+6R1X3mfdFjjoiLuhfxfLclOUbJz6CmzLRDiOMK4DHCiXQoFeS
         xqHNhmZEwww7Rum7eDsXh54oid4oHF9oBhTFRUHcEjUT/4gcmm+k5e73QOHPnK9+LRuP
         KWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740006222; x=1740611022;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ftoSX9xYRr/sVzCgjZPkFj1DBXhNwozrL+YAzY6rdbs=;
        b=mdfY7wzbdpshBaNfA09nkQcVTWlTQyq/BsJUhmgCz7gWk//CfCoRMB5RjJP9b6Zkvx
         Yr5yPPUlAHG1dx0fQgzWhtpUjLuVOV+vk/Dt6gOnjyc3FrOId+MmxzDExSSi2O7z1Jhm
         u8lM6bh3msMDI4E1VbwVbuX0UkZ3upGWAnVv5cA4XZDX7SBLfuAeXXqiYa7G1frsVQ+R
         5WTiH0wdL72Y/vXqNfBD6Ym8MfaOhwl5Lde+VgSuMJEYCeCDkREzsZDYOYffdVLKfM/D
         nVZCdFYHuVtELvtMbxnzHnP4xO2TUYWMafsJDTkWrmwJj27zUSP8Rcz6X3AYQPfWhk5j
         AFCg==
X-Forwarded-Encrypted: i=1; AJvYcCUz75wRJbcK3pIIEPuXTLUiN8JBTqPCJDu3g3aRP1wgW8lA3LmsShTTXFLUR+geZ3oazkf9/SMXo63CdR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX5XQsrHIdMWUjyeQNi3BT5lqZUafiYCnvjn/JJ5dcsm7bacsm
	0LjoIsNY1E1oLOfPWeunTahj7zPSr5jyb+aIP9F4A16ybPjMfhUwi5jx5/kGcKv/qAjpACwLixe
	XenV2gLqM8q8dMrtn2dupcNIqG18YMW4S/h3Gub5KAxm+5LrrdjFj
X-Gm-Gg: ASbGncvywnu1cXjTUQPLbwuqLhiqsLOEioROrpM1TD+QuEhpkY0W9ZPivOec9eG/7vK
	wCYFaZE+Ewb55KCTwwxFWtpYQ0e403VERVg2tPJKg3UGr5MR4lRgyUpAxC+bIrrZrUAMYow==
X-Google-Smtp-Source: AGHT+IEigDi0H23C4tqPHVwUDRe0Z3zfFdcq8Sehbc5Y5JBHSEG2LTHIimwD47MYcRJPZsrNUaJqJEkjtq8JpwbLyeE=
X-Received: by 2002:a05:622a:1387:b0:471:ead2:1171 with SMTP id
 d75a77b69052e-47217136e5cmr382641cf.27.1740006222365; Wed, 19 Feb 2025
 15:03:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213094930.748-1-yan.y.zhao@intel.com> <xgycziy2o56hnom3oau7sbqed3meoni3razc6njj7ujatldnmm@s7odbl4splbn>
 <Z4T1G4dwzo7qdwSP@MiWiFi-R3L-srv> <87zfjuoj3i.fsf@email.froward.int.ebiederm.org>
 <f38f1b56-a5df-4644-be59-56c70499ed92@intel.com> <fslhdizolr4twqm4ixevzj6ai5l5qg6mxky25jasn3yctsnvt4@hpwphlmfs5cp>
In-Reply-To: <fslhdizolr4twqm4ixevzj6ai5l5qg6mxky25jasn3yctsnvt4@hpwphlmfs5cp>
From: Jianxiong Gao <jxgao@google.com>
Date: Wed, 19 Feb 2025 15:03:30 -0800
X-Gm-Features: AWEUYZkM_ptDo00RlDjH7cwtNoiOgNsG03JspNquMGAj5QLM3hk8OLDGfWTmT7U
Message-ID: <CAMGD6P3r-S-Va-TRvVjZ808on9+-wFJ_VeTpQ+FEN1jBbhmnXw@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] Accept unaccepted kexec segments' destination addresses
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, "Eric W. Biederman" <ebiederm@xmission.com>, 
	Baoquan He <bhe@redhat.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, akpm@linux-foundation.org, 
	kexec@lists.infradead.org, Yan Zhao <yan.y.zhao@intel.com>, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, x86@kernel.org, 
	rick.p.edgecombe@intel.com, security@kernel.org
Content-Type: text/plain; charset="UTF-8"

> > It sounds like you're advocating for the "slow guest boot" option.
> > Kirill, can you remind us how fast a guest boots to the shell for
> > modestly-sized (say 256GB) memory with "accept_memory=eager" versus
> > "accept_memory=lazy"? IIRC, it was a pretty remarkable difference.
>
> I only have 128GB machine readily available and posted some number on
> other thread[1]:
>
>   On single vCPU it takes about a minute to accept 90GiB of memory.
>
>   It improves a bit with number of vCPUs. It is 40 seconds with 4 vCPU, but
>   it doesn't scale past that in my setup.
>
We have seen similar boot performance improvements on our larger shapes
of VMs. Both lazy accept and kexec with TDX are important features for us.


--
Jianxiong Gao

