Return-Path: <linux-kernel+bounces-337029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC43C984464
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9244D28413D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146B31A4F11;
	Tue, 24 Sep 2024 11:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeoVvcXp"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3541A270;
	Tue, 24 Sep 2024 11:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727176733; cv=none; b=e9vUdrdSYdKAl5t0FHftE5PhA8PdWY0wH/EovyKyRPU5sjC7uCnesW5I5l983ug3hkYCl+S5wjGWtVEIZ5xr7FUp9P3uHhz0H3MoazUpDgGMGIujTQL+iB0QulCl+Kmd6EcMe3DKpGQ/9g0uveD7IOo0OgpSWFUazDnzjrSWzng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727176733; c=relaxed/simple;
	bh=YBAqfCr1rPGxWzSzMR4p/L3+lR7/ASXO7LooTM0/hqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m50LHyyS0BAAXoh9wAQB4kCrL9wPOKlkzn4HqBQEUSGQ8h8bmiQASwRWui2esl++IArgEgGuq0p1KSA1NQ/Q9eLJcWFdS1vH6YL6v7Gi2LwsmNP+5/8BtQws4SutA2yAFs9C0hoe2qMxY3QPd0HpnZFVyW9O8eAHNk1VvQGaVQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeoVvcXp; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e201f146cc8so4915915276.3;
        Tue, 24 Sep 2024 04:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727176731; x=1727781531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBAqfCr1rPGxWzSzMR4p/L3+lR7/ASXO7LooTM0/hqA=;
        b=WeoVvcXpupKfScfrTBA7vHp/YllamVH78ISwaKFJAaIFxbMvCXQFE+vlhTS+HHVLwh
         vD86xPq6wb6BPW0xXrATm2TY5TwkXqq3e8OaCHTN9vNyl9+dg+BMX3v+OQLTs+FcUemX
         XeOBs0vEGmUnF/KZQyEODH172b5w5Rq2C4rUhA85qsmQPM/ucC+aIctMNyL47YlNmDhq
         OmzagC/UB8DhucFXxNEca0L+s+LmH2esQOXNWPXBVxYhCsQj9Z7sgHXmlXpcIOQBXSip
         6rzy4BQZQijVEDf2OwrM20goQIec+6f7IoOFkxuZCxWp4BTyogCWa8hHkWNnSLGG6ThD
         VZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727176731; x=1727781531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBAqfCr1rPGxWzSzMR4p/L3+lR7/ASXO7LooTM0/hqA=;
        b=uxWb6tqAJK6ZQlxyaavvyxCrp+dblQrdAc4sraUjnZr+sGj9UrMhTZpm7ey/DIbGkB
         tHFlLh0m+S/AK7g+r46OI9v2SIXClpkBTzFvlmNDGv92jfrphtzhmrlt1rw6aUpbuYxc
         IXqg4hnn5IbNO6cxtYFTqh/WvntUuyLc3CuoJy5/NEROaWNN/EtZqOiRjLDQV1fiIfMz
         bXDVbF+HJ9sfABMIE/ODyan6gNhDG7aCr4vW4y2eWQFX5JIZtfFg9jSQRpY11okAasCn
         RcviPlIKqeKWffZ94aqgRNvokAcOhn/CWRPtdDMiYOTHOxQcFy+2yla2rH2prDq96C3q
         CSig==
X-Forwarded-Encrypted: i=1; AJvYcCU/r5y9E42p9uKU3He6Ewh6w0mv0BBi7fuPgzpYXcPsejjqxIwjAJ7SCyqmlGQrK2UW4ErRXDdcJbB3@vger.kernel.org, AJvYcCXVnc+piefxwFTNPLR94OaUqhPZ+qSZWHIqZODrUBWZ0UDg0p2T0NgpzIYw7F+WiiSLfV6LZP7e3YyGTLVS@vger.kernel.org
X-Gm-Message-State: AOJu0YydvxI74dw6ur+RwXwLwwh5ZFv+p6AJfZ0NmAENLc375AjfFO3E
	OKWzvGUN7obNvfmkoq93uAzLh48ePsuFaXBYy74sTR/bbFb3r87ZespTgTsJjZ2UESzUZd4e/EX
	lpR6QZt3MHQNdi+iWMY9RoMRwC4g=
X-Google-Smtp-Source: AGHT+IHANp7+/BMwt988SLqyFK4IXfD9/zYPo0ZjUxhHBAeaZYv3Ys8UDFEPSo4JAjl/rljyKlox04YLEYQzEDwc4rk=
X-Received: by 2002:a05:6902:2b91:b0:e1a:72e9:b243 with SMTP id
 3f1490d57ef6-e2250c24a2cmr8718542276.9.1727176731047; Tue, 24 Sep 2024
 04:18:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915114311.75496-1-laurentiu.mihalcea@nxp.com>
 <20240915114311.75496-3-laurentiu.mihalcea@nxp.com> <CAOMZO5DR7xaEGj9=mzzFPy6wB0z7-SmvXkMnFH-wSjs01hp=WQ@mail.gmail.com>
In-Reply-To: <CAOMZO5DR7xaEGj9=mzzFPy6wB0z7-SmvXkMnFH-wSjs01hp=WQ@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 24 Sep 2024 08:18:38 -0300
Message-ID: <CAOMZO5Cacne=7ZYQ3eSdO2RRd+QuPurziFN+mS_KU7kucXHBQA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] reset: add driver for imx8ulp SIM reset controller
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Liu Ying <victor.liu@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 8:16=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:

> Who is the original author?
>
> In the NXP kernel, the author is Liu Ying.
>
> If that's still the case the Author field should contain Liu Ying's name.
>
> Please double-check.

Also, even if you are the author, there is still something wrong
as reported by checkpatch:

WARNING: From:/Signed-off-by: email address mismatch: 'From: Laurentiu
Mihalcea <laurentiumihalcea111@gmail.com>' !=3D 'Signed-off-by:
Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>'

