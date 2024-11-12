Return-Path: <linux-kernel+bounces-405603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 862609C53DA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C087281A8A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4A1212D16;
	Tue, 12 Nov 2024 10:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="MTdWGo2v"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9561CBE8F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407576; cv=none; b=J3sllKQZyZJT30LKC983/UdSLyL/8xMKNkkPXqIx1EM/O1/n6oAQT7UxKUSTSYuRzhL3p9eZXNj9ljSK8/LiB43hyVei/EXoxdlnz3KvvR1WZaAX5A1m6xkyXmhlHdATS8/fgqmUJ05ktcJf+r4IE77qQZuEZfskk/ISjXlWI0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407576; c=relaxed/simple;
	bh=OIew12GHF+xnt8Vkq19r/MC1ps1jVYsEHY2A8MzHpF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXaf4eY/7uQNfErLuSzJNUKgPKReEtcvsxF8mVAF+kjTF/8Sevjsq0LAKmdJMJK8FQ4pF4hpvY+X9OPFoVs04w+R/E/TvNQou7oot6RfETgafcCafH1vzzh4Sh7Abn2+gAH0NKa3raRTb6Y328OCjlNLUszSDSUJ+yDPmp38LWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=MTdWGo2v; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-460c0f9c13eso47234831cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 02:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1731407573; x=1732012373; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r7gAq+ChZEKrR9v0dJsNpJxXDvU0gKFXo5LHzSUCVyQ=;
        b=MTdWGo2vjRF9Jb64/hLvhmfUPdW6E9/2o4cFsyhCdgph+c5OGHE+6IrRaoVQd/wJHc
         CVJNA1feXS2qwpoh6SyHYA8W0Ffqe8L+CQYHO8dVNAhSwOeNXoBO2nPmrIUwVvV6CdoZ
         OnrOBHcoEsrARNmVD3iwzZqW/4iXs+JCOd8TQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731407573; x=1732012373;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7gAq+ChZEKrR9v0dJsNpJxXDvU0gKFXo5LHzSUCVyQ=;
        b=EFKN9YXfSjnDg/HAi7tJQpKPG7SpekEJL8nzDWhSngJIXgetDt1BMnBqbFse9oN96r
         YGf0Fj7QdCO1V1fFP7z09tQNrtOQV2X+bVyixRPbSfxwzOGIFVwz9os0x5ZnV/cvkk38
         kFFKhmULJLEAh5e64SV0qLo+8U8TCaN/CKrzbrgrLBrMz/0xfrSvgDBHZ1lctz07ABgx
         URgbDA83T8l0SQ4T+wnp1FJW7F6kZT0zqJeyUUbebMDvTdNn0Rr/979z+mvLy3RP93nW
         daOuMNTZDrroGOMZ+KAt/Ctne43/pHipmUBrV8rp/QZOL0ZRqcx1cOuSZADkMWwUEBdW
         wrGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3hX1OuB54t/75TgYgRp4Z9wtmZMSoVC+20lluwIytvALCzxBP6oEPcHUTxHce1zeB2izP1VDuAChRUrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YydqewWTtzTg9UNh/3J7ScJ2JUZN3Z23sBoQ7t3Uo3kVvgaYgzh
	dFWnIky/OUmG/UxD5qaNsQ6yK2X+8LCwUgn1jGm+roiQf9HOqtaks/puLUMkpxjWcpUu9YgRwlS
	8SiTWQlKKA+pYkDC+Ozg2sughWkhO0G6SzoJBarp9ZEvIESbymfE=
X-Google-Smtp-Source: AGHT+IHpSETzbG96Ob7chAWHSfTkPJ7hV2uyCplMZIYtf3U1U9TVDdH1wtyxXaUdTVsu+jL810WTxx/QQ22N+bZtYMo=
X-Received: by 2002:a05:622a:5448:b0:462:a961:6316 with SMTP id
 d75a77b69052e-4630864c5f4mr279927521cf.26.1731407573119; Tue, 12 Nov 2024
 02:32:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111-statmount-v4-0-2eaf35d07a80@kernel.org>
In-Reply-To: <20241111-statmount-v4-0-2eaf35d07a80@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 Nov 2024 11:32:42 +0100
Message-ID: <CAJfpegtPY+g5nApZ47AGbexncJrvUJ7iCotYpgApCHzGDONGqg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] fs: allow statmount to fetch the fs_subtype and sb_source
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Ian Kent <raven@themaw.net>, Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Nov 2024 at 16:10, Jeff Layton <jlayton@kernel.org> wrote:
>
> Meta has some internal logging that scrapes /proc/self/mountinfo today.
> I'd like to convert it to use listmount()/statmount(), so we can do a
> better job of monitoring with containers. We're missing some fields
> though. This patchset adds them.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

When thinking of the naming for the unescaped options, I realized that
maybe "source" is better than "sb_soure" which just adds redundant
info.   Just a thought, don't bother if you don't agree.

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

Thanks,
Miklos

