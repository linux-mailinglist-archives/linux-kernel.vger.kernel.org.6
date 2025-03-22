Return-Path: <linux-kernel+bounces-572416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E13A6CA21
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 13:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAEA73AE1A3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 12:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C31021B9D5;
	Sat, 22 Mar 2025 12:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="XzX09J07"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5941BD9C6
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742646249; cv=none; b=HTu4VNq7QA0xsOrPyeYb/BEA394r+3Y3Ul/Y2ElrYw64Moq771BDNc92x9XjNelzTYSTcullVGL2au30OdmeLWt/f8YHe22REhYWsTlNSu6eHSxgg7T5B0iZ/L9XMQ7rYaEEsORrrChP/oMZ6lgFCJy/z/O4vwogYbonYZFzMtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742646249; c=relaxed/simple;
	bh=LtXKUFITKx/5AE9vczJ/kQIbvMqXvAsLm3q/nzV8STM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMS9f4wEOiGMd4nhBb6u9vXuINUtzEDlKhdWZoDsmNbY4s7AcDEkSADAyX6x9O4YQb8+KwBWO97tcGoIgjq8jAd7fJk94z3gwg2rxwqDRn50TV5a9dOidw14EwDgZtRn6JeLiMdYC8XJzaueWzqdVEfgnSYMvd7+k4k88iKNCaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=XzX09J07; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742646236; x=1743251036; i=spasswolf@web.de;
	bh=9ijOm03zH9pvCrE3DLbQdiRmGtSkUn8cIZSt9Jn3RYU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XzX09J07MtujBsFWdUpWUCuOkLt8CT20seIoMazZoiS1EnZqlBpTXMYjBrRE89Ob
	 NVNbBuPvBnyhqyGY6xEErxwckBaVhOBBTO0AMJrHszykACZ1yZPZGab3+SWLQfOPq
	 Pn80/XAl/Ex1+pK4mOZ05lngHnJ1NBQutsk+dND1n+tGK8xWfXEdAi4Y6bkYAAh1Z
	 kreSoTmYUs6dx/j0KNF9908+PvjXBV/Zp4pX00gmaUZeuctxQ5F5xJJWHwbSlKrwb
	 uaDSixj+Ldy8WtwH7p7WCZJUaBK0piPJ4CuEMpLKrg5XzHsoiP9sRk4eW4Eenf1eo
	 E+Lr/Q8mXP8GSHcbrw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([95.223.134.88]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MxHU2-1syVXg0UxM-0115V8; Sat, 22 Mar 2025 13:23:56 +0100
From: Bert Karwatzki <spasswolf@web.de>
To: Balbir Singh <balbirs@nvidia.com>
Cc: Bert Karwatzki <spasswolf@web.de>,
	Ingo Molnar <mingo@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org
Subject: RE: commit 7ffb791423c7 breaks steam game
Date: Sat, 22 Mar 2025 13:23:48 +0100
Message-ID: <20250322122351.3268-1-spasswolf@web.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: c5e5b3a7-e8ab-42c8-a33c-ce2c0dd21344@nvidia.com
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hAJLFKPTY6o5LmMrec62vbRj/07P3N7vmOupj0k9rmY5Q712+CA
 Mnb7oVQNPa6p29Cex9Le/HpfoY01c29xV68KqMNfj71p5qhsGUz43bu2FgMxlhJQPsTAOok
 Rf1s5orfFVIl1RBCRzb6Ve4GPnyJgno5IfdtBQ4hARp0TVEpW1FKFw63LFZ/vvFCPBuSJEC
 TrLlVuFWlCE1DDvPxIu0w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Eg18juMOxcc=;nkxu0HFBMatDv853sg2R/F555pN
 fhmgp6Vn5g7hFSdAixnHnFkJ+Jq4UkPosyeHvEvOLQC4D4d6CwJqG2Y3hBoNHpIN2UON8EKpN
 zg/Z/r9ufRw1xZF9jxEaahslOAqYKkT1geuCnjWYD6CTePCUZKr+wAIzUTaMsAPOd5Tm+qaAK
 nlPzh85d0RCF0gsCpz+MQxNst+oc9DLJe4By67YfvWw/tV+gcfhnWUfbLGrFGbV7IcIWm6oqR
 y/MRlKCZzzDjRWYb5feuVEBM5GVshvQi/nMqZhbYh1X+YJxrvAQl8Xkm7m+/WD4B/MXTr8VBS
 JjxNxCeNNsRbdexx9TRVi8KfQE4sqPEK/p4D5/RQCc1u1+iVlWTGHRZdlR9KAZsVJajOtlhQ2
 d38C7NMG5W1YA4b10aT8v/5miNsaVyXuA1wimdaHOwDHoHOLWmF8D6qBQLk1kgSBEFHv3tcME
 pX2xOoV2qJzp9nbYa15fl66B8GBzL/ReM1eLNWKI2nrdteIfkqaAY/5Mx6E0Sl8nIY+6MjK2R
 ZkaPJnLhuaXtGNRmnpQT4JoZZpcDxn858LaRMAZIu5SlEsEwD52Nfl15PbEbD+s8D1epwGHYo
 aonUwC+DV9faQ8LdqusR6NHexuoGH0BqOgBiUM1rYW67ny9e4KZdlSq8L+9YDnNxTX9jfl71f
 t2qOMvrIOd8UVMeSKXGUJ/Ev75ojGhtPuhjQYrpnPpkWKx3U0E8lgo01478TRvdyj0C5xUCdM
 RPcqjjg3S8WUKcpnvdrtk8thiPkdMXx5fpXyc0S0eaV9mUNxBS2zfuW/cpbWbWxqSnqPyGcQz
 U0MKElkrBlbt89HpDv/bkZN2cxADfxt3Ewk9TceKP+sGKbJ5xUhJYA/PIaMzCXXxkySWqwFRD
 JXNjSorgVDgTnjsQmTBUqMuBwkIxyh4V2zT6Y3w0Ej6V+NyCs+aydEQlI6OM6ypQbrRbaW0cU
 uSB0dFJf7wyLXIV0TCDlfZS3C73QS/wG9KwoiBvnVGLftJQACSLDLZM4L6RTuB4ihVajDjcw5
 ELArBwbgEo38VxKhgBQYx1Z+KTDvrIQH7fqDLsxgfwHBFmerYOAoG3cXKlkN0Lc+TIq0it7Wr
 jh/fW1kh0FNRjxMUv3/RuuzC2p/Bx95lWrxG4ps0SgU6m2D15WKdgllBsL8LDSgmfjDIaH/Nb
 D9YNe9r586ByuLfpy5F/k37G99cbgqv0wMNYmf8J8FEoArBuzS9bBUz7W7uXyOXWC+JH96maT
 2XgGX6o05bczvdnZzqeEbzUwXFG+McdR4oQHMDhwau2RIibpMa/PbYiiZIe5BkbNA8n8rUxIz
 sr48q+Wyoc6iQCW8cySetc8Liufr9PimAZ7ep3875q7Ee8B9kxhFu7okjGnchGuejsaDczP38
 +Lt7i2gSmXigKO6QTotMLubLtdh6h3lyGhzusJn6bxei6Jf7pkhs+h9vaQs5B1M9DqZEgK6v2
 aq8sk9cT4qWdLH14ljTRvOrt6Y2s=

The problem occurs in this part of ttm_tt_populate(), in the nokaslr case
the loop is entered and repeatedly run because ttm_dma32_pages allocated e=
xceeds
the ttm_dma32_pages_limit which leads to lots of calls to ttm_global_swapo=
ut().

if (!strcmp(get_current()->comm, "stellaris"))
	printk(KERN_INFO "%s: ttm_pages_allocated=3D0x%llx ttm_pages_limit=3D0x%l=
x ttm_dma32_pages_allocated=3D0x%llx ttm_dma32_pages_limit=3D0x%lx\n",
			__func__, ttm_pages_allocated.counter, ttm_pages_limit, ttm_dma32_pages=
_allocated.counter, ttm_dma32_pages_limit);
while (atomic_long_read(&ttm_pages_allocated) > ttm_pages_limit ||
       atomic_long_read(&ttm_dma32_pages_allocated) >
       ttm_dma32_pages_limit) {

	if (!strcmp(get_current()->comm, "stellaris"))
	printk(KERN_INFO "%s: count=3D%d ttm_pages_allocated=3D0x%llx ttm_pages_l=
imit=3D0x%lx ttm_dma32_pages_allocated=3D0x%llx ttm_dma32_pages_limit=3D0x=
%lx\n",
			__func__, count++, ttm_pages_allocated.counter, ttm_pages_limit, ttm_dm=
a32_pages_allocated.counter, ttm_dma32_pages_limit);
	ret =3D ttm_global_swapout(ctx, GFP_KERNEL);
	if (ret =3D=3D 0)
		break;
	if (ret < 0)
		goto error;
}

In the case without nokaslr on the number of ttm_dma32_pages_allocated is =
0 because
use_dma32 =3D=3D false in this case.

So why is use_dma32 enabled with nokaslr? Some more printk()s give this re=
sult:

The GPUs:
built-in:
08:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] =
Cezanne [Radeon Vega Series / Radeon Vega Mobile Series] (rev c5)
discrete:
03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi 23=
 [Radeon RX 6600/6600 XT/6600M] (rev c3)

