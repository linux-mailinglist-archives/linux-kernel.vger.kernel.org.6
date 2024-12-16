Return-Path: <linux-kernel+bounces-447099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D95A9F2D46
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D497188A918
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A108E202C3E;
	Mon, 16 Dec 2024 09:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="H85/k+Jw"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663E02036E8
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734342446; cv=none; b=XPdbeldzggeBND37Tb3Pfk3rhvCS18fy2E2De+v8bDh+gOWJPX/rXJ/inlFy3Cig3BQuBFEbVF3WeyhUItfXeXQ1i0BZQBTDRFuU5Lw/Vstws51BUryfr4vFhrOQwkGkZ9zC/uhmeusfZzk8UQ4Bm3Yzo1kokvtX9JnpCjE7ZV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734342446; c=relaxed/simple;
	bh=BfwhoMEmCl4bzWZVdzsW/vy74IIm23dtlmSsoG0ijCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQ825zt/u7VvRzCYDpXueYLrau1VrGXm7qYlmxcHkneyOHEOs9Z9Iojq85htw0qhSC556XoinDhA/fr+5a8o4g2ONClAvCUptcCKt7SVKtyPAG9xN84521Nw80exildRGJeSkwFJFm6MKu9LDW9APaW4jlAcpNOCppNd0a4swno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=H85/k+Jw; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3d69e5b63so403193a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 01:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1734342443; x=1734947243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BfwhoMEmCl4bzWZVdzsW/vy74IIm23dtlmSsoG0ijCk=;
        b=H85/k+JwmsNlWhwwis8gUZ+L79P+MZjx2j7zeUolUlfyr7aKdsiTCL+lWDNebTMo2t
         /wejalIpQaF53k0IJZl4/lP1k2+zxKILfjR8JJWWZGv/LAjhtdCV4YRmPWQVtgK43WuA
         l2ZCqfAlxcfBzMNlqJlULaxaDmy2QQaH4oU20ruQQbTc7gGFL2fasLGvaAcYvZcv6rDx
         oKkX+oQGEJddITB4WN0brtEgz+snSoX3ADxYEzQoiJ/PDkrpG3njt8ASJ0mOYnOdEoj/
         cJ6FzF4kXs3rrFmCY+5wL6ZNFZBCjEu9DzPWIYT5ED8jjsrwgUQA0+2KQB+9EltDO5cd
         NiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734342443; x=1734947243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfwhoMEmCl4bzWZVdzsW/vy74IIm23dtlmSsoG0ijCk=;
        b=btfs6NRPgHmaXIeirzStBkbCekSQ8Q+tf+jeRuJiHPC0VZQGpCM+lX2BB5BtiDIFiU
         FLwnOIrcx4F/9/hEVSAtox9YHbkkuF7Hmb0hEudAsrsEL1Dca5+yf/g0dr85rqyKyPJY
         PRjFVhUJYyVHseEMTdD+sNmDu5ZEpkFEg2Erw9xbxBr0e1kby5Q9jhjOfkAgt0Qt/4J9
         QZsxADe+/x97hEUjictEg9gscyuKP9ma4uTk9w5OtKx/NO2LxY23l47iOHVeCPf59tX4
         EBI51mKyM1YoMF15lnrUsP1d54PIrxI0V0Chv1aRTUMWkc9AQtX0efdibseh1i3GbNou
         N0dg==
X-Forwarded-Encrypted: i=1; AJvYcCXKZott/iGNdlGxOdxF4GoIXFoZRkJRj46tnWGrWkjccEjYshvs9+UWrGgB9HDQpI5Hdl2bs5yyKJbuvxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx2XUDZzPKBpsUqSgXD1gfOIhJeHy5ygaNhfPOKCxNzh4M48cB
	ck3WWsrCqjUX/imSpP/waLPFuWJSUETMZ/3R4jW7l0LMjEBtMGyYCE6dI7jgX0g=
X-Gm-Gg: ASbGncv0hx9OD3JsrVed2vFCsO984Vb4KcbZgcPO9tfjXkwcxbJYirK2/JzezPRAGga
	a/0JYeRT6fLRM7N3E87MAqy1AGZ/7V096zRMygvUHB4RmIcbZhtHzHTeiJjtGQqznl6gw0e2FDK
	TlDA2k7sM4HkaHdgfIdX3M1wUli2dAEX3ErVlWLE6//vf5ciPuV2H/eDLbz43tuo0A8DOQcJLft
	TzPK9LjFHSVdTOy4shi2JDBqkPBFJ2D3zCkUtlGmIq65ttiAVjPyBkt2TG2HAY14+nMbN77Lrnm
	JDD9y8KbXbBXjNMMAxBXDhaWsZyVrzBKuWIn7PwqgR8zjw==
X-Google-Smtp-Source: AGHT+IHFeq/+nCe5ggsaLGepw/t531rWVuUQBmDN6QoOg6H6ozKl8Rg6N9Iw1AYH27D2IAU9zMcOww==
X-Received: by 2002:a17:907:3f8f:b0:aa6:ab00:7b9d with SMTP id a640c23a62f3a-aab7794039amr442095266b.4.1734342442726;
        Mon, 16 Dec 2024 01:47:22 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-ac7d-82cf-fd83-c610.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:ac7d:82cf:fd83:c610])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9600e02esm310913266b.15.2024.12.16.01.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 01:47:22 -0800 (PST)
Date: Mon, 16 Dec 2024 10:47:21 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
To: guoren@kernel.org
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, bjorn@rivosinc.com, 
	conor@kernel.org, leobras@redhat.com, alexghiti@rivosinc.com, atishp@rivosinc.com, 
	apatel@ventanamicro.com, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	parri.andrea@gmail.com, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] riscv: qspinlock: Add virt_spin_lock() support for KVM
 guests
Message-ID: <36jzgc7cpsvphw32wghpegb7t6ezsgd622bm2ws7syjj6mmah2@pameujabd32c>
References: <20241215161322.460832-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241215161322.460832-1-guoren@kernel.org>

2024-12-15T11:13:22-0500, guoren@kernel.org:
> Add a static key controlling whether virt_spin_lock() should be
> called or not. When running on bare metal set the new key to
> false.

Wouldn't re-using the combo spinlock qspinlock_key be better?

> The VM guests should fall back to a Test-and-Set spinlock,
> because fair locks have horrible lock 'holder' preemption issues.
> The virt_spin_lock_key would shortcut for the queued_spin_lock_-
> slowpath() function that allow virt_spin_lock to hijack it.

I think we want the proper paravirtualized slowpath, have the
discussions stalled on the SBI side?

Btw. how bad are the performance numbers without this patch?

Thanks.

