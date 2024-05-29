Return-Path: <linux-kernel+bounces-193934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D17D8D3439
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08462285A54
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF71C17B4E2;
	Wed, 29 May 2024 10:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dAJb4wkw"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBE217B433
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 10:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716977573; cv=none; b=muA6PPxiBvfcftxCYc8116NGnRn5YU1iOtxC+b2tBsGauMqFdCtSyIVzC5EUIH4zUcaYhkRC7Ykjxtitfv5Ez6bGoNi5NDcu8Ey8k8z3PTGta/xaHwR/5cwl+i2ePmAKxdzS+SyAa/tl+2TY0LpBCHgCJNwCpbIGjM/3BxM97vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716977573; c=relaxed/simple;
	bh=XK7lp1SRCjNNrrjcYhfn3RUUicNzAJo0YOsPL1QuCT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=jjT1176B7X3rBC1kXCRvRW0izz6pMRaKLku5uyEHy/HDW2yqV+tIC3ETTx3HnxuUo/+hVtl5OzXvzbvbDLlDm0PD8JP6SCrfxnwnuC9GnYv8Qz8G5g/wO6uFG/p+osjAop4mEQTXgPcqVNahcvaT9xiXCZy6PLDRo7xIhjlqjbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=dAJb4wkw; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240529101247euoutp022e74717097b4c372d06c39e435f88f61~T7gAvA7wW2471624716euoutp02n
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 10:12:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240529101247euoutp022e74717097b4c372d06c39e435f88f61~T7gAvA7wW2471624716euoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716977567;
	bh=HO+7UjuoRlc/thxjUXP4kSGkQyoPYs9fPA2mfjX8yE0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=dAJb4wkwQqAV9GACs90ykfTM8ECXAE1mYODFWOMH4zBqh3zlW43KZpjUCV5jiWRFv
	 Q+cWZs8Jhvsk+3xkvawgpITG3680TtO7XPIFabNMsGfXAdf/7dR6t1RnCrclc51xea
	 0o3RWvpvuow8QjRUklQ82rQT6IeeW0ljsFgZHQtE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240529101246eucas1p24567ec7825b549dabbbaad3476478acc~T7f-5Ms130983809838eucas1p2F;
	Wed, 29 May 2024 10:12:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id D6.85.09875.E9FF6566; Wed, 29
	May 2024 11:12:46 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240529101246eucas1p1266853c07f5178c7e3e4b8a264eb436e~T7f-ewj_Q0581405814eucas1p1S;
	Wed, 29 May 2024 10:12:46 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240529101246eusmtrp20f71868899ba885bcd2c7cb539f29ce2~T7f-eLpAK0458604586eusmtrp2f;
	Wed, 29 May 2024 10:12:46 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-74-6656ff9e9de0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 70.55.09010.D9FF6566; Wed, 29
	May 2024 11:12:46 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240529101245eusmtip1ff2b0736c6db55ceb4b5b216276c55b6~T7f_5cD8j0638506385eusmtip1f;
	Wed, 29 May 2024 10:12:45 +0000 (GMT)
