Return-Path: <linux-kernel+bounces-428088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7749E0B1D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3335CB61B76
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3161D9694;
	Mon,  2 Dec 2024 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIpDDqZl"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974B018784A
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733160813; cv=none; b=s8+AMkIzwnDLom1fdy5zpGGkze654eAfPFr9X8sqbY2088bGl/Z4/zcpOOxh+qpBokhefi0yf3RtGmRJC2sfWW5XAgCzQejmo3qmAtevRfA13+lmiMk03ui9rIEfRrW45bqY2iklKCvowwBL3HBTfdrGZl2jRmVSaAJ0NnBYsyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733160813; c=relaxed/simple;
	bh=XI6YEhRDbY2dVg07ZloVGZup6d6j7MxEGk1pt+bXbRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jt4odWVfXK8m67D9VIt2tNii/Q7YdmGfs1CNnLp3l1/2DSMLs5ccODwS22I/8hJVHDHrN+AzYSoy3do9BjcwK6fUUhwM+qp/J1YrWXgz/0zs7fPfsT8Nieq2keUsx0pkhNOF/pIboQhOE3HJkICUAH5cT5G7GbvznDjpHjwcxpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIpDDqZl; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ee94a2d8d0so355659a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 09:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733160812; x=1733765612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XI6YEhRDbY2dVg07ZloVGZup6d6j7MxEGk1pt+bXbRw=;
        b=LIpDDqZl0p9E2d7gJBK3at+TfbGTm1vWJnp04xRZe7i0Q4o3b0n2SE45aRPz4Wrrqu
         /QGzb7VV/4sX7wzfNwOwNtcx+NyHZ5R/jM3Nu7XjROigBADAPiXidScvr6G2P3CFvn3F
         nwOpCHKimBz/tOe/mqCBA73gkbD1D6xCqmr406QWuxITsYbgBCjjAcPszPyQcpX/5sqL
         M7GTONvs2YnVmdqsWRfnNpwzUTIzBzH1l0tn1T09lgix9zVrQeAXOSO6bZ2/gsVVf08Z
         AbqZ1o4J/hXiGHjZCo8IKpO9hqaP4F8BSfHiRZhl5RLqhFdwTZMt4gNOV+XTneMBHyN8
         sB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733160812; x=1733765612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XI6YEhRDbY2dVg07ZloVGZup6d6j7MxEGk1pt+bXbRw=;
        b=wZCt1tEg3LXAccdvDD3f5WBCTY588doziwP7ufEUf6KYxXUeoIF0Xagf5XVxRD85Qg
         QRPEx5Hr8Qmz3X7I+uqIrehUVtOZIqXtqM9zfBsj5RZZEdQCBQLSVSnQL28F3TlBzNcw
         g9r+IZkdxFka+klGGxYdZSECkgpGICHzJkxc3J6AopYaZHAQDIIWDfQvhmoNLBbbUq0M
         87YB9BtlUYAz+txSKz9tb7ZeIhDaNUuG8SbwW5yM3gA48FUoHT7WGgKCs5B6jh8JnKYF
         bUwTGrJiDJ7xqBLBeLie20YrxK8ueRSwGiXw8LM0BkvenHVy0eofG9dLmN0jb6JtQoKT
         kkbw==
X-Forwarded-Encrypted: i=1; AJvYcCWFkeliYZGWYrM65dgnbP01uCihpivtm0NI0j2HAPS8lNaxhyXBihulZq68NP/xPu1MrCjAKDmECLuscww=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEPbkoqqxWTS5YWIXQWdsU+msEXCbc1O0EEqhopu6bNUkIoE6w
	b6oqc9vHegrSAaSd1InMoroijU/XqgeJqgOwonQRVB7Olfpzq5VLL1AcgDOXTHIYBfDRtIur0JV
	hAhDGelsbAToFoZdVRBSSo0nwpMU=
X-Gm-Gg: ASbGnct0EPfORyHBsRhl0vvmPT1BmBBIVPJMKgXzXj6Cj9QUo+nxaa2MgBYyJ4oILqE
	T78nNaE8ee5GD2yr26qBvAWzipNKov6M=
X-Google-Smtp-Source: AGHT+IEgrxQyXV09BTM0jTl83mAGz5Gp0ZnaVDUwVL0gnExFSb/vSjPqpg9yshOhiox/DlenNMSGIEqc0p6O6KQsKGM=
X-Received: by 2002:a17:90b:3850:b0:2ee:b665:12b3 with SMTP id
 98e67ed59e1d1-2eeb66516bemr3173515a91.5.1733160811811; Mon, 02 Dec 2024
 09:33:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130145727.900020-2-u.kleine-koenig@baylibre.com>
 <CANiq72kqMmD1P_2wjL3xL2ot9+3MzcrrZH1Jsw6Tz+m9A3z6uw@mail.gmail.com> <abek2strn75feiakoteul2hcw5vkgci3sxcbckexd5legbdjn3@u6hegsqm5cwb>
In-Reply-To: <abek2strn75feiakoteul2hcw5vkgci3sxcbckexd5legbdjn3@u6hegsqm5cwb>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 2 Dec 2024 18:33:19 +0100
Message-ID: <CANiq72nZjNcvdWx8C_6mj4RkZLDgdHZU87YmUP_4gNFPYvOXqg@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: Switch back to struct platform_driver::remove()
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Andy Shevchenko <andy@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Paul Burton <paulburton@kernel.org>, 
	Erick Archer <erick.archer@outlook.com>, 
	Chris Packham <chris.packham@alliedtelesis.co.nz>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 4:33=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> It is completed now, faster and in a different way than I expected:
> https://git.kernel.org/linus/e70140ba0d2b1a30467d4af6bcfe761327b9ec95
>
> So this patch doesn't need to be applied any more.

Great, thanks!

Cheers,
Miguel

