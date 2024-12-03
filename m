Return-Path: <linux-kernel+bounces-428873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FBB9E147B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F4D6164AF0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 07:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF941925AF;
	Tue,  3 Dec 2024 07:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="YWptD1HG"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DE0192B81
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 07:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733211697; cv=none; b=jzX17kx9awYAElaQX7qlN7a+VqtxXmeO2lsAdDbAPOAV7tYq+8NqWUXK0bjOb9qE67TUQZ/D43ZIPTJmSINsGP2VKvI/nADQGOYRSmGlSSunXirEoa8RjGwhQBlOSeJhKmbDmrovq04xm3tENOZoZVEioOHJ4377tbD2IL4Qp1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733211697; c=relaxed/simple;
	bh=8/MeihlYKEjbtYq7yjGOiPXZ8SPSiHsjEmNh5LnyysQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XCXbEdOQZvyHPTNBn4USi0s+FAR+HSdKV3LUEi3Erj7en03oWqw71x9Tk7TZXxHJqE5bcR9yQoEQBbwDfnenUeZU9pNtdo/eA+ocSZs3q2vY86Y7jzAqSfcj2ujH73DguMJXxLyox5Apcw3Grgo14c2Xas1K3opvpU39Pn/NLsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=YWptD1HG; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53df7f6a133so5486278e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 23:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733211694; x=1733816494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/MeihlYKEjbtYq7yjGOiPXZ8SPSiHsjEmNh5LnyysQ=;
        b=YWptD1HGN2U4nz/1/wkBJb5gJK8F4orww9bCWkanmqrLrjDnfly9Pel/7CqEevARyp
         TWXHT1YfeFS5BOxWfiPSNQrjCKklSpgz93HC+vv0fv2x81McfaCvoZa0f9RiTa1cd1UP
         QJSzNEWhabTuUOjLrF33Uk0kmQ8AD0SqvAqTugUk3iJmGI5jd0wPLfjCs2I9B3H5UBZd
         SUUXquwAVpKvmz8p9A2WkEWLY6+9IqqFpUgeeJ5gERpxhT1vtH5YhCOcUBM9b0bqnf6f
         yvGfCAfGFyazCflwJnlAIUw+RRhS6VYTTOTNy3NPp1+/RqD797MrObRKFU2PoPoL6ZP2
         8yyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733211694; x=1733816494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/MeihlYKEjbtYq7yjGOiPXZ8SPSiHsjEmNh5LnyysQ=;
        b=F4NhWNoXC0Dz1GV8Lkl/oyvQAYuwUkzQBwdNEudGCk/rq6qBztQ6j7HT5Yvu86j5DH
         lblfOeU0h5MZTEbKcTCQ702eFhsSDvBiGZHK1wyzBk6c2acKy9BNVEWDDtnheFP0T3w2
         lhk679VHsB2MTuJ6qjWN4mWd22ArmBA1ZFReP5HBzt5iKkuWOSEAHn59Ca7eeZagDe65
         lKT/nHupnhw+UmonJXZrsgaxmDjgi5ScQT8C4fmZPZA5cEFi0psAfbGmEsDK4OIdEpPJ
         DDx3YL2GpcWerKlXZA3ubvnrkjncOLkjGas4T/xSdx5rmTpbWDYHG+7rj9VT5g6NSrai
         3M5g==
X-Forwarded-Encrypted: i=1; AJvYcCUv1IXehkrCPuKIf221sM/6ehLWwP8ovD3zerRM60ApzESfMVT+RFQ1EgYj7UXjOAN8kOaHfGNsD5fTlqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcgouOEa23aUDkEhWOuwb0Ttrq7RdGrU8c8E6Rz1fqY3DtuSFr
	tcigXhqvkxSNDI9xgwmqc3jm35GePfzj3ZMVsr8Knl7m7EMg+y1VEI/D5ZV1mt9Cw5KH2KBh7gY
	XbcDmTQIHKmyB2r4M0YhvUg9KLYaiTpBpwGte0Q==
X-Gm-Gg: ASbGncsBvlel5GFUZiHwxqtrsxD8oDOZMB9PRuItx4fXWeNcUs3ObjLzbqobrxCzmvv
	JoP3pX+9yhRQHv9cb0OT/SI8J2d5wyjo=
X-Google-Smtp-Source: AGHT+IGXEhBq6wns3RLJUvyfVAD0UpLJ7elXsJY/o8pbtWMWxfMKmXusm0f4mIT7tIPT6ikD0FqI/k4l6ADmK8tOoXY=
X-Received: by 2002:a05:6512:ea5:b0:53d:dda4:8b0c with SMTP id
 2adb3069b0e04-53e129fdc50mr718667e87.18.1733211693822; Mon, 02 Dec 2024
 23:41:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008160947.81045-1-brgl@bgdev.pl> <h57xw6en4bb7gxsqq7qwq4z5yakavmn26jda36uh34r3ve4kbt@vj35tpjd7d2f>
In-Reply-To: <h57xw6en4bb7gxsqq7qwq4z5yakavmn26jda36uh34r3ve4kbt@vj35tpjd7d2f>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 3 Dec 2024 08:41:22 +0100
Message-ID: <CAMRc=Md081Y1PGdmdSWuwsw7z++MM-jtDttRE-CU9RzP9autYQ@mail.gmail.com>
Subject: Re: [PATCH] i2c: qup: use generic device property accessors
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 11:53=E2=80=AFPM Andi Shyti <andi.shyti@kernel.org>=
 wrote:
>
> Hi Bartosz,
>
> On Tue, Oct 08, 2024 at 06:09:47PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > There's no reason for this driver to use OF-specific property helpers.
> > Drop the last one in favor of the generic variant and no longer include
> > of.h.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> this whole thread has gone off my radar, I'm sorry to have missed
> this. Thanks Wolfram for bringing this to my attention.
>
> Merged to i2c/i2c-host.
>
> Andi

Hi Andi,

This now shows up in mainline as commit 50b9d43e6ceaa ("i2c: qup: use
generic device property accessors") and in next there's a duplicate
commit 6f5f581b577b4 ("i2c: qup: use generic device property
accessors"). I think you should drop the latter from your branch.

Bart

