Return-Path: <linux-kernel+bounces-440201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC369EBA1F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEBBF283C56
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D586224AEB;
	Tue, 10 Dec 2024 19:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="MlzcHmQF"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF2123ED63
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 19:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858751; cv=none; b=rcuv2Fvv/9dJ+dUKIxf9ae7iufbg/HZlYrUahckn4M7wcrElEsw1UWvyk7PSV55gBRuWK5HED+IxIA7xlifomJf16TjFL7lr/v+E3btW/GwmqkZqtW64XsD75Zq65RXUMJnDAGgoos32voFyqwUTWIyjHxDmSuOa2IisVDZcchw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858751; c=relaxed/simple;
	bh=yI+m22eZ47zXqA5alDA7J22lteBOg4qMNlifPwfSWN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqYJ+tHkz4dQgYGRaPlLxZ8vscgcxskdGJNeiLB/vEL73mTkUfkA5SA7umKP2eF+BXYmFBv5EIID3B91bPEjIomAWSraq78OPUxyvyLetVx1x1Y7wdDatxfmSVFN9pq3YvGzCGfK9g/hcgABenV2FdqW04JtWtLL7yI/x3sy3o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=MlzcHmQF; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6d8e773ad77so33361786d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1733858747; x=1734463547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1NtCkjYpTzUEcQtUOoTZj6Gta+taIvsFh5ZGDIhZ+nM=;
        b=MlzcHmQFLx1B/vUsWXUWnPSqa/I+ywcQr1V1YOM+wk7muYD9AsVjVjDCIVqm1BMQwz
         mrsyDHUoNX99txgOWsmnu1aHSHTH46UkmqXwqPO/i+RhTB8AkATGTxcnCk5CuOGPJPsp
         cjJWDPRGfr3F0kbHJozMLH1cVbAMX/OIyaGRy2zvfDj5OtNDzOwRginQtZHmB37fWmXh
         8/YqhNt1ajZGgeEStvRaQ4HU9wcKfwcnTOYaJnQ2iFEj0Q+FgKUXaBiMX57noag4APbp
         CaGatOs2Twh8kOx5Gyj0T4EAjHioF1tv3AnjQbR1Ig3lVYYIJIRSHgJbGGlqsaGOYe3f
         4YIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733858747; x=1734463547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NtCkjYpTzUEcQtUOoTZj6Gta+taIvsFh5ZGDIhZ+nM=;
        b=hDd7eYfZ6NBIGj+vk6XuXyPasDDcurS/1AaSO6bjsEE55fnFMJ3KRHn7WgmVnSs6hw
         kq8Yipxg0u6MUDNibOAk5rCtDgDhisvc9z2YUMm4/LSzOLzh174xdRhAbt8msUXIr8lB
         jaz0iD2kPIVLXZDbfbNLzVG0bzqLwpbC5bzwQkdqb+30Crsi6IYNiwFz7afMFUPOWIl7
         Upikw5jWBLTG4NE/mtKwcf7pfG0sOS8Tzn+SXfjjjSyBdF3bO33WdLBmq9iqiFumnnQ0
         +WV3iSMQcTNVoZoycDZVYsllUAYDf5uZosMQWmtMAlyzzPypjVP7diCJBxpOWDAax8Zm
         wy+w==
X-Gm-Message-State: AOJu0YzbNJwo+r4f9yj6ro2I0z4SHuvClH3ZBaLP0ZDe3LR4u3NLI64/
	JxcOaQRAXgqk/pcjcfLguAFArzgM003c2mkrCOQ1g0BDeJ6Z79inynOXhJaRSIE=
X-Gm-Gg: ASbGncvDjqG3sLpGDy+P7GmgFRRmkFc6avRov++q3uGDGIl+T8/cPWEgs+Gu+TRhL7z
	s1PXHtwdXfdp1fdo/b303WpVpp54siIR3y1zdiPR/2CjYRub2zCAKufqzGXknHqHAIJCu5bM5KF
	MKyWyHd78G0SFENrPfXXT6JX2810VFPVCRCvXgKGX2MCOsvZy+6gxoaMACfAeDZh0H1Cc71jCYC
	ZnYZtnYqw9pQrIAGujmQTcb7TJO9UplUB0Zjr00/WHrDgOeyio7
X-Google-Smtp-Source: AGHT+IF/PTmpj9i0eiqNi7DD7EhCR9J4pLF5hz9u4sVHQ4rKtXJ+Bv6P1uvkZZ4zn3fhHcXYYjzUQQ==
X-Received: by 2002:a05:6214:2488:b0:6d8:ab7e:e552 with SMTP id 6a1803df08f44-6d934bc47d7mr3204126d6.39.1733858746985;
        Tue, 10 Dec 2024 11:25:46 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6c3591a10sm392911785a.129.2024.12.10.11.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:25:45 -0800 (PST)
Date: Tue, 10 Dec 2024 14:25:41 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
	Yu Zhao <yuzhao@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH v1] mm/page_alloc: don't call pfn_to_page() on possibly
 non-existent PFN in split_large_buddy()
Message-ID: <20241210192541.GB2508492@cmpxchg.org>
References: <20241210093437.174413-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210093437.174413-1-david@redhat.com>

On Tue, Dec 10, 2024 at 10:34:37AM +0100, David Hildenbrand wrote:
> In split_large_buddy(), we might call pfn_to_page() on a PFN that might
> not exist. In corner cases, such as when freeing the highest pageblock in
> the last memory section, this could result with CONFIG_SPARSEMEM &&
> !CONFIG_SPARSEMEM_EXTREME in __pfn_to_section() returning NULL and
> and __section_mem_map_addr() dereferencing that NULL pointer.
> 
> Let's fix it, and avoid doing a pfn_to_page() call for the first
> iteration, where we already have the page.
> 
> So far this was found by code inspection, but let's just CC stable as
> the fix is easy.
> 
> Fixes: fd919a85cd55 ("mm: page_isolation: prepare for hygienic freelists")
> Reported-by: Vlastimil Babka <vbabka@suse.cz>
> Closes: https://lkml.kernel.org/r/e1a898ba-a717-4d20-9144-29df1a6c8813@suse.cz
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

