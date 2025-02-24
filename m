Return-Path: <linux-kernel+bounces-529560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B29A427DB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 479DE1641B2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFBF263F2B;
	Mon, 24 Feb 2025 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="YD8RJopM"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C83263F20
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740414261; cv=none; b=kNZLHYVvw+Aa/iay0Vgnh1WPbSTmR+MT1+QrlL13nNJ6jpFuuFF1mMoUWsV+1Bv8XHYy7afVVdj0tptS5d3Z5IqHWfSaAHxNBuluoVwCjw9YxiVoVJZJmlowkhUd5dQH2OeRRehmrB/EGTyNk3TKZKeEF3M6OlPiJ8nM99M7Thc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740414261; c=relaxed/simple;
	bh=f9fqrDm4f4P/5LiKN/iY17TSZ6PnstGOuVc0Ti0nO7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKFM+XJwlFAK/vvMEdk+r+Qvl2JvqutpaKMwEFUB7Uj3wVblVr31MhViAbaydfZ9Jyr3mnxnKBDRDMZtpMK8qb6OTdMQpHAFEkFxVtLZfVamzcGogtesirlTUT2TrCy8Tofkn0edz2mvxoB4B4YAse4qot5oOGe3QiyKnVyVyaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=YD8RJopM; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-471f7261f65so46041841cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1740414259; x=1741019059; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=35lyu+6zyP8UnNWENXatfW2M13RT1ggpz1uxSE8VHmI=;
        b=YD8RJopM2Tk4qcc7ZhFkJdqsnUISOWOOEXznjVIIDqfY022w3NmduMRcK7dvJ4wERu
         qoeIiLFehhbqjzeqEWWNa+g3I/06tm6wUFLCUKpuYyC6+LN0UUFqE+Elpx++RQRRRrwd
         xFgd4Zsv5FMnyU//Im/z+NVQnn8uzbkKL/9Cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740414259; x=1741019059;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=35lyu+6zyP8UnNWENXatfW2M13RT1ggpz1uxSE8VHmI=;
        b=IzB0hV3kzy277XQvGYVOpUnh+qdwtLETReT5IUSDHBMiRrNiuFN9ptRCOjvg7ru7wG
         cLfdKPxbRGV0ob1DARLtRUp4FrDT2MYfptru6/ZjLYOh9K7k5EY7wsItto1CYgXKqz0S
         XXeDTFtwr3m/YNzJJKaBJAOl513UkYZGUoQGZcxR/QFrEcgIm4K3VZN5dM01ucKo8rEf
         Rel8N4vHwuxddyuNbQcsuXldUoTKEl06vSvTPbeseboqxRWYDTQsRC/+JyDYrF5YV5pa
         k/5RQQLxjBd/r62U4FOAUKJr/IH4oQakaeoXGK9G1q6WG4n/DW3yPfzfxx541EfaSUox
         ElZA==
X-Forwarded-Encrypted: i=1; AJvYcCVshEJgtAJDOGUANAfS/9HtRnuyOE2oxIDLauMDzVfk5zZ2CHSSNZFs906f3lrtgOsrIXEFfQaJWQBe3f4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrQY/TRBQn2qWIzcEOM1Cd71YO5pMys51bLmt9zFhkxFaHwZjF
	ywHHeAfYzRqVcvl5Iw+ib1VoRb6TDcqLBPXsMewzYrpl0En7ExJT9K1mgR/ps7YancMf0+nx80U
	poYH1joD9HGOsH8cOGPABiPKc6BW26gWzZCxYGQ==
X-Gm-Gg: ASbGnctDxEh8TSNvPtcv9z/ONbnARy/UrKJV//Xfc+5uspPmBxe1BajJkmv6tqLlQM4
	E23EijQ51sLo6I/uR+C81IWkACJpKwdLq+u8R6k5xA5ESSrbmFqBZiKEXPQyuoIg1mJ5d4KBLJ9
	Rwm8EH4ROy
X-Google-Smtp-Source: AGHT+IE6Ky9EEBFBIPfIG0tubUoMa5hcfqB32/Gfh0yagcinnaME1gRLzoVpVDxXuSsCd6YeSm2PCMrBg8mPoK8nMt8=
X-Received: by 2002:ac8:584b:0:b0:471:fadb:9d41 with SMTP id
 d75a77b69052e-472151469e1mr241920671cf.17.1740414259165; Mon, 24 Feb 2025
 08:24:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKXrOwbkMUo9KJd7wHjcFzJieTFj6NPWPp0vD_SgdS3h33Wdsg@mail.gmail.com>
 <db432e5b-fc90-487e-b261-7771766c56cb@bsbernd.com> <e0019be0-1167-4024-8268-e320fee4bc50@gmail.com>
 <CAOQ4uxiVvc6i+5bV1PDMcvS8bALFdp86i==+ZQAAfxKY6AjGiQ@mail.gmail.com>
 <a8af0bfc-d739-49aa-ac3f-4f928741fb7a@bsbernd.com> <CAOQ4uxiSkLwPL3YLqmYHMqBStGFm7xxVLjD2+NwyyyzFpj3hFQ@mail.gmail.com>
 <2d9f56ae-7344-4f82-b5da-61522543ef4f@bsbernd.com> <CAOQ4uxjhi_0f4y5DgrQr+H01j4N7d4VRv3vNidfNYy-cP8TS4g@mail.gmail.com>
 <CAJfpegv=3=rfxPDTP3HhWDcVJZrb_+ti7zyMrABYvX1w668XqQ@mail.gmail.com> <8e0597b9-d8a9-4d11-8209-ab0f41e94799@gmail.com>
In-Reply-To: <8e0597b9-d8a9-4d11-8209-ab0f41e94799@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 24 Feb 2025 17:24:08 +0100
X-Gm-Features: AWEUYZkAGcL0DMXQBzs_mCpbBAb7pYa17NFtHVcfAECQBfKcOzw6NACtoHMfTvY
Message-ID: <CAJfpegtpBxXk+bJJgXWT8moqTD07DHEdufdNWy51ac9RDUVYdw@mail.gmail.com>
Subject: Re: [PATCH] Fuse: Add backing file support for uring_cmd
To: Moinak Bhattacharyya <moinakb001@gmail.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bernd@bsbernd.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 17:06, Moinak Bhattacharyya <moinakb001@gmail.com> wrote:

> Thia would require a major version tick as we can't mantain back compat,
> unless I'm mistaken? If this is the track we want to take, I'm happy to
> send out another patchset with such a change. Would also need more
> extensive hooking into core FUSE request code.

I thought we were discussing backing file for FUSE_LOOKUP?  It doesn't
exist yet, so no backward compat issues.

Thanks,
Miklos

