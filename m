Return-Path: <linux-kernel+bounces-263519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7939F93D729
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E8C283F20
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D9017C7D2;
	Fri, 26 Jul 2024 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KCyVcWvn"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B7B11C83
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722012320; cv=none; b=f0cdrEfMDrwfi/ElgPkXMaCrhyiAY/0RJSeCOmpXcQiwT1kwPigJFKTv36aouybUL4k3QN04qrI86FYwbPZhPEYqJ0z+PtVDmYT9QV6HZd/IdOK2bOrqUD6TCIpv60XDj8MIZWfGjgOwXmPYFqCOH86+XrsIuTlqCY12MEaUQi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722012320; c=relaxed/simple;
	bh=XJLgZuR3KviFafgvQJVTyFT3i3vA9AL6Ik6JXASwW1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gyjLitmBo+Z0s1HQhdFdEdr3TU9rp76Hqr6ecYdhI8ElPPFbKov55ZHP0NOmikqoNXv9SYuibvKTAiNPJqU6DdAymKeRPhk4U+PXonkBCNUiothBxgBw+QTLefx0BwGIE/vsAfTawS7uMy0BOH2/6QjrlZsIm8pZsuPDoyLCnzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KCyVcWvn; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7ac469e4c4so338819166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722012317; x=1722617117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJLgZuR3KviFafgvQJVTyFT3i3vA9AL6Ik6JXASwW1o=;
        b=KCyVcWvnVGyUSwYZnn4xUjfyQxCdBfd/87QnDHAokuzIV4Aztu+TaHAsMg2XoslXOR
         w2EnhUFbn/dPhsNYOHCOUx8XN2jnL5weLSDllY9YJ9SOMYc4tHKBHDYijCbAuES0Zf9m
         H4A7zxnTcjIJJu8YH/bnaoAjAqPN5vsbt5UpOhY0XecXf95N9imAB9DTP0VNu+SsC7df
         1EyZt9vJw2QJb5w6mFfQAOU4m0mOl4+9EoXeaWA/T9WpzVIIwS2Tvr3DQr2/Moe7rU9K
         SrE5QWTIdh/iCsOueke6yVb47KBki8wGw/SfbS8nM8NJACZzsQXMwLPrVnxhjC3AoQZt
         hjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722012317; x=1722617117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJLgZuR3KviFafgvQJVTyFT3i3vA9AL6Ik6JXASwW1o=;
        b=wNXPGtchfv8GUBzboiqzw9680Qn6pAI0A9MhFEYX0vRSDCroFKuwh3Tio5+5OvpA4y
         MznBo1GO5fJLNEW3/hUygaD6yUKjjgjMjTjQjmpwWx/7xt/DLdSGd18dopnX7zaY5Nc/
         /Sk85YYJN0WvwN/Gn2hrLe/eAO8ePYuVLPSc4JoFSOoYEoYf1EiuXJSA/NMhmnWYE8Um
         wFtPBwh4+p4QFzwOavPJby8l3nUIpPuUr5utXSSS00nNW3sY2mEzq6FQSL5uAALw9Q1w
         YTdIYTbY/mepXmHuAOlNNtmY480RDJ6qnk+scIcuI9yvR6sSJ3kosYRpiRpYzkQUZyyZ
         swPw==
X-Forwarded-Encrypted: i=1; AJvYcCVo2z+U1kQjDFTJjShnDVja96MefivxzGTYGQszq8sE6NNnMtynflMh379ngVVf6/YcdyqCVTE8Q97ehhiGsK7Vg4l7nuWUvpccclbY
X-Gm-Message-State: AOJu0YwExBkWBotTFrvbJh9SvAXz6ABHRz8Bl0ysbrLgS3tsqAlnRNSO
	xqcV4KgoQ5HPvMvln+0ltO8whqVczYE089YfOoKgTcnbL3JpXzlY3Si/QHKH1liPnbYpE36CWJo
	7SAZKYZUoOlvDVys3lYPwBBfwLDv1tVyofy21
X-Google-Smtp-Source: AGHT+IEs6xxkecDHpoDt8aXv2saqRhNdcaqmQyIQMaHfq1aVGzWAr+xECNfHIFDYKnmrMq7rARexHpPAvEgy9LjO4gE=
X-Received: by 2002:a17:907:9705:b0:a6f:6337:1ad5 with SMTP id
 a640c23a62f3a-a7d3fa3f679mr11658966b.27.1722012316474; Fri, 26 Jul 2024
 09:45:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709132041.3625501-1-roypat@amazon.co.uk>
In-Reply-To: <20240709132041.3625501-1-roypat@amazon.co.uk>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 26 Jul 2024 09:44:40 -0700
Message-ID: <CAJD7tkbeHVwABajRis0hHx9WLQ+yvnr=8gHQeEQcAi_BW9fAGQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] Unmapping guest_memfd from Direct Map
To: Patrick Roy <roypat@amazon.co.uk>
Cc: seanjc@google.com, pbonzini@redhat.com, akpm@linux-foundation.org, 
	dwmw@amazon.co.uk, rppt@kernel.org, david@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, willy@infradead.org, graf@amazon.com, derekmn@amazon.com, 
	kalyazin@amazon.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, dmatlack@google.com, tabba@google.com, 
	chao.p.peng@linux.intel.com, xmarcalx@amazon.co.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 6:21=E2=80=AFAM Patrick Roy <roypat@amazon.co.uk> wr=
ote:
>
> Hey all,
>
> This RFC series is a rough draft adding support for running
> non-confidential compute VMs in guest_memfd, based on prior discussions
> with Sean [1]. Our specific usecase for this is the ability to unmap
> guest memory from the host kernel's direct map, as a mitigation against
> a large class of speculative execution issues.

Not to sound like a salesman, but did you happen to come across the RFC for=
 ASI?
https://lore.kernel.org/lkml/20240712-asi-rfc-24-v1-0-144b319a40d8@google.c=
om/

The current implementation considers userspace allocations as
sensitive, so when a VM is running with ASI, the memory of other VMs
is unmapped from the direct map (i.e. in the restricted address
space). It also incorporates a mechanism to map this memory on-demand
when needed (i.e. switch to the unrestricted address space), and
running mitigations at this point to make sure it isn't exploited.

In theory, it should be a more generic approach because it should
apply to VMs that do not use guest_memfd as well, and it should be
extensible to protect other parts of memory (e.g. sensitive kernel
allocations).

I understand that unmapping guest_memfd memory from the direct map in
general could still be favorable, and for other reasons beyond
mitigating speculative execution attacks. Just thought you may be
interested in looking at ASI.

