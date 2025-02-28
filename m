Return-Path: <linux-kernel+bounces-538027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F44AA493B8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 241C93A6F64
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382F52512C3;
	Fri, 28 Feb 2025 08:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ktlfyo5R"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF99A242907
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731928; cv=none; b=MwiOprCDIeJaWMSrXSjSs293QBxKqPYi/NzDTFCkHcjkcvyNChzBTbZsXA1oPE3Gh2Sz6+ixUYwR42DiMKOAofJnwlILR14NgMVqvCUmSuHwp1tRSUZWUG3x7+Hqd2UAErrQqk88cG7yjT1LlxzMSgBHFSK2XyhQhzPvl58z48U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731928; c=relaxed/simple;
	bh=A1hq1DB07dwQXcqWwcco9SDEwQn8DEialn3ZI9yG+nI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r//b7b1DbLYWPbiStb5xNa9TzS/Pg4XNOvBaKnw5JyLhKrnarEmtr78yJ4n+DRXIewnJGX/Rl7L3YNU7LoEdA0ytv61zK1zMl04HkiYT2hrulRmGFtPDMcajcHvayzXyRv97FwPQUsi+wNqKLx8ArdE+k0H+pRLtZhnhUIqUIAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ktlfyo5R; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30a2f240156so22019111fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 00:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740731925; x=1741336725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhQwmFqFnuuSHTQ4pAgL3POj8tqEsseUbiv1Ze3QwuU=;
        b=ktlfyo5Rezu/DwyRXtB+mouxaCxNdMiOvsPrFQiZ6MqUd8kl38loCYP8gZilR3av/9
         4orW/S5c6/3vJGv3xIkdfisMrmvsD5ezvh1wIfGla9GD4IxSJZ4nh0w9OT9Z2907Fpfu
         6oiM0lua77jpKFdrTWRsLmzJ+dCnPk7Kz+4bFFvePfWh468oY9almut+KlraH8Lwx+rA
         KwT45/3TRElrH8wbzNksnRDCIgwKw/hzAKjGWW3Oi/9fcPwkjEdIQ6Kj5zxbONafI7GB
         oeZyUjWwAqpV+eoagBIruEFbRlq/fqNqjkcPK2B1T1j7cRzY65Gc2xstHMbWJ0zO6Xes
         Xojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740731925; x=1741336725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhQwmFqFnuuSHTQ4pAgL3POj8tqEsseUbiv1Ze3QwuU=;
        b=IGJP1HoMG5VoScoyJbxkbdqyrqpCmPwjeUMK2EYzHnf0lUpCj6i+/2Ht4cS2aqY9re
         o+EtGJUQn7eKMJiglW4FkdBJmBvobrKSTavsHOXAWgjo9Xh3L2hJG9PDYWRteMKtxvE9
         ZKlZSSrX/caPOIOXAFN1R6rPYNzGiGpdQz5+pTtFDGdZnpahKEk7B2dA85UptPhkNz8V
         yKlJGfdovUz6cb5fdmI9j8QVWNjbqglp9u4hTJDqT+XCZWEqVHUdsSDCHWb1sgQQXOky
         gusKSa7uB37zjrMBgrFySmC9e4M8tilbQMl14ppch+v2Y+tKq/pR/n0V57k9TtK6iQcD
         EQRA==
X-Forwarded-Encrypted: i=1; AJvYcCXWTeJJTeCD/eUzmWcKOC/67mhYw3YoXAQQQfq6DAbnxJROYmZmVq+xfr3PjVkQFiN/EppDurXdtBTVWaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOUMPwVQKzwkc8jsgk7ADFqT0KOG4AMXpbo19mqGZ6IWQgJo5V
	rz5AZ4Rzy0H0p0BitDxZs4OMlhrC0Vk9ckyGFyxeT143DoGbxOib+AdyvlzwnEIeAOnvOIyaUHt
	aML58W6/5vBkNbn7i08PvErnM+Z+lgYiaCAy5dQ==
X-Gm-Gg: ASbGncub/l3ZuO+vUSjt/14FHy0ggNaIbktahM0tuUDpjWaZREcFJx/G1Xb/I8HCuHS
	NRE+lJHk77d6+e/wuELhAGnpjEEzVRGYq3j/VhjdV5heMSy7a2llRih2gVtX89TI4Cq/zB0pU8V
	2tvqgDg2s=
X-Google-Smtp-Source: AGHT+IGAeIIeJSXlZOyD09BfTdJNYrhaAtk2Dv0VSScJsFIn/A0Qltg4bWtfnluZesdEZ3LGCJeP/Y2geE3003qeeVo=
X-Received: by 2002:a2e:be03:0:b0:309:1d7b:f027 with SMTP id
 38308e7fff4ca-30b9320f37bmr8362171fa.9.1740731924837; Fri, 28 Feb 2025
 00:38:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217153249.5712-1-pshete@nvidia.com>
In-Reply-To: <20241217153249.5712-1-pshete@nvidia.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 28 Feb 2025 09:38:32 +0100
X-Gm-Features: AQ5f1JphGbre185SJnlbZEv6StWJ-0HLtZWYERPdgLdD9d15LkTt3vUooRToznI
Message-ID: <CACRpkdZGB=O_1ieN-RhFTVxsm6RWAcjO_JWvVBO8gLgUBZ4_CA@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl-tegra: Add config property GPIO mode
To: Prathamesh Shete <pshete@nvidia.com>
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, peng.fan@nxp.com, 
	linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prathamesh,

On Tue, Dec 17, 2024 at 4:33=E2=80=AFPM Prathamesh Shete <pshete@nvidia.com=
> wrote:

> The SFIO/GPIO select bit is a crucial part of Tegra's pin multiplexing
> system:
> - When set to 1, the pin operates in SFIO mode, controlled by the
>   pin's assigned special function.
> - When set to 0, the pin operates as a general-purpose GPIO.
>
> This SFIO/GPIO select bit that is set for a given pin is not displayed,
> adding the support to retrieve this information from the
> pinmux set for each pin.
>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>

Sorry for taking so long and losing track of this :(

Patch applied, I take it this is for getting the right info
in debugfs as Thierry says, and that's fine.

Yours,
Linus Walleij

