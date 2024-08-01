Return-Path: <linux-kernel+bounces-271112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 332109449AE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEBA9285314
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080FA18452B;
	Thu,  1 Aug 2024 10:51:01 +0000 (UTC)
Received: from smtp134-32.sina.com.cn (smtp134-32.sina.com.cn [180.149.134.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE2C16FF48
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 10:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722509460; cv=none; b=L/4YFVxGYcZEtv42O5XhNQw7xy4uTlKWqtjim+TpSheBBy1hzEbEjTcZ+QdQiu7wj1MKi3INN90c4hxW24FkcYVbdCkq03O04bs41qg0e2jmV9E6gJXRHXFKxoQCjoFhv4MS2avUeAxSQMMbZrVEQbMLhdlvPItO/KqVIDNuKKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722509460; c=relaxed/simple;
	bh=nuP/Y348n+wY/EbV+GNC82gNs/u2wcIrgg4cL8XBftY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=flryCCip3+GC3E63U1V3K38YBP1bbqnbOyf8m5BjPfTWx3FOjUPxQXdaAYTKVUrE5ANNCJCLSO5dOGLwZjiB4oMoPYIyoLu+tRS72pUH99RfnqU8IJfwPIKwILI3PMHLcxyIrWDebXOQOMn8OLHqnMOq9EWwLKCQNwBIjGr12RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.72])
	by sina.com (10.185.250.21) with ESMTP
	id 66AB688000007D8F; Thu, 1 Aug 2024 18:50:43 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 665173408395
X-SMAIL-UIID: 3E7A22F8EDBD4BAEBA9114D9211CA665-20240801-185043-1
From: Hillf Danton <hdanton@sina.com>
To: Liju-clr Chen <liju-clr.chen@mediatek.com>
Cc: Will Deacon <will@kernel.org>,
	Yingshiuan Pan <Yingshiuan.Pan@mediatek.com>,
	linux-kernel@vger.kernel.org,
	Ze-yu Wang <Ze-yu.Wang@mediatek.com>
Subject: Re: [PATCH v12 05/24] virt: geniezone: Add vm support
Date: Thu,  1 Aug 2024 18:50:32 +0800
Message-Id: <20240801105032.2533-1-hdanton@sina.com>
In-Reply-To: <20240730082436.9151-6-liju-clr.chen@mediatek.com>
References: <20240730082436.9151-1-liju-clr.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 30 Jul 2024 16:24:17 +0800 Liju-clr Chen <liju-clr.chen@mediatek.com>
> +
> +static void gzvm_destroy_vm(struct gzvm *gzvm)
> +{
> +	pr_debug("VM-%u is going to be destroyed\n", gzvm->vm_id);
> +
> +	mutex_lock(&gzvm->lock);
> +
> +	gzvm_arch_destroy_vm(gzvm->vm_id);
> +
> +	mutex_lock(&gzvm_list_lock);
> +	list_del(&gzvm->vm_list);
> +	mutex_unlock(&gzvm_list_lock);
> +
> +	mutex_unlock(&gzvm->lock);
> +
> +	kfree(gzvm);
> +}
...
> +
> +void gzvm_destroy_all_vms(void)
> +{
> +	struct gzvm *gzvm, *tmp;
> +
> +	mutex_lock(&gzvm_list_lock);
> +	if (list_empty(&gzvm_list))
> +		goto out;
> +
> +	list_for_each_entry_safe(gzvm, tmp, &gzvm_list, vm_list)
> +		gzvm_destroy_vm(gzvm);
> +

You add a fking deadlock by invoking gzvm_destroy_vm() with gzvm_list_lock held.

> +out:
> +	mutex_unlock(&gzvm_list_lock);
> +}

