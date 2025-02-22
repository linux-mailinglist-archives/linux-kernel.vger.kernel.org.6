Return-Path: <linux-kernel+bounces-527275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45ABDA40915
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 15:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BDDD18838B4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 14:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADB0190477;
	Sat, 22 Feb 2025 14:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dxkqJ/Zo"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02193188583
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 14:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740234481; cv=none; b=eNmOgsXlUD3LFcg6bcvh2sQUXybVT2pJ0Akt+nyfnJtGevxN7rmypbR3zHi4cGnENahjM1nAWHe7g3NQTJeD0J/Y34YK+LJzS813GGRl84Ei/OsdIqqVolarkXS9bjto8clesF9KkefJXZIngKWA4kFnJ8IhFVUbVLCBGLfZVpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740234481; c=relaxed/simple;
	bh=bWACM+CIjldQm4d9hS/Qm6lGurt3JhxvPdGMNHlxy0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hr0vofHpxTwBS2q1jJ/Ab03RRnS1dGWxw9K5Zorl+VKbpdCBlgHlE6IzpXkOXn+2RBfMDJcjn6/65EZaQdnatr4e8uRppzQukWpb9v1wb9MNoX/u54TEKlgQ69rt4quDzrM3uiAJdOk412NMieFZA6hXo8Q+4GkEUAVo1+4KpuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dxkqJ/Zo; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22128b7d587so58919505ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 06:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740234478; x=1740839278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zPvXDuvmRAhrxvOfwR/RABZWu0CVYBLRPN9dNRxz0ZQ=;
        b=dxkqJ/Zo4IHG6c6YmFhgu+5m28TWxFKUwGXLAWzjW+dWaarfqW2+cvVx93Q/Dq0Ne1
         InEs4nm8o+8CiO/1vkOEGMbwDsU/bHOq5rCML7uch45uLBlTO0hRTCpPtA3zOc57r0X+
         bgw8Sy+pvQP1Y0CXdHTT2vDfqhhwoxbWtCSCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740234478; x=1740839278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPvXDuvmRAhrxvOfwR/RABZWu0CVYBLRPN9dNRxz0ZQ=;
        b=bUGEg+zKTn8W6XpZMHMXfiIkKCL6VUs+KTpzATmuiZVECpeQtyY7cwD2C/4OJ4d6LN
         feNmODgvgTzI4b1Qe01/6W5PdoV0+HagHuVlz1/ib8z0dQBbHKlrE8MpgkwUTJVSaVHU
         tJaVy/ET0mCvaBOC0br/2uzLPskFgM4/yeaa/UdcP/TAXYaoug7pa/2vf4MCBgBCy4LC
         70Nqrd2HuxsG6iUY0JktWFMGaTq27Re6vnfqOQcWd+Wb0qFgFLUyRakuqrnD1wfEbRYK
         l9fQzBgTMy4XamhLA/9wdiWlL2wj1T2CUI4wqLkn1/18IkQpPNRuDDsbmp1vNL9T1ddT
         QLCg==
X-Forwarded-Encrypted: i=1; AJvYcCWFGfoheCM4BP2zDXBlq8HkAH8a+NglYtzGYnwWc6UjIDFkqvQCneNuR04efQxcdJngo8ynhOttZaBGwEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxr0KfU5f6rNMaZpWuevIFImiCZS4LVXp/0v17nrYTZBJtCBGK
	8jNiL4siMkfIkQdlPDyTfxBQfL70gnukzpPexxJxAyKZUEtrX4WADJQZKDE8iw==
