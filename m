Return-Path: <linux-kernel+bounces-293718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 745EF958387
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0196D1F216BD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DDE18E37C;
	Tue, 20 Aug 2024 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aZMQnyCY"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5747818E355
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 10:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724148259; cv=none; b=GW8o/pLV96WJ37ZI26i3UNuvgf5QLv5NXj4Y5Ucu/x/liPCyk4wn2ZqbVwDtBJpSgiMrKSGkQpDo9no/MUeZdTZlMprjR1OYQoegM0AEJabu/yi/Jtga4gn+7ZQUfugMUmtcN3M4X9sxiQ1z0yhL9MU41wP/Bm/07uEvvhRqbJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724148259; c=relaxed/simple;
	bh=uUvJSDext6M0nkcoLRNGPClWhhDWh23u/VzRoORDXsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZcJOTn807nNXx0wKptqfm7QsfBNdHTz9Vp8wiYAoHX+Vil8JZHZpVp+p0TlB0n9/SPsi4YIbPhQk4UJWgDuLEtdjt6JjCTf3yP6UMrJl8VnDLZK3IVQUz42EEsubhI/Km1Ec6VtvF95FC61R94c30QKbRaceqswvCdQSAVeEXMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aZMQnyCY; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso5882173276.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 03:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724148256; x=1724753056; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UBjDvZ/sDAoI3c7pZR5hFVt6twxbxNuOp9fpshLzAtI=;
        b=aZMQnyCYQeW5KkAojIBNQ1E34EWVtT48h1VRj/cB2cmP0jcmpMPRDH5WDbPmVJDpld
         azeqMCp7wdclozOr5Gbu+lmmIsmPof83kqF1bXQ8q0+Y2JUUY4HqRz/gmoaixsXKeiXT
         Vf+G3AGpuqUepqfWbT7YqS4Z+OPy+GPZoNgg4xGlgBeQ+iAQAggupdWvMqp+XS0P+feQ
         c4l4dWKeBl+IN5XgGFhq0dRu3dmAai0tBiKGdt5HtLcY0xmYxIMbh6rFdmzTc9kPh6PL
         3d9chcMEJLPCicDEZJhClS0N/1UlQc7kLpKDuv397QRPZx7fPWJWuvtZAaxwsdwGMdfk
         SBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724148256; x=1724753056;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UBjDvZ/sDAoI3c7pZR5hFVt6twxbxNuOp9fpshLzAtI=;
        b=GC/ZHBBdHxAk4s0rCcl2XLo50+JrYKtZZn4IUwqJ3Hmjs6WUNGg/gMuQCO9Yrg1Iyw
         pQEHjuboy+radamIaC+9jWGgtZSFTFK7BVfCmOuHA7oglC2EGC8Hba1Uk9X9ayYXamPm
         HEKuz+JzsTZ90mihvP0jwsj0kbY86EethSLd3Rj9O0mERls1KWNZnP9f5nhOZLnk/UNa
         ug3VrHLHqzUfRKH1TYAgjq3V/s9mdX9CRT5SUZoj42pEnZlfwCqhruzK31Sn1XRq1D1y
         VeT5tJADXgKs7qBWaQbkQd+nFaKsMhwboJ/GSJ43nwyi1J1KEQAxGy3jKLQUzenxS80T
         y45w==
X-Gm-Message-State: AOJu0YxTL8yr0z4LKdTlpo3qM4vb9FfhHFAxu218fzbYqX+ZpWAap/Wj
	ho6lxoAoc0rAGpg1BmjgwQWPX5BVmNUPd+XtjfmMqZtbJPz7LW/h2WaqgzjRTzFCHdu3w+gxKSX
	h9lEtt4tJMC7iY2gzM6B0dss8q8qVk/QHNcLNEw==
X-Google-Smtp-Source: AGHT+IHBNMgDes/xOrSYTcAxVAiCQ63pEe0mawlXoCrl1I1mciCmsCuuB1UsOINdhPNlL2/rofQb0GrTwKYlnNu5aVM=
X-Received: by 2002:a05:6902:11c9:b0:e0b:fa84:5839 with SMTP id
 3f1490d57ef6-e1650d0e422mr2420853276.8.1724148256125; Tue, 20 Aug 2024
 03:04:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240707160555.78062-1-krashmisha@gmail.com>
In-Reply-To: <20240707160555.78062-1-krashmisha@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 20 Aug 2024 12:03:38 +0200
Message-ID: <CAPDyKFpQ-GoxuvL7DvxJR6R77Re8UFXkhcAhjz0wKoC4RuRLFA@mail.gmail.com>
Subject: Re: [PATCH RFC v2] mmc/virtio: Add virtio MMC driver for QEMU emulation
To: Mikhail Krasheninnikov <krashmisha@gmail.com>
Cc: linux-kernel@vger.kernel.org, Matwey Kornilov <matwey.kornilov@gmail.com>, 
	linux-mmc@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 7 Jul 2024 at 18:06, Mikhail Krasheninnikov
