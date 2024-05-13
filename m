Return-Path: <linux-kernel+bounces-178057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E888C4803
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 22:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6961F21D3E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 20:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199287CF3A;
	Mon, 13 May 2024 20:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kmhAuAtT"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEB978C9B
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 20:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715630580; cv=none; b=f8fRcWvNuP2J8gjrItKNZ1J6DIXORb9YWsNHN8h2KLIJ1cTHilVx5t9oPM/Y+7KXwhO1TDvYGhV1aJPuNVSepOY8LKJt8xMAohwuxrhmBiH9AXAlssRjP16xR/FNAKEva7gCKYfKSBBKXULcWyZKXJ/Jy+dO5bvYWT8J7QFcKqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715630580; c=relaxed/simple;
	bh=vN/oZPVUM0VbKTBMpMyTJSQOi5UZXcQoj84jhnHinmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApDrLEZ/GvMalnjTe04r0wnOLNmsOBVywQ20P5lG+lAQrYqMukb8Y21np46Q+lmXWQOasVj78K+8bSbB3Y6ht4utv6KPQWwz/O6yAk9EL7uEnHaZt8n+sWa1NIbQPV1pi0C3/iyUIx1jvS6zu3hDoLiOnG+NieZ+cPYllFdOAoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kmhAuAtT; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ec4dc64c6cso33317035ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 13:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715630578; x=1716235378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L5nQNVYZPxKaKLdJxSwXvg5R8/O6lRnjptx4J93d4hY=;
        b=kmhAuAtTSRBDjVwsZJH4oVuUmfzhyMrIe8cZ8Tud4FCMLKQJmxIGplZNKhVLJgzmRV
         tTKI1lYGHn9XnIB+sI2nL0ONOCBEHPt3qzI9U2BlCTOq4Hv925YxS5K+nm2HpA2/aejE
         vTRZOyRXiIOGvH38XcbhF3rqnjcco6JwEtorg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715630578; x=1716235378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5nQNVYZPxKaKLdJxSwXvg5R8/O6lRnjptx4J93d4hY=;
        b=vIxF/orKTFS8KZmT+o6LLcX0IFqE+B8qBhJL6w6JgZ98mrj0k3LBOmDwpYy5x9Rra0
         LpBo6u7n997SvLKOfaKS7dC6QXNBjlPmu0QSz2kkFIKFQ6+gAodHyXWekCX/3PK36kMZ
         oNwvG5ys6G6EYnFxPaWI8oC2PAFtlxSBdJ60CdkfwAHnJlM2xIPSGqvtYRQzhi9+HSOg
         Ho98EasOXYXz0RMiLGJX2pOYGzrW4cwxxMf8KcYF3XddV3+fCg5s/qlAtQs0T78I5EP2
         8Or/HXeoLjTuAW1n5Y7nPCyf8xGhfsipHKN3yj1F2FUqaPioUfnJSiUEHtWPBcvZmMGa
         68cQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3R4Q4EF9gCLze8X0SySD0cBy+3vF1/RFrDug+/U7UCjZdYQukxtkniP0+QtTQoz0znUH42aU70F1O0o0EQqUOKSvbp4Ukun5ObWQS
X-Gm-Message-State: AOJu0YwHflNRYjeJyGY4Pq6A43vZo5Nrl8HKdTTrTje95K7sGPBn+EhA
	DUEbXPV5b0ce0RdjJT+DFJSnGE9K//7z3iL4Fx1BL6Ml0R8QgA9RDUWTabdf/g==
X-Google-Smtp-Source: AGHT+IG/kQjGxArMBt2gt0E87feuvucE0+UTE644XiSYwvBHzgRi5fADgV7o5cADuhUcHPkhpx2rNw==
X-Received: by 2002:a17:902:ce85:b0:1e5:11ac:a283 with SMTP id d9443c01a7336-1ef43d0ada2mr143038325ad.9.1715630576456;
        Mon, 13 May 2024 13:02:56 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c1368desm83578025ad.233.2024.05.13.13.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 13:02:56 -0700 (PDT)
Date: Mon, 13 May 2024 13:02:55 -0700
From: Kees Cook <keescook@chromium.org>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	x86@kernel.org, linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
	linux-integrity@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v2] x86: um: vdso: Disable UBSAN instrumentation
Message-ID: <202405131302.51918C1C1A@keescook>
References: <20240513131024.1309073-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513131024.1309073-1-roberto.sassu@huaweicloud.com>

On Mon, May 13, 2024 at 03:10:24PM +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> The UBSAN instrumentation cannot work in the vDSO since it is executing in
> userspace, so disable it in the Makefile. Fixes the build failures such as:
> 
>   CALL    scripts/checksyscalls.sh
>   VDSO    arch/x86/um/vdso/vdso.so.dbg
> arch/x86/um/vdso/vdso.so.dbg: undefined symbols found
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

This is fixed differently (and more universally) here:
https://lore.kernel.org/lkml/20240506133544.2861555-1-masahiroy@kernel.org/

-- 
Kees Cook

