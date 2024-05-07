Return-Path: <linux-kernel+bounces-170779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA028BDBEF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 08:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC50828395E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 06:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9F479B8E;
	Tue,  7 May 2024 06:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPh5ylTa"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FF778C91
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 06:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715064983; cv=none; b=eqoGGFFwCkqhAHqVMrWP2sLYbilfI6j3tqk7cQfb6kPbQpwA2+M/6Wdxhw3XWA90/DFnpBqJWt33xQwJNJcgOBR198r0RQtZzU397I4T060odUKPFwxsEGXntI6L2MpvachVS2tvTkhktUOGNKLuY8+dk5OhxAwYj3HA1YJI9yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715064983; c=relaxed/simple;
	bh=srNF1To/gkrtW+OMU1GPxXVRf2tkwKaLhSiYRijk9os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D2X93QCbgiHvQZmrOWfA1THW/UcHWV3U6kzv7SZMminifZNoxzvU0rokwwNMQCZCNlrbcI6NzWAecZeKNMWcZ8Ayx+WYaWZIBCf9Jw9BZg3N+Li35GOJeX+JZGm2owYJInDnC9pwhfTaytPJtmg1rR4E55d0xCKvTDux0avGwFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPh5ylTa; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4df3d1076b0so680688e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 23:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715064980; x=1715669780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brFAlWc3o5xAeQcntdmVz1rSXR23wEs67uDjVrMmI+c=;
        b=TPh5ylTajPjaiHmZeVKIAU+g+nOVZ6+cA8TDKBbcABaeGTBZ9ssUZlO39lk1yxKlZQ
         dUyIRORp30zD6TgcWCV9cy7/6G5Uxf7icwwWZNfnioyrcZYaELr/6fRPc2ahXTBm5pPR
         W3Rqg+W0t+0ld5C+8OXMWVlnd0uronqo1V/UQMMxRQtKCngF7B3PB6rjc6hOmwmN5zVP
         cuRIHgfkDD2joeWx81JkvOZ2DL9mWyJc+2mTBzpTvWuFjjrP8OWOAuv49F7eOy1/vlSZ
         du22Xot6VFMGwy8k/ZmRECckn4qAnDR5OkYfguTv/vf0hlGK4SaryvNfRXnwbJ6025L9
         o8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715064980; x=1715669780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brFAlWc3o5xAeQcntdmVz1rSXR23wEs67uDjVrMmI+c=;
        b=shdYndl0RXwCRja+39LcJoIm/gPHU+qAmdhEk7IZ3Ka0Jk/9SX6li7bHUwGjme4w0Y
         0ZQHp0r+oKb9e7DQJo9cVZe/L4mhufxTvyFWtMmRhD0Xcn4sfoc0/m+gy0GONbdLDfQC
         3kVtmpC04OekRR6xNM+FDppLFJY2UYyKJjD7HasEv34KI4KnxpohFhGzqNs4vnSBVi6c
         Ipl/5SBfBNpeJX4HFvOi5uPT5s7PXc+ty7tF7Rtn3Rm6RNSaRBwqZqn2hvy/fBqfMxtj
         olCI8ykZzJQ3FH6xw5rKJabVN1AeMcnWWCQum21Bt2IR7vNELk4ycKhLIjIcnB8SUfua
         DN+g==
X-Forwarded-Encrypted: i=1; AJvYcCUC6dgfDxsAIYZ4TDlahIEEAwAM/2WEhDGtvoSAbSUaud1OrC9UeI86YvgjFB1aZkG6MqpzXLNat5nIKf+Hnh3b5QVeYYvidnfq+ahg
X-Gm-Message-State: AOJu0YwkvXtvtArSOw5tQOisKfAMdA/VzkiZ2pvkivOAzCgsvEwhoswB
	gnT2522sU2VC4B5gSJCE2Y4IEMZU10nPL31nmrqK8Y9XLD7bpKve4R87rNnJx6CUtwN//THttNg
	6O7w2BOehNs2ebG6D3EKaUWA9aW6sgKQP
