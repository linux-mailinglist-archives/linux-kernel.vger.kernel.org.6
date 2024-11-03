Return-Path: <linux-kernel+bounces-394036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D31E39BA96A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 23:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B79DB220C6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 22:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1698218C03C;
	Sun,  3 Nov 2024 22:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b="nmMNBHbG"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA449189BA0
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 22:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730674394; cv=none; b=KwJesdPMQ8PB0CsbZg8SnReTpVw0HFurP9fvBqX39hnpcg4PrzqXhfKq9uFTCwTFDv1RjEFzj1QafqyPXUK+mv/FlblWecClSW6xANRLzFqSMtJCLbg3CHtYZ3VGnkAP81DT5GxQ1W4M1cuyAbO8WaegzxG0sUpviyUl8TMAFCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730674394; c=relaxed/simple;
	bh=h0N9JSxmh1chs4NvO7r3yn1fpf7R04K7m4MXQCWx5Bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l7LnQoN9ssWnuu7iFRrFSB50CZXcFXHAb/foreyKyClULRZNvwTp9kjTbFZrpLNF5xcUoQ+1xjZNveW6xA6aXPHfnt5acmLV6sY9EIxC+DkLSzNabCqvb5hxsHJW4SVZ7YLsld3NnXi1kYmr3piQTEr4lT+YoFlLEiZflQEy+Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com; spf=pass smtp.mailfrom=netflix.com; dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b=nmMNBHbG; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netflix.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a99e3b3a411so717983966b.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 14:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google; t=1730674391; x=1731279191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/o07MZV6TjINQ+zDnpBISVrIcwIjg5m7Y/v0tWWBlU=;
        b=nmMNBHbG7YxxK/QqGj6a+dPbafeTNMqt3paykLErXBrPx1TwmU6amIGCa63jzEqHrG
         aMk4TEOfUY9zlDPtBvkHyBv3b6wk6Xt1JqLEQFvwY6AR7IrC9B8i3G2HaEhaTvxVLFCA
         SvJ7GUOwoUJokGB1gAaSuP2L3wLl2F49RNsgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730674391; x=1731279191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/o07MZV6TjINQ+zDnpBISVrIcwIjg5m7Y/v0tWWBlU=;
        b=H6sQ2r4ABZn609Mx19GutinJ3d2bD4PLuGzFrOgJ3IVGA40CKtofRPMaM4gL59723T
         AHALJDJHE9Ob7rNDalLpU8ZYjqmiNh+TWOoBJeSQ0irmJ+cu2qZdbL87JbvD46mdUL52
         KEj9di4PTEf5f66SBNhGBgPt/RghmzumNULVLWwltOkDLc2ygDw1gr5ZNXFUekRgSINA
         oH72aPdtai061uEKndx81yiqxJc6NOTYkK0k1qBkDG6UtRwq/1cRQgWyU0LYD057paxS
         o9KpFJW9pEEpHMTs3jAsZhV89hzkXh1n5LgBcQqhLFvU12DGaNdRI3He9NGo34M0gFJY
         5TRg==
X-Forwarded-Encrypted: i=1; AJvYcCUeSeSN7t3HO89KlQdK6do5ZAhnYnGcwskHpHZ6PdCXtQ8TZMoSxBLNK1YlAX6AC+3j0Q2be1HKDnnl55M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUo0QrlNUtqWbJwRb1erXQZktrzZP3kqdyxobwe7+gbddBg7Ak
	Szzl8IbwWsy/nk4xNgHhnu04ImVFyatpdLMzWl+YVHMnoi/8IUvMB5YvY8xWJWLjOY0v+wVmDMC
	Giv4fCfxiBtvT6NoSExdQ03SXasLzF3ko0+5mvg==
X-Google-Smtp-Source: AGHT+IFy4o46TYKoQTbVYKAMB2on6bfie/1kLl5cIFqDUnN/9UDRY5lszF0hFgsjo2kqN5eCFId2gUMEqsXUF4IgBZM=
X-Received: by 2002:a17:907:3e9f:b0:a9d:e1db:de8b with SMTP id
 a640c23a62f3a-a9e55a80e56mr1303129166b.16.1730674391087; Sun, 03 Nov 2024
 14:53:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <18f60cb9-f0f7-484c-8828-77bd5e6aac59@stanley.mountain>
In-Reply-To: <18f60cb9-f0f7-484c-8828-77bd5e6aac59@stanley.mountain>
From: Tycho Andersen <tandersen@netflix.com>
Date: Sun, 3 Nov 2024 15:52:59 -0700
Message-ID: <CABp92JB9GGbxWO0Q0QhkiQyZoYoAGmz7agaEp8VyH4ciXoELDw@mail.gmail.com>
Subject: Re: [PATCH next] exec: Fix a NULL vs IS_ERR() test in bprm_add_fixup_comm()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 2, 2024 at 3:31=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> The strndup_user() function doesn't return NULL, it returns error
> pointers.  Fix the check to match.
>
> Fixes: 7bdc6fc85c9a ("exec: fix up /proc/pid/comm in the execveat(AT_EMPT=
Y_PATH) case")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Oof, thanks.

Reviewed-by: Tycho Andersen <tandersen@netflix.com>

