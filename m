Return-Path: <linux-kernel+bounces-358273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5167F997C69
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 07:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C01371F244A9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 05:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B1419E99F;
	Thu, 10 Oct 2024 05:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z2HHIU/n"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB50154BF0
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 05:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728538230; cv=none; b=JRzTXx+46OK49goH9LzYjWB0o3i+IPj2wNO04m6xe3NT0pIsOPUDfboJGXelRBScbhi7ZF2TgtbZTTYH6pEj7Rsg5OHuHJZu4847z66Z0oHcLfk83om1S72jDhiD0zgk8V9C4+XD7xFFgVJ0dQ7wrpZ4//g68tNWLSqSPVNw9GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728538230; c=relaxed/simple;
	bh=8vrimWluOky7+aW1AAmoRPcEh4YVHM2VIY8aApW/HZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIEsE8WgLeMc/pHtxU3FEzbIcqP0W54iiRJxu1mg4xUMZ7nOFR3A9LA32KSXxIHqP3yQCdcuqqtoo2rybsRFTGX9N4gfXz4JeXo0CQvOvBLe/PfOxOUqtHAfAMUAiWIp4GUIDSXU2+iSgpXH32BPc6nFEcBSubWp0AZjQxfq+/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z2HHIU/n; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42f6995dab8so143695e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 22:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728538226; x=1729143026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Vsbn1te+zu6FOdxZ9pZKFB7CXsrSwAH4ylvWDXfwvY=;
        b=z2HHIU/n2aBAKKWCVeuWNYwBobqKgIz4HQ6ZiX8GDLe9iaTDCqU73JRYNkTrUv1WHs
         3EhoR2rK1nEh2q+H5ShTlt0QrW0MqNo/qShNozrDxrW9xM4Y2Pa8uFrIN0RxM1ow7szK
         WU3EwPR8BWLODS4qmptJE5pFSf5/hZEFtjkQqyamx7AuNcoh3X53IFeOuJGx7ArRROq0
         wHPQhAmGqlLOsTMtrMxo9gP+dZ+nlsxcNo1rNJTSXK6WVogW9GcpjwQ0GjXvsfPWvhWH
         m9QqFcefl3ZFRDircUHVkcUCvazxLoF1ubYHLhIJuSfg5yog2ke+tN6FjUl1aq9IrCb5
         jN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728538226; x=1729143026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Vsbn1te+zu6FOdxZ9pZKFB7CXsrSwAH4ylvWDXfwvY=;
        b=Rrv4Rm0oxTbfZi21TcrC+4yPO9+3s4r95OfLytoQNN/RyVLDjNavXcvSj8jPZtO7fl
         6XZT+Pxj997rinoWYSSDt0NWTksB1VhGGwdnZ49R5sxsjd9cqlzc6Uf80BuJQgh95AJp
         YIXNzZLFAdIvwIg4zOoluJTzDx5423nSgP+tZLyJS0q7UTr7VHP9y+hR5z/pU9NL2kfN
         nWk3+kNHpI/9/jyGA4WHvCxZ8S7zT03UOb8Mst1DZsIde2YdQ9riUyykL/lOo91Hnhoe
         5PxIKVT2x0Wzu4Mi+wIU45evgeGrslLJrxBxifWFZsDDRn+CqJkAsv6S0SezAShmeJW1
         548w==
X-Forwarded-Encrypted: i=1; AJvYcCUulJzsnc7OVxHAfOnvgHG2UyYZ2eofi+pml62a+a298JqROB6kUEKu+NB8a2CPYotqLbta6JsK3dV59lM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY1XGOcXCKf8WCqykw/oHMPnOX04nEPq/GrErryuaJhImUn3VF
	spR9tILSr9b8FH0MFUJaf8ar0Rb4Hk/pTEX/nKs2eqSt7sSJK32nwIKWL+BWgdjdFnxDJ6hZyU7
	jJYmRU+CWPFyuMCVRpJMbKAdMeQpDKDY6uKpx
