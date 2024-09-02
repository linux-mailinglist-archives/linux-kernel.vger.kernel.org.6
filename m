Return-Path: <linux-kernel+bounces-311713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DCE968CA1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 19:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34B61C21199
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EB21AB6E0;
	Mon,  2 Sep 2024 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEqqbEL3"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80D313D50A
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725296589; cv=none; b=DTWohZEgrLcu6oDU+C8zq7aFByxHj21G/LHVWBNnvWoS6ePJ7Hfkiy4mwQUOWRa/G637ivVuURJFsqDpK6RVeASmPn1JODLND5SsJLqwBuhy+THfb7JNd/siYxTOGXjeVJPJX5F5i5K/gbt+TXL9ZMv2yB1EGRsEm1+/o4i2Fpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725296589; c=relaxed/simple;
	bh=x5wE2DDKvv6+OHQ+coR9qHrGW2vQFgeLrtlp2gRRsBI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQ+NyAqiykPNNufrpq0bwa+dQEFEfw1fT2AgCilvoCUMSRZ8N1Re2TNu8T7YpBq9J7LTmlo1yatyT46fdra3LpHwxEiy9qHp9ve2uCYQnCARcAw7536ocXNHIKK7BKKvNnDor8cdUEOyNyWGlusgO+g+rI9q4pmWCmXSPHjYLBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEqqbEL3; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f51b67e16dso50522321fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 10:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725296586; x=1725901386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+JSYR2Z+n9TGP0d666feNqOWhgoU2mK/WUfppMAONMU=;
        b=HEqqbEL3CEmHHfSxMjnACJ8IOHNoECr2y9+LlaRUa4qO5Q6rieEpxheivdPmVLOqhU
         oTC+HQKD2JfXGz6MAptDA56lbne0ifPSsO3EUB5E4t0bh+XUoFqfgReh7bml8OF47L0A
         GdK/SrTKYaVSZ2qm3A/MHieyLWelInq71wuvmHdpxHQ+9kHFSEP0MvgoB6ofsvM2FgR/
         wjnAs2zq4TVsUv9+mkqprGBy8MAjLjYvp+/p9S+ehXg4Z4IP+GgFX3RAM5lLZDOTCfUG
         eykZ5Jyzj1BmG+fWRoxmmq5LWAFqP3iGzTNMrT61PFP459db6KxwxDZ87yBEP+qUAPca
         /AMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725296586; x=1725901386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JSYR2Z+n9TGP0d666feNqOWhgoU2mK/WUfppMAONMU=;
        b=YiHQp6Mk54ZZzmBoK4D3z8XCmVQI4xreQie8GGRL1ftZGPHMsLPC23EKdSVzqDgTXu
         QbnOth373iPOQtTVioUxK9ubFas0WL6JwT+RduB/8w+H/JWNmAjnaZgsDjwqEt2XbIJ7
         nVSWvNgsq8S0hFu1OOSdqP3xCxMHrBI5Cno8nSRWzWPu7+LrvBQ65VFCQ4KoZupRCVsz
         h+yVwrMJJEvguiIQewtgP04K7V9fCA/VKPVCswVcs464MemR+Tk6mc7LZ/14IbsgjTM8
         NnT3uLQUj3KHzMkpkzAJx6EstXnInP4iXOPuqJrL9Rm5aXrbPFEcnjP9v/PNcFWCvb1j
         hQPQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1WxngrrluXM49v4xfNKGhlnKG2a1EJgX/yuoxJRA6BNOXFgH/nBmT19a6PeB9mjA70AL34e8dMqxH06s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpUTSSwkI/zaiLabywQ9e0f9TA10L56X5yaJFm4q79HtmmabEs
	mAZyMnbeakk1VN21bYophPe7UYpXrQUsqH4P2ituyyna67Kvt/BgLjqiVw==
X-Google-Smtp-Source: AGHT+IGQqls70Mjc+NYF2v4214Le4kWQPZVljO8bj3AhiqIMRuDRnQGw5yrZe/8wKCBEP9JGGn1Mwg==
X-Received: by 2002:a05:651c:b29:b0:2f4:36c:9c4b with SMTP id 38308e7fff4ca-2f6108908c6mr114282191fa.39.1725296585006;
        Mon, 02 Sep 2024 10:03:05 -0700 (PDT)
Received: from pc636 (host-90-233-206-146.mobileonline.telia.com. [90.233.206.146])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f615183134sm19376071fa.122.2024.09.02.10.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 10:03:04 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 2 Sep 2024 19:03:02 +0200
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Adrian Huang <adrianhuang0701@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Adrian Huang <ahuang12@lenovo.com>
Subject: Re: [PATCH 1/1] mm: vmalloc: Optimize vmap_lazy_nr arithmetic when
 purging each vmap_area
Message-ID: <ZtXvxuD-xkUkveRo@pc636>
References: <20240829130633.2184-1-ahuang12@lenovo.com>
 <ZtDFQHGHMq6TfbKA@pc636>
 <ZtHyxvscMuxHQkaO@pc636>
 <ea017b05-7a42-4d3a-a1f2-9bceb56966e3@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea017b05-7a42-4d3a-a1f2-9bceb56966e3@wanadoo.fr>

Hello!

> 
> Hi,
> 
> unrelated to your use case, but something that coud easily save a few cycles
> on some system, IMHO.
> 
> Maybe:
> 
> #if NR_CPUS > 1
> static __read_mostly unsigned int nr_vmap_nodes = 1;
> static __read_mostly unsigned int vmap_zone_size = 1;
> #else
> #define nr_vmap_nodes	1
> #define vmap_zone_size	1
> #endif
> 
> So that the compiler can do a better job because some loops can be optimized
> away and there is no need to access some memory to get theses values.
> 
> Not sure if such a use case can exist or is of any interest.
> 
> This is valide because of [1] and the #ifdef around the num_possible_cpus()
> declaration [2, 3].
> 
> 
> Just my 2c.
> 
Thank you, i see your point.

--
Uladzislau Rezki

