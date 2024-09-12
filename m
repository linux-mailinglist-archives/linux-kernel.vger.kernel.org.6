Return-Path: <linux-kernel+bounces-326764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF01976CA9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7611C23B5C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CEB14293;
	Thu, 12 Sep 2024 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kKknT4C7"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A09176FCF
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152640; cv=none; b=P/jFlPOB8KfsnPtHEQswcdN9725nIsgOl/AFA+U+At9oUuGLWHcMPgKUTk0xIglQuijrKnEbayumyUBfgsshuZi4bF2Xa3wDRm8dglrJ9WwCSv53HOwmVSBXmR2t/JPoOeA23N9ade7vexwpZOLuXJA2cBbgH7EysmSw1WteuMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152640; c=relaxed/simple;
	bh=TBxosJnxKNSR0MGeo9H9cM/4TfnfF1GV0MUVsO/FJXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qe/oR6vU9mdhbnsuVfCT+EI1Ye3cs2861UPnNy/zrGIRHddHhBWGe2vvPeCjQQyZaE+fT32H/4dIuef+gKshyN5sewYI3MywX02Hq0hqMyZANoBEa2VW0DoenRGlmMYG/GOGy+ld6eJiVe7yR1xug1xJ11tIUMXUwZLHvuGsMR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kKknT4C7; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2055a3f80a4so7459655ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726152639; x=1726757439; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8riDeJfpKTiIIgIK66ZvC0JkQHqkw/ZkvYMdWGm4eVU=;
        b=kKknT4C7VsEw99TpuC89aoZZSdMdmdRRiaqe1ayEa3f94Rfqw2gE8xbK2tRlA/oVsH
         HxEvkqZhD9Lr8YtyFKWp4B1L0zErz82/hDnpQrnS0fd2cqceIVX+62oqYXALxzzZ09xZ
         hK+60J/VS2Tn6wCMXpx8FlZisNHaRvoBudFnkCN8sSKAhcRpmEviDcOsgwqITAo7X2Ah
         VwB1PBILBzyh0M7ujQ6cUdDVyvfhLBTeDjlqOlrTLVA0RZm6P8vNZH16EcZF1bJ8908S
         GTXUAf+WGXaf+zXQHRXDdfEYE25HN7hjKobRIu3tk6zDm7AkjjrLyBXJq7JnNu9qAOog
         08TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726152639; x=1726757439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8riDeJfpKTiIIgIK66ZvC0JkQHqkw/ZkvYMdWGm4eVU=;
        b=cFVuiGWFYqyLYPZU0qerhwxpUfhEfxlj973IE+ax8dFRST3NoJk0bZVfJsxvWU01YC
         qfNJRlEfDGZa75cEbuLq4qkgC/8vNJyHmzoWwHQf7UXEsB+AF6L2Ql7JZGC5nIPc+vwl
         yCRIEs/Y7yIdlRoIgl0bwD8DZwkd++5R/NrkbV/3mUDGcFpWT8qo4eLAJR8DEjRm2zTv
         mJxZvfX3f8tj+deXnrpMwlITbf5WbIU2gCjUHs5FjuaNUfAvJSAEq1+b8vguoh8cW4HL
         jWo2sUsoAwsp07EpsL1hcFu/zOzGLikuDr3rzB6cmZmW8xxUz1qOyskIOfxr6k7lnlpw
         NAfg==
X-Gm-Message-State: AOJu0YwwwbJFRhWbojNlsN1Cn51pqQjmezuP51KJO5KxqOk5M8uUDvtf
	VzDqNSBP/1iJOF7iWMmrQXCZimEh3IyemufPEJNKWEPzlp2GsbYfMCKVK15rnBhgNbC/ycEr9cN
	2aPgODRj9llkkdPbeeO5ryCjSRSe52CvMSxHa
X-Google-Smtp-Source: AGHT+IH+oOivsgfrBeKHuHozhtz6eiw/QOezGUkUUw4eyVeYY7NMSvWWqexcWfthAnr/CXOkRdF8YxLmOcYdvlqrug4=
X-Received: by 2002:a17:903:32c2:b0:207:894:6e58 with SMTP id
 d9443c01a7336-2076e45e311mr42095165ad.56.1726152638371; Thu, 12 Sep 2024
 07:50:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <39fbceb9a794b7c412b17c4ac6c2dd285d1bd3e5.1726152335.git.mst@redhat.com>
In-Reply-To: <39fbceb9a794b7c412b17c4ac6c2dd285d1bd3e5.1726152335.git.mst@redhat.com>
From: Marco Elver <elver@google.com>
Date: Thu, 12 Sep 2024 16:50:02 +0200
Message-ID: <CANpmjNMNgvg+NKtzxy06AB4QFQKzFsmp-chB1G_+XueiKNA-bA@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: tag event_triggered as racy for KCSAN
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
	syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Sept 2024 at 16:45, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> event_triggered is fundamentally racy. There are races of 2 types:
> 1. vq processing can read false value while interrupt
>    triggered and set it to true.
>    result will be a bit of extra work when disabling cbs, no big deal.
>
> 1. vq processing can set false value then interrupt
>    immediately sets true value
>    since interrupt then triggers a callback which will
>    process buffers, this is also not an issue.
>
> However, looks like KCSAN isn't smart enough to figure this out.
> Tag the field __data_racy for now.
> We should probably look at ways to make this more straight-forwardly
> correct.
>
> Cc: Marco Elver <elver@google.com>
> Reported-by: syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index be7309b1e860..724aa9c27c6b 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -194,7 +194,7 @@ struct vring_virtqueue {
>         u16 last_used_idx;
>
>         /* Hint for event idx: already triggered no need to disable. */
> -       bool event_triggered;
> +       bool __data_racy event_triggered;

I guess if you don't care about any data races on this variable, this
is reasonable. Although note that data race is more subtle than just a
"race": https://lwn.net/Articles/816850/

Acked-by: Marco Elver <elver@google.com>

