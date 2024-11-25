Return-Path: <linux-kernel+bounces-421529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9C89D8C84
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D40E4280FE7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762A71BBBDD;
	Mon, 25 Nov 2024 18:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Oa5aCEJj"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258E42500CC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 18:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732560792; cv=none; b=dgRZhLecJteWThL+l1Ep/JVN65rruQMlFI/M1PCz/Ik8ZNKhxwent+SkQPJ+mqTLjdQIL5/TgoT9qrefpNpc8P5zAH3WC1asJLdmuSgexYpXVrJ4RfkKezSfM5DxZNU+iDjjWOUnq58AABhOs27oFfJRAuy2T/OrO7J8I+Bhpag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732560792; c=relaxed/simple;
	bh=DgyXtub/mrosQT7xRYvugi2qsZ0dWJBpLmbcBYjlDpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9lutqtxE/H/lBKrO6z1nHlLdVRWMaGot70rDpu39cQTML4fpJaYIHoD1+qZI9OyCtvKnb6GltyqLCReyZgoobredUraJX/mVqdJlFHCx2AAD5BoD75i5QLvg2X5L3X0RT964SVB9yLB7g5UZHpinpwK06qKAxb90hSbUeIR1tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Oa5aCEJj; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e34339d41bso42039687b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 10:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1732560790; x=1733165590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgyXtub/mrosQT7xRYvugi2qsZ0dWJBpLmbcBYjlDpI=;
        b=Oa5aCEJjXEX7OG+KET1dsdzjJrt74joABXQZbZIR9N+0lsKrcpInSztcpiRf0CWAOd
         MGVjr3lJJfKWMPAJhwM/PIzrdY9JYTDvA/eDTyt8zu5tupKZPXFCdiPvnRgkyWvkIFTO
         mpUFmNnnIWHSGHLtwj4P8ku0+pLqTRDEamAeMjC+rYMI0xoZTZ/fLwNXLxJ3tQ25Gp5B
         WB3iAUKbUzm3U772kOqvZd7C4nGiI0ARECRCAqa+bzJ4JF1/IPQLdJmcitFaAN8J+TXY
         MmBEepf0ilKnyzib1YZsoDVJlaFfxO5VcZuvaUxSfXwCs7irvKtrTuN0qxBnCHoxlvmU
         m9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732560790; x=1733165590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DgyXtub/mrosQT7xRYvugi2qsZ0dWJBpLmbcBYjlDpI=;
        b=E+Vou2l+zsL3oxNK7pxql9RdhHrV9SBl54f+nouL3+k+jeucZzQGFLIcvhMRoPqe0E
         kAn/4wRYgafuu0W8FAw/lKpvh7D1fzXpXlA51lCtoD+wpgB0vlbIqA7mcEh044PXA8lY
         dThgScO6iVri1juQ6HK6XZdfOdfQ+7/GzhJbJ7HIuiYWq/F8BoJOtBHrb2Uq2QOEbCOe
         dilAVe9MgfjB5rE2qpPcqEH0SO0K1cZFUOqE/rtLXeYf1pkHjlsc6OlE3McJCZAM/5G4
         klW1u+W7yVtD9aNV+sAgKdvzQn9E5pEWrAbpz+RAKnmJ0eU0yMxXDyyom5eoB0UYJKEl
         Q4vA==
X-Forwarded-Encrypted: i=1; AJvYcCW8pOEkYWzRbH1h9pHilSsL34tsFxUZvS+z1hJrqrwldnKcnfk3aaMUljFQeEMABmfEyv56H7sh7TLCF2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUhflYX9W/2U2He+dRW0dJaVgWmbGyVTB3P2bcdAxuxjZAlMpl
	7UGmf5vvLxBaxI9tWm7w6kQm+2felBaLtLtBs90W6kJeYKDYZgbGGAiRvnrTTetWLaPXNQvR+NX
	ifZ9ThpOMlc61L/EpjnyK0Jq+3NTXwGop6Scr465qSUxPbA8=
X-Gm-Gg: ASbGncv3qgJmDMJ1dwof3ruKnaMMSGu8JnnGcPSV3qFNI2/zPE8EMHCDEJW1xz9BCx9
	B+YeXi0zjsLFuu6L1lVcn043iK6dUTQ==
X-Google-Smtp-Source: AGHT+IH4DDz+VxDlpzwy5Tehg7j+Pz6+AoiLkVQmZ6sHppSS7SAzMQPpgzbmFRcFkdDNu1kI1gZ8fYkhnFxzn5B1PPQ=
X-Received: by 2002:a05:690c:670f:b0:6ee:b30b:f124 with SMTP id
 00721157ae682-6eee089f8f6mr138230747b3.16.1732560790126; Mon, 25 Nov 2024
 10:53:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zztcp-fm9Ln57c-t@lei> <20241122173418.GA518018@mail.hallyn.com>
In-Reply-To: <20241122173418.GA518018@mail.hallyn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 25 Nov 2024 13:52:59 -0500
Message-ID: <CAHC9VhRtuDmRX37asbFTFnwnoGTAidS1PArwZ9EfY4992fXQXg@mail.gmail.com>
Subject: Re: [GIT PULL] capabilities
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: sergeh@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	Jordan Rome <linux@jordanrome.com>, linux-security-module@vger.kernel.org, 
	lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 12:34=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com>=
 wrote:
>
> On Mon, Nov 18, 2024 at 03:26:31PM +0000, sergeh@kernel.org wrote:
> > Hi Linus,
>
> Hi,
>
> before the merge window closes, I just wanted to make sure this didn't ge=
t
> lost.

... and while Serge may not have sent a pull request for the
capability code in a while, I just want to vouch that Serge is a real
person and this is a legit pull request :)

--=20
paul-moore.com

