Return-Path: <linux-kernel+bounces-568262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D714A692E7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 335DA8A0D2B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C972C1DE3A9;
	Wed, 19 Mar 2025 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WY2FYx2T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD0635971
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742396416; cv=none; b=WeTJE2wz1HZCg3du5N8dNc0kjzYl9Lgcu+SgEU3UWMtSktOwJW/NUHxdPx86KbrBGiU9gPRQ8ae6uG6dE6WFtYw/K0G9Te6MWkloQjW+gQIXaRDmtWy2vWj8NSfsAll/ILhNH+0uIVmePPYOZggWwgfBWyP9jk5yyhswuTV148w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742396416; c=relaxed/simple;
	bh=PFBm2I4N5jYoUgCLRmxJIOtwy7bj+cX6hvDXoT5qs+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUmdco20LZpxwxtUlLBTGlzMvrMKoxwf2vw6bO5NJhHX5FD8mLJ1kjeOsmM+pNS8arCIirxqN2q3hseHe5Yl/uMWnZnahGaZl21sCOJGWmVFoEyt/WfJFF6LhFXfG87bEXQkTGvasbK4TX9WIZPCmqnFpNf91zl7sXSp/eQxgfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WY2FYx2T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742396413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Znos5WaUC4/XydmSkRRiQaq6by5qPuZbVqgImjMATjw=;
	b=WY2FYx2TqW91msJ2BnwTZP3OysLRB25FzaIzhfWRI6bDv7QwzQUj8aLCHQsf14rK+/mJeg
	hRgFLwjwWMrKsZoXAimtO61gd6aGy+uOEV7HQK8VfdFkzqLn1Oj6AJa38zE7vCx9WantMk
	KjSsG4T4S12G/R5D0E78l6GaLR5gA/E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584--8a0Egn3OHW4GsWWsOsSuA-1; Wed, 19 Mar 2025 11:00:11 -0400
X-MC-Unique: -8a0Egn3OHW4GsWWsOsSuA-1
X-Mimecast-MFC-AGG-ID: -8a0Egn3OHW4GsWWsOsSuA_1742396410
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43ced8c2eb7so34985185e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 08:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742396410; x=1743001210;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Znos5WaUC4/XydmSkRRiQaq6by5qPuZbVqgImjMATjw=;
        b=FzNzK0sT8s51sb1eBIsdqdrZQ7QFfQEMvK4eqiY60A4fho3fwn8EnwDZe9/au1PAKc
         MRAiMZeQrcVkvXqre4RkTeYZQxF/9VwaamGrjBX815m20T8AiSC+4AJWAX9TFejFqBTg
         TyqoPzUid3ECqUXzVEY58vFIpr2Sr7lfC8Qb9fTPYEfZXRbMXa8l2+BryJpXecLMz1xn
         pfeZgaba23WpkdCOb5b2f5cTW9n30USnSIm0yawwZ+O1X2ZyxEQW1IobW7LhxVFEAs7r
         ukz93XQMD8InJlOl/hGXSgrzxUJFeuMH2F5+QWfxMAs0Eq2LhGLY0rHZgKJ4BNLR+GNI
         fuHg==
X-Forwarded-Encrypted: i=1; AJvYcCWOfKOHcErrigMfmPNzhPG/AjTf169U37iqjQrOqOzr2b9bcND14nM9cHUk+fxMGblrZARtRjMKqvjZXXU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2jCl+wmAt/ARa+RxBaMp/un0t2gxszxh7F31XkQthbLAIymJn
	QYTZjhCEMIvUZqRhtYsAa9OAAPG/+4LX9JNr0Hv5HUHU+/SM5J5LOmWwCcaXZLjsUDnoF6gc4ES
	8p/BW/mm1f3bTaw6iQQmOfqBK5sKufqa+7tJxFVTT3lIFbsMlqgdAR/Vh2efT/Q==
