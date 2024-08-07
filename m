Return-Path: <linux-kernel+bounces-277303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27334949F0D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0376284216
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D210C19066E;
	Wed,  7 Aug 2024 05:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MNo/lHaC"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C377AB647
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 05:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723007881; cv=none; b=tpHhWUnmEHqZmdWPyhzHDlT8V10eQmCVrjIrgaFBJAFoDNjDwqm3CCf9S/Wr2SUeQzBFi5e8mZqj/4vixoK9fbq6VGzhLwy1SfxsphI8JZBwJUakLizqBJK6zr/AnU1Mjw6uq3MgRg4fre0e2sPSmLK/qGpKGq81FR/COugMZjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723007881; c=relaxed/simple;
	bh=Gub2kw+LS2F8XLbGJYCNm5TLkpJB/1AGqEHS95VAiBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0bALUibhqyIwh1Hjr2dHErMOeY7+1lc48rwuuoIlj1B+zqs1uMxxm3Q/A4DT+GJRfVHfC7FoktgDUAMf9jVB8liaJ6keJyymwpGrMe0Fhe4T9jU15kLx30iO08R+i+CvlPO4OtIkx15W0w6B7Kl1Ep0n2Vx9ZIR0nAubYqIRgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MNo/lHaC; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fc491f9b55so11551105ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 22:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723007879; x=1723612679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=moP0eby16V5Q/F0Gmx/wT7OwDvwPCvzY+Edv2BxmnB8=;
        b=MNo/lHaCLwQGNo0/0maT4d6YZcAK+3nQBRnC6OU3rsI5K89d3TxkY5RQYfQQMFLQOf
         7g4d4jmyCrwyLncjBJdTInW0eE2KAG6eyhgnSNfgSNjFW7whT+HhdYhbq8pNjjubxyxL
         js80JhhQmDltrWDiRLE4R03m9VizqYqcuSjh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723007879; x=1723612679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moP0eby16V5Q/F0Gmx/wT7OwDvwPCvzY+Edv2BxmnB8=;
        b=PxO5q0t2n6CIWuiguHs5Ti3nB23YOsfYij57txOImYip5ncKEU4UQQm6vHZ8sEv+wv
         REzN9HMVkbV6p0FHQGsprRB0PxfIswLIDd+wkVyFSoWI5t3V6KEZPXbRLqE9Odzxipz1
         9yQaQL7Jfj2d+NbxahhaMPn43FMyA0xLMr+nAsQnCOJEORPcofhaZgA/G/m1SDS8Iqdf
         NrYobBFw2IK7iAB07RDepFsbnoPWOeVtaa/jClW76uv4Y0FhuM50v2nQe43jW+sZa5nu
         iiqcWxAt3z6lDwF8k3AJ14K9fD5EXuQKve/qOQ+bis9mXwYQNFE2in4U3gfm1G+InXCT
         Xkxw==
X-Forwarded-Encrypted: i=1; AJvYcCWnh8DxGAj8IBfDcl5i7ev8qAsc3wz4xtXtCRsWL2mQZkLDZ+i9kvtBokHMvEyB2Uo0AXoIFXcCehk4AU4odA+I2cQM5IFyeGFseAO6
X-Gm-Message-State: AOJu0YyoJFWjUwH5/5mZfACnkbXcY9OGzZlI94sw9T2+CiX5AkKV5aeL
	N5HVoFfGB9ndns9K9A8Ec8tVyYG2UCCsK8Ot6BDdB1HvdymeM2WmaYH+STeCU6DuC2cnZxoksVx
	qDw==
X-Google-Smtp-Source: AGHT+IG7fnuePmRkmUJKTskUgLsDluay6BMheiuE3wvZNhLZcCk5AdmXcRwn112OGxvkwYU4xofbsw==
X-Received: by 2002:a17:902:e88b:b0:1fb:4701:be6a with SMTP id d9443c01a7336-1ff5728c7e0mr167241985ad.20.1723007879075;
        Tue, 06 Aug 2024 22:17:59 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:cfc2:ede9:52cd:5b67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f2734dsm97150485ad.41.2024.08.06.22.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 22:17:58 -0700 (PDT)
Date: Wed, 7 Aug 2024 14:17:54 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yosry Ahmed <yosryahmed@google.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, alexs@kernel.org,
	Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, minchan@kernel.org, senozhatsky@chromium.org,
	david@redhat.com, 42.hyeyoo@gmail.com, nphamcs@gmail.com
Subject: Re: [PATCH v5 00/21] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
Message-ID: <20240807051754.GA428000@google.com>
References: <20240806022143.3924396-1-alexs@kernel.org>
 <20240806022311.3924442-1-alexs@kernel.org>
 <20240806123213.2a747a8321bdf452b3307fa9@linux-foundation.org>
 <CAJD7tkakcaLVWi0viUqaW0K81VoCuGmkCHN4KQXp5+SSJLMB9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkakcaLVWi0viUqaW0K81VoCuGmkCHN4KQXp5+SSJLMB9g@mail.gmail.com>

On (24/08/06 12:34), Yosry Ahmed wrote:
[..]
> > So the sole reason for this work is as a part of the mem_desc
> > conversion.  I'd like to hear from others who are to be involved in
> > that conversion, please - it this patchset something we should be
> > merging?
> >
> 
> Matthew asked an important question here that needs to be answered by
> zsmalloc experts:
> https://lore.kernel.org/lkml/Zq0zucMFsOwATsAC@casper.infradead.org/

Iff "zsmalloc experts" include me: I was under impression that there was
a zsmalloc conversion plan otherwise this zpdesc effort is a little
confusing, and, frankly, it hasn't appeared to me that this is "my problem"
now.

> Do you allocate a per-page struct zpdesc, and have each one pointing
> to a zspage?

I'm not very knowledgeable when it comes to memdesc, excuse my
ignorance, and please feel free to educate me.

So I guess if we have something

struct zspage {
	..
	struct zpdesc *first_desc;
	..
}

and we "chain" zpdesc-s to form a zspage, and make each of them point to
a corresponding struct page (memdesc -> *page), then it'll resemble current
zsmalloc and should work for everyone? I also assume for zspdesc-s zsmalloc
will need to maintain a dedicated kmem_cache?

