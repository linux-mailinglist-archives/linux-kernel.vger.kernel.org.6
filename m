Return-Path: <linux-kernel+bounces-273161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E47894650F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5E41C216AC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650C17EF09;
	Fri,  2 Aug 2024 21:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/IRgE6+"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D53D61FFC
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 21:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722634199; cv=none; b=PUbWNpGhm+Sw2sDMfwfQeTQOFquWZ1MWuAG/8MJiPMB/tMqYEPhNtmUkpN7/SYlTsDNuBQCMG75l/PoP7yf/JpkZ5xtNbDykvHjUtf+ZBpaHpReXZ18DpmEeq1xOfqr+zIH1mODaLSHoRh91BkPW4qhZ+fJDnBxGTnr7bPh7Oj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722634199; c=relaxed/simple;
	bh=Eqd5DSqcYMAnbki6Oa/uDzMz0iJTYPIDWjPGs8KfInk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M/AKKWwv/zZK9hpFOoSVKmQklMwklijgt6X2pd/Z2v5QAxpie5yrTQLvqPDNVWOKdCsRGMtSgDwS25s2DqCKVIeztOIzjH9SrCcLo2zauCfNzUcw6lfcoWuOAp/g8i8RX6WdV62GqUVcDJJL/odA+RQ4Sf53WyJvN/6fkK5veN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/IRgE6+; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b96a253c59so12630866d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 14:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722634197; x=1723238997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eqd5DSqcYMAnbki6Oa/uDzMz0iJTYPIDWjPGs8KfInk=;
        b=h/IRgE6+kCYZHZZe15wgv6U50+1Z6Bgx+0Xq70XhPUp1vNyQmjuwNYJ+IdZ2EEqCxQ
         eAjOohw3LnQqO1KBva97G9mWe6yNM11wgoP+UPEejf0gmZwRq3MVySf9ay2OCZZjJxsW
         ivYrtcD0uRE1kixe4ghDaUgRB/6LYL5Ubjdwk4OC6TKONqkxgYQXHi9dxVTisr0Fym7I
         DeBHjdSrqM6PfISe2UM8jk+1BoyXFnwz8gcBk5f5gmZs6/tArJWE0h3aJA7vA5l810Kp
         4fGYQV2kZ7sWeY/FPQ4AjmwjUBgBEb7ZcUr0eqXKCMlxVAX4yVoZC3drFLZEbDBhgc3Y
         kOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722634197; x=1723238997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eqd5DSqcYMAnbki6Oa/uDzMz0iJTYPIDWjPGs8KfInk=;
        b=EHqD135MozQvSjz85lXYdKBQtOZ1K6Dxmt0Z+ZpEckCh2sWfJQBNcWRTnzD7I3dUWU
         gws0m4ul4nKUMMr3t1KE7TIrS2g2uux+NG+D+DtQmg/cNr+fBLWHTVGwZGvH38I8Q6rR
         bBBVeza/6WDh5IRP7kH1qC6X26aUZqsDZwQDq1T565ZUG6eVP/SbjnvjfD/1/z19qhik
         QQBzk+yWAskaDdHV3slGXaiUulV8PO8ZTRK78sypH9+T4HHibyxalTYCMSsKS34VbG45
         w0msN+rhv6RCm12NwhJsSngFsK4cCqLY5T8vmzDG3MRyD5/uMwDA0npoc3nB88uSK7eo
         JLcg==
X-Forwarded-Encrypted: i=1; AJvYcCUJgC8sZj6LkHjVTGuzgcDbqh4ZCvVWtmLBl/ceURKCuO61Rf0U6vEdZoW/3shVvqAIrvJba2Oyfx3fs/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkvGCfnbn6+aacbtwtkC1+OqO6/5U/8DqcrN4f5reo9aVKPFv1
	3umECLAB65sGNZ/3zxQ1tLEnvnGEIg9YBKVLVz9xiUV5xL27oI68avAyfRp7wZrRW0eyH0WAzSN
	IBeMXoMaw99Dtpa/Ojv59Sxr4Mvx8AgKrGAlqFGvL
X-Google-Smtp-Source: AGHT+IGeyPkk/dWhUIyWDzjMBB8iGs4RL6xounmSFkrEvZlAvm16BiP8UqA0qIQBOFfHGQPdk9Nxri4ADWEeHCXChxk=
X-Received: by 2002:a05:6214:e8c:b0:6bb:3f69:dd0c with SMTP id
 6a1803df08f44-6bb984bab76mr33918776d6.9.1722634197160; Fri, 02 Aug 2024
 14:29:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsMmtqzBfUykT-JgyhZn-7ZXtftHL35znDdYuTnUOpGnoQ@mail.gmail.com>
 <1266c4af-a000-48c0-bd0d-79c2e918aea9@gmail.com> <CADnq5_O-hKQZoMxuX2=HiukiorxE=bFAJownQFkTbzNR2d411g@mail.gmail.com>
 <CABXGCsM=Q-Xp2d0Ht2J78FupEtOtMh1bhVMUZtOqKqSoiZA8cQ@mail.gmail.com>
In-Reply-To: <CABXGCsM=Q-Xp2d0Ht2J78FupEtOtMh1bhVMUZtOqKqSoiZA8cQ@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Sat, 3 Aug 2024 02:29:44 +0500
Message-ID: <CABXGCsPr++1ViN467+uP5G+wdFmZ_Bnjoor9VLndZoAG4qS-dA@mail.gmail.com>
Subject: Re: 6.10/bisected/regression - Since commit e356d321d024 in the
 kernel log appears the message "MES failed to respond to msg=MISC
 (WAIT_REG_MEM)" which were never seen before
To: Alex Deucher <alexdeucher@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
	amd-gfx list <amd-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"Deucher, Alexander" <alexander.deucher@amd.com>, mukul.joshi@amd.com, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 10:16=E2=80=AFPM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
> > https://patchwork.freedesktop.org/patch/605201/
> For which kernel is this patch intended? The patch is not applied on
> top of d67978318827.

I am able to apply this patch on top of e4fc196f5ba3 and the issue is gone.

Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

--=20
Best Regards,
Mike Gavrilov.

