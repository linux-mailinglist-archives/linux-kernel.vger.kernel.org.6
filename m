Return-Path: <linux-kernel+bounces-571234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAA0A6BAB8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936513B98D1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414AA22687A;
	Fri, 21 Mar 2025 12:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YIimjCTy"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA79B226CF8
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742560211; cv=none; b=fW9WlV7/Dc1e+opDxFqMYpWjQ4Ehq5b5ljWD8sTbH2MZ/KpxXfLccVD8B7k72xPJbHoXFOGXdu9eIB8Zi2a4smn+La1Ta2xVWtVqhsGkTBRYjc0y275Lil4fySUzwZu4Jl6G/aZaPtae2Kn/Xx5qannzgy+o6q1CvSZcKOWlmWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742560211; c=relaxed/simple;
	bh=z2h8kmcrvjsG0wHPqWEEDMYXLWs3RQptqRtGchizi+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbYbFPwvR7iWunXfWueKtZIwfefjuiiDX8ko5AvMZbehWLrgcPopPhF9hWM1IEve05oGs+Sbn7IhDbdKG7volEcvWVhNGzAOUJO+96QE+1S4TZXOUJfiP0y7G92OW4jmp3pfF1bhJsg5cA6tphjy+0/cUJT0+xYongjcl4nEkQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YIimjCTy; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so959215f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 05:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742560208; x=1743165008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G65UV4/EPEL+kQ65PV9/uamD/u6L+fEtW/r8PlOFSsA=;
        b=YIimjCTyLFFAlPTNbZO3VZsh/7j3Kc15NqeVnhXZBUOSddhkUAbprRzb0/3GMpZXk7
         Yt3GwW/WqwgKlcU50hEPXMGjCpjFqno1EzgV3Hb5vJJrEU93vBWjvdn2abi2loOVwOgQ
         GXNq9gWOTl3dcXxBKIa8U/zHyclZYfs09lgPw8jE1ldQzTkDKFKEwBuIwqpfLRXlT7MR
         ZoFKS+Ry368BOm7oxaUEVR+8YG4bcX9YbOivunjJ/jE1lrokjvj4/rbEAcHj7h/k6y52
         kRjUFB7BDRQzvpI72xL2dTvGrdHvXDnxmzkgvwufKA+n4WQJFLn2JlcR7HiKXtHsHFgA
         FftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742560208; x=1743165008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G65UV4/EPEL+kQ65PV9/uamD/u6L+fEtW/r8PlOFSsA=;
        b=I172Vz3u/cdvwzEN507t69yXgwfd6H322w4/4Aaun3Zq6hoH3PVAzL7Crdn4dkaRmS
         msWvBky8Pr0lsDQuwxoaSpcQvYwQMMtRZSZVIN3zC0il6xatIYJxQBtK8kPg/OYPwT7a
         2oGI7wjXmulepu4dSmgSKsDMchdq4FO9PT+F3gvopKhXMU1i1YCApXy6lYMDo4gsl6YV
         EHCMJ2WScWyuM+2094ZFZwhedIr8Gk5zVHxU+qcQztRR7/rQe5BjQMe45EEodMjKS7vj
         9Y55bsqkrultFbv5pZ260xr7qYAep9cuEtkywGSlRYcRQ38Hp8KgjKD2gp+xxlN3Hjj2
         iExA==
X-Forwarded-Encrypted: i=1; AJvYcCViX53QvEeNCk5RU38Z0dAvgr9KG45FO6Rw/u+fxcvBXYkdFQr/+1jKo74wJfrsNhk1LSpSxMeX/AccD3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkumevtiKKJuikDuoPvK7rl2iKp/bvSvGWN0HYE3KQLYw48L32
	ekoPpfUjqZZNdtINj+NzWXof6RrcrRhr+Ct8jE436NXjdpUlt7CIiEa8OKedO4Q=
