Return-Path: <linux-kernel+bounces-447859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D3A9F380C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B77C618832CF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6790206F0F;
	Mon, 16 Dec 2024 17:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jT4XH837"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE542066E4
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371691; cv=none; b=JCfBUTq5C6lIVL3WMqR+HDCz8yGlS/sgv+PJC8S364/QEfDkFTTIyCMiBA2h3l6R8pWQ4Ag/PmzHqdWQq4b0i7UuIjIaat/HYb2E4aZfYs6HgvXNfqSQZ4NuESmgIFi+s9P6VzHCk0mfna2HtQq7Yxd3ezwvLeL1joqSdKzzZqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371691; c=relaxed/simple;
	bh=t4FYe7Gm5xtC06oaiScu5p5Cbwegv+blsaKqUEyBo0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOhcSAuFgKkb582LV9FywwabgSq7fOd30GCwGE36unYC/8QKUZYkf1b0gAfOwvrX/QTKGrVDhev9tfx/XwCUF97PPzIKyBDfkDj8jYPPi9lpVLylJdnEk8YmuB+k+d3le9yo1rzElgQmcFBeS1muY25HesuYvr6CTshSJR7C5Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jT4XH837; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385d7b4da2bso4281479f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734371688; x=1734976488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G3AbEFKqDmJ/1viuki0ESyzjIWrD2kKZVZPFr7133W8=;
        b=jT4XH837vdHMX7hXcbldsGvaElnHnwASUn7SxdwbUt51LMc+tq4LD/xC3m9cI2PapC
         EzX+LTL3NfG/HsWV4FEpBWlF8I4ZW/s9LLppuUsmBGoxjsIuuw4urlW5CVqmSh0zOsQh
         7/eRDGrrd1HxrqVYtP3QoEtteybVy65rfmXHLGIvCQ1wLuQ2KFpXue18zDXMBKrLareN
         PbBkMxCW5N0yFP+a1b4/e6OC6elGIkxe2Ih8JwwTrkIzIoQ/FWJYkVz0gtr0NS5Zv01d
         YZAm1zK9vIrRGC4SBzbYrXECFLRcSfppWTub+XHihodcRZAApeC68nIkJuGicwCn2yPl
         NGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734371688; x=1734976488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3AbEFKqDmJ/1viuki0ESyzjIWrD2kKZVZPFr7133W8=;
        b=tfDnsJyoS42j4d5xc3RxNmh/9Wrw/LAgrShaQiL/MsR1ytHLPv+J2cQlBAEkTXZoDz
         OCDEHqIg6NrbttY8dUy1XcTug1etAOlFxzDitQEtbHXBK51dfOhhPngsoh76Zggahj/z
         vcFl6vMe8KgS3dpIzbjwVPeZFI4SCnY07d/ldscJBnbXn0pIhe1YR2JWKzAb1oS+lIx+
         7HAev6yalscnaz4ZVp5HLfIEasQny/DJAO2niyb75OfTCudmeK+cDpmm78e6fSO1Jt/s
         yun0DQbjm9zu5ljaWmm5tYVSCLg0miLJr7a7P1c9a50uPM4rrDDYTMHiP3nTdhdZgtZX
         kYkA==
X-Forwarded-Encrypted: i=1; AJvYcCWcec36LVv1SwAD5xtTODYyAqJElevSvW2pmYdkBO2JB697lorADOM2kS8hzCRV6JehPov7R6QPrQYqpjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLUwwNjqiFIW179cFyjRWdzxhxSVhREfnEbryvVTVyJjBeoveN
	PR9j81qapsbTUUGFXPv2esmWrTlAeBMpKyewFMEN4ngHMcq3gziFsBjAkL/kfA==
X-Gm-Gg: ASbGncunigb58zPtmiQHyJgUQoBABrFeomJHp5Kk5AUTeqJqh0pHS7aK5GHybQQa/Sh
	EsqZCScywIaozLFETlFhpXfo+4WKIXdqueSTGI5/CO6d/vATTKz5IpXfKAHf/XKdXrlGgAstdJp
	fWvEJ49eGInc47GyxlrnWg1Hy9WHQYQQ+htkq4YONW8cGizWh5wKwFM4Ll5omB5GdY7qgKYcQJX
	tj82xlTr0vLCpk/pgHy0CMlgAviMgCEnk8tAeDDkDCbEYPmtsIH5HyyE3JfNgVM+pzcmi+Th4OG
	NTkN3Z67svoLoyH4PXmY4Q==
X-Google-Smtp-Source: AGHT+IGlns8j8gYRX+8al9zuzgAiKn/tbr/9/wdBkt9kQs6HtCRG/bDMRMDr27QgDSp6SOTOy/GBrA==
X-Received: by 2002:a05:6000:70d:b0:385:ded5:86ee with SMTP id ffacd0b85a97d-3888e0c0515mr12706974f8f.57.1734371687837;
        Mon, 16 Dec 2024 09:54:47 -0800 (PST)
Received: from google.com (202.88.205.35.bc.googleusercontent.com. [35.205.88.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c80121d4sm8996562f8f.2.2024.12.16.09.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 09:54:47 -0800 (PST)
Date: Mon, 16 Dec 2024 17:54:43 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Jeongjun Park <aha310510@gmail.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, david@redhat.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: fix array bounds checking
Message-ID: <Z2BpY5LimG7E3LpC@google.com>
References: <20241216164931.57323-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216164931.57323-1-aha310510@gmail.com>

On Tue, Dec 17, 2024 at 01:49:30AM +0900, Jeongjun Park wrote:
> If there is a case where the variable s is greater than or equal to nr_subbufs
> before entering the loop, oob read or use-after-free will occur. This problem
> occurs because the variable s is used as an index to dereference the
> struct page before the variable value range check. This logic prevents the
> wrong address value from being copied to the pages array through the subsequent
> range check, but oob read still occurs, so the code needs to be modified.

Hi Jeongjun, thanks for the patch.

Did you find a reproducer for that problem or has it just been found by code
inspection?

As discussed here [1], s >= nr_subbufs should really never happen as we already
cap nr_pages. 

[1] https://lore.kernel.org/all/78e20e98-bdfc-4d7b-a59c-988b81fcc58b@redhat.com/, 

> 
> Fixes: 117c39200d9d ("ring-buffer: Introducing ring-buffer mapping functions")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  kernel/trace/ring_buffer.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 7e257e855dd1..83da74bf7bd6 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -6994,9 +6994,9 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
>  {
>  	unsigned long nr_subbufs, nr_pages, nr_vma_pages, pgoff = vma->vm_pgoff;
>  	unsigned int subbuf_pages, subbuf_order;
> -	struct page **pages;
> +	struct page **pages, *page;
>  	int p = 0, s = 0;
> -	int err;
> +	int err, off;
>  
>  	/* Refuse MP_PRIVATE or writable mappings */
>  	if (vma->vm_flags & VM_WRITE || vma->vm_flags & VM_EXEC ||
> @@ -7055,14 +7055,14 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
>  	}
>  
>  	while (p < nr_pages) {
> -		struct page *page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
> -		int off = 0;
> -

I believe we can keep the struct page and off declaration within the while loop.

>  		if (WARN_ON_ONCE(s >= nr_subbufs)) {
>  			err = -EINVAL;
>  			goto out;
>  		}
>  
> +		page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
> +		off = 0;
> +
>  		for (; off < (1 << (subbuf_order)); off++, page++) {
>  			if (p >= nr_pages)
>  				break;
> --

