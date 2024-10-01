Return-Path: <linux-kernel+bounces-346100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F19E198BF95
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E521F24742
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D621CBEBE;
	Tue,  1 Oct 2024 14:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ci2pfD2u"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA751CC142
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 14:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727792042; cv=none; b=DNAIvUL/VDAyr1ZUBzLFELRB/21EiNFRgXYfOzxFk6X14SjFm4zHBudTUaEk0+rWI95jL72NNKOvG2U3wpkZDlXTGVEmNuGetQhz51eVjx9z/HBtDcJ/udvRcf5mUteFyIBohhtXPgCgUNpg2KBEinsKj/u3J1lkzEFCqJZFEAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727792042; c=relaxed/simple;
	bh=c9k27wF4HRgpLueBG4Pf2APtXo6yuM+OkrBzV15ubFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pDbVvb8S3m2p9TG01Dgv0yGEzrFg7p0tdqft6Ue4nbAHPY/1puL5nFnPm0rmuqMqoqk3ntFo2Yhc/BPOd2XuSzW/gGiNCtU1pNOS98FFhcUDGaVHCWEw0TxGZqNbdIB7i8eB3QdFOVBZtC2q/yuz94DtUwSVK9XcMAnw+A/EQeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ci2pfD2u; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5398b589032so4954609e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 07:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727792039; x=1728396839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bsrbSdX6EPWFR3XqD525RkRXnDDB9V77qUREJTrLp8=;
        b=Ci2pfD2u8q7SAnZGrqRyOV7JMcWMA6pjrixXJIiRKbVjERfUu249QJV4zn0gU2dEP6
         VRUDrKAP3kPYFxV1tROSVYcekOw5tQeInWHXxkbYZzr0ZY4vOK6UbG6nHOOdnNQHB+r/
         sN/1D/2OmiIPyG3PVyHVbDDMyhcVlGu5cMl5PRdRy+6Xvy7Iz3lZsfikv7fIiEXsRBus
         t76l2WFJygiJxa8fJP5+KDt9qsOEek9TictIftOov9VXqE5qM49EfXWrGHCaLeumnraS
         37eMeLOdEqP8eOsIa0NTEGAYkHVGgvBV/hK464iFdwPgPBmW5pvxRgf0jqpcjlkSzCi5
         vFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727792039; x=1728396839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bsrbSdX6EPWFR3XqD525RkRXnDDB9V77qUREJTrLp8=;
        b=tAiFbZLFoVjM/sswxnJv6+FME81gsCRJYSTX95oi32eYOweeOTXCfxlYzwCSYYbXQk
         o1rM+dMSV/1VEmM2SuWdN2GHhPZE7AKiRP+j/qo5k/eS6FSzDGczbn2XXA9NQ7xgEuhQ
         /FUYsOKMgLVbFmGo24+ptWNQddab0UesAo3N4xehtnqkr00iLhg5/lpZ2mZFb9KSxOxk
         X8Kb2Qd/aa3tyOKJ2JIk2aOesOM8C2jGdqQh4rVxZj/hIOcMgZsFJ9xMU9N4EoBPdt9a
         F7mh/xNTl+k8bopFiygkwGtVqVfM2CE44lWY/Lwcvvg4Ce8RijBEvOxHfYT2aX9f5xjQ
         QxAg==
X-Forwarded-Encrypted: i=1; AJvYcCW66ervUFPc5yuFXpfe4WzLhItOni+Q7G2YsZd3BpgqsrnpOQzn1HHJn/97DD/Ctghe53THn1EBPWhDEXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+iH2jo4pI8oGsS2NJv6I7M+OW0RarmMloKud7JPUxqwjEOVw/
	/5xoxXFcQx0YdM9cK2UYZUHbL0R8tM2lXNbZPmZIXvAdvhXIKM87aL4zHIVxT9h9gULMGVqRbMS
	0Bd42ATxvJ8yzdmerXFtcxe56dL3/+2E5SFh8eA==
X-Google-Smtp-Source: AGHT+IH6ZblbuHzeWYNgj0qMbKQe6HIgMe33csaXGbHVMylssdfO2oRVeVcy6SqujgFdACrOi05i6ciessxhYK0oDP0=
X-Received: by 2002:a05:6512:108d:b0:533:407f:5cbd with SMTP id
 2adb3069b0e04-5389fc3445emr12362507e87.7.1727792038590; Tue, 01 Oct 2024
 07:13:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240928-gpio_device_for_each_child_node_scoped-v1-0-c20eff315f4f@gmail.com>
 <20240928-gpio_device_for_each_child_node_scoped-v1-1-c20eff315f4f@gmail.com>
In-Reply-To: <20240928-gpio_device_for_each_child_node_scoped-v1-1-c20eff315f4f@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 1 Oct 2024 16:13:46 +0200
Message-ID: <CACRpkdb+C5u4cQ0EapgXTzuwL-9CE2MrimRd11U3O8c6vajjNQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] gpio: dwapb: switch to device_for_each_child_node_scoped()
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Hoan Tran <hoan@os.amperecomputing.com>, Serge Semin <fancer.lancer@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 28, 2024 at 9:47=E2=80=AFPM Javier Carrasco
<javier.carrasco.cruz@gmail.com> wrote:

> Switch to device_for_each_child_node_scoped() to simplify the code by
> removing the need for a  call to fwnode_handle_put() in the error path.
>
> This also prevents possible memory leaks if new error paths are added
> without the required call to fwnode_handle_put().
>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Neat.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