<krashmisha@gmail.com> wrote:
>
> Introduce a new virtio MMC driver to enable virtio SD/MMC card
> emulation with QEMU. This driver allows emulating MMC cards in
> virtual environments, enhancing functionality and testing
> capabilities within QEMU.
>
> Link to the QEMU patch:
> https://lists.nongnu.org/archive/html/qemu-block/2024-07/msg00221.html
>
> No changes to existing dependencies or documentation.
>
> Signed-off-by: Mikhail Krasheninnikov <krashmisha@gmail.com>
> CC: Matwey Kornilov <matwey.kornilov@gmail.com>
> CC: Ulf Hansson <ulf.hansson@linaro.org>
> CC: linux-mmc@vger.kernel.org
> CC: "Michael S. Tsirkin" <mst@redhat.com>
> CC: Jason Wang <jasowang@redhat.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> CC: virtualization@lists.linux-foundation.org

Sorry for the delay. Can you please re-spin/post this to add Adrian
Hunter, the sdhci maintainer.

Moreover, it would be nice to get some from the virtio folkz to review
this too. My comments at this point are mostly nitpicks. Please see
below.

>
> ---
> Changes from v1:
>  - Add MAINTAINERS entry
>  - Refactor includes
>  - Change CPU endian format to little endian for device communication
>  - Move structs that belonged to uapi
>  - Validate multiple fields
>  - Introduce mutexes for safe request handling
>  - Call virtio_device_ready before adding host
>  - Fix removal of the device
>
>  MAINTAINERS                       |  15 ++
>  drivers/mmc/host/Kconfig          |  14 ++
>  drivers/mmc/host/Makefile         |   2 +
>  drivers/mmc/host/virtio-sdhci.c   | 258 ++++++++++++++++++++++++++++++
>  drivers/mmc/host/virtio-sdhci.h   |  40 +++++
>  include/uapi/linux/virtio-sdhci.h |  39 +++++

Please rename to sdhci-virtio.* and update the corresponding prefix of
the function names accordingly.

