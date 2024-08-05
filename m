Return-Path: <linux-kernel+bounces-275331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23723948383
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 22:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D365D284403
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D76514A09C;
	Mon,  5 Aug 2024 20:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Rc27k3lf"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE9116B399
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 20:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722889961; cv=none; b=BK70MGNEVOKSw8G9o2+G2UI+6T9p4YxdgqeaHnbNu6EJ0Cyyv+SGDCkijF7X4IX8JQBB1bD2cr/anTlxIJZ1fnWXeTJnVvwNNAkWckEKZSJUgg/xFmHpTq56MmdNaDU8W1IURze3/9GBuYETGmSke2Q2E1vazA4b5+spY5fGMC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722889961; c=relaxed/simple;
	bh=QUw3QeI7OYZ1AwcqILIHnl5Wyq/fgKZKE4y6WwkXezA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pMx7PoPX9l4bGrQ2XiuaamtzbN7QLcq6HyZBZYKm6s0ryZYM80XzZ0r31DQjzbhUIvZqO3VqsomHNNQ6gOE6UnNpMsfofRsx6pjKP7kyNW0fgfdUD0S2q1XO2/OtliMyv3phDuojGu/VK+uts0EbUa+VUZvwhqCjiOUs9fp0cBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Rc27k3lf; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-428243f928fso73272625e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 13:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1722889959; x=1723494759; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vn6Rnyxr4niEdIXil13oe5CZlyeVE53UOlfup/AAfYs=;
        b=Rc27k3lfr9eyi8SjbJcNRO/iwiEzwWl6zn+iCj+T+Hb+FzLSEHmN9WKSLekogpBZqA
         eC8/Wmp3mZI9WbXv69yFrnpm96YRm6pLvpQcCmozdXrPqAX9lXvRCGbVpXNy7NJG0N6E
         AqSSg/csyjDw0j/Rmn83oJe6Jdj5BMFeu2ESSebyh1uViAPCj/3CBn8DTaPYOE8UBTD7
         E9MMIGyFcBoWf/YCAIwSx7GQNbAZCseKFZC6ZDdCXaIoZnumAeZh5d4CeTd7OZl0izjf
         UfEUnuVs+iD7AqsDPE525KNQP6q8OZ8VVCuD895vYnWNimvm4G5DQQy0YB16D/Q9WW9i
         BcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722889959; x=1723494759;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vn6Rnyxr4niEdIXil13oe5CZlyeVE53UOlfup/AAfYs=;
        b=a4o93nskxwi1kTK3OgjnHbEbNwJR1TPFr3JgeeJTuNUwIDHqDLQPfiieSjoaHfBWl+
         Jx41R57JCq5ZEc1H3bI737RHU6gJDbQJYNLudqESqJO9CD//2PR87Bh/e1VX62xPoDoT
         QGoREjGaYJZ6HxbyQm1W/2NWXgsi4jUfkoIEre9ATpfV9L6VTDOz8qQuaVBoHbd7463+
         SoL6nq4PDEV7s5xqmV/Ism95G/15Hm4Jr+ZdJsmLc+VnpjvkVQ55yVT4V+WlS1NE1E+f
         u3e9yxZw74ep59Lm1c020cFkJ6qk9Cr1QCgewa2nxc2U13Pt11pXNrMT+Et7b8SqlIcs
         3NgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrrikmB8oZoABwxnVfekhAmy9uF6YhF0eJN/8/rrrld0WW8ATefXdFPk+Ag7YlzGGHDtVO5m1oY2KkM4ZEIY9DKTnk1/ZbokPSKLJz
X-Gm-Message-State: AOJu0Yx7krOVwJr+Abd2gEXKBxKBcO35HaroX+6ErptYxsbzlCbK4L4u
	f47YAeFGSxzuj58V54fwaYHfhZQdn/E5mRKCTjIuyJKEG9jOs568vOAAgpEh7t4=
X-Google-Smtp-Source: AGHT+IFEVQJwp3vZXhCpDGiKBNDcqVcaDTiD72/DHGQk9xC8MVyvZWQq5QLSREYXMf2KASU8Tj4CmQ==
X-Received: by 2002:a05:600c:4588:b0:428:15b0:c8dd with SMTP id 5b1f17b1804b1-428e6b2f14emr118747665e9.20.1722889958397;
        Mon, 05 Aug 2024 13:32:38 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:10b5:fc01:ad5e:c962:d96f:7752])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b89aa7bsm216173985e9.5.2024.08.05.13.32.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2024 13:32:38 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] crypto: chacha20poly1305 - Annotate struct chachapoly_ctx
 with __counted_by()
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <20240805175932.GB1564@sol.localdomain>
Date: Mon, 5 Aug 2024 22:32:26 +0200
Cc: herbert@gondor.apana.org.au,
 davem@davemloft.net,
 kees@kernel.org,
 gustavoars@kernel.org,
 linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DA00621C-305F-4126-8D04-9F6D86E959D1@toblux.com>
References: <20240805175237.63098-2-thorsten.blum@toblux.com>
 <20240805175932.GB1564@sol.localdomain>
To: Eric Biggers <ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)

On 5. Aug 2024, at 19:59, Eric Biggers <ebiggers@kernel.org> wrote:
> On Mon, Aug 05, 2024 at 07:52:38PM +0200, Thorsten Blum wrote:
>> struct poly_req {
>> @@ -611,8 +611,8 @@ static int chachapoly_create(struct =
crypto_template *tmpl, struct rtattr **tb,
>>       poly->base.cra_priority) / 2;
>> inst->alg.base.cra_blocksize =3D 1;
>> inst->alg.base.cra_alignmask =3D chacha->base.cra_alignmask;
>> - inst->alg.base.cra_ctxsize =3D sizeof(struct chachapoly_ctx) +
>> -     ctx->saltlen;
>> + inst->alg.base.cra_ctxsize =3D struct_size_t(struct chachapoly_ctx, =
salt,
>> +   ctx->saltlen);
>=20
> What was wrong with the more straightforward code it had before?

There's nothing wrong with it, but I find using the helper macro
struct_size_t() more straightforward. It's just a refactoring; happy to
take it out if there's a preference for the open coded version.

Thanks,
Thorsten=

