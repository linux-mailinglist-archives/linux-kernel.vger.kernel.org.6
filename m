Return-Path: <linux-kernel+bounces-546378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A243A4F9D8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F3033A9DBF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDB0202969;
	Wed,  5 Mar 2025 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H6hwbWbJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EBF20127B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166601; cv=none; b=RA9jUbQd7tZwTE2DLLQsy1H3k1D7i1o4XMONqFxF+neQzumpFbvs4O/Xsxhk+A55GWqeicIE+CvbZKY9y3rrq31VESPJooI/rdlH2O0aE/UGvtHlVpber2X3Q8J2HIdm5RGHl77PoQXvwymWcbUCqoUo6imRqxbGoeMARMUe6a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166601; c=relaxed/simple;
	bh=+QfPm6bqrG0OcdOxhTC1BYzGGpBGfOp64hZJsZUGa8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYBFOivBXxTbLCidQLbwmNBGgktpl2LjrADjGFHSCGlOrAWvqnRX5rSS07liSPfUmC3ZJTJtUsxTrd5YPMfDCWNjiNcCZKHOyLlP4pp7Mybl5tve/ambkDAzalMZxRgnibCtSS9g9X6o4jEp4F9Ng/2gdzmk4k9BVdB5iK04MHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H6hwbWbJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741166597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Fz/47DT/bcZQibct8BTl8FGEvkFXwI/p/JU2LZO+88=;
	b=H6hwbWbJvRc76HNKQr1ncFfLpM5roA6dEbbpRKWURLBSpKbzmqw3SLtXU96DX24QKcZ/UI
	S6I2+iyPatIuPtlA6XD1T3bcVeEP7BV3P667UPleGxaqk1M9HXAbti1hR2jDEhlKvhKHGh
	IMZ0jQ1GJbQb7399rZmvqvxFdX1t6R8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-oJ0t0moLNy-akXb_zE_z-Q-1; Wed, 05 Mar 2025 04:23:15 -0500
X-MC-Unique: oJ0t0moLNy-akXb_zE_z-Q-1
X-Mimecast-MFC-AGG-ID: oJ0t0moLNy-akXb_zE_z-Q_1741166595
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5e4987b2107so7183644a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 01:23:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741166595; x=1741771395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Fz/47DT/bcZQibct8BTl8FGEvkFXwI/p/JU2LZO+88=;
        b=H+RJAF6zm7bYOGVFMB/BkcZRfMnx+WobN2wjWnKM20+PkOjt7qvZ3Pd2Ta0na+frws
         gAHDzdAiJiduLCil8FCkMDfC3Oa62D/jPtD1/7NlTFWUrhFJ0BLqEQYEuoeAZpRKsEGn
         0kF21TO7vR7XGYNrzUKauAlUjIbEZ9tsgsird0TlgNuFzUp9Akvhw02CT+csZtyYTvRg
         DR3kwZ5/XVMEHtqccC9mlga7RMtKlkeoaGx3JUTS76xrnrVGI17pMZjwm4b5+s8rZrEa
         T52R+ecIUlicR/ILDPG+Ux0u90O8zzQl+ETyPW4t/0Lalps6UKI5Soh624Z47RFJBZk2
         Zj6A==
X-Forwarded-Encrypted: i=1; AJvYcCWSoOAsFtqVbqVa3a2ztFRh4Nn/eK44ljJDWLUfMkfpbRbK1mSwneQXfK/RET9Q9mpElgB5hcXA4UAomNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsajg1XU8sK1eGmzYeo+Cr/BGSzb9ldl8vdVjzlktT/LBstGP6
	CbmYEF1njrFte0afkxaLvsfVcfYNTr/Ux2kCoNAh6B2UbUOMR4oqru3q++hzx/lNr+hX+5cWht2
	mM8c/RVREWF0OAx1vYy9UM070TzSrYVJ3mGEm7G0cwPCVoE5A8PXgpNCHxbyWcQ==