>  include/uapi/linux/virtio_ids.h   |   1 +
>  7 files changed, 369 insertions(+)
>  create mode 100644 drivers/mmc/host/virtio-sdhci.c
>  create mode 100644 drivers/mmc/host/virtio-sdhci.h
>  create mode 100644 include/uapi/linux/virtio-sdhci.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dd5de540ec0b..be86156cd66c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22907,6 +22907,21 @@ S:     Maintained
>  F:     drivers/nvdimm/nd_virtio.c
>  F:     drivers/nvdimm/virtio_pmem.c
>
> +VIRTIO SDHCI DRIVER
> +M:     Mikhail Krasheninnikov <krashmisha@gmail.com>
> +M:     "Michael S. Tsirkin" <mst@redhat.com>
> +M:     Jason Wang <jasowang@redhat.com>
> +M:     Paolo Bonzini <pbonzini@redhat.com>
> +M:     Stefan Hajnoczi <stefanha@redhat.com>
> +M:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> +L:     virtualization@lists.linux-foundation.org
> +L:     linux-mmc@vger.kernel.org
> +L:     OASIS-virtio@ConnectedCommunity.org
> +S:     Maintained
> +F:     drivers/mmc/host/virtio-sdhci.c
> +F:     drivers/mmc/host/virtio-sdhci.h
> +F:     include/uapi/linux/virtio-sdhci.h
> +
>  VIRTIO SOUND DRIVER
>  M:     Anton Yakovlev <anton.yakovlev@opensynergy.com>
>  M:     "Michael S. Tsirkin" <mst@redhat.com>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 554e67103c1a..d62d669ee117 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -1069,3 +1069,17 @@ config MMC_LITEX
>           module will be called litex_mmc.
>
>           If unsure, say N.
> +
> +config SDHCI_VIRTIO
> +       tristate "VirtIO SDHCI Host Controller support"
> +       depends on VIRTIO
> +       help
> +         This enables support for the Virtio SDHCI driver, which allows the
> +         kernel to interact with SD/MMC devices over Virtio. Virtio is a
> +         virtualization standard for network and disk device drivers,
> +         providing a common API for virtualized environments.
> +
> +         Enable this option if you are running the kernel in a virtualized
> +         environment and need SD/MMC support via Virtio.
> +
> +         If unsure, say N.
> \ No newline at end of file
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index a693fa3d3f1c..f9b05a07c6db 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -108,3 +108,5 @@ endif
>
>  obj-$(CONFIG_MMC_SDHCI_XENON)  += sdhci-xenon-driver.o
>  sdhci-xenon-driver-y           += sdhci-xenon.o sdhci-xenon-phy.o
> +
> +obj-$(CONFIG_SDHCI_VIRTIO)     += virtio-sdhci.o
> \ No newline at end of file
> diff --git a/drivers/mmc/host/virtio-sdhci.c b/drivers/mmc/host/virtio-sdhci.c
> new file mode 100644
> index 000000000000..1a637ab5e010
> --- /dev/null
> +++ b/drivers/mmc/host/virtio-sdhci.c
> @@ -0,0 +1,258 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  VirtIO SD/MMC driver
> + *
> + *  Author: Mikhail Krasheninnikov <krashmisha@gmail.com>
> + */
> +
> +#include "virtio-sdhci.h"
> +#include "linux/mmc/host.h"
> +#include "linux/virtio.h"
> +#include "linux/virtio_config.h"
> +#include "linux/completion.h"
> +#include "uapi/linux/virtio-sdhci.h"
> +
> +struct virtio_sdhci_host {
> +       struct virtio_device *vdev;
> +       struct mmc_host *mmc;
> +       struct virtqueue *vq;
> +       struct mmc_request *current_request;
> +
> +       struct virtio_mmc_request virtio_request;
> +       struct virtio_mmc_response virtio_response;
> +
> +       struct completion request_handled;
> +       spinlock_t handling_request;
> +};
> +
> +static void virtio_sdhci_vq_callback(struct virtqueue *vq)
> +{
> +       unsigned int len;
> +       struct mmc_host *mmc;
> +       struct virtio_sdhci_host *host;
> +       struct virtio_mmc_request *virtio_request;
> +       struct virtio_mmc_response *virtio_response;
> +       struct mmc_request *mrq;
> +
> +       mmc = vq->vdev->priv;
> +       host = mmc_priv(mmc);
> +       mrq = host->current_request;
> +       virtio_request = &host->virtio_request;
> +
> +       virtio_response = virtqueue_get_buf(vq, &len);
> +
> +       if (!virtio_response)
> +               return;
> +
> +       memcpy(mrq->cmd->resp, virtio_response->cmd_resp,
> +              min(4 * (int)sizeof(u32), virtio_response->cmd_resp_len));
> +
> +       if (virtio_request->flags & VIRTIO_MMC_REQUEST_DATA) {
> +               mrq->data->bytes_xfered =
> +                       min((unsigned int)virtio_request->buf_len,
> +                           mmc->max_blk_size);
> +
> +               if (!(virtio_request->flags & VIRTIO_MMC_REQUEST_WRITE)) {
> +                       sg_copy_from_buffer(mrq->data->sg, mrq->data->sg_len,
> +                                           virtio_response->buf,
> +                                           mrq->data->bytes_xfered);
> +               }
> +       }
> +
> +       complete(&host->request_handled);
> +}
> +
> +static void virtio_sdhci_send_and_recv_request_from_qemu(struct virtio_sdhci_host *data)
> +{
> +       struct scatterlist sg_out_linux, sg_in_linux;
> +
> +       sg_init_one(&sg_out_linux, &data->virtio_request,
> +                   sizeof(struct virtio_mmc_request));
> +       sg_init_one(&sg_in_linux, &data->virtio_response,
> +                   sizeof(struct virtio_mmc_response));
> +
> +       struct scatterlist *request[] = { &sg_out_linux, &sg_in_linux };
> +
> +       if (virtqueue_add_sgs(data->vq, request, 1, 1, &data->virtio_response,
> +                             GFP_KERNEL) < 0) {
> +               dev_crit(&data->vdev->dev, "Failed to add sg\n");
> +               return;
> +       }
> +
> +       virtqueue_kick(data->vq);
> +       wait_for_completion(&data->request_handled);
> +}
> +
> +static inline size_t __calculate_len(struct mmc_data *data)

Please keep the prefix of the function names. This applies to the
remaining functions too.

> +{
> +       size_t len = 0;
> +
> +       for (int i = 0; i < data->sg_len; i++)
> +               len += data->sg[i].length;
> +       return len;
> +}

[...]

> +static int create_host(struct virtio_device *vdev)
> +{
> +       int err;
> +       struct mmc_host *mmc;
> +       struct virtio_sdhci_host *host;
> +
> +       mmc = mmc_alloc_host(sizeof(struct virtio_sdhci_host), &vdev->dev);
> +       if (!mmc) {
> +               pr_err("virtio_mmc: Failed to allocate host\n");
> +               return -ENOMEM;
> +       }
> +
> +       __fill_host_attr(mmc);
> +
> +       vdev->priv = mmc;
> +
> +       host = mmc_priv(mmc);
> +       host->vdev = vdev;
> +
> +       spin_lock_init(&host->handling_request);
> +       init_completion(&host->request_handled);
> +
> +       host->vq =
> +               virtio_find_single_vq(vdev, virtio_sdhci_vq_callback, "vq_name");
> +       if (!host->vq) {
> +               pr_err("virtio_mmc: Failed to find virtqueue\n");
> +               mmc_free_host(mmc);
> +               return -ENODEV;
> +       }
> +
> +       virtio_device_ready(vdev);
> +
> +       err = mmc_add_host(mmc);
> +       if (err) {
> +               pr_err("virtio_mmc: Failed to add host\n");
> +               mmc_free_host(mmc);
> +               return err;
> +       }

sdhci provides various library functions to add/allocate and
free/remove a host. Please try to use them.

> +
> +       return 0;
> +}

