Return-Path: <linux-kernel+bounces-182567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3818C8CCD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 21:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54323B21B9C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9EB140362;
	Fri, 17 May 2024 19:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gK+Da7Ju"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A3213DDB6
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 19:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715974055; cv=none; b=YLeY1ztCEYAnHiTvByMDtLwk+YCGdB5fK4zgpzUiToIUlhzbihUMKySqhRAz6JoF2u1bgMZqj9pZfj9PRagVw8+fjTwxVr9axEDenoZrGafEmj9VzbA2TQSbiUszqtVvEIVprcLOlx8CvA/rOFcMahY+079R55j4NRJVJof0z9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715974055; c=relaxed/simple;
	bh=CVOfe6HurJ+s0lhFU90cNX8PIHkgmC1d0AOkoT6NrAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfqzl57hda3gCrOiL+ljKkXmjP23b/44svqR7MZDEt9HjUne0JLfQO9TpnvE+pYy8UxwbCae344EdFbJGKjGxle7aUjmxedg9DCckGOn/hq3u0365Zct77RWOCYFIY9Z9KuvrSmxF7pEPSLi2kjDcE/QeeoIlb8Vuw/LwBfw8Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gK+Da7Ju; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e1fa824504so11753721fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 12:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715974051; x=1716578851; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T9M6F97XE4rXzWiUArT6i3Fj8MiLIPSp5Zokso35LN8=;
        b=gK+Da7JuD3WGitINMwhyt6MGHBtOaNjXeI+rJrGPyAkBdpX4sY7tQnV77SYZGMtu38
         3KMRVdGpcu1X7aWv/9/0pNrZJ3x5vSCVmNDPrG4GBbxyF0PhMbW8PNOV4Qgby3cdapAW
         tPoyPUW1lixy53Li31MiBOsDRTSXyiTZ1koNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715974051; x=1716578851;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9M6F97XE4rXzWiUArT6i3Fj8MiLIPSp5Zokso35LN8=;
        b=ZiKsbxU3XggxK+d1CJaiIWWUkEo9tGHr1muUI+QQ1NxspItCbBP2DTow9kLNgbNwQ+
         VcfRrdGtQe+dYTTNzBIDT8eEbXsycNVy7wzbcqt/LOz1cjYOwRglgdHHJWiwZtUHfzZr
         8RMzJG3/yvVfUDf8g2GQ65KtDakV9VoNZM3nEHPDEZlMWmldYpnaIPHq1zWKh0rRyTmn
         st79Yc7W9LvLrNn/NOPtvqmuPk4kLVcvXsIjRPhQ+UAC4g5PAs4MpJPPaO2gZTTUCN0n
         xbWw0Ru2jckEPpNv/H2YybZzMjGaNR8c9s2JfgvmBDxsowoAr2Q64FqPbaM2pQVz9jKn
         3U5g==
X-Forwarded-Encrypted: i=1; AJvYcCWjbETXBVKKnGh5YgwojiMoe2lj8dLwebi3sKXSdQLXZaKP8W0DCV3rxNRaPjStTKWSSAlUZQTPzYn8eS5WGou6v5FcQDKBCHBPNo4q
X-Gm-Message-State: AOJu0YwyX0qpuEzR/bV2ofARGwDJUv3Id8UY96LU9K4Q/3jRzFVKGcai
	iAISpIysPxcsI6adqImKuDC/2EdIFZYHK0hS6r+Z7OhDeqcPLxdyRNj/6Tv+abi8zt1AsDZTH+5
	endr6gQ==
X-Google-Smtp-Source: AGHT+IE3ciBQR7F4wrgnZiWE7iqiNvBnNFypdEyjvxogf9xV3f4whbGXQkYSCAZ25lAZBp7dzDTU4Q==
X-Received: by 2002:a2e:934b:0:b0:2df:d071:76ed with SMTP id 38308e7fff4ca-2e51fd4ae06mr143375881fa.10.1715974051071;
        Fri, 17 May 2024 12:27:31 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574b6f6c53asm9128697a12.16.2024.05.17.12.27.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 12:27:30 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a5a7d28555bso559051266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 12:27:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/OVsTSa1/8UzcYL6+4Likk2eIL3Q4yGp0P92GI06HYMSSsY8X96Qi3aIo5QjQauh2epVXFe+XQ61OUx6XT/Wf0N5wohX5WtP0MMFi
X-Received: by 2002:a17:907:1118:b0:a59:c5c2:a320 with SMTP id
 a640c23a62f3a-a5a2d581b19mr1527950266b.23.1715974049802; Fri, 17 May 2024
 12:27:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tx_KS1qc8E1kUB5PPBvO9EKHNkk7hYWu-WwWJ6os=otJA@mail.gmail.com>
 <CAHk-=wjdyimk4t2C7xfqLYFX1HUH92yTRTFQXAitJJT+REvF3Q@mail.gmail.com> <CADnq5_P3pR8C=SsZWv85h7rZUxxfoQBeMsNbTWnLpOqeQ-2m=Q@mail.gmail.com>
In-Reply-To: <CADnq5_P3pR8C=SsZWv85h7rZUxxfoQBeMsNbTWnLpOqeQ-2m=Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 17 May 2024 12:27:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=whEo=eTSjAcHWV=cAiBFnRJ3R35nV_bt8uSq=CEKehHMw@mail.gmail.com>
Message-ID: <CAHk-=whEo=eTSjAcHWV=cAiBFnRJ3R35nV_bt8uSq=CEKehHMw@mail.gmail.com>
Subject: Re: [git pull] drm urgent for 6.10-rc1
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Dave Airlie <airlied@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, 
	"Deucher, Alexander" <Alexander.Deucher@amd.com>, 
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>, 
	dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 May 2024 at 06:55, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Can you try this patch?
> https://patchwork.freedesktop.org/patch/594539/

Ack. This seems to fix it for me - unless the problem is random and
only happens sometimes, and I've just been *very* unlucky until now.

                Linus

