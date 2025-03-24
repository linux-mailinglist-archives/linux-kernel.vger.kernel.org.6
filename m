Return-Path: <linux-kernel+bounces-574320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8477A6E3DA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 20:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FCCE3B0180
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3991A3156;
	Mon, 24 Mar 2025 19:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CRg2drOc"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9865195FEF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 19:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742846040; cv=none; b=D8dB1/9lGkmevg86RU6fCygU/WEToJYqFAO9CB4fz6MYwptAfVvDgIRNtCFrAs5Q5IJ38w8+bDY1Obm9XhIj6npMwRy2HS84EBx5od57Wtc8AWQSzbu7WW67DqRa6Wg7f+nWVFLiz8CIgXD34YC5EKrjyJ5pVhUaeoFd3xowtdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742846040; c=relaxed/simple;
	bh=u5NQ/BAm881tOnqIxN0/hFBR2wZjfr8cxBjCMGnGSlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFxtw63y/l2SfedkRf+BEdqqXvhzSS9Mb8yj7So37g1z4wgOPBNQYRkanZ7fEus8NX9w+bPRGNYgzvr6L0dnG6PTRnrkQEyd+YXnd9a/J8QIMyWGEPo0kqatd3Fsph1lk2ZTUarP2ewM4FqaJE7WNA2SzZOBvpQ/3ZgB6+NXMic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CRg2drOc; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-224104a9230so10671035ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 12:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742846038; x=1743450838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NINTTnuRREaCij9WQdNsTWv0nTZM+LnALUAf/adBLFU=;
        b=CRg2drOclX4m/fYtr0k46EFtt7vUyRcTP4ArEzqPox3m4ah9Tmt6wE6dyHZh0jKel1
         SDExzN+blfO78S/75K+cxoy13w8zh0I3LtOKtPMoxkeyK2AdyYx3yWt3ooNKPZrmk5S7
         vzSfB0g2UMnIvcxqERB3nhkR/KYHKcPR+s0ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742846038; x=1743450838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NINTTnuRREaCij9WQdNsTWv0nTZM+LnALUAf/adBLFU=;
        b=uFVIcvufZoMcnbbCDnJTLHbQe4zP9X2xZsuDeNR0IU5RUz6mxsN5SZr2bX/4FsQfz7
         DhEWKNwTF7Y6uYKYiRBTN4gjIoqR3buZcki79yK2lTi54E5JAgm+yRDlK6H65wN6Sfqh
         OjWiXo9X1D6Oqoy965wzPFgrBezhHsX4VnZRSEswlgvmgNMA7h5pGPiQsd6dBphQePPu
         fLQiy7f/SsmP3YEzUhhDlg8JI6u7pRbVdtWT6HF/fLOLh2n2nqca6YI+zfdzihU3pOPm
         G6CQzwVf4JKqcuiNJTyjQeqzTUNW+hJI3yr6fOEYt8WQr5Yl5tdVzxSrtSzKfb8O2wPf
         /yAQ==
X-Gm-Message-State: AOJu0Yzc8KxIVLICybOv98X9yprFpEsLXNNqYndlz6W3VY6XFuiwWbc8
	ydLs19odxa484s+0XXWMoJ97tDqpUMRpJDD3tEo4oZaRWpit/FcSjcoxasvY4u6WBI01zPPR4w4
	=
X-Gm-Gg: ASbGncsbzXXEVY32s4IzqT3hfAreks9i5NrbzNHAyvmM2GNeDvl0gdpJhrhFXIOOdFP
	TrVho4kL/ozJC+wCDqE2CDQZ1Y2hMbjlFyZr483eBdA/AQdpGDcsoZVliYjkeoidHjBwwvzqlT5
	aNUyw2Qra8yxggkr8fSO6Jc5xMP+CP2PLKsuf/JxlILaPOFtou+M+9n20VA/T6bzsceAuVZykZX
	rUWBSNd8/teV0XOgNX7pmTJ6I6Em4jmK9n1eUfedr6j7Mwl4sqf/HFDua641ferHzfH/rDc0dqi
	t0iQQJ7rqTOnGQ4WQoCCDHyszWBsReUHbyKpHCsiD+zyhsyKNk9mmq7hMlUNCBBSkdnVtdYT7Jb
	8iXYyr/yG