[...]

> diff --git a/drivers/mmc/host/virtio-sdhci.h b/drivers/mmc/host/virtio-sdhci.h
> new file mode 100644
> index 000000000000..db35268e7b64
> --- /dev/null
> +++ b/drivers/mmc/host/virtio-sdhci.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + *  VirtIO SD/MMC driver
> + *
> + *  Author: Mikhail Krasheninnikov <krashmisha@gmail.com>
> + */
> +
> +#ifndef _VIRTIO_MMC_H
> +#define _VIRTIO_MMC_H
> +
> +#include <linux/virtio.h>
> +#include <linux/virtio_ids.h>
> +
> +static int virtio_sdhci_probe(struct virtio_device *vdev);
> +
> +static void virtio_sdhci_remove(struct virtio_device *vdev);
> +
> +static const struct virtio_device_id id_table[] = {
> +       { VIRTIO_ID_SDHCI, VIRTIO_DEV_ANY_ID },
> +       { 0 },
> +};
> +
> +static struct virtio_driver virtio_sdhci_driver = {
> +       .driver = {
> +               .name   = KBUILD_MODNAME,
> +               .owner  = THIS_MODULE,
> +       },
> +       .id_table       = id_table,
> +       .probe          = virtio_sdhci_probe,
> +       .remove         = virtio_sdhci_remove,
> +};
> +
> +module_virtio_driver(virtio_sdhci_driver);
> +MODULE_DEVICE_TABLE(virtio, id_table);
> +
> +MODULE_AUTHOR("Mikhail Krasheninnikov");
> +MODULE_DESCRIPTION("VirtIO SD/MMC driver");
> +MODULE_LICENSE("GPL");

Looks like all the code in the header file above belongs in the c-file
instead, along with the other static declarations.

> +
> +#endif
> diff --git a/include/uapi/linux/virtio-sdhci.h b/include/uapi/linux/virtio-sdhci.h
> new file mode 100644
> index 000000000000..751ed215bc61
> --- /dev/null
> +++ b/include/uapi/linux/virtio-sdhci.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + *  VirtIO SD/MMC driver
> + *
> + *  Author: Mikhail Krasheninnikov <krashmisha@gmail.com>
> + */
> +#ifndef _LINUX_VIRTIO_MMC_H
> +#define _LINUX_VIRTIO_MMC_H
> +#include <linux/types.h>
> +
> +struct mmc_req {
> +       __le32 opcode;
> +       __le32 arg;
> +};
> +
> +struct virtio_mmc_request {
> +       u8 flags;
> +
> +#define VIRTIO_MMC_REQUEST_DATA BIT(1)
> +#define VIRTIO_MMC_REQUEST_WRITE BIT(2)
> +#define VIRTIO_MMC_REQUEST_STOP BIT(3)
> +#define VIRTIO_MMC_REQUEST_SBC BIT(4)
> +
> +       struct mmc_req request;
> +
> +       u8 buf[4096];
> +       __le32 buf_len;
> +
> +       struct mmc_req stop_req;
> +       struct mmc_req sbc_req;
> +};
> +
> +struct virtio_mmc_response {
> +       __le32 cmd_resp[4];
> +       int cmd_resp_len;
> +       u8 buf[4096];
> +};

Without a more in-depth review, I can't judge whether the above
user-space interface makes sense.

As I also said earlier, it would be nice to get some more virtio
people involved in the review process, especially to have a closer
look at the user-space interface above.

> +
> +#endif /* _LINUX_VIRTIO_MMC_H */
> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
> index 7aa2eb766205..6de8d432db7f 100644
> --- a/include/uapi/linux/virtio_ids.h
> +++ b/include/uapi/linux/virtio_ids.h
> @@ -68,6 +68,7 @@
>  #define VIRTIO_ID_AUDIO_POLICY         39 /* virtio audio policy */
>  #define VIRTIO_ID_BT                   40 /* virtio bluetooth */
>  #define VIRTIO_ID_GPIO                 41 /* virtio gpio */
> +#define VIRTIO_ID_SDHCI         42 /* virtio mmc */
>
>  /*
>   * Virtio Transitional IDs
> --
> 2.34.1
>

Kind regards
Uffe

