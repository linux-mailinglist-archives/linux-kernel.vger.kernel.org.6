Return-Path: <linux-kernel+bounces-424674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B8B9DB7E6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AE7B163B6D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E6319E810;
	Thu, 28 Nov 2024 12:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqXaYon0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C05113D8B4
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732798141; cv=none; b=abQ/sGKOjHHnK3pXsYP4FZGHI5K5OYhGy3a1ou7VFDJ5qJtIke0BasVknUilcG3HEF5J2lc9i7RJHQ7yOvlqM40ZtzimWEjeS3c+ULAsMo7MmfMTeq6vwxuhSrt997t6VOz3e3nlexm5wPuckM8smWoy+IOC04KGx5P2wpRyd1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732798141; c=relaxed/simple;
	bh=pVn4CwQnElFAMNTHPQNx+FLhkcukHMnJjjj6xdSW2os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uYLQbMtJLOQXoMVkQFahNt81E0/jRdQ+bYkNEPwUaKLcGn265hmob+ARvEBewl8gg6hGwMBOddLA2nc3iWt8lhuFYgac/xrKADoBnQfJYCtmuTtccNvwtWJWD7V/6KhQqNbTX29/mrrMTTuysb6WOSVPek9NxfnUnS6MfEu4FHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dqXaYon0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732798138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rfAvR7YYk+y9zWk1qVDAVIqs1aRRRfyOj2S8utkBWMg=;
	b=dqXaYon0BF2rXfsIK7xnE6rJswXtYSviPJSuoDJwW31Y9t3NRxjwJnJNU8vbKiPOE2q8WY
	g4gE5X1ANGEFc8cfPv770TXG/WKm3wV8hkKQvIeHjuyPpgsax58kmFPHPQxBZX7G5HgSZS
	9U9F+WRdmv2sGehJ/49YFVqS2nbeEFA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-cD0cxTFiOp6x01uylFY_FQ-1; Thu, 28 Nov 2024 07:48:57 -0500
X-MC-Unique: cD0cxTFiOp6x01uylFY_FQ-1
X-Mimecast-MFC-AGG-ID: cD0cxTFiOp6x01uylFY_FQ
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5cfca4c0096so427784a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 04:48:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732798136; x=1733402936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfAvR7YYk+y9zWk1qVDAVIqs1aRRRfyOj2S8utkBWMg=;
        b=Uf/VaR8gjuFwMkxUn1hZY4nh7Zp2TuHnGCXoD4DGuMgu7lKAEp6ucHfGpmE8HaUFP1
         lReWlcrVG1x+PhdIHh9w9kRqstpsYbLnHAIG+A1lYy75Bp+cLaDli01nFllvx+v9fLSN
         TJ86Q4t5RoVmbxrY5IGlkFmooG2k4OBkQhEYVGBo6i+yWM43qGng+3qe4VdD/Jx3tOfT
         2hiAnXWYQOBeaHBl1ltaYtipOCbegZ92WsIbNr08PkKO6oujSkcTldCS9vwn8jr7DqrW
         9kwhaoZkiIMNC+mmb2SiLFGeapySuoky5UDBoddDm+xF+wb6ZBeuBHyfU9rFk1/CpUP0
         Xg2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMi4At5KRBIOpSAPRpJZ/Xh/cslXtEQeWQXOQOmtcq5QnqY9XzejQEIH2rkv+7TSpaCCx7vXRwobY+I/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YweSoS/RJM4ocv0gviRA8nSdttSU9ovAk2RuIqy5pthn/TNQ1pG
	Rz+7jr5voYwrK66hiprARlkxH8JsYbZTfV7AHZSFOjNrpeLkJL/vIzjHJyq+8bQ2xAEm9UZJ9jX
	6b6M5NUjSU1wiUk3cVuSgkCTZtSb7mOv0JKW5m/7BKM5JYBVCYIlBvabPWK70ZT47DfIpDJ4C5O
	RQf7IzdIs454S5+dpA1b7+gASlfvGy6VrVPT5M
X-Gm-Gg: ASbGncu5r21i+VO/L3gyoGSxuX1Aw6gw0VPiaXp93uqwerOuensWmVae0b1Vq4FP8Lb
	GIU8suTkB2I3hHRrdFwC/Vm0e5h30JwI=
X-Received: by 2002:a05:6402:2807:b0:5cf:dcd4:1277 with SMTP id 4fb4d7f45d1cf-5d080b7fb27mr7644585a12.7.1732798135983;
        Thu, 28 Nov 2024 04:48:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqespB5pnh6QZG6jUOEA2sxMetiq8Ns1u68KUXRR85sdhHWac+b1nfQFhGDLXamN5ZkQk50Wl3uPRkyzJg04Q=
X-Received: by 2002:a05:6402:2807:b0:5cf:dcd4:1277 with SMTP id
 4fb4d7f45d1cf-5d080b7fb27mr7644431a12.7.1732798134201; Thu, 28 Nov 2024
 04:48:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127212027.2704515-1-max.kellermann@ionos.com>
 <CAO8a2SiS16QFJ0mDtAW0ieuy9Nh6RjnP7-39q0oZKsVwNL=kRQ@mail.gmail.com>
 <CAKPOu+-Xa37qO1oQQtmLbZ34-KHckMmOumpf9n4ewnHr6YyZoQ@mail.gmail.com> <CAKPOu+9H+NGa44_p4DDw3H=kWfi-zANN_wb3OtsQScjDGmecyQ@mail.gmail.com>
In-Reply-To: <CAKPOu+9H+NGa44_p4DDw3H=kWfi-zANN_wb3OtsQScjDGmecyQ@mail.gmail.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 28 Nov 2024 14:48:43 +0200
Message-ID: <CAO8a2Sh6wJ++BQE_6WjK0H5ySNer8i2GqqW=BY3uAgK-6Wbj=g@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/file: fix memory leaks in __ceph_sync_read()
To: Max Kellermann <max.kellermann@ionos.com>
Cc: xiubli@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The ergonomics and error handling on this function seem awkward. I'll
take a closer look on how to arrange it better.

On Thu, Nov 28, 2024 at 2:31=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> On Thu, Nov 28, 2024 at 1:28=E2=80=AFPM Max Kellermann <max.kellermann@io=
nos.com> wrote:
> >
> > On Thu, Nov 28, 2024 at 1:18=E2=80=AFPM Alex Markuze <amarkuze@redhat.c=
om> wrote:
> > > Pages are freed in `ceph_osdc_put_request`, trying to release them
> > > this way will end badly.
> >
> > I don't get it. If this ends badly, why does the other
> > ceph_release_page_vector() call after ceph_osdc_put_request() in that
> > function not end badly?
>
> Look at this piece:
>
>         osd_req_op_extent_osd_data_pages(req, 0, pages, read_len,
>                          offset_in_page(read_off),
>                          false, false);
>
> The last parameter is "own_pages". Ownership of these pages is NOT
> transferred to the osdc request, therefore ceph_osdc_put_request()
> will NOT free them, and this is really a leak bug and my patch fixes
> it.
>
> I just saw this piece of code for the first time, I have no idea. What
> am I missing?
>


