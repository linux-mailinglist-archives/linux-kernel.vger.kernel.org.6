Return-Path: <linux-kernel+bounces-399623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 161B09C01D5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 323961C213C7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7408C1E907E;
	Thu,  7 Nov 2024 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GaPNvfr6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB7119B5B1
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 10:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730973822; cv=none; b=bDxF2Q8245WtdKqwzl9PLB1YOIpqk18nB3GhxAVMn/JvX6GK4Bd8NuHEX6Dn0YBO026DP+lPeqNFRKa3TZ8j1DwZs8vbs6W1ANIBppQwS/eVeaj9sy6wtedN7xh05d2hlSZ4hg+rKRtxPjzGfaSbZsGyMzg5nmtshpXHt5UjumA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730973822; c=relaxed/simple;
	bh=2+Yutr5Xglcz8V8+xc221L3KYuAq5uCZTnAUQj8Hv0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vw7iIoOdusxhus2WKOj9uHr9YZglAemzpbvYbVhMrlSGXN2ucelQMIVaLBUCGq88GeRadnJwAYgYxw8IOxyuFBjVuiU4LRHVOY7jkpp7tseISCGgsLlmPEN+cegvp3oQkqIFP/SBasQzG5SKfIzpSypNJmxgEmjIa6BuwNyYRXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GaPNvfr6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730973819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=An3BH6XKuTAnMBgKcn0eA2Zh2Rap4I/isdV3TdHYfCA=;
	b=GaPNvfr6bCOO6tgu0QmO2gcaKXTssX0jdrDW8eEAsorXTybrXxSPE+xtmQNWhnpTlKdNQh
	wmRs0oy8Rn5yKEiNzhEJgJPd4s+zTe+uC+IeR1YmZx5Hoh84FK1lTjcJ8zaEuOnvznrzby
	0pbMyy/ZFA7oqBw3cS/KSZkHPVnx5Jc=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-0iZgY5_4NmWTY1vmJoRu3g-1; Thu, 07 Nov 2024 05:03:37 -0500
X-MC-Unique: 0iZgY5_4NmWTY1vmJoRu3g-1
X-Mimecast-MFC-AGG-ID: 0iZgY5_4NmWTY1vmJoRu3g
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3e5f78786cbso912107b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 02:03:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730973817; x=1731578617;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=An3BH6XKuTAnMBgKcn0eA2Zh2Rap4I/isdV3TdHYfCA=;
        b=SEs4h5OpcAriyMduKox/0PaswRLn+Kd/gFS5jKuqSk9akX2lTH675YHAtzEL/sYV9e
         0GT98yqn5kNV1wiUU09gG1qr2ZBHzqjV7mJV9IKAc5R5+KCwANCsB8Sg0HA+XTDaNZwO
         Myg5zmUMWwk+RvVntlSkbj/w4yRYQZBQP89mcz/F8Y1blvhm4OB0UQEY6SVKalpKzzRI
         11p/qCsD56rOP05aQ2jbHAfhzsIKYftAoTnXYQVtWeawz2dI0nCxD/UFFOSh69yTMHju
         1XLl6hV8a+8LJk7Ckm9vl0wuKOyR3lTs6tpkvQIC5wDxVY+0xOxrVruWpV5DcWMlJYvh
         +UZA==
X-Forwarded-Encrypted: i=1; AJvYcCXVx5BGBv4E5dJgQdMGN/HRlOkwxHHaEkNVw+OGiTsRJvCrzr8IGXhsNvxjmfpMjCpH+POfzADuKW5X4e0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu1UFFouN1O5POPTD3Enwjv8mM0MJjWSHcXPwrgogbZYxo0kiH
	Fj5u6vzgpENUZolhLfCMFLO8pf+smCJDgjgDieUqQE7Avs1xPq3N4aLShv3C3NpxsveLHEdkn0h
	Iy74T6zJDA/38i2g6clMtv6bUlKfJ5mkQGEZA5p0VEZTGQtWqWBSL1otq5SkGaQ==
X-Received: by 2002:a05:6808:1587:b0:3e6:61ed:d62 with SMTP id 5614622812f47-3e78fc71ebfmr482176b6e.6.1730973816634;
        Thu, 07 Nov 2024 02:03:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGh9cwaUN0Ba6FgiawQwL1+eLsqHmCIJp1Eq590jb/9RX+uJ0m1Iu3AL2UUAklxiLKOlF6EEw==
X-Received: by 2002:a05:6808:1587:b0:3e6:61ed:d62 with SMTP id 5614622812f47-3e78fc71ebfmr482139b6e.6.1730973816142;
        Thu, 07 Nov 2024 02:03:36 -0800 (PST)
