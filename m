Return-Path: <linux-kernel+bounces-329290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2F5978F9B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 11:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD3FFB22D85
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 09:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E72A1CE6F6;
	Sat, 14 Sep 2024 09:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bGfBo2ZB"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4321A12C544
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726307449; cv=none; b=Y8C+dGgy0bEw1oqDDgVHoyj9WOPNEUVDuHHwXOwQn0jKo5R/A7RoVCIia5mmEitZKkEgYjplqud1oSjfx6CYqZ95QqT7XVO4Va+CBNQXrNewX6nLT1RjQrP2w3VjvCEGBRsJQeYYnFG2gcjWCclWuxHY1gVmRbHudvLHK1T+BsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726307449; c=relaxed/simple;
	bh=zhSneWLXFCVVLqmMTD6MnQSH5pGQ+P7hTFbFd5EsMYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RrL5BhYFE+2CS0W6fUv3rvzyMagUL6O1hdu448rY/If0Qz+wp7f3XsHLvVCy0CHN3FxFCPmFOXQC42MPKQKfkS0/IsoLjdQYSrgLmmpQezggYFjMRskP+eEfJAVsqT2XJvspXONk7p7Ikl4UvVp4MM0SVTVrjkyzPO5eWeA1Vb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bGfBo2ZB; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c24c92f699so2746856a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 02:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726307445; x=1726912245; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0Z3Kfeu0LIfwumusNuh0KHY7evirzDwLG/vl9vmdqxI=;
        b=bGfBo2ZBkppuLtEV7pzqv4JROiB9pTxObLyzdF3M/hy+JT7xVxUVs0dBhQbGiKkgMQ
         AyxbZB58A6REbcv0eiASWERBREQhsdc4SuEk3B6MNHet0DhLXL5jMDoJyAL88nAZWkTF
         RQPBea6nsuF4wGb/ZeA2y5ANDaDbRr3NWudDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726307445; x=1726912245;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Z3Kfeu0LIfwumusNuh0KHY7evirzDwLG/vl9vmdqxI=;
        b=SH4DIAn/Uht/xAQ+ck7NeDJwC7Z/kLo1nkxLy+Jb4hbEljxyWRizmCptEhx8/GWooo
         rWTo5Jvt24pgL0it8Xw7UZI4FDNB6ozliepLKpbtrfSCuTqkFDxumZLqf74cGxghet6j
         szDO0UGFLiogVPgsBXWwiiZcZOtfoo6sQYk06o3MxOw5VoVGrAQesirpUpgSYA52c3tr
         C67iOxkDhUMuarkgE9xrH3uDXAVF4jJQ11hk92Pl/arigyd9+Nkam3/eoYde64luriDz
         E13tsX9rYLhZlZQZqqjtPHMg/JIsQ3OXsuCiRxTs96Ih2qD/Qdw/b+v8kSAasxDaKgcQ
         BuKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOVxL9iQ9AgmYvvjz2JRKn++gSPctlUWICbcdmIun8LJxcHwu1y4pRs8dMOmyvsyGTX/iA8aASfMjchgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAenL0bNZfjAaU6Mj4SiKLt1hkU/Y7QZOXmmydgNvYa8TamDXY
	HaQ1KOY09Rz/CFVc8b+/kDDde8KdXkWBrVon35QBWQt/tZaZenTniiZCxAThsiTLoD9G30ZjRqB
	3Z432Sg==
X-Google-Smtp-Source: AGHT+IFMg7yVZ54o8vdq0exrFgz7KRTucr91/QhJgDFkx1049mszJsElDTr7LNKc6wlDD3k27MhPFg==
X-Received: by 2002:a05:6402:90d:b0:5c4:136e:cef8 with SMTP id 4fb4d7f45d1cf-5c413e1b38dmr7407092a12.16.1726307445000;
        Sat, 14 Sep 2024 02:50:45 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb56b8bsm498654a12.38.2024.09.14.02.50.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 02:50:43 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c3cdba33b0so3531929a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 02:50:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZ2sHtQp5KevuM9MfYB88fYI6NbrNVMKfXcEE5luLXv2NjbF374jCdkVTMGCjQ5tetLFCZAxtZ5sWiajI=@vger.kernel.org
X-Received: by 2002:a05:6402:42c5:b0:5c2:6a7a:5795 with SMTP id
 4fb4d7f45d1cf-5c413e06c05mr7363046a12.6.1726307442755; Sat, 14 Sep 2024
 02:50:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87ldzubqgr.wl-tiwai@suse.de>
In-Reply-To: <87ldzubqgr.wl-tiwai@suse.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 14 Sep 2024 11:50:25 +0200
X-Gmail-Original-Message-ID: <CAHk-=wi+31+ctjVhgVww4MN9vD=vc27uw_KepbufhgzxaEHViw@mail.gmail.com>
Message-ID: <CAHk-=wi+31+ctjVhgVww4MN9vD=vc27uw_KepbufhgzxaEHViw@mail.gmail.com>
Subject: Re: [GIT PULL] sound fixes for 6.11-rc7
To: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Linux Sound Mailing List <linux-sound@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Sept 2024 at 10:15, Takashi Iwai <tiwai@suse.de> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.11
>
> The topmost commit is 134536c21275bb3410cd1f10c5e369d30702741d

-ENOSUCHTAG.

I see the branch with that commit, but no signed tag. Forgot to push?

                   Linus

