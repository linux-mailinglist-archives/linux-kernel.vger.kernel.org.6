Return-Path: <linux-kernel+bounces-323801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9159743A9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35BBA288123
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFA612CD96;
	Tue, 10 Sep 2024 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HrqvSguV"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61EEBA45
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 19:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725997567; cv=none; b=mEL8Wp8z160TKJbFBLbMnGhDxMICkr9rEOxKq3TvT2Ag5i+jeCY5ggsafgc8WMsmzo6E6g4B4qy63+bLrfyra3LLug8DqC09SZdQDKPyxLOu0dehtmxFMwV+mPDfE04M4jXbooTSTntxR09UNn0ImnnnCr51Kj8xv+2OOBeH3E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725997567; c=relaxed/simple;
	bh=QBqw6gziGf23dU8+1mGT+PEGoWX0UtdqDF+Lqa8STv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=loGUU5gwPe68xepZBfJQplKVaRO5yKWh/y3b39DKoM0I1oToYjEojChHk0lmCiV7k5XU1ka4vq/0AV0zwq9ejhhcx+St4M6wK1Fkh48/KkrfuJj3V56cZFtUDRhUowjRj/C5KYL7/Q9ZiJ37mc/tsVWtN/vOoGG0gCcRju/vzSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HrqvSguV; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e1a74ee4c75so6207306276.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 12:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725997565; x=1726602365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGMVJNuYVmspnlv8k2Ek+U++kVby1SW+hA87sFmyA/k=;
        b=HrqvSguVlwllJrbJOkxGhgbKfouCFXUk34B+t20hs5KGHb9Mxk4C/ZWuRiFYtt6ndi
         9fh9ppZ0y57Qetz1vA38qmUHXkXKpHNF68hEH35u3ZQcs9CFmY8nCe9CZu4mSnsEyC+e
         QHHvC4mOzDifwCcGZeKClKnAn7v09p1127uhWvXcvlEN2h1eRSZcN0jbuH58n5SPFexW
         /KPejj6dWHF2lqnJJ3ubmW7Zb+BlzKYgNl6heoVPAf73yWOpB6Kr2gQdY/o3poBmgMz+
         IhX2U/oXDqwgNhj0x8hlOWfT/nxkOzb32XL/pW/TBYjxlN0ErnN7bJU0XT5JvzCNpqMu
         AivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725997565; x=1726602365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGMVJNuYVmspnlv8k2Ek+U++kVby1SW+hA87sFmyA/k=;
        b=v50aq+9MM6nBDRwuzO9z3jVj+uJiF/StnyxkLrKGF1mR2Wu1DVMJddREHldKn2f/J2
         VRUe/oBV9vjOnHMV25TXx0k23w8rNpS0/EhlwxxJYuTnVsWKdsdkKk89TcZcRUVCWzhA
         J1/23aATr8fT5rzlfIOVT0ZeHggOyjlUThUX39jrqQtHlmBbUwEdEQxpbDRZNOwS6H7Q
         dPbeGJhpBKZ9KsHVCRALYu79pNTQlBI/gR0BvuOVb6zqJyGFj+UmiVqRK08/T9AuM+7D
         hFkVeBL3UZPsZeUgsaIXv+v0ottoL5JsAW6tFj4mXRp5muBszc5Esbo8X1XsuAiZeV9i
         iYVA==
X-Forwarded-Encrypted: i=1; AJvYcCWT+9UDdlwv8xW1acE55ggldrPs5vjLynU/55myzO5ODyiQv/6EBXc41CiBWcaaz3snZAqSkcO3gYFu8Jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeAWe+CrnqL9CCSnisK+UoebkbndNDJHIeEzRH+bvs/du/EgXD
	xX89OXFtMVamC8ndPG/Z5nMcZJrhQPW7zp/CXZ/S7RmfXR0vvuQGF1HB6QvcsaayiTvaBRdKO3g
	PU3B355MzxclxziGtOAwc3FCVJrPYu1K+1NUVyGDDjaubVsk=
X-Google-Smtp-Source: AGHT+IGEY6Db9V+HMZkh01TPbqGXgUQsNjb/9mYCmCy6WgYF3hmTtZMDxdx1lSISAmzW4RleXnfFtRWZYJ2FtLTp6lo=
X-Received: by 2002:a05:6902:1b89:b0:e1a:824f:1216 with SMTP id
 3f1490d57ef6-e1d3487fbe9mr17412009276.13.1725997564624; Tue, 10 Sep 2024
 12:46:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910132740.775b92e1@canb.auug.org.au>
In-Reply-To: <20240910132740.775b92e1@canb.auug.org.au>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 10 Sep 2024 15:45:54 -0400
Message-ID: <CAHC9VhReKtzhTBbOxDWWeP7Tk=VoxVrYsLPt-v6TPCnwzKEiXA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the security tree with the
 vfs-brauner tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Christian Brauner <brauner@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 11:27=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the security tree got a conflict in:
>
>   fs/fcntl.c
>
> between commit:
>
>   1934b212615d ("file: reclaim 24 bytes from f_owner")
>
> from the vfs-brauner tree and commit:
>
>   26f204380a3c ("fs: Fix file_set_fowner LSM hook inconsistencies")
>
> from the security tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell

Thanks Stephen, the fixup looked from from a LSM perspective.

--=20
paul-moore.com

