Return-Path: <linux-kernel+bounces-350028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC6598FEE5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE0F9B20D89
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385EC13D613;
	Fri,  4 Oct 2024 08:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NOhWeeLU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F067C13C9A6
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 08:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728030168; cv=none; b=iNv/j61JnXUO5hcyFS5dIpc/qhZSz+vN4JqjT7kiLRR6VmR49MM2FhnrshGVsG4gGyzNYaZybPvleM7Ak5HFM+jSixBGV6sHyA6N4irqxo2GLxeX1uCgiHTq7F4g8Q2oAa9qz4mNvCkFQIGljtoTKPufAq1AYwtoPTeCUWDN7gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728030168; c=relaxed/simple;
	bh=g+mm9g21L/sKPQHBpa9NpV+e2PiRkmnslgamHkcdXa8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A7pxirGEaw2b14lQ62/Mlln8+F6Ag1/IvkoP5+9R4WiQW+T8eya/SCvsVE7jBbNwB2a5T655VL9uYIi6cCIbB69HSR8uBXA4NEnW0N0ovUaC5fzduSKNNPJ7GUVIHq460+kLdCeqXeeVeQs25y1TiNbvL5gslClwCExg5K9217Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NOhWeeLU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728030165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tVLJSTfOV9RVRQd/Zz1InlknhMgR10jK2wkwAPV9cAs=;
	b=NOhWeeLUO0g+RJB7nnVLJ/6DLwaExbxf+1q5IL87jtDnvkuRe27KFDLodHa+rzRrAXPAZj
	ZmYxx3Nu+r+j9STDNOXts3UgBXvGLKBBOKN2G02ILr3V8z+KanBoJ3FrstUW/eq8ikZzF3
	G1NEZZnqqIe3Bxd5CPqNbjl7sz3Wt38=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-wsHH3zrlM-6mAdYvHwhPnQ-1; Fri, 04 Oct 2024 04:22:44 -0400
X-MC-Unique: wsHH3zrlM-6mAdYvHwhPnQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-53997e2fe14so1697135e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 01:22:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728030163; x=1728634963;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tVLJSTfOV9RVRQd/Zz1InlknhMgR10jK2wkwAPV9cAs=;
        b=JygNvu0BzKp9O6upC25Mg3+mNEFyuxwK8p5s+AUFnIh+CXkaljdXsWFNCi/Nnj7TKL
         IvwiBIeQHxkecQVNcAKA5nyEXVxmDGlQy3V/+CYN5VF77MY2ELxWk9IlgByXQoTA320P
         PUeJnH3e+XS83bdXVix17Jtx7B/wg8izu9IG6W+MO7XB4VkHMPwrmerXN4E3cfq4bNWd
         g9ZLKlxvLLNGkT5Giy4ppBCfNJIOWNcQ8P0KwE/whZuc1N9EtAQX6QDq0N84c8eYCuVZ
         HPcpkJBFeHnxR9xElqKE0aldslEK0Ovz6jILAWe9QN5xKqWB/mbpcjVwp5BrzIvyL7NC
         vn0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbGfb0M5rPSe8HxaxYCYO9btDQKntFw96EfDuM35wt0nys5llkRwwI56jrcTKmLUn8i8RuO8DjnDjgp+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YziqSDTj/+DGEYijrO5uWdJsCqW50nv3spUaZg0tGM4QN80sPqO
	egPtEvcISioz24MZvYCzfkAJCoTdFh3ULGr/GZvjvPfk8BVTwphxdmcYMkLb9oB7AJ8krFoI77x
	lGPjpkT999U4fq23UDIUcjOAaNhOjcVuSoAtVp9qwz7DJ/qSh0p0iB542x88k66/C7Yy1UCM1dA
	vgRY6rrkFQLmkpJWRF/CyWGzuzNuamq8FVKsxuakpKU3MNVw==
X-Received: by 2002:a05:6512:3e05:b0:539:89a8:5fe8 with SMTP id 2adb3069b0e04-539ab88a739mr1317469e87.29.1728030162816;
        Fri, 04 Oct 2024 01:22:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGUsxAJPvLCdNVEZ7VSbbzd2ccePpd9ZYIH9mWfk9DU5PJfhU7xhiGb4XJoRp86kGhETTIgw==
X-Received: by 2002:a05:6512:3e05:b0:539:89a8:5fe8 with SMTP id 2adb3069b0e04-539ab88a739mr1317447e87.29.1728030162321;
        Fri, 04 Oct 2024 01:22:42 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8ca3c2dadsm1583216a12.16.2024.10.04.01.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 01:22:41 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] KVM: selftests: Fix out-of-bounds reads in CPUID
 test's array lookups
In-Reply-To: <20241003234337.273364-2-seanjc@google.com>
References: <20241003234337.273364-1-seanjc@google.com>
 <20241003234337.273364-2-seanjc@google.com>
Date: Fri, 04 Oct 2024 10:22:40 +0200
Message-ID: <874j5sjmzz.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sean Christopherson <seanjc@google.com> writes:

> When looking for a "mangled", i.e. dynamic, CPUID entry, terminate the
> walk based on the number of array _entries_, not the size in bytes of
> the array.  Iterating based on the total size of the array can result in
> false passes, e.g. if the random data beyond the array happens to match
> a CPUID entry's function and index.
>
> Fixes: fb18d053b7f8 ("selftest: kvm: x86: test KVM_GET_CPUID2 and guest visible CPUIDs against KVM_GET_SUPPORTED_CPUID")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  tools/testing/selftests/kvm/x86_64/cpuid_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/kvm/x86_64/cpuid_test.c b/tools/testing/selftests/kvm/x86_64/cpuid_test.c
> index 8c579ce714e9..fec03b11b059 100644
> --- a/tools/testing/selftests/kvm/x86_64/cpuid_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/cpuid_test.c
> @@ -60,7 +60,7 @@ static bool is_cpuid_mangled(const struct kvm_cpuid_entry2 *entrie)
>  {
>  	int i;
>  
> -	for (i = 0; i < sizeof(mangled_cpuids); i++) {
> +	for (i = 0; i < ARRAY_SIZE(mangled_cpuids); i++) {
>  		if (mangled_cpuids[i].function == entrie->function &&
>  		    mangled_cpuids[i].index == entrie->index)
>  			return true;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly


