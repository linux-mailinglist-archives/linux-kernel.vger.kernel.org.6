Return-Path: <linux-kernel+bounces-557801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F18A5DDFD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9373B3453
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09412459C2;
	Wed, 12 Mar 2025 13:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sv/3pAYv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28E31A256B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741786099; cv=none; b=izhsI4xIeK4TdrJsqmdoI1kZpm/YIMK8N4Hwr1mFOibwZEynlKeeS2pidoa6Yv1AhtEbPOV2V4f1IWUevjvyZHVWDHl8SoGJPh4d5kpqYrtEsPPagc4nZ1T3wCzCCYBryVKMEcrDpG1BoExocLsYp/nAiSWJYx16wHI+XwSstlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741786099; c=relaxed/simple;
	bh=bppsgeCLPOVJeGMR97jVKd7rPBeAw9kXU5zpyCLPEJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJaFsVyWhwBzGtiySZtzOt9EUFJD2NgBVyqNlx6cneGk+F8ZzH47Wbako1NjY3yEnb7qW7ufvxTh0k7jnrZ1E989MRO33ajPJizsfZDpXleRLY5ev8CsM7Gk2+WnsBmE10O3jQt0QLWiI6mrEyyun2on7fEO+YLDAQwUmZPZgbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sv/3pAYv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741786095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cd4wn8Fv1QUp8UgtRjUbrAGy6ACAXSarUlDGzc+cAok=;
	b=Sv/3pAYvpBsFn/8q7A3AwpJzWoAL7ZWKhDdhph+JQWMntNHZbZWSLeboWS2rSByT4G7Bru
	CARtot8l0Jzrivn64QJcchrnwFEVSyjQHu1DPAqUciatwAIlElc+Dr3DJuIvDbyR3Bjra5
	C9MkD7kNjmed91M9frOLe51cvrXCJP4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-ZBVJ3feoMeeTih6F8YsiPA-1; Wed, 12 Mar 2025 09:28:14 -0400
X-MC-Unique: ZBVJ3feoMeeTih6F8YsiPA-1
X-Mimecast-MFC-AGG-ID: ZBVJ3feoMeeTih6F8YsiPA_1741786093
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43ce245c5acso34933605e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 06:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741786093; x=1742390893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cd4wn8Fv1QUp8UgtRjUbrAGy6ACAXSarUlDGzc+cAok=;
        b=CrH4vCbjYIMoW+BADGJBbe46RXyEd7PQ8OnBbzVQrOWDyPqzy9/26/c4YPzb4CBb9J
         s56c+yKLVRRBymxlw8IX8XYdHVhOU++Cbf1NWxnFXJ8z8lgkZ6gyHzQiro9hBZRP2xRV
         Rh60gFR4XYJDAcUy+Qk3t0DStFSDQe1AI8r1PbII+/FP1LKWBhQm265sMgFutqRBgxVZ
         HseS6ZVjIQmAiStyk2QVwrDZWsy41TZTjKMeI1Ce1HuMxeUm8mFs9JHDLlktPBhzmexE
         z9/iR2XYtTsoe1YStXOESQLQpe4n2xjtqVh61j6QJdwRGA5HRJLzW9Vc6XRLlWJprXDX
         6kkA==
X-Forwarded-Encrypted: i=1; AJvYcCXCkDlqeijphDOh3iaM4ppr8/CPNkY7m9z+5XSMxdITY3gew3ENBiXte3iBuNOlS1Ak//I5gMOs/la+Ckg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX+t89ZtlYymi98Y7cAL9aK1lv9gP/9o9pkrdU/nZM4TSS9Je/
	iAbNdSow8SidEwXGtA1szyhldi+HRsOQK0DtFkRJRruIS6OpbuwrDAmiaHZzACDbOCaGdjrPLah
	GULnoxxiyFBFHMZQpT1VPwHaB6xGKj3832dBleFCsxmsWo7T2uLJXgQksseyXNA==
X-Gm-Gg: ASbGnct7TQD54McWYU0IVfz4SP9B8Vu23UuR4gSW9NnC6CPWOyIfoWhVRHJGRl0qj49
	e2RtT8H+h7AzaZVFpMGpvEr0JiC+h3RF37w5chiTeu9Tcqjue7IsfyEgolrkx0TUFrQiHogvhBV
	2A2xd7PBmbBeU675y/l/cSAd22VxZCYF53VruEzl6VOmR1KZ29XDPWbT3/ox/h3GSd1U2FC8GQI
	OlnKKOWDzFb/PmduhdJljGz1Zbj6V9r4oWnlud61tZwmkUiHDM0DXrjb9zqYz7XmvEM/k2VK1uT
	CuV5PBiwHQ==
X-Received: by 2002:a05:600c:198b:b0:43c:f5fe:5c26 with SMTP id 5b1f17b1804b1-43cf5fe5e0emr116970135e9.4.1741786093071;
        Wed, 12 Mar 2025 06:28:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrFZYXg7iC/H/VXbl+Ds5zQUdtIQbQ9fB3jQl6MW8bK6C7iTZoHzvzY6YXwej9HbMobpTCbw==
X-Received: by 2002:a05:600c:198b:b0:43c:f5fe:5c26 with SMTP id 5b1f17b1804b1-43cf5fe5e0emr116969905e9.4.1741786092685;
        Wed, 12 Mar 2025 06:28:12 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a72eb5fsm22019125e9.8.2025.03.12.06.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 06:28:12 -0700 (PDT)
Date: Wed, 12 Mar 2025 14:28:10 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Harald Mommer <harald.mommer@opensynergy.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
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
Message-ID: <Z9GL6o01fuhTbHWO@fedora>
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <a366f529-c901-4cd1-a1a6-c3958562cace@wanadoo.fr>
 <0878aedf-35c2-4901-8662-2688574dd06f@opensynergy.com>
 <Z9FicA7bHAYZWJAb@fedora>
 <20250312-conscious-sloppy-pegasus-b5099d-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312-conscious-sloppy-pegasus-b5099d-mkl@pengutronix.de>

On Wed, Mar 12, 2025 at 11:41:26AM +0100, Marc Kleine-Budde wrote:
> On 12.03.2025 11:31:12, Matias Ezequiel Vara Larsen wrote:
> > On Thu, Feb 01, 2024 at 07:57:45PM +0100, Harald Mommer wrote:
> > > Hello,
> > > 
> > > I thought there would be some more comments coming and I could address
> > > everything in one chunk. Not the case, besides your comments silence.
> > > 
> > > On 08.01.24 20:34, Christophe JAILLET wrote:
> > > > 
> > > > Hi,
> > > > a few nits below, should there be a v6.
> > > > 
> > > 
> > > I'm sure there will be but not so soon. Probably after acceptance of the
> > > virtio CAN specification or after change requests to the specification are
> > > received and the driver has to be adapted to an updated draft.
> > > 
> > What is the status of this series?
> 
> There has been no movement from the Linux side. The patch series is
> quite extensive. To get this mainline, we need not only a proper Linux
> CAN driver, but also a proper VirtIO specification. 

Thanks for your answer. AFAIK the spec has been merged (see
https://github.com/oasis-tcs/virtio-spec/tree/virtio-1.4). 

> This whole project is too big for me to do it as a collaborative
> effort.
> 

What do you mean?

Thanks, 

Matias


