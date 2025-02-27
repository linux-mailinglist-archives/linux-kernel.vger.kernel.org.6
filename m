Return-Path: <linux-kernel+bounces-536921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65125A485E5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1672D189292A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8109A1CAA6A;
	Thu, 27 Feb 2025 16:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Car6dCNZ"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082F01BC07B
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675141; cv=none; b=rn0/KBVgiwsRG+eDdQcdG18e72O1gTNXjfxzdk9EGIjXXh/DTFUv3QP44e5q2nusowre56AJQO1aRkfNsco1xDQuZKITjjFlYZOR12eBpjpYb/BWtvGEON/5AnRAqVqRXW1hbYSFZxjmfqlqqqaYzv9Pmt0WKsU78R4D57hRmqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675141; c=relaxed/simple;
	bh=0PbYFSPB0Y87sK8pgl92IdpkP9r9ojirvp3PtP9z3OY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWDanWgvtyyizXKb5wibyq1+lt61Xvrvcy9hF7pxx7YSISxXXMXokQfNpyF+Lg/yTtnKXGToHcRbBYmQIA35pHlp2BbKZ4ShY1YIOsKmaz9u2qBrQ7atKSO9RwwrBa5B2MJoAWgnkJY2r8/pavZeTH6JBuD6uAnukoYibgHMrC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Car6dCNZ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab78e6edb99so159055566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740675138; x=1741279938; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=em10wxn8hU+Ww08TcX0fNMGmGD38PbTgAoFmhvOjNjA=;
        b=Car6dCNZT07Ecb2A+b2icIoikJSrBhB261bjNcdzr8ONNVTOp+jUbqD3cr2ZKiNQer
         rQ9dgCqyi1VMZFpE6uktav56e1RX7yRvcpPyewPo8bWulDVEDHYR0OKIF1UCbtVI/IJk
         DN4jsxRz9YkHDc9ZN0uq7Owvl0xa7vWEatBRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740675138; x=1741279938;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=em10wxn8hU+Ww08TcX0fNMGmGD38PbTgAoFmhvOjNjA=;
        b=SN62qUz3drHVkE3rUnSFJiIJPYu9ZChf82xz40SATeCKiehAXj9MOLJ+XsUxorkKSd
         KMYDeQ2nrz3lARfaz7BiNK5W51/zkPqOlkldQ4Sfw7sUxgMp/HQzvVLc2XqaSCAmekfQ
         idh9oeEj1qgdmZvUU0RtRp3Z8c4+AyJh/xKrc6+QoklPC9tk75UGDeWZsduEM4FhlLMr
         yj4SYnYHlxWXb7zLJyhCm+UHbIPOj7LSmqtyJKbCtM4ZY2oNDOPdhdZ6hqcpk3ZlhpiQ
         uP6L0zG+ZHUYksYviqT1NvJjATe7AKJdwJJqlDRsMsEIcxS+Jr+QR1Wbgn2tJldkAcOe
         YIFg==
X-Forwarded-Encrypted: i=1; AJvYcCW3Y4dhwO/8JLcbPnRslS62jRDVFMxjCy2cP/oh4aoyudFZxbmWh+F+V5413m4JxDWKKfXN8PNKtLppcN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya43B7pXBPuuO0y4CRQeetkp1sBNciTAL4A+mlpLmGxH2zQXBG
	I7wmjQu8O0ZxLlj36UirTkPzkoFzdL4QkToMsAp61lX4kdlOQQ9FQ5oGlU6Cs/i97WitBZXa/YM
	db+Rwzw==
X-Gm-Gg: ASbGncuHJry6aww/9FY19JUK3puUeWLrVyWoQepAxqr+ZPpkdib52PibHLeH9pGLo1H
	mysYpZ5UzDf2Ckque5Ctwb2Wnr7hjOXZF2gdagDM5Vr5PV0bDkWGRpqyJpVIItOeQpJF7e046qr
	QYygj5La8AAHl7R9aACKFKUeoiSeAv51zhvc3Q4zwQ2vidldZthGf14FFlLOuBQFceaQOnSm47d
	j8MxVOFy4QC9vX8xinnn+SDu3LpIiuHZ1dup4v9z2R3Qh9Ftb0PxbN1FgMaw3RnFh7QXma50A9E
	HUGeanCLtTusdQ5nq3KZkuABJ52tbkzd1b7ES6WnTyy+rqFXUwt007QJLCIlzlEPllk9uyt96yE
	x
X-Google-Smtp-Source: AGHT+IF5LAcgRJhqR8hg+3aLZi/FvVsbE0GKYreyqfwcChp6l317p9Zewua2m75QwUyHlzbTZp67yA==
X-Received: by 2002:a17:907:2d21:b0:abe:fb28:e69 with SMTP id a640c23a62f3a-abf260d4a22mr14736766b.25.1740675138110;
        Thu, 27 Feb 2025 08:52:18 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c101415sm149327366b.81.2025.02.27.08.52.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 08:52:16 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abb7a6ee2deso178975466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:52:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWCviBg7gG4j69yVW7Y1B1O0ThXoofTRKxc6TT458RzhFsrY+bYq0b4xFytGA/g/Il7ANbLje7PdDb7eyA=@vger.kernel.org
X-Received: by 2002:a17:907:2d25:b0:abc:269d:d534 with SMTP id
 a640c23a62f3a-abf265a3664mr12415966b.40.1740675136315; Thu, 27 Feb 2025
 08:52:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226213714.4040853-1-arnd@kernel.org> <20250226213714.4040853-6-arnd@kernel.org>
 <572DCA31-1CCA-45FB-ADCD-29C24A527437@zytor.com>
In-Reply-To: <572DCA31-1CCA-45FB-ADCD-29C24A527437@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 27 Feb 2025 08:51:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjFb7jeWXB2wovPeHqZ7XaxfiCbb+Vgk9FeGO2pcY78zA@mail.gmail.com>
X-Gm-Features: AQ5f1Jq8-a2PyFbc-bTfKcSFDNAin9Eic-n5_B5Vd56_bIFUaTIOK1h2JGhoJXk
Message-ID: <CAHk-=wjFb7jeWXB2wovPeHqZ7XaxfiCbb+Vgk9FeGO2pcY78zA@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] x86: remove HIGHMEM64G support
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Feb 2025 at 07:41, H. Peter Anvin <hpa@zytor.com> wrote:
>
> One of the generations of kernel.org ran on a dual socket system with
> 6 GiB RAM. It was a mess; basically it achieved less than 50% memory
> utilization because of highmem.

I'll be very very happy when HIGHMEM is gone completely, but yes,
HIGHMEM64G was particularly painful.

It was definitely used, and it worked better under some loads than
others (large user footprints with lots of anonymous memory and little
kernel side memory pressure), but it was not great in general.

I suspect that absolutely everybody who ever used it switched to
64-bit as soon as humanly possible and nobody has likely actively used
it for a *long* time.

Good riddance,

            Linus