Message-ID: <8d95757c-fd05-4a48-ae9d-24d78d04d663@samsung.com>
Date: Wed, 29 May 2024 12:12:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] of: property: Remove calls to of_node_put
To: Shresth Prasad <shresthprasad7@gmail.com>, robh@kernel.org,
	saravanak@google.com, DRI mailing list <dri-devel@lists.freedesktop.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com,
	julia.lawall@inria.fr
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20240515202915.16214-3-shresthprasad7@gmail.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djP87rz/oelGdy4L2cx/8g5VosrX9+z
	Wczae5jRomlVP7PF5V1z2Cz+79nBbtF16C+bxcLXDYwWe6cvY3Xg9Ng56y67x4JNpR6TXhxi
	8di0qpPNY//cNewe97uPM3l83iQXwB7FZZOSmpNZllqkb5fAlXHpxhLGglN2FVc+/2FqYHxo
	0sXIwSEhYCLx7LxnFyMXh5DACkaJWR1nmSGcL4wSM19OYIFwPjNKfH19j6mLkROsY9/pflaI
	xHJGiVtrFzODJIQEPjJKdG3zAxnLK2AnsfJBOUiYRUBVYurHE4wgNq+AoMTJmU9YQGxRAXmJ
	+7dmsIPYwgIuEicvrWcDsUUEuhgl+qcbg8xnFpjEKPGnsQusiFlAXOLWk/lgR7AJGEp0ve0C
	a+AE2tV59jJUjbxE89bZzBCHNnNKnJ0gAmG7SBxvbYeKC0u8Or6FHcKWkfi/E2QmF5Ddziix
	4Pd9KGcCo0TD81uMEFXWEnfO/WID+YxZQFNi/S59iLCjxPo1e9gh4cgnceOtIMQNfBKTtk1n
	hgjzSnS0CUFUq0nMOr4Obu3BC5eYJzAqzUIKlllIvpyF5JtZCHsXMLKsYhRPLS3OTU8tNspL
	LdcrTswtLs1L10vOz93ECExTp/8d/7KDcfmrj3qHGJk4GA8xSnAwK4nwnpkUmibEm5JYWZVa
	lB9fVJqTWnyIUZqDRUmcVzVFPlVIID2xJDU7NbUgtQgmy8TBKdXAxFfvL2Rzxvcp29S2mBNs
	7T4Xni180h5jL/hna7GzxdOHUiWz/zx6bh6u3LL/t/7B1Xs/3ZotvuX14kSzcpOPBYZV/Df9
	DzZ1bFmbnW5mv3dRSMlq4R9xMloP2lV4pLeJCq/Vv+YaNLUh6ytD3p9v9xdq9F9e7iG33EjE
	euP93Sn7n/inXrObVP+FwSf7bd+TSXbhocsTisueq80IM70mtO2p/cfr7/yb1tW7za6yEn1l
	886De+HHe3ztW15+sI8+MP2GzVRWhbpCX4MtRy0vG/lIsc89wvwx/GKuTG1i1Zx38jE1H08x
	rFh2wezikXsRmifV9/K+vyti+JivOMFx25MJFbvNtbkTpuleOvF8kxJLcUaioRZzUXEiAK2k
	xTXCAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xu7rz/oelGWwIs5h/5ByrxZWv79ks
	Zu09zGjRtKqf2eLyrjlsFv/37GC36Dr0l81i4esGRou905exOnB67Jx1l91jwaZSj0kvDrF4
	bFrVyeaxf+4ado/73ceZPD5vkgtgj9KzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1
	MjJV0rezSUnNySxLLdK3S9DLuHRjCWPBKbuKK5//MDUwPjTpYuTkkBAwkdh3up8VxBYSWMoo
	ceCTLERcRuLktAZWCFtY4s+1LrYuRi6gmveMEqtuLmbvYuTg4BWwk1j5oBykhkVAVWLqxxOM
	IDavgKDEyZlPWEBsUQF5ifu3ZrCD2MICLhInL60HmyMi0MUo8fDNeiYQh1lgEqPE9OkXmEGG
	CgnYSvx+agfSwCwgLnHryXwmEJtNwFCi6y3IEZwcnEB7O89eZoeoMZPo2trFCGHLSzRvnc08
	gVFoFpI7ZiEZNQtJyywkLQsYWVYxiqSWFuem5xYb6RUn5haX5qXrJefnbmIExuW2Yz+37GBc
	+eqj3iFGJg7GQ4wSHMxKIrxnJoWmCfGmJFZWpRblxxeV5qQWH2I0BQbGRGYp0eR8YGLIK4k3
	NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpgqlx7ne/l9FMWlg8y1Bdf
	XLXYvV1AKOy2s9NV3/u+vIy53kuOMps4+B7YuLZ+8f2lyy5d+qEeym+ary66/qh+T/hB9Zcb
	quUafnUtuyC+wKZ8enpTGt8f3oc2UT3XLjitWLpE/IP7/OhngZ+6V747GjtJYueMhUKZaZf8
	Xqj845jwiPH580ea0fraRyWe+sUvkD/Jel91/7wm87l/vZ+f573bvWVbwKRjbtc+GzM2PODs
	6IrxrIxVnH/UJCkiZTazfzVnHKOzZo7yhqTCG20c5810zNXPcofyf9rH3FaT8+2Uf90Ua9EE
	fptau73reXb+fKJ/qPMHh+Cpdf8evXd4mdgu5bf+zzbJy73PSsx4lViKMxINtZiLihMBwTAl
	tVQDAAA=
X-CMS-MailID: 20240529101246eucas1p1266853c07f5178c7e3e4b8a264eb436e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240529101246eucas1p1266853c07f5178c7e3e4b8a264eb436e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240529101246eucas1p1266853c07f5178c7e3e4b8a264eb436e
References: <20240515202915.16214-3-shresthprasad7@gmail.com>
	<CGME20240529101246eucas1p1266853c07f5178c7e3e4b8a264eb436e@eucas1p1.samsung.com>

