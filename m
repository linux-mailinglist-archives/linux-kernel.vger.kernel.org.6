Return-Path: <linux-kernel+bounces-323273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F25973A7C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F00FB23B0F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB13199FC6;
	Tue, 10 Sep 2024 14:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m9cba+8P"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F337F194C8B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979585; cv=none; b=s4k00cLSmmQC0+6vmRDuBuVTu1VmyWCSyaPW2PBzkWT5uvsAp9p5yTBMzaW7KwZamZhlIbISL06kHKm1wG5abx4RRPZGQPpoE4GfY2xbf9M7ZhmBdxZMamntvDYV2Je44xF6IHnAgPwBr2HiXn8HsuY9UX0DeKaXM9ovLEeMWAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979585; c=relaxed/simple;
	bh=eZA0INVIaxysifRtQ/js+f8NGdZZ6GaHJWhtEVUb9e0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCueRMVuCbOONeOYD4D8OMGdZv8awt5G/Gb3+sHjpDaMcOhJ2H08ubS3q1EMUDRYDLL46JyXw7csMDy1d9IazFyycxheLMp9KDaVUusQvHwHqpzb2RdtZVXmWwe25/XMFDZYXO8Ptid2PiPQIvc3eu/4AwZ+Ijbwekb5Z9pjWwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m9cba+8P; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-371941bbfb0so3464020f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725979582; x=1726584382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ie2tWWuG2E+Q7aPM8G4eDhGSZkXYMPi5r/t8cU74EXs=;
        b=m9cba+8PBk0B5PSgFI9bBe8fTaDXYqzTC4B9vcNx7zEI8AchBIVlgYFFdsM4cwltqj
         2/H652FUjwWEPHYnq9t8CESZF16scWTevaA64v5ZHnkxPmOUkc8kZWL9HYShUqspVyvP
         uRIK1JBZzwAYL2tK8nvZF4mXoXXo4jo346uVwA1UV8pWYafOtTNg/U5g9HiMVHiWyPVW
         2lWBRH1z07G8QGC+XLwj+HfqCKGoTSd+kU8RC6FM6SqhwA/87lHWOT7LlIESludoE31+
         S8mNWtMKXjHWWD0idlFZOZzsyLVBbFxCpW18/bpDJz5BsDneCiBetTcO+nVWwmyqTfuG
         V9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725979582; x=1726584382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ie2tWWuG2E+Q7aPM8G4eDhGSZkXYMPi5r/t8cU74EXs=;
        b=T7kXiL/qKy+L73WZ0iEq5wtcx/eTAixipfKrJy+cGooI6YNu+fQZz5bes/mJUm5XPr
         6N5xDYJYuSgTDYPCZh1jR0PNLEzLxudDe/Bqfr7ErIRad11pLVx9zwAh6TQuTwo/4x09
         86X/pLl43N1v9xROdMb00npeHb84QGXTTNJHfBD+pfjD2lkuIKVznmGNQ6IYrI/VmxQl
         9CqUm9FMbzS/kiL3OWmG/YxGXtPVds65W9ddfAgZJVT9qp7C0qrsh85Tb14pC4VJd20R
         WYHDHWSi4NMWEqnZtCj0+ne3Al7C1oj1Bq93knCoJN+6O1gjs2gyQjdiWKakloosz4zL
         Q16A==
X-Forwarded-Encrypted: i=1; AJvYcCXEbDNU8UVHHYE9tj9mJ1xBu26zeo2CQAIH2NG6/D4Y+bSgRXrgxzI52TRG5NYrlZN79ZBxqQzS+CbNG1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj7Gd0WcoqOt832fnTYALYmGNYdsPmSgnvs8yLyok9mm08ZN77
	xFY3TByNt4Wxm2jnPh60SO3/GQyP6FKPbOxt5TkMdWKbSbfNltw7SGWUyXm0vCJ05sAwWOBSxIp
	/fehIXTpP0F32MP7mcKTouf5P616o940vg6uZ
X-Google-Smtp-Source: AGHT+IFDo0mvgDytpH5FIgETsS5NS0VkC0LwE1ceohat1+4L8zu+UXVBY7Bz+bza4xIrhxdf5+XOjHx5ZC12LMqc5VE=
X-Received: by 2002:adf:f64f:0:b0:374:c977:363 with SMTP id
 ffacd0b85a97d-3789268f0a6mr6431494f8f.24.1725979581832; Tue, 10 Sep 2024
 07:46:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910143144.1439910-1-sean.anderson@linux.dev>
In-Reply-To: <20240910143144.1439910-1-sean.anderson@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Sep 2024 16:46:09 +0200
Message-ID: <CANn89iJoA5XNOGr6-esswau8VymFHrrpT62+CT=nf4KLuDU-Ag@mail.gmail.com>
Subject: Re: [PATCH net v2] net: dpaa: Pad packets to ETH_ZLEN
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Madalin Bucur <madalin.bucur@nxp.com>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 4:32=E2=80=AFPM Sean Anderson <sean.anderson@linux.=
dev> wrote:
>
> When sending packets under 60 bytes, up to three bytes of the buffer
> following the data may be leaked. Avoid this by extending all packets to
> ETH_ZLEN, ensuring nothing is leaked in the padding. This bug can be
> reproduced by running
>
>         $ ping -s 11 destination
>
> Fixes: 9ad1a3749333 ("dpaa_eth: add support for DPAA Ethernet")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

