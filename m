Return-Path: <linux-kernel+bounces-557531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3919A5DA72
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2453B6DDE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789BE23E342;
	Wed, 12 Mar 2025 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJc0rzld"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705C315A858
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741775482; cv=none; b=Ud2OJdczQTZF+1YaPmHn6NP0ahaSIaDUKU5eu+KaukCeTDFRkLqKA0/wrrEW8PpFjiUphVuqI6B5jJuor94wgMcQWEBZdkyV0kAuLL8nyFdcFuHsqoAqvw30Wvhm2iJgQ92YaK19eCCFqmqha6hSYC9Po3j9Fyvo4MYbGPalj5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741775482; c=relaxed/simple;
	bh=P99lE3mJwXPj+GEbmP0xwX+rf4eTqzBXZGRaykWQ8v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nY4cH5MX6YTYSMlP3iLW0QH4RbIwKQ336VT9v59MvyRmalIeCxVAsG/XEwnVy8uWD/h3bJd1C8ZZzBk3u11MILj9mnaKatW3f6S3zHoe4dhUPmJOVG23SzmiiKThk3uW5YmaAs8zbFlH7gPPIlvOq0fQAnzLTTd43L85kkn//e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OJc0rzld; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741775480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cx0qYAqk+Ndkh+zCqVoXeKfQLXTHj6djYkow7w5DHN4=;
	b=OJc0rzldSenE1mWgOFuaI442IlQSq907b4yS6lwxwLgPvSQr5JY3vW1zc3kBH1IpTK8yJB
	De/ayYfXHvJdwgXYxJUPr7LbQ4M9UiFLgfsi4TNaldNMrBMU6RWleZfO8ESMoowzLFS/4X
	JYvbmYBzWCF/9o/jbncYA5Q9jBjqJpo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-aY_RAd6mONOy39qkWny2dw-1; Wed, 12 Mar 2025 06:31:17 -0400
X-MC-Unique: aY_RAd6mONOy39qkWny2dw-1
X-Mimecast-MFC-AGG-ID: aY_RAd6mONOy39qkWny2dw_1741775476
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d007b2c79so19065035e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 03:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741775476; x=1742380276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cx0qYAqk+Ndkh+zCqVoXeKfQLXTHj6djYkow7w5DHN4=;
        b=S+rHkPJaCY3zzW/1qS6nsoGvdsiVklpka9PBJp5zvKeHR3lUG00mZjOGRiS0xPXiK6
         nIaIhRsW5XipUxZ8wonm0JPWa4LAsDHADDmOGkhQYcry4ZKzaPQLZYrx6V/1m6PvuXk2
         Ng8Uaw2oQbKaAAfxSIFc3w9DtaPCrZ0wjmZFanxMQyj0AfM6hbUN3X6jwW6oHmF5PBr+
         /tHqGfAS3kdvIYWMwMJ9pt9T2gYx20kcXlMO9ubDGPOwRzUTspOQRyOpEFtZY2tNeK/r
         u7n+UiSeC2qTdp9HpkGgBqzgTRH0BuV8qsz5Up6y7Vl8aS8K1vP0pAnXHJ0Zg1Gry7gw
         M8Kg==
X-Forwarded-Encrypted: i=1; AJvYcCXDoO/Max3DljUfH5d+plJ9JSK/ROTLybQntrLuH1/JYRn9K4BNZj3k4lZ7inG9qObCXVv74srumERghT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6C4w1rzwfEUqZc8sL+Ntxd+T9oUWrn5MXGZAyUIcFtBZDtT2n
	186fzWbWh5Iv2OPagd9Hs++9C77Qrk/vxvamdFgG711uUO45CVdXtHKBvGeUGv844MOSTT18mQM
	Jvi2i2ZBxYDSXhXO8qWGWmFkN1lXuafg0iRrvswUwiYywg0iB49hVzR0uaeAAqQ==
X-Gm-Gg: ASbGncsOPbnCLfecZlcoCLjonpPYis45gErOMLkNynr164VfPo7YBhNTQDmoq2A4BhA
	zonkKiByZg7l5QlgriCmY9FsAy1dUSDohkiv8wkcftnre92YWdQch3aJXNVzk75Z3Kc12W66jQT
	qelKh+DGujpOKZ71FFYdQcl5R2gBQDRE/qgnGjylGxN7a/w6lo9RWRuRI4nScUtzTeULPoZeNyS
	CHE+TUDJq7HfEA90LK15shH1sNdGCQIvFE9vlx/IDJzIYnknesXpGZ05fCbTD8Giibram/z/QM9
	Rl84f1ZOZA==
X-Received: by 2002:a05:600c:1c81:b0:43c:efed:733e with SMTP id 5b1f17b1804b1-43d01be6389mr90683885e9.14.1741775475783;
        Wed, 12 Mar 2025 03:31:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMo39VgoZH85nAphCFnLGhSo95m+X8Gu22NIYuOsLFerRQWzuG2jF+y+KHgzz3MHJwbiYZow==
X-Received: by 2002:a05:600c:1c81:b0:43c:efed:733e with SMTP id 5b1f17b1804b1-43d01be6389mr90683655e9.14.1741775475423;
        Wed, 12 Mar 2025 03:31:15 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a72eb5fsm17374525e9.8.2025.03.12.03.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 03:31:14 -0700 (PDT)
Date: Wed, 12 Mar 2025 11:31:12 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Harald Mommer <harald.mommer@opensynergy.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>,
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
Message-ID: <Z9FicA7bHAYZWJAb@fedora>
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <a366f529-c901-4cd1-a1a6-c3958562cace@wanadoo.fr>
 <0878aedf-35c2-4901-8662-2688574dd06f@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0878aedf-35c2-4901-8662-2688574dd06f@opensynergy.com>

Hello,

On Thu, Feb 01, 2024 at 07:57:45PM +0100, Harald Mommer wrote:
> Hello,
> 
> I thought there would be some more comments coming and I could address
> everything in one chunk. Not the case, besides your comments silence.
> 
> On 08.01.24 20:34, Christophe JAILLET wrote:
> > 
> > Hi,
> > a few nits below, should there be a v6.
> > 
> 
> I'm sure there will be but not so soon. Probably after acceptance of the
> virtio CAN specification or after change requests to the specification are
> received and the driver has to be adapted to an updated draft.
> 
> 
What is the status of this series?

Thanks, Matias.


