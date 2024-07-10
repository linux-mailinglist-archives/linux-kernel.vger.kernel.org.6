Return-Path: <linux-kernel+bounces-248151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0A392D8F1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD9751F24A61
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942CC197A8A;
	Wed, 10 Jul 2024 19:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gq1EGplQ"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97498195FE0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639167; cv=none; b=YuwxzJEiFt7ZRhjAeGa8MkSxVf8oPPZvTzkb7sKA2/MU+iXgymnOP74SXR5CgU1uRPyc3puk/FQYsWY2qayFYDjPxyyvwxKHK83lD+xc9qO9FJtOFLMcrGuPd1+p7v4ntcVhuTh2vsbi4rQxGtvQSD4BBIg1YIXSUJky2pdL//o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639167; c=relaxed/simple;
	bh=WZPvRRYPuG1k1apLr7+uc+ETUG4y6xHUPigbLwS2g1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pYB8BQAurY3NaWgWgxxpgoDjnXivFCVPuVw4g6HdwZ8Bgy06rQozrQWjRN0SNsYWx5bmj64eZyhDgoy1X1UCezahrMhfgSU5IWDU+CI5e1EizaT5H4dKn5RBVIATWsb9HgOFOzNOAZuhVZBfHy+nYsNOkYZkGuURPx8jXvqmv6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gq1EGplQ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-70df2135426so40080a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 12:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720639165; x=1721243965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfu6YHYXAYDu8BCDtd4YBroCALNFVkJ9E+bO6AtHH3w=;
        b=gq1EGplQbq0Znsjp+TA1apJppxG0YSIfWhuCcrI2cukgOXJ9iJN8q+ExLrgMZX6xtq
         mHWwMQ2a8pZcbqrOwTHjEfPDm18shkLUUxYDmEQ7ay+bZJ9tgcEjlWc7CMDs4FRalWVt
         JFFk9/yHkEIupyxhd+3IFN3EITMes1bAu6rbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720639165; x=1721243965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfu6YHYXAYDu8BCDtd4YBroCALNFVkJ9E+bO6AtHH3w=;
        b=FDIsrEVTS1fzbryhI8obh1NNYoWazksv0K380b7JUvgAw10TIJW/gc0txR/xezqZx7
         eFm8uMOCqPayFtDlPUDMoGze8iQRvEd42iiDRkBEkwYQS0Eo9u32DjXWIPpHF25mqKiz
         KELoxOG9C9aPkNp7F/0MOofu8vM+n4vNqbx7sgal9USkcfffoeUdl3cahE9FqPbG0WEY
         NpT2J5u1ocie49jAZuCzPridrLF8NuxlUcvuPqao7lpaP2ih0IpMrSl9x0NqLEHBWHoy
         2wy5f1LluUwRCsx/np7SHX8XZY0MYDJkJ5VLOkiCmSF4fjR30AwyISQsJ6JRJo5Ax6JQ
         CvxA==
X-Forwarded-Encrypted: i=1; AJvYcCWz2o7JuJpWU8z/sHKlxz44G9SppSO4A7zE1R8wGKdSE3T10uwwoxmSNKkXYkK0Qbinvtw0SzlrecCFMan7tEIXprm74iPPXW/OKBQ6
X-Gm-Message-State: AOJu0YwKVZUKQaIMViFQd1Lcu+bBgOHTWmdxLI+rYzea4TMcwWRog6c7
	NWO3SzP1Dijb9k1cGpu9jiik4c7aHtlj/In06GJdtUMEv3X5mSuuh6TBR7qe6QDJJ974P8aZBXg
	Hzg==
X-Google-Smtp-Source: AGHT+IHWcJG6FpmSV852lerObEkvcsTHEy44LA5E2DBEB18WK/km7nTik9CJZ0NbcR6VzCVjHn+6Ig==
X-Received: by 2002:a05:6a20:7f99:b0:1c0:c95d:af4e with SMTP id adf61e73a8af0-1c2984e6277mr7103472637.57.1720639165309;
        Wed, 10 Jul 2024 12:19:25 -0700 (PDT)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com. [209.85.214.181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6acf373sm37163205ad.261.2024.07.10.12.19.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 12:19:25 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f70ec6ff8bso37735ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 12:19:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUv/6rAf4d2n3NQ5GVMfSv6gkl6kM7MATP0LvNwgy2YOb2j/X/ys5fX1/P6rQfOhdSsT00gLEGAGQaQjgc730zYjm+ynPe7Do2kmdAg
X-Received: by 2002:ac8:51d1:0:b0:444:fd8a:f1a0 with SMTP id
 d75a77b69052e-44d1255ffaamr427131cf.25.1720638782549; Wed, 10 Jul 2024
 12:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710084715.1119935-1-yangcong5@huaqin.corp-partner.google.com>
 <20240710084715.1119935-4-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20240710084715.1119935-4-yangcong5@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 10 Jul 2024 12:12:50 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vftx+AVUtpnYrSwW9725gwjH8BD_C6i+bd_m4nCx1vQg@mail.gmail.com>
Message-ID: <CAD=FV=Vftx+AVUtpnYrSwW9725gwjH8BD_C6i+bd_m4nCx1vQg@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] drm/panel: nt36672e: Break some CMDS into helper functions
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: quic_jesszhan@quicinc.com, neil.armstrong@linaro.org, mwalle@kernel.org, 
	linus.walleij@linaro.org, airlied@gmail.com, dmitry.baryshkov@linaro.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 10, 2024 at 1:47=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> Break select page cmds and reload cmds into helper functions.
>
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>  .../gpu/drm/panel/panel-novatek-nt36672e.c    | 69 ++++++++++++-------
>  1 file changed, 44 insertions(+), 25 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