On 15.05.2024 22:29, Shresth Prasad wrote:
> Add __free cleanup handler to some variable initialisations, which
> ensures that the resource is freed as soon as the variable goes out of
> scope. Thus removing the need to manually free up the resource using
> of_node_put.
>
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
> ---

This patch landed in today's linux-next as commit b94d24c08ee1 ("of: 
property: Remove calls to of_node_put"). I found that it triggers the 
following warning while booting of the Samsung Exynos5800 based Pi 
Chromebook (arch/arm/boot/dts/samsung/exynos5800-peach-pi.dts):

OF: ERROR: of_node_release() detected bad of_node_put() on /panel
CPU: 2 PID: 68 Comm: kworker/u36:1 Not tainted 
6.10.0-rc1-00001-gb94d24c08ee1 #8619
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: events_unbound deferred_probe_work_func
tps65090 20-0048: No cache defaults, reading back from HW
Call trace:
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x50/0x64
  dump_stack_lvl from of_node_release+0x110/0x138
  of_node_release from kobject_put+0x98/0x108
  kobject_put from drm_of_find_panel_or_bridge+0x94/0xd8
  drm_of_find_panel_or_bridge from exynos_dp_probe+0xf0/0x158 [exynosdrm]
  exynos_dp_probe [exynosdrm] from platform_probe+0x80/0xc0
  platform_probe from really_probe+0xc8/0x288
  really_probe from __driver_probe_device+0x8c/0x190
  __driver_probe_device from driver_probe_device+0x30/0xd0
  driver_probe_device from __device_attach_driver+0x8c/0xbc
  __device_attach_driver from bus_for_each_drv+0x74/0xc0
  bus_for_each_drv from __device_attach+0xe8/0x184
  __device_attach from bus_probe_device+0x88/0x8c
  bus_probe_device from deferred_probe_work_func+0x7c/0xa8
  deferred_probe_work_func from process_scheduled_works+0xe8/0x41c
  process_scheduled_works from worker_thread+0x14c/0x35c
  worker_thread from kthread+0xd0/0x104
  kthread from ret_from_fork+0x14/0x28
Exception stack(0xf0a81fb0 to 0xf0a81ff8)

OF: ERROR: next of_node_put() on this node will result in a kobject 
warning 'refcount_t: underflow; use-after-free.'
------------[ cut here ]------------
WARNING: CPU: 3 PID: 68 at lib/refcount.c:25 kobject_get+0xa0/0xa4
refcount_t: addition on 0; use-after-free.
Modules linked in: i2c_cros_ec_tunnel(+) cros_ec_keyb cros_ec_dev 
cros_ec_spi cros_ec snd_soc_i2s snd_soc_idma snd_soc_max98090 
snd_soc_snow snd_soc_s3c_dma snd_soc_core tpm_i2c_infineon ac97_bus 
snd_pcm_dmaengine tpm exynosdrm libsha256 libaescfb snd_pcm analogix_dp 
ecdh_generic samsung_dsim ecc snd_timer atmel_mxt_ts snd libaes 
soundcore exynos_gsc s5p_jpeg s5p_mfc v4l2_mem2mem spi_s3c64xx 
videobuf2_dma_contig exynos_adc pwm_samsung videobuf2_memops 
videobuf2_v4l2 videodev phy_exynos_usb2 videobuf2_common ohci_exynos 
ehci_exynos mc exynos_ppmu rtc_s3c exynos_rng s3c2410_wdt s5p_sss 
phy_exynos_mipi_video phy_exynos_dp_video
CPU: 3 PID: 68 Comm: kworker/u36:1 Not tainted 
6.10.0-rc1-00001-gb94d24c08ee1 #8619
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: events_unbound deferred_probe_work_func
Call trace:
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x50/0x64
  dump_stack_lvl from __warn+0x108/0x12c
  __warn from warn_slowpath_fmt+0x118/0x17c
  warn_slowpath_fmt from kobject_get+0xa0/0xa4
  kobject_get from of_node_get+0x14/0x1c
  of_node_get from of_get_next_parent+0x24/0x50
  of_get_next_parent from of_graph_get_port_parent.part.1+0x58/0xa4
  of_graph_get_port_parent.part.1 from 
