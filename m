Return-Path: <linux-kernel+bounces-514658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75801A359DB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 041017A1F97
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C347122F151;
	Fri, 14 Feb 2025 09:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KbVSiN2J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABC222F14C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524163; cv=none; b=PKPudgkG7HSs/Vhasn1/lkryX8RuLQHozxuJTNB6Yn4J6+PERZjII/36Vcy7wkYAmAgWHm9/6gGRR0+selKJC3TBjvg5sagrkOlOpOIfW9IQN8BgIre2/SEUQPC0I+ILBSl1yHSKYL7TyMW+61S8gPB7/gZLUuF1o+ccO4uQvMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524163; c=relaxed/simple;
	bh=+YlkbjzccGRqkWwHpSFZUUSOe0RPNXe8gtXayegBMac=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJY1bWT//GsvSwY65DUwxgMWfZIN14D7HKTNr1SBlgVsj1TzKV4ABJp8kGZm8tvlDCi9QsPpyfVmAdlzHW3ge9Lk1+MxLe2yojH9AIo/+3u3cRdupz28XLJeVxPC3RHDYnXtPkt8wV+8QR14aW1Lr2ctGHXjyfc9BHsfVsd4oJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KbVSiN2J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739524161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/+nbout4lsz7dbdgL7U1+4YNWasydkL0pPSm+7Ne+0E=;
	b=KbVSiN2JPjxDSdYXgJrU4qeCPay8f5Qjqg52MmrE0YktA8L0WwiyNltC2ic/faFg252xCd
	lS4NbAHUCZObT9TJWzjgyWzs1zRyy3Z+9e/DSmOZJ7bOkWhyfjrdupVhTisfVIV1yRks4P
	HR6B124aAZn6cVkuzzZrhAAgQIIlVjQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-vDmXT03oMl6RiIQdKQNkDQ-1; Fri, 14 Feb 2025 04:09:17 -0500
X-MC-Unique: vDmXT03oMl6RiIQdKQNkDQ-1
X-Mimecast-MFC-AGG-ID: vDmXT03oMl6RiIQdKQNkDQ
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2f2a9f056a8so4007193a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 01:09:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739524156; x=1740128956;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/+nbout4lsz7dbdgL7U1+4YNWasydkL0pPSm+7Ne+0E=;
        b=vt+obD2Cy8uBzCTWJm6TTT/1cViKn/VTPTCVyDTZFcdYHEU4rlYLcBUMgzOaZLBOsi
         4vVU2SbKpUEfehje2JbLjou8GkdSlMKKdkZaoQZK4MGztrBHoUpnZl1Rbr0q+UuajJwg
         46xIXifAFWfC7OwMrcyEmlseL4RH3Fm3+2CRBtRekoSYcUqaq+2LQJsRiWjruhrummCS
         togbrh5PmaFjyyQInM/fJLVAOVSAFzaysbq9ViBTW4w2u9YUEMdLVtkWD2PnHxdbK8Yn
         m5nEfESOO1N8gFWoyIoyxtbJMOrn9kthLr3BvB+4zlbsDbEizUVb5Ft+GExX2QLH/zCd
         L0UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSZLx1IZ1MbJoCzqoeh/XqE7jVewG0WkyokUCIiSFyilVgQ4gPKDkC4YF0/FjFrgLN6cfP7Hy1N8LDtys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxucQTxU4viKnrZJOJiwuW+pzbAmY9uA7FVQb3yEXbLUipiq+EC
	lDXCgzVTiAX4KpIFY8zPBGI9adElpZSh+ARgYm5VaRNpPw5JWpGfzxFxzwXSu31S6Go8YOLTA0f
	5OrDQ3YXmsjZsKc1JX73G1chMMGGsSfsVPgXOVbxJsw7xuDIY26uMqM1G9K/iZLye3opVe6bV+G
	GUGN9oOkWoWjG+GFYAXwFiUhUBHYzPzIAdO/R6
X-Gm-Gg: ASbGncv6B+Hfcm0QI7BWuIUYt4p3kzhPyWwEX61XvBT/sub4c2aP1JCCHKGCliYoEPI
	nKKOwyO/BgrswlMD/eVZQ3YI87YcF2obNB98t/NKNeLCEi3bbVOZalEET+Q==
X-Received: by 2002:a17:90b:23cf:b0:2ee:f076:20f1 with SMTP id 98e67ed59e1d1-2fbf5adefb1mr18493340a91.0.1739524156703;
        Fri, 14 Feb 2025 01:09:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfBgLIwyh2FsWpWhHAyE4zl/I82er44UopncdtHfHPjqZPaXeOHlFpwjXqLXDv7MngbAIpn83RTELo7JIUQoE=
