Return-Path: <linux-kernel+bounces-557959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B98A5DFDD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62421165163
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5A62512E7;
	Wed, 12 Mar 2025 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHRcZPLN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4162505C6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792288; cv=none; b=cAaJQ3bveQ9NPHBownF43P8wHwu27/zB5A1po+nlPsN+5d/SftxLBgcwmJghWBkwyHq2qtbfk7HK9rFFbd9m7kdvqEoYbEWDBPdrqTQDUh7om83L3JjlgzsMl8sshwtLHjvCc0OHLCOT6vSR3gAuK1GY2c0s3nwxQNaQvRiiNws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792288; c=relaxed/simple;
	bh=ztlmegBzBKs8vJ1Sj3J75o5jqxXX3n3n98UKsP0n/bU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDP4qGGjXWCc5JDo3hrfYaic/3MH7B9J3FlhQ6WPhwMceqo07VsV1Nqn7wJgmvYC3ygMW1KSDriTA1d+e/ZANSFKrYU0aqVXRxycA2/MWTe6UeB1pcJh7eS+IHyJduQ5q4nyMnJtsxRfnyVy/ABaDVGS4tAFMuPeRBNtBo/p2Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cHRcZPLN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741792284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s3wvkUF9pbg03+vUjzzWddDimlNCCehc9tv57CFp/bk=;
	b=cHRcZPLNtv9E3ou3E/M/UVZ5jfawT54zag5dQZ3d1flStogsf3w4BbhuTJQSsMmEegVPF5
	0IJ00g4MhsWrtnTqK7uVy57UWBXOxU8qbzJ6CaGojOTzbmd46qSdqg4Eabk58o/OOR9Idq
	ACv/CLV/uzo2f0bQpO2kh+4Gm38hqNI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-k-CYNeqBNUyczRWyU9Dmuw-1; Wed, 12 Mar 2025 11:11:23 -0400
X-MC-Unique: k-CYNeqBNUyczRWyU9Dmuw-1
X-Mimecast-MFC-AGG-ID: k-CYNeqBNUyczRWyU9Dmuw_1741792282
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43bd0586b86so48232465e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 08:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741792282; x=1742397082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3wvkUF9pbg03+vUjzzWddDimlNCCehc9tv57CFp/bk=;
        b=kSEJ3JSzEpJVfSmXVjRHmKyFyvaYFvKbRdSOoKJ3C2pJll3aizgwwpkDXVjfSHHzPC
         b2u/SWG4U9GLVhhj9u+O2kZohwZx1peL2iwj+lUzhsWQJ0noTt9tZYzcr4LIE/yP2Vnp
         Kr4Y+bsdz4rncRQgW5lHxFfM9zCDlfMI9qOUKgUSq0fKhWsdVa/vQJyNUBHKC93jpAW7
         dJvlvu7LtsiNzVpJTGzY/vAQ8qbwifZEg+W6xgBTJffdSkIRcz0HrFsAVD/hi36RZWQu
         SsCJsco32cuufDgzsAJ1mmyAbVeMpteD+aSJfRNYwthDjECA6BpYyz8rpQZ7f2g3ClQM
         uu8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWcTmEehGb9C2D6kvatd3TBLt/j2Vo7cARAurU9+Xv6CmLPnfoTsqTm/IKRATnbdDfCVFOe29UGUYV5pao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKmSk829YOVwiwEJEhg+eMX3Zd2Rt6jejyJoOfb1hNHboHYwEq
	hDM5EQvI/2uvHX9Lbs1zH2oczD3wqXBNSqsylWR0Resn+VOfqcr218vohYc40rR64sV9ccwUPTQ
	QVK/LE99PpeumRXJTjI6uySG3HrYoQx121AfH/PkpQDfWHmWrT3K0HtViNKDpnQ==
