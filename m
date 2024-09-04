Return-Path: <linux-kernel+bounces-314161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0389196AF88
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 05:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5A0284B27
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 03:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9097C4DA13;
	Wed,  4 Sep 2024 03:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDAOwPal"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1FF42047
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 03:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725421128; cv=none; b=XrpPunfAUBZzvw8PM2wmONjo4OpPIwIDzVduhmJyY3jBV/tMZCyrH8oY8ksRMQOGclIbaKs1y+kdP3ScZgAvANy7/sr/APJtr0DDquoS+rSQCpuJ0yDVdXcbY2qrhpQsY1pBVSOUEnD0MZ9wf8NcJlVH9ezw6Cn3KbAnzVXRFPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725421128; c=relaxed/simple;
	bh=8LggX3uN4M7m0h/bm9JWl52ManAc19NR9Lnhyf3mcUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PIuWSY8uqJ8Yn7Jy4X3KqSy8KzyiibHEIIFC09L4IbUM7g6dc49VKjSuU+jRv3rY74OMq9OBi3bqqSWPGTkGSHYE22Jsj8BbtC8RYk+poCyA77tzL15sftz/sL09y3T8Gc+Qp6d1AP+BNlwrAwwS0qFBqQNe4FsS/2lqbj8vGf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZDAOwPal; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725421125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8LggX3uN4M7m0h/bm9JWl52ManAc19NR9Lnhyf3mcUM=;
	b=ZDAOwPall2zi0VeQF+L13GvwnzqSvYtZXg4EPZTdNlKIQdCy0wQw2ni4SnY/Pt3eCaSAWG
	3hPopondL3GxPuxZ1DyjggHMqhZiDQ/h1Dswpc9LC4Oycdi/+ltuNwHn0zqzaf9XmK9Pt2
	9BNIyPgLCPJh3hnsvHHvDuZ4l5PhWU4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-CFrNCTZpPbS5CWfiJfdkow-1; Tue, 03 Sep 2024 23:38:43 -0400
X-MC-Unique: CFrNCTZpPbS5CWfiJfdkow-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2d3ce4f35c1so370794a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 20:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725421121; x=1726025921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LggX3uN4M7m0h/bm9JWl52ManAc19NR9Lnhyf3mcUM=;
        b=tdzONecsz0Thxx9KNNhr5XIEQUvsRa3K+FQlTOV9EYiThEfzIE5FE3gQ1Hwc0zCFGb
         0rglYYB3XDIgBmT6YD1RhUWzJLnAswA1lcD+/gG27jFi0VTyVSTB05MiLhNU6r8e93KV
         NJDsmN05HVzfL4w/G/0YzrcbilwsUd5a4PMGJcdq1iiqZtZEcN1dqoVZURSuAocG9l8q
         VC4YQxe4aKMrYY2VLZsXpxwp/JFSZ+U8lO8V0G2mMYfniWBHBiGkvBGZt45OOaX2k2SG
         YmI6yNXXKpI/5NwvXkHKwuv6Ax4uP9lO/mFqtvXDfQ/II6zrfSrh56w//beHHUf6EKcs
         0IUw==
X-Forwarded-Encrypted: i=1; AJvYcCUmL3JJSqJAABSaleNGwWWDPbVlTyeoaRs2DvDKqpytQRdswgQTOcvWHaouqDF8JHDslmICiqRXiRpmP7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcsTjL1IPOjK0KI9dnCDbbzWC+G1MNvWQotxmzsRh8rrOAgdhE
	ahZVCB7OsH3WP+nJ4wSKfO8jQB69TaB3UOQ0sfGldtUht78ZK+FQh/NBx2qDEjOYL337uW4p+tC
	j4VjdanLduNs3TxLexCHI9WEtv2/MeHVp/TvpN73NYGz/ySfTCJPDFwxwCsNCidhejakkIwDMwG
	LPN372edVa05j09zQoaCKeNd5PQ8YM57iTyjSR
X-Received: by 2002:a17:90b:a51:b0:2c9:7343:71f1 with SMTP id 98e67ed59e1d1-2da8ef06ddamr1214120a91.14.1725421121687;
        Tue, 03 Sep 2024 20:38:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlGyB9HKL34arDASkgE7Wmme3C7Z/CcaPhQaHiR7JfaCCZ89rNpkhiOJtxSP3M0uKmOv0+AQdjpKz3P+KDyJk=
X-Received: by 2002:a17:90b:a51:b0:2c9:7343:71f1 with SMTP id
 98e67ed59e1d1-2da8ef06ddamr1214084a91.14.1725421121098; Tue, 03 Sep 2024
 20:38:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903171514.201569-1-carlos.bilbao.osdev@gmail.com> <20240903171514.201569-3-carlos.bilbao.osdev@gmail.com>
In-Reply-To: <20240903171514.201569-3-carlos.bilbao.osdev@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Sep 2024 11:38:30 +0800
Message-ID: <CACGkMEvHU0VnOEZbVnEr1SvmOF5PhMtKk=M2o7Wwq-DUO9p7Uw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vdpa: Remove ioctl VHOST_VDPA_SET_CONFIG per spec compliance
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, shannon.nelson@amd.com, 
	sashal@kernel.org, alvaro.karsz@solid-run.com, christophe.jaillet@wanadoo.fr, 
	steven.sistare@oracle.com, bilbao@vt.edu, xuanzhuo@linux.alibaba.com, 
	johnah.palmer@oracle.com, eperezma@redhat.com, cratiu@nvidia.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Carlos Bilbao <cbilbao@digitalocean.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 1:15=E2=80=AFAM Carlos Bilbao
<carlos.bilbao.osdev@gmail.com> wrote:
>
> From: Carlos Bilbao <cbilbao@digitalocean.com>
>
> Remove invalid ioctl VHOST_VDPA_SET_CONFIG and all its implementations
> with vdpa_config_ops->set_config(). This is needed per virtio spec
> requirements; virtio-spec v3.1 Sec 5.1.4 states that "All of the device
> configuration fields are read-only for the driver."
>
> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>

Note that only the config space of the modern device is read only. So
it should be fine to remove vp_vdpa which only works for modern
devices.

And for eni, it is a legacy only device, so we should not move the
set_config there.

For the rest, we need the acks for those maintainers.

Thanks