X-Gm-Gg: ASbGnctrssRYG6M3HyhrGJ2T0IC1pYqwiVTV95HD7EJzfp08+5p5EmjD7racxI4UyFC
	mWINF/cwtifmnTFjnNjqkZu9Gspy8kDritHUF7V4YgZxdSpYer09sgG9Lm0dFrOljSxiozHQuXn
	rAVUmvKFlYU7efsl8ptG3map4mmXyva7pO67Oa/oLEk1qyT9lVdOVMH0hPhqyfGigUELQHWSrzZ
	K8P5QQiIHn5cl2bhZmu1KmuCNrsRN6uayS6zGAmnjutZpgsiCP/IDp6xA3lTCKHpK0J2/bYETa+
	39vwQrQBaQ==
X-Received: by 2002:a5d:47c9:0:b0:391:12a5:3c95 with SMTP id ffacd0b85a97d-399739d4817mr2819052f8f.22.1742396410323;
        Wed, 19 Mar 2025 08:00:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtQGh+I2vuGaNYtN5Wod5Mm6S3SyNqy9i9AO1JYL9vJ/bbEsx6r52lPyyaG5tlRjOWFPfqNQ==
X-Received: by 2002:a5d:47c9:0:b0:391:12a5:3c95 with SMTP id ffacd0b85a97d-399739d4817mr2819012f8f.22.1742396409808;
        Wed, 19 Mar 2025 08:00:09 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3978ef9a23bsm16981307f8f.15.2025.03.19.08.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 08:00:09 -0700 (PDT)
Date: Wed, 19 Mar 2025 11:00:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Cc: Amit Shah <amit@kernel.org>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, arnd@arndb.de,
	gregkh@linuxfoundation.org, brueckner@linux.ibm.com,
	schnelle@linux.ibm.com, pasic@linux.ibm.com
Subject: Re: [PATCH] virtio: console: Make resizing compliant with virtio spec
Message-ID: <20250319105852-mutt-send-email-mst@kernel.org>
References: <20250225092135.1200551-1-maxbr@linux.ibm.com>
 <f5ab160dadc2219b9576e50588dce88f22e9bcb1.camel@kernel.org>
 <649563cf1b8abd42401ed78d84bfd576d48bdbb8.camel@linux.ibm.com>
 <f27debf87882df65574f21cfced31fecf1dd1da3.camel@kernel.org>
 <dc3ff60fd16e5b5f94c12cf6a5a7893b94f705a8.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc3ff60fd16e5b5f94c12cf6a5a7893b94f705a8.camel@linux.ibm.com>

