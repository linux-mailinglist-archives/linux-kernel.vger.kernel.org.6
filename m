Return-Path: <linux-kernel+bounces-276905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C759499E9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2140283317
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEC316BE0B;
	Tue,  6 Aug 2024 21:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caCXsD0R"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A4413C3E4;
	Tue,  6 Aug 2024 21:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722978855; cv=none; b=dV256sP4UwvWPVI8Jq7y/I48KnC2AmZohtxtvrRXAibXzWs/oGRgboSFZJ7awbHDBZImsAyy7ygrCpLCEO4bsuI0fZgjgv+FhXwIxv6GM6onp/KLyL4CKV8LapzpMCwt0awetu0IVnAScmRUrdktT6t5W7sUSAAt017ar+t3GMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722978855; c=relaxed/simple;
	bh=n3SL6DqMd+Il1p2z5Fmna3QwtyNnTZU6xFan5OyXh2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GzGv8eDB9Q6pe8aiPuZ7uqMxxIu8veCXdmSlDCZ5x1H4lIzSxXKxcSz6bKszyvvvnUVs8Q7rnmLZwghha+wT2iJbVWI84yoga7QY/e/l+jUbxMR8vDVdelPy8dJJVhiby8XiHdwUVkQdZHAP+a6v5qUzeJNotkX3zuG/mkpsWhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caCXsD0R; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-70b2421471aso747240a12.0;
        Tue, 06 Aug 2024 14:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722978853; x=1723583653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3SL6DqMd+Il1p2z5Fmna3QwtyNnTZU6xFan5OyXh2E=;
        b=caCXsD0Rn85iAwJN88et5mpH3Nz2LX9i0g0F+DiVs6D4xpi7jFSvR99VmaDokYOK/9
         by6tExDd6kjWXr+pPRlyPvakxnL6uXUfood1gwW0q/cPTO7mwWF8VRPYX2bKHTwVb0v1
         sbic346LTV5MxRlIjP/2/VrDARXVJmh4otwFxs3sqRvbFjb4PX12VKj2iMr2mSPS10Z4
         S452JMMsIVP0tEBh3Pvc9qV/W6Im8pQ5T3J6Q0xPHVJOha/H3ENSNqcqFWLMSinIRm0Y
         wpspF+qrjtjzGXrBz0PKmxPyiIycMPcgaTU5XXlfhOKsHMXMPciAV0DwwGVAqOFYtPde
         vEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722978853; x=1723583653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3SL6DqMd+Il1p2z5Fmna3QwtyNnTZU6xFan5OyXh2E=;
        b=uAZN1vZynHob+ooERNw8rcEnMoU/5qTsMeGU4h8SL3QVy3P/mCMYOIAx9RfXQAZ7KA
         BHceT28gs04wikS1RrzHSIENEzeH/yhRUOd8yaVE5nQriGuW7WGp4B45K87cM3bzLuIB
         xSLKyIfJ3lvQOK/YbIQhlyUpSTX1vu0k+LOiSqzUnMciJ7wz09JSQ4i2YHOUMifdPi7z
         80CdATzDtrnFDdURbAWeImSuaoqzMXcqBcicJpq2GvrlvfQdZYJr+q/J25LtQRPZTPkZ
         SZXFDyq1WpDgQSX2CNh+8ZBEfeuRaXPFM/qQMBJdaFR7b7srEDILtUx5Xpx74vu3CH9E
         0ykA==
X-Forwarded-Encrypted: i=1; AJvYcCWT/uTwWSsbzSCnDwiFUYmi3c+qje/78qOht+TAaBOM3Qw3n76nKncreYltZIIjSOhc+eu2Brcg7ZCa3Twnmh5ddbpBVwX7uyOPFC3iQIoGRETPXw1i2xOsT8pP6H1ESc0Qr/OqfsFQWkyzBTU=
X-Gm-Message-State: AOJu0YwgHW270k9R2Gjjt+MQgZUTY0m9kHQdnJgm3SLQq1clWzgaiEN/
	XTzcV/9KlWUWmsWD8mRmApEJMoic7TQSblMR9LGWMCrQA+9PPtEz6Whx+AFtEnGHkBU4zCk9O4h
	Us4r9STJehNPh8tWWu+pxvv77Ohk=
X-Google-Smtp-Source: AGHT+IHvbAAL2NcqVlB4Rqy6c9/uB/Hg1OGnq+JeRukgKKxR43dKQDIDjEllPEROqpREAP0g7cYcAjDTNcZqjkTqRks=
X-Received: by 2002:a17:90b:152:b0:2c8:a8f:c97 with SMTP id
 98e67ed59e1d1-2cff955ce55mr15015074a91.37.1722978852967; Tue, 06 Aug 2024
 14:14:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-22-dakr@kernel.org>
 <6HIL4hSg3hOCh5IDDOtdEaEy89ZksSJmSLNiKrSvpu2Q78wA5KdrCCrcPSD_p4jB7IlmVRyVBnvBllU4irzuYgpQJOBtwUInAKdOibtRjVc=@protonmail.com>
In-Reply-To: <6HIL4hSg3hOCh5IDDOtdEaEy89ZksSJmSLNiKrSvpu2Q78wA5KdrCCrcPSD_p4jB7IlmVRyVBnvBllU4irzuYgpQJOBtwUInAKdOibtRjVc=@protonmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 6 Aug 2024 23:14:01 +0200
Message-ID: <CANiq72mc5h1vx+YoX_MxpFcgDEOfuYJNT9986wTjc3oSbVsbVg@mail.gmail.com>
Subject: Re: [PATCH v4 21/28] rust: alloc: remove `GlobalAlloc` and `krealloc_aligned`
To: =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, 
	wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, 
	akpm@linux-foundation.org, daniel.almeida@collabora.com, 
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com, 
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, 
	cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, 
	lyude@redhat.com, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 9:07=E2=80=AFPM Bj=C3=B6rn Roy Baron <bjorn3_gh@prot=
onmail.com> wrote:
>
> This can be removed too. liballoc needed it for us to acknowledge that we
> were linking liballoc in a way that isn't guaranteed to be stable, but no=
w
> that we are removing liballoc entirely, this static is no longer necessar=
y.

Thanks Bj=C3=B6rn, noted in issue #2 (and linked to the new tracking issue)=
.

Cheers,
Miguel

