Return-Path: <linux-kernel+bounces-558575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7493A5E7EF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 00:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A0C3B0DB6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3E81F3B87;
	Wed, 12 Mar 2025 23:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="2hkJOiBV"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515C11F2C58
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 23:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741820480; cv=none; b=NHNiS6QMdYKQ41z/o2aEBdQaJ8N07wb88jrkkBdCCtMYKt82cwRxRLEYZhTow1braR53w51E92Ud1EIis5FrNJYsSvZS+ass/mlee8i7xcd3RZUlXnwpqNdjqQ+2pQBh/ZS/EcXK2QA2ZAhXXwibWQwlHEFufxh1FAbh0EesOLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741820480; c=relaxed/simple;
	bh=+rpDxaQgm+wsQPbws3qQsNkRIKl9zmIeGuw5sA2yj/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsMJJwBzliqkLXAWikeHHF/ypMtZGS6e1sELo85xVaMHUu7FDCrK9+VmKGad0/EImUgKkT2GcDmGEGlPFF72wig7AuX+N0RRTsfvuFscPncLa2uiz9QY8YmMSjwfIH8l85G+iM3nfQrKeMX+DaVg5V2Ftai9KRxH42tpZM49xBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=2hkJOiBV; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-476805acddaso3324581cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1741820477; x=1742425277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/k48zVdw7SyhnQrDrLHbVl8Rl30ZSbI9RE/c9vyrahs=;
        b=2hkJOiBVlTuzioFSMUGCYbWS+O6F1B7rf0+f6sYBepplXynldKA3fFJOWqQt81oigd
         flBiqZwPzS041J1bpVf8P9kK19965RkR8DTNwVCFiOUZZ+Y9ixFHDADose27NRDJMpsd
         3Ogl8Za04+PyAm99F9sm6HjkKgABbMkCcITg0UPVilciKK+b/EEvBlrRtQT0yg5v7rBt
         lE84hwQ7TlryVQnt8krrVkz65ncsx6xxfWxco71ZgkYZiEEOKNi1CAREzuRIXcJQID2z
         OY6IdymGd/YWFwwIl+VNw22SNPeNOpn6Pn+uqvRoVfytiLYVa+qtLmXGtu7Brk8RzXsZ
         BC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741820477; x=1742425277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/k48zVdw7SyhnQrDrLHbVl8Rl30ZSbI9RE/c9vyrahs=;
        b=Nb1FoXK9FtGQvIK0HvwJjjyr+wZwL2XIGllf1zq9i1NCkE3mzdznGLUI8M/yC2Ut+I
         SspMzoVHwSO5EuI4C8N2fkAmkgrnl+6YfwHXa4Wdn0jmk/dVygEOZp/p1hH/xyKCPPM7
         ZYLS1ukBui/A5dDY6YVsan2SeWLj+8I883YHIh5Eif1njDlXgcnIFVztWtiohNRYCcTT
         4HnWQJe9dvaysrKlytjv28SMwsnDPyVYoMuqwO4Wpoo8nJkKG9BFvoOfG9LYuGhrm/V/
         AKPSZDbifZHfNdM954JMielzWD/rrOrLUrWx3hhPCXN5xOpO6yROP8b7FNfxFzs2MACP
         CAZg==
X-Forwarded-Encrypted: i=1; AJvYcCUCKwk18QYcN4/yK7ddGOBVXthkoR57SfQ3XJx13hRiWmpS15dixLtw+EOFfiagS0STWL2uWGKEyuf1SYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+YwRidQzmF2hy3P4CSt4avQE6hAX04u1oQ37FA6Co1XFdjVrL
	BBZKNCPPbvTeRgNHBTCeLV7YOyOMLjng/Vt8HTR7owBCmpQ761Aki6PLKLM5DDg=
X-Gm-Gg: ASbGncvLTKpJvXUdjAOKX9FwCH2UzuXfGDZcUDrlAsWo1sc2oGrYoPSR6+/Kvl4C5nu
	irze6dtht0BVJveD2SqwmPj77dVVI8nArUev/qoOjYcF9LJ58RxIAHJCcYYn2zSfqeUsEh7Pkt0
	P/IQU11nIX7L61bqlPzSxvrXWZW0wM1ilRD17MI3UXeQbSlyz5ce5HWkQf04iOYhAnIDm1u2RHl
	JC3I6SEXRzDIVv4zSsmP7+FLz9ep2yI2Bvxz3hqii3sxyTl56BXjWbmyYNtb+HEb/AHkBf58sMe
	9zYQGjwSEO1NOXqLTR7qaMwn6ltqxvmU+xf7AhwmBEI=
X-Google-Smtp-Source: AGHT+IHh1pCjpeXCj9O057it0duPj9RnmfTnaglKfOGbIcKnK2/5+F6nwuoQMbtwb+1X3EUnHJ6fdQ==
X-Received: by 2002:ac8:7fd6:0:b0:476:9001:7898 with SMTP id d75a77b69052e-47690017ef3mr156653221cf.25.1741820477055;
        Wed, 12 Mar 2025 16:01:17 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-476bb7f4f08sm822891cf.56.2025.03.12.16.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 16:01:15 -0700 (PDT)
Date: Wed, 12 Mar 2025 19:01:14 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: move do_memsw_account() to CONFIG_MEMCG_V1
Message-ID: <20250312230114.GA1247787@cmpxchg.org>
References: <20250312222552.3284173-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312222552.3284173-1-shakeel.butt@linux.dev>

On Wed, Mar 12, 2025 at 03:25:52PM -0700, Shakeel Butt wrote:
> The do_memsw_account() is used to enable or disable legacy memory+swap
> accounting in memory cgroup. However with disabled CONFIG_MEMCG_V1, we
> don't need to keep checking it. So, let's always return false for
> !CONFIG_MEMCG_V1 configs.
> 
> Before the patch:
> 
> $ size mm/memcontrol.o
>    text    data     bss     dec     hex filename
>   49928   10736    4172   64836    fd44 mm/memcontrol.o
> 
> After the patch:
> 
> $ size mm/memcontrol.o
>    text    data     bss     dec     hex filename
>   49430   10480    4172   64082    fa52 mm/memcontrol.o
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Nice. It being a jump label avoids the branch, but it's still
unnecessary text and therefor i$ burden on fairly hot paths.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

