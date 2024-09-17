Return-Path: <linux-kernel+bounces-331994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B20497B3C8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 19:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0866CB23A04
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BF3188A2D;
	Tue, 17 Sep 2024 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGIZvNlH"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D79174EFA
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726595054; cv=none; b=sTWFS6kKKJVjBGsvWtfVJZQ1k86HjB/ui8cmr2RBrv7hxPkqEWX8lwRtvz+vwx2BY7B0dTGao0+shnUg1/JiAhRK3zsixcLLwfpRs4WqFDMt9LuBh1hNS1Z/39A5ua8RMSMud8jAo/l+Umk0QYpbXg87LgQ0G7UjbMvKhUw2IKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726595054; c=relaxed/simple;
	bh=FtNqKJ1epZCwz6D45zYk0dvkOL1YwiOIktLYgpe3YGY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PAqSzncBdJoOpS5JiwR5srC7KLvpc2NTIEzCtsmcZfP63BkWKLBRbx10aPepx0v2HHXuYSMKaLv77DcRljaSHsou2SbcD1Q5dQdKHU79r5t47fT/gy6FG3RwMg2tXGHzpN4lxzSB5ZAaOnhQRYyAazTHMh4KPvzJZQJiVTHH+Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGIZvNlH; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cbc22e1c4so38751575e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 10:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726595051; x=1727199851; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3hkAjhgPl/2TiN68DozWvPeGYa77vsjX/Twty+gyE3c=;
        b=SGIZvNlHnkAInbdXmlvDCRaP4xG3iytUHawz6Z6lN5dSgEzXHV+ueXvursI9DtQNwh
         SskM+P9wo3TV1n62g7Fug6RMOFNk5qTs9q/LoI7gLlXsEe54OkjJwl7pXAOI5TFZxn7n
         hJL6Sq1o4UJRZa3lEIn7ealOr5SEcUWMgD/5vy9zAleRP329QU1d13cZrASo/8h6ThuN
         2nYHD4sQESJguJ/I/u/5XX/AhI7Ynj+8aPrlivpo4A7AbZMyzsyLxhxV+Upk1IWIMwv2
         imVbLt/vpLDzWfiZf91IHzvkiDtJsNCTu3POPVl0BCcOD1Zke44+9t0Q2GEgAJvp5hwd
         Mngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726595051; x=1727199851;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3hkAjhgPl/2TiN68DozWvPeGYa77vsjX/Twty+gyE3c=;
        b=q66qnasdoApbTAEMSFOYgWuC2n3Q1Ky0XPyheAUjaPFAO2PV/1gzOwWjPc2CFi51MS
         brK6JstySmWFBUfj5mw6jVVMNW8gQCMMAoAejWEvF6WytmlaJY6udkDNvQYhZ+XEvS/U
         S24+Emz0iUqEPk61cqRm9SjhWR69bzMeJNrQZEp2hxdi2CUD69hFpKVOFDW/mRQvPe6A
         jqywQo0fiYDNnxcg0fUAaMCjA6PNo8KIj/6K3/dm0RkqSyq7OsCQ+yS06Qz6NBWn4vI2
         Wr7OzuqHYfcEu5VGhZ04q0c8sO28BENRvmZFl4mxwlOJWNEehb/O7fvoaS3TFB8OxvdR
         qCyA==
X-Gm-Message-State: AOJu0YwLXD5+7Ghu+gR5FIfICCwJf1AVPi7wNuz1oziCo6DaUDocsQ/L
	26uv/542QLnESvijD1qIBi76sO6EmxSnLZCrfb2/cdXKF4g7tDMu
X-Google-Smtp-Source: AGHT+IE05nXrpogTVppn+TE+u3C2kzmxZtRMiSNDpMkPM/H2DThZtaxhtrJNkzwEUr8JDQ3aH93WGw==
X-Received: by 2002:a05:600c:63d3:b0:426:6a53:e54f with SMTP id 5b1f17b1804b1-42d964e10b0mr95965425e9.33.1726595050816;
        Tue, 17 Sep 2024 10:44:10 -0700 (PDT)
Received: from giga-mm-1.home ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e6c71c72fsm13954675e9.1.2024.09.17.10.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 10:44:10 -0700 (PDT)
Message-ID: <6309bcee5dfa3a1734b5565733cb819bce5da626.camel@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update EP93XX ARM ARCHITECTURE maintainer
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Nikita Shubin <nikita.shubin@maquefel.me>, soc@kernel.org, Arnd Bergmann
	 <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Date: Tue, 17 Sep 2024 19:44:14 +0200
In-Reply-To: <20240917163401.6501-1-nikita.shubin@maquefel.me>
References: <20240917163401.6501-1-nikita.shubin@maquefel.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-09-17 at 19:34 +0300, Nikita Shubin wrote:
> Add myself as maintainer of EP93XX ARCHITECTURE.
>=20
> CC: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> CC: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
> =C2=A0MAINTAINERS | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2cdd7cacec86..f9672f279a66 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2272,6 +2272,7 @@ N:	clps711x
> =C2=A0ARM/CIRRUS LOGIC EP93XX ARM ARCHITECTURE
> =C2=A0M:	Hartley Sweeten <hsweeten@visionengravers.com>
> =C2=A0M:	Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +M:	Nikita Shubin <nikita.shubin@maquefel.me>
> =C2=A0L:	linux-arm-kernel@lists.infradead.org=C2=A0(moderated for non-sub=
scribers)
> =C2=A0S:	Maintained
> =C2=A0F:	Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml

--=20
Alexander Sverdlin.


