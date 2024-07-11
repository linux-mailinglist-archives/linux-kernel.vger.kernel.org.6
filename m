Return-Path: <linux-kernel+bounces-249853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C3C92F0BB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 23:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BF5F282173
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326F419FA6A;
	Thu, 11 Jul 2024 21:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QjuwKNon"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CF32836A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 21:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732217; cv=none; b=HqCgmoxDOd3iKAiLpkPuk57HgQKcfQgKy8YPWF2Oi+izZkgvUVzBHo93jUmjyRd/OWZ5AOQPu6iNjoYEn+yPGr3SylAjDlegHOBlPbu5hbyMUj6p9pd3VuVwKZg2nLk3qWuGnHg+hJVhUBzy9saMEbg6DIhkbfIT1MPa0TWQwL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732217; c=relaxed/simple;
	bh=GhoB4jdgPLUvG7kwGn5zgnlxuoDT8WRMMgSEmZbJmj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WshlIvjQXZ9Wsz0DGtITN8BrAfOdqYzaqcuYwz6lsUe/uiCTiYj6zKSVbQ9IDoYY+65dVGug2QbEiN/C82fSAhBReRRIS2VGCBP8MmQw751LdwCyoCZEODzEpy61MDRHWUrPwot17Pj+ye8XCk2okDIgweZb5S5M2JftAeqsZys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QjuwKNon; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-64b5617ba47so12953257b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 14:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720732215; x=1721337015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQEjnhPJsBKTlnL+AnULLgLA6phEDmk5N6W4l5c5JDY=;
        b=QjuwKNonZ2HHRTPkI7gzboeMAeLWoyvXN8gGBauvvQq7FJ7vet7tyUIrdD6asDTQNM
         0pTfNIkaFVLg7opKH0UZWlGUrfGAEc5rdg/8rAvJxONwhIPU4JsISGKHOFKZuxLdduCi
         6Zh7LBq0egYWA5TMjDIpAcbOyiP1eUqmBt/VTlxd79wnT8pOptAUfSoft80uoRV5qkrB
         glVudhuHzkNfGxmoLRudHbZNLXiM023GhClw/EYEeVDoGchQCRnNra4rElFmPjPmW2Qz
         J3eR8dfljm55++56szk689D+ruQLQQpyctRjuDqyUNNMogtEYD7YJdXPDSh6YvboR/np
         eY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720732215; x=1721337015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQEjnhPJsBKTlnL+AnULLgLA6phEDmk5N6W4l5c5JDY=;
        b=ppS3Zg/konAIm7qSPioRI4tnUAdrNL0DjkeGddU/NvskusP6A5hmCCKJAfuwmBpt4J
         noFaoCgnVaGnsXijNEbXGBBVxRqL9HiMwZCXfdr1JiOQAvXMoL8qylBagjXTxa+fj4wY
         1NsfZe34evqOCnDwLdt5HPvzFjlR2X24BwAhJcG7FPSHqeZ9IYoOnNe+y4P5PPoHscC9
         SdaGfdeNQuE3s1mcZtvvB9rjLvKo3HrWECpLonAmVpvUFGTf+mGnwMRAPJ0f3FSlmuOp
         pT5BsaJsISzRCgxZZgxH+I2W7nuaHUiUuC72LhN4uIMoDz+6DGOdXHrUBE28lnBiGVQo
         qq3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRDib09/5KNJP9B1a8NTJUYPiLqK2/BPkpWvYyR8sAwIRMcbL9ofpHg+GS6OY1x8WzTAMO707R2SbHhGPxiaKvFrbl3d3Df46q2qvy
X-Gm-Message-State: AOJu0YwhNXZXSpESjBjkal/PCau/guJIcY3Tv+2cgiAvovz0RnIYz29Y
	brCiGwf3aTSZSH8JVJ9YxYSUacMP44cw6P+xb2jq20NFBMV3VjgeeoS/pRALXJ6wZSuJvx+FVUT
	GC8gX8KnSFK5Bn5Q5LDeDaXaWHFS7UmqogmmU
X-Google-Smtp-Source: AGHT+IFk850plTl6FfUzJCerB2fJLct5MptmpXAlnhVn1xmW8r2nJvcEpPHxKRke7LUllx6inZ7id5LhARS4bwB6VMg=
X-Received: by 2002:a0d:d083:0:b0:643:673d:2f8a with SMTP id
 00721157ae682-658ef34aa9dmr92055537b3.30.1720732215050; Thu, 11 Jul 2024
 14:10:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703025605.63628-1-guocanfeng@uniontech.com>
In-Reply-To: <20240703025605.63628-1-guocanfeng@uniontech.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 11 Jul 2024 17:10:04 -0400
Message-ID: <CAHC9VhQ8y8fYeLz8KHXVNrLmp3cLZtUPHsagf3fym3gJvoTs3A@mail.gmail.com>
Subject: Re: [PATCH] selinux: Streamline type determination in security_compute_sid
To: Canfeng Guo <guocanfeng@uniontech.com>
Cc: stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 10:56=E2=80=AFPM Canfeng Guo <guocanfeng@uniontech.c=
om> wrote:
>
> Simplifies the logic for determining the security context type in
> security_compute_sid, enhancing readability and efficiency.
>
> Consolidates default type assignment logic next to type transition
> checks, removing redundancy and improving code flow.
>
> Signed-off-by: Canfeng Guo <guocanfeng@uniontech.com>
> ---
> v2:
>    Modify the format to follow the generally accepted style for
>    multi-line comments in the Linux kernel.
> ---
>  security/selinux/ss/services.c | 36 ++++++++++++++++++----------------
>  1 file changed, 19 insertions(+), 17 deletions(-)

Thanks for the revised patch, it looks good to me, but it is too late
in the development cycle to merge it into the selinux/dev branch; I'm
going to merge it into selinux/dev-staging for testing and I'll move
it to the selinux/dev branch after the upcoming merge window closes.

--=20
paul-moore.com

