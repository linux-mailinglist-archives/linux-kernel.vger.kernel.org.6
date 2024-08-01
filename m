Return-Path: <linux-kernel+bounces-270577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A91A2944194
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 05:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53DED1F23037
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 03:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBD013D898;
	Thu,  1 Aug 2024 03:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kRSBvmi4"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7840513D889
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 03:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722481991; cv=none; b=HZhf0C6e/0lta4jAgP9UKJbbWY/+MMHRYO91iXMXloGSztSnSZpDjUZMfOobU1zEpdcA4oT9DYn2GkM0abx0aIUqlASh4a9N17seziOmsN8jD3QD357ZrDSUjG9h6nDaqzMJLyFL2XAoCL2awGmG0n0uDB9HyHprpcK+Pc3ijqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722481991; c=relaxed/simple;
	bh=ecOnCIOS3T8NyGm2iciQxq86cjmgzMyP+x4NhA5J8Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1LGsCmyBhhKrMK/AWis1awOcDFwPYF/5ftUY3MtuT0lZIwAH8abEIJ6YEvQ6QNI16tDJl1a2E2LL2Rvf2KA2u4TPqjC4B9mmIl762S4u5wS+X+lX65q7lT9dyyh3rnXJZKRIJNtG9uNw4V7XUqSC+c0OHiC0xuGtFvuBp5MXoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kRSBvmi4; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-6bce380eb96so3964213a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 20:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722481990; x=1723086790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IDwVKJLacT/8W+BOY0Lh73qJbUqMV8nEA0zMYmTJMpk=;
        b=kRSBvmi41vZD7jaQVMzHjD4MEn3ZeVLwLx7Jwe3hjIP61P/U/Zk8yBbx+zZcion/3c
         f413AxFJWT539GgfN0mkNTZQYE0pUwB9HWraAeGgKXjAFExMlap2oND79lceqEDr3gIf
         bU7sAfnJr92e0u1cAQDUUp29QpU5KIm3r43uY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722481990; x=1723086790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDwVKJLacT/8W+BOY0Lh73qJbUqMV8nEA0zMYmTJMpk=;
        b=VwCIdTofy8p07OArf1p0ydhNOSDSxCKDR3EfnOQdEmUXk4a0ZNU6cEzzDj709E5yMN
         EKM3PQm1HH/XwBz5aOc9rH9RNO0fnVu+bXC/XJsSWgwEzFcILeQjkeygdRAO9+HOxXLz
         AP+IavzKFiZTWgUrXWK2WfnBjdOcFOHI1LZ5b8mcLTCNORic1PM7wT1tCImzC2+7sKf4
         kcf88tPeDYGYuEvsrOeZxe6BC0ve6IsIFQwjgsECZ9DVNG8MxoG8DHPjJI/sHyLO1WfM
         wIZVDOKvXqtt/4xbxAAnYDm78NLPVpVA+AUEftEx/UWzNwytCumKFaYNFELrKa7gCw3w
         O2KA==
X-Forwarded-Encrypted: i=1; AJvYcCUakyiaMSdGvCeCa5KlnAOrmJWEzhvKwZFpJoWzNBNvi9DIsmWZ7R20/ZVY2nl3pr5IMvzsGAXILnkzfNWQ7T1ZiT2ToGl4Sy4zgpNJ
X-Gm-Message-State: AOJu0Yw3Jksgm5AOYS2ZEnYkEaOCRYQ0RpbB2IemC22IqSsPWFH9iJOy
	W2aqW/Dl8U8n/yzhzzdmYCQ9mS6zcwmbG+Mo5XnpyifXVqVBYCaHvuM8x51e4TeX9agTrLZKrR7
	cWw==
X-Google-Smtp-Source: AGHT+IG61gMvEEw/hJLHJWg4o4hHvYkubdgaUu6RT/iNCsNthhAqCrYIclJxF2FpWoLrdEwXgzwYbA==
X-Received: by 2002:a05:6a21:164e:b0:1c4:bf4a:6c0e with SMTP id adf61e73a8af0-1c68cfa47cbmr1414800637.26.1722481989728;
        Wed, 31 Jul 2024 20:13:09 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:153:1133:6aa8:dcc7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7d15e98sm127934545ad.99.2024.07.31.20.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 20:13:09 -0700 (PDT)
Date: Thu, 1 Aug 2024 12:13:04 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Alex Shi <seakeel@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, alexs@kernel.org,
	Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	minchan@kernel.org, willy@infradead.org, david@redhat.com,
	42.hyeyoo@gmail.com, Yosry Ahmed <yosryahmed@google.com>,
	nphamcs@gmail.com
Subject: Re: [PATCH v4 22/22] mm/zsmalloc: update comments for page->zpdesc
 changes
Message-ID: <20240801031304.GF16599@google.com>
References: <20240729112534.3416707-1-alexs@kernel.org>
 <20240729112534.3416707-23-alexs@kernel.org>
 <20240730093726.GB16599@google.com>
 <8fc7939b-416a-4328-9df2-488f17783543@gmail.com>
 <20240731021619.GD16599@google.com>
 <c614ec0c-ff5c-4ef6-8542-53ee5308f62a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c614ec0c-ff5c-4ef6-8542-53ee5308f62a@gmail.com>

On (24/07/31 12:14), Alex Shi wrote:
> > A bit of a different thing, still documentation related tho: do
> > we want to do something about comments that mention page_lock in
> > zsmalloc.c?
> 
> Good question!
> 
> There are some comments mentioned about the page_lock in the file, but missed
> in the header of file, so how about the following adding:

And e.g. things like

`The page locks trylock_zspage got will be released by __free_zspage.`

Should this (and the rest) spell "zpdesc locks" or something? Or do
we still want to refer to it as "page lock"?

