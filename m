Return-Path: <linux-kernel+bounces-274238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6CF947581
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48AFAB20E29
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 06:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FE9149E0C;
	Mon,  5 Aug 2024 06:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pILr2IVP"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632E2149001
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 06:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722840154; cv=none; b=B+x53BcWIyAmCNsPNOdXqiVcWlaPusMDOdxuGJnTpkh701RuQdkPCFd8u9JN+ZJ3Hdi0sRqwdLy5XIUUsrnPlg8vNIkJJZ5s/ZM+ROODpyHHhZarVOlfWuRRCmMWfWdS87bspDtjCZoPGYPn4ZbGtkYr/daqLbzcB5Ah7ZZdDAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722840154; c=relaxed/simple;
	bh=YzPGDXjl+eDy+6N4e8OZmZe9l2E04UtisDrDRuOId4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzDTbvm2TE0tGQnVVPPrdYQk9+Iuqb8kR68Dw/zIZoEdRa0071bKH4DqA392bFgWPzh/E1gIRtcRRuWADJLvxwsHNp/Z8kTMyxomd2cb6w4wsGVK2mflHYfmor/BSretPye0FdD87mdi+kIHlLjKx/oNLhp89t7fv/Md/QgciOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pILr2IVP; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7a8e73b29cso830302866b.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 23:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722840151; x=1723444951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzPGDXjl+eDy+6N4e8OZmZe9l2E04UtisDrDRuOId4c=;
        b=pILr2IVPBECX0PblY0vj7LFrh+7TTUotBCORKq1T4giRMbvpuA5PnpHu2czvf+S+Mr
         QUM/4ThUIg6ApD+kdtX5BIrACOzCEz3bOku3yKRWrt/wKNkKs1SEpt8Foon9842Oqu+P
         S4HgXBSVDu1sizLfUccOfp/4EQG6BHfM/XSQg6zuXne2/7lDPwW3YbSpsPFCeJgcOuJb
         GNlUf1DEhQuIDhdjBYCIDDxJKPQQ6y/0cSux34dZPq7IlVkkacp96ypN3ixLf93MJc6J
         AkEw7Ppi9DBKo8F9O4bNVLTE1nWR2D6f4Av3Kh510hRHv06pDnYYbfGdKEK6zaQELqdl
         8sjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722840151; x=1723444951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzPGDXjl+eDy+6N4e8OZmZe9l2E04UtisDrDRuOId4c=;
        b=AEGdl3nacU83GWT9urchVj4wYApftdyAV4sWTQU+2D5PIfTlu8NIQMsWls/dX69Mgg
         RvZ3kFsrRXyWc6+Y9GbmaMOzEFA2MzsKidFllhSvR2shODX4l/Wp3ejDa//Z4pji5viO
         sARO8Xo7+yXdoGXqdeAxr2aVUFsdgCDS1VP0XyfYWuqxRD4ptqApRnJ7b4MRKZYMBiBJ
         l4NzsMmsG7kNuq2RrtH9zAZcg7KMeWSm/28r9HDE5g6Zd+N3tI/KJBp5+i1SW00yWeZ9
         j+MmcjIapZTxLnG1EEnA96LSoMjkEhS3YV0XeApR/DKAp6gFuSjrjaNdD5tR7ydbX3CF
         RD3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3trZhCHQ7HBKQyaf7gQ2dsYumGKIT3C5mOv0cmV0vgiz/0YWkAY+xUMIfYaQC+vCVTMRVwMCgjfZvn8+CuMOU72/ZhhicIsVPj+Tl
X-Gm-Message-State: AOJu0YywE0VFfbFcXBtWH6oImxrvtXTOiQBwlPzpSYENxpnRnZaPAZJ0
	hKY7PLmZTfT/N6rm8advUCwiV6HIH3snZ7sKMtxJ5GGQpf5+CPAQ6WXXd84RajcyrKWw88OXFLq
	dfA5D17HUA31p1bCFvJii+8pVyY7TI2e/jwV+
X-Google-Smtp-Source: AGHT+IH15Ujg8tPz1fJtw9Huyg2yIRaAIJXfYpvCzwAb670F2TzQXL6sR1QEXEtpyqaAojAbleCRXilC6e87NM5eCSg=
X-Received: by 2002:a17:907:97c2:b0:a7d:3cf6:48d1 with SMTP id
 a640c23a62f3a-a7dc4ffe3b0mr675122166b.32.1722840150244; Sun, 04 Aug 2024
 23:42:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801111611.84743-1-kuro@kuroa.me> <CANn89iKp=Mxu+kyB3cSB2sKevMJa6A3octSCJZM=oz4q+DC=bA@mail.gmail.com>
In-Reply-To: <CANn89iKp=Mxu+kyB3cSB2sKevMJa6A3octSCJZM=oz4q+DC=bA@mail.gmail.com>
From: Lorenzo Colitti <lorenzo@google.com>
Date: Mon, 5 Aug 2024 15:42:19 +0900
Message-ID: <CAKD1Yr1O+ZHg_oVYu39z=qKPC2CX7P56ewRLWOkvXqvekKk6uA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: fix forever orphan socket caused by tcp_abort
To: Eric Dumazet <edumazet@google.com>
Cc: Xueming Feng <kuro@kuroa.me>, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 10:11=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
> > This patch removes the SOCK_DEAD check in tcp_abort, making it send
> > reset to peer and close the socket accordingly. Preventing the
> > timer-less orphan from happening.
> > [...]
>
> This seems legit, but are you sure these two blamed commits added this bu=
g ?
>
> Even before them, we should have called tcp_done() right away, instead
> of waiting for a (possibly long) timer to complete the job.
>
> This might be important when killing millions of sockets on a busy server=
.
>
> CC Lorenzo
>
> Lorenzo, do you recall why your patch was testing the SOCK_DEAD flag ?

I think I took it from the original tcp_nuke_addr implementation that
Android used before SOCK_DESTROY and tcp_abort were written. The
oldest reference I could find to that code is this commit that went
into 2.6.39 (!), which already had that check.

https://android.googlesource.com/kernel/common/+/06611218f86dc353d5dd0cb5ac=
ac32a0863a2ae5

I expect the check was intended to prevent force-closing the same socket tw=
ice.

