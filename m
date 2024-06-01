Return-Path: <linux-kernel+bounces-197940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 520DE8D70FE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 17:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9BC4B21C60
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 15:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3708152539;
	Sat,  1 Jun 2024 15:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PPDCvSOn"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4FB13ACC
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717257126; cv=none; b=imOdMADpUoTVyeq8KOHtIy2CcVAV301nEXvRznarRAXQoeqWYMewjBYWyaYO75T1WDJFpzUzD+ED8Hcb/9JwSO8YUdJZGrUWpHJHeOeiVaqFgn4sa+vpv4H+Nat+QXK0iVZBJxQkLS4iCdcJzYuMGxt2TwsRPgJ0HPvEUyrnwdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717257126; c=relaxed/simple;
	bh=qJS3dptAs0b6ICH3HfZ/O6wWzFNWchWCVlNuDqYwGPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=APCR532iMfJCKK/a7nSd1h71wztfVXAlMs2zAqRBilX6TrWk878ka64HyDqtu9pk/F5hbE2dJT7E4rEgxPfeFb8+s2Q4RSoAkmY78IMD6X2X1+bhRu5jYtvcJL5IGRZiuPodXZxjpRenIBNbq88/vyehNYBYUWuepqtLJN8+qpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PPDCvSOn; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5789733769dso5388736a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 08:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717257122; x=1717861922; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ubgchBBIIBDPhTkq9U6D3Uy86lpfCKuAOR1AhGG7tMU=;
        b=PPDCvSOnW3/6HtWoRlC1KnEWYXd6l10e+8AMMnR/f7678jdRU2bm4CdEEEJQ05nszh
         nfKeu+/Cw088+gk/GJFbtr2yuWlvGd4QikWXYLX42pAXSlhF9V6TA//i9FsPj9HH3hjN
         9mxCrdF0VfuYJ5v4bMjAWKIKpJVYlqIbZyPt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717257122; x=1717861922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ubgchBBIIBDPhTkq9U6D3Uy86lpfCKuAOR1AhGG7tMU=;
        b=L3HYV4OId1jsbPzAB0Qu++MWwrr4i5ha7ePIYQBAFr7X+gYRi+JlUXIQ+qF8oANpgy
         /mC+TQ9rvobWTsDlzNMtY2E8Npm5pxXD6SsH8XJ802ElnYubTk51PM2cXlALNTJC7z7h
         GiB6JogWIelYEmmVLTD6kFxXtO7jSI5txuPbB6BzImbzXyHIQmxXjrZQPQ9ack9blBNH
         nzt8PmTs0imTtvm/OdMolQHY3VRDwp76Xlt0l+9OEcqI0Ao1sChiALfBNubvES5jA3yF
         aS4bPsLiBItWd3bBcT5ms/kSskJ7AQlJKvY/plwufwL7408dkgqO8iUWkUrlVibmVuDA
         rmMQ==
X-Gm-Message-State: AOJu0Yx5oQzZm3W+7o3WfwIE5h/IKtpCVi0koSU10wvSMDYoSvaSocv8
	jGiZ7Jb/unLsUA0YmaKBOVirzGHxyuYLvGiFvLDLYjkejujC1UFz6dmXGBKXiKU7xveLUEEg45o
	plC2GyQ==
X-Google-Smtp-Source: AGHT+IEiS3YZG5hgHnWUWfdAcQiZ1VPdZ5gedgXhgOqy1YS0Chi3Fu13fjDdODg9sP8lGRTV7cPKCg==
X-Received: by 2002:a50:874f:0:b0:578:d846:fc0a with SMTP id 4fb4d7f45d1cf-57a3654af64mr3229283a12.20.1717257122181;
        Sat, 01 Jun 2024 08:52:02 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a4606f159sm1167590a12.43.2024.06.01.08.52.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jun 2024 08:52:01 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59a352bbd9so488898966b.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 08:52:00 -0700 (PDT)
X-Received: by 2002:a17:906:6a04:b0:a68:e681:be2c with SMTP id
 a640c23a62f3a-a68e681bf23mr1574266b.20.1717257120610; Sat, 01 Jun 2024
 08:52:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405311350.388C0A398@keescook>
In-Reply-To: <202405311350.388C0A398@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 1 Jun 2024 08:51:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi8Y+T8d8fdyo6KDGfy3Z-Egd=NBfOjzwLuQjo_6yarYw@mail.gmail.com>
Message-ID: <CAHk-=wi8Y+T8d8fdyo6KDGfy3Z-Egd=NBfOjzwLuQjo_6yarYw@mail.gmail.com>
Subject: Re: [GIT PULL] hardening fixes for v6.10-rc2
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, "Ewan D. Milne" <emilne@redhat.com>, 
	Marco Patalano <mpatalan@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 May 2024 at 13:51, Kees Cook <kees@kernel.org> wrote:
>
>   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.10-rc2

Wait, what?

This is not the key you usually use, and it isn't the one that is in
the k.org pgp key repository.

The patches look fine, but no, I'm not pulling hardening patches
without proper signing...

                  Linus

