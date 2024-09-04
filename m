Return-Path: <linux-kernel+bounces-315386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5141796C1F8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 841661C2417F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7491DCB30;
	Wed,  4 Sep 2024 15:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="mckSfOwm"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B251EBFFD
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 15:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462956; cv=none; b=IedKIFkLlbElYpjDs96bcnmrIBWAb4jXOukY/SV4hjnuEqSPHnk4g6j/SsDrUTChOp36QlkhhhXkwdAlcqxitR/9Q0KZLKSqvzG3QZ9t7Y6+DEUsdf4HLxQ913cahvtFf2+uRtzyIo+7YTpnNgczKcEZt3Zv6gg5xDia1z9x4Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462956; c=relaxed/simple;
	bh=44VIprjCYxhe78ahmsvk5iQ53uqpSS391gbqLmt67fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXH/xeuO1+1xYmIWhtZIlk/MmFhRqcLn3y2WQVJQH8oZFEWhvVCHoo5v65U8sgWNW98jE4GK3ZLCEaWRa0UnRU5tZZNx7XYgV6rVfzoTaRxG7P8V6e7497XvgDLZSCVooMthwraQdEUfMfQVIBuTB4pRmLihEc6OkfmE+UmK/RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=mckSfOwm; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5343617fdddso11591687e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 08:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1725462953; x=1726067753; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=44VIprjCYxhe78ahmsvk5iQ53uqpSS391gbqLmt67fk=;
        b=mckSfOwmfpzwG96GIHoZuDMoR3aGdJm6E4mEUBITRwesUSlz++yQ/gOc+vLPAuklRx
         lmt+2XFc9ahczwVmAJKyqf/68dp9VdarRNgVjZTz2iS61PKia0HM7wUQLpVEp21t6oen
         oehyw9pIW0iIjfNOSecMz2bXnUgKo1yJwUkrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725462953; x=1726067753;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=44VIprjCYxhe78ahmsvk5iQ53uqpSS391gbqLmt67fk=;
        b=Uu7Nsudddj3uIFL+U65LmjddCWRrrDG2VJMbm1b3bI2/ERp3PiiPA6mnxYOFkE3A9E
         nB5PN4+gp+sLO7XML5bvE/aaFr+63BeYxdWZ1B9LQsdxZR6Td9Tm/BrR56ckT8akzEqm
         C+h0+YkBltfNzoLu+4OI3LBoZWxktecXkGksZr7YCFmNFgWMtQCkOdMMP1XmAXJ/V1PH
         yWbqYaC6d1s7kqHDi8attXD4TD7FpI0+SZ44fEF6dRIpVT86hynQL6SjH1UwcoZo4uwv
         D/lzPhHfZW5hfAv4yf6HZDiDZKfTvRkajVNG7s02F6p/9BapycXryr74c2XtlH9gzqtX
         HPrA==
X-Forwarded-Encrypted: i=1; AJvYcCXPNMyTaC1ds2l8Q8aN1TzMTSA3Mp99lReXdo6KkUIgH17zr3JnAfaVaUFbmAZjD1uVZFBKOpfL/ZT/dNk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6J6xfCr61tbNVrvfPMubKSKEivVnRUZL4Wza3Lh+ripuNP/qZ
	usyCxw0rtty41M4OmaA3mMOgloV2Hr+crVvAat54Tqr5a6z0CprX9ptHneHpP89FCe3SdrlA9FU
	dNwU/tGE8kSwxQrcHoQsk4j2URLDxDXUWMeuJUQ==
X-Google-Smtp-Source: AGHT+IFd5AubgTZT1sWImGPdUe0O91LhcQhJNlWdLwiS1Elxh07YXmiWxiKAx2HMXiZMG4se8lmRg7tLpoCug8mkE20=
X-Received: by 2002:a05:6512:b1d:b0:52f:d17e:46b with SMTP id
 2adb3069b0e04-53546bfc7f6mr15804416e87.54.1725462952496; Wed, 04 Sep 2024
 08:15:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 4 Sep 2024 17:15:40 +0200
Message-ID: <CAJfpegsouKySsJpYHetSPj2G5oca8Ujxuv+7jpvmF57zYztbZw@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] fuse: basic support for idmapped mounts
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: mszeredi@redhat.com, brauner@kernel.org, stgraber@stgraber.org, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Vivek Goyal <vgoyal@redhat.com>, German Maglione <gmaglione@redhat.com>, 
	Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Sept 2024 at 17:16, Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> Dear friends,
>
> This patch series aimed to provide support for idmapped mounts
> for fuse & virtiofs. We already have idmapped mounts support for almost all
> widely-used filesystems:
> * local (ext4, btrfs, xfs, fat, vfat, ntfs3, squashfs, f2fs, erofs, ZFS (out-of-tree))
> * network (ceph)

Looks good.

Applied with some tweaks and pushed.

Thanks,
Miklos

