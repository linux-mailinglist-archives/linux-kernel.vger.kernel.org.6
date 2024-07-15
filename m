Return-Path: <linux-kernel+bounces-251984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E85930C8C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 04:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3AE1F21058
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 02:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A2D6AB8;
	Mon, 15 Jul 2024 02:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ambvSNoi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218464C8F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 02:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721009690; cv=none; b=Qm81vVNO2iU91g2UPR4k+Vp3IVKe8uZ1wtPMLezfsZbrRp+r5ZJYddSb+qxCBsSfDlnwWKm0BmffBPNkvYr5a/HGkyQXo9KOtZb04Q30oH33vOc5rrKH1gfumdhjG7HT74R5qg4j3gaGVuMs4al4OzlhZcPH2NxRq07nxGOceAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721009690; c=relaxed/simple;
	bh=yowH7QalUapkYgHeZUVZ+f9BegeEJH4ngNknLAglrJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBQwa3POogJEbViL/7SDONXQIZzsQraemgqZcdRKgD7EIxInpIfIH2y9UM+Ivz+xH9AI+TdWxcxYKPJxYVA0GPTu0Saysh13SVI/ezQ1+Nd3j3wdp6qs1aWEbRYWfFWsWoPAHvYp8JlkRtvK5ccs9XozjUIL57rzJWw9/cDL4ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ambvSNoi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721009687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T6J84PcjdhpOh6VF/DDBtLfXI9t3OT/wsOmHTj50YU8=;
	b=ambvSNoiVY9DKo+7M7em95Kfvh0vdqxOBGNdxElzyU60a+7C9/dXdZaXcOa0ePd36z63nH
	Zz4+sSjtEp5NP8LOBoiCitjTOKkW8Ea+Kunm9P+5PHnhvYJ0AU7wryDcr3yXjEimG5yMlV
	7uWnEAJayLuDhVCc+kLvQZWbA2DnBhE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-zxPMbipdNEOsDZWnr6N0xg-1; Sun, 14 Jul 2024 22:14:44 -0400
X-MC-Unique: zxPMbipdNEOsDZWnr6N0xg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c96f6bed83so3200609a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 19:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721009683; x=1721614483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6J84PcjdhpOh6VF/DDBtLfXI9t3OT/wsOmHTj50YU8=;
        b=QuJQ5Wt6dsnF1xrIboAgi27sWJhP4j9iDhSvbbolI+SWYUqvro7lfVU//yFIVLy9jT
         khggOAdGluv42tjALbWAMlM7Fx88EBHxQ5bBsRE3oJsBAKnfHFFxpuLTwS5w7wpaiIpX
         HBsiuaERQE4czz9xWqxMqZQUFpSWfbaMO8lKKkRp5/rvpyoyZA/oqWFZYmou0WPd5K2a
         JEZlx675gLxyff7HKzOwDU6sQnsi7gFPhFLAuU4weZa/1qBtJEDvO8Blib/2XXlSbCsx
         YMa44fV5UmYbDHGr1jud2WYOYs1JSplFWKYx/ypbofrSTTImmIYK67Y0NtDIARCk0iAr
         vORQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwQoJVprKCFJZBNpsPfamfiWhDcO+RWn80HBiStwrmOyn3DAiYuztimXHgqpx2SchM6uT45cDZl8xlc5SndWsUuZa7CXQVeeP97/3J
X-Gm-Message-State: AOJu0YyftBeVkYclt5CNsxOThcgYdr/Moj3DO/owZA8ztP/9jrFp8y0K
	ByitRBvE6/WUt6NG8PqyATUMgCUIF187+v0lKtd6lKTahYZfOZJeai1PxbEEKivCTFV/c7K8PI+
	3+4PiGsPHcc8H1FmHG9q4hS7YlyDDNWhU1uPZ2A8WH1EytZPBpKsfNrcz6Nb8fMK+Zam7E0S91H
	TwFblvt2V2Er7/dakQ/dBngtpZMdVRkAzv+giu
X-Received: by 2002:a17:90b:384c:b0:2c9:752d:c007 with SMTP id 98e67ed59e1d1-2ca35c7d124mr12543378a91.29.1721009683260;
        Sun, 14 Jul 2024 19:14:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGspocBKY5h4Ykba/X8TSphcHRCAowc5kdsJBrllBcK1uqTGlzIbjTzOagJ0s7w0Xxe6h7gxFBSEq/x37ViMVE=
X-Received: by 2002:a17:90b:384c:b0:2c9:752d:c007 with SMTP id
 98e67ed59e1d1-2ca35c7d124mr12543369a91.29.1721009682769; Sun, 14 Jul 2024
 19:14:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Jul 2024 10:14:31 +0800
