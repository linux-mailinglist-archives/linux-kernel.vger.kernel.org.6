Return-Path: <linux-kernel+bounces-398397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 671749BF0C9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B92E282EAB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFBC2022FE;
	Wed,  6 Nov 2024 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="iNc6fAvY"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3704202620
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730904832; cv=none; b=ok8FQp1hDBXvH/OZIbHEufMM2WkGA0Hht1XSWXgBuO78/LhfERms5gHlm1ovldUg7ku6bZ4zIPOHRwxiYiDJf4gTkuSC+Y/IpjoEPL8ZIb+aRzngiwFGAQ0o3tBWyfeb7NooeYcWUjVujRBXpjxcVcZEJUJiynAGXExyOLpKEXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730904832; c=relaxed/simple;
	bh=qd2oxWfj8ZkVoRk1/1WgltaqLpvNVj+hI5ourNOsBOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ERV+YZaObHbF9G2baM2MRtW/sS8vjLQ1wrch3/Uq1FYnMrSYreS/gQuoIaftFGP5dg6e81fVXpnyZB7LqvTGhJTnGSDKA9Na75QBqwO539WztjqE+3D7vO01WulibCSRwcoxmxohEYBW+zfQubtVYeVL5fLuIl4XDiTzdHij/Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=iNc6fAvY; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5ebc1af8f10so2956094eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 06:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1730904829; x=1731509629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qd2oxWfj8ZkVoRk1/1WgltaqLpvNVj+hI5ourNOsBOA=;
        b=iNc6fAvYDeRtPQr95FUNmrazZefk5IUyWYVku8Nvjklvc0w/YVHDAK9739iYEshGF5
         DbtFXsGTDrxtltYCKGm4hQiTJKJh/+49XnAA+gp3Goa10UD6FziCyKvChmqcXhuY0f30
         opVdF3FZbrUa+ZDGmClDzO9LwDDvRx8eMyNrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730904829; x=1731509629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qd2oxWfj8ZkVoRk1/1WgltaqLpvNVj+hI5ourNOsBOA=;
        b=upPVaTVaO604Gd6bPl4qPzyE5YGuXYPl1bBzEeYMml4pj0F1x1OA6ungRsByvmQ08K
         oUd30XDU4tPcCvp8kK2JCCqPiAlduHRckdhbGkxJbAlYT+BQ78sqnrN9rkqwPnhq4290
         b3QUrqo6vSsfQ/QmWsb3yiUWSbMsRbVOzI+wfk3aBNIyDYNjcVN1vSsabKXzA7uuCX4/
         /8j0XPQa37uK2RUea9EI7NFnmSFyhH87Ds502usJXlBfG1zFumHmxRrsocfEaY+Ew849
         f+/bqupEsu53Jy2Qa9M5T0F5sCzgM2OLsRsc66tlkq86ZjKBFRsUlMKctgyjhVNdEU3z
         R5mg==
X-Forwarded-Encrypted: i=1; AJvYcCV9qwyqtZWwH8vh18ZrEwTPlDWN1dlz9umT+bO/SeKXrDvMUDS7tD8w2DB1nbWXQleB5wNO1f7qHJ/40MQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtaB/6boOFEei+IPm1jZoHaGzEulGby8gM5MR+HfEyuhUSryN0
	2X9CUSS8UA6BSuXfGEzw+IHulinaDBY7ESgor2NoF5JWjktyP6GhUAZTQslcWdWCZb0PRCtwY3f
	yIjl4TxkFr4aUpZ9Ln+Xjel89s5Hp/tF9hXDVeQ==
X-Google-Smtp-Source: AGHT+IFa9JnN+t6Lfxkdc0ulgnBmj1ApwylswzSBXd0agEog+CiLEpOj+2CvAIt5HGuebycCh4ZaLZNNY+Op5Y+TgtI=
X-Received: by 2002:a05:6358:729c:b0:1bc:2d00:84ad with SMTP id
 e5c5f4694b2df-1c5f98c78acmr1025710455d.3.1730904828818; Wed, 06 Nov 2024
 06:53:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106-overlayfs-fsopen-log-v1-1-9d883be7e56e@cyphar.com>
 <20241106-mehrzahl-bezaubern-109237c971e3@brauner> <CAOQ4uxirsNEK24=u3K-X5A-EX80ofEx5ycjoqU4gocBoPVxbYw@mail.gmail.com>
 <CAOQ4uxj+gAtM6cY_aEmM7TAqLor7498f0FO3eTek_NpUXUKNaw@mail.gmail.com>
In-Reply-To: <CAOQ4uxj+gAtM6cY_aEmM7TAqLor7498f0FO3eTek_NpUXUKNaw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 6 Nov 2024 15:53:38 +0100
Message-ID: <CAJfpeguvAB-VMyV1Tin=ZDzPHE=P+ac4REQrsn4C5u8uh3+TmA@mail.gmail.com>
Subject: Re: [PATCH] overlayfs: port all superblock creation logging to fsopen logs
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Karel Zak <kzak@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Wed, Nov 6, 2024 at 12:00=E2=80=AFPM Amir Goldstein <amir73il@gmail.co=
m> wrote:

> > I am not sure about the level of risk in this format change.
> > Miklos, WDYT?

I don't think the format change will cause problems, but it does fall
under the "no regressions" rule, so if something breaks then it needs
to be reverted.

> > I am not really sure if the discussion about suppressing the kmsg error=
s was
> > resolved or dismissed or maybe it only happened in my head??

All I found is this:

https://lore.kernel.org/all/CAOQ4uxhgWhe0NTS9p0=3DB+tqEjOgYKsxCFJd=3DiJb46M=
0MF04Gvw@mail.gmail.com/

I agree that this needs more thought.

Thanks,
Miklos

