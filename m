Return-Path: <linux-kernel+bounces-533015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83012A454D9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78A4E16FC10
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 05:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C20214203;
	Wed, 26 Feb 2025 05:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2cK3MWu"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2DE137E;
	Wed, 26 Feb 2025 05:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740547304; cv=none; b=YfBu+ljoxBYshXtHVGb1mz2Vhk3XPkVIQLMogcldxNjOkcOeZNj+2xwjgBdnpL7HYsOudmiFKJWIxZzcU2FLi4vSKCg7B9QBoWM3hi2m8LZRXlJEgihLdDBEjXfFMAKN4lxvVGGz1pqxqkaoGlYY0gNlhA3nnuL4pBqyPguSrqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740547304; c=relaxed/simple;
	bh=5u42TaZfiT7kHxPhHJHkG8B3VXwDOaJxgtIfoAyv++Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OjQMaX5wPhMicPd87NqqGz10odrLrguGv+IDDJhWiHkb4Ggk6jfM3Hpq+qSTJaE4Cjj9R7DrNdoZAEJSJg4SwcO1DsplN+otZgQfIVVnmAhBId/iqvPcpDoj6v64x04PtaW0NIuVSj/2LMST9ju05Ysz0D0w1o1oyU3Ms7L9fqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2cK3MWu; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e4ad1d67bdso39927a12.2;
        Tue, 25 Feb 2025 21:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740547301; x=1741152101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ilb2rxBJ3i7v6d7nLIk5GihtEfmnK3ceocDgl/ZfviY=;
        b=D2cK3MWuAfq4GbSi/FlaDQL7ZOEkbWJjTJG+gJ8HLgpOr8yu9nwU0z7dnLypk8BQdi
         RQslU7wCeNMU9+giWC+jgF5SPSWNoHl1QjKaLYv1Af6D7tHg7Wtiry9X8GzulgvMSndK
         FySx7BT7MeDVXMLd85pBVV3aGsyqyDxvASpEuUKW34YIZh7BXuOkeiMW0uzgikBqdMRU
         lK6patDYKu0gVGAsFrO6ZBQgK3qSzZWjiFEwoI7JUv8lGtyyJeLdt74n7WH5Y8qEC+gX
         kB4065T+qo04J8sE2gVYUt10//ofl20ba3UktA3hHlFYEZoZZOCIx4d4QTwOjmOSJEI3
         /DsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740547301; x=1741152101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ilb2rxBJ3i7v6d7nLIk5GihtEfmnK3ceocDgl/ZfviY=;
        b=eXZyeYIRjj7Q+HYOnQTnvi11avoyAPkTHGnfUZyQedM2CtfwsdTGmoOu9vY4YjhXrd
         mO89uYTEkpMR9aatEDmSrYdS+wROUY91fG3B4x/sVeHnN4PJoaFLUJmNNX43BsU0tPqV
         sAifKRDqzmQf690Ye2Nkgg4uFqJSZRfiaiHFSayGuffBWYorHxJW7Ivl1Hv+B5SaHHVk
         owAUAiFoNzD+7HMQeDNXNDeCbz5v9aF1UvJLm5NdDbss8/t+9OPFP15KW5EhUFiL3dDc
         S5BDdbS+iO2sWwMOq9wVlUAiMY4mvv6c3+5+5q5vcSSSiu/l/zNdQIyV1i/DFF8PGar5
         TJ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVk1ufrNceSzi3dV9LRgP5czASA5tmV0YGHsZSikN/3KOfiKEDvLL/+E2rk1I8UAxh3Ulul0O75qQA=@vger.kernel.org, AJvYcCWLSYSHQWqs4ewo5uL3jflVnSD1tiI25FzcWAB/HsACZFKdj8go5ZPvnqioBIO399AJRtxC4WcLm3v9r1/M@vger.kernel.org