X-Gm-Gg: ASbGnct3q1JPJ70QkoZx7x0DRKkKN1RmpM2X/AdeXngY6NTqEYlTOHN9h5pxbHkqq3R
	qM9XHn4r/NDS9PUFCtKrOtneLFfJ5RJeAtDS94LYUJHPc9Za46XD2461AQIX0hce7Pwm0czS2Xg
	OqSSHD87P2bqStaBx8cMVUwDA5kkT+sotdPr09p8stQTkasFxPIaiLPdr3AlMtpn4NatYMMY10A
	X1o0OLLL3COghiv0BDRy5fQ+/0aFhCXkEdk9ZXXyKQ5RUDbkhoV1687oUYQV3nf5uryFNL6Mana
	oxsPrR1oRM56fX9Rx6hEvEl4CInQrJcFqzR8hweTqkDhAHUktUEattL1iRIHlxLr
X-Received: by 2002:a05:6402:5214:b0:5dc:8ed9:6bc3 with SMTP id 4fb4d7f45d1cf-5e59f467cd0mr2334222a12.26.1741166594691;
        Wed, 05 Mar 2025 01:23:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrT/jfbwSVjoA3FYJOR2RrQw1bBL1x20n/7XdsK3C0UVX0BQZe2DpbudtEjt/UHC5wEkkQDw==
X-Received: by 2002:a05:6402:5214:b0:5dc:8ed9:6bc3 with SMTP id 4fb4d7f45d1cf-5e59f467cd0mr2334183a12.26.1741166593907;
        Wed, 05 Mar 2025 01:23:13 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b4aa46sm9297702a12.1.2025.03.05.01.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 01:23:13 -0800 (PST)
Date: Wed, 5 Mar 2025 10:23:08 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, 
	virtualization@lists.linux-foundation.org, linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>, 
	Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH net-next 1/3] vsock: add network namespace support
Message-ID: <CAGxU2F5C1kTN+z2XLwATvs9pGq0HAvXhKp6NUULos7O3uarjCA@mail.gmail.com>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <20200116172428.311437-2-sgarzare@redhat.com>
 <20250305022900-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305022900-mutt-send-email-mst@kernel.org>

On Wed, 5 Mar 2025 at 08:32, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jan 16, 2020 at 06:24:26PM +0100, Stefano Garzarella wrote:
> > This patch adds a check of the "net" assigned to a socket during
> > the vsock_find_bound_socket() and vsock_find_connected_socket()
> > to support network namespace, allowing to share the same address
> > (cid, port) across different network namespaces.
> >
> > This patch adds 'netns' module param to enable this new feature
> > (disabled by default), because it changes vsock's behavior with
> > network namespaces and could break existing applications.
> > G2H transports will use the default network namepsace (init_net).
> > H2G transports can use different network namespace for different
> > VMs.
>
>
> I'm not sure I understand the usecase. Can you explain a bit more,
> please?

It's been five years, but I'm trying!
We are tracking this RFE here [1].

I also add Jakub in the thread with who I discussed last year a possible 
restart of this effort, he could add more use cases.

The problem with vsock, host-side, currently is that if you launch a VM 
with a virtio-vsock device (using vhost) inside a container (e.g., 
Kata), so inside a network namespace, it is reachable from any other 
container, whereas they would like some isolation. Also the CID is 
shared among all, while they would like to reuse the same CID in 
different namespaces.

This has been partially solved with vhost-user-vsock, but it is 
inconvenient to use sometimes because of the hybrid-vsock problem 
(host-side vsock is remapped to AF_UNIX).

Something from the cover letter of the series [2]:

  As we partially discussed in the multi-transport proposal, it could
  be nice to support network namespace in vsock to reach the following
  goals:
  - isolate host applications from guest applications using the same ports
    with CID_ANY
  - assign the same CID of VMs running in different network namespaces
  - partition VMs between VMMs or at finer granularity

Thanks,
Stefano

[1] https://gitlab.com/vsock/vsock/-/issues/2
[2] https://lore.kernel.org/virtualization/20200116172428.311437-1-sgarzare@redhat.com/


