Return-Path: <linux-kernel+bounces-433783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8589E5CF8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283E816C9C4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDA0224AFB;
	Thu,  5 Dec 2024 17:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+t5dSjY"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CFA38C;
	Thu,  5 Dec 2024 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733419382; cv=none; b=TG6UmOuTsB2PqrEjQilYgKTBB5ImarIicDky2KjVlNXtK1+0fPT5+cALD3+Tco1wam9yFVKvkD516pmGA6iZFJCMeo7t0+2KFo96O0rFLXNPoqQN8o0KbzNkefwIZ53VJLwwikvyM5L54u4P6AUfyv/MjjsZ3Xh1gT2jOQMohaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733419382; c=relaxed/simple;
	bh=BqSM8N50H6QhKCPkEQA5e10NM5HT9sxZq0pE6IYGqJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptXmc3bFCqlacHy5sJIdAQxkFdYW91KZtaA+te9LYE7npGz1b3kOa+oPEXhfxUpR5Y1jQDaHVupFC8zMTIz06PrFXnEnb8GIAJ4i1S1aaJ7YFIsGeIo6u6aEM2XyWBrmVI7XJl7DpGKuqtCXkqXioK7UoZGu6mX4bXK3wbG3aGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+t5dSjY; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ef10b314e4so1049065a91.0;
        Thu, 05 Dec 2024 09:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733419379; x=1734024179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhdPRWkOROlVaSbJ6YQy1i9EYdyki/LINrr9kkVS3fg=;
        b=g+t5dSjYRwEBn5stZdNTr0d6trRGHloMIBG9AlFDANBbJiJndQXw/9Dy/B++SySTYe
         vgVJ0i8839Y9hSO5e2qDGtWl1RVKd8kIpjZ+Ju3ND2dMY5DQdDneBpjFeaS9amYdUAJW
         e4CjWfK7DOgMgh79NKN1wFR2PWS5/HBv7qwIxEAjH66H2qV7Iv1+rWNMntwpnWZpUEhI
         LgSnE/el7+IIx/57evfa6ztTSNxb+DEYVhrTPEF1G49gXulOAmPcxuUHfjdiQYBPa/bQ
         JjdmG0ceJaOPsoMun6mQqEps12sb/wblFJsuayNLbx20AoCQxH2pWK6np0T5Hztdk0KU
         e2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733419379; x=1734024179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhdPRWkOROlVaSbJ6YQy1i9EYdyki/LINrr9kkVS3fg=;
        b=bgoVPvjIyrZcRXleXxcHwCI8ywH6VHS6O5LSg+gMshLAdF6MBXbES31Ww/eAaKIcXQ
         0XBWju7CNMqZOsSXSNNWQDRCZrzJ9rG4hwljWhyxRoG0PuR6LT0j2zgyQj5twF88odH7
         09DziOoG1WxEzoaFYnMO9mYwOMx8lTPVuFZ/ebsF3xfQ4q7u+0Ee6v1CrPl222CTbqyp
         fj0DF+yPyjCLl0boaHG2bdebijrtCl6U1ZBFRhjxGrslKSENNg1a15Xeq4GMxr64JVVL
         Hl4JF0Vu+OvcLVkvU+K/dhcw0YhwKiKysUWxRVc0n4+O8GqGouvFN48QsEItDZZ5VdAj
         GFJw==
X-Forwarded-Encrypted: i=1; AJvYcCW7tweZLP99HqA75qYOQAacXYbJdjpCRC+rvBWtmOv6Jwb1jpfiUUGk4Joi8jpTQMJvzoaoFuCfKeMkBXI=@vger.kernel.org, AJvYcCXH7iiuHRlrhkxkA3sNT0lugjhWet0ugfTkbWLWtDnxxemdN/GoMCWsEYZ0vhViBjsmvMm/JcQEqMA=@vger.kernel.org, AJvYcCXbmnr1q+TTm9+P+nIm0ANlJxJN6JPkbDi77f+LbjH515JRjVp0cM/YU4xySbGNXX3dE/aeucbH44DmFaCE@vger.kernel.org
X-Gm-Message-State: AOJu0YxVYCi+SGcHcdyNmxQt9PrQNnc9G/DKj9jEZsmZbY8KkZeoQ7bR
	GvVI/brSp3rJ0mzA2P7geBOWfdNysApIjpnTxpPKpZvQ0Db/eVpGwpoERRWk1zfjQl2OzCq3axJ
	OMEGtLs5r6RftL35p6NECHFwv4JA=
X-Gm-Gg: ASbGncuQ0Fsc0f78VKxIf1nYbT45hGjA0TzDKW150CmwmxYO0EExGJ0gxVEDnpOVw9v
	2EdE5hnlfUEc9iQdIE1xIIfnt8Nw=
X-Google-Smtp-Source: AGHT+IFRC28bn5zw6rV/4zwbD7vVk4nlvazIl88CtbVj9ElsuAp3kyssxILbM84N5R4u454ffwnz3gTex5Bn0Ofoe/I=
X-Received: by 2002:a17:90b:3510:b0:2ee:cdea:ad91 with SMTP id
 98e67ed59e1d1-2ef011f6881mr15804718a91.15.1733419379423; Thu, 05 Dec 2024
 09:22:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114-alc287-nitro5-v1-0-72e5bf2275c3@gmail.com>
 <20241114-alc287-nitro5-v1-1-72e5bf2275c3@gmail.com> <87iksmq8ho.wl-tiwai@suse.de>
 <CALiyAo=5aLbYEyRWWw7QscTk6cXy5qckHToiPL6h4fKM9=skLg@mail.gmail.com>
 <87ed387ioq.wl-tiwai@suse.de> <CALiyAo=awTsGQnGH5UPB7dF5QsZ2AFkKv5LcJkJRXV9sv51iqQ@mail.gmail.com>
 <CALiyAokt1zY4a6F0DTpyYAmu38D1Fk0k0QvsFtXYHzQ7suS38A@mail.gmail.com>
 <87cyib4xmx.wl-tiwai@suse.de> <932d49003ee7444186353082495abb10@realtek.com>
In-Reply-To: <932d49003ee7444186353082495abb10@realtek.com>
From: Hridesh MG <hridesh699@gmail.com>
Date: Thu, 5 Dec 2024 22:52:22 +0530
Message-ID: <CALiyAo=UmgHdbM6qY5GNBQkFgPaMm3_fSTA+m3LLvnvzqbOBOQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ALSA: hda/realtek: Fix headset mic on Acer Nitro 5
To: Kailang <kailang@realtek.com>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Stefan Binding <sbinding@opensource.cirrus.com>, 
	Simon Trimmer <simont@opensource.cirrus.com>, Joshua Grisham <josh@joshuagrisham.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, 
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 8:16=E2=80=AFAM Kailang <kailang@realtek.com> wrote:
>
> You can assign model "ALC2XX_FIXUP_HEADSET_MIC" for the quirk.
>
> +       SND_PCI_QUIRK(0x1025, 0x159c, "Acer Nitro 5 AN515-58", ALC2XX_FIX=
UP_HEADSET_MIC),
>
That seems to have fixed the problem, thanks. I've sent a v2 of the
patch with the required changes.

