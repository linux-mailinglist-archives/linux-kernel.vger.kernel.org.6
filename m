Return-Path: <linux-kernel+bounces-535994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07222A47A48
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D83313B1F34
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8A822A80A;
	Thu, 27 Feb 2025 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ct7ckqjP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC0C229B0D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740651896; cv=none; b=kCErnp3odV96DS6tWdH5IeyLvYa488jZjVjdSOd/9im6ZbDxgDqqYhZT/JTZxbmzCsOEixe06XBsi822MpmCbZ6u7uApN/M3aZB4b+oaGrWGhpue9AU+cbXjEuED1EFdHeknLUUNxzaUIJQLWzI/APM8jQMup38YRoQtQHV2CVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740651896; c=relaxed/simple;
	bh=YYX5Y6x8sVNtWqEWCHNDXuQkb2mtaSvdi9UEEpL/J1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cKkHzRq6Uc8quYMJMxRYMGrSTqj00vkgEPqBisfiG1KKaxmydUXUZRfdXhdcyPzTiVAVzUrERzs+Z/aKJqM0dvYT1qlZgnSXjRzt0FG6ksPqSbjte8XDh5A6w7DfIEGijoNCxbePx5Lp4dyWxzlU2kX0IptUtLY1qmdA8ohMKbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ct7ckqjP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740651893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YYX5Y6x8sVNtWqEWCHNDXuQkb2mtaSvdi9UEEpL/J1o=;
	b=ct7ckqjPrYoVRjliRpYfl3qFPyRt2RNPFOkarw0Zb81nWrDhwR6nJ0zRIKa2zYC+B/AoNl
	Am7E8F5IdIuysyawIYLZHkTNmvfKOyiaWI23hi165KhOWXaIqEcldQcCdjDiuzoSkpj4dy
	Vs/TewJLoAr5zEebWphASMimTWDpGZU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-4xNkZy91MXiaa4JL6Y0ASw-1; Thu, 27 Feb 2025 05:24:51 -0500
X-MC-Unique: 4xNkZy91MXiaa4JL6Y0ASw-1
X-Mimecast-MFC-AGG-ID: 4xNkZy91MXiaa4JL6Y0ASw_1740651890
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4394b8bd4e1so4135515e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 02:24:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740651890; x=1741256690;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YYX5Y6x8sVNtWqEWCHNDXuQkb2mtaSvdi9UEEpL/J1o=;
        b=dHJjWp6yW4EyJl+UkDi9/6QqLlPDXy0F8h8IkyJH8Nu0ZDZpoxIo0Q+x8ACBIT7Lyo
         DsVWgnOPZezj0LdavHh2Vm3TJs9WXlQcG0CE721KUCCQImLrJeErHaPzLvetN/W/Xp1K
         AVnckG/dsfJAOp48KVFz3BTGfX29EGJRKC0GXxjd2IHL8TG76uVbxvD9UEsKGLxW+Q60
         7lQQWYtATVBR3bljrHL/z/b6dROnTKibkEPCkzaSL+60CLXWslaUauta+N4xJXT+Xlmp
         BYwqSKeohBH6xVU9a1JPIJUdpZjqapfIORe0wjVP1n931cbC2KVBXf1yZpdfOzaFDtZm
         OQ+Q==
X-Gm-Message-State: AOJu0YxJeiiFyi9sJhBwrr7gjxUChERNUqhyynOhabYEEC5bVhjR70oh
	8CUQ+drolMaSQMh7WA0eIL+wePvoUCR9KRDYhXvqClUt6E846QzuDCiCow/mZdYwsX7K+wnzv9d
	mwK5YShAPnBxTMHMjLzHpCofNlZ4me1rHhop+wWC5/g0qOJZPE9fcyq6NylP/IQ==
X-Gm-Gg: ASbGnctUGQyqJgMbzToKtN5T4fK1FfGiTPU9jLYyBht85rg9np14UhEqFBY1omoJo+L
	+/n6nooxhuX2foGWuMcw+/e9jB+qMy9veHIa7w/ZTjxjbAwh3+eIFf9Ww4MapV+ZPKyXoTlWEcL
	ymS8YKc6GvoNANnBEi4jaLJib4dxRA7owOvIyJrZLTjwisUg3+K55IJCa0NTd2U3Ja0BRtifhYZ
	lec/PDP18mPhn9mGsBIrqep5zR8yUS/cSNvatKaR7+m1OzQCqHpc5pTgRDsLYGQXkMmKg+IKoNY
	v9urgbKr5165aER9Q/foLXohbUk1vaCIgESll+jvY13Tsg==
X-Received: by 2002:a05:600c:4fcf:b0:439:5a37:8157 with SMTP id 5b1f17b1804b1-439aebf3613mr245216635e9.30.1740651890265;
        Thu, 27 Feb 2025 02:24:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8N+SGDfS2sopNFZtZ5Mn79q9qVg00ddErNII9bO79/XW8bgD6mRD8xzkPQyBtEOZqB0OjPA==
X-Received: by 2002:a05:600c:4fcf:b0:439:5a37:8157 with SMTP id 5b1f17b1804b1-439aebf3613mr245216385e9.30.1740651889915;
        Thu, 27 Feb 2025 02:24:49 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485db6csm1566929f8f.91.2025.02.27.02.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 02:24:49 -0800 (PST)
Message-ID: <ec8fbe36-138f-4a0b-a8d3-95e49187a47a@redhat.com>
Date: Thu, 27 Feb 2025 11:24:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 4/8] net: pktgen: fix mpls maximum labels list
 parsing
To: Peter Seiderer <ps.report@gmx.net>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Artem Chernyshev <artem.chernyshev@red-soft.ru>,
 Frederic Weisbecker <frederic@kernel.org>, Nam Cao <namcao@linutronix.de>
References: <20250224092242.13192-1-ps.report@gmx.net>
 <20250224092242.13192-5-ps.report@gmx.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250224092242.13192-5-ps.report@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/24/25 10:22 AM, Peter Seiderer wrote:
> Fix mpls maximum labels list parsing up to MAX_MPLS_LABELS/16 entries
> (instead of up to MAX_MPLS_LABELS - 1).

Very minor nit...

The above comments sounds misleading to me. I read it as the new limit
is MAX_MPLS_LABELS divided by 16, that is 1.

Thanks,

Paolo


