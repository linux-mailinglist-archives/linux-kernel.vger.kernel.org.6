Return-Path: <linux-kernel+bounces-563720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E3EA64737
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683493B5440
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39182222C7;
	Mon, 17 Mar 2025 09:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xy/tzjt0"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EC9221F1B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742203449; cv=none; b=PPTMZIpBNwtVOhsJijxcIwe+PyOnBwS3GKL6qdkTw5QYgoDpYtq+xnM32V1lBERsq5skYwG/M7yRLWcUyGTW1qa7Fk0UO129DtW4GYzXvQNb7mm2IgpjrmxCO4vVE5sF/iubme55ZvUsrpH7WXl7foSM+vw6mo6ysxi1T4UyG6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742203449; c=relaxed/simple;
	bh=n20nGFxTmcJaZG2reuyyngVL2ZIPOhrefpjSOvNbBzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kwz7Ns+omE1dzNvWPTxE2M4AavVB4qC/Wbu7C0qpN4ePFaw3aRreHq1zplqsAfqbyNF8XpVfCU0/NDgbikvg9BBJFGKCTTXL0jsX1vVIBYPLykGU+UOLwL5vffzJ0RgMVVhNS/XUg7a/2USz4Ttbb7WJyZyA98zISJd03cOQs68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xy/tzjt0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2255003f4c6so67754945ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 02:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742203447; x=1742808247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qX0t6hmEl/ttFwtNba0D0ghdF1Z5CR+NbGCxyEIf37s=;
        b=xy/tzjt0G76DGeZ+YqH3trc1+czZxDUza6y5SNjHEfjkXJlQbjs2nk4R6RgizLAB/8
         J8RZy35kWjoi4kiznEPSthe+/yCRU4QNvp1icYHTrJOgcfb5ZCNYt7kxQVtNWYFxNLzn
         PlN5SRjOUhYxYpqZkuoAn32MoX+eYXQU4HKzhHcTx9wZj7sTnKBss/NiIVIMC5GS1JRm
         GWWa8b3eA5Y5KGvno5lmRK4Y1ATOc7drWzbisOKpt9Lg4/LJ6wzKu4hcVFT+lPXoq2Gz
         9kGs+L2Re4M3OugBI7zMZGa+plzb8VUKZvTPBltKdbVa+j8IGyeHdBe0b4sk+nae+j9m
         G+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742203447; x=1742808247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qX0t6hmEl/ttFwtNba0D0ghdF1Z5CR+NbGCxyEIf37s=;
        b=PVC4nLlaOPkZRclI/yLrqfyRrtM2zNmp9pYfsw4ioR70z0M2k7TkyxStxaISgNwb/A
         ydfKxHxfkjRQfo1j4uJnIKnl4kb9wNF6oVeOlVyFwNjXyyK4O2z/1u3BJeUWeaTQadJn
         S5CEU2o3XppAVCepWi89IPIFKikVA0PbRnai2atXnPMEbiVY2u7rs3/KLqOSNp4ATFO6
         1X4Dl+J2/0/HQGQr8TlYySUUavToZ+qRVqtHHdJ33N3dfFnc729pPkP7JiQTysItI7ze
         2NEMGDgSdBygd5ZBSBOcz/n5AubvLscaP9O3o6VM7/2PvV9s9RyET+zVbi6pT31zAOI/
         TqxA==
X-Forwarded-Encrypted: i=1; AJvYcCXZd2uWPRFljKOef0SJXYoe8AbktNdVd4J8lh+sbnnuJJooqS/cckjg/bmG0fznoJqS+KWNrnxffHeWSNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YystiMWcranokH9VS/4zY7p2Rh0eDQ9X6PF1QQOT87bYHUSTs3v
	+BVZyAnlItMdA3qLhRljTRKVGeGTdmAnOdekvhNN8ViY+yP1my2WAdTp0BC0O5I=
X-Gm-Gg: ASbGncv8POWYnnA+1Cia05buokffPEbGdvCL95RQg7NrlXGfjsVKniW2wx7hDrthmoL
	d5w0C+77c5vq2dKY8SUJPAm6H5756HwsjKn7Q6VBoqT3miG77rWtKNbZMaou1zYeecKPiGNcovj
	I6LloLk/kcuGiLxaUSZrV8xWOjWD9S8VB5dVngFj7H4TbnAwVJBrcNwlCRi6RnDfSRgehEQWTuC
	NbmtY5amNB/VQWEH7Ren7RpXfRtls1IyoVWHECCjmoxbPRbpeSimsH2M5PxsvSqdAju4pZW0rk3
	o0qnB17JyMwrZLBFH7t5qt39MFEXwXw+zZ8mf7b+7YFp7w==
X-Google-Smtp-Source: AGHT+IGJ/2dHOLsZIbIG2tr0KpKh72aCjWHwXgPaFwja0OjiG43diYcHNku0fI+Vv1FDoPAaGUSjNQ==
X-Received: by 2002:a17:902:d482:b0:224:1074:63af with SMTP id d9443c01a7336-225e0aef7c4mr157534905ad.34.1742203446830;
        Mon, 17 Mar 2025 02:24:06 -0700 (PDT)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68883fesm70839775ad.6.2025.03.17.02.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 02:24:06 -0700 (PDT)
Date: Mon, 17 Mar 2025 14:54:03 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Yury Norov <yury.norov@gmail.com>, Akira Yokosawa <akiyks@gmail.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] cpumask: Fix kernel-doc formatting errors in
 cpumask.h
Message-ID: <20250317092403.uphmlx7u52ntvih5@vireshk-i7>
References: <cover.1741332579.git.viresh.kumar@linaro.org>
 <f4ad81150eaa00b43c161f0d1f811f8ecfe21889.1741332579.git.viresh.kumar@linaro.org>
 <Z8snakYmzhaavkKN@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8snakYmzhaavkKN@thinkpad>

Hi Yury / Akira / Mauro,

On 07-03-25, 12:05, Yury Norov wrote:
> On Fri, Mar 07, 2025 at 01:04:51PM +0530, Viresh Kumar wrote:
> >  /**
> > - * cpumask_next_and - get the next cpu in *src1p & *src2p
> > + * cpumask_next_and - get the next cpu in *@src1p & *@src2p
> >   * @n: the cpu prior to the place to search (i.e. return will be > @n)
> >   * @src1p: the first cpumask pointer
> >   * @src2p: the second cpumask pointer
> 
> So the question: if some word in this particular comment block is
> prefixed with @ symbol, can we teach kernel-doc to consider every
> occurrence of this word as a variable?
> 
> Why I'm asking: before the "*src1p & *src2p" was a line of C code.
> And because we are all C programmers here, it's really simple to ident
> it and decode. After it looks like something weird, and I think many
> of us will just mentally skip it.
> 
> I like kernel-docs and everything, but again, kernel sources should
> stay readable, and particularly comments should stay human-readable.

I was looking to get a public links to cpumask APIs, like:

https://docs.kernel.org/core-api/kernel-api.html#bitmap-operations

which I can use from the (WIP) Rust cpumask documentation.

Can you suggest how do I move ahead with this ?

- Let the warnings be there and keep the comment as "... cpu in *src1p & *stc2p" ?

- Something like what Mauro suggested: "... cpu in @src1p and @stc2p" ? 

- Something else ?

-- 
viresh

