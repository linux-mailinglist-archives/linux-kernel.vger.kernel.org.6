Return-Path: <linux-kernel+bounces-365024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F44699DC52
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 04:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4157C1C20D1D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 02:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B891E1662EF;
	Tue, 15 Oct 2024 02:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLpuAbmT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A645C8F0
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 02:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728959792; cv=none; b=iJUoXv2ULdpJDsZekRPqiN04mzbDz1LYIxOlp0LeqZ9X3pfui1T6ql8TgW3XuY3NwzSDW08DcRkvkIXauqX5jMcXLN3vkvumi7w03AvM6TPoicfONR27sCSStEysBz5H7UGfDTrGpxszr5wukWoVphtgDA8jyuSRwJOm9xbUh/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728959792; c=relaxed/simple;
	bh=ZyfwRkmYYo9902jpV4Xf4OPH2JQu291dWhcwEhB7NEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q5b/ph4wRBBuGxqWgxC7va9tChQ2FV1/e9heJLM913sdYKheJBU4y5UwVXVIbLhkfTFsL96/ny54GSY000b5ytsfQTCwzIvhUsR06DQWEl0TjpLneHH93h1EkRNy6a5WZ3XDRbkLw9vNDt2bJk8f1UpRzbJoP/BHhnWq7wW1mh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RLpuAbmT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728959789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RepCkNLxrfOjiYjrBfat8VzhDr4hw0yzZI+H/gu/KcU=;
	b=RLpuAbmTsEAv7Mh9L32P/rFxh9s5MglD5LAtejbRlPzeoJHEf85ifJ/a/euWeFk5++wea5
	Aj54oPILuAMvGr4s9Lj4Qt2vlTvwVeuqT9Z43Tnglr1Q06qMEYG9TCL4uNKMZ8B7NOoLEw
	qO7QDW6J9kR8rCbO4lD+QM+zeLw8ZWs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-G2vjo-1nMbaXHevhPRA0Fw-1; Mon, 14 Oct 2024 22:36:28 -0400
X-MC-Unique: G2vjo-1nMbaXHevhPRA0Fw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a9a01cba9f7so127623666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 19:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728959787; x=1729564587;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RepCkNLxrfOjiYjrBfat8VzhDr4hw0yzZI+H/gu/KcU=;
        b=fESBDYNYx+mOxWW+ngOJFS6R22Ii8njHhBOMNSWGGFPT7r1Shy2ay9lnMh1ynOJJaj
         aSlqRPYJ0ClHIouG5TSWAVCzSChD35tUfMKV9rWrSxMWcYiLI/FQ/Vb5mIU8xi2elWip
         Evz4fQzdjFbgOP/uL7so7auaO93Lp1XXPh0GyhJlz2fccBN5/x7qMOby6TePGPzGs7Ff
         FPrtDZttTBz00JeGlyJd9Bq7l+mE2Ce/26WDVHHOPeqdf6PTJYgeqUrDhiUp3q8xXd3f
         pnGyTqJu7DoRElv/VcphpOqIsGGC0ugmfU3ILsjrO99eE+XecqFkVMWGLnHci0yOMOk5
         owUA==
X-Forwarded-Encrypted: i=1; AJvYcCVHd6TxcKRwFFm1ABeWDwKoxyKWlxdxttHd1dilmmsaLDSFZjvwvIzwcTCGswq0LUNRh32Odh28gaXit6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5BUSgEQOnDfTrl8cwWVD+rrriZdWrPmGHIHRWo4Gb+UL8zO8K
	ExWg0WHnBD469ldd6UpOqz6sQ5HJ96DaD/2LPt8WT3kGhMYeO9qfbmP+sQMP5/YLRTvCy2H6dFY
	FUOVdIBJd7x1KQq+UeTAlj5By7q1HnCmT8qJtcqsGDkKZq3Jvi94GHFW7Fhk+99aNIjCv/dl4eT
	6MniXas7dVtL7QFFJS9esD3C91l36i4jnDlbpy
X-Received: by 2002:a17:907:9452:b0:a99:379b:6b2c with SMTP id a640c23a62f3a-a99e3e3f8f9mr877404066b.42.1728959786824;
        Mon, 14 Oct 2024 19:36:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3XUGqLtf9WJVjnzTsPPwGijvC7KeImWI4dUv0/+mGZC7jS/6KZV4iT1QqrnGvBrVPKfLNnYQZSrHnSrEUZEA=
X-Received: by 2002:a17:907:9452:b0:a99:379b:6b2c with SMTP id
 a640c23a62f3a-a99e3e3f8f9mr877402866b.42.1728959786432; Mon, 14 Oct 2024
 19:36:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004015937.2286459-1-lulu@redhat.com> <20241004015937.2286459-8-lulu@redhat.com>
 <a6b0d25b-4b8c-4633-8900-978adf14795d@oracle.com>
In-Reply-To: <a6b0d25b-4b8c-4633-8900-978adf14795d@oracle.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 15 Oct 2024 10:35:49 +0800
Message-ID: <CACLfguXbMFZbGN+U1couZaJC7Sh3Qpg903W-DmFJjUtyECwT9Q@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] vhost: Add new UAPI to support change to task mode
To: Mike Christie <michael.christie@oracle.com>
Cc: jasowang@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Oct 2024 at 04:56, Mike Christie <michael.christie@oracle.com> wrote:
>
> On 10/3/24 8:58 PM, Cindy Lu wrote:
> > Add a new UAPI to support setting the vhost device to
> > use task mode. The user space application needs to use
> > VHOST_SET_INHERIT_FROM_OWNER to set the mode.
> > This setting must be set before VHOST_SET_OWNER is set.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/vhost.c      | 18 +++++++++++++++++-
> >  include/uapi/linux/vhost.h |  2 ++
> >  2 files changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 08c9e77916ca..0e5c81026acd 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -2341,8 +2341,24 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> >  {
> >       struct eventfd_ctx *ctx;
> >       u64 p;
> > -     long r;
> > +     long r = 0;
> >       int i, fd;
> > +     bool inherit_owner;
> > +
> > +     if (ioctl == VHOST_SET_INHERIT_FROM_OWNER) {
>
> Maybe instead of a modparam and this ioctl we just want a new ioctl:
>
> /*
>  * This will setup the owner based on the calling thread instead of
>  * using kthread.
>  */
> #define VHOST_INHERIT_OWNER _IO(VHOST_VIRTIO, 0x83)
>
> It would initially be used by vhost-scsi when worker_per_virtqueue=true
> since that is a new use case and there will be no regressions.
>
> For the other cases we default to VHOST_SET_OWNER. Other QEMU cases or
> tool XYZ can use the new ioctl when they are ready.
>
If I understand correctly, this means the default vhost function is
using kthread?
Thanks
Cindy