X-Google-Smtp-Source: AGHT+IExR+gZgJ9+ZjEm/14g9BXJdiE3901d7DoQIau1dkDL3xiK2Bq9ZBBLMMTnoABIwrRyI5YGN5iG92XsC0UWHcA=
X-Received: by 2002:a05:600c:3d88:b0:42c:9e35:cde6 with SMTP id
 5b1f17b1804b1-431161221eemr2758015e9.2.1728538225796; Wed, 09 Oct 2024
 22:30:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009054429.3970438-1-guanyulin@google.com>
 <20241009054429.3970438-4-guanyulin@google.com> <2024100941-limping-dislodge-5c74@gregkh>
In-Reply-To: <2024100941-limping-dislodge-5c74@gregkh>
From: Guan-Yu Lin <guanyulin@google.com>
Date: Thu, 10 Oct 2024 13:30:00 +0800
Message-ID: <CAOuDEK0a43yLhCoA8iq=stj+QQAmKTCVWGKHvKM6-GPEaN9C3g@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] usb: add apis for sideband uasge tracking
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Thinh.Nguyen@synopsys.com, mathias.nyman@intel.com, 
	stern@rowland.harvard.edu, elder@kernel.org, oneukum@suse.com, 
	yajun.deng@linux.dev, dianders@chromium.org, kekrby@gmail.com, perex@perex.cz, 
	tiwai@suse.com, tj@kernel.org, stanley_chang@realtek.com, 
	andreyknvl@gmail.com, christophe.jaillet@wanadoo.fr, 
	quic_jjohnson@quicinc.com, ricardo@marliere.net, grundler@chromium.org, 
	niko.mauno@vaisala.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, badhri@google.com, 
	albertccwang@google.com, quic_wcheng@quicinc.com, pumahsu@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 8:44=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Wed, Oct 09, 2024 at 05:42:57AM +0000, Guan-Yu Lin wrote:
> > +void usb_sideband_get(struct usb_device *udev)
> > +{
> > +     struct usb_device *parent =3D udev;
> > +
> > +     do {
> > +             atomic_inc(&parent->sb_usage_count);
>
> As this is a reference count, use refcount_t please.

Acknowledged, will change it in the next patch. Thanks for the guidance.

>
> > +             parent =3D parent->parent;
> > +     } while (parent);
>
> Woah, walking up the device chain?  That should not be needed, or if so,
> then each device's "usage count" is pointless.
>

Say a hub X with usb devices A,B,C attached on it, where usb device A
is actively used by sideband now. We'd like to introduce a mechanism
so that hub X won't have to iterate through all its children to
determine sideband activities under this usb device tree. This problem
is similar to runtime suspending a device, where rpm uses
power.usage_count for tracking activity of the device itself and
power.child_count to check the children's activity. In our scenario,
we don't see the need to separate activities on the device itself or
on its children. So we combine two counters in rpm as sb_usage_count,
denoting the sideband activities under a specific usb device. We have
to keep a counter in each device so that we won't influence the usb
devices that aren't controlled by a sideband.
When sideband activity changes on a usb device, its usb device parents
should all get notified to maintain the correctness of sb_usage_count.
This notifying process creates the procedure to walk up the device
chain.

> > +bool usb_sideband_check(struct usb_device *udev)
> > +{
> > +     return !!atomic_read(&udev->sb_usage_count);
>
> And what happens if it changes right after you make this call?  This
> feels racy and broken.
>

Seems like we need a mechanism to block any new sideband access after
the usb device has been suspended. How about adding a lock during the
period when the usb device is suspended? Do you think this is the
correct direction to address the race condition?

> > @@ -731,6 +732,8 @@ struct usb_device {
> >
> >       u16 hub_delay;
> >       unsigned use_generic_driver:1;
> > +
> > +     atomic_t sb_usage_count;
>
> Why is this on the device and not the interface that is bound to the
> driver that is doing this work?
>
> thanks,
>
> greg k-h

If the count is bound on the usb interface, I'm afraid that the
sideband information couldn't be broadcasted across its usb device
parents. Do you have some insight on how we can achieve this?

Regards,
Guan-Yu

