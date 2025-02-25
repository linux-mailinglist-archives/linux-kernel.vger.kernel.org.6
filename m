Return-Path: <linux-kernel+bounces-531744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACC5A44460
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46AEC3BC221
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A533326E634;
	Tue, 25 Feb 2025 15:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dSYmaP9Y"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8EC26BD8A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497267; cv=none; b=nZiUQ5xXGDEGvnIoQJXCU8irGdIExlRhQJdy3pMCC42jX7FtbDLzLg5ciV35iqvMTpxLF+JXb3F9Mnzhe7P1QhXVRp/G7+bP0c0OPs3GN05fwIaOwiVyXOuuUWCqDTabti/ONoN+XJGEeiYO4dV5XV0ftwdqsBWDaRtDDavuWlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497267; c=relaxed/simple;
	bh=7S0+Zh7bx00KedsQeG+Vi+B61V2GRVFmBCadrSzhX3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jSugUZ1tTP2t5oYpF4DTecqBaOiDOjgZMz/2aer4RfTNMwlOHxWAYeVyeyODUMSOREX2DKe2eru1lSRo7GVLcQmIKkXyfygO9TorJ4+dXM6EJBxK6NGDcAQVANCI/c/0EDpabDu6BO1bsIHG70Moz7RvXSFBCv5csnYFDeKqrz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dSYmaP9Y; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-548409cd2a8so4027925e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740497263; x=1741102063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7S0+Zh7bx00KedsQeG+Vi+B61V2GRVFmBCadrSzhX3s=;
        b=dSYmaP9YWad+LzNZDn18QkcctWuSJ6F0/bh61H3UgmObOGxy1Kat7E9UGvyGH1pCFk
         8acntJYeuQ7LUak08BFvyqfwsu0rIUjGP+PRCNoO5K1AgxbZ6h3/fKWzgnMsC8urh21L
         ffDfvut5fpvI7RB8AMJI8ZXQpnr2OM72mnGzUa5JEToriOTx2NXeFSMKrY4C5bDh6ldm
         bYvLLF0QQGtT+TJaYxkCzyvnYaYBk5JrIFXyRt1j3BtAAS02m8INNouLqy+nBBRbRzgK
         CX7khHqrYqCVgu4S9z/oPL/GyTOGE1U87layRiGbXT6ZV/LxfeQaXTGVT5p9HMQgndyO
         HIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740497263; x=1741102063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7S0+Zh7bx00KedsQeG+Vi+B61V2GRVFmBCadrSzhX3s=;
        b=dewgcRM+WVMFRAaaL/6F+qjyClhY/0YkdScl8RSoyzYI8ni20ktfnFqzGAQmGDMOTL
         fl3k41jE2fU/x7FHAep8yhsUk+m6tmSlNPerIqHUSareJbDHITaGZRIu8a/CUaqjlb2c
         MxtnSd+zpr3pHCrBvunpFIYvIVOsXC2eJS0uke8kLEBg0auJujYgWQsjCVlz/6bpU+1A
         vrHyfRsYVgZnCYXg18LszDo16z6yClXZKSYwhtYEq6NxcjyzXjkeqralNV/25F34pfGI
         HWGom35ebRZ6ov7oRR1LYeHNH6pP+6vhfebSdvGjKJEH69CoTv92c9bxLl55c6hQOvuh
         VAhQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5Jptii7TQShZWamVjMPRxO+khjz6hYrb2auBPQQwjOTkdluspwHTa30AiHiXGhtL2LMWPuunH9axIqEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Hv5f+5EVd/fd1DjRH83epAERGHKx1RdoVheQDy33ycLFC78S
	u4SSO2ul1L93mjuvwOZj7jF8FS+vnV7Y9rygebpIOk209Xg120q3OMtrX7PAXGNVDRqtv7E0qqv
	kl2Ar9QrYkXw90yaMSbkUfVJPxK6Tziid15ShSQ==
X-Gm-Gg: ASbGnctR23hpMbcTUENezJepZO4rJnOoEhvVmotjYYubkOo8xBn2qf1YkcAMVqVMOR7
	NYqxgKun0JY2TGOiJOQWGD78pauT5OmyBggxisPHvl9KkkvmUioKoA3HH5W+mLIR7TFRCGi9Ojn
	4/yUVzDks=
X-Google-Smtp-Source: AGHT+IFgTJGE+RjBrEO8OC8TeDJzFMHUlzAIhSFbfMnj8/Q8uFWtMIjrMUGLsz+zRCyCJyT9lKeUrhXtO4KqUE8JmSg=
X-Received: by 2002:a05:6512:a93:b0:546:2f7a:38b9 with SMTP id
 2adb3069b0e04-548510ce891mr1958352e87.3.1740497263319; Tue, 25 Feb 2025
 07:27:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220180427.3382482-1-vincenzo.frascino@arm.com> <20250220180427.3382482-4-vincenzo.frascino@arm.com>
In-Reply-To: <20250220180427.3382482-4-vincenzo.frascino@arm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 16:27:31 +0100
X-Gm-Features: AWEUYZlv7NPRpHplJoYHtLorhg9CL7rEI01TWd7nd5BSlHowCiDOAXdzpMqpzHs
Message-ID: <CACRpkdY8TdiDyZU7Wye=hj5csC=8HKBghPwFxggrhc=7nbwtnQ@mail.gmail.com>
Subject: Re: [PATCH v6 03/10] dt-bindings: arm: Add Morello fvp compatibility
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Jessica Clarke <jrtc27@jrtc27.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 7:04=E2=80=AFPM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:

> Add compatibility to Arm Morello Fixed Virtual Platform.
>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>


Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

