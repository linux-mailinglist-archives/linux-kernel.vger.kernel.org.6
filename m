Return-Path: <linux-kernel+bounces-387985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 065B89B58C5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 01:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0F7D1F23D50
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD22208C4;
	Wed, 30 Oct 2024 00:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrbH85Lb"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F081803A;
	Wed, 30 Oct 2024 00:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730248968; cv=none; b=DyuEiLCQgkFZ2xqkmRia+ndgWYk9SYxM7C8BFZIv6SnvpW0swNR1nJpxUaUY0sq6JWaLrzI/M7BTGRzWPS0J0C3by3v6wHciFKdUIztGlSu9M+DTtl6VRLeaoRVyKJE0lNfUHUhMzfK9uiMgojNS7yB215porW/a4gzOJi8JOIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730248968; c=relaxed/simple;
	bh=G6pXtqDbWcDeV22YksqQNnDdrZO/RSVIYwoOTh119Vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpMHFbt7a5g/aT4XgB6Rj8glxqsO8P0DAMMdpnY6ADEM09O6TkhyNqpwqk5IRAj0Bs0Woi6Z97enqOAjk5pcOArfnVOb2HrMD0hxwQbi+uYUNBvn9NDfe4tJhebBpf6c6GFkQ2jMk0sk8hy47K2tUI+lNi3PTG7u5Is2R40UOrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrbH85Lb; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb3ce15172so3678141fa.0;
        Tue, 29 Oct 2024 17:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730248964; x=1730853764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6pXtqDbWcDeV22YksqQNnDdrZO/RSVIYwoOTh119Vk=;
        b=KrbH85LbMTf76iTxlcAIhe6kCbLBTW/g8dM7I3EnJ5edsqFCfAu5HdMvrC9E0M/MwS
         +YbgXvNgBvP5NQ+yKTF8KKWSpIG2HPVtwTeJsksnPLUCsrpUqxY2WJLfMCA0deXySYEs
         uex1hbdmPo83XCIn0TNo3+SgCChYXdrdDvX5V9fapHZobzPWglK2xkWdnPffv+D0ml7k
         p6+jhWj+cNhOUx8VjPk2q+MKmwLdFcGNTrVa8fqidmOz06NoAzbYM9zzEnHiimsyd/rB
         DX8Ts62ZtlHuoI6p2DKQ8fhjiWCxjkj0RzufI833u2HbP0vxe2LxSIr8nSRDmdN4QNvu
         9bqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730248964; x=1730853764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6pXtqDbWcDeV22YksqQNnDdrZO/RSVIYwoOTh119Vk=;
        b=VgiO9baN990KTQrrcZePvPAwc0D2ad+Jzc8ooLEd25Q2A2iRPY9FY420CF7MnhksEm
         E8tIr59vxFlfV7PijmebCkR881NNm9GP+qJFgSMDgjVwibvX2cBViBHB5RnoB7FbRI8B
         XDOydJwIhWajJjaRU5meVerl0FXcI8CJj99wGcA0lp+bnxNLvcfWAbYZ7mAJ7S+jffYd
         68AlHIsyluGkYTz4C+ozjtJqazg26cUaLcWKCgi7c1VK8i4z64F8hnupWFhkJ9SsjtrE
         8KOMrQnSksgGQHGcM9TUdwyevEwisPv5vOZXU6HiJXuK2jovo1RUqI/N1kg3GYuFiYfm
         YIjg==
X-Forwarded-Encrypted: i=1; AJvYcCUX8qPQx0hFUk3dV0j2IdzOGWLZ2jk7aVgHpfiODo/OAkQqq+LHXuKZREsnweViK0EtDwl1TpPnyuOyF6cM@vger.kernel.org, AJvYcCW2GChWL4z/Xw/n8s9ugI0H1vox2fRlI2nah0fV6IG61KZhuB0zmAeD8SDJ51HH+9Z6pK10oaSMDYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YywQ4NS8pOUM8FUWQgRmraQAaPAYvYiTvSqo4KIjPVsXeuVrT2O
	qInTp5Qct3Yd0ZG4TGBIo4lPc6+1Pn+pqzoNjbcK4RwQx2KV59tezsUdCAPuG/W1geNHKuq84VQ
	+bVKwKDr1lK75GGZlxB54xZgWaUo=
X-Google-Smtp-Source: AGHT+IF7mMFHpRn5rNFNndl6sTpmrs/eEo4YNFU89kk2OyPoF/Avm+YE5Ft460RWNEreDTOvEq9F3Snk/9pwZSGlUJc=
X-Received: by 2002:a05:6512:692:b0:539:fcf0:268e with SMTP id
 2adb3069b0e04-53c3161741cmr161028e87.14.1730248964012; Tue, 29 Oct 2024
 17:42:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241019195534.79603-1-yesanishhere@gmail.com>
 <20241019195534.79603-2-yesanishhere@gmail.com> <ZxsSvbXXiwNAHCWX@archie.me>
 <CABCoZhB62CKhCnZTCgTAhEh27td4Gw6XjJ-uYQJRqJuN9NPqmw@mail.gmail.com>
 <CABCoZhDUajW-L6LdbwDHcHcNcQGSRbzO=bqyOZfMwjoeCb+p2w@mail.gmail.com> <83df1d71-dfbc-49c9-a6e6-05454cac2ca7@gmail.com>
In-Reply-To: <83df1d71-dfbc-49c9-a6e6-05454cac2ca7@gmail.com>
From: anish kumar <yesanishhere@gmail.com>
Date: Tue, 29 Oct 2024 17:42:32 -0700
Message-ID: <CABCoZhBvcqgqaky1YyrLKHBQDFNc4F6-PJwZQOuCoLiD-D4gBA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mailbox: Documentation: add the latest documentation
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: jassisinghbrar@gmail.com, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 4:51=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> On 10/30/24 01:06, anish kumar wrote:
> > Hello Jassi,
> >
> > Gentle reminder for the review.
> >
>
> Reroll.

Waiting for him to provide any additional comments otherwise
I will have to upload a new rev after that.
>

