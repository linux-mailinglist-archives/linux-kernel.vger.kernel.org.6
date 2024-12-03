Return-Path: <linux-kernel+bounces-429200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6CB9E18E6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18814B29D06
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD30A1E04BD;
	Tue,  3 Dec 2024 10:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L43PTbuA"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC0D1E009A
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220091; cv=none; b=O4iIQzqqhg4KrgUiZgL+0eOjAoib4S1WzKr7iqy49sSqDYIzvlJtagnF4xmnQNbCxIOYtpzYhIuxXJkrsIy6yn5ted5k90Y+BxAmMkZBwap8O8k0zaO5d4MzY5H73i6bMAeg6PMSjULLHB0qegTrgT7mCnDu0q7GFj/lDfZqaUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220091; c=relaxed/simple;
	bh=48nTI7AWcdsIERUS2YT0x5UxLWNTOAaNrysk490F92k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEs7KgQw6u+nvzHHT+FUVYP5q/Z02ZU93rohbzxXzgCJxwBzwQ05Dcwsiqt+2K2iJrLID5mHctsVXCQ5jc8WOFmQQPuM9J4mVQ5+5VcZaPsn214MoGnaqa8rKdVV9UWew9r25ILTfvh3DrlI1JHzIN3NHJ0EW2cUEHmu4mNWLJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L43PTbuA; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434a7ee3d60so36579315e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 02:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733220087; x=1733824887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rFPLO6/3fL7P20w4/2+PsYz4j0mE5KdUQ3Vu/oxGEfo=;
        b=L43PTbuAlG0vgY8cTWcwx1fXpJVfOoZkjOl1mcg7mAQSkE9ZhBI0OZSToNxkoSS14t
         +YxoMg9zLDZEF9K3GMtcf0qSPG7f0dz9l4ZORj75AY2yHMRLeDrcENIDvZHvnz3A/Bg0
         p3DTXXhqqcgzv9PybbrGQ8D95CEmKscAtVYFLo+euelZmmpLqvgKhqpZFMUV3ll02u8a
         hMvmFkxh796LSGYSR2/4OuCU0dJIKBg8dXkOuxxS/ZR1Rj2GAi+MjSHP4fl6mbq7GBwP
         LscBx0db2nt/zjgM3pQ67FfMeEP1lceRQflu+Fqo9AJufxAVoh18joFcvR3oyEYKSW/Y
         99gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733220087; x=1733824887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFPLO6/3fL7P20w4/2+PsYz4j0mE5KdUQ3Vu/oxGEfo=;
        b=P1MeWgdgJCKRmEEYdHihf/4pvmqkWuvLKawaEiW+XQqtLYvUk20FSOy3thO0T+rJYH
         eHuHERI257HQTGPI1p+agxIjd1LjRdnNM+7menl4UxkBkBKpWtpd0gCpG7t2koecU+jK
         F3wY6M/sQf6jd7Z04yneZYp80Y3GPikMQeHAW9xd3uaQNIypDFM1wCHBCFxYGxWLlPTK
         t4JVCdzaPVJ1TrxRQunA8U8i2R1m1GJEuJl8fwMBnrfqilxagORPk49FpXdjfxFD5uoG
         sCctA7TMz69rouREPEmcaIjKWTJG+Fs+g23dHixKqm3L26LDi6PbCp14bu8QG+fN1jpo
         I2Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVcqXBU15+uIoNlZHexQgHjeFkuA6YLLd2lBnnmXDAcRrUdHp9ptC7WE7NFzdfpa4x/tm6LwSwTp77U8fY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBixsy3oNghRqqKYvN71fOvo7FMVzjHWOVcbsx6hQT8nT4BCa5
	HNNT3fuOu2bcf9PiX8V1L4u+Y3bAjg/h4u2pbU5RNry5IAuVaQo1KcQx6R1PALY=
X-Gm-Gg: ASbGncsy8h5apIPr5/jjnsQ+fQJBpR5wRaXOhL/X6CXwooCZlaBsHPnsR5UDn5ChLho
	6Fw5ci0kozvAfEQfiMxlTi0Pw+Oht+WUE2W1UPG0UxdRy8sQW/wP0YIrXoNo0sSUGJuosuIABP5
	nKaOcFkernsZEOQL1wH9NkDWl3YoNABPbjC4Fp21xQwLKnst+V/p3JAEqkqUmp5TGafUWciucAF
	5KN7MeKUJDnNJcl5WCM94j6nyxC2/uWOsKrF14o/pHFeAP/QKG5
X-Google-Smtp-Source: AGHT+IFDA3IqnoDGlo1cC9AkDhgr/ERWkM0MFaLubSlQafL49XpjDGMGJlNOzpE9WiRQwNCilBcCcg==
X-Received: by 2002:a7b:cbd0:0:b0:434:a4d3:31f0 with SMTP id 5b1f17b1804b1-434d0d1be0amr14628955e9.3.1733220087230;
        Tue, 03 Dec 2024 02:01:27 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd367f9sm14765071f8f.31.2024.12.03.02.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 02:01:26 -0800 (PST)
Date: Tue, 3 Dec 2024 11:01:25 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, hannes@cmpxchg.org, 
	surenb@google.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/4] sched: Define sched_clock_irqtime as static key
Message-ID: <4mn32j3ppdhh4xtvjs4bxaskgoc27ldpap4j6676p7uhsuzuzk@gbq2xb35aki6>
References: <20241108132904.6932-1-laoar.shao@gmail.com>
 <20241108132904.6932-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eszeasz7a3ilbfts"
Content-Disposition: inline
In-Reply-To: <20241108132904.6932-2-laoar.shao@gmail.com>


--eszeasz7a3ilbfts
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2024 at 09:29:01PM GMT, Yafang Shao <laoar.shao@gmail.com> =
wrote:
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 081519ffab46..0c83ab35256e 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
=2E.. =20
> +#else
> +
> +static inline int irqtime_enabled(void)
> +{
> +	return 0;
> +}
> +

You can reuse the removed macro here:

BTW, have you measured whether this change has an effect above rounding
error?

But generally,
Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--eszeasz7a3ilbfts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ07W8wAKCRAt3Wney77B
Se/FAP9TaNFtDd1ArcvSVMN+9VnZo/SoHTK2GV9KFLSe9WLeNAD/WmR6YxdSYOKe
ZgYsiCnD/bJYlEAaLJnLuH5oK8FqXgI=
=hFu+
-----END PGP SIGNATURE-----

--eszeasz7a3ilbfts--

