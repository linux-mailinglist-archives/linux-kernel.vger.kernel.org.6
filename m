Return-Path: <linux-kernel+bounces-517703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BC4A38484
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FA2318872A9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0250E21C9EA;
	Mon, 17 Feb 2025 13:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BODpmy7N"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADB021C9E6
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 13:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739798543; cv=none; b=WtElaFd4xJzBQuq8alBtbimGQFZ2nhWvWsxOKunRvo4BwoghTbO1PHA7mGFapK+YZV4w2garO++mSQjqp7AFtiOB3aYd+2kyAqs1WxgV8Ytb2reLAWNBZaitSQoOHhDB0pKAeDjC5NqXFHPrNLAt6u4dN7abQgaOSTaAI1X6hsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739798543; c=relaxed/simple;
	bh=OkrgoHhvKKyqKU2T3RsdpgfrAc3hLMfwN6gM0yk/0WY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qZMMOwEuW5Hxh8qA/X+HTm7W/LWI5KQR69HDptDVP3bDv6JmHD4hM6fTwYPc6DB3P9q3hA6BGDVk2/xrEzH/1Bt0rGnYjNOkjkSqTYSS01Pn10KTonzKKgmYzjkb1mSWFc7h/PzNgUpSmxDV7a/jdtcBbXXukn/1hDbMG2Ydv6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BODpmy7N; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-471fbfe8b89so13741cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 05:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739798540; x=1740403340; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vq9CJlm9LZioC/TdF9O153jfo2iM3nlQAWvAD/w6QrI=;
        b=BODpmy7NklfVGbQvCP/HWTPYj4iatKa3fCIveEyGzUeM4YFOzZIUSmK7iNqbMG1HE5
         3rZ9J2otzsf+jX2ocvYfcsCMoN9tf1p9t98Gnkrq7plRGnBsY5jOngk4BhIxm0K9JdOO
         JHWqJEJgiJoNcJPKSSOif2cQYL+EplapmPeLu0pEmW3/FqXjhPDW9ECOzuwkS5fSwsW3
         zSjZvKieOcuxAol/urzZv5auKoKOD3tFi71xUjgkIOM6+JObWXDUlV20+7XBNWQuGSlh
         oCDgU6tn9qe0/FmjQJksj9G/L7MelgD4lYQbxOC+RTstpKe3iUIM2pjPZ81eyMxBbWEu
         UIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739798540; x=1740403340;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vq9CJlm9LZioC/TdF9O153jfo2iM3nlQAWvAD/w6QrI=;
        b=Nx96eMjYHIlQYXblTt1QaCNSH+izy3Up7A9P7HL1SiOLiLw9eYvaoz/xD/TdIcU8fV
         isZadwcYruaTBXkrWbcfDA86AeveOUXFMXpats5Xtejqn+CjGFUM/RX3EdBXjIYxP4KQ
         tS88wR3UM2vTL7e0NZMQcPMtQuWlq/awsrwLFLSqAdBDvF4QYzP4DygeWcS/u/8qmBbk
         aw8xyi1dFadxFFMmKDDNLrcVkuqUg94tpqRrDQ+f+JxN0I2BrZaX0zNfhFE8QLZxfXFP
         wcJ72705ITHHuuo/6iEuCTX6qN14j6abC/Hxw8dCtrM9sbN5NyfrGFHZEw2uFOJgvJKs
         qa1g==
X-Forwarded-Encrypted: i=1; AJvYcCWrdHbj2q9tn4mYrdWFDgkn4a2Sdc/wF+EBE5PdgcO2ATlyaXM9lRbXe5XPAjZEZFdjpcPJOGZ8GKahvzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuYwvrWKdP7a5p42nBk+1xWsbIOU3NDzmu9j9zUOJaNnmrNT2R
	goEd5L2xI+aQghiiCXM+qjdyzobq9BIjqzV+ZNotAsbMm3l/bjhyn+WnnSzgKmtT0lMd6sagjfG
	hLN0+tjFCEdwDvumBHdCXMnbNZ3WQ6BPnIx39
X-Gm-Gg: ASbGncuATmP73/CVQWN1u2ULMcucYtbV3dSwPYUqXECUmsinaazwrqz4rppSypxvCT5
	0fRMYUPfL3hcVmXKTTGTkY68c5RP9EaRieFYknH4k80UzTxH+e8+TJyzii8j+LLOoPxMvkhT3io
	DiaVN4bvuZ+A8E9Z1ZSXkAVMg7ic0=
X-Google-Smtp-Source: AGHT+IHPb2N/Ql2QklTpLkD7IklZWxXHiU6D+knUHd+msp5Utd9AH8vt3AvwQmgYE4W9XOtxZdSn2sDo/2Lh+Ipx1nE=
X-Received: by 2002:a05:622a:4d2:b0:466:975f:b219 with SMTP id
 d75a77b69052e-471dc776c37mr7257111cf.8.1739798540440; Mon, 17 Feb 2025
 05:22:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213161423.449435-1-riel@surriel.com> <20250213161423.449435-10-riel@surriel.com>
 <b067a9fc-ff5f-4baa-a1ff-3fa749ae4d44@intel.com>
In-Reply-To: <b067a9fc-ff5f-4baa-a1ff-3fa749ae4d44@intel.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Mon, 17 Feb 2025 14:22:08 +0100
X-Gm-Features: AWEUYZkcGmtgXspwSIHGcORyrrSbO5XSN0cgRWQ-uvFbLyT8pNr5z7geDMZUGAk
Message-ID: <CA+i-1C2G9Db1X+qa3FrYSDFZmQJoms=VBpBpVPyQbCX17djYow@mail.gmail.com>
Subject: Re: [PATCH v11 09/12] x86/mm: enable broadcast TLB invalidation for
 multi-threaded processes
To: Dave Hansen <dave.hansen@intel.com>
Cc: Rik van Riel <riel@surriel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	bp@alien8.de, peterz@infradead.org, dave.hansen@linux.intel.com, 
	zhengqi.arch@bytedance.com, nadav.amit@gmail.com, thomas.lendacky@amd.com, 
	kernel-team@meta.com, linux-mm@kvack.org, akpm@linux-foundation.org, 
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com, 
	Manali Shukla <Manali.Shukla@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Feb 2025 at 20:53, Dave Hansen <dave.hansen@intel.com> wrote:
> > +     /*
> > +      * TLB consistency for global ASIDs is maintained with broadcast TLB
> > +      * flushing. The TLB is never outdated, and does not need flushing.
> > +      */
>
> This is another case where I think using the word "broadcast" is not
> helping.
>
> Here's the problem: INVLPGB is a "INVLPG" that's broadcast. So the name
> INVLPGB is fine. INVLPGB is *a* way to broadcast INVLPG which is *a*
> kind of TLB invalidation.
>
> But, to me "broadcast TLB flushing" is a broad term. In arguably
> includes INVLPGB and normal IPI-based flushing. Just like the function
> naming in the earlier patch, I think we need a better term here.

If we wanna refer to invlpgb-type things without saying invlpgb, and
as you pointed out "broadcast" is too general, I think we just need
the terminology to refer to the fact it's a special "hardware"
feature.

So "hardware-synchronized" or something like that. The former would
abbrev to hwsync in identifiers, without any loss of clarity.