With nokaslr:
[    1.266517] [    T328] dma_addressing_limited: mask =3D 0xfffffffffff b=
us_dma_limit =3D 0x0 required_mask =3D 0xfffffffff
[    1.266519] [    T328] dma_addressing_limited: ops =3D 0000000000000000=
 use_dma_iommu(dev) =3D 0
[    1.266520] [    T328] dma_direct_all_ram_mapped: returning true
[    1.266521] [    T328] dma_addressing_limited: returning ret =3D 0
[    1.266521] [    T328] amdgpu 0000:03:00.0: amdgpu: amdgpu_ttm_init: ca=
lling ttm_device_init() with use_dma32 =3D 0
[    1.266525] [    T328] entering ttm_device_init, use_dma32 =3D 0
[    1.267115] [    T328] entering ttm_pool_init, use_dma32 =3D 0

[    3.965669] [    T328] dma_addressing_limited: mask =3D 0xfffffffffff b=
us_dma_limit =3D 0x0 required_mask =3D 0x3fffffffffff
[    3.965671] [    T328] dma_addressing_limited: returning true
[    3.965672] [    T328] amdgpu 0000:08:00.0: amdgpu: amdgpu_ttm_init: ca=
lling ttm_device_init() with use_dma32 =3D 1
[    3.965674] [    T328] entering ttm_device_init, use_dma32 =3D 1
[    3.965747] [    T328] entering ttm_pool_init, use_dma32 =3D 1

