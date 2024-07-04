Return-Path: <linux-kernel+bounces-241346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B18DA927A03
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E77428335A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70661B1218;
	Thu,  4 Jul 2024 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZoYo+zhs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8802743AB3
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720106901; cv=none; b=fmB8YGyaq85Qf4bvJbo6CBwV8iDsQZWiU3p8qSs4J93JGCpxqRNWpd5DBxAQpPIFbscEMGJoPnVen4jzigBq1Sxv7i4kGwMPD8xKcTQSMuIhwcHBoN70gn7Za/2DdfhTzg+YgTA9Q8KmFELgDS3TE/uvW0GRqJu51Nylkjh1a+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720106901; c=relaxed/simple;
	bh=K+9khsHPrGl9+kaP0GvrXu0P9KWKNyzA+GM5yKpaUmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2FKv8omKEATmYx/k1cPH7s5rbZQC3dqXvPcM6/Eat9uh4YNXRQ9PzDHtFKymY5gTe/DeB9PTsiNlUdpTlpDjFeheub6B9D/+roTAA3uC+3MIWP1KUTxWblFwxYbRU8HEpfmy4Bd2EkXo1NmGkhYiZm8u8+BDFGJAIriuYQs+gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZoYo+zhs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720106897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EHDQLEHUfgvmw0ktLAaUo/x5tRI2fcgOxkiiF8qk/9g=;
	b=ZoYo+zhsBKsBvBVGPDNEVQOStsjr/kx/QJznV76fejpJ684AOMvMEgHzmHvdPuaHkUgt9s
	sjAo2LukeSfjGpIW2jI2P22jNn7qbIhLAAd3qONd1ceMLJ7muKoTbUFaN/AOXErdapk8N8
	WYrFRz/uZ0DGn/pAFrS66R2tTsmEtYo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-vOe2KNUvMoiTRuUfLq92WQ-1; Thu, 04 Jul 2024 11:28:16 -0400
X-MC-Unique: vOe2KNUvMoiTRuUfLq92WQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-79cca22db8aso96122485a.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 08:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720106895; x=1720711695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHDQLEHUfgvmw0ktLAaUo/x5tRI2fcgOxkiiF8qk/9g=;
        b=ADP0g21GWzZoItpbXuexfvUVvqTEkGP/lGpb6WesNhG+jRijdGld8D2kfxMKT3nkGL
         zO7H9kuHFijmLh+LCvkXPWNbVjy4kiX73ih1pvepS1GtRqdnzI7xhFWqIiiAm18RdrCY
         1rWQeRvCnHiFb/URiWZ+VnToCWKR5oeMlfX6FdRa3iQjepxc96it5pJu6oSszFAMUKsB
         KAB8u9bigDZYg/H/sRXqYTW+weJe5c/9eRafQJ89iS19kqGyI+iFVF4HoNnxr4ZO1sDD
         zZRDvYgRua4F8OV6j5Qa1CX9D/RjNTbqyg/UxLq85MnPlEjzXHyxmTetm8Y7SMDmrCKt
         GeMw==
X-Gm-Message-State: AOJu0YyIXRzaxdrl9O7n9AjaZZpfKxdEDohtNH3uP60SmQRuX0uFiURW
	NsOkI9zk+DnNFgO+AmNi5mkoUQryfHk39pw7uUV6II8C/OazmJG6KgJ5XMyzvjGcq/tNpUUeeHd
	7g52UxEyx6wOHBP8+AcQ6YAAqjj1k5TnaXwA6G+stFFtemHc7sWRcrWkeyzsNXojHb6OdzA==
X-Received: by 2002:a05:620a:1a1a:b0:79c:2d:1f40 with SMTP id af79cd13be357-79eee1bf27dmr255650085a.26.1720106895748;
        Thu, 04 Jul 2024 08:28:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHes96ObGy5APTGY18HYlFTXCHgVASL0xqXVWp48t1abDxvgyujx+r7kVow6rFIGUnPQZIjqg==
X-Received: by 2002:a05:620a:1a1a:b0:79c:2d:1f40 with SMTP id af79cd13be357-79eee1bf27dmr255628085a.26.1720106891095;
        Thu, 04 Jul 2024 08:28:11 -0700 (PDT)
Received: from optiplex-fbsd (c-174-169-122-120.hsd1.nh.comcast.net. [174.169.122.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79ef26f843dsm24794385a.136.2024.07.04.08.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 08:28:10 -0700 (PDT)
Date: Thu, 4 Jul 2024 11:28:08 -0400
From: Rafael Aquini <aquini@redhat.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 2/2] kbuild: rpm-pkg: introduce a simple changelog section
 for kernel.spec
Message-ID: <Zoa_iCGGrMWvbJEb@optiplex-fbsd>
References: <CAK7LNATxSePzOrHaQvS1MQo4mpAwdfwrDu3iuUsYZ+RL=LiirA@mail.gmail.com>
 <20240611211123.959459-3-aquini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611211123.959459-3-aquini@redhat.com>

On Tue, Jun 11, 2024 at 05:11:22PM -0400, Rafael Aquini wrote:
> Fix the following rpmbuild warning:
> 
>   $ make srcrpm-pkg
>   ...
>   RPM build warnings:
>       source_date_epoch_from_changelog set but %changelog is missing
> 
> Signed-off-by: Rafael Aquini <aquini@redhat.com>
> ---
>  scripts/package/kernel.spec | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
> index 19e458341f45..126b23c1f6c2 100644
> --- a/scripts/package/kernel.spec
> +++ b/scripts/package/kernel.spec
> @@ -132,3 +132,8 @@ fi
>  /usr/src/kernels/%{KERNELRELEASE}
>  /lib/modules/%{KERNELRELEASE}/build
>  %endif
> +
> +%changelog
> +* %(echo "$(LC_ALL=C; date +'%a %b %d %Y') $(git config --get user.name) \
> +<$(git config --get user.email)>") - %{version}-%{release}
> +- Custom built Linux kernel.
> -- 
> 2.45.1
> 

Please, don't forget this one.

Thank you!


