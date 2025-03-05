Return-Path: <linux-kernel+bounces-546394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D636AA4FA19
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2290170C90
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16872054ED;
	Wed,  5 Mar 2025 09:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RRK3eg8c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1871204C0B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741167040; cv=none; b=gjTFqBJKtnRlPMUbACajMRQHGVZY7OUqcsZnojIfmuh8m1wL+2ASSnZiUUZOu7LfYSBuJ8ckNuYyOpSMw9J5Mc/gluhrugCUpdryS5xkKVFyd9BAHM0hkfXnYOfT/vUg4dfXiFarao0IoaBYPtP9ILiZbKaYGADUWJi7ApJIF68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741167040; c=relaxed/simple;
	bh=Vxv0VBbtdbVDbDGLcORTnzoIpxIDB3hFqwWMEq+B6MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kh6IqzFGcE2lvxy5l6YK5HGN/gdWBWJ4VG+gm+e0T7pSQpVuuw4oX3tXMdPtGDcaS7NNyUzwJunWgKCW0OQw3vPlN58A3ABAxme5mqz/xeIQsF2QZiN4VPNbPhKJ3EkfAyWqdIer3U6NsN53Jj/pWMIvQNzCS4sWbpoty1ESVU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RRK3eg8c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741167037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8BZqtssEKSX9U+sm7giaUTnUcD9w0nxNJyaKF0Dg8jk=;
	b=RRK3eg8cZJIviDmanGRmH8RFqe3h0bm1OxhLwj3ARd1SdFA/Pb8Eug0PD075NEdlxrS8fR
	uJ6j5JNAWpMtGKspE1ltMBstLJkNoX0ecSVRbcrnZlKk5ShSMZhCygxoHDGwz/mHSR1S0W
	KovkG+RbiO03B+0eabhff2jjMGUys3A=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-w1FDP2PqOmeSZZ9NlJLVlA-1; Wed, 05 Mar 2025 04:30:24 -0500
X-MC-Unique: w1FDP2PqOmeSZZ9NlJLVlA-1
X-Mimecast-MFC-AGG-ID: w1FDP2PqOmeSZZ9NlJLVlA_1741167024
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-abf68178603so409233566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 01:30:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741167024; x=1741771824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BZqtssEKSX9U+sm7giaUTnUcD9w0nxNJyaKF0Dg8jk=;
        b=JNjuyQp2vnCyxwDBroBbgwy2iu1YQCoYkKC9flggkyDLFir05oltTfoa89FtvA0aqS
         ZoZAOqXap2CLNzE5qD4V8RjoUCLVKaSeZlfC5kyFYHc6kZaV9VLnX0juhChwa1CzocAE
         PFd2gb4wBGFRLr+Ec8Mz3WUhEyhFYN8PnvI/giRavrjSbBUVRroctwwkdGMvKrPLcftU
         2qVaz5z8zhkDR4iBwj/StxesGNepe91/O43mBdJgnUgRWxzcPG6wANlyTFvtiC5DVUVt
         VR+MeiM7WH70RpOxLeHXllZiGM+V/yOmp2TftOP4yF8kq8PYeaqv3lUCgYHvoJjKl+lA
         YEXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQfqabmzmBt7Xx3ulxySBz7lMysan1N5oS/nnpWFSPJFGk685teMECQQLJeJwXH/SnwqMrGeAlcMportE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt2EQLumjfnIJJiK6jZguODE27rfMovUMdsXj2QNI4Lk2Ixkr/
	G098uo4bDeuoyNhoDgKJfyIUcUfwmByr9S7k50cY5EPOajsd+xs1e6j0G27BNmZpb9ZcUzw7N7o
	fEpuynZIkwRmHCMqjONwe72zNGHtU4vcj7Cpxkzi9p5VXd2GrJo4cLIxIX/cF0A==
X-Gm-Gg: ASbGncs1v/1poDH952pniBPKSl+XFPua+5ppfSH5o+KomJXRuUPWu8/wgyoSH3w5lqb
	XRjAMi4W5312LDDD2nYQIR5NkhKdW9F7w2AzB8Ic5ZccpK0UxhIzdgCvGQlKKAvMbP/oUmVl4nQ
	E7mK4m8AsAj/iNNTF9TyTrB9xIBcUnVrcGzaMNZXVfJn/GTuJQzewV7yZIUvOKf/Smfr7eQR+3A
	JPZwWK/udrNnfOKlo1uIIpcD5c35Hi7duWKFAE13zd0wsIAfXgzvAu1U5PNg5e4rT2Dm7UFEiLh
	v8KkGv1DCKpu6bKNMxYVpUrzD93+NeC+Kr8S66rzrsIfm24pm13AQzTfgS8KACFN
X-Received: by 2002:a17:907:9494:b0:ac1:da76:3633 with SMTP id a640c23a62f3a-ac20d84412emr257569366b.4.1741167023614;
        Wed, 05 Mar 2025 01:30:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXk7a1z+Ze1GZvne805ygS+jajQyu0NiMIy6MNpjgAxqXVnbiuz0kcZ2+UtS+U3NrxoZnl1w==
X-Received: by 2002:a17:907:9494:b0:ac1:da76:3633 with SMTP id a640c23a62f3a-ac20d84412emr257565066b.4.1741167023076;
        Wed, 05 Mar 2025 01:30:23 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac20225a3a5sm182343166b.177.2025.03.05.01.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 01:30:22 -0800 (PST)
Date: Wed, 5 Mar 2025 10:30:17 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
	Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, davem@davemloft.net, 
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
Message-ID: <v5c32aounjit7gxtwl4yxo2q2q6yikpb5yv3huxrxgfprxs2gk@b6r3jljvm6mt>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <20200427142518.uwssa6dtasrp3bfc@steredhat>
 <224cdc10-1532-7ddc-f113-676d43d8f322@redhat.com>
 <20200428160052.o3ihui4262xogyg4@steredhat>
 <Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebook.com>
 <20250305022248-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250305022248-mutt-send-email-mst@kernel.org>

On Wed, Mar 05, 2025 at 02:27:12AM -0500, Michael S. Tsirkin wrote:
>On Tue, Mar 04, 2025 at 04:39:02PM -0800, Bobby Eshleman wrote:
>> I think it might be a lot of complexity to bring into the picture from
>> netdev, and I'm not sure there is a big win since the vsock device could
>> also have a vsock->net itself? I think the complexity will come from the
>> address translation, which I don't think netdev buys us because there
>> would still be all of the work work to support vsock in netfilter?
>
>Ugh.
>
>Guys, let's remember what vsock is.
>
>It's a replacement for the serial device with an interface
>that's easier for userspace to consume, as you get
>the demultiplexing by the port number.
>
>The whole point of vsock is that people do not want
>any firewalling, filtering, or management on it.
>
>It needs to work with no configuration even if networking is
>misconfigured or blocked.

I agree with Michael here.

It's been 5 years and my memory is bad, but using netdev seemed like a 
mess, especially because in vsock we don't have anything related to 
IP/Ethernet/ARP, etc.

I see vsock more as AF_UNIX than netdev.

I put in CC Jakub who was covering network namespace, maybe he has some 
advice for us regarding this. Context [1].

Thanks,
Stefano

[1] https://lore.kernel.org/netdev/Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebook.com/


