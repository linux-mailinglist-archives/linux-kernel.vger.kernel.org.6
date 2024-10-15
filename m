Return-Path: <linux-kernel+bounces-365228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D757199DF36
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837291F2459E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E6E18BBAB;
	Tue, 15 Oct 2024 07:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YyS4ujRP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAA49474
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728976842; cv=none; b=esprOv0UdiqYUPRDZiXoyynk/bKE/p51DWxbPs6s5vHWFi10VhIPJKOgEAO6zGqPS6Zfd0lXN4h8FbwiL2/CBrye5RaqrghKYGqJt/+q69IhyTag3DEkguyEyskn+jIqyBQZSmiFqtOhibaQSnr6rFSO7LVaxEqDoJXYAvsQdfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728976842; c=relaxed/simple;
	bh=aZ0nI4wEoXTnix+K7vnHNRRZ5u2CxP/xJ7+eeSluSRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IxHR11fjz8aVY5wnW9eO9/NYcAzxJ6JgnXnvlv6ey4212KZ1Qz1/o4NJLvCq02HWFfGTYB0jkS673W9N7z86GpLEZaQYM5UdImDr7UCAw1jeE9paJKParrRUjrUJJ+eBUojEmtWUkbUb7Y9RgpmDXoTMqMVo4jfA/rWZ6rHLKE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YyS4ujRP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728976839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dm4roKBoCmtc4l/ytASp7XB8VjJl6kkguFPg7ZNJ3FY=;
	b=YyS4ujRPMDVas9kPkT2bsaXXyBPUy1M+iXkYrMfiLSM17rOMpp3QnKJ5Je4yXE8yko0AXP
	T/eXohZ0wY8n05quiVF74VSxkL95gWeqBvkqYxpQeEbZHggklqiFDy4qp3Mope34D1w9zE
	fQUQ9JYwPSaqVKpK4iAfAaAnoVlQjoQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-o18TCe_PPUGclLLOLJJAbA-1; Tue, 15 Oct 2024 03:20:37 -0400
X-MC-Unique: o18TCe_PPUGclLLOLJJAbA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a93d0b27d37so432002966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 00:20:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728976837; x=1729581637;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dm4roKBoCmtc4l/ytASp7XB8VjJl6kkguFPg7ZNJ3FY=;
        b=RNxJk7Z5QLTHvpSPPw+DIDDBDHTg8k9W5+S/p9pnuRrGklDjIkXW/MYC90G7vM6g/P
         6LErRAapG4T6nGHCwii/SxTrQ0p82K77xL2Eab0+A2RKOK8+uAmFw5Yd7GS1z5s6jSo6
         4v84ahmNtNzS/XtXzUCzdm0CtIXgCGj4Z3gBC7ZNiI/OKVeeVSgyknK1NWJPjnSjJXE3
         sl5IBK9z4x7vHcak/DVHP9JyVanaT8RP5u4mYOS7IiuhnV3ohzhY9RogQs6RyaNhDcE9
         LYq5BxzmXb8/d2DKiN5cM4fkWaOyLBRSCt/nXhbw+I1VeeUd7jcT6TUSp8qF3ohvRks+
         VexQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDrI5LtGpl67Ta62yacw2EqbnVBNzj2wu9lQeASpoWaG4kszLw2yc1UevS6rvL5UvjT+dKSBmvE35GApM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4eXXNorqELI5ItB5iYVc21o7mT3nWys+VZsBX8Vogvl65eu+d
	GOrIWwKu8aT9q44bnQp1CTuqpIxfkit1QOgLiYlxdE5MsdgPRmUYF/pJkl3zdZZK29HqRN0e9Vr
	eDBjHe9xluTP5Xgo1zwwZm/NquBYKrA6GhVuMUOQIuezCOffsRSa8wn99ZOCmK5BYoMCLy6HFHP
	qRDLA2JSBCYPHhF8SiQCrTCzEMFAPaSQQnwiiO
X-Received: by 2002:a17:907:9693:b0:a9a:1cbd:257e with SMTP id a640c23a62f3a-a9a1cbd2a10mr370384166b.29.1728976836672;
        Tue, 15 Oct 2024 00:20:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/SQ7uHHwUBTGa0Un4BlqLc26yoGrlspeQeIyQ7UgPrdorFar9eEEL6Uh2CsWThHDqSlkBzEqBAUNaiivaeT8=
X-Received: by 2002:a17:907:9693:b0:a9a:1cbd:257e with SMTP id
 a640c23a62f3a-a9a1cbd2a10mr370382166b.29.1728976836340; Tue, 15 Oct 2024
 00:20:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004015937.2286459-1-lulu@redhat.com> <20241004015937.2286459-4-lulu@redhat.com>
 <acb5ea13-9695-4158-9152-aff761401be3@oracle.com> <CACLfguVB0Xn2vsj6kJB9ONv1AhpcUteH9PEqDaPX-7JkxxqvKQ@mail.gmail.com>
 <lpwqg4j2nnh3xgg64vrlk635vcmu2bxrq37sapwp3yl2pdp5rz@lg3wgfop6rkx>
In-Reply-To: <lpwqg4j2nnh3xgg64vrlk635vcmu2bxrq37sapwp3yl2pdp5rz@lg3wgfop6rkx>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 15 Oct 2024 15:19:58 +0800
Message-ID: <CACLfguV1vzs84mKQCQZzT+x5rNo9u+pFwk7i54ng4=OSQdixBA@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] vhost: Add kthread support in function vhost_workers_free()
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Mike Christie <michael.christie@oracle.com>, jasowang@redhat.com, mst@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Oct 2024 at 14:52, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Tue, Oct 15, 2024 at 02:05:47PM +0800, Cindy Lu wrote:
> >On Tue, 15 Oct 2024 at 05:06, Mike Christie <michael.christie@oracle.com> wrote:
> >>
> >> On 10/3/24 8:58 PM, Cindy Lu wrote:
> >> > +static void vhost_workers_free(struct vhost_dev *dev)
> >> > +{
> >> > +     if (enforce_inherit_owner)
> >> > +             vhost_workers_free_task(dev);
> >> > +     else
> >> > +             vhost_workers_free_kthread(dev);
> >> > +}
> >>
> >> With patch 7, userspace could change enforce_inherit_owner after
> >> we created thread and we would call the wrong function above.
> >>
> >enforce_inherit_owner will only change before the owner was set.
>
> As I pointed out in patch 7, enforce_inherit_owner seems to be shared
> among all vhost devices, so what happens if for example a user sets it
> to /dev/vhost-net, while /dev/vhost-vsock is already initialized and
> therefore already has an owner?
>
> Thanks,
> Stefano
>
You are correct, I will think about this and provide a new version
Thanks
cindy

> >the process is like set enforce_inherit_owner---->set owner->
> >thread/task creating
> >in in patch 7's code I have add the check for vhost's owner, if the
> >owner was set, the ioctl
> >to set enforce_inherit_owner will fail
> >Thanks
> >Cindy
> >
> >
>


