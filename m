Return-Path: <linux-kernel+bounces-353734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6839931EF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB691C230E6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CE01DB345;
	Mon,  7 Oct 2024 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TEXUfQsu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806A21D9694
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316035; cv=none; b=efQl42JW4C7QQ8Pg3mYrtFLt0aypv1yFPRC+8/9xYZmwYVub3u7cBjb1zZ2ooPCjM1jyGsApo20Jsh+6NvAh4Wm+iUy6P6g71q+7x9EBcgEgROhHKPv9OBqOqwLrEZZ/RCVW7Frepuh38eRaIMOyqCke1nTh73nIvy6EA6zW+kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316035; c=relaxed/simple;
	bh=DQZCNIJ48pE5/m76HV8ZC97oJTUUoycjro9TNIIqwwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orVbLmbb430iGfLel1JU/Z0a1k6VUGUByzxv98UOuNVAV7YdSFy4DImY//QQMaAhvbrM1URlilR576hNi0sF8oetydp9WB8TCYNWy/4pfhSA2MwlOSr2K1fekSNmhbx/Qk/7Om0F5EYcDpxk0ytceHlC194SDtt7NwGZp+hotn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TEXUfQsu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728316032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j/qSM1gi+xzbWol0GgR9iU7ZEDf5izrAUc1BvVzk/UM=;
	b=TEXUfQsulv/lfruu1txg5pNw2sKEcntz3yYV/ckKYsxqqiEog27+YAZx4yXrxW3A981xBQ
	cN32LhsR8D8Utf9q+B6mxLKQId6AaTbP67gx2p5Od69cnY7YDIK1roGtrkQeIaZYaVAIs6
	Dkf+OybWAtBfzUj48VLeKJSsAvf7WGU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-Bd0lh8_QNMWQbeii3hMQ5Q-1; Mon, 07 Oct 2024 11:47:10 -0400
X-MC-Unique: Bd0lh8_QNMWQbeii3hMQ5Q-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-53991bb134bso3021705e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 08:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728316028; x=1728920828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/qSM1gi+xzbWol0GgR9iU7ZEDf5izrAUc1BvVzk/UM=;
        b=n2IHKWiNlim8DrdkwQf/qcZ1bMTFQ/Y9f/S9uwSQol9AfpQKuMbr+EbNdAtOEB5VED
         8CU2VSSaMK1cVEAAUnxY1lulDLvmFzEfs8xeFsN0NplQvXvthVPRbQ5+Ve5ekAW7XMdo
         2KI85scTCW1cJqyBS6TdCYEGl1Iv0UxG1h7H7sRkULanv68Sv64L8/DdB/JYid1eQAM3
         R90hlOcXInFQ2lirkGqTkrSvVQsur6shfmpGLkgclIEDP+wLA+V/2ASv6XF9B/Sz3H1L
         Uo0lxev6nApivamh/CxlozWh6W604mHrdCmNTvs+pAQFtKCgH7AL4IEhBlfcZvpRVB56
         U6+g==
X-Gm-Message-State: AOJu0Yz80qbgznHDwr0XDS1yq6dVH81e4hK5a4yABorpFTac6MplSrZ/
	UsPCeT5oak8RUchv7QKGWjrEDrhM95oqST72T2L/FOC13ydNbJFil1hFEmohiB+n6rVPatP1YGE
	zJWio4vs0/dJEn1FU1vw5HGXCKmr+HWvxYpj/7ZnsrXUuBeCloUC/V78htrvuxg==
X-Received: by 2002:a05:6512:3b20:b0:52c:dbe7:cfd5 with SMTP id 2adb3069b0e04-539ab88ad63mr5809834e87.32.1728316028354;
        Mon, 07 Oct 2024 08:47:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFI5CdxaS7NGjXGnhFpfvKBPg6dFQrE1IAMYDLqlZB8GcB73cj72b1bEGAmRYzgtVhZ1Lo4Kw==
X-Received: by 2002:a05:6512:3b20:b0:52c:dbe7:cfd5 with SMTP id 2adb3069b0e04-539ab88ad63mr5809803e87.32.1728316027827;
        Mon, 07 Oct 2024 08:47:07 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:8906:45ec:feb4:98e4:6184])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff1d13bsm890443e87.139.2024.10.07.08.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:47:07 -0700 (PDT)
Date: Mon, 7 Oct 2024 11:46:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Luigi Leonardi <luigi.leonardi@outlook.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Marco Pinna <marco.pinn95@gmail.com>,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] vsock/virtio: use GFP_ATOMIC under RCU read lock
Message-ID: <20241007114637-mutt-send-email-mst@kernel.org>
References: <3fbfb6e871f625f89eb578c7228e127437b1975a.1727876449.git.mst@redhat.com>
 <20241007083920.185578a7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007083920.185578a7@kernel.org>

On Mon, Oct 07, 2024 at 08:39:20AM -0700, Jakub Kicinski wrote:
> On Wed, 2 Oct 2024 09:41:42 -0400 Michael S. Tsirkin wrote:
> > virtio_transport_send_pkt in now called on transport fast path,
> > under RCU read lock. In that case, we have a bug: virtio_add_sgs
> > is called with GFP_KERNEL, and might sleep.
> > 
> > Pass the gfp flags as an argument, and use GFP_ATOMIC on
> > the fast path.
> 
> Hi Michael! The To: linux-kernel@vger.kernel.org doesn't give much info
> on who you expect to apply this ;) Please let us know if you plan to
> take it via your own tree, otherwise we'll ship it to Linus on Thu.

Hi!
It's in my tree, was in the process of sending a pull request actually.


