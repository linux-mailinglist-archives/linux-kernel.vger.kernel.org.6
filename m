Return-Path: <linux-kernel+bounces-299849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C4795DAC4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 04:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE3E41F226CF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 02:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7894428683;
	Sat, 24 Aug 2024 02:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b9/Z5YUu"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA08182C5
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 02:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724468297; cv=none; b=AeVYKdPCU2+jSB/PfgOFkxWEDGLYonMfquY3a7F6TTKpO1n2+mD8hLc8i6TTNXuH5hft33EWf+7+qAQzEdSTMAL8IL0ouUCmU8k3lnpshjtx3jXQVoMb6u0qZf+0/dUSfu2QnlLdWIMM4GHgivzR3//L9ceHF0Dny54EW+oJ+80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724468297; c=relaxed/simple;
	bh=Hezca5d/Hiw2dSGl+lfWfGmJ5GwuSrZGZxIfhqwIlv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z/6iHmYeeRiXgrlvW0D73xcDDf5nlja6E2Kt6EuWl3o7p/xKTqbCpzcoT9IQ2uX3Xl7iqnmYoaf0NnaXReHJYOqH1zzE4ndxSxem0mW12/ENjeEaQNYyMpUPSIfMJJPX8/vUDA1pltaNcvSP4d6KnPpagjLxFmppfiugM/8c9D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=b9/Z5YUu; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-533461323cdso2970766e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 19:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724468293; x=1725073093; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0zedOl8uvkVp44rXL8uYLdQqyjd2Jc+tYGlkUMKlkF8=;
        b=b9/Z5YUuffySd9Ql9bADiNJ7HTGCunMWIPzYBH9egPB1VHKdS/hTkX3NVpWmhkFK4Z
         b9yYCYWVsi85KGrQQS0A+AMd9FELsInydhP7vvaKwPMRDorbX1krG5ztpBL9dUYw0w3A
         hKr/zmQ5X25PCFewVEKHoOVItoNWdDkYFhicc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724468293; x=1725073093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0zedOl8uvkVp44rXL8uYLdQqyjd2Jc+tYGlkUMKlkF8=;
        b=l1Gy0bQXw7Lewj4A5AhCMMiifEoQwuVpIWCY0mvq9ygbqAGpkdRT0kHnjGyrjjXTHp
         1J7hOL2nsgqlc5j6KtHsz4A2c5ce2unIHuSXmaScdEsFW0Nx7FLKlKLPzRDZci1w4e7H
         +2vds8Ws2sM/WylL7vWK3RXOX0bDURMNoUHvKxjVJpJ6/q/CLeSLwg7y39a9ROlrKtwo
         VNGUjqjQTHvW3hhhRUE2Zjac9QG9DP6ctvORFrKWIwA0UWdEUmyfp/mRqvCGe+ZItUsH
         7W29+oxY7PypR5KM1AvUFHdFFBmp9ydtMPflmgXzNNHHWjcVNLy6ylV6uJBbMRh6JA+4
         KRfw==
X-Forwarded-Encrypted: i=1; AJvYcCWnjzHPgc3M71k/hskYEI9RA6rUBBte8dV59V2Nw3JjQLykkrUMJ6EGqxAJpknxUnMn1uqhAHmfW5jouE0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/OwO1hlaYUNdPOJXtRnzC5uyy88Z03aKCJirGk2XkFLvvK8lu
	eIaHhd+vKtzspGiCwISU/L/w5lasxT17gfuEYuFF/IU2Cc4Apjea/wtw2AnrnHlRC4QKilqsmeR
	Iw/7B0A==
X-Google-Smtp-Source: AGHT+IENizFyeN6FtbWemL2zMq5y5hTdkL+0DpeVmoYrpXn6bGCAbjYaVbwU1ifmvIKiRGPMWAv1qw==
X-Received: by 2002:a05:6512:3088:b0:52c:9e82:a971 with SMTP id 2adb3069b0e04-5343882d1ccmr2674507e87.7.1724468292975;
        Fri, 23 Aug 2024 19:58:12 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea8a4ffsm711277e87.301.2024.08.23.19.58.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 19:58:12 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f3f07ac2dcso30006161fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 19:58:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXyezS0pG6LoeWRoDx0JmSyRhxy1YvU3yZB5oBCxPtLjpVBQtV59xFhCWBOzSBrIEOBfsSrWjIIlP3kubc=@vger.kernel.org
X-Received: by 2002:a05:651c:b21:b0:2ef:2bb4:2ea1 with SMTP id
 38308e7fff4ca-2f4f5728ed4mr31688981fa.4.1724468292020; Fri, 23 Aug 2024
 19:58:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <sctzes5z3s2zoadzldrpw3yfycauc4kpcsbpidjkrew5hkz7yf@eejp6nunfpin>
 <CAHk-=wj1Oo9-g-yuwWuHQZU8v=VAsBceWCRLhWxy7_-QnSa1Ng@mail.gmail.com>
 <kj5vcqbx5ztolv5y3g4csc6te4qmi7y7kmqfora2sxbobnrbrm@rcuffqncku74>
 <CAHk-=wjuLtz5F12hgCb1Yp1OVr4Bbo481m-k3YhheHWJQLpA0g@mail.gmail.com>
 <nxyp62x2ruommzyebdwincu26kmi7opqq53hbdv53hgqa7zsvp@dcveluxhuxsd>
 <CAHk-=wgpb0UPYYSe6or8_NHKQD+VooTxpfgSpHwKydhm3GkS0A@mail.gmail.com> <wdxl2l4h2k3ady73fb4wiyzhmfoszeelmr2vs5h36xz3nl665s@n4qzgzsdekrg>
In-Reply-To: <wdxl2l4h2k3ady73fb4wiyzhmfoszeelmr2vs5h36xz3nl665s@n4qzgzsdekrg>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 24 Aug 2024 10:57:55 +0800
X-Gmail-Original-Message-ID: <CAHk-=wjwn-YAJpSNo57+BB10fZjsG6OYuoL0XToaYwyz4fi1MA@mail.gmail.com>
Message-ID: <CAHk-=wjwn-YAJpSNo57+BB10fZjsG6OYuoL0XToaYwyz4fi1MA@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.11-rc5
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 24 Aug 2024 at 10:48, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> Sure, which is why I'm not sending you anything here that isn't a fix
> for a real issue.

Kent, bugs happen.

The number of bugs that happen in "bug fixes" is in fact quite high.
You should see the stable tree discussions when people get heated
about the regressions introduced by fixes.

This is, for example, why stable has the rule of fixes being small
(which does get violated, but it is at least a goal: "It cannot be
bigger than 100 lines, with context"), because small fixes are easier
to think about and hopefully they have fewer problems of their own.

It's also why my "development happens before the merge window" rule exists.

If you have to do development to fix an old problem, it's for the next
merge window. Exactly because new bugs happen. We want _stability_.

The fixes after the merge window are supposed to be fixes for
regressions, not "oh, I noticed a long-standing problem, and now I'm
fixing that".

But obviously the same kind of logic as for stable trees apply: if
it's a small obvious fix that would be stable material *anyway*, then
there is no reason to wait for the next release and then just put it
in the stable pile.

So I do end up taking small fixes, because at that point it is indeed
a "it wouldn't help to wait" situation.

But your pull requests haven't been "small fixes". And I admit, I've
let it slide. You never saw the last pull request, when I sighed, did
a "git fetch", and went through every commit just to see. And then did
the pull for real.

This time I did the same. And came to the conclusion that no, this was
not a series of small fixes any more.

             Linus

