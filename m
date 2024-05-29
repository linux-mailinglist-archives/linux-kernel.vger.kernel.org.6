Return-Path: <linux-kernel+bounces-193633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1B18D2EDF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2550E1C22CA5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 07:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC50169380;
	Wed, 29 May 2024 07:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RufkETRn"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC0B16729D
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 07:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716968882; cv=none; b=Cx6bp2FMB41qrgXu1u2WWPYaPOhszRiXcD+d8je9Wz1T74bvbylqrEhaKVqB40+GzlS8EBRmhw2foLOW76iIo0xFLcOGwCxISBuB9LDKomJKtQ6WblGx4YVEF6I7pvFBBpd5Z3/qYZA4CJu3LnZF1soCKTEMDmURu+d7o4xfjSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716968882; c=relaxed/simple;
	bh=ZLRsrxpXe9Zp3VPT/T7RwKIZpGBJnxKr2hKHPCuX+rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/Nz0XthckhmU3DI3WxOfVMRNvuxqP0o945v/eJDt6FUKcZM1eDbKHPvfVOZYSM1XNnp6/fm1EfqmHZn4Tmq46TdpHH0D+vdjDDuHjcB5JSchTkVEe5c6q0CyLAlHuQXwrMhzz6nukFKoBfAtkLsOpCP7F5PsW8gZyfdXhDtKZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RufkETRn; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dfa52560cb3so18312276.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 00:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716968879; x=1717573679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLRsrxpXe9Zp3VPT/T7RwKIZpGBJnxKr2hKHPCuX+rg=;
        b=RufkETRnvUZcun33kSF8shuoUS5ktZvzvRUZvRs4mMrB/j7Ee1JWcifKt5xeV8hSF+
         mGBbr7ZxxYUpWfV1SxMDxUK9Lx8v5EgZKZE2en4n8GcPpnuD5HB3fAQe+FPHy4M6f0Z2
         uAp+1IuyXWGrLNwf1smb3MBt96/AWC5ltQzgFNJCYjQ2StVE+iHpabtXAJLsaP1yNRRV
         PJ4HyZO8ninNuNa4xJl4BbktfGjwL8wQJVAD981NCoEAcewAvSgHZO1ZrPJ9ux6Ojbly
         8BBxhiAguvN4OtSUo330XKBBopyw7rRHF9UaUG5nasKlAqqZGU59urbEfYdoNTHvBFPj
         WDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716968879; x=1717573679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLRsrxpXe9Zp3VPT/T7RwKIZpGBJnxKr2hKHPCuX+rg=;
        b=dNNe8JDpri10SEQcxy2465dLqG1Lx99iFuD5CQHSkqgHb7tZBFl7QS3H7sbZD+SZK9
         /zdRk4XWxoj6TjXNmjhxhuXVKELS4Xv/YDi5Wqtx/1+tcuZJ8EzRzcZ0pNU9ZZze8b5G
         wFayWmTxWnNFWSOduaoWR2Hvi4i67GMmBCOMnYHPnZp4DG8lgEQeay6x1Bw7h3isPtMU
         ZM86+KBv/wC7dX2X5Gdh0YU5nu73REstEP6Fb17W7bZg0kPp4X322j5laSO5O1FISqi1
         O7Twepar/TR8gYnnaiiMRcpNss2cYy+IYUQTPfRoGV51PONSz+MTNRKUtVDdLJeVfI3g
         +Xng==
X-Forwarded-Encrypted: i=1; AJvYcCUdf2ep+8g5GueE+Oeal0TiiSEqsjHdFR9DGDCmESX3zNXIDnAVVbQzC8zs6tSAcMNALBjwsswo5j2PdVGvEAfEzVi9m1pbwPzIrVIk
X-Gm-Message-State: AOJu0YzDyu8Lue3Hzd1gq5haos0Eh5yYDLiB93oEkwFIrh+rVbPjfCtS
	GbNYoroR5PAg8EsUXrEYcBFCpRrRuAOjdEaRr4KWaZJjad+tRzbjX/zeRiHG8sUgGE6I4bQMf1R
	iWsN+xkP1JmB9nCLWnIODVVH/VT1LDmSVoabD6w==
X-Google-Smtp-Source: AGHT+IHad5DPGdv1vZ6pFMvNRKeWKOg+qWNTIV+G/n3igH3L6YelODk3RzdV6c+pkeV5mhU93NuGxjhn7G2QyWrazfw=
X-Received: by 2002:a25:8286:0:b0:dc6:bcb3:5d8e with SMTP id
 3f1490d57ef6-df772187fe7mr13537892276.20.1716968879430; Wed, 29 May 2024
 00:47:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528000634.196707-1-linux@treblig.org> <20240528000634.196707-3-linux@treblig.org>
In-Reply-To: <20240528000634.196707-3-linux@treblig.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 29 May 2024 09:47:48 +0200
Message-ID: <CACRpkdaWszS-CpPTdjkQyNoyRffMGywV0tkkiF18m1_Nvu5eVw@mail.gmail.com>
Subject: Re: [PATCH 2/2] power: supply: ab8500: remove unused struct 'inst_curr_result_list'
To: linux@treblig.org
Cc: mazziesaccount@gmail.com, sre@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 2:06=E2=80=AFAM <linux@treblig.org> wrote:

> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> 'inst_curr_result_list' is unused since the original
> commit 13151631b5bd ("ab8500-fg: A8500 fuel gauge driver").
>
> Remove it.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

