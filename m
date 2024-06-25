Return-Path: <linux-kernel+bounces-228482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E386916081
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6ACC282D35
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F8E146D7E;
	Tue, 25 Jun 2024 07:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uov8r4kX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95126144312
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719302262; cv=none; b=cvw0JaOnfObXJNeyWlU8efniS0WyVC68YBfsPQg+tEl0TrMZK3vrTPfo2Zhc8GmWH0PQPmsi01UgUjdvzXz7TjN4FVZdugjX2/wKzLyYc+OjIZTKBIks31CTw3rRqLKQVJwigrhRWySAgMJlDJ2IBKz2UBcHOcOtWnxvbypt+fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719302262; c=relaxed/simple;
	bh=Wlc36+PGhvjjvSPA9aoelCfxeFiMdalGPnlYKE9au40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SltYHw9AzATAn0xzovmUws/aDo+bDxqeHYoXHplI8E9RFjSCboo5yL4GGtAq1P4NFYztWpDgHTJd9x2F9WB0DunPbiD2fCAclKwAh8gvDP/8gUFG7JAJRPK9OWq1s51EEEaClWSjpOhd6aX7/jPkarklxXZBaM2TYqE196fetTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uov8r4kX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719302259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wlc36+PGhvjjvSPA9aoelCfxeFiMdalGPnlYKE9au40=;
	b=Uov8r4kXBQHUdTzizROlqWIYSbiN9+KLF10i9bK/ldvR/q205cH6E7Zlb47tFX0Lahp23A
	YwDU6A+1D3S+JSnT1GxAPok79b+Mq5Ol742YkUVg9sFSgDPF9pmskJ8YryCmPzmAaj8eWT
	WWg9Y7rwR9dCqxNtiMDy5OP8ORyq9xc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-Rd0a-9DDN7KS4bxxcjHf7w-1; Tue, 25 Jun 2024 03:57:37 -0400
X-MC-Unique: Rd0a-9DDN7KS4bxxcjHf7w-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52cd67cee83so2738196e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 00:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719302256; x=1719907056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wlc36+PGhvjjvSPA9aoelCfxeFiMdalGPnlYKE9au40=;
        b=bo2M7rK2ZsNtflacoxBDkZkurllKSeVij768b4UDxQSbgcMeuz2/f6O8vq0t1vIyJ7
         bZuPrBZhxgZbKE1MI6N3qSB3ffDzs7IdO/g7a3BjMfXrYDObLpA3TY4yXffqnMdQiwgO
         QYNx14brhGO8IHfPdDLzaU9KVcj+xXcYvpIA2j3lvV7rxzV0AaXej/F5kInGHBF2AYcV
         NwrE8HoQoMDUmO0BTB6JzT9GCJWSEJAcfQW9sa5Va9zDA5iMgUxE4WQH3P8T5tIiWUxB
         mmVhB8BYtS6Ktw1qwiINHhqYzvK61eqEDRbfzvGDWwqfvCnsWozNLpZche0qZVXlf1rE
         dFZg==
X-Forwarded-Encrypted: i=1; AJvYcCWtRiJb1N+bvTrojw5Nl+aD4tfpgK/mK/T+vBZ0xaMNoimNtieODyR4w8GANJOD1OWYDNsIdSJyPV3lt2xdKlx3YpidNw6JkU6VxWTT
X-Gm-Message-State: AOJu0YySZEOCEU+yq+CaOwgn06ww4Knw4Isn1LQ0StjuxpjVJ1cKOqLA
	wa6Grj0Cl+8c2iDMoRlzmx7HpgIoN7DG2xS/YaCq9EPYOTIVlIvrJ/cm0DTJ7aDr6FF9rSxstkC
	grJxmVfCdBu5bCyS6wsGa/Cr9goM/urDor741n+OQNvpSGcmocQj3vpUvWB9QjQ==
X-Received: by 2002:a05:6512:402a:b0:52c:8051:5799 with SMTP id 2adb3069b0e04-52ce1832b57mr4772812e87.11.1719302256143;
        Tue, 25 Jun 2024 00:57:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtSiI6MnJMyKcIBakFxsAacJJgrU/9spzJO8lG47UPorN5R3MoQXUk1RYI4fQLSyfsKsVUtQ==
X-Received: by 2002:a05:6512:402a:b0:52c:8051:5799 with SMTP id 2adb3069b0e04-52ce1832b57mr4772784e87.11.1719302255343;
        Tue, 25 Jun 2024 00:57:35 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:342:f1b5:a48c:a59a:c1d6:8d0a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4248191fac8sm160640555e9.42.2024.06.25.00.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:57:34 -0700 (PDT)
Date: Tue, 25 Jun 2024 03:57:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, venkat.x.venkatsubra@oracle.com,
	gia-khanh.nguyen@oracle.com
Subject: Re: [PATCH V2 3/3] virtio-net: synchronize operstate with admin
 state on up/down
Message-ID: <20240625035638-mutt-send-email-mst@kernel.org>
References: <20240624024523.34272-1-jasowang@redhat.com>
 <20240624024523.34272-4-jasowang@redhat.com>
 <20240624060057-mutt-send-email-mst@kernel.org>
 <CACGkMEsysbded3xvU=qq6L_SmR0jmfvXdbthpZ0ERJoQhveZ3w@mail.gmail.com>
 <20240625031455-mutt-send-email-mst@kernel.org>
 <CACGkMEt4qnbiotLgBx+jHBSsd-k0UAVSxjHovfXk6iGd6uSCPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEt4qnbiotLgBx+jHBSsd-k0UAVSxjHovfXk6iGd6uSCPg@mail.gmail.com>

On Tue, Jun 25, 2024 at 03:46:44PM +0800, Jason Wang wrote:
> Workqueue is used to serialize those so we won't lose any change.

So we don't need to re-read then?


