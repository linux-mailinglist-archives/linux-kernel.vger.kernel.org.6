Return-Path: <linux-kernel+bounces-358989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FE499860B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A9791C23BB2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F42221C6F44;
	Thu, 10 Oct 2024 12:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4kw2GX4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10201C462A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728563501; cv=none; b=V5B6nVuD7av7oRQeKBoRXQUSKJJDrwQ+s/XvwSEa9NP5o3u+ffHqHhOfbKvbxzMNXNDK41Jb5EyVVgGaXqYITbp5t9gekArUDKFSwaDY6nxN1znVvD615la/GZEwhueJbQMGruENvlkzEtYyBwrgvsY+uqhY2x+PWMqFOBxGE10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728563501; c=relaxed/simple;
	bh=L4ooXiCT1u8VDy2NKMaHzqDIECfnj5QbZHivTQRFVXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smWNdR44Jmo+Ki+Wr4v9eivSALQRRf9is+j1rNr0fuKwjqNSK9RtLSpoHIx8j1N65kVxmu4i6NI0dx4MA4Dw2iX+v1kLJRmnMMdHfhYy8tVkSTfmMmkZDTqVH+Bjd4FlyZjYqEl6lsOxPWyhILOUVj3+YQkRxdGxq5ykXVe8EA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4kw2GX4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728563498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yMLaQ5QkFa8Mr6Qfl8g21moI0yjtVUAR75K3syFBELE=;
	b=E4kw2GX4yCrchyYHjTBM8uGThGV4/YGaUSfN/7lXpF3VBfWuJIy4BNB3zBZj07oY2yD1sb
	qZUa45HR6kcGwSB4JEUcz78aAX9cS6mdtbRxhnW+1JcAHObxhi1OUdaQy/eTiwDuFKbYk4
	DEeU2ukp0jJYNT8VxSkG7fySIoKrhSE=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-oIWyaeacNlGAFswY1yqNmg-1; Thu, 10 Oct 2024 08:31:37 -0400
X-MC-Unique: oIWyaeacNlGAFswY1yqNmg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2fb1c04af0bso7082551fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 05:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728563495; x=1729168295;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yMLaQ5QkFa8Mr6Qfl8g21moI0yjtVUAR75K3syFBELE=;
        b=Lp7ERtwBZ3RC6vpRY7N0BprDCAc9fh6toksAP+1NulRWPYpfRoar5mhlqHLANqgOav
         IPwyPwvbrl232uPW4Nc0X02wMWN9H6MOJoftXIPITvouAqv4rYZnbKPGElP3sAJMN1lA
         bX8JHad2xD7YldyqnGumjkOwGDYiMN2lj8zAPK6CN1v1k6ujG46keKYrgwBc9dd06BbD
         Y7x4bEN+7HCZ15ETY5A2zNj7OeiH0xITHu/PG9EXE+c8Xx7yyGKsF8I+W3WB0I0LL/3M
         rCrIYOxKucAFXCwlj4PEZcJPP71uy9xE2JJjbCAORLmXBrQGeLU9qlZQR/nLhD3vgv45
         be/Q==
X-Gm-Message-State: AOJu0YwUygpzn0/QiPnWXeYrL1xQqwvHL0PEi6JJRcCpC8uCznKZam5X
	rZxI7c9PvCRmmiwRVoiILHf/KfRCXqWXlsePoEtlob2kA8LXEDPaSU7OJW0GaPsAdeWZyp0+A9K
	QBygsuF9cHLxlmW7Vo/18yD0UHdyc4vBLcYH/Ya/n0RqDS0eMfjYJGEimHd3Xag==
X-Received: by 2002:a05:6512:224a:b0:52f:154:661b with SMTP id 2adb3069b0e04-539c488d6b3mr3544281e87.11.1728563494625;
        Thu, 10 Oct 2024 05:31:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnHr4Irxyr+RYVKlyujdagWkzSUYqYfjeKA3ExmFU3+AVt6K1LdKHp/baluH2R3E5i7h5IRg==
X-Received: by 2002:a05:6512:224a:b0:52f:154:661b with SMTP id 2adb3069b0e04-539c488d6b3mr3544262e87.11.1728563494163;
        Thu, 10 Oct 2024 05:31:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c742:9200:eb2e:74f9:6f5c:3040? (p200300cbc7429200eb2e74f96f5c3040.dip0.t-ipconnect.de. [2003:cb:c742:9200:eb2e:74f9:6f5c:3040])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d748dd50sm47931965e9.47.2024.10.10.05.31.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 05:31:33 -0700 (PDT)
Message-ID: <e0e13b95-bc9a-4f4b-a721-379676725525@redhat.com>
Date: Thu, 10 Oct 2024 14:31:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] virtio-mem: s390x support
To: Mario Casquero <mcasquer@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
References: <20240910191541.2179655-1-david@redhat.com>
 <CAMXpfWvRy_fpNUXeVO_-0O9WXDYY8f+cBEQQvsqZD2g2043LaA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAMXpfWvRy_fpNUXeVO_-0O9WXDYY8f+cBEQQvsqZD2g2043LaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.10.24 10:41, Mario Casquero wrote:
> This series has been successfully tested along with the QEMU's series.
> Virtio-mem devices could be resized, plugged and unplugged seamlessly.
> The memory information displayed is correct and reboot doesn't cause
> any issue.
> 
> Tested-by: Mario Casquero <mcasquer@redhat.com>

Thanks a bunch for testing!

If there are no more comments, I'll add the in-tree kernel update for 
the new diag500 subcall and resend.

-- 
Cheers,

David / dhildenb


