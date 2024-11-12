Return-Path: <linux-kernel+bounces-405517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1589C5255
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA5861F22A69
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8530320E03D;
	Tue, 12 Nov 2024 09:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejpdp1rC"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573BE176231;
	Tue, 12 Nov 2024 09:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404764; cv=none; b=Vxhq+0VVxRPNtRn1IIeQ4PaF0KRLoY8r1yWjYe2ftRSchJU+Ve1CnJBnd97jrCk1okQXMUPl47EB6NFnyTxprHlASxOytEIhjkmMYXCHSqNTrqspMlD7I2O5oMoTrhDD7f61QTO33OfPHRnNRVwV/j4jZ41s7zaOz7/wrJlzn+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404764; c=relaxed/simple;
	bh=Oh6CO+N03zDIceK5ENrBo6kbEv2iLpS8+KXHx+FYWQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPpmzbmLhyJ3SR5iIm/Ji5JH0DPcL/10Lv/1CcLyOBPzAcDVVifROAqOBgfUYpSZD+k9ettfb0y5Hqy7Yuw5CadsIf9OoVmdzS9QaCSNHlaJDN5gySu9JyNU5lkqQgSCRM6t+MCm/dajeqeNmdzy806jA2XM+vj5/Lb7JSO4xjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejpdp1rC; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d447de11dso4049741f8f.1;
        Tue, 12 Nov 2024 01:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731404761; x=1732009561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kn+8aJWTkqwQ5EGfRTZpllEjlS0gFyQTELc12l06XLU=;
        b=ejpdp1rC+KGgnA5HQQ7hy9NFJ8QdyOnTohG4x+Nv1K+8un68jx/wIhMuyiWd7uE0MP
         C7uyzORUjqYUZ3swLCXb7dg5rpDwMr0YrBYO9HLAa3g4S3FsLaLUbw+cnG2mCgt4YEHq
         8PBxs1FEZGdJft2wHbPw1GlV1y9WhB3CDi99+N4LXrw3m72ZvldhUREodxTN7U5eZ2is
         O2hRn7ZnAVQcDgvMzXuhFm+3g3Pwiv3Tqj1qYpCYFA8SVuKnvHi5TKLo6MNY3FE3i/MS
         Phd7lUMPc8Wm2bhACUi9bnfW3hLehE9cjx22MZ0Sg12ZkC47OxRZPIK2XVGGBJK80YbJ
         mSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731404761; x=1732009561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kn+8aJWTkqwQ5EGfRTZpllEjlS0gFyQTELc12l06XLU=;
        b=BHgKncI2tF7N28erPR9A9pqJAI/KwXC+5LBlQ0lgTVfU2tZsrGbKgY2tgSLa4FnWjr
         9ex2oClqI1IEHzUvFKJNWAVMEiYEYiNr149lROBoB/0kroYdyYrxbbYa8ecwHkxqwIO9
         H25kVVIaS8vdM+YPWH65dIFY8/xLFsZmcvRI6ucutM0WJQ9S3pFzofOGhitgHqhLeKhY
         pRvzsOHx7QsI+ZF4iUem7p97VoYEaWkwzN/gFfaqfIpnMczwNJ+lb/p2wakCTB687xUq
         KtLj3+esY+auqAizThY3hhF4sQscwaqC2Ce0shGP/+drg4Kglbb4k657wlhHOB6XK2kd
         yXEw==
X-Forwarded-Encrypted: i=1; AJvYcCW5RWuibVptzVG8pmU2E4/GL+bI15aNr8OFR9aHCGdWo7zDTkV8LNPxymXuEIFOjDXvfVOgp4F5NLq+gZmP@vger.kernel.org, AJvYcCX3hH+IRmBj4VH7tvtR60vIxGSc0GlqUF9gv+oDy3GBE4F/8E6eeAZ6xoS+1LQVn+5YEihhxGn8RfCj@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg13pDkBl6MJM2U3eFsiAax/NQAAcA/dNx4oRatM1s5cCA/y4f
	MgPME/g47XOXznm23hAHVyJyOgxLo0G+oJgQHjp/8bCcvKDSdlPzfrt79dlTOWxyMrsNmHqjgbx
	vHuONjtozMddeKBSg8iD51qTw52M=
X-Google-Smtp-Source: AGHT+IFPzNA/ykyop8Pr9VmfZCzUea/dWGp/PCJjjDw1YLiQF+EUnfcDBl+zIVNWxL+YF7MTzG6Ojpszf6h87p4+fzg=
X-Received: by 2002:a5d:5f48:0:b0:37d:498a:a237 with SMTP id
 ffacd0b85a97d-381f171ccc1mr13389793f8f.8.1731404760474; Tue, 12 Nov 2024
 01:46:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111094349.2894060-1-peteryin.openbmc@gmail.com>
 <20241111094349.2894060-4-peteryin.openbmc@gmail.com> <434b2dab17050643badc60c50b361153631b7cdd.camel@codeconstruct.com.au>
In-Reply-To: <434b2dab17050643badc60c50b361153631b7cdd.camel@codeconstruct.com.au>
From: Peter Yin <peteryin.openbmc@gmail.com>
Date: Tue, 12 Nov 2024 17:45:49 +0800
Message-ID: <CAPSyxFRC-VBVs4xBFnkoBNx1jNjr+cJ_CztmgCpMzqtjYDCVbg@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] ARM: dts: aspeed: Harma: Revise GPIO line name
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 7:53=E2=80=AFAM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> Hi Peter,
>
> On Mon, 2024-11-11 at 17:43 +0800, Peter Yin wrote:
> >   Add:
> >     "ac-power-button",
> >     "asic0-card-type-detection0-n"
> >     "asic0-card-type-detection1-n"
> >     "asic0-card-type-detection2-n"
> >
> >     "cpu0-prochot-alert",
> >     "cpu0-thermtrip-alert",
> >
> >     "irq-uv-detect-alert",
> >     "irq-hsc-alert",
> >
> >     "uart-switch-button"
> >     "uart-switch-lsb"
> >     "uart-switch-msb"
> >
> >     "leakage-detect-alert",
> >
> >     "power-card-enable",
> >     "power-fault-n",
> >     "power-hsc-good",
> >     "power-chassis-good"
> >     "presence-post-card",
> >     "presence-cmm"
> >     "pvdd11-ocp-alert"
> >
> >     "reset-control-cmos-clear"
> >     "reset-cause-pcie",
> >     "reset-cause-platrst",
> >
> >     "P0_I3C_APML_ALERT_L",
>
> Rather than list the identifiers that are already contained in the
> patch, can you please discuss what functionality these identifiers
> enable, how different functions are related, and why this must all be
> done in one patch?
>
> >
> >   Rename:
> >     "power-cpu-good" to "host0-ready",
> >     "host-ready-n" to "post-end-n
>
> On the other-hand, explicitly calling out these changes is helpful, but
> please also discuss the motivation and impact.
>
> Andrew

Hi Andrew,
    Understood, I'll include comments in the next version. Harma will
be moving into the DVT2 stage,
and many of the new GPIO lines weren't defined in the POC stage, so
I'll add this to the one page.

Thanks,
Peter.

