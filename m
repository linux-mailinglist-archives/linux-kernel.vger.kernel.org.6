Return-Path: <linux-kernel+bounces-290987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A77F955BE0
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 09:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18A771C2114C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 07:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F250A17BA0;
	Sun, 18 Aug 2024 07:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHt2mONF"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECABE1758E;
	Sun, 18 Aug 2024 07:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723967768; cv=none; b=Iynt8Plrt0HA2DQHH/L+a78e3Vn23+2KNHmlFA0mraRPYB4QMvdQAsjGRBh0aRms9T3MevTZeCweTETkNuLICFZK4JyDCfZZWlUG0fLAbF7cOCy8RPA6KcfJWBvZE5vlernksA5gq+qKsP9nAFKXDRMXdSYzUU46gMSklwZl0Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723967768; c=relaxed/simple;
	bh=t8uTSm1OjmGe81hLPjCF+uvzw8vE2zCcTHLtkDeI8gQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MidPrvXFw/8JsHgLeTYYXSXrz5P1LEJ1sq2kSQ39QqHhqC0ar89LttGnsPTaHPIjYvoePaAfk3aprMr9N2L/X42TdZWudHua99jNszZg+slBhVoGhienB96d42McLmtbU4qgD6jOSaDcQwQ0oxDS3/1fkj3FHV9O7vhApYy1pVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHt2mONF; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-70942ebcc29so2442044a34.0;
        Sun, 18 Aug 2024 00:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723967766; x=1724572566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8uTSm1OjmGe81hLPjCF+uvzw8vE2zCcTHLtkDeI8gQ=;
        b=OHt2mONFOgciT6+BMuEnlcMINPHncSmo7mKdvXkA8E2kKjNa0Mvr6T430cnVVhftJr
         04Sn9jMxJA2l7Oi9iVrpDfccte4qIfNnDiI41UhVNUu+tbPO7HcbbPqJldRB8YZHIEId
         NVNacGwYHe8FKUEi4S/71ETlkDN+jUEtPd5dw7mxT2Uur8Jy68zcAk6MBbs2O6kMkizW
         DZpzPrq2QbBAtmM4xMfUKHOCETgnI2ZD4Hgks5TXdNnbuJZZ5gOtVphIhD1b1YshPl0H
         7WlxkmvdubD13rQpXtjw5goI7322H7lH7Vf+WFNue4n41EFWILLfDLatvj+TfaoiZxyT
         sgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723967766; x=1724572566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t8uTSm1OjmGe81hLPjCF+uvzw8vE2zCcTHLtkDeI8gQ=;
        b=PGfVqp+0LJP431lBuxsiZr622zeTFpAbdMtaPQ30xU3oAhrFHIC9te/WHMZ23pQjDD
         R3vXKE2ZteuYuzUop5J55mhj6/UE3mOccbfu3btTa3yvigO+QW/g3uDpfk6O4zN53al9
         3iDY2RzAWab7ihUYmQJ/1+atI7iir/B7s4CRNMOyppFsrYwSwFkCtULyukRq9cbMt/of
         KBk5qMArnBo2zgAYLjseGYZY74J2BRhxM8BeA2Pn/tpoJkpSED9ArsW9Z3sRKe3CMw65
         IggOmXWNgcs3FzlorcW1qx1kGQ967uGJf4wiH6oH56ObV9pUuCieTkkUhtRVG562rznO
         6Ojw==
X-Forwarded-Encrypted: i=1; AJvYcCVmuyLniUeGK/LiC153NHmgS2xx3tq2MW719NB2c/8bWSBGu4vCTEGr/XlW9F56B4W9QhAkizpqL8DBT/VKHwicTUP0xhhshhUkFz4u
X-Gm-Message-State: AOJu0YwXNZOp9uvX//ECnF8gbArq+nB3aTrZEp27g0p+aRP0psvzrDyt
	g0eDEAKNZ2YidStblRySjp35Ce4JEEh2ZHX7OL7cNXyMRlngIraZBcgIxLgz8tnhU+7cdiDPk/2
	to6ip2GIXEwSxSZPJIbAdbwP9aUSdCw==
X-Google-Smtp-Source: AGHT+IE8dlSq6w4uSu8TfcVMBsnyNvLPxKquFZ2sa9LhlUsXBcdL+i+13pUBqqGyAHNhB2vDZCvcqwzH6s1kn1pAkFU=
X-Received: by 2002:a05:6830:4491:b0:709:5601:abea with SMTP id
 46e09a7af769-70cac85fd75mr9405560a34.10.1723967765943; Sun, 18 Aug 2024
 00:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731125615.3368813-1-neal@gompa.dev> <CAEg-Je9qtud+9uJdratbLmD9EOWPrFh8xn5==-ip_AMZF82Vsw@mail.gmail.com>
In-Reply-To: <CAEg-Je9qtud+9uJdratbLmD9EOWPrFh8xn5==-ip_AMZF82Vsw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 18 Aug 2024 09:55:53 +0200
Message-ID: <CANiq72mji_iFPx+f7pXy8b47KB9XfYrZzLcSJA2kaa4oQpgxwQ@mail.gmail.com>
Subject: Re: [PATCH v2] init/Kconfig: Only block on RANDSTRUCT for RUST
To: Neal Gompa <neal@gompa.dev>
Cc: rust-for-linux@vger.kernel.org, asahi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, Asahi Lina <lina@asahilina.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2024 at 9:04=E2=80=AFAM Neal Gompa <neal@gompa.dev> wrote:
>
> Bump for notice... Can we get this looked at to incorporate for 6.11?

We have not picked up any patch yet. -rc4 will be out later today,
where we will start applying things on top.

Thanks!

Cheers,
Miguel

