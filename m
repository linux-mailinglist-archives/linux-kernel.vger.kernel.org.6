Return-Path: <linux-kernel+bounces-536158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1C5A47C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59433A5731
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C58222A7FA;
	Thu, 27 Feb 2025 11:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hk9Dz0n4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54246215F45
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655671; cv=none; b=jKRkdsgSoGp45ZOIrTYyNGOQHp1dhpQhIYSaxjnZEayTuONHKrdC6ZP0VUz3ZsB16URDY3kZtI3kEQ8yQBRL2jhjHmU+eTlFhQiyBmMUQWEKbr3A36LcBFNW+QDBYO+3fm6xwPij6ppSvugwHAc0GJyH3zMU9UBeHQXI/zA+UZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655671; c=relaxed/simple;
	bh=2XNVnAyDm3PjiXLwehc/rlLkpHOZbf5GmEz2365CD2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lmqCHNw+FSqze9MIVa1oN4fF1Hves8VM/9ApFFRkjTilrkjCcMq0QMiA6bG9DVsRSXgUcIbBoyVn+6P2BnWWeg9ITZMQcswix6lUaAZeHYUVvVFRC0ULNTaV74i9l3PLUwCtFao3vw79YcJ6W24i0CFdpR3xdqDZSOkPEZLd+zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hk9Dz0n4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740655669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3CkPQdTGCeSORYEiAZeYzr9XXq+mqqO+Vu7Eg+pJ7I=;
	b=Hk9Dz0n48m6/jz4eIG6WNKScauTv6W/osvFPnhmGm04RthDexjPGZiQLEtJBdKpof5dhDX
	2XgKy4ZV+1igcQMM68u9p6Zxj62GVPxGz92Xx4T9ZyxweLjRxUEN+TYzGpgiO8Gl1xP7aa
	MgbcuK97vBG85x89ZIvUkRgSX5bUKbo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-7c2WRk2TNvqNJJe6KFuqjQ-1; Thu, 27 Feb 2025 06:27:47 -0500
X-MC-Unique: 7c2WRk2TNvqNJJe6KFuqjQ-1
X-Mimecast-MFC-AGG-ID: 7c2WRk2TNvqNJJe6KFuqjQ_1740655666
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-390e27150dbso605306f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 03:27:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740655666; x=1741260466;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k3CkPQdTGCeSORYEiAZeYzr9XXq+mqqO+Vu7Eg+pJ7I=;
        b=VTWuYTalwV64EkjFve4MIaCKRc8SHMhZSzx4KNDYaLjkbvqw03UUJxnTukMBLM733f
         CLYJN+vZr6poLWbM54qrLNhqEEfGOUfMz+ZlCxRAuecGJrOjSWfOyZTadnXv4eRbtigW
         WOKcpbvjL/Uwgh1WmqwUMBQYtQe2Q1dtW7DY93iU/qE0wlA58ibCeVqWxYiJIWhYN2yI
         WISs4yfceZALyWy+DR8SfbeCfTgzHbsPkL6mTGiafmensz2OePSeLyHj3h6+lgxKwQzB
         AxhFNR+dLdMFvYdamMQstL1o3U+CcuywKjDn1iJ7UPybWV/k3DUrs5GYqS3eASMx0r/Q
         YbVA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ/pg0uwx5FsfxAb57q05uYu0T7pewZoIo2SUzvHB0CmiJbnwyp+s9BnXoP9EN7QGq7bXQiET9hhRQNGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1b5MhWuFkxSfhhZqy0UFwS10DMK/vsFddkpP33mUWgRHASriK
	UJw/eczxMzHU3gP6+LSSHS9Sz0zcIH4LH93Q05UrFGzYgFUQyTjWIGWlZAmFyILDWjrPgJg+XMR
	kIl8XFkdkJ+QhmSLT4gVyxBWIfTn8VEmTOrEvYMISeDDJxjwKErcjGtSZJxWe5g==
X-Gm-Gg: ASbGncuFRRAlN8liMUmWIj3moS/6bukDO3T30DZA/cXVtgvMlNEYvSM9xlrGP4hCUpR
	GBQIsSu3hC1/gaNUXuXrx+601AEx550QJGwYuolAPNl/0v1Y0WrpVB0zRu9Eca5moNvIzGNtZi7
	QiJEi3MX9WTUPVzPw6dtEb7AuRPoAAGDXCvgl86E8yCK6FPq3crVHBB9bvyofN0pgwj8bbIgXyw
	yv0d/XEIPAQgnNvtuAVRnHOqnP3Hv7J1Rgf95T2iC3rdxV1IXc9ztbH8Fu+4iT7DA8DgToMoKzK
	7WinDhE2rM1nXORUAufHs3X3a2zPABupK7DG7IfSMTM64A==
X-Received: by 2002:a05:6000:1a85:b0:38d:ba81:b5c2 with SMTP id ffacd0b85a97d-38f70854e1amr20380512f8f.47.1740655666500;
        Thu, 27 Feb 2025 03:27:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEswokDyQ8DCmCLBEiVAJ05eapAKtiYcRQ1bTYqiKrKJkSlhiC7M///9FUusM+u/YQh1Ky8JQ==
X-Received: by 2002:a05:6000:1a85:b0:38d:ba81:b5c2 with SMTP id ffacd0b85a97d-38f70854e1amr20380488f8f.47.1740655666121;
        Thu, 27 Feb 2025 03:27:46 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6aabsm1731589f8f.26.2025.02.27.03.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 03:27:45 -0800 (PST)
Message-ID: <899dfc34-bff8-4f41-8c8c-b9aa457880df@redhat.com>
Date: Thu, 27 Feb 2025 12:27:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] afs, rxrpc: Clean up refcounting on
 afs_cell and afs_server records
To: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc: Marc Dionne <marc.dionne@auristor.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Christian Brauner <brauner@kernel.org>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250224234154.2014840-1-dhowells@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250224234154.2014840-1-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/25/25 12:41 AM, David Howells wrote:
> Here are some patches that fix an occasional hang that's only really
> encountered when rmmod'ing the kafs module.  Arguably, this could also go
> through the vfs tree, but I have a bunch more primarily crypto and rxrpc
> patches that need to go through net-next on top of this[1].
> 
> Now, at the beginning of this set, I've included five fix patches that are
> already committed to the net/main branch but that need to be applied first,
> but haven't made their way into net-next/main or upstream as yet:
> 
>     rxrpc: rxperf: Fix missing decoding of terminal magic cookie
>     rxrpc: peer->mtu_lock is redundant
>     rxrpc: Fix locking issues with the peer record hash
>     afs: Fix the server_list to unuse a displaced server rather than putting it
>     afs: Give an afs_server object a ref on the afs_cell object it points to

You don't need to re-post such patches, just wait a couple of days, when
net will be merged back into net-next. So that we will not have
"duplicate changes" inside the tree.

The remaining patches in this series touch only AFS, I'm unsure if
net-next if the best target here??? The rxrpc follow-up could just wait
the upcoming net -> net-next merge. AFAICS crypto patches go trough
their own tree.

Thanks!

Paolo


