Return-Path: <linux-kernel+bounces-321481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D19971AFC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F1A28A0BA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504461B3F22;
	Mon,  9 Sep 2024 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yb0a63UE"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562901B78E0
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725888423; cv=none; b=pza85mVoBDdbI5qB5h14itDxbTwkNxJK3c+URhQxJQmAc0gUslIgvfuA9PlIrN0c3tu0FSwp45Jug8GTWdTtmlGmd3Cmee5VkYpYBBwcIOJEluQLfdc24vJM7BYw7vmu80/GDdt3eX0JY0yDyePyQutdjBrcYOm504/bGtwLwNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725888423; c=relaxed/simple;
	bh=8NPuVW4r6t7ooWB4l704lARcRv+pYm5pldQ/0JNS5Ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mx9YU7sq//HfiMWighroQmo3EE5AxUQpD6+Jr1XDRTgtWWtz5UpxEUvwvSNNjVvbiY1LiX4OlmGzSHJrDj/iT4CZ8CwTQiqW+tcdCGJki+HBosE/Fj5S3vUQTJGj8DFHwvldmoyGe71p39t/i8pVOLN9QmwApcARt/ECj8deFKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yb0a63UE; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-846bcf3677dso1200695241.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 06:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725888421; x=1726493221; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RK2owrGqF5BPDXOzMjhXIFhBXeulK+IBCn+O/obzMo0=;
        b=Yb0a63UErZ3Br1YmcyxKTjyVeu7EK04sSzgYBI1uc0VXS9SDE5WwUhFus666BpBYWt
         fkl6GhvvubQIkyYJbEI7tcHX1nu9f/sXn4rHlsLqAeWoP6l8FYi0BdlmN5o2MICFhPSK
         uqfQ/+FivX6Z7RFCD3UhxuprWJTkneWqnYpvV70ReAxvy6op8OenuHlFxdwZYd6pgBOl
         pPbziBsYBfoD5D1WyBaFJJZhMctl1JW2xezWWCOvCDK4lz8fLn8nUMCSWcOkCDHAKTL3
         4Mw4O11ksV7Pbut8+Mi3vEHzwLj4mqCZMSKugM3l3fIVXujfu1TTF8pIb2h0DtogEe/7
         Qrvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725888421; x=1726493221;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RK2owrGqF5BPDXOzMjhXIFhBXeulK+IBCn+O/obzMo0=;
        b=Ee6nNanyVlReZTCatzZMYPZQUUddq9a1CeuphXx0tDmBX10CdUDhg6FkXa61bdJGPv
         Tc3U5Vh7xlyZ1KCmKSY2PkMRnIez4rjnOKGs+/vON252vkskoghOmjFYJL4AtBN4sRrX
         O2JvIFehJkFs/LB3IH6jFwyL9V9TI4exaU7JYOPA4Rxvf91kayJ1wXU5HRGoQK44JSfo
         Z0dUM6OOFRWlRbNTGNLkBuqkvX5tUhNPVjosvqzWNLzUStfccjUzSTw0CjVELKGhcT/m
         oQAB+Zv9lnth5oq+zgJ8txxMHmK020h7QDpx2+uZqmU33XVH4sY1kKQxdpcMUWyEWhaQ
         kGUg==
X-Forwarded-Encrypted: i=1; AJvYcCU57bKd6uZUOFd05PethQQkQ6IbyBktjvJhIzv9UWWiqAXl8QVb3GOzuuYAxbGHDzbhbbpoLNFrwfRpMOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfi4mvZycccCA0Mn+g1XSJBz7iGgyzf1KkNjFgh7MqKYycGY9F
	obi+teYBYlc3Qyp+iI2MZKSBzjuv7A3fl0arwNZGs44gQwEK5ut8HTZewgKjfe1fGzivuRA5/F8
	bnc1legbY2t346LT5W1U2+cfnYEKxCl5i8kU=
X-Google-Smtp-Source: AGHT+IFdN7CQlNG7Z4/pzQWiLsu0EFgNsMpPnKQE23XgLfB9rnTVGgJTc10xs6B0LLchx5XDjp3+ymefBefd4ATKd3M=
X-Received: by 2002:a05:6122:3104:b0:4f5:1978:d226 with SMTP id
 71dfb90a1353d-50207ebf230mr10711341e0c.3.1725888421147; Mon, 09 Sep 2024
 06:27:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826215313.2673566-1-philipchen@chromium.org>
In-Reply-To: <20240826215313.2673566-1-philipchen@chromium.org>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Mon, 9 Sep 2024 15:26:49 +0200
Message-ID: <CAM9Jb+jRL9f-JH1WNx0m-ua=FX+ksr7SjUR46pGUG9W+7yj3Ng@mail.gmail.com>
Subject: Re: [PATCH v3] virtio_pmem: Check device status before requesting flush
To: Philip Chen <philipchen@chromium.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	virtualization@lists.linux.dev, nvdimm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"

+CC MST

> If a pmem device is in a bad status, the driver side could wait for
> host ack forever in virtio_pmem_flush(), causing the system to hang.
>
> So add a status check in the beginning of virtio_pmem_flush() to return
> early if the device is not activated.
>
> Signed-off-by: Philip Chen <philipchen@chromium.org>

Looks good to me.

Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com

> ---
> v3:
> - Fix a typo in the comment (s/acticated/activated/)
>
> v2:
> - Remove change id from the patch description
> - Add more details to the patch description
>
>  drivers/nvdimm/nd_virtio.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> index 35c8fbbba10e..f55d60922b87 100644
> --- a/drivers/nvdimm/nd_virtio.c
> +++ b/drivers/nvdimm/nd_virtio.c
> @@ -44,6 +44,15 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
>         unsigned long flags;
>         int err, err1;
>
> +       /*
> +        * Don't bother to submit the request to the device if the device is
> +        * not activated.
> +        */
> +       if (vdev->config->get_status(vdev) & VIRTIO_CONFIG_S_NEEDS_RESET) {
> +               dev_info(&vdev->dev, "virtio pmem device needs a reset\n");
> +               return -EIO;
> +       }
> +
>         might_sleep();
>         req_data = kmalloc(sizeof(*req_data), GFP_KERNEL);
>         if (!req_data)

