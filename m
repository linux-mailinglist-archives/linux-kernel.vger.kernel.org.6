Return-Path: <linux-kernel+bounces-358697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFED998289
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57DCA1F22CBB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962031BD508;
	Thu, 10 Oct 2024 09:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzlb/aAw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939801BD01D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728553174; cv=none; b=YOmLdbCQ42LXbqcz302ih2hTLAvFr8z+mauYNl4rUxOlAcKaIYUJvp3bxK0K//PsAnJvRRU5z/Ua+pLFZz4QUN/peKZXUbGxaXS2EAqhifPDqQE/P0EWCsqSXYJV7Vz+OfrAUcp624yQo0anaWoMewHm2y7TjaUFDWi4x53OYqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728553174; c=relaxed/simple;
	bh=UH1KcN6aJU23wWi1cO1qdQicdr1PoB59i5Ni4SZhtsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W072OKMLYFvtjB4+6hrx/G6PlUxGoPFTg9s9eJGbSoX+8cCMTKZJVogg/Ojop2yMwO0CMMlMOkSoX6a34scTUOdjt5ojU/d0MsGpzOViR2/fB7GCImTanDDSrmRIgQnTE4fc18yYMxX9FIq7dKkxY6EjtMJAQrz9rmikUcgeN9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fzlb/aAw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728553171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DFpkVzZdNC6CnlTTVl2TGiDBeW16kMCAfBnHOOM8DCw=;
	b=fzlb/aAwoqOj2HD6iLInGPujvNqTC+UQIoMNml4dAfHgbYsk7Y3RTj6yhO2VxXFVO6ZHJ0
	dzsWzMts651diNI3O2xqyoAswnkYPqeX7TpFvSudk1bXai0QtozP4co1T5Pj7nXwB/5zud
	9tbY3moCUC/ZwMFiWznbDyvcfyhIhk0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-t5q8XdhZOESeV0OJsHcemQ-1; Thu, 10 Oct 2024 05:39:29 -0400
X-MC-Unique: t5q8XdhZOESeV0OJsHcemQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2f75cf9472dso5664521fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 02:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728553168; x=1729157968;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DFpkVzZdNC6CnlTTVl2TGiDBeW16kMCAfBnHOOM8DCw=;
        b=UpdBTPzoj7rcioTcZ7JyfiycUy8HbH6hFXZqG5Z/8EloMO+YpHmcS7KMkACsplU7UB
         ePbC7yMkTovG0mRWW0odfq3RAzay56Ef9L6lnYP8onYAQ1Zlbduh/hLAZr7UlNiSPDrR
         hvC6fwVvogTHdhntPs5tY76B2tgPk21GD2r/vnamZAgVCNGIqCPt+qPY8z/nMpMB46Ek
         xZe2PA+7W0D9Xl0MTBa1WWpY64DZr+gZy1WTiZsdnGrHJHObBW6xk4KRriJEdgQiOhfc
         +q1d2VnnZ0tVP20iz4DsAfhAPVA4ryY+G3pnpi0qNoTdWm5P6Cx2mPcuej8g+DWn1fZA
         OfHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY8x+FFjyve0ceznMAi5NAa0tO1R0CgGa4V0BCdXIpRZEG3wG73FHglfyAn4N6LNmKmDk5DurSb4vFZrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBarqsP2WEP1Z/MnXDz1H9xk+XtM8h3Ar1IQj8AtoiBCgnYU/2
	Rqf6FD7CNRFv3HzhFkRBy3NwVy0gC29Gb95BEHWnRVuxgXa8PJ2WJkVjGYwhMDuj/IGdn2BcFIg
	VmwRl1x0QTS2kv/znibFMMp/R00KHWyfU4IS63ctddR3OXlRIFqeBI8trIDV2aQ==
X-Received: by 2002:a05:6512:1250:b0:539:8f3c:457c with SMTP id 2adb3069b0e04-539c496ac2amr3163255e87.53.1728553168233;
        Thu, 10 Oct 2024 02:39:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzYePXXkYHbL1Su4nyf+oLAE79vXYQkaaX3O0Z7jUlyV7RSc07CjqwATXl8but6Sk2WX7kuA==
X-Received: by 2002:a05:6512:1250:b0:539:8f3c:457c with SMTP id 2adb3069b0e04-539c496ac2amr3163239e87.53.1728553167860;
        Thu, 10 Oct 2024 02:39:27 -0700 (PDT)
Received: from [192.168.88.248] (146-241-27-157.dyn.eolo.it. [146.241.27.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431183065e2sm10822215e9.28.2024.10.10.02.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 02:39:27 -0700 (PDT)
Message-ID: <25f50405-e36c-44a3-8045-3cc569b37a1e@redhat.com>
Date: Thu, 10 Oct 2024 11:39:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tipc: Return -EINVAL on error from addr2str()
 methods
To: Shigeru Yoshida <syoshida@redhat.com>, jmaloy@redhat.com,
 ying.xue@windriver.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 tipc-discussion@lists.sourceforge.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, tung.q.nguyen@endava.com
References: <20241008142442.652219-1-syoshida@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241008142442.652219-1-syoshida@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/24 16:24, Shigeru Yoshida wrote:
> The return value 1 on error of the addr2str() methods are not
> descriptive. Return -EINVAL instead.
> 
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>

I'm sorry if I gave conflicting advice in the past, but I now think this 
patch falls under the 'small cleanup patches' category we are actively 
discouraging outside the scope of a wider (functional) change:

https://lore.kernel.org/netdev/20241009-doc-mc-clean-v2-1-e637b665fa81@kernel.org/

Thanks,

Paolo


