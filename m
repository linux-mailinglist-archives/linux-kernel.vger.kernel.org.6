Return-Path: <linux-kernel+bounces-559170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B002EA5F054
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1266017DD0B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411B11BC5C;
	Thu, 13 Mar 2025 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wwbW/ef5"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B46425FA25
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741860650; cv=none; b=rs1/McQCfzSwBNUxIVdbyD/BOrxvU3MY8ITwrELlfK62qLXSyRhm+o2X4BhKfnG810ZLUtzi55a/iodCmqxVaWBC5U9SMMPz/kv+R6yY95Xtv9U8ZS1PuahgHge8ID2TMXRB3il+wjugLKlv3F60t1O7QoujTtPjXBgcdl5lSzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741860650; c=relaxed/simple;
	bh=TbxwI+znO/sxGqbs11RbQ/Plw0Mybu0NGFX5kC+YrbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YEIMflo2JmsenyOhE9R+DPVlBbYU5HxzRyK7yAA+OM82nJ26VttIXw68nAc5VySL5zh2toFf2oWFyVbscujmo4P3FG8Xh+R9xWiVcBEj8vLWc+ibZxvJf+rUlZm2rKdI7kRCClk6oP9JLX9w9ooW8d+ZhurM+vKdKsQdKDMPv4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wwbW/ef5; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6ff1814102aso15293477b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 03:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741860648; x=1742465448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEq4gSc+pVBLq6kDjW0dhNwCO81EyRwI+zgKcB69s94=;
        b=wwbW/ef55DSMJsruWuOsko1h8+Lryk0Ui8JkBRE/FYY51KTwxhj4f1cXJbn7b92y6S
         HdwVzHqjItYpzevWfCC4ai5ELNAApv0BtxNkctHP+iYvNcFmTdTLvDFCJwPgJQ5VTv16
         rPiFSByCre04xhWpbQL2DWGo8IbuXmJgJJ1vqVo3uTIxST6+iRGuN2pwlpRMhH5dv6mg
         ha72AbQyCf5SczjqhmBW+zIodoj3S8RSD78iSqCxagdyzHCUQ0mb0fIyLnN77rjs830r
         5fqzJwhgEP/YIDmg5oMGPe81WYVwISQy2f1zm0agtK5NCo6HqMPBf6LdbyguzKtfnYSU
         yE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741860648; x=1742465448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEq4gSc+pVBLq6kDjW0dhNwCO81EyRwI+zgKcB69s94=;
        b=lDdYY6DbXWJW/mhhtAd49opZXf9f5l9igQ1HJcZzExRlgU21QTs1s6ci5CT+n8yjK/
         dbFKCrSSZmXlMN2bh47ARAUIx5DwGkwwq4337Ixg+6G5KnWKXYBA5+Dq7YUQBs+GDMw6
         xeVInMMaiggwWxup+/Uxy/NIgmdDRiGuB9Mqqlo9TYOiSWBv/pAevg32mUif6PFsjIWh
         sL/bSzD8Q0HLf22DY3ES5JeMWg/MHdFJMA08jwPqB0BznVAk+RQAL2iSrSq8B6seJm2v
         J+EkEQzI5xvkDIh3AiL16tsBS7peP6iHTGv8tvm9sCPdGBih4zDLdRq4pvPbmRwrK2lH
         nfkA==
X-Forwarded-Encrypted: i=1; AJvYcCXoqjgyPh+2JRYJ5YKa3jrNos+KhiYovGoeTYGjIVxkxKzXjunHmdTRMHwtdmjvFstVewffjYTWhzb524I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiF1ypBw1zTOSnLtv3iJ+lueY63ezLTou/UX1JjQqAEJP3ROnF
	NYuZiQ3MeV5oR3SQXdhjojuSsEe7H8BkUToeDXHG+ayLnEr5qqFMiHcqRh3sW3QHRdx3REe8wQ9
	quWcyob8q0aku32ApE/HCl23ndCEaZ92X1SWvTw==
X-Gm-Gg: ASbGncseQCY0xMtYsCbEaTxUe4v9AYuujeGlNOAK1khyvxhINOEVmlq5glhlOTmo1mZ
	ZBqkiHH57+zqxXBKDQc+LPl7mEut+GM0EH5sX/L8p7aXEVCcZIR23Bnx0whMtT0J26bJmwqDP1z
	QxWf2Pt37ViPouWIgCe2jXZLPI858XClQQBg/NnA==
X-Google-Smtp-Source: AGHT+IES4ylSRZLRhz4IqnSjIJ4SbTq78c06VoJ6seezxJB5E2x1gFW3S9k2nq1/9lT8UoeNfaCTlenakAPZsdBj9dI=
X-Received: by 2002:a81:c702:0:b0:6fe:4ee5:a6d5 with SMTP id
 00721157ae682-6ff2f45d995mr23159657b3.0.1741860648042; Thu, 13 Mar 2025
 03:10:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311160827.1129643-1-ulf.hansson@linaro.org> <CAJZ5v0hgzVvA6vcRxUeByhVPgjyeUfY7v5Aj5GPi=_T_XWpPvQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hgzVvA6vcRxUeByhVPgjyeUfY7v5Aj5GPi=_T_XWpPvQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 13 Mar 2025 11:10:12 +0100
X-Gm-Features: AQ5f1JpdkM0uH49Oh4WBEU6OiQEkUVTrTDRedrw1VN-bzd_F5ywqSRzg6HsfmUs
Message-ID: <CAPDyKFq=Ne9xt5UaQWdWVFfu6fc8ZFmaNYiJ2s6kRCowVxzagw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] PM: s2idle: A couple of minor lock-simplifications
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, 
	Pavel Machek <pavel@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Mar 2025 at 21:20, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Mar 11, 2025 at 5:08=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > While working on s2idle a few things caught my attention when looking
> > closer in the code in the s2idle_enter(), in regards to locks. These tw=
o
> > patches tries to improve the situation a bit.
> >
> > Kind regards
> > Ulf Hansson
> >
> > Ulf Hansson (2):
> >   PM: s2idle: Drop redundant locks when entering s2idle
> >   PM: s2idle: Extend comment in s2idle_enter()
> >
> >  kernel/power/suspend.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > --
>
> Both patches applied as 6.15 material, but I rewrote the new comments.

Thanks!

> Hopefully, this is not a problem.

Looks good, thanks!

Kind regards
Uffe