On Wed, Mar 19, 2025 at 02:00:44PM +0100, Maximilian Immanuel Brandtner wrote:
> On Tue, 2025-03-18 at 15:25 +0100, Amit Shah wrote:
> > On Tue, 2025-03-18 at 11:07 +0100, Maximilian Immanuel Brandtner
> > wrote:
> > > On Mon, 2025-03-03 at 12:54 +0100, Amit Shah wrote:
> > > > On Tue, 2025-02-25 at 10:21 +0100, Maximilian Immanuel Brandtner
> > > > wrote:
> > > > > According to the virtio spec[0] the virtio console resize
> > > > > struct
> > > > > defines
> > > > > cols before rows. In the kernel implementation it is the other
> > > > > way
> > > > > around
> > > > > resulting in the two properties being switched.
> > > > 
> > > > Not true, see below.
> > > > 
> > > > > While QEMU doesn't currently support resizing consoles, TinyEMU
> > > > 
> > > > QEMU does support console resizing - just that it uses the
> > > > classical
> > > > way of doing it: via the config space, and not via a control
> > > > message
> > > > (yet).
> > > > 
> > > > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/char/virtio_console.c#n1787
> > > > 
> > > > https://lists.nongnu.org/archive/html/qemu-devel/2010-05/msg00031.html
> > > > 
> > > > > diff --git a/drivers/char/virtio_console.c
> > > > > b/drivers/char/virtio_console.c
> > > > > index 24442485e73e..9668e89873cf 100644
> > > > > --- a/drivers/char/virtio_console.c
> > > > > +++ b/drivers/char/virtio_console.c
> > > > > @@ -1579,8 +1579,8 @@ static void handle_control_message(struct
> > > > > virtio_device *vdev,
> > > > >  		break;
> > > > >  	case VIRTIO_CONSOLE_RESIZE: {
> > > > >  		struct {
> > > > > -			__u16 rows;
> > > > >  			__u16 cols;
> > > > > +			__u16 rows;
> > > > >  		} size;
> > > > >  
> > > > >  		if (!is_console_port(port))
> > > > 
> > > > This VIRTIO_CONSOLE_RESIZE message is a control message, as
> > > > opposed
> > > > to
> > > > the config space row/col values that is documented in the spec.
> > > > 
> > > > Maybe more context will be helpful:
> > > > 
> > > > Initially, virtio_console was just a way to create one hvc
> > > > console
> > > > port
> > > > over the virtio transport.  The size of that console port could
> > > > be
> > > > changed by changing the size parameters in the virtio device's
> > > > configuration space.  Those are the values documented in the
> > > > spec. 
> > > > These are read via virtio_cread(), and do not have a struct
> > > > representation.
> > > > 
> > > > When the MULTIPORT feature was added to the virtio_console.c
> > > > driver,
> > > > more than one console port could be associated with the single
> > > > device.
> > > > Eg. we could have hvc0, hvc1, hvc2 all as part of the same
> > > > device. 
> > > > With this, the single config space value for row/col could not be
> > > > used
> > > > for the "extra" hvc1/hvc2 devices -- so a new
> > > > VIRTIO_CONSOLE_RESIZE
> > > > control message was added that conveys each console's dimensions.
> > > > 
> > > > Your patch is trying to change the control message, and not the
> > > > config
> > > > space.
> > > > 
> > > > Now - the lack of the 'struct size' definition for the control
> > > > message
> > > > in the spec is unfortunate, but that can be easily added -- and I
> > > > prefer we add it based on this Linux implementation (ie. first
> > > > rows,
> > > > then cols).
> > > 
> > > Under section 5.3.6.2 multiport device operation for
> > > VIRTIO_CONSOLE_RESIZE the spec says the following
> > > 
> > > ```
> > > Sent by the device to indicate a console size change. value is
> > > unused.
> > > The buffer is followed by the number of columns and rows:
> > > 
> > > struct virtio_console_resize { 
> > >         le16 cols; 
> > >         le16 rows; 
> > > };
> > > ```
> > 
> > Indeed.
> > 
> > 
> > > It would be extremely surprising to me if the section `multiport
> > > device
> > > operation` does not document resize for multiport control messages,
> > > but
> > > rather config messages, especially as VIRTIO_CONSOLE_RESIZE is
> > > documented as a virtio_console_control event.
> > 
> > You're right.
> > 
> > I was mistaken in my earlier reply - I had missed this
> > virtio_console_resize definition in the spec.  So indeed there's a
> > discrepancy in Linux kernel and the spec's ordering for the control
> > message.
> > 
> > OK, that needs fixing someplace.  Perhaps in the kernel (like your
> > orig. patch), but with an accurate commit message.
> 
> So should I send a patch v2 or should the spec be changed instead? Or
> would you like to first await the opinion of the spec maintainers?
> 
> The mail I initially sent to the virtio mailing list seems to have
> fallen on deaf ears. I now added Michael Tsirkin to this thread so that
> things might get going.


If we can fix the driver to fit the spec, that's best.
We generally try to avoid changing the spec just because
drivers are buggy.

> > 
> > Like I said, I don't think anyone is using this control message to
> > change console sizes.  I don't even think anyone's using multiple
> > console ports on the same device.
> > 
> > > In fact as far as I can tell this is the only part of the spec that
> > > documents resize. I would be legitimately interested in resizing
> > > without multiport and I would genuinely like to find out about how
> > > it
> > > could be used. In what section of the documentation could I find
> > > it?
> > 
> > See section 5.3.4 that describes `struct virtio_console_config` and
> > this note:
> > 
> > ```
> >     If the VIRTIO_CONSOLE_F_SIZE feature is negotiated, the driver
> > can
> > read the console dimensions from cols and rows. 
> > ```
> > 
> > 		Amit


