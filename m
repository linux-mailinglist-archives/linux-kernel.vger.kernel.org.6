Return-Path: <linux-kernel+bounces-322576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E47972B06
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067231F250B5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0C5183CC6;
	Tue, 10 Sep 2024 07:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OY1un5hY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083FA17BB26
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725954124; cv=none; b=OzOM387LLNHKOzHuewgcS3kwpTBU0+LfHB6MQhaL72wcR+vGSGp7BEuBDNqQ7mzaItSKPz+4fLKz8+4zbcXPlifjtcMF4ICfaXb7Cn6+r1KbQD+CBTNEShc0jYk23Q+uZ0IX4CiQmZFh1QsA9iCWAYOTARi7IOdlxEgzu/uD9uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725954124; c=relaxed/simple;
	bh=868wQv69+C1rc2cl0jagbErfwedCUJFcxF801bTgrYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0hbPwbIzWaajyGYUguw2WzuFm5ly7C2lCYFp0379e5zlmMcRhhLRdaaDV+vJItTD6/uHFGTUn0Waxw8cePJmRSk9ngBxqF9Z5IMxgc6paf6NEd+aawQ/CdPcrj7cHB141jgtMq1Lqyt+8JZqJOIcrDf50fCZ0Rww9KlDYMRoe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OY1un5hY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725954121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YjmwAz5ahZsSyMH7sv/F6TU19phROj9JmvsK6FuhNcU=;
	b=OY1un5hYrL4EK5CHy0+q8qr72nJFNxrmuIcPEEb1TsdpWcnXV7WP2nFIRT1CWm2ZP2il25
	OOIQaU82lod6iaPvV6OwuiEzBzpuhwH+qseqQyv1ZwwSN2QoUJLafBTQxdpi3L4fgFd8tY
	cvw9vkGZ7V+lRcz6XovTW87hWK5j29c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-Kfpj1oB3Mwa08EOrAgrukw-1; Tue, 10 Sep 2024 03:41:58 -0400
X-MC-Unique: Kfpj1oB3Mwa08EOrAgrukw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374c301db60so2260950f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 00:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725954117; x=1726558917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjmwAz5ahZsSyMH7sv/F6TU19phROj9JmvsK6FuhNcU=;
        b=C7lw/GeSr/oIHjWCt/7v59XJvyRfLWQnBAGg4/MqJDY+cnPP2TQqhGx5j8mVDu7noj
         XvSFIWeGy0yMPZrN2glk+9/tsCp5xF7jLsM/8FcxRNUu6pd75FRAPUkHGN+7ggqP+vAA
         PF8QsYyifevorbw+m/GCZq++McvvQUO2/w0uxjrxfXCo/ce5oNX0CcfqfY43iTq7aqAQ
         ZrRScKgQDL7E17wjCk/VrhSC4iQVLxlxSCGTAq+NZpxP/FqNE9mxPOotFw7zZCh0ZI28
         hpW4YqXo0pKapuMClU9+mDkcPZM5jhNr1gCYFHE/fND1QvWZFuKo+EZcOIEGr0SOKpIf
         1A8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFfwIV4CCks6Q02GHFYcdmhQvr3ZKefb/fml7hezb+CcR1+YVKRwVnSpBr0srKVZQPhf3FnHAALRojMV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIpXeo07wh8h7JUvWRnAOdzGoHY42LS4mDPY22GeLAQDGZhsNs
	iwLf3rLsu6rKOZEv1xWkAW9nO0tnMdnAxA3FjIbyJvEMZlSKaY9cxQYK59BfRDbIHevmOqmeDKd
	EvydE5DBdspDl3XQpbE3UDQr1sSvr+NlDACCtPGFfKfx7LsrMYDWDvJUD06Nhpg==
X-Received: by 2002:adf:f687:0:b0:374:cb17:c62f with SMTP id ffacd0b85a97d-37892685e58mr6075124f8f.11.1725954117108;
        Tue, 10 Sep 2024 00:41:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjs08g7NP4XaP5B2YK7CxhhOiPcTLvIVgpASYWgufgd1/GjiAqX7+X6E9+SleKBdH7ZBVQNQ==
X-Received: by 2002:adf:f687:0:b0:374:cb17:c62f with SMTP id ffacd0b85a97d-37892685e58mr6075095f8f.11.1725954116265;
        Tue, 10 Sep 2024 00:41:56 -0700 (PDT)
Received: from redhat.com ([31.187.78.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956de02esm8080786f8f.109.2024.09.10.00.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 00:41:55 -0700 (PDT)
Date: Tue, 10 Sep 2024 03:41:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [RESEND PATCH v1 0/7]vhost: Add support of kthread API
Message-ID: <20240910032825-mutt-send-email-mst@kernel.org>
References: <20240909020138.1245873-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909020138.1245873-1-lulu@redhat.com>

On Mon, Sep 09, 2024 at 10:00:38AM +0800, Cindy Lu wrote:
> In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
> vhost removed the support for the kthread API. However, there are
> still situations where there is a request to use kthread.
> In this PATCH, the support of kthread is added back. Additionally,
> a module_param is added to enforce which mode we are using, and
> a new UAPI is introduced to allow the userspace app to set the
> mode they want to use.
> 
> Tested the user application with QEMU.

Cindy, the APIs do not make sense, security does not make sense,
and you are not describing the issue and the fix.


The name should reflect what this does from userspace POV, not from
kernel API POV.  kthread and task mode is not something that any users
have any business even to consider.


To help you out, some ideas:

I think the issue is something like "vhost is now a child of the
owner thread. While this makes sense from containerization
POV, some old userspace is confused, as previously vhost not
and so was allowed to steal cpu resources from outside the container."

Now, what can be done? Given we already released a secure kernel,
I am not inclined to revert it back to be insecure by default.
But I'm fine with a modparam to allow userspace to get insecure
behaviour.


Now, a modparam is annoying in that it affects all userspace,
and people might be running a mix of old and new userspace.
So if we do that, we also want a flag that will get
safe behaviour even if unsafe one is allowed.


Is this clear enough, or do I need to elaborate more?

Thanks!

> Cindy Lu (7):
>   vhost: Add a new module_param for enable kthread
>   vhost: Add kthread support in function vhost_worker_queue()
>   vhost: Add kthread support in function vhost_workers_free()
>   vhost: Add the vhost_worker to support kthread
>   vhost: Add the cgroup related function
>   vhost: Add kthread support in function vhost_worker_create
>   vhost: Add new UAPI to support change to task mode
> 
>  drivers/vhost/vhost.c      | 246 +++++++++++++++++++++++++++++++++++--
>  drivers/vhost/vhost.h      |   1 +
>  include/uapi/linux/vhost.h |   2 +
>  3 files changed, 240 insertions(+), 9 deletions(-)
> 
> -- 
> 2.45.0