of_graph_get_remote_port_parent+0x1c/0x38
  of_graph_get_remote_port_parent from of_graph_get_remote_node+0x10/0x6c
  of_graph_get_remote_node from drm_of_find_panel_or_bridge+0x50/0xd8
  drm_of_find_panel_or_bridge from exynos_dp_probe+0xf0/0x158 [exynosdrm]
  exynos_dp_probe [exynosdrm] from platform_probe+0x80/0xc0
  platform_probe from really_probe+0xc8/0x288
  really_probe from __driver_probe_device+0x8c/0x190
  __driver_probe_device from driver_probe_device+0x30/0xd0
  driver_probe_device from __device_attach_driver+0x8c/0xbc
  __device_attach_driver from bus_for_each_drv+0x74/0xc0
  bus_for_each_drv from __device_attach+0xe8/0x184
  __device_attach from bus_probe_device+0x88/0x8c
  bus_probe_device from deferred_probe_work_func+0x7c/0xa8
  deferred_probe_work_func from process_scheduled_works+0xe8/0x41c
  process_scheduled_works from worker_thread+0x14c/0x35c
  worker_thread from kthread+0xd0/0x104
  kthread from ret_from_fork+0x14/0x28
Exception stack(0xf0a81fb0 to 0xf0a81ff8)

---[ end trace 0000000000000000 ]---
------------[ cut here ]------------

If I got this right, this points to the drm_of_find_panel_or_bridge() 
function. I briefly scanned it, but I don't see any obvious 
of_node_put() related issue there.


> I had submitted a similar patch a couple weeks ago addressing the same
> issue, but as it turns out I wasn't thorough enough and had left a couple
> instances.
>
> I hope this isn't too big an issue.
> ---
>   drivers/of/property.c | 27 +++++++++++----------------
>   1 file changed, 11 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 17b294e16c56..96a74f6a8d64 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -773,15 +773,14 @@ EXPORT_SYMBOL(of_graph_get_port_parent);
>   struct device_node *of_graph_get_remote_port_parent(
>   			       const struct device_node *node)
>   {
> -	struct device_node *np, *pp;
> +	struct device_node *pp;
>   
>   	/* Get remote endpoint node. */
> -	np = of_graph_get_remote_endpoint(node);
> +	struct device_node *np __free(device_node) =
> +			    of_graph_get_remote_endpoint(node);
>   
>   	pp = of_graph_get_port_parent(np);
>   
> -	of_node_put(np);
> -
>   	return pp;
>   }
>   EXPORT_SYMBOL(of_graph_get_remote_port_parent);
> @@ -835,17 +834,18 @@ EXPORT_SYMBOL(of_graph_get_endpoint_count);
>   struct device_node *of_graph_get_remote_node(const struct device_node *node,
>   					     u32 port, u32 endpoint)
>   {
> -	struct device_node *endpoint_node, *remote;
> +	struct device_node *endpoint_node __free(device_node) =
> +			    of_graph_get_endpoint_by_regs(node, port, endpoint);
> +
> +	struct device_node *remote __free(device_node) =
> +			    of_graph_get_remote_port_parent(endpoint_node);
>   
> -	endpoint_node = of_graph_get_endpoint_by_regs(node, port, endpoint);
>   	if (!endpoint_node) {
>   		pr_debug("no valid endpoint (%d, %d) for node %pOF\n",
>   			 port, endpoint, node);
>   		return NULL;
>   	}
>   
> -	remote = of_graph_get_remote_port_parent(endpoint_node);
> -	of_node_put(endpoint_node);
>   	if (!remote) {
>   		pr_debug("no valid remote node\n");
>   		return NULL;
> @@ -853,7 +853,6 @@ struct device_node *of_graph_get_remote_node(const struct device_node *node,
>   
>   	if (!of_device_is_available(remote)) {
>   		pr_debug("not available for remote node\n");
> -		of_node_put(remote);
>   		return NULL;
>   	}
>   
> @@ -1064,19 +1063,15 @@ static void of_link_to_phandle(struct device_node *con_np,
>   			      struct device_node *sup_np,
>   			      u8 flags)
>   {
> -	struct device_node *tmp_np = of_node_get(sup_np);
> +	struct device_node *tmp_np __free(device_node) = of_node_get(sup_np);
>   
>   	/* Check that sup_np and its ancestors are available. */
>   	while (tmp_np) {
> -		if (of_fwnode_handle(tmp_np)->dev) {
> -			of_node_put(tmp_np);
> +		if (of_fwnode_handle(tmp_np)->dev)
>   			break;
> -		}
>   
> -		if (!of_device_is_available(tmp_np)) {
> -			of_node_put(tmp_np);
> +		if (!of_device_is_available(tmp_np))
>   			return;
> -		}
>   
>   		tmp_np = of_get_next_parent(tmp_np);
>   	}

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


