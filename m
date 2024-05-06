Return-Path: <linux-kernel+bounces-169511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE52B8BC9BC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F3728325C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D243E1419A1;
	Mon,  6 May 2024 08:39:50 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232001411CE
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 08:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714984790; cv=none; b=jMsLXE03/9Ri8JA538DgXHAgp3XJZzHIKU6M8ID2vA85C4mCJz1VRZ+99RX2Th5Shl9ISmq+iWBuy7QOXg5pph8PjrySQH3y2d0UU1rY6T0nqEzYWF2c/ZpO6KUVF94qPjZJypuvQbg9b48SWnOZttlFt/I2sRFoGQS1Nm2dnNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714984790; c=relaxed/simple;
	bh=dFWNbRzySIjYQnEWTP9mapKbZO69zQWs5KfXcdrl56U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fPPBRhYjTZlpHoQey9wQPraNaa7EwsARVhe8MQXM926dp2JXmTlnB8K/87jf6LDIXilAvcj/X8+0vYDxpvck3q671AFrkfXCDLM1Iqah3N+zmjk9BsMDbsyCWK2LEzQIAjiaoRvc6fSagMRTCVUb0EfP8WiiD95Ojq0jKmBtgDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4VXv1n3MMJz9xGWg
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 15:59:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 4B2D9140797
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 16:20:38 +0800 (CST)
Received: from [10.81.214.173] (unknown [10.81.214.173])
	by APP1 (Coremail) with SMTP id LxC2BwCnURrAkjhmm36iBw--.33418S2;
	Mon, 06 May 2024 09:20:37 +0100 (CET)
Message-ID: <0c07a0dc-542a-48da-a286-280d9c02b353@huaweicloud.com>
Date: Mon, 6 May 2024 10:20:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] arm64: Support the TSO memory model
To: Marc Zyngier <maz@kernel.org>, Zayd Qumsieh <zayd_qumsieh@apple.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Justin Lu <ih_justin@apple.com>,
 Ryan Houdek <Houdek.Ryan@fex-emu.org>, Mark Brown <broonie@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>, Miguel Luis <miguel.luis@oracle.com>,
 Joey Gouly <joey.gouly@arm.com>, Christoph Paasch <cpaasch@apple.com>,
 Kees Cook <keescook@chromium.org>, Sami Tolvanen <samitolvanen@google.com>,
 Baoquan He <bhe@redhat.com>, Joel Granados <j.granados@samsung.com>,
 Dawei Li <dawei.li@shingroup.cn>, Andrew Morton <akpm@linux-foundation.org>,
 Florent Revest <revest@chromium.org>, David Hildenbrand <david@redhat.com>,
 Stefan Roesch <shr@devkernel.io>, Andy Chiu <andy.chiu@sifive.com>,
 Josh Triplett <josh@joshtriplett.org>, Oleg Nesterov <oleg@redhat.com>,
 Helge Deller <deller@gmx.de>, Zev Weiss <zev@bewilderbeest.net>,
 Ondrej Mosnacek <omosnace@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Asahi Linux <asahi@lists.linux.dev>
References: <87zftoqn7u.wl-maz@kernel.org>
 <20240502001035.41083-1-zayd_qumsieh@apple.com>
 <867cgcqrb9.wl-maz@kernel.org>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <867cgcqrb9.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwCnURrAkjhmm36iBw--.33418S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFWxWr13tF47ur17WFW3Wrg_yoWDJFg_uF
	ykAw47Jws8CF93Z3yayw1DAr47ta1jqasxXr95Xw1Iy34IvF4xGryDJ3s3ZF13JrWkuF17
	GrW5ZFna9w43GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb7xYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
	AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 5/2/2024 um 3:25 PM schrieb Marc Zyngier:
> although
> someone would need to start thinking of how this particular TSO
> implementation composes with the relaxed memory ordering used outside
> of the VM and show that they actually lead to correct results for
> something such as virtio, for example

I used to think about this problem space. Composing some kinds of memory
models (e.g., Arm and TSO) is easy, others is hard.

I don't know much about virtio, so this may show my naivety, but what
complications could arise from virtio?

Does the "visible behavior" of virtio change depending on the memory
model of the machine it is running on?

At least internally inside virtio it should not cause any problems, since
you are effectively adding some barriers inside some of the virtio threads.
(those that are running in the VM).

But if the VM relies on virtio behaving in a "TSO manner" but its behavior
is more relaxed on e.g. Arm, then that could cause issues.

have fun, jonas


