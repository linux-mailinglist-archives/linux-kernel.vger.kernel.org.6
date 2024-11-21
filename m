Return-Path: <linux-kernel+bounces-416746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D45B99D4988
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9729528146E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793DC1CB333;
	Thu, 21 Nov 2024 09:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bXx63RYK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3094982890
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 09:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732180092; cv=none; b=gOP7+cvqZQRYA4ndZ0AMsyVd4scHrtXozKjzA2uR+OrVWNsl3TEa4y/1baMcQ6znd/z2G177Lf+wpu96daT5ag2wKZyBG4axveCIPr0Tb8zQf1PRnsXHdG+RA0cgwJVT5K5WEeeManaFP8LQP1ZMzM0Wpfko8Xfw+TenVx39Fgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732180092; c=relaxed/simple;
	bh=XfxHG7T9zdJ9nblrp6w+ekWfkJvYj/7d5Bu7Q0dX2Ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S9tINYdLT6PTvHsK9hwkEf0k9XzH4T4bifgXHhSkigdpyJcOVim3sZuIvXJaw06CxFZoRrW9PuHdXRVMXZeno55Ck3orgLwSo880Obn3wGBslEeLe23m/SAqmb+CiCJagXYQwems9K9D5Z3Th/v7r05aZ441BCJlueqMeQirK0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bXx63RYK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732180090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=afC2fEWr0oOrXo3pVR/4wD4LruzaVFrljRmorsICJx4=;
	b=bXx63RYKEduDE99zNB0uqUxUMCieweSlzGRruOYGGkIbRDMxX8fT8xvHUoExKlUyiAiODY
	WtKpFZHrNvk2DYggAVwRhw9LgVN7notwV4Uh0yvukM2POHM5y/YpU97WvdOM65pTUIr4UH
	+IoupB2ucpUzUygqvO0CGhQCkbB7ds8=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-JxXKc51wNX2c140bavv0Dw-1; Thu, 21 Nov 2024 04:08:08 -0500
X-MC-Unique: JxXKc51wNX2c140bavv0Dw-1
X-Mimecast-MFC-AGG-ID: JxXKc51wNX2c140bavv0Dw
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e3859de1c11so1225725276.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 01:08:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732180088; x=1732784888;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=afC2fEWr0oOrXo3pVR/4wD4LruzaVFrljRmorsICJx4=;
        b=ID/I4rJrJcOj0YW2YfOeW0JCeV4H6B6XYpWOa3Pfk4vSEKgFiftt8t4nr3fU9lVQ1o
         voC/6BYcRK7vN5mgrHnH9wfBVmoZH4GNuem5b0Gq7wK+4DghptW8HZahrgfg/t6kO79c
         5BEBa+hEOP84Edk5uRcxEHtwhgGmNf6I7rOUHj1tfoCJZV1rtl/ZxDmQ08AYHUHLL1q6
         dIwqBNCjOWH8hz0mMQGJV9MfXd3RBGvOkKRhnZQPa7J64sl1ODLT++nckDjQ9fD6eQtP
         RcsTNR5WmoTELYfEuf2n9qhxH9DHy4/ipuypOpYKpUgYuaTTb98uXxTCnjPypcnLRbWY
         NTnw==
X-Forwarded-Encrypted: i=1; AJvYcCXA2ecpM/D62EQV6pSknY/sP/lDXqD+0ygiBwy43/J5wA9t0FtcpcygimckzacG+t5Arb+BXinifgAVVq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEE3gjAimtptDXjyhwNLgBgsLySizFeg9gCx0s5u8rPVzwm7RC
	76u6WBT+Qp91kpWaTgGqrIXpTwGWtUOvxLc6OWqJTBH2/0nQHF/G+L+HDqLGU8VcU4n750fCdc6
	rjBZ4GHeLijB6MCD5In2/qfRrEmqmsZT/Jn+8V3HoqpDln0YQAp2/X4VrV17Rhg==
X-Gm-Gg: ASbGncv3Zo6ykRvdbNrFobYoCjAKxzWlcHs+NqqzkpYdkF9ETJ3d2oMjUVv4JBJq1eF
	2QhB523yqpzTyAJD6/kOvoiPDQkYDkdvSKcMKksD2tPPVXkDK4eYNkTfI2pQt6MA64cUDZW4wOw
	5Cmf0gMdsPoXVpyRxGRm+Aeo8A7cvvPFBQ/iqOzO5USJAonmzyDL9J0Ld4LeODW+UA3Q6iQXq+9
	+X6r/boFbX6LW0Qmkn+Fz6Mr6cy+wPdcXvbq/JHTXpUkit/e0W/7HrgZ/lQmhghXF/4wpSSgQ==
X-Received: by 2002:a05:6902:1107:b0:e38:ae50:3360 with SMTP id 3f1490d57ef6-e38cb58cb69mr6096050276.27.1732180088123;
        Thu, 21 Nov 2024 01:08:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvcd2Tc+vOWhnMdPjejOD4B82sqJ4ONVE5q8tt3h7dnbHkb3vWE9q84qQ2i9DLtZwcC9d5Bg==
X-Received: by 2002:a05:6902:1107:b0:e38:ae50:3360 with SMTP id 3f1490d57ef6-e38cb58cb69mr6096030276.27.1732180087824;
        Thu, 21 Nov 2024 01:08:07 -0800 (PST)
Received: from [192.168.88.24] (146-241-6-75.dyn.eolo.it. [146.241.6.75])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4646ac1971fsm19452431cf.89.2024.11.21.01.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 01:08:07 -0800 (PST)
Message-ID: <ed3a24ba-ec2b-4261-a479-11625b04b44a@redhat.com>
Date: Thu, 21 Nov 2024 10:08:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net/smc: Remove unused function parameter in
 __smc_diag_dump
To: manas18244@iiitd.ac.in, Wenjia Zhang <wenjia@linux.ibm.com>,
 Jan Karcher <jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Anup Sharma <anupnewsmail@gmail.com>,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241120-fix-oops-__smc_diag_dump-v2-1-9703b18191e0@iiitd.ac.in>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241120-fix-oops-__smc_diag_dump-v2-1-9703b18191e0@iiitd.ac.in>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/24 16:01, Manas via B4 Relay wrote:
> From: Manas <manas18244@iiitd.ac.in>
> 
> The last parameter in __smc_diag_dump (struct nlattr *bc) is unused.
> There is only one instance of this function being called and its passed
> with a NULL value in place of bc.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Manas <manas18244@iiitd.ac.in>

## Form letter - net-next-closed

The merge window for v6.13 has begun and net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after Dec 2nd.

RFC patches sent for review only are welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle







