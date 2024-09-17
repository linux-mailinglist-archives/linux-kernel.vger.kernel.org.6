Return-Path: <linux-kernel+bounces-331514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF15A97ADDC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97684B2C92C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B714136351;
	Tue, 17 Sep 2024 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TcpGKdCA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AC413213E
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726564769; cv=none; b=sxeYqlOJgzs/xk3ROb/Ufl5XXoQtrpqQn9Xes1cnkHItpka2BCohOWMuby11Y51rpax/c7txW+9hjTX5Ojj+c8f2FcD5XVeYpzZn89vLzDg3ZTsCWPWSRYj3JZNwkHxGzKkJmf2tiB48YdfTlAzKAp4QS4MZbOlPbJZV49XsGu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726564769; c=relaxed/simple;
	bh=kWuW+XR4q5jXLOcqkgK9vOp5gvxRDxmxZd6napgsXZs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EPyk/I+m589rl899L8MLCvgBnnpB1E6AQ4RnWa+ZYo1CPSfGCPxl44b5nfRHPnXAJcIn/rTcFcL9IEG+SYCakPoTyai1k1NXe7OIkDcwVcCLIJWUoPZ1WxoQxaD4QNqGmquccWJtitaEn6Py1/URpygFKcitZhJUtS9/jHVO6yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TcpGKdCA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726564766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KUX/cDE3gOpSZUKXDw0O/fMf4D971hqREO3NNvXeAJs=;
	b=TcpGKdCA14AYWYaL2yd3/LKAM5B6XjIHzaBYBGaQydBnKlPd/L+j8tqp5bV054bnz/J1QR
	fVgeGD1VEbR/VjWlRmvP08tdprd8jm9x3Mg51W2XVgZG54EtDnTI0Sw4xZTYnhWnbgRdbs
	v8bBQms+BqKvDldy340cmOxR/8XGFBU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-wnnj1nLSPDC3rEKoOTIX-g-1; Tue, 17 Sep 2024 05:19:24 -0400
X-MC-Unique: wnnj1nLSPDC3rEKoOTIX-g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-377a26a5684so1476362f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 02:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726564763; x=1727169563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUX/cDE3gOpSZUKXDw0O/fMf4D971hqREO3NNvXeAJs=;
        b=oBoc4MsGYzP9bKhmjPNZsiqmy0395gnREDyo0ZHaP9tw3OXtS93l1xt/cEQ/Go+0Fi
         OP0mYfIEZV9hOO+UUNGFn78i4exQIakD5GonPx/iNklhre8isuPO8y7Yd4qYcrZ0l+Nr
         G51uoQXejIRm6rLTFgkPrrcZXvYY7MIBMvvPS837uQV37aSN8O6/5gcH2rzndEh+5XtK
         YYVCrQwY3iCS38H1PlmbjaIKGO0TXu0Q9T5ZrJpAwrQ1uS9WK0GnloyJzw7GQMs7V0OQ
         KSWkCf2mfqDzXimeHLyBbDmqvqfPIYp0puYautJhKIDQmko47ZabkZWZwNwdZWKS4x2C
         MA5g==
X-Forwarded-Encrypted: i=1; AJvYcCVa5yWRbYD8AOn5i/eeWNLHuPTH1Y2CgxZdXEWNwz3clpm9lKI89vUEvG3D1ib555kQi1NFjERbW8hYl0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg4rFSi1zW1mDuaJACFm3mCYNsB5qRSfsNZ/HHfGWHCNeByXCS
	uQkKA06/RPzsA/zVz34cdiE+WwxGR+8Mp3ia0OB2OSBGLvGH2D1wkhIf0KPPvxl/kdIwxHEg8/J
	q0K1WCrBDGWoIUp7KY+/HyHV7IfxDAJj/zbMLRFUJoDwtd9u4SJyumFiaE5ObrQ==
X-Received: by 2002:a05:6000:120d:b0:371:82ec:206f with SMTP id ffacd0b85a97d-378d61e2871mr7662716f8f.16.1726564763157;
        Tue, 17 Sep 2024 02:19:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv0lTzGa0En47cTCylvcPoC7R3ZsfV7mcSql4HpZVVz0Cn5vdXmB2CE6F2pXgFsdS98qHtrQ==
X-Received: by 2002:a05:6000:120d:b0:371:82ec:206f with SMTP id ffacd0b85a97d-378d61e2871mr7662700f8f.16.1726564762614;
        Tue, 17 Sep 2024 02:19:22 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e7804483sm8908721f8f.92.2024.09.17.02.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 02:19:22 -0700 (PDT)
Date: Tue, 17 Sep 2024 11:19:21 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v10 02/21] acpi/generic_event_device: Update GHES
 migration to cover hest addr
Message-ID: <20240917111921.7e95726b@imammedo.users.ipa.redhat.com>
In-Reply-To: <bed4b2da51e0c894cc255f712b67e2e57295d826.1726293808.git.mchehab+huawei@kernel.org>
References: <cover.1726293808.git.mchehab+huawei@kernel.org>
	<bed4b2da51e0c894cc255f712b67e2e57295d826.1726293808.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Sep 2024 08:13:23 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The GHES migration logic at GED should now support HEST table
> location too.
> 
> Increase migration version and change needed to check for both
> ghes_addr_le and hest_addr_le
But I don't think it will work like this (but I might be easily wrong)
However I don't know enough to properly review this patch, CCing Peter & Fabiano

> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/generic_event_device.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 15b4c3ebbf24..4e5e387ee2df 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -343,10 +343,11 @@ static const VMStateDescription vmstate_ged_state = {
>  
>  static const VMStateDescription vmstate_ghes = {
>      .name = "acpi-ghes",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 2,
>      .fields = (const VMStateField[]) {
>          VMSTATE_UINT64(ghes_addr_le, AcpiGhesState),
> +        VMSTATE_UINT64(hest_addr_le, AcpiGhesState),
>          VMSTATE_END_OF_LIST()
>      },
>  };
> @@ -354,13 +355,13 @@ static const VMStateDescription vmstate_ghes = {
>  static bool ghes_needed(void *opaque)
>  {
>      AcpiGedState *s = opaque;
> -    return s->ghes_state.ghes_addr_le;
> +    return s->ghes_state.ghes_addr_le && s->ghes_state.hest_addr_le;
>  }

what I would do:
  add ghes_needed_v2(): return  s->ghes_state.hest_addr_le;

and then instead of reusing vmstate_ghes_state would add new
vmstate_ghes_v2_state subsection that migrates only 
  VMSTATE_UINT64(hest_addr_le, AcpiGhesState)
field.

btw: we probably don't need ghes_addr_le for new code that
uses HEST to lookup relevant error status block.
but we should still keep it for 9.1 and older machine types
as they expect/use it. Separate subsections would work with
this req just fine.

>  static const VMStateDescription vmstate_ghes_state = {
>      .name = "acpi-ged/ghes",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 2,
>      .needed = ghes_needed,
>      .fields = (const VMStateField[]) {
>          VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,


