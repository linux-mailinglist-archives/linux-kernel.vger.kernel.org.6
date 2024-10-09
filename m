Return-Path: <linux-kernel+bounces-357452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C65199715A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2922C1F29629
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DCE1E7C3D;
	Wed,  9 Oct 2024 16:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y73bd84L"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B02B1E1027;
	Wed,  9 Oct 2024 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490692; cv=none; b=QFAo6nhWyrhjHbT5nHbEkrHSABxAULn/qP5G/94m9PxGGhBtsmkV5l7NmGzgdBnLsJZTwlKua4m5uVJbfWWKmJpe93jDNytjITfpU+YMw+MALeoffAf++J/zbdz1+mpwZJb4KQy7L1eaDDqHybrfsildQv/RG57/fkw0MCHWeWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490692; c=relaxed/simple;
	bh=R+bwzfBn+NKlXqBtED1qZHPLvdXju454ckxASZOT07c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=phx8DtmVvyCSQPgHQOqRNc0qahuBKj+KSp+HIG9m4RNI6pQ8Wrq9yBdgpB6IF+o0hRXh5VbCECC58R+r6lJEKd9enY/R40cjR+NP/1IluOo9OEXXsnCe7DRORH8AWhlvh4fqkbppjJnH1vUKueXE169WB0XcYOOsNnOAMnYrWwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y73bd84L; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71df49bbc2fso659036b3a.1;
        Wed, 09 Oct 2024 09:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728490690; x=1729095490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+bwzfBn+NKlXqBtED1qZHPLvdXju454ckxASZOT07c=;
        b=Y73bd84L7tYYRW/id5i6GGDgdI3zkr+UwlsKW7IXWcmFCKo2TDwzHukdw4n59+/axn
         8fPIYWKuMSt1lMgY7FESXEEgk4xQA8WylrCGqekkQxj/Of1puXGecn94n5iDs0iBoUsQ
         Vvs63rCH7LDKue1/Oi8eA3qf8ZvJKD5/comdlADKFxIAdeob9JUTUc3+80/9xmS/Sp03
         MhDQ6bPQC6wgbkPkvvpoCSqu7dGyZ0PTaB8tA7+tKRA9xNoEDZE5IzutGoV5oZZKbUZR
         vxzW4rBXxiIxn7gJ+zUVDdQpIN2rXBjtiGO5Mzftw2QVm1pxZPWPXA2wbsRkeArkgzjI
         c2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728490690; x=1729095490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+bwzfBn+NKlXqBtED1qZHPLvdXju454ckxASZOT07c=;
        b=vBYIToEuu1A4vTqjuk/mM4v6XlyXCIIB1cpl74vIN2PI1tZiVSIBqF+Ps84X8s50U8
         g2drlUPQzpIqnSv/ro1xkft38PYYKgbQC4NDX2hqxvr7E1qoCfkzCrf6fZY3s8hgwFi7
         F+iSVoAvcHehVKjdcoUFu9GgAF7ZQUtMMUiabdeYUJzHBnxHX5ojPg+QknWHwIsEs4uL
         JXVCQXSRSHzL0VkmBLuYeNWeDGbpcYq0enUYMP1JEoyY5ZReyNCFRQeFfFUKsOD0ni26
         S+OwRRT6N4x5ZbYqtKOHxmZ8UQQuTsRSnI/zDPcnxrWtNunQyTshayVcjgu0XMq0IeNx
         4N1A==
X-Forwarded-Encrypted: i=1; AJvYcCV+KNJSiFD2WyqO5ZDfWTo6g12wCmzqcHRRT+Uac/XmaqDbo1p9dJcfKjd1jP5eKXd83DOwpHP50Z4fmzePhLQ=@vger.kernel.org, AJvYcCXoAfCVUru+lfWvh4p7gt3cDpiGdNjFoX2S07ntrsEhJReSGiL95VK2f5P/yclYuEww6SoQlwTvJ6sC58o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBp92YKmkooaQtzulOFRXPYs455hicQPqogesgfpOmlGxjzsR8
	57vK/Ze7gaovDKdBq+CSf8lFbdXGXiq1G+/iaMErKSOp0G0QMqYNkhSx8tvLBumH5nmMsskx5aY
	q7EY8vyDwlFYEvZ64J3bdkHpaFbw=
X-Google-Smtp-Source: AGHT+IGhMG0D0vHb8wqt6AK3Wy3fqC5nAxT59P0MQjx12rPH1Ylv8DUettlfSVcXfSwdUoOrc8Rqnmv7IptsZo8l0pw=
X-Received: by 2002:a05:6a00:2d18:b0:717:8b4e:98ad with SMTP id
 d2e1a72fcca58-71e1dab4274mr2116195b3a.0.1728490690256; Wed, 09 Oct 2024
 09:18:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009151017.26685-1-tamird@gmail.com> <813594ff-b167-4ae2-8105-e2f958ec2cc7@gmail.com>
 <CANiq72nUT6cFXCGg4jfN07W7UE-8vma=o9a5DQjsRwtNsKUGbQ@mail.gmail.com> <CAJ-ks9=ejys3cQsKRkHkZGLFJ_Po9B4yeWKAuSHyQ3vBRDJXwg@mail.gmail.com>
In-Reply-To: <CAJ-ks9=ejys3cQsKRkHkZGLFJ_Po9B4yeWKAuSHyQ3vBRDJXwg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 9 Oct 2024 18:17:55 +0200
Message-ID: <CANiq72=M+rgJGLOBeSYygQzJZa9XnVvaWgi3DKUyT1Z_Rq=1Kw@mail.gmail.com>
Subject: Re: [PATCH] rust: remove unnecessary #includes
To: Tamir Duberstein <tamird@gmail.com>
Cc: Dirk Behme <dirk.behme@gmail.com>, rust-for-linux@vger.kernel.org, 
	Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Dirk Behme <dirk.behme@de.bosch.com>, Filipe Xavier <felipe_life@live.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 6:12=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> Thanks for calling out the grammar fix, I'll state that in v2. Should I s=
plit it
> into a separate patch?

Yes, please (ideally as an independent patch, i.e. it does not need to
be in the same series).

Cheers,
Miguel

