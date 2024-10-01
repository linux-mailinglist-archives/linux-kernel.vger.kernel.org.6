Return-Path: <linux-kernel+bounces-346225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D974098C16B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92DA51F23620
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036CB1C9B76;
	Tue,  1 Oct 2024 15:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyrlF6cq"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA311373;
	Tue,  1 Oct 2024 15:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727795950; cv=none; b=h1lvqJw2rq1jbRTnq0Pr0kw/xDkmwL0U8wEsZWh3JAp6sCH/H+bSwtAFGJXAhFRNe6ulXItUWV7KBc++ALRKpsCADI3+Nf52P4Qf/auq117cfPZOoGs12GH7wAsMzoXsYCfhyO3JVFSS2loDOoLAkz3zVI3hCNtXcmuizJpnD0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727795950; c=relaxed/simple;
	bh=qi8yKQjrLWHCSWjOpRs4bR/ZSldJgDWgk6YEdhDY6s4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/ecpdJlJfovrcLTQ1BJvuYNCIn+sn/94ftqXpZ2O4tX4UXIRnqohyjeftWVl0aFagZWXxmtf6qHy/PRJEE4IEVpJzwFsgsBK6fQjORpHv9p2nyB7z/ppxcS20jDpvamZ8+sq+yvUpuuhCKMxwgv3kBxL7z+seTC1aoLzyuzb4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RyrlF6cq; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f75d529b49so3013321fa.1;
        Tue, 01 Oct 2024 08:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727795947; x=1728400747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qi8yKQjrLWHCSWjOpRs4bR/ZSldJgDWgk6YEdhDY6s4=;
        b=RyrlF6cqYlj5P7CFNk9JGp57Mt44heratlNttCRApoYOrrMV2bXDGY2PbAubOKH9Ua
         oWyH/wivnLkTFDLwHS8f6ZJlxIqyCBxbkekpLnE0Zg9jI2gZuzyLoi2z+Xptgfeyl7dr
         a0KPcv+XEaxQK0EVaWyZnN+pvlAdpffStReBKjG2WjfS3Ca3LPWPsjME7nzTN1hD0gLM
         tEzgOGChm1pId8joTT5EmxsvhF27vnD2DuG8r9Diks2MoDToE7aKyPIYfMTB8TCA5Vmt
         ESyQJLisvnI5ako+gds8wVsxqBXmI0a98G8BriS2Pu7OWJ1dBN5Fjf2tdThDC1uxu64f
         A8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727795947; x=1728400747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qi8yKQjrLWHCSWjOpRs4bR/ZSldJgDWgk6YEdhDY6s4=;
        b=HTqjsp7TUExOnyQdTgZwAh7k/NUOmvJRtm7JmGsJfY9N0G/+jhT3CSlPFDRtHHUCRU
         0nn/FBujD0InTspeppRPj/aVmZaPTi7ZCXbBi+1QqF63FOWlB8Iwtyw9gyIDm34JPSnd
         h/8BJJl+DtoW8yIBKEmvQx/OXk502n7PeR3bkXqqUdDLyXg0vmPh0lQR/f1J8c0xVzEd
         IztMmqOMOfo4vFduRgwElLaZDvqhvsx/C7JavRw0dnXLeq1suzNij+wvyiuK3ggAE2cH
         mR1iZ35LOTwpNuwbvp4Aa5tz4M4cFSrtwlvaNstcU9/+7CzABHcLLB5gk2Mg/egrC9In
         m9Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUl1lTLqko+4lUsKSlutc83XuOZAnZHwsIEvpqR3jYFUWY15+sHcQWg2V4WRAHm9p07xLs3FZ16ZchSqgJWAi4=@vger.kernel.org, AJvYcCV9Hn8haLr4So/gRIBJO6zdj4xb/tASWhAReE/v/y9+coy/GerGnMQubRhl14Iz+BBgUh0Rx6yDFg4qe0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1bkq1hEeKCfoeqetHFdj6XFFOMg9rP8ONZR4LviEv4JuJd10d
	Q/aES/3Vtmox1jh7oDMCV9eOJyyPxXsZ0iF2iLDLAhotazByrE6eb/wHP1fTwOusq3JauZY0+d8
	/G198pUbI8+CyvxORlUfaPE6Vxvo=
X-Google-Smtp-Source: AGHT+IHt+TuZfDewSpTYnzspHrDKyHlYwH7HsKkgbgr/yf/IpVhOkdGpUpV5QaZEfyPfW8LWCD7/L67Db9Tp6/Do6RU=
X-Received: by 2002:a2e:b8c5:0:b0:2fa:d784:e11e with SMTP id
 38308e7fff4ca-2fae10a34c3mr207631fa.11.1727795946762; Tue, 01 Oct 2024
 08:19:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930233257.1189730-1-lyude@redhat.com> <20240930233257.1189730-2-lyude@redhat.com>
 <87wmisuqcd.fsf@intel.com>
In-Reply-To: <87wmisuqcd.fsf@intel.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 1 Oct 2024 17:18:53 +0200
Message-ID: <CANiq72n5bethTsoGvEEd4OM-J+7t6bsMN0Qvm-=cnqjMLyAcrQ@mail.gmail.com>
Subject: Re: [WIP RFC v2 01/35] WIP: rust/drm: Add fourcc bindings
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org, 
	rust-for-linux@vger.kernel.org, Asahi Lina <lina@asahilina.net>, 
	Danilo Krummrich <dakr@kernel.org>, mcanal@igalia.com, airlied@redhat.com, zhiw@nvidia.com, 
	cjia@nvidia.com, jhubbard@nvidia.com, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 11:26=E2=80=AFAM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> regenerated? Should there be more granularity?

Indeed, eventually this will need to be split, like we did for `helpers.c`.

Cheers,
Miguel

