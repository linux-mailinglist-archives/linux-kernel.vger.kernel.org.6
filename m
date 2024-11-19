Return-Path: <linux-kernel+bounces-414236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4B39D250D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0FBF282106
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750D61C9EDA;
	Tue, 19 Nov 2024 11:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DP0YiKqT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8A91C876F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732016468; cv=none; b=MVpKpfbQOkveWOYihf3pa9E2c2om1HdMgp+lomDwsY/XjIa+RgCW6Bu99+NWE8w+cqnBJheQpuhmBVk0Vqyrkhe4hO13HgD1HggeQeylmrlxJ6obmucKpSZZ+GYgJXsAWuPB4Bae5s/oh7vYAzpC/k54SCAhKVFeO+eJ71vkg1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732016468; c=relaxed/simple;
	bh=B6tGFGc/acnVM3Qye2kgK47gJP4agRKP+KzyCFDdH6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+CvjUNtItubCMn1lqwoaayd7PVPgiHNA6wiMnHc7ieb77/Zciy5kvoPnY/4VYSo3gxyHcUoVhF3RAwJ+il7PlM5BrS4qNfjf/+RayAsQFOdI1RC2dTZObeOEr7GJeaRlkWAC0xHbI+zuuE2R0ZF4l688CeflyvEaEDs05z++eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DP0YiKqT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732016466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iSO7rRgJI8m9saV4ky7Ejp+AThjtq//l80mNHJPVY1A=;
	b=DP0YiKqT9vOn2Ki/CuDdBcI4vNLQlYyC0HhEchXXBRlcCPRqFXY902rOpQo5uhSt38PBkI
	fplbK59WdPawl/nCv63BVYWc8W+jV39WYO61MzoAovthhO7TnRzzfIy9BFj83Ufhpl5SM0
	SUPTZ8V2mcJXcihng9jAwRdCsRuj8GM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-NuqRmUQVMaCvahVDaamHqw-1; Tue, 19 Nov 2024 06:41:04 -0500
X-MC-Unique: NuqRmUQVMaCvahVDaamHqw-1
X-Mimecast-MFC-AGG-ID: NuqRmUQVMaCvahVDaamHqw
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d41f4c5866so11402766d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 03:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732016464; x=1732621264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iSO7rRgJI8m9saV4ky7Ejp+AThjtq//l80mNHJPVY1A=;
        b=eGjXY14RpGhm76ijlGPLK0I/u2pRZOMufnLBHECHjPed8E2x7lwKjS6wd056eThtpj
         xyPKjbeAzOLyPg6eUmi2VLuVbqbmg2leKmN4ADuC9cnLr+QhffBq0VRZXi1LoEoYqaAd
         6l/Bf1xgD2WOBTtGAAdxb26V/d1Zj54/eAnkjSQ7bZYXOxv1BqsdqiFjyQ1G13ep4VVo
         A5Z9AWetAYP8CZcT9IOdL7y87DG7oFi6JpVHR+oThkaJGJJKrmEQxbUlZf3lTbNtZKPt
         XLh0E4kKOTycpVnXZirdn5RwTGep01BLuODIJGivotzxiFghp6iHsz8jZcx5AVaI3X+5
         DjTg==
X-Forwarded-Encrypted: i=1; AJvYcCXdowGg+EURVQV3y9hC998Q78hOg4CCnYoEF2z/8bvw++y8qW1REnYV+O5+wpeNNhN17MQ/hUt2hixatEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjN3LtsXZy7WYR+Ytgbc/zMpEKpqP3cJGraCzianGmeTOQqGrE
	B7L33hrVqtYEdnbfhCeAr5D6iPtWQw5NXXh0ti2Yl6d2Na3nMBjoylXQiXHCfHq/hVGwwnmcYJk
	EyfpyZGfa0pSn+ze8bWD0ETkw5wGhSdM9POXNL+2tY3DHEznhNw/I/iYbkLkBOA==
X-Received: by 2002:a05:6214:c65:b0:6d4:ab3:e19b with SMTP id 6a1803df08f44-6d40ab3e1abmr192732226d6.42.1732016464381;
        Tue, 19 Nov 2024 03:41:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSL+CvUXEPORupLRfcZC0IPSOYYNVWZYJtS4mmscYBrBcgg3M5ByxsUOZ5P6MeA/A9Dqar/A==
X-Received: by 2002:a05:6214:c65:b0:6d4:ab3:e19b with SMTP id 6a1803df08f44-6d40ab3e1abmr192732066d6.42.1732016464058;
        Tue, 19 Nov 2024 03:41:04 -0800 (PST)
Received: from [192.168.1.14] (host-79-55-200-170.retail.telecomitalia.it. [79.55.200.170])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d40dc7ada9sm47266936d6.69.2024.11.19.03.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 03:41:03 -0800 (PST)
Message-ID: <06940878-8a7c-441c-958b-7cd7e7408beb@redhat.com>
Date: Tue, 19 Nov 2024 12:40:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] mm: page_frag: fix a compile error when
 kernel is not compiled
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: netdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Alexander Duyck <alexanderduyck@fb.com>, Linux-MM <linux-mm@kvack.org>,
 Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241119033012.257525-1-linyunsheng@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241119033012.257525-1-linyunsheng@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/24 04:30, Yunsheng Lin wrote:
> page_frag test module is an out of tree module, but built
> using KDIR as the main kernel tree, the mm test suite is
> just getting skipped if newly added page_frag test module
> fails to compile due to kernel not yet compiled.
> 
> Fix the above problem by ensuring both kernel is built first
> and a newer kernel which has page_frag_cache.h is used.
> 
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Alexander Duyck <alexanderduyck@fb.com>
> CC: Linux-MM <linux-mm@kvack.org>
> Fixes: 7fef0dec415c ("mm: page_frag: add a test module for page_frag")
> Fixes: 65941f10caf2 ("mm: move the page fragment allocator from page_alloc into its own file")
> Reported-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> Tested-by: Mark Brown <broonie@kernel.org>

I'm closing the net-next PR right now, and we must either apply this
patch even on short notice or reverting the blamed series.

As this fix should not cause any more conflict than the original series,
looks reasonable to me and has been tested by Mark, I'm going to apply it.

/P


