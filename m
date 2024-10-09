Return-Path: <linux-kernel+bounces-356505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB286996233
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A492F281DAE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EA218870E;
	Wed,  9 Oct 2024 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HSuu8o0f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250581537D7
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728461718; cv=none; b=Wc6JzF7v1Q++UqNxXu0TFw0uwOwcVwxt0TRxWY+22NXSCtxcFAdUrfpuQLfISIp/Jjvm2Q4zjKh+pOPVO5TFmRqIpCpffxFjHRK9Aq6gE0czWIDpHDiHkZTU6T3PDRpGzmbSGRg2T5PjLg1U3I1L9u5zbIriouPx6rxsLFqOU9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728461718; c=relaxed/simple;
	bh=4IZ9kpdlykp+ZcsHXczVOJRE1epELVCs54RvK50CheI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFjZx+PToxUYirQzOWQa09H7yLIbu3lCeehRei+kHA3BvbMUFI6LS1lLmhb2Xq2cGcsJca5pQaYDWndOwGQBK0AbPVLHiPNiFlojECyueAggZnQOG384RMDnjHlwk1nE+TUs1+RrdpDXo/Yq883RIHnUTwb2esubKmwAa3jwbD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HSuu8o0f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728461716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Avzij+L+4NBcCeyDm835566DodnsC8NlmStQMnsvhLg=;
	b=HSuu8o0fu/Io5fr3anU2Iia4JmUWGyWPZ5RY3rmtmda+zDTqcYsHbUXlgzh1diGgoyzqQP
	bbowu36UhE1JTjDI8pVHFw4CoXxToPb9dyC1XnHBZDEDUWVM5aH3xKERlVWe1LWOAyyo6y
	noVvehCO4BUkJN0X1hNpX2bDb/WpnGg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-EQqE1zPHOQOfO4Vyzigtnw-1; Wed, 09 Oct 2024 03:57:36 -0400
X-MC-Unique: EQqE1zPHOQOfO4Vyzigtnw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7acdd745756so1279349485a.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 00:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728460640; x=1729065440;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Avzij+L+4NBcCeyDm835566DodnsC8NlmStQMnsvhLg=;
        b=rNAQWIuX+rCWXEsquM+DXrgRwgyrwto3U458sPPgzo/P6kKxkFV8CF5cRBNFiq18jT
         zBIsWYzhgsQwA6HI4c5+qtq5btucwOT56QuuXFhj7Dkick0+Ej8uLr+4F7v7bk5qSXzt
         tRn+pjM+5yHLjqXXXrei2rRPIM/hz+YssOos68vrFIeG8M0QpmMtQPAd7IpPE0uqFBsg
         qKnnULD9Bs+t3dqBECkKV6U0tPOrzXfU+JuCQktUeRsvKu6nLoTMeCNXs4JdQiCqH6Hg
         Xj8SxXVhI1Jl1/LU44yGvB0Iu05C4aijcoF6/LTQAiHx0m5ufqApTpnWmdtP3gEhenzK
         F4Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUidCk7RiQY+JmdzCVHgBhj0M1GTFdjseKT2aWMMXs4HU+wu6JVK1onsjIH1My3B5zX3RgngVtwc3QZM8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNxnNTgx2uJRT0mRb99bUjn+Kq/vfPScDNIp/Kf1bWBPFWH0XY
	WZvjL0SfYDmLcJUmFyp3ePW+I7pGZcz2SmA+YctN/ZQVl0vAVf3a7+gj1qB/6yvz8VjFBZyMwEw
	MtjG6DXykS1H9h7xyWg8EuEracOcbwE71AqBKMqSydhdn/puzh3UWlvHKmElc/w==
X-Received: by 2002:a05:620a:4509:b0:7a9:c333:c559 with SMTP id af79cd13be357-7b0874a9a24mr209132785a.48.1728460640221;
        Wed, 09 Oct 2024 00:57:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESo0NmZIHT1z6RekNTQiUjGY/96nXVPyjFU/Gy078glQMkADkOM4numum8sa85/IUGjTMTBQ==
X-Received: by 2002:a05:620a:4509:b0:7a9:c333:c559 with SMTP id af79cd13be357-7b0874a9a24mr209130985a.48.1728460639838;
        Wed, 09 Oct 2024 00:57:19 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae75615aa2sm437290585a.14.2024.10.09.00.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 00:57:18 -0700 (PDT)
Date: Wed, 9 Oct 2024 09:57:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, mst@redhat.com, 
	michael.christie@oracle.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 1/7] vhost: Add a new modparam to allow userspace
 select vhost_task
Message-ID: <d4h4g7txswidmpau5i6evvnragzzgtbxgoelorcolowweb4qjo@ujevaic3uzrv>
References: <20241004015937.2286459-1-lulu@redhat.com>
 <20241004015937.2286459-2-lulu@redhat.com>
 <olbm26f3ifb6ypfmfl22xszbpevqsxc3ogfzosrb44ujtzt6pw@uh7irbqfy5jr>
 <CACGkMEt-8hdiAaAPjNAPNSNtBFHK+ogCndHFJMtYpjEzoTK6Qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEt-8hdiAaAPjNAPNSNtBFHK+ogCndHFJMtYpjEzoTK6Qg@mail.gmail.com>

On Wed, Oct 09, 2024 at 03:28:19PM GMT, Jason Wang wrote:
>On Mon, Oct 7, 2024 at 9:31 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Fri, Oct 04, 2024 at 09:58:15AM GMT, Cindy Lu wrote:
>> >The vhost is now using vhost_task and working as a child of the owner thread.
>> >While this makes sense from containerization POV, some old userspace is
>> >confused, as previously vhost not
>>
>> not what?
>>
>> > and so was allowed to steal cpu resources
>> >from outside the container. So we add the kthread API support back
>>
>> Sorry, but it's not clear the reason.
>>
>> I understand that we want to provide a way to bring back the previous
>> behavior when we had kthreads, but why do we want that?
>> Do you have examples where the new mechanism is causing problems?
>>
>
>The main difference is whose (kthreadd or the owner) attributes
>(namespace, affinities) would vhost thread inherit.
>
>The owner's attributes tend to be different from kthreadd, so
>management might be surprised for example, vhost might be created in
>different namespaces or having different scheduling affinities.

Okay, so this requires some API to allow the managment to understand how 
the device vhost will be created.

But why do we need to restore the old behavior with a kthread where the 
resource accounting is completely disconnected from userspace?
For the old managments that don't expect this?

BTW I would suggest adding all this information in this commit, in the 
parameter/IOCTL documentation, and in the cover letter because IMHO it 
is very important.

Thanks,
Stefano


