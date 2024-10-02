Return-Path: <linux-kernel+bounces-348313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A71198E59E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 23:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7567FB217B2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD11199225;
	Wed,  2 Oct 2024 21:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q4bu//2Q"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8577195F17
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727906169; cv=none; b=TOx5wTkOlsaaOu/wHwGNHeBF4gu2dqfPnyBkYw6Dq7f7j0A6rQ5EZDkTpf+KiUm/cxqVZP6+WrUA+ME7Bi9HJksVQcwUlsl8w3bjdfTbKt87IN2ER8LP9ZBMUF0+7kC2g+ZgnruEAj9anAX+Sd1c3TFQ4fUS4d/rvhPMJX5sdiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727906169; c=relaxed/simple;
	bh=h0EBJ5lNu/jJJVuBHSnFz5qqW/dBFft5gPiqC+7OkQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c6g9W6bsNwxf7H1YmSsyoJVwLeTptSjwP0AkoAkkQkNTE/lbjo4Dz0kdQtz+w0chPFbtWs8fCLzVfIXmmk+dy5Fu7i2J7BMjhjbvi8g7AtWMdK1sWYHx4YUNgcmmjvuTw1hE4KohSg3aCJ721a5i6twUMOXDIq+4crGhcmDWBAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q4bu//2Q; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e25ccdffcc5so288065276.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 14:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727906166; x=1728510966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0EBJ5lNu/jJJVuBHSnFz5qqW/dBFft5gPiqC+7OkQE=;
        b=q4bu//2QEzekr8PdvgB+0ggdBmBW5s3lZ68DqkbVIITSuhzkq7z17Yhw2l4EdgArA+
         dGu3F9maZWxmiYl1zPB0dyngFv305oL4mLtb9BkhxL5sGOtCcQHklC3uVMaFb8JbANaA
         CBF8W3D72s/M04BmDAEypfKYy/zHEjC/XtxrnylNW9aNhoH0Cl2iXvnZxhVwqQLOnWn6
         U8QJ+wAgsrcolCpsaFCt7a12ZvqOmvreTgxrkkWbp7CFrDEZK1b+RuTNo1xw/OGzqZOq
         MRDaIJS1+PHNJ6GKsj4Xabk9M0lvsEOoWTCaUzMXPc8qpwGSiymoa37EqSL7ChfWhTHK
         0efw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727906166; x=1728510966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0EBJ5lNu/jJJVuBHSnFz5qqW/dBFft5gPiqC+7OkQE=;
        b=euu1/+cZR7LMa9+ivoK615OGPRc0d5S+zD3CaveOnlJ5rwCX4vagHWNCFADiW19hMK
         9WGPly9fzrKuJ9/FqbvPHd/2jDJTFOPgD51dYq2xKUGblf/qEdkz53laTdfq/BlsXfIc
         AqvsOcj4h3G7r5vrghfzwwZomppJRubew0sg/EHZR5PaWoMEono5Q1RvMVT98y8xd8r3
         8/fijWb1/iJMY5QPtb+L2UPmNwP9RWBqDu9yNWplx84dHpjiR256gildgvW/Owuz7zVD
         iWB+UxkhqQSPSdabEGHaCTQYsyZz/vDU+rMSDQ8EBJNrEjzBp/UNTcddv6IDJPVlduUB
         Eb6g==
X-Forwarded-Encrypted: i=1; AJvYcCUcHQ7n4U5PbbeWOXoKmgtJ4yoSBR7fzHE0fk3Z8jUWuPRjAOKQcBKpEhpJvFTpD0kS2VNs2eDZT+pQCYs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4a1+I2nL3lan7hFPOdQdFBhRpS3bffmydu99iDPp1zMZJ0SEz
	JteYu4fDbQsgvjKQfIwWCze4G8Sg+R7pIYGDWJrHCP92X7BCNByYovNuFN0YzhObC5efQCI6Mvw
	EKhMg4DlUBVlFB8O0VtZYAv4fHOH9+I1+SgM6Wg==
X-Google-Smtp-Source: AGHT+IFRD5Rwum9K8DL674IifKjdfllmqQlH2FJ5zW9tVqEuOQNeCWTFnfrU70tmiCM2rMmiZ5ejF92CDM0MocFZHCE=
X-Received: by 2002:a05:6902:1b8e:b0:e25:fc6f:9cc0 with SMTP id
 3f1490d57ef6-e2638385365mr3826517276.9.1727906165882; Wed, 02 Oct 2024
 14:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912152538.1.I858c2a0bf83606c8b59ba1ab6944978a398d2ac5@changeid>
 <4920950.GXAFRqVoOG@diego>
In-Reply-To: <4920950.GXAFRqVoOG@diego>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 2 Oct 2024 23:55:29 +0200
Message-ID: <CAPDyKFosf_+m9j8YgHa-PsC2SV8+Aou2O6bTbMfzGBpQ2sY8YA@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: rockchip: Keep controller working for card detect
To: Kever Yang <kever.yang@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org, Jaehoon Chung <jh80.chung@samsung.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 14 Sept 2024 at 13:52, Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Donnerstag, 12. September 2024, 09:26:14 CEST schrieb Kever Yang:
> > In order to make the SD card hotplug working we need the card detect
> > function logic inside the controller always working. The runtime PM wil=
l
> > gate the clock and the power domain, which stops controller working whe=
n
> > no data transfer happen.
> >
> > So lets skip enable runtime PM when the card needs to detected by the
> > controller and the card is removable.
> >
> > Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
>
> So for the change itself this looks good, i.e. it fixes an issue for baor=
ds relying
> on the on-chip-card-detect.
>
>
> But for boards doing that, the controller will be running _all the time_
> even if there is never any card inserted.
>
> So relying on the on-soc card-detect will effectively increase the power-
> consumption of the board - even it it'll never use any sd-card?

Good point! A better option is to use a polling based mechanism - and
we have MMC_CAP_NEEDS_POLL for exactly that.

Moreover, on DT based platforms one can even use the "broken-cd"
property to indicate this.

[...]

Kind regards
Uffe

