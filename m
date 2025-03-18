Return-Path: <linux-kernel+bounces-565231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7D6A66418
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 01:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E63817A76B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 00:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D801311AC;
	Tue, 18 Mar 2025 00:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6GmjMOC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0810D18E1A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 00:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742258940; cv=none; b=c7Dde2azMECF1UhPRjw5UATzPti/Z6WR2ZnxgW4DfcCO0tZ3vk9LyUgruuKPoIpeWIYrE4AhTDQT70Eh2bZqGGZd5OpTIKu7mJptcHWFH0ENmB3rmA0BqcMCEREjyddna5XcgcrH7y7N27C/ICHxQrOS2KHjLo1Ce5WOjn5zJhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742258940; c=relaxed/simple;
	bh=747T9jLSqH8bFgDb72pde2D+kt0cpKYYu/2oRmA4qo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c99dyLHepnzSsxui/9yQ7n/M2zJVRSC++p5zaaJaeW4hgsPQaWBaU2MUC7QCEylwBHWi6dXwFbXkC+gEOI/lOFUhHeEx9cSaPmGtpV9rejr0rD7/kwBYhXHhZ3pcBohi8+rwLG0Q/6P6uy5EugiqoTa2cvFef7tQkcyUiGW33CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S6GmjMOC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742258938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nlAq9ja2RSbJ2WExbn5JQkIBqDsE/3iSsVzG9YVP7BE=;
	b=S6GmjMOCYUXb41wbLeGx2xDR20unaiSm6PBbeYwoYWmZKGDzUa6xAIkHjGlzfD7K/vMxbo
	Fsyb7PxDbpTCVfLUPIt0uzxQXrmyBQBA1jR/8u8fBVwlHTlbD04LcIMxK39Kb/xrOh3lfa
	e9d32M/zkUOvqVhqh6KGl5Yvm8R3+RA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-KmM6bqAePAmaYnObn_CkuA-1; Mon, 17 Mar 2025 20:48:56 -0400
X-MC-Unique: KmM6bqAePAmaYnObn_CkuA-1
X-Mimecast-MFC-AGG-ID: KmM6bqAePAmaYnObn_CkuA_1742258935
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff798e8c3bso4604622a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742258935; x=1742863735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlAq9ja2RSbJ2WExbn5JQkIBqDsE/3iSsVzG9YVP7BE=;
        b=Ggbz6Eoc8DgtIk/ZirSQWVOC3BLWGEwzwxAxuX8cBMzSXXC0is21EI71xLJgQW0CO3
         zSlQsWXZ4bJ0jAwpyL8WqvaWyUQrS9Z21yCqpnK8QBOoGOHtm8m4Ol5zehS8ckWHfQfb
         hikVg6/jIt1txXtZR/KHwt3LeHcZgE7pXlkMM3QLdeoKrq2pCm8xdH8W9FEu4X017SBr
         qi5ezt4BciwuPYh0k4e8V2PRQqB7Del7rmvbQ3vbIQinrK1D8nGtzDvBvkJWuMZNMjAM
         jpdBpkRTDJ3/VgjSuqkv0pMmbpWP0f203PnxdZ2AX1bZj1McowDtm2ovkCm4IP4noZz3
         YtWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqRRUjoNp4lpPp9lEr7eHJ36eghq3PE6MJavmvrQoyJiLo4qvm3VXxuqQbCzpALoRSTa5zOuo6jYTfpwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNfN4fPYpzlO/XyX5IL2cyyNXbJQ0PdMGyHfsh84gn1FnSER9V
	+hX8J1yEM+boDN2N7bZArbAVY3o1747DCn+QpAhHxcN53zf5qJtHm7kK8I6ev9maRw0KXik6x5b
	5y2X3czGYFPfhlzgZfmTpmhM4/5i+25C/wyfEgw0/Sig6paApH8mJZ0mIzKP7kciu0s9oCoTz4A
	x0RObo82/BWrg8xKafoLtwEMUIiP98bV2xo6LR
X-Gm-Gg: ASbGnctovkHnpsg8OxyRaalLc3G848CCXyaVMoWRNrM6/b9/V/1wLyweybPT9NECG4r
	ba5TosKK5Tes/hsApHrnBqU+362UxXrOHSjWULgtRoSu8BdGcSxTD35a4Go8ZQ/bWCDqN6A==
X-Received: by 2002:a17:90b:4b10:b0:2ee:741c:e9f4 with SMTP id 98e67ed59e1d1-301a5b1313fmr486192a91.11.1742258935179;
        Mon, 17 Mar 2025 17:48:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjSE8bZtH24Q4k70pqmCF3Pl5ZG79aTMFklPXXWxS7VadnbTFOusaQmH8Wzxx/kb4T1iFplzJMw+APpySRBkg=
X-Received: by 2002:a17:90b:4b10:b0:2ee:741c:e9f4 with SMTP id
 98e67ed59e1d1-301a5b1313fmr486162a91.11.1742258934866; Mon, 17 Mar 2025
 17:48:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317235546.4546-1-dongli.zhang@oracle.com> <20250317235546.4546-3-dongli.zhang@oracle.com>
In-Reply-To: <20250317235546.4546-3-dongli.zhang@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Mar 2025 08:48:42 +0800
X-Gm-Features: AQ5f1JrAlxtKtwUtKRrW-cmJuRCs9VYdUge7DAbLNhWk3XLXSW2HZUWTJOSqcLg
Message-ID: <CACGkMEuhqbxr-20Jghn10fWH+pCAVih_KvWU6Mj+FXgE6TOTVA@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] vhost-scsi: Fix vhost_scsi_send_bad_target()
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, mst@redhat.com, michael.christie@oracle.com, 
	pbonzini@redhat.com, stefanha@redhat.com, eperezma@redhat.com, 
	joao.m.martins@oracle.com, joe.jin@oracle.com, si-wei.liu@oracle.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 7:52=E2=80=AFAM Dongli Zhang <dongli.zhang@oracle.c=
om> wrote:
>
> Although the support of VIRTIO_F_ANY_LAYOUT + VIRTIO_F_VERSION_1 was
> signaled by the commit 664ed90e621c ("vhost/scsi: Set
> VIRTIO_F_ANY_LAYOUT + VIRTIO_F_VERSION_1 feature bits"),
> vhost_scsi_send_bad_target() still assumes the response in a single
> descriptor.
>
> In addition, although vhost_scsi_send_bad_target() is used by both I/O
> queue and control queue, the response header is always
> virtio_scsi_cmd_resp. It is required to use virtio_scsi_ctrl_tmf_resp or
> virtio_scsi_ctrl_an_resp for control queue.
>
> Fixes: 664ed90e621c ("vhost/scsi: Set VIRTIO_F_ANY_LAYOUT + VIRTIO_F_VERS=
ION_1 feature bits")
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
> Changed since v1:
>   - Move this bugfix patch to before dirty log tracking patches.
>
>  drivers/vhost/scsi.c | 48 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 37 insertions(+), 11 deletions(-)
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