X-Google-Smtp-Source: AGHT+IGl4EuHv0dRyoYb7H94b3WfThdmu6cVTyFbEUFr+1l351FibZu0HRnT2kV8alRFt46cOwR2zquwVuU8oSwmbnU=
X-Received: by 2002:a05:6122:3293:b0:4df:18b1:c1a2 with SMTP id
 cj19-20020a056122329300b004df18b1c1a2mr11632483vkb.11.1715064977496; Mon, 06
 May 2024 23:56:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240504114713.567164-1-pchelkin@ispras.ru> <20240504114713.567164-5-pchelkin@ispras.ru>
In-Reply-To: <20240504114713.567164-5-pchelkin@ispras.ru>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 7 May 2024 18:56:06 +1200
Message-ID: <CAGsJ_4xo6rxO=twFVL1w6D2ht+8BRmB5816zPaptE9v3SoYA-w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] dma-mapping: benchmark: handle NUMA_NO_NODE correctly
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Xiang Chen <chenxiang66@hisilicon.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 4, 2024 at 11:48=E2=80=AFPM Fedor Pchelkin <pchelkin@ispras.ru>=
 wrote:
>
> cpumask_of_node() can be called for NUMA_NO_NODE inside do_map_benchmark(=
)
> resulting in the following sanitizer report:
>
> UBSAN: array-index-out-of-bounds in ./arch/x86/include/asm/topology.h:72:=
28
> index -1 is out of range for type 'cpumask [64][1]'
> CPU: 1 PID: 990 Comm: dma_map_benchma Not tainted 6.9.0-rc6 #29
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
> Call Trace:
>  <TASK>
> dump_stack_lvl (lib/dump_stack.c:117)
> ubsan_epilogue (lib/ubsan.c:232)
> __ubsan_handle_out_of_bounds (lib/ubsan.c:429)
> cpumask_of_node (arch/x86/include/asm/topology.h:72) [inline]
> do_map_benchmark (kernel/dma/map_benchmark.c:104)
> map_benchmark_ioctl (kernel/dma/map_benchmark.c:246)
> full_proxy_unlocked_ioctl (fs/debugfs/file.c:333)
> __x64_sys_ioctl (fs/ioctl.c:890)
> do_syscall_64 (arch/x86/entry/common.c:83)
> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
>
> Use cpumask_of_node() in place when binding a kernel thread to a cpuset
> of a particular node.
>
> Note that the provided node id is checked inside map_benchmark_ioctl().
> It's just a NUMA_NO_NODE case which is not handled properly later.
>
> Found by Linux Verification Center (linuxtesting.org).
>
> Fixes: 65789daa8087 ("dma-mapping: add benchmark support for streaming DM=
A APIs")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

We've never actually accessed the content of cpu_mask when node
equals NUMA_NO_NODE because we always have the condition if (node !=3D
NUMA_NO_NODE) before accessing it. Therefore, the reported failure isn't
actually an issue. However, the underlying concept is correct, hence,

Acked-by: Barry Song <baohua@kernel.org>

I also noticed some arch have fixed up cpumask_of_node itself.
#define cpumask_of_node(node)   ((node) =3D=3D -1 ?                        =
 \
                                 cpu_all_mask :                         \
                                 &hub_data(node)->h_cpus)

> ---
>  kernel/dma/map_benchmark.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index 9f6c15f3f168..4950e0b622b1 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -101,7 +101,6 @@ static int do_map_benchmark(struct map_benchmark_data=
 *map)
>         struct task_struct **tsk;
>         int threads =3D map->bparam.threads;
>         int node =3D map->bparam.node;
> -       const cpumask_t *cpu_mask =3D cpumask_of_node(node);
>         u64 loops;
>         int ret =3D 0;
>         int i;
> @@ -124,7 +123,7 @@ static int do_map_benchmark(struct map_benchmark_data=
 *map)
>                 }
>
>                 if (node !=3D NUMA_NO_NODE)
> -                       kthread_bind_mask(tsk[i], cpu_mask);
> +                       kthread_bind_mask(tsk[i], cpumask_of_node(node));
>         }
>
>         /* clear the old value in the previous benchmark */
> --
> 2.45.0
>

