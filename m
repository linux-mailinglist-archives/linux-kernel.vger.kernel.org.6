Return-Path: <linux-kernel+bounces-172656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FB38BF4FB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 05:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6871F1F24ECC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 03:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D57D14A8C;
	Wed,  8 May 2024 03:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MbaRmWjT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935F711C94
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 03:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715139251; cv=none; b=lDD5YdmpGU8D3do7dl/YbhfXvAweLVizUj+/6lCcn1bbUqTL1OndW7Y/EHcXn+EXBD3zrDoBpTVfPWUldGGVfkpQDYpKp00YpHO64G6YsgGQa+2+PNisdrisD26ulmsLdZxUli3JPELbd2fjOFFJvjYNzWqUF0acjyUgKXUbz54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715139251; c=relaxed/simple;
	bh=DP6Las4iyZG1q0MTdVif5tZZCnRfjH1q6IbNjmsqxYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Th3hbfjpl4ZNJQO8mPR9yPRbvN1jBn+fsiuardO3nl2gOG556SU5i6cromQpdFbmIBDvBDXV/KRiQQwlAMysR8hMgFh9aFTq5DSPhXhvpxXBR23R//3YPERPu2kXqp/k0tdMVS36Xn0GvxYRz18XkK3eYmGax6Je8YwgwcVie9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MbaRmWjT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715139248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVoTuCtEO04UuXZtxxmuRZe0x7MbxM+VBY2AhWXNg4I=;
	b=MbaRmWjTVv08Ib8AvSnDQqsO00cWuogQDYl0jGtLO6KtL2AHNpzXsKAXZFyNyV8sBc/Vwx
	QTltuhO/2jhXgfncL727H6cbgxlxwB1ZSOy/fhuLUVTFn8kS4pF1cgwQthHJaWI1JTHU/x
	bDqHyW/LM6YbrDgcuR92qtZ3GM6FTGY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-EP-KsJxJMzuMhKRxzpf_5A-1; Tue, 07 May 2024 23:34:06 -0400
X-MC-Unique: EP-KsJxJMzuMhKRxzpf_5A-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2b4330e5119so3230380a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 20:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715139246; x=1715744046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVoTuCtEO04UuXZtxxmuRZe0x7MbxM+VBY2AhWXNg4I=;
        b=Njxu+3rwrZ7/cJ11IxZsb73vp4dhLXDiSAu1eT2MlI5DtECgrZxDDnpy0ALiSgE79t
         SjRkQMUbtti1E/dnLDI1q0YbHdnxCKgLH9IAy5C8gXvmBBR0vdR79jvGAopvFsJq2iEJ
         u5ejPwEcDMF/LyzOCmV/FKGf/y6suGtlnoO/27J59M1EjKJRPL+Ci6R53oXBM014JurD
         kdTcXTiJ4lSI1f3YywV31utCn5fPTcVLdtTRluzWiRvwGhC9mWj+7TV8ngL4wIQTB7yY
         Fb4mlJPLV5/+Cw4aGo95V++qduT89u4ciK7uWmC33oQIrpw5Ub/n/fT04U8hXU+AvHux
         E++g==
X-Forwarded-Encrypted: i=1; AJvYcCV4aGuKxUjQGQOaGKYgyQFWLYTTyv87Wcc1FjDcZCwrolrwRyDnnw61f0WgPFK/QSUJyMqZbb463uqP7ENz1hRC8+aMH5aoHYqThwnb
X-Gm-Message-State: AOJu0YwwWa4HGY/N97tA2VYptBfR7+h0v0u092bPK1J/xWRlwphzCU1e
	g19FGpfcPUGvJ7S/QS62NUZpzJUqq950skEplP4JV+p7ASfuc71GXftU3LMaMvdAVP/HpijU/k6
	ZrwR+lMVemW+rmWqo3+eJyQTMo1zDFB4AbbgukyxY5lXt4UHJeiGVkZnHfNBGw2eY4IgZxupeyV
	0e/5uYrLORRRoISpoP+KKKVPjiQQFicCszT3gk
X-Received: by 2002:a17:90a:d389:b0:2b6:22f0:844c with SMTP id 98e67ed59e1d1-2b622f084b7mr792397a91.36.1715139245915;
        Tue, 07 May 2024 20:34:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENt6vTm33UPU1sy7DBoAxP6qJq6T11Q72VgjODyJxDUQJbMYjoUQ+ibtt99fcAnsizkczIuoJeHi+xqDRM6Rw=
X-Received: by 2002:a17:90a:d389:b0:2b6:22f0:844c with SMTP id
 98e67ed59e1d1-2b622f084b7mr792374a91.36.1715139245577; Tue, 07 May 2024
 20:34:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13a313c7-c214-4d49-9029-c79b503c17dd@canonical.com>
In-Reply-To: <13a313c7-c214-4d49-9029-c79b503c17dd@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 May 2024 11:33:53 +0800
Message-ID: <CACGkMEtZEeObDxcVBnvczLFGm1=13=tz_4mJGeXMw+4JgGWRpA@mail.gmail.com>
Subject: Re: [REGRESSION][v6.8-rc1] virtio-pci: Introduce admin virtqueue
To: Joseph Salisbury <joseph.salisbury@canonical.com>
Cc: feliu@nvidia.com, parav@nvidia.com, jiri@nvidia.com, mst@redhat.com, 
	yishaih@nvidia.com, alex.williamson@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Francis Ginther <francis.ginther@canonical.com>, John Cabaj <john.cabaj@canonical.com>, 
	Catherine Redfield <catherine.redfield@canonical.com>, 
	Ankush Pathak <ankush.pathak@canonical.com>, Chlo Smith <chloe.smith@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 4, 2024 at 2:10=E2=80=AFAM Joseph Salisbury
<joseph.salisbury@canonical.com> wrote:
>
> Hi Feng,
>
> During testing, a kernel bug was identified with the suspend/resume
> functionality on instances running in a public cloud [0].  This bug is a
> regression introduced in v6.8-rc1.  After a kernel bisect, the following
> commit was identified as the cause of the regression:
>
>         fd27ef6b44be  ("virtio-pci: Introduce admin virtqueue")

Have a quick glance at the patch it seems it should not damage the
freeze/restore as it should behave as in the past.

But I found something interesting:

1) assumes 1 admin vq which is not what spec said
2) special function for admin virtqueue during freeze/restore, but it
doesn't do anything special than del_vq()
3) lack real users but I guess e.g the destroy_avq() needs to be
synchronized with the one that is using admin virtqueue

>
> I was hoping to get your feedback, since you are the patch author. Do
> you think gathering any additional data will help diagnose this issue?

Yes, please show us

1) the kernel log here.
2) the features that the device has like
/sys/bus/virtio/devices/virtio0/features

> This commit is depended upon by other virtio commits, so a revert test
> is not really straight forward without reverting all the dependencies.
> Any ideas you have would be greatly appreciated.

Thanks

>
>
> Thanks,
>
> Joe
>
> http://pad.lv/2063315
>


