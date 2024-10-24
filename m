Return-Path: <linux-kernel+bounces-380599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF349AF32E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 22:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA7F2845F6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C4818A6A5;
	Thu, 24 Oct 2024 20:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XF4/L9ay"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F6822B642
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 20:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729800023; cv=none; b=mOc5pe2zKIKDueLRU/BA3F2zG3rnvZGzMhKv8BvpEsFOH2hhU36UpWsk1oFGpSRCRViy7uveunBibhSQMALkH6RY6CEzXetEx847O2j9Du/qN2Fiy33Z6BlktwNxrp/CecDfMEphEVeuNMglUA3BhOUNUpl0PDvAxbeeI0lZNFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729800023; c=relaxed/simple;
	bh=APGnPOCBShuZbn/yjaCffvFu0yNZ3khalfc2pOUsDxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YXIwvKgi9rnd7XY8XohhH22W5CWkLXncXgo3aFpTqjN6mB9a9CH6pNMwmedszNh9f+8h1WL1I+G4TJo6Ql8ZmSXsHuNGNuiHVB+h2B9HbWhQve7TqYZqIlr886bHQn1/p6yE9LYCC/PQABZWN9Bkc1TMCTW53eky5LLkvwhTp9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XF4/L9ay; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9aa8895facso196055966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 13:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729800019; x=1730404819; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y/927tBCrl8U10OnT2Xd8FdgRNeSxDW4ZHR5RgRATXo=;
        b=XF4/L9aybS1DkZ4gtId48uq1uzm4pmmjy6TjLZldet5nOiP/AGCf7h94rilVof6EeG
         yW6WErs0AHv0Fn5muRQEd+bfCF8B5CQ4hkM/NftcJCrkYZoxbVYoyEfrnim/iu77szs8
         aM0nghwjw9WwT2SiCulcMlc/5vGX7/M5e3vLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729800019; x=1730404819;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y/927tBCrl8U10OnT2Xd8FdgRNeSxDW4ZHR5RgRATXo=;
        b=wDLuV/Y2OX43KBSseyCS/220MW+NBwGLMPFRCCqb9mo1rwVtKeQ7ICzj55g9BChTGr
         6jSXyEYsTds5BccJ05QduChmUgsNtGHmAhkUfiYZnvIVjDeZPOwT7nfH/8kw+TMVxvWu
         9cEzfgbVL9G636Anute9MDifdOyhvbsDLFY3+j0mx0chDk+8kgAETjDh/VqTRZFq34uQ
         y4NhXUVhKn9Y665+rpOnq2d16+2m7xgdq7kbVbzDEMPfmntHNbQt3QWDO54RLN8f1qmg
         fh20SC5ZxZRQWmRcv8P2SUIQv+zOzzC99BcjdVl+AUs3R4W5FtER7tfkIHGMRk2nzZs/
         6s1A==
X-Forwarded-Encrypted: i=1; AJvYcCWknH03jEXtFLlZoTFLp2gDVRrTWhNg1R0l2VkazW53wNv1s6YGbkZ2ImRhuHORVXR0XqAlZzatsrrO/Jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwyPDch/nT0MJ4F723seUaaLS1ElPyCYwD2+k4Kx2yUocdKGN4
	SaWplYnP/28sAVrX2DdJNadJ62X267d0enlD5XY2yl4AYkjRs6XC3JwXJT45Q9zBj3B+skmYKNe
	fYg8REw==
X-Google-Smtp-Source: AGHT+IGZlYklpRTeWhwphKFH1kBPJHGWi7qXd0nO0myp2nSh1rTze315ijFaiq2N8Kb+p2M1ALhoUQ==
X-Received: by 2002:a17:907:e9f:b0:a9a:422:ec7 with SMTP id a640c23a62f3a-a9ad275d9cemr282476166b.32.1729800019277;
        Thu, 24 Oct 2024 13:00:19 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912f681bsm656970666b.84.2024.10.24.13.00.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 13:00:18 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a6acac4c3so196192566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 13:00:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWojvBsmKzDdENNRY4mnjystZAdJ9071wazsUSQV3sqqfqGdawPfG3kpCsFawDb+P2N3OQLGtlITBKaFOY=@vger.kernel.org
X-Received: by 2002:a17:907:9809:b0:a99:f656:2bd8 with SMTP id
 a640c23a62f3a-a9ad2814477mr300288466b.42.1729800017829; Thu, 24 Oct 2024
 13:00:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024013214.129639-1-torvalds@linux-foundation.org>
 <20241024110822.GBZxoqppmxp0xxG7ew@fat_crate.local> <CAHk-=wgynHGhG9dzwRdySJSHZTOCp9jBHChomEF-mERJmsUeQg@mail.gmail.com>
 <CAHk-=wjBkvHNTy3orkjw=2GH25S4MSFWesSjni2zZNW2+gjomg@mail.gmail.com> <20241024190903.qlmfegs4y7rxl6q5@treble.attlocal.net>
In-Reply-To: <20241024190903.qlmfegs4y7rxl6q5@treble.attlocal.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 24 Oct 2024 13:00:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjR5j9C=58BBJ7ok5bq4-3ePkPsUtVEDFfUCraqNEDXkg@mail.gmail.com>
Message-ID: <CAHk-=wjR5j9C=58BBJ7ok5bq4-3ePkPsUtVEDFfUCraqNEDXkg@mail.gmail.com>
Subject: Re: [PATCH] x86: fix user address masking non-canonical speculation issue
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, x86@kernel.org, 
	Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Oct 2024 at 12:09, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> On a non-related note, doesn't the inline asm need a "cc" clobber?

All inline asm is always a cc clobber on x86, probably because the
bulk of x86 instructions do.

Having one is certainly not _wrong_, but we typically don't have it.

(See for example all of the atomics, all bitops, and pretty much
everything else).

We do see to have added the "cc" clobber to a handful of cases - it
looks like the virtualization people do it, because it's mostly
<asm/vmware.h> and <asm/mshyperv.h>, and the ones I found in
<asm/barrier.h> were added by Michael Tsirkin, who is mostly also on
the virt side.

I'm not sure what triggered the virt people to do it, but it's
certainly not wrong, it's just neither needed nor traditional.

                  Linus

