Return-Path: <linux-kernel+bounces-522394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47328A3C99F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFC1C16D973
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DBE22F3BD;
	Wed, 19 Feb 2025 20:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faiwA7L6"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7891BE251;
	Wed, 19 Feb 2025 20:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739996631; cv=none; b=hm/QutW+pWNemjSfftPJXBeWpkPEIBx1FBGHAyyNWxca6J5sKGpOE0SUlBwkM1J9YEKshki7/L6jZRP9RRdl8twOt+eiVU+afiCbMZYRDhRnzuIxwGG99yD6/MU3+oWjtE4+Vy6ypkEeh5X6YurxP7wsy5n/tuyZo1tCrOg2iiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739996631; c=relaxed/simple;
	bh=RTVKhvTQg+qUrNY+YEt49jXp0PAFjJ+Vt74JxKMhdf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QlrwkefJIPD3C+n4kSnpNdZWWTVJw12Yzvuu1Kx9cXa1tfZJSj0GLh4wqY664jdXiQg2zxoy31RO5YefKLCagEIfCw76cXbmkFUl9sGY2bIWhFyGvPuh/OwOCSOff91grUfX89+VLGUKvi+8V/qw6kappyE1sZGszB9vsH78fc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faiwA7L6; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e050b1491eso2353213a12.0;
        Wed, 19 Feb 2025 12:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739996628; x=1740601428; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8C9FDgpCO5k/lG9CyZPK4deI/6T7YtN9NRCiQlWA9Hs=;
        b=faiwA7L6Rx+FnYmqZ1Guq+PR446JTv5SQh0TQimXFiQ+bG50HeGLBHgjvcnnK85IVQ
         0/qBgcealHls3IM5wCi3hF71z8ulbRlphD3YqEYROkbjRyOQ0c32xYCmMTnYHGFhGSh0
         ZYehUjkeodvJnchOO7+337NnmIFShBJ1ZKmfstXf/JFN+i3dBfUHmbjoRF0p3JI3LvKM
         ssyMybxR9isRAJwjXhe3kaSSaYpA4rskrFnC/5XWulWOksX06kb1rFdRY6mGqEP5SNZI
         6hi628+RovjyE1hV9gj2FINCjmJPS+2QQKjZat/WL3RdhwL6YFNWb/dWxLpsvJbawkUJ
         zelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739996628; x=1740601428;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8C9FDgpCO5k/lG9CyZPK4deI/6T7YtN9NRCiQlWA9Hs=;
        b=tErcxg6PQbs8Tx2TSU8j9ioOBKmuGXlHDin2g0jTj10G5+fdydyevoXodTpdhiV7Cl
         n1kEtMOE82If/mOJet/ln7MdiEkgwA5P6mWJNlg0R0jeQIZV7cU/kIflAAU9An9WW3Sf
         z3oPh5UUo0YmF6zVJaDI7cErA0c13N3PupzCdmDigny76tOCVrPcjRB7fAfqeNsy1AtA
         Sq5qroRUgX+WFAGE7F0ihaqaV9wEYanr06XKedGMY7W6Tby35uFAggugaexbuR03ny4j
         qQU6t1yF06OovU5W4hXL9KwpcNq+6cQ0CITUwpDEJhWNraHpRYOZEGZGEFJyDPnI8LGl
         PzJw==
X-Forwarded-Encrypted: i=1; AJvYcCUajCoKtaCIF/9RJtVYK4E713AxFgixJiuQ09/1scq7FNt6ZKo8PBgDCPoKRLrAAI9w1zZKu0gMi+Qa4vCOKlI=@vger.kernel.org, AJvYcCXby4yexJFlyr8R7+cgibus5H4G6mY4RTVdzOWnpkajRoNfEWBm7YtYezr+xXywj6HCYLRqROc5NGCWLFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtwbN1JFhRXJ7VBZ2HKr2PXEiGAxjNJMDgsZzxZsO3IK609Eu4
	UJeR07du+valRmZovzbhMIlECTUb/fkn2n/Qk6jH45p0Kvvt7Gu0vS8yRZhhPVwZhdJrxniKYQd
	5qiLjS15KBVtEOCu4r5pfh5e5FIg=
X-Gm-Gg: ASbGnctOUsZIFpLl6/OKiwKhQVopNmjijLoNn3bSQa8HuqqmPxtVnERLUG+AAEHnAsB
	gs1CWv/EjfI52vkiIcvnRb10kaiuRH0Mlu4Ttfgv0mSSLuU8uu7G9RQ5TFjj+OaDuJiqtmmo=
X-Google-Smtp-Source: AGHT+IFTlPvg9QQaaWG38k9pWnqwqUxFI4TWfr84YWgQa8VYHZrfD/59IaIQj2pDGyJZK0qQXwPO63XKwpHnAgwuThw=
X-Received: by 2002:a17:907:770b:b0:ab7:b7b5:2a0c with SMTP id
 a640c23a62f3a-abbedd2f416mr55624866b.6.1739996627857; Wed, 19 Feb 2025
 12:23:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217-nova_timer-v1-0-78c5ace2d987@nvidia.com>
 <20250217-nova_timer-v1-1-78c5ace2d987@nvidia.com> <C1FF4314-C013-4AE1-A94E-444AFACDB4AC@collabora.com>
 <D7VLMD31YB0V.OKHDSVUPAZTE@nvidia.com> <1b8921d46f7d70c7467ea0940d60220f05cccc5d.camel@nvidia.com>
 <D7W119MHCCWH.IS600FTIOV8O@nvidia.com> <e6322f90-08bd-4e86-8dad-2ddbd7e5cece@nvidia.com>
 <D7WFP99SMV3H.26AJWK17S0UPX@nvidia.com> <fd920faf-a707-4c6d-8c0b-3d59c010da1d@nvidia.com>
In-Reply-To: <fd920faf-a707-4c6d-8c0b-3d59c010da1d@nvidia.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 20 Feb 2025 06:23:36 +1000
X-Gm-Features: AWEUYZkOfBGae_62O2RzZAhPDqSPHCfH2IsqaSVq-HA6ddj2SAfSDh8cunMZ-t0
Message-ID: <CAPM=9txmQWO+SHnZhr8zXHCZ=S8CNY=PryRVkWWuHyor-ajU6A@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] rust: add useful ops for u64
To: John Hubbard <jhubbard@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
	"daniel.almeida@collabora.com" <daniel.almeida@collabora.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dakr@kernel.org" <dakr@kernel.org>, 
	Ben Skeggs <bskeggs@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Feb 2025 at 06:22, John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 2/19/25 4:51 AM, Alexandre Courbot wrote:
> > Yes, that looks like the optimal way to do this actually. It also
> > doesn't introduce any overhead as the destructuring was doing both
> > high_half() and low_half() in sequence, so in some cases it might
> > even be more efficient.
> >
> > I'd just like to find a better naming. high() and low() might be enough?
> > Or are there other suggestions?
> >
>
> Maybe use "32" instead of "half":
>
>      .high_32()  / .low_32()
>      .upper_32() / .lower_32()
>

The C code currently does upper_32_bits and lower_32_bits, do we want
to align or diverge here?

Dave.

