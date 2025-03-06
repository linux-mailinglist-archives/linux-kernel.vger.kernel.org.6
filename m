Return-Path: <linux-kernel+bounces-549453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1065EA552CC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7AE43ACFCD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124DE25C713;
	Thu,  6 Mar 2025 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6fdP6ki"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163B425C6E6;
	Thu,  6 Mar 2025 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281608; cv=none; b=GZH+YYfgTDJp10QWjUv8N/kKDoOe2COYQoiULRgWad3vw0Wq7JkDeW7c4yQWZnk5rwyFPlhaEd93MVPsAk/zeJ8MjlkGQ2kMtDhdJq5shQRpFbwbhrZZjz3estHvqnghGJiJpPFmHm/DJp2JbuFFKRgUHe0yC21VmTcxReQKhLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281608; c=relaxed/simple;
	bh=jro/Hbh0PVRMm17RAdN1D5xn9Gy8MGklCX8MalsLCa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EbWeuMdheWh3Ip3iJsB9KSd0UPHnbIoMN1AAHad1ufA+srI5t9lQfoeCdCc4mKqwR6cj6atAwX8KsgkoDqnrJhYCFdeiPOL1Dp+R3QgMKgvDjuM2RyUzyH+IirvskGnEh8drCm1WnwTpgBigpKKhByswlQAt1xfFYNpeIcFwbxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6fdP6ki; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2f9b8ef4261so235875a91.1;
        Thu, 06 Mar 2025 09:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741281606; x=1741886406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jro/Hbh0PVRMm17RAdN1D5xn9Gy8MGklCX8MalsLCa8=;
        b=O6fdP6kiy04aHdbll2HGbMsNwMTBH9sssMObyNEfPO6B7X7HOxG2MitgHaqw+VHbol
         5m2F3MZRWHeKFyjFkXmOov3FOGF4IVRuQnagHg8zgWwZERtDUzFLytxDNq8qD5xoUreH
         GJPMoTxKOLRmgiaEL6qyYVX6p2go0lq+wR2p8CPxhOxCZ7Pefc7oagDIWMr1GvazsdJT
         308Th/iW1lYFAJcqMEuq9Znelxjf3SZK3TPwg0Y5X8wUv24PxGGcfRJG1Ki/ApAAlJfJ
         CPyHa9VIw94c4SaZpMWzQIXoKC6rH9u5RTPSJ26Itvp3oYJsNyxVyOW3AP66S1XjAxKq
         d0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741281606; x=1741886406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jro/Hbh0PVRMm17RAdN1D5xn9Gy8MGklCX8MalsLCa8=;
        b=NYQfi2kkHTB6+b1ainBkPTrmRxGsDBwcl4g0RJaOR7mMS8fowMIU8+/hCT93AvMgih
         FbQvvQLt30wdbavM1c2yS0xrkTAgItNLBVxjzLZ21KDQbpla7W2iF9Ny023KU3AwwjVv
         nYAv7hhOjruNQ3Cz14pjAi0UiQdEm4ds6BnelGKTsbo8mo52RDOowofH7B82XgkvM06Z
         Y0NUnVtRhoxYyfvMvCHGh6IWUkYiVB8qyvauWSLRZVdwlK8aPkJt8L7hphDFCruTsLY5
         AxadhbmXd5vK99GIxJjsRbs7qw29hecy9qe+EDsRDHiat0bFpk/vM4vF7Tl3GrLEh1bR
         jYEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4rjtOBxPl15Xixb05wEUafTcKove/oIOjLO69R//tKiCwXqAHf5hCLAmFaS9vbzSmgq5HuNLyOSKNIaY=@vger.kernel.org, AJvYcCVIoob+qWhQsn2Ag/6jm97iI+mh2FibNIAjtcsR033bv+WBlkXQXpjFJ2LErMHEQfTU/NCftQPnap/AJxVdiL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm8fLZNARDYzeIO/F9HJOMty509KDPjk3f+op3444MYSYZDZMO
	hI/5lfnsDFozz+6mshU57vh/scEqXTG71ubKQyORlrONZvNv1YqNYDJIV+J8zl6jLP5m8uHkG7p
	FNhozt5X60jzoZ5mAd29LQL7ntLA=
X-Gm-Gg: ASbGncs8KnNXP/SLAdRFee+++oHjjtYQz5yyLYGpZGOdB7axjVBiJ/jDgOny8dg9YBV
	UrGlf2d1swU7+W6QtkLBvyONlzfqGep8+Ep/fg8cwE7PED1THczF2Rvh3zSxG0V5H+Xd8+8s/4o
	c56J7Onc+TbFXrdoQNaowBnuTqgg==
X-Google-Smtp-Source: AGHT+IEJ0ZbOJXDh4ZxTTCwkcVFO971ZHgpLvODntDZs2sWDdHeKnkvGwePWAIGtVoBUdWog16IM2WmdU0Jb1tYWrc8=
X-Received: by 2002:a17:90b:3146:b0:2ff:6941:9b6a with SMTP id
 98e67ed59e1d1-2ff7cee0eadmr20217a91.3.1741281606209; Thu, 06 Mar 2025
 09:20:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72nXzY_j38ytE7KwHpH3Cy4sDw85WU2MyUe5u74oB2UP+Q@mail.gmail.com>
 <20250306171829.365809-1-trintaeoitogc@gmail.com>
In-Reply-To: <20250306171829.365809-1-trintaeoitogc@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 6 Mar 2025 18:19:45 +0100
X-Gm-Features: AQ5f1JpWvE0IRPHwLDHpIkF6uuc_TxVZDObgDuO3j__IKMqxzQ-ELCn3J_lQj_c
Message-ID: <CANiq72=KJt89yUy-rX5n+4Xqdb7F=NnoPkymcjAhMP1sArmF7g@mail.gmail.com>
Subject: Re: [PATCH V6 2/2] checkpatch: check format of Vec<String> in modules
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com, 
	apw@canonical.com, arnd@arndb.de, aswinunni01@gmail.com, axboe@kernel.dk, 
	benno.lossin@proton.me, bhelgaas@google.com, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, dakr@kernel.org, dwaipayanray1@gmail.com, 
	ethan.twardy@gmail.com, fujita.tomonori@gmail.com, gary@garyguo.net, 
	gregkh@linuxfoundation.org, joe@perches.com, linux-kernel@vger.kernel.org, 
	lukas.bulwahn@gmail.com, ojeda@kernel.org, pbonzini@redhat.com, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, walmeida@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 6:18=E2=80=AFPM Guilherme Giacomo Simoes
<trintaeoitogc@gmail.com> wrote:
>
> Is good make a check for this too and senda a v7

Sure, the more the check catches, the better (as long as it is not
unreasonably complex).

Cheers,
Miguel