X-Gm-Gg: ASbGncvPcS0WH88nHp/eIvghxzPoSG2UwDzCifsL8G+J+k08lxH3hChEBzDS8Q1dU5W
	JHMDsaNHEPAfvBeBldTOwOLadSuKa/O7IjS99XpTyXF1HY6WFOUnwp2o4YDQbxHyXVz/IP83fwn
	GlIWoq5WqF0ijnG8HtGUhbzK1nPS0Nvqrw1Xw6ZAs03w16PW6NbuU7clCUBfV//RP9SPX3a5r5v
	xrZZ9i+Se/ACBPnUfbQwhgcSu0Y65ZC6jOjQAliy/fqXjoU5GRXNsjCguvDGa1ejdPihF/M6Bwy
	k8IwW+BuGQ==
X-Received: by 2002:a05:600c:1c0f:b0:43d:ac5:11e8 with SMTP id 5b1f17b1804b1-43d0ac51609mr16259745e9.21.1741792282003;
        Wed, 12 Mar 2025 08:11:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5W/D3ES/M6kJRPjyEgSuPr9XA1jcGO11zxvnqEpd0Ho/mZnkNgRao4/TRivG1z/At8axlrA==
X-Received: by 2002:a05:600c:1c0f:b0:43d:ac5:11e8 with SMTP id 5b1f17b1804b1-43d0ac51609mr16259465e9.21.1741792281627;
        Wed, 12 Mar 2025 08:11:21 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba686sm21749973f8f.19.2025.03.12.08.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 08:11:21 -0700 (PDT)
Date: Wed, 12 Mar 2025 16:11:19 +0100
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
Message-ID: <Z9GkFxPQ54Jzn45f@fedora>
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <a366f529-c901-4cd1-a1a6-c3958562cace@wanadoo.fr>
 <0878aedf-35c2-4901-8662-2688574dd06f@opensynergy.com>
 <Z9FicA7bHAYZWJAb@fedora>
 <20250312-conscious-sloppy-pegasus-b5099d-mkl@pengutronix.de>
 <Z9GL6o01fuhTbHWO@fedora>
 <20250312-able-refreshing-hog-ed14e7-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312-able-refreshing-hog-ed14e7-mkl@pengutronix.de>

On Wed, Mar 12, 2025 at 02:36:05PM +0100, Marc Kleine-Budde wrote:
> On 12.03.2025 14:28:10, Matias Ezequiel Vara Larsen wrote:
> > On Wed, Mar 12, 2025 at 11:41:26AM +0100, Marc Kleine-Budde wrote:
> > > On 12.03.2025 11:31:12, Matias Ezequiel Vara Larsen wrote:
> > > > On Thu, Feb 01, 2024 at 07:57:45PM +0100, Harald Mommer wrote:
> > > > > Hello,
> > > > > 
> > > > > I thought there would be some more comments coming and I could address
> > > > > everything in one chunk. Not the case, besides your comments silence.
> > > > > 
> > > > > On 08.01.24 20:34, Christophe JAILLET wrote:
> > > > > > 
> > > > > > Hi,
> > > > > > a few nits below, should there be a v6.
> > > > > > 
> > > > > 
> > > > > I'm sure there will be but not so soon. Probably after acceptance of the
> > > > > virtio CAN specification or after change requests to the specification are
> > > > > received and the driver has to be adapted to an updated draft.
> > > > > 
> > > > What is the status of this series?
> > > 
> > > There has been no movement from the Linux side. The patch series is
> > > quite extensive. To get this mainline, we need not only a proper Linux
> > > CAN driver, but also a proper VirtIO specification. 
> > 
> > Thanks for your answer. AFAIK the spec has been merged (see
> > https://github.com/oasis-tcs/virtio-spec/tree/virtio-1.4). 
> 
> Yes, the spec was merged. I think it was written with a specific
> use-case (IIRC: automotive, Linux on-top of a specific hypervisor) in
> mind, in Linux we have other use cases that might not be covered.

What use-case you have in Linux?

> 
> > > This whole project is too big for me to do it as a collaborative
> > > effort.
> > 
> > What do you mean?
> 
> I mean the driver is too big to review on a non-paid community based
> effort.
> 
I think I can help reviewing it. I will try to spend some time in the next
weeks.

Matias


