Return-Path: <linux-kernel+bounces-437178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 189389E9005
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 150A128132E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA42E216E29;
	Mon,  9 Dec 2024 10:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zn9wGcWK"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6192165EE
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733739657; cv=none; b=FNFiwwTg7jQUCJR6qRVky9sTnDzpLhUvQTolyz9OS/wZ+6rmHnja8pe8UKSO05YXDELJhvf4lbqPRD2CCmXgpHlZNZixZMYCjYS3KXyTdVhr/XM9A+itR6HdQ81kQquhtylafo0LlDkj56vMpPNTKiubbdzhEtNJBfdOTrr0Mg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733739657; c=relaxed/simple;
	bh=rpYgz71jOdIrmb5oVsE/GILmkdd4/Vr6iqmTb1HmGLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S0w1sFMqC3LuqupZ+4MXt9CjS1+qLvL7D9U6VUfE5i0dPoXH3TlL7QX685O9gnzIgVJ3kyl5MuoTZjI7Hk1cHrkMvKYBa80KnP+p9jz/QPVIGtx1iZNTWAMjbthgkHQY7LXHG4NKdPR9Sbiu7QBj/ksKiW3m/ti1K8XTReMKlpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zn9wGcWK; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a977d6cc7so604947566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 02:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733739654; x=1734344454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rpYgz71jOdIrmb5oVsE/GILmkdd4/Vr6iqmTb1HmGLg=;
        b=Zn9wGcWKCGYs69q484n6lRB4W2sRKsq3/xnozgPMP/xp+5emqwlBiKoqqAlxYUORCF
         s0fr87uItM4y+4/zuBM4o0H2HFJWrqFTiGxkdaa33/G25ZxzWogX7b4PL1Vjaen8usMH
         dG0jkcsUaLBKBp/1b75aSNDcNbHkpTe91/ubiq1d6AulMgHx4ocFT/pioumOfTzEK07p
         tjR0YRteM/Q3zfEeq4Lj/bKcjz0q0cEHt2JLWn5Xol5I9HBDMQgpNRAktF8ys4+AUFRO
         RXHPs1O+P4E+6aMh/FNlcq79JyuF4YicYZaPBYXTg+10arWfJ7GZBMu+v/EaZQFPVd6n
         uEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733739654; x=1734344454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rpYgz71jOdIrmb5oVsE/GILmkdd4/Vr6iqmTb1HmGLg=;
        b=VVinRT0bSRAF7ZeQotU/chiNacnMWnqe9cH0F+78pbBoWTMBEjzpH57cZ7RQ921one
         Wo6naF5GHbEbA97XtGrdIlSTdistEgegHQYwaoFeALG655Mds3YvcNTJVaNs2cRXEw11
         7PBXN4r1E/lIYBQZ4vrbh9biIXgDJWvnXfgXZd3cT36Y9tATpkxqZpXcdtA3dZPROw9D
         tSccsqSyssIep66TMRNoTyhJP93Ii8tAapUukqFi2hsMrLzKr5TN5hoF3glV/wD9weyS
         0Zf70FTwsIgch5SJOFmenH510u17152bgKutefYOnyDzRKZB0GF0GBs4QJMLrBnUDv3v
         fhNg==
X-Forwarded-Encrypted: i=1; AJvYcCX0w5C9JL/207fplBTq91iWr/T88xJ3wLSrBMLuZUOVp/tQeWdtO8C7273j7W6UUcEJl/cgCGNSuX5pmtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJXnd1gTwmUl7sRYAdklUMRW7jE3NPnsxBGuNuGKgtLp790Cqm
	unDpkXLz9/Gc+DcphPqL6sz9tuafII2oLIRhaMWX1FrpuOStUxkoS5zQp/qe6oboZyFBLxXpEQT
	E0DyZLcoiC+U+w6J6P7k2KTntvT+nvMgLEGwH
X-Gm-Gg: ASbGncucaBtuZTA9I0ovukODs1lxkyzOGOQFzJXLcyGeOLlfUea6LDABvd294Z2urEZ
	dmObbWTokNPFqmfW2aFQAWsLsBIgGCQ==
X-Google-Smtp-Source: AGHT+IHnMfF0t+SlVVVzDaPuIkuM/lC/WO2jmqKFQe7KDUFWMt1VWRvc+Sl5w2JJswbt9emtWfmW31i2DShAMhlWidw=
X-Received: by 2002:a05:6402:510d:b0:5d3:f55f:8349 with SMTP id
 4fb4d7f45d1cf-5d3f55f8f2cmr12687619a12.33.1733739653710; Mon, 09 Dec 2024
 02:20:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20241203081005epcas2p247b3d05bc767b1a50ba85c4433657295@epcas2p2.samsung.com>
 <20241203081247.1533534-1-youngmin.nam@samsung.com> <CANn89iK+7CKO31=3EvNo6-raUzyibwRRN8HkNXeqzuP9q8k_tA@mail.gmail.com>
 <CADVnQynUspJL4e3UnZTKps9WmgnE-0ngQnQmn=8gjSmyg4fQ5A@mail.gmail.com>
 <20241203181839.7d0ed41c@kernel.org> <Z0/O1ivIwiVVNRf0@perf>
 <CANn89iKms_9EX+wArf1FK7Cy3-Cr_ryX+MJ2YC8yt1xmvpY=Uw@mail.gmail.com>
 <Z1KRaD78T3FMffuX@perf> <CANn89iKOC9busc9G_akT=H45FvfVjWm97gmCyj=s7_zYJ43T3w@mail.gmail.com>
 <Z1K9WVykZbo6u7uG@perf> <CANn89i+BuU+1__zSWgjshFzfxFUttDEpn90V+p8+mVGCHidYAA@mail.gmail.com>
 <000001db4a23$746be360$5d43aa20$@samsung.com>
In-Reply-To: <000001db4a23$746be360$5d43aa20$@samsung.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Dec 2024 11:20:42 +0100
Message-ID: <CANn89iLz=U2RW8S+Yy1WpFYb+dyyPR8TwbMpUUEeUpV9X2hYoA@mail.gmail.com>
Subject: Re: [PATCH] tcp: check socket state before calling WARN_ON
To: "Dujeong.lee" <dujeong.lee@samsung.com>
Cc: Youngmin Nam <youngmin.nam@samsung.com>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, davem@davemloft.net, dsahern@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, guo88.liu@samsung.com, 
	yiwang.cai@samsung.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	joonki.min@samsung.com, hajun.sung@samsung.com, d7271.choe@samsung.com, 
	sw.ju@samsung.com, iamyunsu.kim@samsung.com, kw0619.kim@samsung.com, 
	hsl.lim@samsung.com, hanbum22.lee@samsung.com, chaemoo.lim@samsung.com, 
	seungjin1.yu@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 11:16=E2=80=AFAM Dujeong.lee <dujeong.lee@samsung.co=
m> wrote:
>

> Thanks for all the details on packetdrill and we are also exploring USENI=
X 2013 material.
> I have one question. The issue happens when DUT receives TCP ack with lar=
ge delay from network, e.g., 28seconds since last Tx. Is packetdrill able t=
o emulate this network delay (or congestion) in script level?

Yes, the packetdrill scripts can wait an arbitrary amount of time
between each event

+28 <next event>

28 seconds seems okay. If the issue was triggered after 4 days,
packetdrill would be impractical ;)

