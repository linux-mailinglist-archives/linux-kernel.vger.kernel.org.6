Return-Path: <linux-kernel+bounces-374551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0219A6BD7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B4D1F227AC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E3E1F4FD8;
	Mon, 21 Oct 2024 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Pi/CJZBo"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7B61D175B
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729520085; cv=none; b=er4xj58QFSdg+lm17FIOo3lNO+zbPUbRFPHvMDoojs6vkm9LLZzp/uklla8GwP3PR1cAEt93g4XWixzmJokX4vidq5zDU8Zm+7Sa4WXrBzx7fyrCBnTYL28B6+YFzmuxgy2bzOtPCfTLMyzeCbZLCl0oc7L9hiy2sdzY/Z0tnro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729520085; c=relaxed/simple;
	bh=CbK/TUhgKsr7R3sfPkrt8loPP4+oBOUaltz2In+SVk4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CoNtBaiCRh+wjhyUf4lNsv6OjbGznS+1T7zIz7YqmUIZ8z3EoZOwxRjRD6gWOkTwzskS+Mn4hyjJLzHwVblTnjIOy0mLPIHs6N6jptW6yfeKzcMg4a6CA11XG9CEI8SuJMHnLAj26L0qOyKenMP0irHqW5qdGPqZXcm6K4FHIl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Pi/CJZBo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729520081;
	bh=CbK/TUhgKsr7R3sfPkrt8loPP4+oBOUaltz2In+SVk4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pi/CJZBosApQDNCSxMR6aYEEiN8RtoyXYUgBtdQyKh68xTJRc3wKlXFiYUOp1WYo3
	 iPt8cOY33j6YJFQo+Au4HiFIapGdtNlAsF86Z/l1xQF1XXK73q72uxDgeLMJSaZbiU
	 q5rHB8Dh5nvDB+bhYe+5M8QmkB1GpItJxx7rlxJIIljk1qtkgq0pFxOUAx76j1kB3U
	 F+QWaiRrVHBo2UBZpKsn94lOuMD7PSMuW0nSylPDbzvWR92sOIXSaQcqKflrpkJA1B
	 cGvQh9FJh9a87XujYIbndpGbBojeVP9doa3qWpsBqwgtsWtuPNzuNXH7KzH4tIfLl3
	 gVsAy6F0IyeuA==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7C16917E3621;
	Mon, 21 Oct 2024 16:14:41 +0200 (CEST)
Date: Mon, 21 Oct 2024 16:14:37 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Philipp Zabel
 <p.zabel@pengutronix.de>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] drm/panfrost: handle job hw submit errors
Message-ID: <20241021161437.4555a490@collabora.com>
In-Reply-To: <20241014233758.994861-4-adrian.larumbe@collabora.com>
References: <20241014233758.994861-1-adrian.larumbe@collabora.com>
	<20241014233758.994861-4-adrian.larumbe@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Oct 2024 00:31:39 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> -static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
> +static int panfrost_job_hw_submit(struct panfrost_job *job, int js)
>  {
>  	struct panfrost_device *pfdev =3D job->pfdev;
>  	unsigned int subslot;
> @@ -207,15 +207,15 @@ static void panfrost_job_hw_submit(struct panfrost_=
job *job, int js)
> =20
>  	ret =3D pm_runtime_get_sync(pfdev->base.dev);
>  	if (ret < 0)
> -		return;
> +		return ret;
> =20

You need to call pm_runtime_put_autosuspend() if something fails after
that point, otherwise you're leaking a runtime-PM ref.

>  	if (WARN_ON(job_read(pfdev, JS_COMMAND_NEXT(js)))) {
> -		return;
> +		return -EINVAL;
>  	}
> =20
>  	ret =3D panfrost_mmu_as_get(pfdev, job->mmu, &cfg);
>  	if (ret)
> -		return;
> +		return ret;
> =20
>  	job_write(pfdev, JS_HEAD_NEXT_LO(js), lower_32_bits(jc_head));
>  	job_write(pfdev, JS_HEAD_NEXT_HI(js), upper_32_bits(jc_head));
> @@ -263,6 +263,8 @@ static void panfrost_job_hw_submit(struct panfrost_jo=
b *job, int js)
>  			job, js, subslot, jc_head, cfg & 0xf);
>  	}
>  	spin_unlock(&pfdev->js->job_lock);
> +
> +	return 0;
>  }

