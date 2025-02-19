Return-Path: <linux-kernel+bounces-521660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5914CA3C088
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 388603AA8C7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EE11B4F21;
	Wed, 19 Feb 2025 13:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5f/W5bI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD651DFE22
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739972815; cv=none; b=a3X4i6zmhfuZfiAODH0XG27X4MjeHqMRFKuDl/TG5QJIF3GBO496HCbIZOCjMITB3UaPzkN6F0RERKGSWEx1Gs04IxPCW6cQyirfc+83abM5u/TlNREz9xOX4H91nw1Cu7QJsRDAVVlHa1OtXw7errGORktYEw0kgniIsZtEDYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739972815; c=relaxed/simple;
	bh=UcJkjuEi1yYJnAiutiiyWh7ZzRjqlpKOLFtDnGJIPCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwrYTdMIyez5x4UGMFH0RY6oSsxiJ9h/Y11L0CpHqKZvl50zZ/4v0wGaXPQ2tno8i2Ops7npXb6szxVN1DjWCfEab5yBxDDW4R7N0LYfsh3ERWdiIDmzxgEUodzG56+oglU7UN20SQNECQz1Nr/Av1AlLAGn2j4mvEP7oEHQ31c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W5f/W5bI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739972812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UcJkjuEi1yYJnAiutiiyWh7ZzRjqlpKOLFtDnGJIPCQ=;
	b=W5f/W5bIw1GjJ0UifYnGvvdJN9GOgRhGAMnX/xKyUExs2wkfReRetcud3NJJvQ+VuXfiWI
	LMkyhdSkrg1ssNvFeqwud8Q2W8lttzMOB2BDJHFFmhRyMHp4owzWmpz3YT0hn2aKT4UVHc
	At59Xo4+0gTXS8Sp2gf0JE1wbnk9LBI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-56JxtoloOtGm1M2NtmTCnw-1; Wed, 19 Feb 2025 08:46:51 -0500
X-MC-Unique: 56JxtoloOtGm1M2NtmTCnw-1
X-Mimecast-MFC-AGG-ID: 56JxtoloOtGm1M2NtmTCnw_1739972811
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c0ae469d5eso320938485a.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 05:46:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739972811; x=1740577611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcJkjuEi1yYJnAiutiiyWh7ZzRjqlpKOLFtDnGJIPCQ=;
        b=f+7B/I8G0KA3RvCOsYL4jCW4lX9Y3nWtC7mjS/H4k0k/kwOAnyZ9bpBCXHnJvpo7KQ
         ywvMbaEA922J/ucoEA+IDCUJcpQT9NVkP/1Ih4PKIZ2idnxhrH16YOS5jSHgRzRx9FFG
         4O3/Ci+qyQP1C/KoDyfkj+xK54AJmv31M8dDgjj3Zk0VLejIchyueLY/AjI3JtkvikJd
         VPB+/NpCMj+vBH1pGbkjsWTa2LPYs/7mP+kEeCGPTctA1xwXz5lBX09QyrGB7QQv1K41
         Kbr2jclYlMNFnhECMxhcgbQk3KJxUlHVqgXO+vWLsX/uzHnidLXgIJDamSxYYgQG9uw8
         nwTQ==
X-Gm-Message-State: AOJu0YxcQabf7z4Qb56gzbMKuPnhw0PurEdLLXLmBys7uIucjZ9ylnaN
	jhesI52CUPK86vV0VkKJ5cgTVlzesM2dZKSms2guQATUkAgxLqKX9YQZeQkBzpi/bZ06cwaRn3R
	DMqFTJCyLF8h9dGwZDrnbHnO2yGWsKOD4RwD/l+ub4YJ/IPQUy/giMONi8olzNAIDCcJzbQ==
X-Gm-Gg: ASbGncsfB76xcSzassMq+RxW/Yl0i/QuDhOKsezu/B5OUv6iAbbkVkCmhQPGZjtsxwJ
	EH89KIFfWK02s/j68EoVAOq1hsxEsAUDKxqV4smW/nV09McI8kmT1xeUUlHG15MDNRkM9ldBWEI
	z118y32k2pOC10XcLaGmRb6KEqUWuXIciioSGFmm75SRjOSc0IYy5y8xfM8Sj0/ZU0KYqB+L58T
	nO7OcdyoZsLpFtlGgmXzdL46nqENTD90fk+rQQFxGvKRcy6BVbZ5b9OTupZqFqVkza9Gq51v+xk
	WS7BDVQn+VJ0iA==
X-Received: by 2002:a05:620a:4805:b0:7c0:7818:8554 with SMTP id af79cd13be357-7c0b534e809mr606130085a.36.1739972810988;
        Wed, 19 Feb 2025 05:46:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvt4PQDCLcNiUnb5vuuQvPmYW2M9pE931fM7yXu2Gz/T9k/kTKHHri1sWt4hM/n19iDe3ROg==
X-Received: by 2002:a05:620a:4805:b0:7c0:7818:8554 with SMTP id af79cd13be357-7c0b534e809mr606126185a.36.1739972810650;
        Wed, 19 Feb 2025 05:46:50 -0800 (PST)
Received: from polis (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c097e43fb4sm394598485a.107.2025.02.19.05.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 05:46:49 -0800 (PST)
Date: Wed, 19 Feb 2025 14:46:46 +0100
From: Danilo Krummrich <dakr@redhat.com>
To: Karol Herbst <kherbst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	Dave Airlie <airlied@redhat.com>,
	Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH 1/1] MAINTAINERS: Remove myself
Message-ID: <Z7XgxkxGIJm0OAue@polis>
References: <20250215073753.1217002-1-kherbst@redhat.com>
 <20250215073753.1217002-2-kherbst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215073753.1217002-2-kherbst@redhat.com>

Hi Karol,

On Sat, Feb 15, 2025 at 08:37:53AM +0100, Karol Herbst wrote:
> Please respect my wishes and put this statement as is into the tree.

I applied this patch, as is, to drm-misc-fixes.

I respect the reasons you have and that you do so out of firm belief, yet I'm
sad to see you leaving this community.

Thank you for all the work you put into the nouveau driver!

- Danilo