Message-ID: <CACGkMEs9SvtW=Dkg1aU6HuFqTP5eekD1JdR2w377u3iGsOR-Aw@mail.gmail.com>
Subject: Re: [PATCH V2 0/7] vdpa live update
To: Steve Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 9:19=E2=80=AFPM Steve Sistare <steven.sistare@oracl=
e.com> wrote:
>
> Live update is a technique wherein an application saves its state, exec's
> to an updated version of itself, and restores its state.  Clients of the
> application experience a brief suspension of service, on the order of
> 100's of milliseconds, but are otherwise unaffected.
>
> Define and implement interfaces that allow vdpa devices to be preserved
> across fork or exec, to support live update for applications such as QEMU=
.
> The device must be suspended during the update, but its DMA mappings are
> preserved, so the suspension is brief.
>
> The VHOST_NEW_OWNER ioctl transfers device ownership and pinned memory
> accounting from one process to another.
>
> The VHOST_BACKEND_F_NEW_OWNER backend capability indicates that
> VHOST_NEW_OWNER is supported.
>
> The VHOST_IOTLB_REMAP message type updates a DMA mapping with its userlan=
d
> address in the new process.
>
> The VHOST_BACKEND_F_IOTLB_REMAP backend capability indicates that
> VHOST_IOTLB_REMAP is supported and required.  Some devices do not
> require it, because the userland address of each DMA mapping is discarded
> after being translated to a physical address.
>
> Here is a pseudo-code sequence for performing live update, based on
> suspend + reset because resume is not yet widely available.  The vdpa dev=
ice
> descriptor, fd, remains open across the exec.
>
>   ioctl(fd, VHOST_VDPA_SUSPEND)
>   ioctl(fd, VHOST_VDPA_SET_STATUS, 0)

I don't understand why we need a reset after suspend, it looks to me
the previous suspend became meaningless.

>   exec
>
>   ioctl(fd, VHOST_NEW_OWNER)
>
>   issue ioctls to re-create vrings
>
>   if VHOST_BACKEND_F_IOTLB_REMAP

So the idea is for a device that is using a virtual address, it
doesn't need VHOST_BACKEND_F_IOTLB_REMAP at all?

>       foreach dma mapping
>           write(fd, {VHOST_IOTLB_REMAP, new_addr})
>
>   ioctl(fd, VHOST_VDPA_SET_STATUS,
>             ACKNOWLEDGE | DRIVER | FEATURES_OK | DRIVER_OK)

From API level, this seems to be asymmetric as we have suspending but
not resuming?

>
> This is faster than VHOST_RESET_OWNER + VHOST_SET_OWNER + VHOST_IOTLB_UPD=
ATE,
> as that would would unpin and repin physical pages, which would cost mult=
iple
> seconds for large memories.
>
> This is implemented in QEMU by the patch series "Live update: vdpa"
>   https://lore.kernel.org/qemu-devel/TBD  (reference to be posted shortly=
)
>
> The QEMU implementation leverages the live migration code path, but after
> CPR exec's new QEMU:
>   - vhost_vdpa_set_owner() calls VHOST_NEW_OWNER instead of VHOST_SET_OWN=
ER
>   - vhost_vdpa_dma_map() sets type VHOST_IOTLB_REMAP instead of
>     VHOST_IOTLB_UPDATE
>
> Changes in V2:
>   - clean up handling of set_map vs dma_map vs platform iommu in remap
>   - augment and clarify commit messages and comments
>
> Steve Sistare (7):
>   vhost-vdpa: count pinned memory
>   vhost-vdpa: pass mm to bind
>   vhost-vdpa: VHOST_NEW_OWNER
>   vhost-vdpa: VHOST_BACKEND_F_NEW_OWNER
>   vhost-vdpa: VHOST_IOTLB_REMAP
>   vhost-vdpa: VHOST_BACKEND_F_IOTLB_REMAP
>   vdpa/mlx5: new owner capability
>
>  drivers/vdpa/mlx5/net/mlx5_vnet.c |   3 +-
>  drivers/vhost/vdpa.c              | 125 ++++++++++++++++++++++++++++--
>  drivers/vhost/vhost.c             |  15 ++++
>  drivers/vhost/vhost.h             |   1 +
>  include/uapi/linux/vhost.h        |  10 +++
>  include/uapi/linux/vhost_types.h  |  15 +++-
>  6 files changed, 161 insertions(+), 8 deletions(-)
>
> --
> 2.39.3
>

Thanks


