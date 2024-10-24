Return-Path: <linux-kernel+bounces-380656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CD29AF439
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 23:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88558B2187A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D0E1FE0F6;
	Thu, 24 Oct 2024 21:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="G7QMAgKZ"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D217022B655
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 21:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729803932; cv=none; b=qxqyp8+76i/esEsBOAxZKPkeZdsbjfdPs37+XvtntvwcKKhCefwDDIgnv0f225wtPv8fDyYyVidaUojjN4gkv8DCinN2tuGdhLIfTmiL4rxBgs3VDZkneS/4QZABrSVtcRQIAS6VNsuSLV2TZitKl1j43z6b4teZa33UySa+9bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729803932; c=relaxed/simple;
	bh=TBDYSpeCABsqqJAMq11DrWneOwt6zrgU5gwLxJxYVfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V2ONjrVM7SjRl+G2GHf3cJ+UCnKxy1H+qoj3uzXsUviOELVFXT2i8n2rt/3RXkKh4Qvm1an+sKNiuWxlJKvxHuYx6prYxXH/SEtvOJL09YripeINH7EiEG4xRNysvl74if+rjzusPuWZXMbM8o+xxKrf5rt6QfwtrUCLRITY8xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=G7QMAgKZ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c937b5169cso2227379a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729803928; x=1730408728; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/qNLIL7WWIHaAqks+syzcLiqOaOs4ebkEnXQc3KU1GI=;
        b=G7QMAgKZXRH5T5Tq1baT3ny4MBujSc0/Zn+TFQlWhsOnfdZ8WH6VuwVxT3eihcoBnc
         Uc9Avp3HD4KIACGX8XyqB29o0lxEvPCCh5bkugMlDE8YM44E6WJjU8q9fxr4jCnC0NhF
         U+fopFPgr47wKVHWLdBi9HcLJVaTJxpqQvYqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729803928; x=1730408728;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/qNLIL7WWIHaAqks+syzcLiqOaOs4ebkEnXQc3KU1GI=;
        b=S0enWo+yWSXCV0EKydBdPgUmOsOf32uLwBBlCh2cpMhgc2rkiZQwuXeuLhF7rrSVXE
         5t7GsTyHrPnmOdEqpP+hQC/zHq1uFHVOWj0jNK2jiCJ9XljisNa5MG66TFEQJFOeFdvz
         Uh2zAKKS+umIatoXWDHFv6wraoJ7jzZgS4OYVqwApPoUVgKFd9Tfco/tKVeHBLia+VWd
         bkuTARVyLN7m2x6RrGMVVYmaExT9YXJOx4IIioUtlFTU98ISzqUmwrecRSYqXx3oWvTc
         hT7fVVDbIO0fq2rvj+I+NpuuDQ0+9BstYp9lIEA1EWfZsNOZROqcmiXYlA1wcxhyk4nj
         rwHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5P3gPaFRGZW2/tReg0MAWvkFSf/YTkgecy9eH9Fh4/TEieq7+UOcXEYpXzkgwUpTdyERPAk4OhtYP9pU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4l6qSSR5oHgnoBrTx0G6HoqgFmB9praz6lTWkRV+kJQh7u4V1
	IEQmPVuLbopuWoh023Wax4SfhO2A4Odh4crdtX7dHWV+R9QL8kqpgCDI9ENxoKbiurWbxX3Jacn
	cUngfaA==
X-Google-Smtp-Source: AGHT+IGcb2KIbl4hku+HoMfiIBF7Vqt9252y1Wux1nHLODmNhAUpKkfSqxVj/w0klVvdZK1f8e0PYw==
X-Received: by 2002:a05:6402:3713:b0:5c9:46a7:527 with SMTP id 4fb4d7f45d1cf-5cba208aae6mr3915523a12.17.1729803927649;
        Thu, 24 Oct 2024 14:05:27 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b1adsm6068282a12.69.2024.10.24.14.05.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 14:05:26 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a99e3b3a411so424639666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:05:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVlmCbxXU06VyYJbL9Cg+0po4tMA46BHPGxU7x8urWZaCwe2L4I81P1VhK2kMgo0GNN1MuRC0plq+3bxtU=@vger.kernel.org
X-Received: by 2002:a17:906:db0d:b0:a99:fcbe:c96b with SMTP id
 a640c23a62f3a-a9ad1a5eee0mr345342066b.25.1729803925427; Thu, 24 Oct 2024
 14:05:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023233600.d309ab5fa8421e97d041bbc0@kernel.org>
In-Reply-To: <20241023233600.d309ab5fa8421e97d041bbc0@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 24 Oct 2024 14:05:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=whO+vSH+XVRio8byJU8idAWES0SPGVZ7KAVdc4qrV0VUA@mail.gmail.com>
Message-ID: <CAHk-=whO+vSH+XVRio8byJU8idAWES0SPGVZ7KAVdc4qrV0VUA@mail.gmail.com>
Subject: Re: [GIT PULL] probes: Fixes for v6.12-rc4-2
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Leo Yan <leo.yan@arm.com>, Mikel Rychliski <mikel@mikelr.com>, Viktor Malik <vmalik@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Oct 2024 at 07:36, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> - objpool: Fix choosing allocation for percpu slots
>
>   Fixes to allocate objpool's percpu slots correctly according to the
>   GFP flag. It checks whether "any bit" in GFP_ATOMIC is set to choose
>   the vmalloc source, but it should check "all bits" in GFP_ATOMIC flag
>   is set, because GFP_ATOMIC is a combined flag.

So the old code was buggy, but I don't think the new code is wonderful either.

For example, it does not recognized GFP_NOWAIT, which has very similar
characteristics to GFP_ATOMIC (it's basically the same thing as
GFP_ATOMIC, but without the "try to allocate urgently", and with an
added "don't warn on failure" as a result).

So what I think that code *should* test for is "can I sleep".

Which is indicated by __GFP_IO or __GFP_FS (and, I guess also
__GFP_DIRECT_RECLAIM).

                Linus

