Return-Path: <linux-kernel+bounces-377820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1749AC740
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C265283552
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012D01990D2;
	Wed, 23 Oct 2024 10:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CrWmZRGm"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5141158D94
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 10:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729677663; cv=none; b=s7K0QBhW6V7WK4ksrBC/p8x4fXftem6jf4Eh+JrD55qlWQ9lcTvZa/VFmCGruLeKR4YzZSEGQ8EA6A85SxxAPeysT7Rmgv9QU+Ozym5kpkZQ8Jf9g7z7DDdgOsa7teYcBs2tdoIAQ09pkZFnZHTPidlr4SUTx5jkU8otKdcGvTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729677663; c=relaxed/simple;
	bh=ZUGc29XkalHds14dCBS9QzTZFbVomRvEcXD27v6fsGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/W3DqqpGLHFYGRtqJhC0+KZL2NcrHtHjL1vvAyZGz6L+muJqezZuziH0Ymb64ATMEqWwxR2ZfNszleYZ87V4McecQH+SN19U2TY2xs9aTA+H9YXxyG+ivVRRXtPj9yvqb1IE0oaAjQfF0A77v/NYEAbQHQ3MdoZ+bwmerPcE7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CrWmZRGm; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso101168941fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 03:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729677660; x=1730282460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AVT/oXvnz327r71R8h8SLtTXDuNUikJe/baXxzlt7M=;
        b=CrWmZRGmVyhljKolnf1UewFXPdO4kYq6II1J4PCFj1zk2WPmxDIqhJD1XnAExw27sB
         uB/o5hwtonzx0/wRijgWwGcgCpenXIQO2AD/i93m+qJ/jIWYuIYPYjphC2TCRbQKONGW
         8TyT/uYR2KovKhIjaBQYB+qfqpotOz+38kMAhYmnDH0Kqv49RDVQvOu1OXkrIuVNu1Gw
         5shpJos4LxmNP0mkuZU2sXd+pHVqcFcBBBiQIRjHw6TwtMkMCYyTOnY54ElY/p7qPuHK
         7dnJJ36xubGyB3NDDy3b/Fi0hC2r9jx+Mq3PjmLe3Szg9hZB2eon7P/VgOLfY75XW9Tf
         zsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729677660; x=1730282460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1AVT/oXvnz327r71R8h8SLtTXDuNUikJe/baXxzlt7M=;
        b=hHAaml0jwJOOSccA+PF7WIIJXGJSpPOigTPGPad0mpHeYZXbT3XVia2YWdILwVJc8W
         54GM4IGJjKzgEfqrcFZjTE9ChaYZR1y4ca4Jt5j0Zj7CgvyAlOvij7HLxY5KBdh5bfw+
         YtQwYXRrumjtGliF6wDdiTgA5SQxZlerazY50qh6aZZtMM5qhe2C3n/RC211XW0wLEhw
         d9Au0zJZqS7OclVuI8s35GIZGxyhAmHL31E/7qSz9MMArt91kzpyzEIQgRCOTCXSaK5J
         Lz1/EdVeLpFm038Rpxq/8c+zF8QbMwcMGU85s9hwKhI8fWEoYY02TxtmT9ogC0w6MwMC
         eJwA==
X-Forwarded-Encrypted: i=1; AJvYcCVE8iwWPOqkQP+4VfOJWwXxM6wItij044rEyMqAGZIV4pADNBz8QJ+hLP6iBuFUmgJRYL1o6sxrCMwm5kE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFJlCLemJJjJ0MrKIDVmW5kchqjuZ1Msdc3HcFBUentOR+uNdo
	vJynMiwrtvRUDq8WH43W1xn+SVOlj2rr6vKwQpD8ESn+hFdCR9KmQLRhFw6ZMDznUCIxbibXTDI
	DhH4Z5IWgCgEPeBdSlwCvrpPM+XSUluoBEUlIOA==
X-Google-Smtp-Source: AGHT+IHE0gsgDLAMHvDGbxM6ahyc/2CXAluj9jyUvAlvq5X0bwerV4oeMKszRONGYK1KtMvqz8Bpm1IOjWxZhoK3CgU=
X-Received: by 2002:a2e:d12:0:b0:2fb:357a:be4d with SMTP id
 38308e7fff4ca-2fc9d588b91mr13043511fa.43.1729677659658; Wed, 23 Oct 2024
 03:00:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014192930.1539673-1-quic_mojha@quicinc.com>
In-Reply-To: <20241014192930.1539673-1-quic_mojha@quicinc.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 23 Oct 2024 12:00:48 +0200
Message-ID: <CACRpkdaAVE8VMNCFA4jQ1+YLuC9=4mc9Bp2PRxeNFQoHB+NJrA@mail.gmail.com>
Subject: Re: [PATCH v3] pinmux: Use sequential access to access desc->pinmux data
To: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mukesh,

On Mon, Oct 14, 2024 at 9:29=E2=80=AFPM Mukesh Ojha <quic_mojha@quicinc.com=
> wrote:

> When two client of the same gpio call pinctrl_select_state() for the
> same functionality, we are seeing NULL pointer issue while accessing
> desc->mux_owner.
>
> Let's say two processes A, B executing in pin_request() for the same pin
> and process A updates the desc->mux_usecount but not yet updated the
> desc->mux_owner while process B see the desc->mux_usecount which got
> updated by A path and further executes strcmp and while accessing
> desc->mux_owner it crashes with NULL pointer.
>
> Serialize the access to mux related setting with a mutex lock.
>
>         cpu0 (process A)                        cpu1(process B)
>
> pinctrl_select_state() {                  pinctrl_select_state() {
>   pin_request() {                               pin_request() {
>   ...
>                                                  ....
>     } else {
>          desc->mux_usecount++;
>                                                 desc->mux_usecount && str=
cmp(desc->mux_owner, owner)) {
>
>          if (desc->mux_usecount > 1)
>                return 0;
>          desc->mux_owner =3D owner;
>
>   }                                             }
>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>

Sorry for taking so long!

I was turning the patch over in my head for the fear that something will
regress but I can only conclude that we need to test this in-tree, so
patch applied so we can get some rotation and boot tests in linux-next!

Yours,
Linus Walleij

