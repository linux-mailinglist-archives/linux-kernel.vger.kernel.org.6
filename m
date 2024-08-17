Return-Path: <linux-kernel+bounces-290676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA9C95573D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 12:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B07282A29
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 10:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C688A1420CC;
	Sat, 17 Aug 2024 10:31:53 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A487256E
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 10:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723890713; cv=none; b=RJSehMP250sUGuDIeKf5yfJ+mHD9aDcUbm1cTx7WJXvqBXGlkK8z++eTFx6CAOMDTuMCglP+uzWdJuRypTNzIRDbvJD004o7ew+J/gB+agKlXaB6B1Uem37J+9FB//qj30nhEggqEbrH5XiU41+7At7F7XQJ/bTyqA1ur+WJukU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723890713; c=relaxed/simple;
	bh=/pWOmZyOB1xth285AS00au612Ad7oA8AgWD7Nxl2VJ8=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FXGNn2OJ2iPgXjziHoecR7u4PUOsGxDgi4yLqzJ053IgFWXPZ8kQpvjyNqXZ+W3IbeijRkr9gGRWJNE9nDnBsqxOV/99c6+UmT1pCoW84Lpc4YfL9fDN7P6B1qlNF7R+ab9HGXqMVAek4W064bbRgiV84ZFgNWdzdtKC08SnwQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WmFR23MCdz20lfl;
	Sat, 17 Aug 2024 18:27:10 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id B1A2A1400D2;
	Sat, 17 Aug 2024 18:31:47 +0800 (CST)
Received: from [10.174.178.219] (10.174.178.219) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 17 Aug 2024 18:31:46 +0800
Subject: Re: [PATCH] KVM: arm64: vgic-debug: Don't put unmarked LPIs
To: Marc Zyngier <maz@kernel.org>
CC: <kvmarm@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <oliver.upton@linux.dev>,
	<james.morse@arm.com>, <suzuki.poulose@arm.com>, <wanghaibin.wang@huawei.com>
References: <20240817101541.1664-1-yuzenghui@huawei.com>
 <86a5hbzbrt.wl-maz@kernel.org>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <99900ad4-6b05-4bba-ec7a-f4f4d36ab71b@huawei.com>
Date: Sat, 17 Aug 2024 18:31:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <86a5hbzbrt.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600007.china.huawei.com (7.193.23.208)

On 2024/8/17 18:25, Marc Zyngier wrote:
> On Sat, 17 Aug 2024 11:15:41 +0100,
> Zenghui Yu <yuzenghui@huawei.com> wrote:
> >
> > If there were LPIs being mapped behind our back (i.e., between .start() and
> > .stop()), we would put them at iter_unmark_lpis() without checking if they
> > were actually *marked*, which is obviously not good.
> >
> > Switch to use the xa_for_each_marked() iterator to fix it.
> >
> > Fixes: 85d3ccc8b75b ("KVM: arm64: vgic-debug: Use an xarray mark for debug iterator")
> > Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> > ---
> >  arch/arm64/kvm/vgic/vgic-debug.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kvm/vgic/vgic-debug.c b/arch/arm64/kvm/vgic/vgic-debug.c
> > index bc74d06398ef..e1397ab2072a 100644
> > --- a/arch/arm64/kvm/vgic/vgic-debug.c
> > +++ b/arch/arm64/kvm/vgic/vgic-debug.c
> > @@ -85,7 +85,7 @@ static void iter_unmark_lpis(struct kvm *kvm)
> >  	struct vgic_irq *irq;
> >  	unsigned long intid;
> >  
> > -	xa_for_each(&dist->lpi_xa, intid, irq) {
> > +	xa_for_each_marked(&dist->lpi_xa, intid, irq, LPI_XA_MARK_DEBUG_ITER) {
> >  		xa_clear_mark(&dist->lpi_xa, intid, LPI_XA_MARK_DEBUG_ITER);
> >  		vgic_put_irq(kvm, irq);
> >  	}
> 
> Ouch. Nicely caught. I think this deserves a
> 
> Cc: stable@vger.kernel.org # v6.10

Yup. I guess Oliver will help to add it when applying ;-)

> 
> With that,
> 
> Reviewed-by: Marc Zyngier <maz@kernel.org>

Thanks!

Zenghui

