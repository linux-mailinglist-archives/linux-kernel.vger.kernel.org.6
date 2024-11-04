Return-Path: <linux-kernel+bounces-394551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6800F9BB106
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA151F21499
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387D41AF0DD;
	Mon,  4 Nov 2024 10:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jeflwQR7"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C631B0F09
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 10:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730715921; cv=none; b=oWVa8DZjJLpJJhDuByk+KVHkqaNndS5pcnw6GMVAO8a6jG7L3zn3PUX/O1s64/IvLtW8Cvv35wjF5w4eQh2cUzi8+gePufUppRY/0sITAFoXRj91z2FlcVX6Kivkd7j6eEPrtpdlLjBFi+C2itokyajZ069Igzsgdr0UjfjR0Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730715921; c=relaxed/simple;
	bh=V/+/hlKh1rxbiBzy+p4y6Msa+GqpWouYUTGPR3WHGsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ikxT7QzU9AWiXaNW9YDWl+XnTAVxpXG9E9v+0IDEDC1QCsPQt6/i0G15jAwWYqwBOucdLpW/dUs1c5vDhhrepk8TLK/v60zwNGIM1k8b6NW0/u9VaR23lZuq3u/2TAqpRU3cQJgZ9b1uW0vh/NQsDD1ktpCc/4eaWNr8VxqiZDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jeflwQR7; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c9404c0d50so4862046a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 02:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730715917; x=1731320717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/+/hlKh1rxbiBzy+p4y6Msa+GqpWouYUTGPR3WHGsg=;
        b=jeflwQR70EPlixlEa9MwqFVXmbEzr7jPD4RzPW4JWqp9JLFBE5Q7fNYzYKUukX4n2Y
         Y+YMBlkV1ULvpCioOwUi6hJDtk4OtAYe/q/76MbNabJU/a9r4P9EpOEeKZ1cj0YvngEz
         uIhCcy/1wc/VXdl54oPhj9HnQXVZqVdDbZ4X/VX6qR27Ure/WIi2wCj2tOqRBM4PK5cY
         LtBheMyUHfwKE9dFSqCWyjsIV8DorH4zbDFuhpOHZWvwDGdqGIKVEvkiipdWoSIxITPP
         6eiJdi0Dnw7c7hmYHlJ39kxdeiFds/S+6zHq7vI6HucEi9mkB7In252FMFCZNC3QoUrP
         58hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730715917; x=1731320717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/+/hlKh1rxbiBzy+p4y6Msa+GqpWouYUTGPR3WHGsg=;
        b=mGJ09fkcQ69p7nTFqSGeJPR/lV98w/z3tMe0XsoWM6Rb309KYaR6zC6j3b958C2VkW
         9n7Hl0RlqzSTuD0M8GYscahHLcqNCwe0B01fj2yB8pPMqg6pbyh4iMvV1H6TOdIb6h9/
         yyeH8xoso3bv+CxBRXKoAEV6zFIyKF5SQ6A+pJLOiih+UFW2sdx81pkwllyrBfNZ+Qxe
         NTMuIMbWd72iVGV82lgr3OesYY3FmUN4NNPcgpqP9R793dYPzgNJaqa3pNwrNAkZ70m8
         cIY5e3SCAr8NuFTzQwaplsY1UBfd/9OvRpqATiF/iMpa08034zOibiBNVBadv8Dva6sC
         7luQ==
X-Forwarded-Encrypted: i=1; AJvYcCUncUgQdZmfawssU61WYy4EozO+bk/f4Gm9khBrWP+1CpJe5p/2gR2w79z3ZJ15LQ7UZVFR7O/RmchpT3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrzwryDQXmbQdmGuMWNg2GnGhzq2xa8ONYfoqOALKdOIegswYy
	Zi9d7caXU/9Udxo6Xf+FYqSuuOW+4KB65mBl7JpXX3sIoerj5QkJmRy7mmgj6vFLIm8MnnJJCyD
	9dL4WBJvRRn8LxNCNekttIIn+gg2JHEzG3GRp
X-Google-Smtp-Source: AGHT+IEk/VV8aixaYr6ZbWjdMvIQt+JsCmv/TNNMBKSlXTspef08ZiIotLJVmSIItnYQWjkfpFoAoy6ki4++u+3nu2c=
X-Received: by 2002:a05:6402:4316:b0:5ce:b82f:c4eb with SMTP id
 4fb4d7f45d1cf-5ceb82fcb42mr11804877a12.8.1730715917148; Mon, 04 Nov 2024
 02:25:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102200820.1423-1-03zouyi09.25@gmail.com>
In-Reply-To: <20241102200820.1423-1-03zouyi09.25@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 Nov 2024 11:25:05 +0100
Message-ID: <CANn89iKzcsKRngJTTxdA96MbVSx4Y9f17ju9+Otf5axas_esjQ@mail.gmail.com>
Subject: Re: [PATCH] ipv6: ip6_fib: fix null-pointer dereference in ipv6_route_native_seq_show()
To: Yi Zou <03zouyi09.25@gmail.com>
Cc: davem@davemloft.net, 21210240012@m.fudan.edu.cn, 
	21302010073@m.fudan.edu.cn, dsahern@kernel.org, pabeni@redhat.com, 
	Markus.Elfring@web.de, kuba@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 2, 2024 at 9:08=E2=80=AFPM Yi Zou <03zouyi09.25@gmail.com> wrot=
e:
>
> Check if fib6_nh is non-NULL before accessing fib6_nh->fib_nh_gw_family
> in ipv6_route_native_seq_show() to prevent a null-pointer dereference.
> Assign dev as dev =3D fib6_nh ? fib6_nh->fib_nh_dev : NULL to ensure safe
> handling when nexthop_fib6_nh(rt->nh) returns NULL.
>
> Fixes: 0379e8e6a9ef ("ipv6: ip6_fib: avoid NPD in ipv6_route_native_seq_s=
how()")

I could not find this commit in upstream trees.

Please make sure to sort out the details before sending a patch.

