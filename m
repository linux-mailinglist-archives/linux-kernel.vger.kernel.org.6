Return-Path: <linux-kernel+bounces-256704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A418935236
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 21:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1EC61F2114C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 19:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42EB1459F6;
	Thu, 18 Jul 2024 19:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fTZ1n62Y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55E413AA26
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 19:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721331553; cv=none; b=hlMp5+dyr8LL5GhZcJg2afHkCg1I31/YUFjCqoYB53H9CEFjNLkcBBBaIEdD5u8Xlq1BCliCozwuDZ+VDRsIJUEaFrjvNPdUK6488a37ad1TqGO9vu8kZEJRK+Jg5W8mzv0IMlQHBoC7x+NochUP8cKy2qiNOhpQyzb39Z0+Vjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721331553; c=relaxed/simple;
	bh=YNdqwy7kCRnthAWGt25BAuPpmrM1cC32dACjVkXCQHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoiT1Sdhr/U9K9Mu8gP9/bT61Lw6GoMuF7CA6oS0aj0lNW83wOe6QkKwBXqm7MTagc8w1+xEOaTH9d06XRLLhcssb5qZ04h2dX25IQKc0i3Jkc8D6NKA1KfvnStdaYfLvsUhw+37wvMIlIscLKQHnc+mrIhJl6FlYoxKeNsR9aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fTZ1n62Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721331550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M+Nl6R9d4RbpOHYlmLt5JwqOfz9o9yrilMSlqF926WM=;
	b=fTZ1n62YoihrJZRGWj/7x+SxY35UhrreQ+HMvIA0yKOB54rh7zQ2Sx+wMs1S1q1sBRgCoI
	8HqrTYyy30LgAOO4iO9i3bx+epmo6BCRJBInXKLdimclnroqe0kLtyPk1J+63aYCkPpOux
	daIHdVQpQ/OMGlYff36nO64VjIY2R0A=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-TA3GLrkoMAuZK3dNZZYE1g-1; Thu, 18 Jul 2024 15:39:09 -0400
X-MC-Unique: TA3GLrkoMAuZK3dNZZYE1g-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-57d3eca4c01so96010a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 12:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721331548; x=1721936348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+Nl6R9d4RbpOHYlmLt5JwqOfz9o9yrilMSlqF926WM=;
        b=uqVdMcw4JeOCFfmCVmBIVmfSqLaHH91k8m9fuK+fSYA1YVuk3TK2CHEsgPFSqzaEe4
         uPLTnynbmtpBLNcLoy3L1QmkuQ3s+qZ08eAqzTcy6pQkdA6cB4oWsu6BvQhYtYzCxnVC
         /DbWMDdEiZ8h46jej9eEZ3xWdtScB81GFafxjSqxPBGw/8EjDl5lTmJ93eyzuEQYDPFD
         NOpSXNMWZLZr7jK+h2gRWpDbWz+pMoQ4TG2RZs+c0C1V6d7ctRDCixAL9DaX+uoGVtJ+
         c7fmj98yztJOfogH7FjmJfBg78nXxmiV8uIhUd+q+mBlI61KFudDObk+ZqYRU90xxd+V
         OPjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0B+f+pibCr0CHj8PT//veQRgFkOuAj5xk7WLbZkdxw711mih1rc2sIY6XhqXMLVYDftrIlHzh98aV2c8NbPBdrczd2ws32abau45I
X-Gm-Message-State: AOJu0YzDBCNNG5ZPpxFKzLVPDWsCIYcwNyG5RfOao+rzBr6grUm/I1ai
	VgIwFGk2BOjETgenpRTrb8j5fafHQoAbaGbpbd2uYmgn5Q5q4P8ZVDUJVxWWN0bYx2h97ZCYkCE
	I2oJQzr7z8qMP7FT3+1O5r4NQvRBpgUVmnCJaGTt4UqLg4zCbhgtIx8G37+s1IGFq/aDKDQ==
X-Received: by 2002:a50:9e85:0:b0:5a1:6c50:a3d with SMTP id 4fb4d7f45d1cf-5a16c500aa5mr2188081a12.20.1721331548111;
        Thu, 18 Jul 2024 12:39:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaoGS44bEP46gwargFeZVeVI2AZznegXlDO8vExCziupfmD6LupuDU+NRqxyVgGi7d2vM86g==
X-Received: by 2002:a50:9e85:0:b0:5a1:6c50:a3d with SMTP id 4fb4d7f45d1cf-5a16c500aa5mr2188072a12.20.1721331547261;
        Thu, 18 Jul 2024 12:39:07 -0700 (PDT)
Received: from redhat.com (mob-5-90-112-15.net.vodafone.it. [5.90.112.15])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a2b8665941sm228569a12.86.2024.07.18.12.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 12:39:06 -0700 (PDT)
Date: Thu, 18 Jul 2024 15:39:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, Si-Wei Liu <si-wei.liu@oracle.com>,
	Eugenio Perez Martin <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH V2 5/7] vhost-vdpa: VHOST_IOTLB_REMAP
Message-ID: <20240718153724-mutt-send-email-mst@kernel.org>
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
 <1720790333-456232-6-git-send-email-steven.sistare@oracle.com>
 <CACGkMEurG88fXiThyainxbuzpgBUzzGkmvyQB5vuXsU7_6XBBw@mail.gmail.com>
 <d738a0e2-5a17-4323-9c86-b5a806066292@oracle.com>
 <CACGkMEuj-6EcEPo9xKkmuPSaQPQnH6zG+j2cqLRiScWUB4oqXw@mail.gmail.com>
 <5a1cfaaf-64aa-426a-b1b4-da84a66b362a@oracle.com>
 <CACGkMEtuErg+nd96k6FkL9dfSxOv2o38L1HSsK9jU-xmmkv8oQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEtuErg+nd96k6FkL9dfSxOv2o38L1HSsK9jU-xmmkv8oQ@mail.gmail.com>

On Thu, Jul 18, 2024 at 08:45:31AM +0800, Jason Wang wrote:
> > > For example:
> > >
> > > 1) old owner pass fd to new owner which is another process
> > > 2) the new owner do VHOST_NEW_OWNER
> > > 3) new owner doesn't do remap correctly
> > >
> > > There's no way for the old owner to remove/unpin the mappings as we
> > > have the owner check in IOTLB_UPDATE. Looks like a potential way for
> > > DOS.
> >
> > This is a bug in the second cooperating process, not a DOS.  The application
> > must fix it.  Sometimes you cannot recover from an application bug at run time.
> >
> > BTW, at one time vfio enforced the concept of an owner, but Alex deleted it.
> > It adds no value, because possession of the fd is the key.
> >    ffed0518d871 ("vfio: remove useless judgement")
> 
> This seems to be a great relaxation of the ownership check. I would
> like to hear from Michael first.
> 
> Thanks

It could be that the ownership model is too restrictive.
But again, this is changing a security assumption.
Looks like yes another reason to tie this to the switch to iommufd.

-- 
MST


