Return-Path: <linux-kernel+bounces-516634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF7CA37508
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 16:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E70DF3A68CF
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 15:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E3C199938;
	Sun, 16 Feb 2025 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="ZW/EOkUo"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9004C8E;
	Sun, 16 Feb 2025 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739719602; cv=pass; b=AgXKEzEbMH6tJWfQ9m+nvm8aG6ZP/7A/Rn9HdkNJKYRBwsYNQEajST8VCuasT1UouFVJ2rbBY4o6DR2/dJiQJ7ifECRRYVVfqwqsCj4q/nPLoDERJddtZdvnZpYCI5SlsGXjlDnUq3xa4DIjIesd6V0Nz1AYbPQUS2cy7ypVh7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739719602; c=relaxed/simple;
	bh=5Jqvqzqft0n/oHOLWCARMRwcX6lA9g/K2VQjrnoVrac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJNwT/9V25MpzUjmVit0HW6kXBE5sSBO0HjFRNt2GeLgcD2d4EcEWXkMjOeXGRCLrLk75thfGmCMXrEHwIN4fQKiU0gnxsBi1hzJutSfk/ZthlleqI5z2bx81gy+apPzAMJsGLTqdq/8g2Fm5vFro+yEnZGXqQb05Mb1woatjKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=ZW/EOkUo; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739719560; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cIjLMA6q4wip75J09SgotIY+SKIgXe5H6zcHb5SDCteraFyIguA+P+PA/4cAlajphaS5gGmYDdWdliSYhyFBG8nzfzIB5qmlOVeqJHTW4Ak94LOS4IyicmjM35+ZG+rpaWjrKmMWrUfBK5rF33k9J8jrsbF2EjJoSwTErKreawk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739719560; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wuJz3OjJegVg2D6QgXOcKi4rWu6OJtA2M255ix6pvV4=; 
	b=LrGZIINFYURldcSUS1FPiYmusnhqxirpt7W+cZqagxsjkRxwRfv4ozHbykhdT5uhifEK1dOJzGi/Xy4i9qXy+M4QwitPv9dfiukiKEc3ZGj/b429jz2wQimVY34RVA8SuFTKLM6fqp4z5lf5pSWfHfoo76HWYqwG/Pw+p49Xk2k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739719560;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=wuJz3OjJegVg2D6QgXOcKi4rWu6OJtA2M255ix6pvV4=;
	b=ZW/EOkUoeiUGvjwDRlKr9NsznvsFv2PyfGt2eFREJ7rH6iRmruVjOKBkGndgl8OI
	srPtVzXjYl9LITG9HmUYXFk4h65wNhlgWzyNoxo1MOM3ygNZbHs9YCoFYx7CUhGvZnT
	y8Wf2ZF6oKTNL8i+6IF424SOAkFXog41CJl7RzfM=
Received: by mx.zohomail.com with SMTPS id 1739719558518293.9973070185242;
	Sun, 16 Feb 2025 07:25:58 -0800 (PST)
Message-ID: <ac4afb67-9ec7-405a-acf9-6287b30320d4@collabora.com>
Date: Sun, 16 Feb 2025 18:25:53 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] irqchip/gic-v3: Add Rockchip 3568002 erratum
 workaround
To: Marc Zyngier <maz@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Kever Yang <kever.yang@rock-chips.com>,
 XiaoDong Huang <derrick.huang@rock-chips.com>,
 Peter Geis <pgwipeout@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 kernel@collabora.com
References: <20250215235431.143138-1-dmitry.osipenko@collabora.com>
 <20250215235431.143138-2-dmitry.osipenko@collabora.com>
 <87seoe1aeu.wl-maz@kernel.org>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <87seoe1aeu.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 2/16/25 12:55, Marc Zyngier wrote:
> On Sat, 15 Feb 2025 23:54:28 +0000,
> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
>>
>> Rockchip RK3566/RK3568 GIC600 integration has DDR addressing
>> limited to first 4GB of DRAM. Rockchip assigned Erratum ID #3568002
>> for this issue. Add driver quirk for this Rockchip GIC Erratum.
> 
> Thanks for taking the time to submit this. It only took 5 years for
> this erratum to be published...

The erratum document itself actually is dated by 5 years ago. Only wish
the doc was made publicly available, which would've accelerated the
upstreaming process.

> However, my understanding of this issue is that the integration is
> limited to the first 32bit of physical address space, not the first
> 32bit of RAM. If the memory is placed as physical address 0, then they
> represent the same space. But this is still an important distinction.

Indeed, will correct the description in v2.

>> Note, that the 0x0201743b ID is not Rockchip 356x specific and thus
>> there is an extra of_machine_is_compatible() check. Rockchip 3588 uses
>> same ID and it is not affected by this errata.
> 
> This ID is that of ARM's GIC600, which is a very common GICv3
> implementation, and is not Rockchip-specific. Please capture this in
> the commit message.

Ack

...
>> +config ROCKCHIP_ERRATUM_3568002
>> +	bool "Rockchip 3568002: can not support DDR addresses higher than 4G"
>> +	default y
>> +	help
>> +	  The Rockchip RK3566 and RK3568 GIC600 SoC integrations have DDR
>> +	  addressing limited to first 4GB.
>> +
>> +	  If unsure, say Y.
>> +
> 
> s/DDR addresses/physical addresses/

Ack

...
> Another thing is that this patch conflates ITS and redistributors. As
> it turns out, we use the same allocator for both, but they are
> distinct architectural concepts, even if GIC600 is a monolithic
> implementation. It is OK for now, but it will have to be revisited if
> we ever move the redistributor management outside of the ITS driver.
> 
> With the other comments addressed:
> 
> Acked-by: Marc Zyngier <maz@kernel.org>

Thanks for the review!

-- 
Best regards,
Dmitry