X-Gm-Message-State: AOJu0YyGqagbAHhnizOOzxOvJ22Vc3XyS/1e2n0WOER7kcs5hhoEvaTO
	gW7tGA7eVyiVf5lL6dixi0mJsgQtYvkirn8AIRLYEQkXDrWiLGdE3ZDueHviXZthFkMr5rR+eD8
	3giTiubJaTymnFcDyr8sJkW8tE4A=
X-Gm-Gg: ASbGncvnM5ftglSzyPVurfpLZdRB2pLlq0dHowVz+n9rOdYdf5+rkH2VZFuEIxY/HqX
	RpJBhkTT+ficQ0ieU7V2KSwH3SZ7/dznFquLaftBftw97X4dT3wN5GhsrSpEEXRc6mjg5Ojm4fX
	SMhN7X8Vn69g==
X-Google-Smtp-Source: AGHT+IE+W97F9VNY3wyKM14FFFnj1CjB1eVhl7K+LtH0POkui0vVywM4ZUS9T6BfUlUgp2gR6UdEaPszqmSqMJY7hUs=
X-Received: by 2002:a05:6402:1ed2:b0:5e4:96b5:1b20 with SMTP id
 4fb4d7f45d1cf-5e4a0e1349bmr1851415a12.22.1740547300660; Tue, 25 Feb 2025
 21:21:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226014942.2586561-1-yaxin_wang_uestc@163.com>
In-Reply-To: <20250226014942.2586561-1-yaxin_wang_uestc@163.com>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Wed, 26 Feb 2025 13:21:14 +0800
X-Gm-Features: AQ5f1Jqpi5uAVgci3pGRFDhCrjRk73KISMHA5f9W2dbyPZfHqmZWbXcTT7f0prQ
Message-ID: <CAD-N9QV1vukcXNNtmasSjkWAAVHFi6D42RvUF572stDgmO7FLg@mail.gmail.com>
Subject: Re: [PATCH linux next] Docs/zh_CN: Translate msg_zerocopy.rst to
 Simplified Chinese
To: yaxin_wang <yaxin_wang_uestc@163.com>
Cc: corbet@lwn.net, alexs@kernel.org, si.yanteng@linux.dev, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, xu.xin16@zte.com.cn, 
	yang.yang29@zte.com.cn, wang.yaxin@zte.com.cn, fan.yu9@zte.com.cn, 
	he.peilin@zte.com.cn, tu.qiang35@zte.com.cn, qiu.yutan@zte.com.cn, 
	zhang.yunkai@zte.com.cn, ye.xingchen@zte.com.cn, jiang.kun2@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 9:50=E2=80=AFAM yaxin_wang <yaxin_wang_uestc@163.co=
m> wrote:
>
> ><jiang.kun2@zte.com.cn> writes:
> >
> >> From: Wang Yaxin <wang.yaxin@zte.com.cn>
> >>
> >> translate the "msg_zerocopy.rst" into Simplified Chinese
> >>
> >> Update to commit bac2cac12c26("docs: net: description of
> >> MSG_ZEROCOPY for AF_VSOCK")
> >>
> >> Signed-off-by: Wang Yaxin <wang.yaxin@zte.com.cn>
> >> Signed-off-by: Jiang Kun <jiang.kun2@zte.com.cn>
> >> Reviewed-by: xu xin <xu.xin16@zte.com.cn>
> >> Reviewed-by: He Peilin <he.peilin@zte.com.cn>
> >
> >So how did these reviews happen?  I have certainly not seen them on the
> >public lists...
> >
> >Thanks,
> >
> >jon
>
> xu xin and he peilin are my colleagues. They helped me with the internal
> review of the document and did not participate in the public lists review=
.

One suggestion is that you can cc your patches to a public mailing
list (e.g., https://groups.google.com/g/hust-os-kernel-patches, our
club mailing list) during the internal review.

So reviewers and maintainers could search the thread from the Internet.

Dongliang Mu

>
> Thanks,
>
> Yaxin
>
>

