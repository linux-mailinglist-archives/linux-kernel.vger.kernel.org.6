Return-Path: <linux-kernel+bounces-295526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7D2959C4B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A9CFB26A1F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B9D18F2E2;
	Wed, 21 Aug 2024 12:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CDgZsUrT"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7654199930
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 12:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244393; cv=none; b=K3TYDVNpel3HO9gLTlTU2so9HluFXJnL26PqIOH+fb3oimtod9P33/lJIeuo5kcB7Ae++YdOE1I3x+xX1LAI5bMFuTYHY3Li0iNarwn92wqtQkx/EVanpgJP27Co/+BTpeghJRSDjgdAX9zMj0wBX8Ecfv5L4kjh8rHZfVpVjOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244393; c=relaxed/simple;
	bh=u6b5rlgS6etWV95fNigBuHk9KVmkdeoUxs/HCe/Yqr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g86ZWFxY+kqAWMeWm6N/AXtEN3bvkAoOwbqpokbeW5FCPz68tGnzxJO5QNfoYvNSPDTwH7/1DE6ycqvx2KEvYIzRF4vVM7RW1j4L5UT9B7Dx7OVgmcnghdkUofdVC/CQXln4gXL6WUKTrZICDG/r206XYk6+9fPZrLJtwZhv+KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CDgZsUrT; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7de4364ca8so731202466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 05:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724244388; x=1724849188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WPDxfukU7D+k6PvjY6DO8kGFmU418euxtFR1jxG8a3U=;
        b=CDgZsUrTC8kxdzfnqgwvbt2EAFwVn4zG/ztZJBN+zDR5eyp5gP1DPcbSyOFxqJpkaV
         Rgf91CldmbJ2NJrdqki6U54gcqhxsiR0kRMFUxoA+hgfwAH7vqSO7K+5nX7+R5VMFYoX
         Y8IAphKGsxlHQOVUHgUcM/fQTnwU2Hqu2RXORm3KKg0P06oJNW49Ylla935qVMulOR0l
         vg5LfmyEg8+fGhvN/SODyAekkFULyJhnRmpND/hQz4LieGCAFVt2rwI7jmtrk5iJrLBq
         JMuckNq3iiM/92C4VrpeOqbzcFh/A8gBttKf9wxBaEBCFABZBWe2AUoekl+1V08vH0pu
         5/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724244388; x=1724849188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPDxfukU7D+k6PvjY6DO8kGFmU418euxtFR1jxG8a3U=;
        b=jdUYa5PuvD8dM/Nv0Lqv9VKTtFAx8rN13Enb6anx1iqR68HuZp52yKG7ZIH5R4SSfQ
         /Qvvj1h0owuTvVwCoCXEoouI9IxbhSDMIgpwIzILoq7r83E+IEJQZCljYXyteqqsRnH4
         jOTy8ZXqbkFY4qz71hsu0v831oJfUHnEvv2USBSNEkI704pB6vby8efvj7WgNT+5uRTm
         pa5Dyf11mh5OaUxZWtwBu4IDHTzjIBSZenbJnBm8awRgdHFCGgB0TDgokCPOAN080xiD
         3RDiYy1yXDp+e91ul9stbc9YGwoUY7zZyPjCn4R4YLjmNP7ukvt08fIRERpic3ZmuWwh
         yEEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfeDUlAxe868kSaIZCeA+XHZiacP7RPG2UH4QA6/+U7+5Y84SLIUcTVpWroSXIVlop5ckLjkU9z+fYTjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8V8txEaUh/YMIWzoPRGCicCPaypBO9nQkT7TBk3GipsdADgWg
	g5vjycxtNHGEPOvnotbVk7/GLI/u/u/dOMk8tcbl2ueCBKqeY/utZXO8uqozQVA=
X-Google-Smtp-Source: AGHT+IHn4E5EqjDPKeqAdrDFu+oHOt1XiIACiD1UV6BOgaaiUHaMkH9DJkd7w5V2YdfWdsj7RhtZjA==
X-Received: by 2002:a17:906:6a12:b0:a86:43c0:4270 with SMTP id a640c23a62f3a-a866f120169mr123879966b.13.1724244388493;
        Wed, 21 Aug 2024 05:46:28 -0700 (PDT)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838d0271sm892634966b.82.2024.08.21.05.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 05:46:28 -0700 (PDT)
Date: Wed, 21 Aug 2024 14:46:27 +0200
From: Michal Hocko <mhocko@suse.com>
To: gaoxu <gaoxu2@honor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Suren Baghdasaryan <surenb@google.com>, Shaohua Li <shli@fb.com>,
	yipengxiang <yipengxiang@honor.com>,
	fengbaopeng <fengbaopeng@honor.com>,
	Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH v2] mm: add lazyfree folio to lru tail
Message-ID: <ZsXho27uAbQ5rEgS@tiehlicka>
References: <f29f64e29c08427b95e3df30a5770056@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f29f64e29c08427b95e3df30a5770056@honor.com>

On Fri 16-08-24 07:48:01, gaoxu wrote:
> Replace lruvec_add_folio with lruvec_add_folio_tail in the lru_lazyfree_fn:
> 1. The lazy-free folio is added to the LRU_INACTIVE_FILE list. If it's
>    moved to the LRU tail, it allows for faster release lazy-free folio and
>    reduces the impact on file refault.

This has been discussed when MADV_FREE was introduced. The question was
whether this memory has a lower priority than other inactive memory that
has been marked that way longer ago. Also consider several MADV_FREE
users should they be LIFO from the reclaim POV?

-- 
Michal Hocko
SUSE Labs