Without nokaslr:
[    1.300907] [    T351] dma_addressing_limited: mask =3D 0xfffffffffff b=
us_dma_limit =3D 0x0 required_mask =3D 0xfffffffff
[    1.300909] [    T351] dma_addressing_limited: ops =3D 0000000000000000=
 use_dma_iommu(dev) =3D 0
[    1.300910] [    T351] dma_direct_all_ram_mapped: returning true
[    1.300910] [    T351] dma_addressing_limited: returning ret =3D 0
[    1.300911] [    T351] amdgpu 0000:03:00.0: amdgpu: amdgpu_ttm_init: ca=
lling ttm_device_init() with use_dma32 =3D 0
[    1.300915] [    T351] entering ttm_device_init, use_dma32 =3D 0
[    1.301210] [    T351] entering ttm_pool_init, use_dma32 =3D 0

[    4.000602] [    T351] dma_addressing_limited: mask =3D 0xfffffffffff b=
us_dma_limit =3D 0x0 required_mask =3D 0xfffffffffff
[    4.000603] [    T351] dma_addressing_limited: ops =3D 0000000000000000=
 use_dma_iommu(dev) =3D 0
[    4.000604] [    T351] dma_direct_all_ram_mapped: returning true
[    4.000605] [    T351] dma_addressing_limited: returning ret =3D 0
[    4.000606] [    T351] amdgpu 0000:08:00.0: amdgpu: amdgpu_ttm_init: ca=
lling ttm_device_init() with use_dma32 =3D 0
[    4.000610] [    T351] entering ttm_device_init, use_dma32 =3D 0
[    4.000687] [    T351] entering ttm_pool_init, use_dma32 =3D 0

So with nokaslr the reuqired mask for the built-in GPU changes from 0xffff=
fffffff
to 0x3fffffffffff which causes dma_addressing_limited to return true which=
 causes
the ttm_device init to be called with use_dma32 =3D true.
 It also show that for the discreate GPU nothing changes so the bug does n=
ot occur
there.

I also was able to work around the bug by calling ttm_device_init() with u=
se_dma32=3Dfalse
from amdgpu_ttm_init()  (drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c) but I'm =
not sure if this
has unwanted side effects.

int amdgpu_ttm_init(struct amdgpu_device *adev)
{
	uint64_t gtt_size;
	int r;

	mutex_init(&adev->mman.gtt_window_lock);

	dma_set_max_seg_size(adev->dev, UINT_MAX);
	/* No others user of address space so set it to 0 */
	dev_info(adev->dev, "%s: calling ttm_device_init() with use_dma32 =3D 0 i=
gnoring %d\n", __func__, dma_addressing_limited(adev->dev));
	r =3D ttm_device_init(&adev->mman.bdev, &amdgpu_bo_driver, adev->dev,
			       adev_to_drm(adev)->anon_inode->i_mapping,
			       adev_to_drm(adev)->vma_offset_manager,
			       adev->need_swiotlb,
			       false /* use_dma32 */);
	if (r) {
		DRM_ERROR("failed initializing buffer object driver(%d).\n", r);
		return r;
	}


Bert Karwatzki

