Return-Path: <linux-kernel+bounces-525206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 025D4A3EC65
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 06:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E66319C4A53
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 05:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10ED1FC0FE;
	Fri, 21 Feb 2025 05:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wpdm2Dgb"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8521FBEA6
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 05:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740117442; cv=none; b=YpfQb9TVVu+UBqPL937Bn5QuZnq4eSJWTjBTyLSkepJGZREAzMXSMZEjVjg+fcKJ+o8IHg0cIt9zUDdIhiMMad6uaXtvEEnRrKNMPICZXYmdVQD3k6m/JYPH/4EhpzRjhjPAEWQHSaz6QTjjGYwJJIZkuhExWch/k7pbb3scb1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740117442; c=relaxed/simple;
	bh=ehpZZfbi2AF75flpipDr/7bESK6ftfSMA3zivtpaI78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvUWzpeQGNsnysNukam/wjpzYZq6WgTgUNY0BlLqXeXuE8ptK/CkzH3x884zS/JVWnvT0iZenvct4CBu4jscvU5XVrZMx3rkF28Jr4fFN27WQMKYXeqdnvBJxrgYjNQ+jMhmFKuwgkMANbJCS9lADoYenwdvdPgRP3V785+bKUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wpdm2Dgb; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e455bf1f4d3so1436697276.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 21:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740117440; x=1740722240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBewxCJLhSyYTZDz5rlN63USGkLSk86TbO+BwKjDqTs=;
        b=wpdm2Dgb6e4ovbQPUTKY79UCxXDTXps9lxUSD7PPVlTGh9iTIqGaSiwPOT60t8DDzS
         iK5QtyNd3ZwPKkamA6bDthenlEhBimUQrgF3mTC/zpMhZJCJPP3rENIdjSQjeLZJbOb3
         G6cbMU8riZTIv8+sfN25SuEozFaGqojNPupTHCeYr58XlPUfLi+KKktxHekdvnFSSrlw
         w7SJnvmZftjvLjO7crvYPAf+5ejQTTCTvM/kGdy7vIRyqbKWqVrOUbkA/yRTfL85GtjG
         1lsNQiqG6eVk63e+IxsRBmdHyty0EXuT0xzauyCVe4cyH/nKbE7l3s73vRrK3y5Kj8C9
         We4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740117440; x=1740722240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBewxCJLhSyYTZDz5rlN63USGkLSk86TbO+BwKjDqTs=;
        b=iPFUq/wWuLa29bou9itQa5oR0WWbHBLF9BvoyS8vudwgj4BhSVD/QX2dBXJFemkDKl
         +4Bjej2L1JwMo9bTERhkpgaKnNZCVvyuFoCMjJFKyN2dAB+poyC+iTVMcnOmQsjCC/V4
         hLYBGi8ERVRo1c7ULub/9tmR0O5q+2+GJwgUmAXWjMAC+IAB2N/WTZ5B0AukNm16ar9y
         ghR5MZY4sxg+w0kCFdLfZUe1smU89YdOLXHSuivfwiUO7pgqFClx+51qI0yVggYaVzRd
         zqJUJUIr2vTSIc90EAmsxmovY2jX2lfaMeB8pMWu6oNFPEy/FlJCYPgkMgLV1mNhd6Mi
         GN8A==
X-Forwarded-Encrypted: i=1; AJvYcCVw/68+q820oPyrUj5ZAmRF0yyEFifBobTKhouj6kGigXqv3lpJG8UlSWmvHI3qVSpjZM4fw3oTJVOZsns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx70TK5WNmBBRRVAxLFU118O9o72L8Y1ejdINqR5Kf1MiIIrHQG
	jXZTLwRdYnoMIMG60rTU+h2gotBMzrXqB2JrW1wK0m4Pjo48Nx0nGhNPHguqUhQ2nxHoPXTVOlo
	yOV0V3Aswl+5xu85XcDnWv6QRCdp62NoSSJVJ
X-Gm-Gg: ASbGncv37o2NMCvSPUwRIhukb2Nc0ET0T1F50nkx8v5FMSALNEUskE9/5yk8S2L/XX4
	l4uPYz7TQ2R569Q8yg68vZ7R1DL4xDMpXcET/tK/Fx2Ghtwu568LWOflDZTKJvzoo+8F3iq2GBW
	/H9exbLphp
X-Google-Smtp-Source: AGHT+IFGgmGLdhl/6umh45K26S9GZkhD9bYD2oQAzttgTTrWX5Gm7a98+2nxYrPQ33yycf1dwLxHOLwf9tCHMDrdVec=
X-Received: by 2002:a05:6902:260d:b0:e5d:b671:8fe4 with SMTP id
 3f1490d57ef6-e5e245b92f8mr1701103276.7.1740117439742; Thu, 20 Feb 2025
 21:57:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219220255.v7.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <CADg1FFfCjXupCu3VaGprdVtQd3HFn3+rEANBCaJhSZQVkm9e4g@mail.gmail.com> <2025022100-garbage-cymbal-1cf2@gregkh>
In-Reply-To: <2025022100-garbage-cymbal-1cf2@gregkh>
From: Hsin-chen Chuang <chharry@google.com>
Date: Fri, 21 Feb 2025 13:56:53 +0800
X-Gm-Features: AWEUYZkaKtd9Ka_CJ7ZwAOSKumXyaF7yyb25pQiYedxpLC4hamOj3h32BsBEze8
Message-ID: <CADg1FFc=U0JqQKTieNfxdnKQyF29Ox_2UdUUcnVXx6iDfwVvfg@mail.gmail.com>
Subject: Re: [PATCH v7] Bluetooth: Fix possible race with userspace of sysfs isoc_alt
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ying Hsu <yinghsu@chromium.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 1:47=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Fri, Feb 21, 2025 at 09:42:16AM +0800, Hsin-chen Chuang wrote:
> > On Wed, Feb 19, 2025 at 10:03=E2=80=AFPM Hsin-chen Chuang <chharry@goog=
le.com> wrote:
>
> <snip>
>
> > Hi Luiz and Greg,
> >
> > Friendly ping for review, thanks.
>
> A review in less than 2 days?  Please be reasonable here, remember, many
> of us get 1000+ emails a day to deal with.
>
> To help reduce our load, take the time and review other patches on the
> mailing lists.  You are doing that, right?  If not, why not?
>
> patience please.
>
> greg k-h

Got it. Take your time and thank you

--=20
Best Regards,
Hsin-chen

