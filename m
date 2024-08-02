Return-Path: <linux-kernel+bounces-272687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D0C945FED
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7CE11C21AC2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C265B2139CE;
	Fri,  2 Aug 2024 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s0UMf1Aj"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7539A11CB8
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 15:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722611349; cv=none; b=E12I/6Do0mfWIP3FtjXkgcMexLlHcPaSHcg4AvZQTuklcevOqGBQhwisss4+RydJJrdHbNHz+zzie6kjcGfOKVBBKmv29jywo+tl8arpyVW/9UmsFybXJHimNSLOI79HHSiwmSqE9O3d/wttiXDjRhNZXlB6PwGZ2pzdLzuRZKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722611349; c=relaxed/simple;
	bh=Oyx3/fLLRUpO/0gYDH4iS0qvB9xDnhBmSVtxj1vVEHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A7voRVFFY0OqdWcngZIKPFzFlu6SjY0TZWeagtntdSWJM4I74ThJH6nltvk0iaR0wnDgGSUdq/02KlrJ5HhMZuz2U89ZXe59mOHO1bPPRb92ms+reUE61F/M6O0n4eC3rXwdAznNcAZT5LiG22THdNtK906Hgat3aPrvoZKX3TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s0UMf1Aj; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so53084a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 08:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722611346; x=1723216146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uIHL/2EoHW5Yr0Fg7c9tyIJScX6QH3x22CFoveUg9A=;
        b=s0UMf1Aj6KWfVxh6K3oFF4ZbOIqhk2hLBifE5w7wxHl1rFUN08cXJT64jRsvSdv00G
         tMlRTT8GoaF5DFA1ejZkv8yx79oDL0lVc52a5gHdkVpyDbz24xCUdhvnW14n8E/MAi8B
         im2spW/hDXJ6XdA/wW4JDZVoyWz6YjcaT69FqwH19e7HGaaVNaUOvJ07/61kIz+po8g0
         5zypKbqtWzX7iju2AQnnlRWVczhi1BPPNDLJGh/0xqoqaV73HV6qi110AtVDpVQuBOAG
         y37L4+4PJ+KjDLM+Yo82/MAn/sQwMWZFdkIjiiWCE0vZDCWB5GH+8hl3n1yP0/5aYIwl
         b+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722611346; x=1723216146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uIHL/2EoHW5Yr0Fg7c9tyIJScX6QH3x22CFoveUg9A=;
        b=YHlo9kVRXfkZyJz5kLf1TRx37ji5a9Uy/5AJxHKzdY83PyajIdZDoulIL8quhUG04F
         P+ky1kEBHizYK3CBA/S0qP7dVzoX5AhUoUL14/FhlnqfMqfL9GtZamffgVD1zMb/7qj7
         K5jGkFTTyCtQW8QMyNuE+lzsmx/Czcv5cz6wqFlSPSL/YUO/f9uLnPn+1tCp2Hr++27o
         N10XYvYgTcUPcFLTSrRP7cQhm/5Aq4OCPRKH2DWLZ5ChGHj8oRrleWUfJiFYzlcfxZIH
         Iv/Wp+jbZrfTHl+bitRrH+LxhZrQ7STBqHdAdV3+Of4B2yKtzKXzITFmGQJrNvMXnmCo
         MapA==
X-Forwarded-Encrypted: i=1; AJvYcCXZcSh7zxS3xfk6ZLGGgdz+qn7D1jUs3+ngkOqOvAM3QGlcxnIIrgQce8ero0cpT5Qsyes0iuxR+2swWcWofoKUR92l/SaDDYxg58JB
X-Gm-Message-State: AOJu0YzHzS2SLU+MOva3G03awXcCJIH+S3XKD9rpdX2HvrkmXejdc0Hd
	dD+JcOLqwi1y841apsLqkjVwqz9NF7lcLscXRVeLKcNrM7Q3Bghlbuq2WiXLyLfXJJWE2rlk2b6
	9/PoLaWsrB92hK9O250BIIjMDktl5JpqcFv04
X-Google-Smtp-Source: AGHT+IHb1floLS7qNFKs7sykGoRKqFvwZASVwNgyHcZ4Zdv/HAxiWgTUKuuRc0PVh6qh3sEAnaYKCdzOAHDCKnTUZfs=
X-Received: by 2002:a05:6402:34c5:b0:5a0:d4ce:59a6 with SMTP id
 4fb4d7f45d1cf-5b869f00330mr145214a12.2.1722611345245; Fri, 02 Aug 2024
 08:09:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802145935.89292-1-aha310510@gmail.com>
In-Reply-To: <20240802145935.89292-1-aha310510@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 2 Aug 2024 17:08:51 +0200
Message-ID: <CANn89iJDVNqnMiGYHGQissykzASK-DcLss6LDAZetnp34n1gxw@mail.gmail.com>
Subject: Re: [PATCH net,v2] team: fix possible deadlock in team_port_change_check
To: Jeongjun Park <aha310510@gmail.com>
Cc: jiri@resnulli.us, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 5:00=E2=80=AFPM Jeongjun Park <aha310510@gmail.com> =
wrote:
>
> In do_setlink() , do_set_master() is called when dev->flags does not have
> the IFF_UP flag set, so 'team->lock' is acquired and dev_open() is called=
,
> which generates the NETDEV_UP event. This causes a deadlock as it tries t=
o
> acquire 'team->lock' again.
>
> To fix this, we need to remove the unnecessary mutex_lock from all paths
> protected by rtnl. This patch also includes patches for paths that are
> already protected by rtnl and do not need the mutex_lock, in addition
> to the root cause reported.
>
> Reported-by: syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com
> Fixes: 61dc3461b954 ("team: convert overall spinlock to mutex")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---

This can not be right.

You have to completely remove team->lock, otherwise paths not taking
RTNL will race with ones holding RTNL.

Add ASSERT_RTNL() at the places we had a  mutex_lock(&team->lock), and
see how it goes.

