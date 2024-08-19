Return-Path: <linux-kernel+bounces-291573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FFC956431
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05743B22357
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 07:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39129157490;
	Mon, 19 Aug 2024 07:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xFWklHQk"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B8D156C71
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 07:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724051625; cv=none; b=DUxiaSkBHVyr7LUqc8AL26x10mjO6DLHpbSxzcQa4YjX6FZULcfJoLGsdI6UCBx+fjsE99mzrDuQ2jpGnQ6wr2pNGenAZkwkuTIDyU0vS9UCZk5zFrS4xFHjw5dO9TBVLSjLpB+7yCBwF7pFuMCIpihAWd6acQFg4D0QITP2kSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724051625; c=relaxed/simple;
	bh=cLwbxRkJ+8dJkhrnF8y9I54oCup0wd8+kTk7wuDk/6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OsQeH7nI60JKgq0NF9uk7TzIlwfFQoPkZ7rLpc3DBs1iHy2QU1VLJ+xPPiLwxdKbORAlfTT2YV/hQ9MIsG7LeGRXkfbDr1Wnxkl7uo6Mz6S+VljADV8xrB7yFOwtjrpKJIu+rYAqxXYL0wERfowR9lBY3nAbH5hDvV6VfbyQOOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xFWklHQk; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5bef4d9e7f8so1031134a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 00:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724051622; x=1724656422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyZeI1PmQ5XFAeRTl6ZL7Lix8GszT5OtnYqACX58x4w=;
        b=xFWklHQkct36FRghD98Z1PrRFRW8GVWcFHxxcROPYk53G9YPa81NAMqKLYNkanfrsO
         tAIklre1GtYZXwoeLPFUHvYtC+DM+o7WMzc8lQSgvWnINZiQVYEyqJSUWU37rNBPgAFO
         jvwE4q3aJ5EJKGlJsjlHeCxoFAbPT4ZmCWC6xkiXlV8Gn5vTvOnQxZrE/ej0pjPcCD7K
         OGalPpDdkfeY1Y0mHHw+hF4DKY2MvdfSn8Cp9SVGQBi7ODaK5hV7PZn6v1UyIe2XLCQa
         552WeXgUcrw49YImHfFW9mLRDGZzuZnADHxH0G+3/eti/Cvyt/qTsWh+sPHl1g1PZcaD
         w72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724051622; x=1724656422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XyZeI1PmQ5XFAeRTl6ZL7Lix8GszT5OtnYqACX58x4w=;
        b=JPt5IZDMO+xS1fc5/AqLX8QNG+Z/pHI0jteomLn2aNt9IDuyZY9XEMkcTZsucSjrAd
         5qP2xsdjuwVv4pMuucivu2OgFHtJnshWHUngTKFXXHboCzXnnqPZwlwWQd36cFazG2mR
         eGTyNx4RvCNvvvaRWWyAc5r0lXDld79R3wcVHszhp9VOWXucuca1B4BLJdBGzd4Lij+r
         ggtJ8w4QJ1uXhWucyRM9nw1ohpVbgGK3uW7ZKtjTfH1r+TV89AUEXdizpjvfyGE80NpT
         vQMdLWWhiPo1NCYyua1qksn+Yfb1kHEOcF7VddAUjzbrMjNxIsrEXiWRpOWIwJJwWfeP
         FJVg==
X-Forwarded-Encrypted: i=1; AJvYcCWrrcJUAWbpnOEghsV2r58OiAnlZN0VVB2+FMp1Vx/0BcP8i3RP1kp3i2bAt+PAxMv3JpfweHsPf9S8eldW7ByZ+U11H+lTfsASppOF
X-Gm-Message-State: AOJu0YxYtZcAurhPlsE2FavqHx3o16Mmf15DbWnQEPsWtrb3Jzi1X/lh
	oFfBcM1dY8brUN2JqyXMXpUVJe97pU9m5kHsb5GD9VpfoZmvRL+8OBFKAYA8TuIYixeUnPLFbDT
	MZokeFItX8XLCOMQ/eSNC2A1DugWtJ1N6tXsI
X-Google-Smtp-Source: AGHT+IG/hg3PrANuDcYlFWGiTHq4+oKP2rAMb3acvgYbnb3UmuUxj+D7gM5FcKy+GIdEowHmzjBtwD5KkTj30XM0zKE=
X-Received: by 2002:a05:6402:50d3:b0:5be:fe84:cc4a with SMTP id
 4fb4d7f45d1cf-5befe84ccffmr721748a12.38.1724051621348; Mon, 19 Aug 2024
 00:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKrymDQ48QK5Wu5n1NJK8TouqA0cmg1ZkiALCM+W8KHFxraWgg@mail.gmail.com>
In-Reply-To: <CAKrymDQ48QK5Wu5n1NJK8TouqA0cmg1ZkiALCM+W8KHFxraWgg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Aug 2024 09:13:28 +0200
Message-ID: <CANn89iKkeM7s-ZbPR+d7P8PNZn_x3n15-e0Mvto7z-+5CWJSGA@mail.gmail.com>
Subject: Re: general protection fault in qdisc_reset
To: =?UTF-8?B?6rmA66+87ISx?= <ii4gsp@gmail.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, pabeni@redhat.com, 
	netdev@vger.kernel.org, kuba@kernel.org, jiri@resnulli.us, 
	linux-kernel@vger.kernel.org, davem@davemloft.net, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 9:11=E2=80=AFAM =EA=B9=80=EB=AF=BC=EC=84=B1 <ii4gsp=
@gmail.com> wrote:
>
> Hi,
>
> I have been fuzzing Linux 6.10.0-rc3 with Syzkaller and found.
>
> kernel config: https://github.com/ii4gsp/etc/blob/main/200767fee68b8d90c9=
cf284390e34fa9b17542c9/config_v6.10.0_rc3
> C repro: https://github.com/ii4gsp/etc/blob/main/200767fee68b8d90c9cf2843=
90e34fa9b17542c9/repro.cprog
> repro syscall steps:
> https://github.com/ii4gsp/etc/blob/main/200767fee68b8d90c9cf284390e34fa9b=
17542c9/repro.prog

Please do not fuzz old rc kernels, this will avoid finding issues that
were already fixed.

For instance, this problem has been fixed two months ago

commit bab4923132feb3e439ae45962979c5d9d5c7c1f1
Author: Yunseong Kim <yskelg@gmail.com>
Date:   Tue Jun 25 02:33:23 2024 +0900

    tracing/net_sched: NULL pointer dereference in perf_trace_qdisc_reset()