X-Gm-Gg: ASbGncvsKLlb7I7zE30lIg4/O2eD6jT+EEw/99TjXhoO0FW/JnEQ5LxQX0nJw8ucoqQ
	2LlvasTptxSkmUwOGRKZTRV8tw7veWinKHH3udl+khFXGplStR8kVpxUad7jYcpjeKplG5H32Pr
	CWS6C6yzpKGQa5whrvd6Uu/x1X5lZkY0IyZ7vsCc1H8sA85r+WWshj3A2XHeI38WuWngJsPCa6Z
	FyjQKAOwotHB/SLFiAjY4PmvZlFU0cMeGWyrWx5MKMUEgfvb1PjwdRXf9Aab9dQkzuBAlMb+IG+
	ZniD1/cJTaO3ngBi/JMMVizxvwfUYpYLGvkp602yk/QKI4A=
X-Google-Smtp-Source: AGHT+IExv+tybR5ipnVHMChIozaD9HWg71HI9cTN6Q9laK+gRbql3sVz1wKjQhAcenueVqPKCCAWLw==
X-Received: by 2002:a5d:598c:0:b0:391:3aaf:1d5f with SMTP id ffacd0b85a97d-3997f9595f6mr2940009f8f.52.1742560207835;
        Fri, 21 Mar 2025 05:30:07 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3a10sm2231886f8f.28.2025.03.21.05.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 05:30:07 -0700 (PDT)
Date: Fri, 21 Mar 2025 13:30:05 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Hao Jia <jiahao1@lixiang.com>, Hao Jia <jiahao.kernel@gmail.com>, 
	akpm@linux-foundation.org, tj@kernel.org, corbet@lwn.net, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: vmscan: Split proactive reclaim statistics from
 direct reclaim statistics
Message-ID: <isr7mmozkvkj3e4zk55fx2lzkwjxjhl4ac2f45l75qnna3bntp@cfm6v7wkmpyc>
References: <20250318075833.90615-1-jiahao.kernel@gmail.com>
 <20250318075833.90615-2-jiahao.kernel@gmail.com>
 <qt73bnzu5k7ac4hnom7jwhsd3qsr7otwidu3ptalm66mbnw2kb@2uunju6q2ltn>
 <f62cb0c2-e2a4-e104-e573-97b179e3fd84@gmail.com>
 <unm54ivbukzxasmab7u5r5uyn7evvmsmfzsd7zytrdfrgbt6r3@vasumbhdlyhm>
 <b8c1a314-13ad-e610-31e4-fa931531aea9@gmail.com>
 <hvdw5o6trz5q533lgvqlyjgaskxfc7thc7oicdomovww4pn6fz@esy4zzuvkhf6>
 <3a7a14fb-2eb7-3580-30f8-9a8f1f62aad4@lixiang.com>
 <rxgfvctb5a5plo2o54uegyocmofdcxfxfwwjsn2lrgazdxxbnc@b4xdyfsuplwd>
 <20250319154428.GA1876369@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319154428.GA1876369@cmpxchg.org>

On Wed, Mar 19, 2025 at 11:44:28AM -0400, Johannes Weiner <hannes@cmpxchg.org> wrote:
> Can you clarify if you're proposing this as an addition or instead of
> the memory.stat items?

1) more precise info for given reclaim daemon
2) slight saving in the long list of memory stats (sorry, I must
   question new entries :-) to balance flushing[*])

I was originally motivated by 2) to propose the alternative but it is
not strong alone if 1) is unnecessary at the moment (and it seems the
blurring via aggregation is acceptable for the users), so let's consider
that idea a (potential) addition.

Michal

[*] You'd be right to argue that per-writer collection may not be more
    efficient in implementation.



> The proactive reclaimer data points provide a nice bit of nuance to
> this. They can easily be aggregated over many machines etc.

That could be collected from memory.reclaim too.

> A usecase for per-fd stats would be interesting to hear about, but I
> don't think they would be a suitable replacement for memory.stat data.

There could be reclaim daemons running at different levels of hierarchy,
the higher one would see effects of its operations only. Or differently
parametrized reclaimers (swappiness), each interested in their own
impact.