X-Gm-Gg: ASbGncsHwPe84xNN4xoFw8bRBNvmutXmqDK/WgtUmTaItbhiYReYq6z2wQOQKDyIvDe
	1d3OWAtYsUfHTOEivy55Dk1qd9SXjqLE0yNcqyPFJeI8KIFnRA/iqfEzqj6h6xR/CNNRtHtrtIN
	/cyu3/cjP+pLLcfcYo0hSFaa5gFz0wZXqNDczEdzRcI8IUkJk8PvGUq9Um/SL36PvUHAxA/APyo
	y/vNMbFct3jFDSBtvfH45NIa8H1yr+Rw8f9hJpp4EuzWMJOQVKLogbxPz9GMq7Vwqta2dcRD4ek
	Q3APHkY9lKTip3wMlnRQRUMjL64y
X-Google-Smtp-Source: AGHT+IFPJedH8sKLSfD18g5iptfNHmHTIVM0EgNuwafBBp4M2gx2umVIm3KLNGcBsyHiBaQenJCWGg==
X-Received: by 2002:a05:6a21:501:b0:1d9:c615:d1e6 with SMTP id adf61e73a8af0-1eef3b1aa6dmr12909888637.0.1740234478261;
        Sat, 22 Feb 2025 06:27:58 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:badf:54f:bbc8:4593])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7327fa51eb9sm11016305b3a.166.2025.02.22.06.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 06:27:57 -0800 (PST)
Date: Sat, 22 Feb 2025 23:27:49 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Barry Song <21cnbao@gmail.com>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>, Minchan Kim <minchan@kernel.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>, 
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, "usamaarif642@gmail.com" <usamaarif642@gmail.com>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, 
	"clabbe@baylibre.com" <clabbe@baylibre.com>, "ardb@kernel.org" <ardb@kernel.org>, 
	"ebiggers@google.com" <ebiggers@google.com>, "surenb@google.com" <surenb@google.com>, 
	"Accardi, Kristen C" <kristen.c.accardi@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, 
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v5 02/12] crypto: acomp - Define new interfaces for
 compress/decompress batching.
Message-ID: <lu3j2kr3m2b53ze2covbywh6a7vvrscbkoplwnq4ov24g2cfso@572bdcsobd4a>
References: <SJ0PR11MB5678851E3E6BA49A99D8BAE2C9102@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkatpOaortT8Si5GfxprvgPR+bzxwTSOR0rsaRUstdqNMQ@mail.gmail.com>
 <SJ0PR11MB5678034533E3FAD7B16E2758C9112@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkbRHkb7Znzto6=RRDQA9zXZSva43GukhBEfjrgm1qOxHw@mail.gmail.com>
 <Z3yMNI_DbkKBKJxO@gondor.apana.org.au>
 <CAJD7tkaTuNWF42+CoCLruPZks3F7H9mS=6S74cmXnyWz-2tuPw@mail.gmail.com>
 <Z7F1B_blIbByYBzz@gondor.apana.org.au>
 <Z7dnPh4tPxLO1UEo@google.com>
 <CAGsJ_4yVFG-C=nJWp8xda3eLZENc4dpU-d4VyFswOitiXe+G_Q@mail.gmail.com>
 <dhj6msbvbyoz7iwrjnjkvoljvkh2pgxrwzqf67gdinverixvr5@e3ld7oeketgw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dhj6msbvbyoz7iwrjnjkvoljvkh2pgxrwzqf67gdinverixvr5@e3ld7oeketgw>

On (25/02/22 21:31), Sergey Senozhatsky wrote:
> > As long as crypto drivers consistently return -ENOSP or a specific error
> > code for dst_buf overflow, we should be able to eliminate the
> > 2*PAGE_SIZE buffer.
> > 
> > My point is:
> > 1. All drivers must be capable of handling dst_buf overflow.
> > 2. All drivers must return a consistent and dedicated error code for
> > dst_buf overflow.

So I didn't look at all of them, but at least S/W lzo1 doesn't even
have a notion of max-output-len.  lzo1x_1_compress() accepts a pointer
to out_len which tells the size of output stream (the algorithm is free
to produce any), so there is no dst_buf overflow as far as lzo1 is
concerned.  Unless I'm missing something or misunderstanding your points.