Received: from sgarzare-redhat ([5.77.70.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d396637613sm5750286d6.116.2024.11.07.02.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 02:03:35 -0800 (PST)
Date: Thu, 7 Nov 2024 11:03:28 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 7/9] vhost: Add new UAPI to support change to task mode
Message-ID: <zkamzruq5e3diahm7vyjansnaowkw42toh5evwgq6vqal7h4pk@3w4e47ggogyr>
References: <20241105072642.898710-1-lulu@redhat.com>
 <20241105072642.898710-8-lulu@redhat.com>
 <6dtic6ld6p6kyzbjjewj4cxkc6h6r5t6y2ztazrgozdanz6gkm@vlj3ubpam6ih>
 <CACLfguVNM_b9LdiMyj+pZH0WHu=-Nrit8-cr+QH9=f7tMLDd4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACLfguVNM_b9LdiMyj+pZH0WHu=-Nrit8-cr+QH9=f7tMLDd4w@mail.gmail.com>

On Thu, Nov 07, 2024 at 03:12:49PM +0800, Cindy Lu wrote:
>On Tue, Nov 5, 2024 at 6:32 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Tue, Nov 05, 2024 at 03:25:26PM +0800, Cindy Lu wrote:
>> >Add a new UAPI to enable setting the vhost device to task mode.
>> >The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
>> >to configure the mode if necessary.
>> >This setting must be applied before VHOST_SET_OWNER, as the worker
>> >will be created in the VHOST_SET_OWNER function
>> >
>> >Signed-off-by: Cindy Lu <lulu@redhat.com>
>> >---
>> > drivers/vhost/vhost.c      | 15 ++++++++++++++-
>> > include/uapi/linux/vhost.h |  2 ++
>> > 2 files changed, 16 insertions(+), 1 deletion(-)
>> >
>> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> >index c17dc01febcc..70c793b63905 100644
>> >--- a/drivers/vhost/vhost.c
>> >+++ b/drivers/vhost/vhost.c
>> >@@ -2274,8 +2274,9 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>> > {
>> >       struct eventfd_ctx *ctx;
>> >       u64 p;
>> >-      long r;
>> >+      long r = 0;
>>
>> I don't know if something is missing in this patch, but I am confused:
>>
>> `r` is set few lines below...
>>
>> >       int i, fd;
>> >+      bool inherit_owner;
>> >
>> >       /* If you are not the owner, you can become one */
>> >       if (ioctl == VHOST_SET_OWNER) {
>> ...
>>
>>         /* You must be the owner to do anything else */
>>         r = vhost_dev_check_owner(d);
>>         if (r)
>>                 goto done;
>>
>> So, why we are now initializing it to 0?
>>
>r = 0 mean return successfully here.
>Therefore, in the case VHOST_SET_INHERIT_FROM_OWNER function, I don't
>need to set it again and can simply return.
>....
>    if (vhost_dev_has_owner(d))
>       break;
>.....

Okay, but vhost_dev_check_owner() already set it to 0, so we can avoid 
that, no?

>> >@@ -2332,6 +2333,18 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>> >               if (ctx)
>> >                       eventfd_ctx_put(ctx);
>> >               break;
>> >+      case VHOST_SET_INHERIT_FROM_OWNER:
>> >+              /*inherit_owner can only be modified before owner is set*/
>> >+              if (vhost_dev_has_owner(d))
>>
>> And here, how this check can be false, if at the beginning of the
>> function we call vhost_dev_check_owner()?
>>
>> Maybe your intention was to add this code before the
>> `vhost_dev_check_owner()` call, so this should explain why initialize
>> `r` to 0, but I'm not sure.
>>
>Yes, in the function beginning, the code is
>if (ioctl == VHOST_SET_OWNER) {
>r = vhost_dev_set_owner(d);
>goto done;
>}
>if the ioctl is not VHOST_SET_OWNER,  then the  code will not run the
>function vhost_dev_set_owner.

Sorry, I meant vhost_dev_check_owner(), not vhost_dev_set_owner().

I'll try to explain again.

After applying this series we have this code:

long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
{
	struct eventfd_ctx *ctx;
	u64 p;
	long r = 0;
	int i, fd;
	bool inherit_owner;

	/* If you are not the owner, you can become one */
	if (ioctl == VHOST_SET_OWNER) {
		r = vhost_dev_set_owner(d);
		goto done;
	}

	/* You must be the owner to do anything else */
	r = vhost_dev_check_owner(d);
	if (r)
		goto done;

	switch (ioctl) {
	...
     	case VHOST_SET_INHERIT_FROM_OWNER:
		/*inherit_owner can only be modified before owner is 
		 * set*/
		if (vhost_dev_has_owner(d))
			break;

IIUC this check is always true, so we always call `break` because at
the beginning of this function we call vhost_dev_check_owner() which
if `dev->mm != current->mm` (so it can't be null I guess) jumps directly
into `done`, returning an error.

So I still don't understand in which condition we can run the code after
this check.

Thanks,
Stefano

		if (copy_from_user(&inherit_owner, argp,
				   sizeof(inherit_owner))) {
			r = -EFAULT;
			break;
		}
		d->inherit_owner = inherit_owner;
		break;


>This ioctl is used by userspace applications, so we cannot be certain
>of the type and sequence of their calls; therefore, I added this
>check.
>
>> >+                      break;
>>
>> Should we return an error (e.g. -EPERM) in this case?
>>
>sure，will add this back
>thanks
>Cindy
>> >+
>> >+              if (copy_from_user(&inherit_owner, argp,
>> >+                                 sizeof(inherit_owner))) {
>> >+                      r = -EFAULT;
>> >+                      break;
>> >+              }
>> >+              d->inherit_owner = inherit_owner;
>> >+              break;
>> >       default:
>> >               r = -ENOIOCTLCMD;
>> >               break;
>> >diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
>> >index b95dd84eef2d..1e192038633d 100644
>> >--- a/include/uapi/linux/vhost.h
>> >+++ b/include/uapi/linux/vhost.h
>> >@@ -235,4 +235,6 @@
>> >  */
>> > #define VHOST_VDPA_GET_VRING_SIZE     _IOWR(VHOST_VIRTIO, 0x82,       \
>> >                                             struct vhost_vring_state)
>> >+
>>
>> Please add a documentation here, this is UAPI, so the user should
>> know what this ioctl does based on the parameter.
>>
>> Thanks,
>> Stefano
>>
>> >+#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, bool)
>> > #endif
>> >--
>> >2.45.0
>> >
>>
>


