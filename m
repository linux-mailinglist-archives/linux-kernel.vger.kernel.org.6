Return-Path: <linux-kernel+bounces-312086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AA49691C7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 05:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144A21C21A13
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 03:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072631CF29C;
	Tue,  3 Sep 2024 03:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EJayCn+m"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6511CDFD0
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 03:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725333610; cv=none; b=C48Ga0nesxHpeDZEFA0IuAU/TG1FRtKyGcULlxZjknLwfODxo4RagXTArLVWgXaXWJW9gDTIVkJE0NxhA0o4EBHKb80RNs3sJ3VQgOaFgmJQgUnTIzc5FzDPya7mUzb5s8eSEAWBkXLghP3uDazZUHiaJ+wLJoRFMvstnmRo01Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725333610; c=relaxed/simple;
	bh=yfdoBCAkML46WxSGIJglV1/W26BtAXPMI9UVe75W7Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvORWmGx0HSW0Q2/TaMHSW5rLgqY3TnaY4D6K7TkhuqXKb7gkylf/1WjO7IEMRTdFq0KmrAoryEaaQA+Pc4ltBUgkv4QXhn6p9Zq8b5ACIYiJZ8z9fNVkkeMUl6Xemzt82tBEZcpLHKuk2PRLGwHDU6uWOhyw62fD/rrL7M+IhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EJayCn+m; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2021c08b95cso42446155ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 20:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725333608; x=1725938408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yfdoBCAkML46WxSGIJglV1/W26BtAXPMI9UVe75W7Go=;
        b=EJayCn+m0C6Z3BTL2RD6k8jGgDcUTJSgDidJqlCOOCSLyVY3rPvV+DqL7B5cKQ2QBf
         5n/kG7rjilz7nHy1K+XRVl1WxjrKjLx/GPsSbpm5uXdacAFTKXKmljFb+Nr/Qe7fadWs
         8gBtfbzsBUpd9SpJauCVSIilL0d0mu4rtL4so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725333608; x=1725938408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfdoBCAkML46WxSGIJglV1/W26BtAXPMI9UVe75W7Go=;
        b=pl6i4zMIg/UBaiuAVzZ5lmY/Zrie2IYSqKa7WubHTemCNAAc4FrC4cKuzUFzoDhUAP
         4X9sJ5AKrUlQBehLn1RiMTt4OII9d+wwyup4wNZwAJNsGBwGOKU6rNaCSaerJZL7Tkh2
         0otjlYXKkDB638/TBVtvZwR+wHrmzZT88967MB8JaT/5+mFbOceRmIYT+dRehBZAP1yo
         x72AexJwI5kmonvCJuTuBpDKKjGqsBJZPhlhNj5gbdZdqHep6wH3j6XQPmIwXzTVoKxw
         hA5v8q+g8rSsKXhKooXexXAkRUg87/FbrIpOgLpu9EboCaV/wHSUWVsjImPsWMAhwvQz
         qGig==
X-Forwarded-Encrypted: i=1; AJvYcCUgXyV3w84HVw1Cn81BgwTT02GV38j8ZwHwHKRq+QOPl28WL3T2rZUO/eOhKPrTkVN1IO+g6heYDuPOaDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzjyXABG0pTIp3lvs6VyGlk2KzaljD2iMohGZmsO0OcFfF4HRg
	Ev5oSIuEuVRjTOKWTkqfAKquRV3zb6zAiAzzknXoy+3JZ9gf1CE4EmnRopObcw==
X-Google-Smtp-Source: AGHT+IFE+S5EEeUYrPbfIa/3fbFiEpKDX9CUlCzp0dLYRDjbMDIBCK/amFepjzfXLWS3N8ITXXiiyQ==
X-Received: by 2002:a17:902:d2d2:b0:206:955c:67be with SMTP id d9443c01a7336-206955c6b8emr17790515ad.9.1725333608122;
        Mon, 02 Sep 2024 20:20:08 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:43a1:71e3:7464:e91b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152cd572sm72466505ad.88.2024.09.02.20.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 20:20:07 -0700 (PDT)
Date: Tue, 3 Sep 2024 12:20:03 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Vishal Moola <vishal.moola@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Matthew Wilcox <willy@infradead.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, alexs@kernel.org,
	Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, minchan@kernel.org, david@redhat.com,
	42.hyeyoo@gmail.com, nphamcs@gmail.com
Subject: Re: [PATCH v5 00/21] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
Message-ID: <20240903032003.GB9738@google.com>
References: <20240806022143.3924396-1-alexs@kernel.org>
 <20240806022311.3924442-1-alexs@kernel.org>
 <20240806123213.2a747a8321bdf452b3307fa9@linux-foundation.org>
 <CAJD7tkakcaLVWi0viUqaW0K81VoCuGmkCHN4KQXp5+SSJLMB9g@mail.gmail.com>
 <20240807051754.GA428000@google.com>
 <ZrQ9lrZKWdPR7Zfu@casper.infradead.org>
 <20240814060354.GC8686@google.com>
 <66ce5eed.170a0220.387c4d.276d@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66ce5eed.170a0220.387c4d.276d@mx.google.com>

On (24/08/27 16:19), Vishal Moola wrote:
>
> Or should we aim to leave zsmalloc as it is currently implemented?
>

Is this really an option?

