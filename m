Return-Path: <linux-kernel+bounces-424708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9129DB85B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE9B161068
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCAB1A38F9;
	Thu, 28 Nov 2024 13:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="WfukNIsV"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34AF1A0B04
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 13:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732799527; cv=none; b=et3VA6l+CpaMvUxw0mfzTzYmQu3lvGHCPso0eFEHugKermUFYUZ2ukQtozu4RHy/wnBPXraXFaRgn7s8WJEarA6M+otL5mw2AtauYmqxMbDy6P9bODY+TevOQye9Z6uEDs3GKt++NIQW2CHPpFHqRVXvLibInGcU2ieoU/IuK7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732799527; c=relaxed/simple;
	bh=RSVSJUlGidziblJUxiTLtOwxA2rGIZxQe7Q2HII3bj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZnxDa522p0DcMKVkY8Gi8GvUV4QkpHssb4mKIoOMQ3IjHB3bcCUBlaCpRM5mbjtOf2TC+d1tO9NrfnADo3y6uPYLRGAOiMzT0iBKNtv4xx1Xqd//Vdnv8jm/d2AGHsYUlaLKWYYeDBQUqvJBebZqSGQpbcwaa9PqbsJqlJkomv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=WfukNIsV; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa520699becso117670166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 05:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732799523; x=1733404323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSVSJUlGidziblJUxiTLtOwxA2rGIZxQe7Q2HII3bj8=;
        b=WfukNIsV9w1A3v+mw5nsNNGLg3DrszqV88B17Wa1xUW8EJiUhdVcU//VgGFMj/Jz96
         GF9O2csXZs8Z2kb0JguNrMWiDGhi9wq0dfqxFDDypRsLqium2sIuL86GQ6tiNkroAaYp
         RW1XBGvs56c2Kld6Yrp01H6QCV+pZWsA2oMr4M6XWYkagFtgEXa2bv6FPW8yv8AynsCo
         iYjDaz+qB68GVq7j/Gma7sun0obGNEv7dWWoemReGeySGsabntUoetUZqWgmApVVZzHq
         n8RA0fYpfksyd3AtwwNgzhap4X45hzocTuCln6s7n5s6EPpcml9aV84MnA9lCXFTKVM9
         O0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732799523; x=1733404323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSVSJUlGidziblJUxiTLtOwxA2rGIZxQe7Q2HII3bj8=;
        b=B10IbDclaxYNKfGoo5HXxplEZIiFNvzHOr6wa+InrbJM3cjjomBT+O59HHIhNR1YJF
         DkDFWZ696TB+81gO6ArLwpsCT11/7K21R1yCdujwMIwA9OSw38fN8uZw53nHEyPluQbi
         pQkltZ4ux3IJrycTj9WyjMop0336CZg8HqOsowRRQk0SUAcgs8/gAlwdsDZ77LnDCBw0
         I0e7K/hPN/lHLmPRz5k3iMoJF3DMZH5xR6eyVreWBMckIUSD0mv0SpfTh9x7AgVaD6HK
         OkFp1zJuh/GAaz1x8xNf01l8A2XplMAZsOk0Tc5i1E7r9kkiYCQpvmY09ThSR2FMOIFV
         JvMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoHRowBKU4pTbIIvFQQMqqeBUhUyqJ8Sb2l1uTnY+SGxIFoLei/mJ/3ib+eXE1QS1qBZj9aQPrAj0hNyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGJfgVwiy5XQ3PAfEQfzAcuhBPiwmUnvoNJVMCeQvGJvTBcaMv
	YtnmxW3BLcyLHmp2NnGlogNde94o3Op51kxpgLUwjHcGN/pVZdMb+N5majBwYWR2UfoGM/SzjkH
	XeCwKFHyhH73XWH8LwDBlErSqu36f858QLqoy3w==
X-Gm-Gg: ASbGncsa8q81l0omQpWQ1fI9qzuLT2G4d5uzDCWTzxmTxoWU0YGiHDfOvJR5E6I02Gx
	vNvkTn5WziTV0S5qmaRt6N5eBOarQOEyqrvfKGJG528VFpcgnA4TDcpOtxcLl
X-Google-Smtp-Source: AGHT+IG1z9xD1ww7s3NzrjYICCANEgPUfErUCJ+27Ulo0O2S8YfixqzsbTMswQj+hKgVIkE2rjhXF92c63MiUh+CN0g=
X-Received: by 2002:a17:906:1db2:b0:aa5:459e:2db with SMTP id
 a640c23a62f3a-aa581062652mr505113866b.53.1732799523286; Thu, 28 Nov 2024
 05:12:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127212027.2704515-1-max.kellermann@ionos.com>
 <CAO8a2SiS16QFJ0mDtAW0ieuy9Nh6RjnP7-39q0oZKsVwNL=kRQ@mail.gmail.com>
 <CAKPOu+-Xa37qO1oQQtmLbZ34-KHckMmOumpf9n4ewnHr6YyZoQ@mail.gmail.com>
 <CAKPOu+9H+NGa44_p4DDw3H=kWfi-zANN_wb3OtsQScjDGmecyQ@mail.gmail.com> <CAO8a2Sh6wJ++BQE_6WjK0H5ySNer8i2GqqW=BY3uAgK-6Wbj=g@mail.gmail.com>
In-Reply-To: <CAO8a2Sh6wJ++BQE_6WjK0H5ySNer8i2GqqW=BY3uAgK-6Wbj=g@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 28 Nov 2024 14:11:52 +0100
Message-ID: <CAKPOu+8H=cGbY4TgoT4bZvWwFPH7ZQ8MioMUey+nJvb0my4xUg@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/file: fix memory leaks in __ceph_sync_read()
To: Alex Markuze <amarkuze@redhat.com>
Cc: xiubli@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 1:49=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> =
wrote:
> The ergonomics and error handling on this function seem awkward. I'll
> take a closer look on how to arrange it better.

Does that mean you misunderstood page ownership, or do you still
believe my patch is wrong?
To me, "pages must not be freed manually" and "pages must be freed
manually" can't both be right at the same time.