X-Google-Smtp-Source: AGHT+IFOkKV06XiGIzPFIsX0oclR3i54tA4ZPPqS+zSriJTzn7m7GB69bCTNFpjeSHy3PmvrbiE2xQ==
X-Received: by 2002:a05:6a00:ac8:b0:730:9a85:c931 with SMTP id d2e1a72fcca58-73905a515d0mr8261879b3a.7.1742846037601;
        Mon, 24 Mar 2025 12:53:57 -0700 (PDT)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com. [209.85.216.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fd564fsm8739318b3a.52.2025.03.24.12.53.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 12:53:56 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-301918a4e3bso8858555a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 12:53:56 -0700 (PDT)
X-Received: by 2002:a17:90b:3c43:b0:2fa:137f:5c61 with SMTP id
 98e67ed59e1d1-3030fe856edmr26859916a91.12.1742846035557; Mon, 24 Mar 2025
 12:53:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324144300.905535-1-maxbr@linux.ibm.com>
In-Reply-To: <20250324144300.905535-1-maxbr@linux.ibm.com>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Mon, 24 Mar 2025 12:53:29 -0700
X-Gmail-Original-Message-ID: <CABVzXAn1iNHP_8h-sj1mTJDuu9dxOBhwi+nbhhr9d27NTo-6wg@mail.gmail.com>
X-Gm-Features: AQ5f1Jr8NkPVuPg1PsgQ4_ODpRqhP97dQpSu7kwfiH-2QqcmVeUNUWXdtuP21V8
Message-ID: <CABVzXAn1iNHP_8h-sj1mTJDuu9dxOBhwi+nbhhr9d27NTo-6wg@mail.gmail.com>
Subject: Re: [PATCH] virtio_console: fix order of fields cols and rows
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	mst@redhat.com, pasic@linux.ibm.com, amit@kernel.org, schnelle@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 7:43=E2=80=AFAM Maximilian Immanuel Brandtner
<maxbr@linux.ibm.com> wrote:
>
> According to section 5.3.6.2 (Multiport Device Operation) of the virtio
> spec(version 1.2) a control buffer with the event VIRTIO_CONSOLE_RESIZE
> is followed by a virtio_console_resize struct containing cols then rows.
> The kernel implements this the wrong way around (rows then cols) resultin=
g
> in the two values being swapped.
>
> Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
> ---
>  drivers/char/virtio_console.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.=
c
> index 21de774996ad..38af3029da39 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1579,8 +1579,8 @@ static void handle_control_message(struct virtio_de=
vice *vdev,
>                 break;
>         case VIRTIO_CONSOLE_RESIZE: {
>                 struct {
> -                       __virtio16 rows;
>                         __virtio16 cols;
> +                       __virtio16 rows;
>                 } size;

The order of the fields after the patch matches the spec, so from that
perspective, looks fine:
Reviewed-by: Daniel Verkamp <dverkamp@chromium.org>

Since the driver code has been using the wrong order since support for
this message was added in 2010, but there is no support for sending
this message in the current qemu device implementation, I wondered
what device code was used to test this when it was originally added. I
dug up what I assume is the corresponding qemu device change from the
same era, which sends the VIRTIO_CONSOLE_RESIZE message using the
rows, cols order that matches the kernel driver (and differs from the
spec):

https://lore.kernel.org/qemu-devel/1273092505-22783-1-git-send-email-amit.s=
hah@redhat.com/
("[Qemu-devel] [PATCH] virtio-serial: Send per-console port resize
notifications to guest", May 6, 2010)

However, I don't believe that patch ever made it into an actual qemu
release, so it's probably not a compatibility concern. (If there are
any other device implementations that use the kernel driver order
rather than the spec order, then maybe this would need more
consideration, but I don't personally know of any.)

Thanks,
-- Daniel