X-Received: by 2002:a17:90b:23cf:b0:2ee:f076:20f1 with SMTP id
 98e67ed59e1d1-2fbf5adefb1mr18493302a91.0.1739524156373; Fri, 14 Feb 2025
 01:09:16 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 14 Feb 2025 01:09:14 -0800
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <CABVzXA=r=X+GYnSxgeyktKzfKCW2DW+v++c4v_+BHBDHZ_Bzyw@mail.gmail.com>
References: <20250213-virtio-shm-page-size-v1-0-5ee1f9984350@redhat.com>
 <20250213-virtio-shm-page-size-v1-3-5ee1f9984350@redhat.com> <CABVzXA=r=X+GYnSxgeyktKzfKCW2DW+v++c4v_+BHBDHZ_Bzyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 14 Feb 2025 01:09:14 -0800
X-Gm-Features: AWEUYZkUHPoBM7Ip5aSx6k-wlgqT6hg27bhkTyFnhLlZU7B6wD2b2Y1SLRAiVHo
Message-ID: <CAAiTLFVZGNi-i-qCZZcoyX6Hfgtz+NMAQSq-OHE4Q0n+kvsc2A@mail.gmail.com>
Subject: Re: [PATCH RFC 3/5] virtio-pci: extend virtio_pci_cap to hold page_size
To: Daniel Verkamp <dverkamp@chromium.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>, 
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, fnkl.kernel@gmail.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Daniel Verkamp <dverkamp@chromium.org> writes:

> On Thu, Feb 13, 2025 at 7:54=E2=80=AFAM Sergio Lopez <slp@redhat.com> wro=
te:
>>
>> Turn the 16 bit padding into a page_size field to allow the device to
>> pass its required page size with format PAGE_SIZE >> 12.
>>
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>> ---
>>  drivers/virtio/virtio_pci_modern.c | 29 +++++++++++++++++++++++++----
>>  include/uapi/linux/virtio_pci.h    |  2 +-
>>  2 files changed, 26 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_=
pci_modern.c
>> index 79616ce5057bf3b2b88cae7e8fb7729efa9dd632..26e9cd5148c0f10209c34d12=
e65d64490a855d75 100644
>> --- a/drivers/virtio/virtio_pci_modern.c
>> +++ b/drivers/virtio/virtio_pci_modern.c
> [...]
>> +               if (__virtio_test_bit(vdev, VIRTIO_F_SHM_PAGE_SIZE)) {
>> +                       pci_read_config_word(dev, pos + offsetof(struct =
virtio_pci_cap,
>> +                                                                page_si=
ze), &res_psize);
>> +                       if (!res_psize) {
>> +                               dev_err(&dev->dev, "%s: shm cap with inv=
alid page size on "
>> +                                       "a device with VIRTIO_F_SHM_PAGE=
_SIZE feature\n",
>> +                                       __func__);
>
> Maybe this should also constrain the page size to be a power of 2?
>
> [...]
>> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio=
_pci.h
>> index 8549d4571257142ac6c9dad5c01369923791a85a..fb0ccb7a125d8178c1f78333=
c4d2f43540e1764b 100644
>> --- a/include/uapi/linux/virtio_pci.h
>> +++ b/include/uapi/linux/virtio_pci.h
>> @@ -127,7 +127,7 @@ struct virtio_pci_cap {
>>         __u8 cfg_type;          /* Identifies the structure. */
>>         __u8 bar;               /* Where to find it. */
>>         __u8 id;                /* Multiple capabilities of the same typ=
e */
>> -       __u8 padding[2];        /* Pad to full dword. */
>> +       __u16 page_size;        /* Device page size (PAGE_SIZE >> 12). *=
/
>
> This comment should probably clarify that the page_size field is only
> valid when cfg_type is VIRTIO_PCI_CAP_SHARED_MEMORY_CFG, assuming
> that's the case. Or should the device be expected to provide the
> page_size for all capabilities regardless of type?

Only for VIRTIO_PCI_CAP_SHARED_MEMORY_CFG, I'll clarify that in the
comment.

> It seems like the name should also ideally make it clearer that this
> is page_size/4096 rather than the actual page size to avoid confusing
> device implementers.

I like your suggestion in the other email of turning this into
page_shift, which clarifies the field contents and also addresses the
need check the constrains you highlighted above. I'll do that in v2.

Thanks!
Sergio.


