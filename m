Return-Path: <linux-kernel+bounces-446102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD239F1FE6
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 17:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25BBA1885CCD
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 16:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DA338DE0;
	Sat, 14 Dec 2024 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ra67mIeS"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F7D17BA0
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734193906; cv=none; b=aWFbA2RPsl5ahP4+QuHGlVlAnQoode4b3AlJvIJxOQDz9cZEhTqSGHS7R9l7NSf42vptiNmdZAH4xtgEIffPFfn/BAWUrkgVigFPTr7Pos3xCzfASLtCdMlFW8ILaCoIbqSfgN7bl8ASlnEAJ3AYwcP0v7JNCumUs5DyVAB4G4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734193906; c=relaxed/simple;
	bh=aNfapG6I/CUOP9Y8AfR2pHR5FECAZ7Mbd4YYU7awi0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=euk0L+NZRJDI36UMId1qzH/C+Ih1Bhh0MoesGgKQ7RDWnx/FAjTj4eVdM0qmo8lQfCuDi2s7SFXMoQDvrI0g+0Zjp7CyZN6jh0rzTuSkd/j8pFD+CKJ/Lio8SX7t2zlIrK+NzDeuMjSDdU6/MUY02oQfcSbsNqf2njGPMdn0Lds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ra67mIeS; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa69107179cso525069466b.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 08:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734193902; x=1734798702; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YSMPYzUxCS1+M94lq1DhBfG9d5bon4YtVfF19FFr/ZQ=;
        b=Ra67mIeSVjc+kW4pyCZFsTNktDFmwh6uM74o8vTN9Q/eKlxsE0wZ1daXOPk0jpMsqB
         UkcAlATlRj4kETyOgw6KCc0Bl5PLnFwBWczyFZ4AAhIsAXwe/rymHXYlbh6+XyXcDC/y
         fTIze9b3CgKI+4szV4M7eQXf9MLIJIPhiaffs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734193902; x=1734798702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YSMPYzUxCS1+M94lq1DhBfG9d5bon4YtVfF19FFr/ZQ=;
        b=Xh62VeNj4B4rXKFjds7T+bcjtRCijYQ2iKu/lEh4saSBXMmZmBYmdLXJVsrFlV+tU0
         N5v8+DP4tRTH4hpO5zOr4h99rI2CcyG1K07fFkvAnnrujF1y8N5Bl4B05bCwj4Q+yvk+
         IJ2YOW9g6UMRkoRMt7EoFL61VPuwNz01JR+CjPxtOLmptyAD3f6ObhmVgaszFeQlO64b
         2VajLNZY142yGsg18VztXzDzghxR3YlIHD6pHUaly/zfp5F4652O2MdyyWkfp9NjdMde
         H2VT+wRbX/vec/ngJ05Xc+3UQLyBi5t8Q8xQKP86YhNWxsJC3L0/D+53bGzLUwsnWHtr
         W/mQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxF7AC96T0woWfZ1aSOwzrzzc1qRj+SDWDtBlP+4P/Hm44Pji6983UpuBu78Lx8OUFg3x8KA3eejDD6Z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMOoWOlCuGYD1PfPjeZQ7wUGF13cOqjT9T+bGOAFo14tVUSjY7
	4uwMyWBZMGGAaby7FH494T6cxtZ8a9NSTKThnfiEENhlGocfNHG75HDezlpL3Ow8vFTtN6y+OYl
	QsOU=
X-Gm-Gg: ASbGncsdJcunX5pu536YwH67o9TFxb1lak+buUewtZLXFB3wdOL5QePnefJpUX00kvN
	xKEHEYPe5V6wnUX/LM+EuO+42Uju9StpeX2N1eRf0ZI8q0WGZHnVpYh5Ehg1X8XiIy/hgrkpX4P
	W8y3UOE7kUZDVRDb1qB5eApfMf0XqUsO85OGKr3MieidjERK/STIQ82uLExMmS8SILWYNo/P4eK
	LQ4kCJ8wweVjQtC6gabbbeZdGbyRMqBAuh5wjDLZsAweDGma6wbZ7etF3thhl2s6tfzNBYJ3378
	aFP1+tSyq9nMRN6PsWS42sOGIKewwlk=
X-Google-Smtp-Source: AGHT+IH7m9zTo0N3Sa1d1LVc1fJoHKrqOAmURMzXHxgBWQaXL2Yhh9ydbNgNrvqvvjS4zjgh6jHnSA==
X-Received: by 2002:a17:907:7d88:b0:aa6:94c0:f751 with SMTP id a640c23a62f3a-aab778d9da8mr750584466b.7.1734193902586;
        Sat, 14 Dec 2024 08:31:42 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96005f89sm111557866b.35.2024.12.14.08.31.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 08:31:41 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9e8522445dso547802466b.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 08:31:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWnr4a3gGtuuUUJrF54jfmtAHCex5I7XlpKST15rJYyUoZp3LCZAQ4aRFe3QSV0rw4OLu+e7TosrJY7oc8=@vger.kernel.org
X-Received: by 2002:a17:907:2d26:b0:aa6:691f:20a9 with SMTP id
 a640c23a62f3a-aab778d9db3mr565846766b.4.1734193900694; Sat, 14 Dec 2024
 08:31:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733421037.git.geert+renesas@glider.be> <46b320b91b8d86fade3c1b1c72ef94da85b45d0d.1733421037.git.geert+renesas@glider.be>
 <CAHk-=wiwAz3UgPOWK3RdGXDnTRHcwVbxpuxCQt_0SoAJC-oGXQ@mail.gmail.com> <Z12sScjRHpB1d0nO@casper.infradead.org>
In-Reply-To: <Z12sScjRHpB1d0nO@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 14 Dec 2024 08:31:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgrc4zvZg+Sz_aLmMbaJ6ZHYaJBQ7nzByj2pMZBbh6www@mail.gmail.com>
Message-ID: <CAHk-=wgrc4zvZg+Sz_aLmMbaJ6ZHYaJBQ7nzByj2pMZBbh6www@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Increase minimum git commit ID abbreviation to 16 characters
To: Matthew Wilcox <willy@infradead.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Dwaipayan Ray <dwaipayanray1@gmail.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe Perches <joe@perches.com>, 
	Jonathan Corbet <corbet@lwn.net>, Thorsten Leemhuis <linux@leemhuis.info>, Andy Whitcroft <apw@canonical.com>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@corigine.com>, 
	Simon Horman <horms@kernel.org>, Conor Dooley <conor@kernel.org>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Dec 2024 at 08:03, Matthew Wilcox <willy@infradead.org> wrote:
>
> I have wondered about using a different encoding for the sha1.
> Classic Ascii85 encoding is no good; it uses characters like '"\<
> which interact poorly with every shell.  RFC1924 is somewhat better,
> but still uses characters that interact poorly with shell.

I suspect that the pain would much outweigh the gain. You'd need to
teach all tools about the new format, and you'd also need to add some
additional format specifying character just to make it unambiguous
*which* format you use, since if you just extend the character set
you'll have lots of hashes that could be either.

And you could disambiguate by testing both and seeing which one works
better, but at that point, you're much better off disambiguating the
current regular hex format by being a bit smarter about the objects.

Using base36 doesn't add enough bits to then make up for such a
disambiguation character in practice (ie 11 characters vs 12 - not
really noticeable).

base62 would be better, but christ does *that* really result in an
unreadable jumble. At that point I'd rather see 16-character hex than
the complete line noise that is base62.

Also, I bet people would start looking for shorthand formats that
spell rude words.  You are kind of limited with hex, and sometimes
that's an advantage.

                 Linus

