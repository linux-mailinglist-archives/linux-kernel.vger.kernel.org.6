Return-Path: <linux-kernel+bounces-230944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A1791842A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868761C22564
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5043418A93B;
	Wed, 26 Jun 2024 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzf+bnpO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472A818A925
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412110; cv=none; b=n/6kVup3X7+kjL6bHdAd2EzNqPZjAWCxeKm3ZYY6JAv5PtEXw/TkVJS8LWOstVsPH960AbDJZP6htdn8iFToxVHmYJTDZBOo+ne2imeTIxTYHOFYHUflzyxpUwYR2PV0cbX7ocKeeoqakmYPV33EMVf1yBKGC6hHojpp1YVq6zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412110; c=relaxed/simple;
	bh=qclw3hNdRZPu9FR309qbQzi7OVWGtjqbBigYh7+EjTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PzeFNdW9n3xMyBaqdzPWfZP4iROimKYmwdFOGJH+Fxz9yCtxJpVqJ4fJH+6svsJ23VUIAuHB/j8K6oMrTK8/7Jc9Ppqd6+vvQw+zpJmjSvrSpFg0kQFY4hI6/ot1cWwue/SMpm3Sold8yK7AYOYCHkM4yAy9rihLkIM8ZABauoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fzf+bnpO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719412108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qclw3hNdRZPu9FR309qbQzi7OVWGtjqbBigYh7+EjTc=;
	b=fzf+bnpOeURr7k+17K3rGju9rQAcDfFIs7JKs+l5xHTyFPagYqkBqqAmQN+zRXWzPXoclK
	xOBzwvk3291l49INBqsgW1Z1VQWbcsC5/oXskbNUqavJ8q9FBQCiLYmiGn98nWWBlFwiJ7
	cu79fOS3vJYFsmftMSwMegzHeXQg2J4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-3Vp_7YR1Na2ZhrEUleXzqA-1; Wed, 26 Jun 2024 10:28:27 -0400
X-MC-Unique: 3Vp_7YR1Na2ZhrEUleXzqA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a7135459efbso257782266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719412105; x=1720016905;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qclw3hNdRZPu9FR309qbQzi7OVWGtjqbBigYh7+EjTc=;
        b=crlCOFc6kJMk9ROeZZKZHqTHI2xa07U4zNWRyP5KOeHPxjgPix5uX2eY9q6TRvM86e
         Ybgv0PW1YolvR4p9m4z/VUNArCITa8E9p4r4PtGlt/HrmOCB8lxR0eYES99o6SDZpXca
         5h3QSLAkHPUMYVvXt7+waX4rSB+moZ84cjDGGpYy0Yma44/MKbsHoJ7lxF9TtuwIxAmu
         uTa7OSO+nevGAKePIRUHykAlw91kpsBgc9+iCdrVRrYSjnVJErfF+imJHklCFrsQqsRV
         fGkmm9MVgdQHeGvaw70346MevigMEywI4hwsDBMvmN9EnT2wYmrT3eZdXguwF7zvcMQP
         /xYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIdo4uK2ll9+MGjmz4PJvviwlQY+tQwORpSRZo5Xhv//aOgibStO6pwBSVX805ZuD/G35Fx8/FjvIbPAkex/JHMVNA/LUTYwR/BQUj
X-Gm-Message-State: AOJu0Yzddqt0BVI79hYb7evSQ7XZJN73+6u+apQ3COahQ+WZA1OXqGvB
	yC+QRd2xXLvcHSaHUW0ILMrYuse79swXa0Kj+1Vq1cbPzEwA9OqdglwKPhuyi8gmnGRv0CRCYnv
	8qieLHrkYZ0Ozz7tWWxiGIibQ6plWlcrF/llYf5ONF9mA6HbFhb60dCIz4Vh1Vw==
X-Received: by 2002:a17:907:7ea8:b0:a72:55da:fb27 with SMTP id a640c23a62f3a-a7255dafeb9mr614664666b.5.1719412104912;
        Wed, 26 Jun 2024 07:28:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEapJi3f74BhkPhjlfRvacWqVYnKggewt5I2zL+WOXW6YqOZnd/6nAKEhMYOQSETUj3uEfgoA==
X-Received: by 2002:a17:907:7ea8:b0:a72:55da:fb27 with SMTP id a640c23a62f3a-a7255dafeb9mr614663066b.5.1719412104609;
        Wed, 26 Jun 2024 07:28:24 -0700 (PDT)
Received: from [10.39.194.16] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a724ae806dbsm383611766b.41.2024.06.26.07.28.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2024 07:28:24 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, horms@kernel.org,
 i.maximets@ovn.org, dev@openvswitch.org, Pravin B Shelar <pshelar@ovn.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 06/10] net: openvswitch: store sampling
 probability in cb.
Date: Wed, 26 Jun 2024 16:28:23 +0200
X-Mailer: MailMate (1.14r6039)
Message-ID: <7AB95FAC-2D5A-4D9A-BB9A-9B0C8C01CA61@redhat.com>
In-Reply-To: <20240625205204.3199050-7-amorenoz@redhat.com>
References: <20240625205204.3199050-1-amorenoz@redhat.com>
 <20240625205204.3199050-7-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain



On 25 Jun 2024, at 22:51, Adrian Moreno wrote:

> When a packet sample is observed, the sampling rate that was used is
> important to estimate the real frequency of such event.
>
> Store the probability of the parent sample action in the skb's cb area
> and use it in emit_sample to pass it down to psample.
>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

Acked-by: Eelco Chaudron <echaudro@redhat.com>


