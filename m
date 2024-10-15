Return-Path: <linux-kernel+bounces-365184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FD599DEBE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C9331F250E8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 06:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FEA18A6DE;
	Tue, 15 Oct 2024 06:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hk2xAQ4/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46141534EC
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 06:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728975161; cv=none; b=nGDDpaJcDjh53sVLL6jnOLBVtcitcxb4BMSEypaUDpQ4jXPfsz8xvx482TlHlKCWr/YdxSZgh4ejh6Ln1PZmzJZnfIhiP0UWVGzFMdRYA7TgajQEZx7ZwhoXCBFjf/9IdBYZ56AMYss098jAq6VTdoHfCjdsbyUGqt4kZD/KnVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728975161; c=relaxed/simple;
	bh=IxKtbfbDWpfY+XrFnqwdLbGcdWrAl8fFCrbgJ+zlr4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXfwV1maJFzUbQ6MSAus8B1msnMcw7zZbGD1O5Ny7gufzJmPVAmM/uBk3VWXRmQFdcdmAD/0w5Y6SNvtuahXQhocb64yx1MsSB6bbUe1jljGUHFPHareb8PoEGhBBJq8+CqWUqCFpRR++VxZLAjeMDaoG+ykZ1OOsCUBaO4e9xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hk2xAQ4/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728975158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Us05G9Xv9FB2BCQGyCCUClyEftS92UVQm4omwqD/MU=;
	b=hk2xAQ4/OtL/KKLk5m5sUyxZzMr/WOkEhT3VAaW+WZ8tkKbXxpVBSbygC8lxC7Ebd86NCu
	yQS6vJCLWTPSRoBvtBOMOqUtWO9aV/ypmyT5kOc03U6+p+l3IPA6KdqbhuoKXzNaG+evjb
	kdLaNuEfY0RGCOyngmub7drXucV+IO8=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-m6M0mbpQNjmg4DfXJ7QJTA-1; Tue, 15 Oct 2024 02:52:35 -0400
X-MC-Unique: m6M0mbpQNjmg4DfXJ7QJTA-1
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-50d45b97422so254121e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 23:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728975154; x=1729579954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Us05G9Xv9FB2BCQGyCCUClyEftS92UVQm4omwqD/MU=;
        b=R3SO55VxfEegQ8vA9TOtNGjmrkTXWmmCfMBGwfFxYeTczX6/J7K9vfWQc/l4LmClKZ
         jSS7fvF+o9cL+5yCmUt7VF7xwllj33VdvaLcVOys3AyDkMxVZqfxZdnIlm/8adKsvaS9
         L9VBYHr2otS+LRuhrR7wWKhPJS/KH5sodL97PN/AYBpD/fvls8S1YqJA5S9GHhRFDnhU
         hQby8igG5GDweY1hV4VsBwDnufJJ2b9Hq60+HgVzPGLdg5NHNnV5p8HmTXYgbAm8YF3r
         I3y2LQ3M3CKXwc+OohGbQxEEhywgHZFXY9ul8yUuP6RYFJLDtXla378z7VStqoAK2tUN
         D0bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTShqRPb8EeP1JYI+iyQNeaay2eTBI94swikx/RSSdPhyWbpAQPdfxTPWXhUvyWu+504kA8THV+c71l4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn8J2JtFyx11qwaixGbInQHMo9rujn0fSuiiBuYjWon7J3S7dC
	ENwC+iQcfdnu69Aqv46wvqTb84LVSlpA0DfNJD12E7Tbymm02ZWsff/THdnTH5bezfG31UZk5TL
	HTawyPQCsJ0HrdP55qDsiV7C8xDuT9ZzVEgaWxCFvreg6VtOLEF+mLN+IzIDvInkCBq1yiAg/
X-Received: by 2002:a05:6122:181a:b0:50d:35d9:ad55 with SMTP id 71dfb90a1353d-50d35d9afafmr7906037e0c.13.1728975154656;
        Mon, 14 Oct 2024 23:52:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKE3sM82gE1lH2AbmVMOwgCoWkTjZKZlxe3981Acz9icXIZwSdhkC3L7BLm0xRKplh8L48RQ==
X-Received: by 2002:a05:6122:181a:b0:50d:35d9:ad55 with SMTP id 71dfb90a1353d-50d35d9afafmr7906028e0c.13.1728975154145;
        Mon, 14 Oct 2024 23:52:34 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc2290fa5bsm3300536d6.12.2024.10.14.23.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 23:52:33 -0700 (PDT)
Date: Tue, 15 Oct 2024 08:52:28 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: Mike Christie <michael.christie@oracle.com>, jasowang@redhat.com, 
	mst@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 3/7] vhost: Add kthread support in function
 vhost_workers_free()
Message-ID: <lpwqg4j2nnh3xgg64vrlk635vcmu2bxrq37sapwp3yl2pdp5rz@lg3wgfop6rkx>
References: <20241004015937.2286459-1-lulu@redhat.com>
 <20241004015937.2286459-4-lulu@redhat.com>
 <acb5ea13-9695-4158-9152-aff761401be3@oracle.com>
 <CACLfguVB0Xn2vsj6kJB9ONv1AhpcUteH9PEqDaPX-7JkxxqvKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACLfguVB0Xn2vsj6kJB9ONv1AhpcUteH9PEqDaPX-7JkxxqvKQ@mail.gmail.com>

On Tue, Oct 15, 2024 at 02:05:47PM +0800, Cindy Lu wrote:
>On Tue, 15 Oct 2024 at 05:06, Mike Christie <michael.christie@oracle.com> wrote:
>>
>> On 10/3/24 8:58 PM, Cindy Lu wrote:
>> > +static void vhost_workers_free(struct vhost_dev *dev)
>> > +{
>> > +     if (enforce_inherit_owner)
>> > +             vhost_workers_free_task(dev);
>> > +     else
>> > +             vhost_workers_free_kthread(dev);
>> > +}
>>
>> With patch 7, userspace could change enforce_inherit_owner after
>> we created thread and we would call the wrong function above.
>>
>enforce_inherit_owner will only change before the owner was set.

As I pointed out in patch 7, enforce_inherit_owner seems to be shared 
among all vhost devices, so what happens if for example a user sets it 
to /dev/vhost-net, while /dev/vhost-vsock is already initialized and 
therefore already has an owner?

Thanks,
Stefano

>the process is like set enforce_inherit_owner---->set owner->
>thread/task creating
>in in patch 7's code I have add the check for vhost's owner, if the
>owner was set, the ioctl
>to set enforce_inherit_owner will fail
>Thanks
>Cindy
>
>


