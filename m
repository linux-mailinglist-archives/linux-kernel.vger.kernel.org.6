Return-Path: <linux-kernel+bounces-252742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B4A93178D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01092823D7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B83218C35B;
	Mon, 15 Jul 2024 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aFepEFyS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636AC6FC2
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721057239; cv=none; b=AcDNNsPRXaEi+LcQA7t8JebGGezMd8gjl9WG65Zp+EEXA/WgSqwPTyd6pVdNdahNTFjEU2Eod9HCcW/LwXXAbELwaDSAZ0nox63ocZVHmkUrrXUHbMkDUx3reAjW43JeZcTYfbOavV1uexZez+iXOOX9b9a+M+vkK9Zl5ihxTYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721057239; c=relaxed/simple;
	bh=2S+FrgQ8ryPuwWYvWnP1efip7b8Y99QYBtp9UmFAWAQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=HCgYGi3A0NhdDbWYJ08Rz4ItT13LkNrxNxPNLnsFbjl+kCgkfG8E5FZ4eCEikLQuCP78gc+BHaJKZy8+y032zxXZR5ZgOJ0TfCRTFycB9M/GMiA4mAoaZQHTUye6oh0AatuKgKfIF+5Awi/jh4KSrpbPczSfeEdpPAqSNIXCmaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aFepEFyS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721057237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=2S+FrgQ8ryPuwWYvWnP1efip7b8Y99QYBtp9UmFAWAQ=;
	b=aFepEFyScMTBCzule/FcNsiUxyZ4jjM2kD1LKh79ct/DRYTfYpzloDbA0lsg6ZMVpHQ8Vr
	3RjiDmAra9/Nn92ZWe2Cyr0/ZHrx9RDVWgp6OabnCz+krXevFO4ZZewqhHUacXVrf6554T
	K/lUfsuAbA/hYWuYTRIpwak0wxLXmtI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-SApNs9NkNIKbFNyb4FfzcQ-1; Mon, 15 Jul 2024 11:27:14 -0400
X-MC-Unique: SApNs9NkNIKbFNyb4FfzcQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ee91e5be95so50878331fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 08:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721057232; x=1721662032;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2S+FrgQ8ryPuwWYvWnP1efip7b8Y99QYBtp9UmFAWAQ=;
        b=wRnRqiKhMnQ3o9wW9PQNj3+054XNuZENn6PSlHZ7j+CX7BEkKAuokZmPk16weGbrvg
         OzAIhTIMfQ62pC6l/01zd3w1FuWUNQI6u752m+MqRHn2lj62JdhMfFaSCJdygB4JlpDq
         cIbiHa811h5kkp5heQaiA3uy8Z+Onu5UjmIkyBDqX5J+W4PK8n3qaWvK/Wv4uQrLkMT5
         gXDKB5tf/p+SkkhewgyhjnpnmHBREmm74gwRn8CXa1k3iBdWnHMb6JQCiuIqdp416Crq
         a5HpLTMxerk+61VVrrcE6J/wrZ0hzDJn3CdPIp4XgvzhZ8K2LHS86dkcLSgblVbtExMz
         7TNA==
X-Forwarded-Encrypted: i=1; AJvYcCVyBzBfOzPCjBhSLVLpXy780MWQcPHtTAdM76COR+nKae+LaP5r5OAh/1q8L1TmlIwRcX7MBdu/jjacvA1DwsNDtzGI6uGyLSnPR+gK
X-Gm-Message-State: AOJu0Yy/WI9fVVIO3tK4xHXAtl+iHkY+gZGHcgAG3Riyx4UqKt6OqerQ
	szWW5kwZRENBz6wX3vaKVuuaQISIE6zyjr8s7PxFBHe4iXWXXloRgzO5Qz3VKgK0Q/br8t7m10s
	NqHnni9CDgH8X+ilvq/knGQOVlBa8Pgs4aLXgQQjkFvKEoly1dMOt3DKNEicr73nzZbFPkV8JiL
	SFeqjAe6dPPSNcIi/sCoJflu8XjBxgErxZ38MzCz9RQH60OHY=
X-Received: by 2002:a2e:b6d2:0:b0:2ec:a022:880c with SMTP id 38308e7fff4ca-2eef2d7b300mr2044451fa.22.1721057232313;
        Mon, 15 Jul 2024 08:27:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/cAGXKgNc1G6xQ5YWBwDINp5NWcOG2InrNWSxqlV2YNKQjwSCAOCz7jjWvd/r6Ah19T2H7Sct5RkMKoTvo6U=
X-Received: by 2002:a2e:b6d2:0:b0:2ec:a022:880c with SMTP id
 38308e7fff4ca-2eef2d7b300mr2044291fa.22.1721057231912; Mon, 15 Jul 2024
 08:27:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 15 Jul 2024 11:27:00 -0400
Message-ID: <CAK-6q+jSBjuFaFqGLQcfVLMUwRcJJMHk2oUnSgMObwz+OAih6g@mail.gmail.com>
Subject: udev kset_create_and_add() with own struct kobj_type?
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, gfs2 <gfs2@lists.linux.dev>, 
	David Teigland <teigland@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

I am currently implementing namespace support into the fs/dlm
subsystem. The DLM subsystem uses kset_create_and_add("dlm",
&dlm_uevent_ops, kernel_kobj); to create the "dlm" sysfs directory.
Underneath it creates for each lockspace a subdirectory using
kobject_init_and_add() with a non-static name and being known during
runtime.

Now I want to add namespace support and need to change the "default"
kset->kobj.ktype = &kset_ktype; that is set by
kset_create_and_add()->kset_create() to my own kobj_type because I
need to implement a different ".child_ns_type" callback before
kset_register() is called.

So kset_create_and_add() does not allow me to add my own
".child_ns_type" callback for the kset that is required for me to have
my sysfs "kernel/dlm" directory separated by each net-namespace
without breaking any backwards compatibility.

My current solution is that I mostly copy&pasted the code of
kset_create_and_add()/kset_create() to have a way to tell my own
struct kobj_type that contains the implemented my own ".child_ns_type"
callback.

I am writing this mail to get some advice on what I can do here
without doing the copy&pasted code?
Add a parameter to kset_create_and_add() that allows me to set an
"struct kobj_type"?
Introducing a new function that does allow me to set the new parameter
(I probably like that because then I don't need to update all other
users)?

Thanks in advance for any advice.

- Alex


