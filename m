Return-Path: <linux-kernel+bounces-225222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92FD912DC2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15E5F1C20B70
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 19:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328E017B4F1;
	Fri, 21 Jun 2024 19:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ECAbtvCH"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A3C160790
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 19:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718997430; cv=none; b=aHXJs/MNVpuhzFcsJb6VV0Xvv0tLQLohFijnxVpT88Eo+zy93BP9e1Et3s0SplJFrnwNh2QTfnzIlirgr5Fgndpk6/529rew2uS7QJMkL3qSEmKESFZyWSVUe6+EVgjpZ6+ShtxrEMUzohxzOb76TLCuNkOm5d++OUUyaYaC69U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718997430; c=relaxed/simple;
	bh=7J5AIRkxOti8YYAHsz/gEyTkLUKSwh4/mHoyvBWhX2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KlIeYKznXrT2TWBP3o24Ffps+8OZZt9hFFGhAXgBWhiELp+7Bbv7RLO+B2P7E2ePughZ5IkPPK9Jz2GNLfEkiviMWk2NWMY9AUnC9uuxPKzYb3TpCarkZfMn8MPrA9+dH8+YFGPRD0/luKS0SjkpMTTgWjrCrOtNYHb3oTHaedU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ECAbtvCH; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57d20d89748so2407221a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 12:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718997426; x=1719602226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7J5AIRkxOti8YYAHsz/gEyTkLUKSwh4/mHoyvBWhX2A=;
        b=ECAbtvCHGsnw/7UdTSrKimVG62XhPwynNC/c44Jg0ctt5iFvTjFEJ+MY2XJiNMeVc/
         a1p9hPwZZV1jufs5evXfKGO3GGJiDciWygJBcvWFsrOO3KhM4tnpn6KQUkNVqGlFN9JO
         3jdprApHcy7eS4+77syeqiLz8FBT3Aa8jTLGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718997426; x=1719602226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7J5AIRkxOti8YYAHsz/gEyTkLUKSwh4/mHoyvBWhX2A=;
        b=fL7ZNHf7t1xStIuy6B2oDc3+hJi/qSFhnFhYUDOrjSEuDn3uRpiKsJr2QMqqymCDOE
         Q85heDMaPKnXilYmRuQZo5wCnGpQnk1ApQD2rqkA9ZDQ+WZjdg6UmdTPV86si7w6PDxd
         Nb7tsHxnEBULZo6OZj2WRdv+GH6+NjdF+R2XEi3K03FG0OZwhGkInMM33UIOzlZnW79o
         0/NtRlME5MPMja4U2o2DtlPujU128toVhIuES6sZXPqbgJeGyXzRwWL7/Y5pJp2NSSqJ
         vkQ5oGBcky51OpiPRasUPVCrTbOdnRp/GgTFMDFNNugCztPhz5cPd17V6DQk5xQNT2+X
         R1gQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQc+FIMk2JuiutQEKQn0ekVKlmLXq8D49S0Yftdml/HePJq4ylWOQdwFA76945x/vuOFMJlTGSL/dDwWShZ5nvHaYeFRbMHBaN7+is
X-Gm-Message-State: AOJu0YyA2Ya+c/Kcpco6Pi1qp/+MSzSTgx+kl1woJcP5qsom/u5N8vns
	E/xopvgoESzbMNU8jHPDByfGui7olUZwr8o/JpXi+4/0NhQRY8lngSSxQzEhLxoB3tWlQ/HDYpA
	=
X-Google-Smtp-Source: AGHT+IE6FJ2+lfgQxUlXU/meALQ5iSRVZnPbyo0rfnX6VgZHGARnEq7OVi0cQNmY5KPVyAXQflKyiQ==
X-Received: by 2002:aa7:c749:0:b0:57d:15ee:3d17 with SMTP id 4fb4d7f45d1cf-57d15ee42abmr4649089a12.14.1718997426346;
        Fri, 21 Jun 2024 12:17:06 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3048b93asm1334558a12.56.2024.06.21.12.17.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 12:17:05 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6f21ff4e6dso326853366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 12:17:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW0dhnlV840XhOOp1jlsV2tqBe9juA3Ypv5B8EfC2Nl7jb/o4jOXu6QdPFAt0QD21jvjdqGYHMDeq+y5lEigwTyTVEFqS7CvcyilyDy
X-Received: by 2002:a17:906:1f4f:b0:a6f:8265:8f2 with SMTP id
 a640c23a62f3a-a6fab642399mr452321666b.37.1718997424907; Fri, 21 Jun 2024
 12:17:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530130156.1651174-1-s.hauer@pengutronix.de>
 <ZnRvZMQJUr4APwUU@google.com> <ZnU-STTaTWjHViwW@pengutronix.de>
In-Reply-To: <ZnU-STTaTWjHViwW@pengutronix.de>
From: Brian Norris <briannorris@chromium.org>
Date: Fri, 21 Jun 2024 12:16:50 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMSyVbPrTz4Vag-4_yi7080bBtkwBgOLFYOTmwb=NDvNQ@mail.gmail.com>
Message-ID: <CA+ASDXMSyVbPrTz4Vag-4_yi7080bBtkwBgOLFYOTmwb=NDvNQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: increase max_num_akm_suites
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>, David Lin <yu-hao.lin@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 1:48=E2=80=AFAM Sascha Hauer <s.hauer@pengutronix.d=
e> wrote:
> On Thu, Jun 20, 2024 at 11:05:24AM -0700, Brian Norris wrote:
> > Possibly dumb question: what's unique about mwifiex here? Everything yo=
u
> > describe above sounds applicable to all drivers, IIUC, and I don't see
> > any other driver that touches max_num_akm_suites.
>
> I asked myself the same question and I don't have an answer to it. To me
> it looks like the number of akm suites is limited by the akm_suites array
> size which is CFG80211_MAX_NUM_AKM_SUITES which is 10 and that could be
> used for all drivers.

Yeah, I can't figure out a great answer either. Although I did find that
(1) it's theoretically possible some driver could be confused by
larger indices (which should be easy enough to audit...) and
(2) there's at least 1 borderline example, in wilc1000 --
wilc_join_bss_param is only prepared to handle up to 3 akm_suites. But
it also has a (magic number) bound of 3, so it will silently drop the
4th, 5th, ... suite.

So maybe it's a reasonable start to have drivers modify this as
needed. If we later figure out all drivers should be OK with an
increased limit, we can unify that later.

> max_num_akm_suites is introduced to be driver specific and so I changed
> it only for the driver I am currently interested in.

Sure. Seems fine to me.

Acked-by: Brian Norris <briannorris@chromium.org>

