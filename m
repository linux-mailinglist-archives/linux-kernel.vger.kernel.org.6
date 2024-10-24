Return-Path: <linux-kernel+bounces-380732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 923BB9AF548
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 00:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E2601F233CA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 22:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94274218312;
	Thu, 24 Oct 2024 22:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jGywH+U6"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87111FC7EB
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 22:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729808426; cv=none; b=gttMvFhyt70gjAV5X8TrbP5gm3tijFGMIJfp8f1/eZlf2oyFD49Peo4Sm5VT+T9C4bKSJi0LTe9d0qchU4oDcKO1e9kelfivoVasrnzkCm+a8MJtuO4VxMOGRByf4awmEd2W6luC7conEACIQvGkqGKocL81XtY3t1flX8kg2ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729808426; c=relaxed/simple;
	bh=gGEbKYgOX5rc8HvwKP+HLvbmqzBX4NlMnm5BCSkGUCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CbRptIVoh5Wo4VbFwtf2RUx6D+4BGRMQwyWGjEMqmjBgJ/OH6BaJWwzyeamaUvPFl4mqF0PAyAMsWl7eu+xzcm1wtfpTeJLQzlhJ4gVcs2qeJMxvhzi+1tB3gYoFA9hmGLGpIXBNIyH5vyh4BPHOnx8wGql31amqUIRecUGyeCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jGywH+U6; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53b1fbb8be5so1661504e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 15:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729808422; x=1730413222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGEbKYgOX5rc8HvwKP+HLvbmqzBX4NlMnm5BCSkGUCA=;
        b=jGywH+U6YalC/NBXj/R2UswQt5xBU7hBY5ftwdP6cmrhOKoV4TTOv8duyPRbWcUt12
         UgOjr1rVR40ime+C3tjM1cnYdOscEwOTUhMaMNHuN+tNm72Po8Svtx1BW2G3C7kzqWd4
         mI8cpHPxiFJ2Tv1DOiYTbGQ9oBOLnT+7wWfUp05cyOWOneEirq7CB/oVBdT32ei6+MwZ
         /9vnHB0C1jUZqjZniSLhQgbGDhm/eFpwJu+sD/U9Y/JyVc437vsT5mXXm2ymlhGhS0tL
         eLenliZsQU9zB6gTTdhUJqKhC6NUknk9/6pQ53w6tweFfjrw4z2tJlylVSPmBxrhxrFv
         F1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729808422; x=1730413222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGEbKYgOX5rc8HvwKP+HLvbmqzBX4NlMnm5BCSkGUCA=;
        b=Edl5RELqoELXZYCqy/nA2pbOEM3z8YnBn/BxAvTIb5PwBz5+ns1gBuzBExDlIRH4ks
         7CueuE3P58c3aDeA5Afjw7a6wmqcXBQTNXBQegD2lh1xiNxwDEgJ3rUC6qrlb/rviBMt
         0PeKcogYkJmVQzysjjq1mqZIGWy0EbFkQyueiZwdkf7yM9Ief6H9pGsluEvUeCKIislp
         7jAJYVJRscZuMOAjgj8rGYZ14jpPwL42d1YD5Bludc2l0PcUZ3QEVy1t5XyJob4U6BIM
         KD2LacTre7B4bYEEG8OP42InGmLiyvXyGGw2Li7rcQFMJVjb99ESu9IR1y/aTTzSv8CS
         nAog==
X-Forwarded-Encrypted: i=1; AJvYcCXkmKV2QyFu6Lf9cxQxbed0PPFGUakj8NMDyoSVUoWYYxYQQygih2wXy7Dap2HWtKGK5N7OHrMXCRyannY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwqvUZZCnKvSk6ojhMh7tbBJIR9ym2yEdiwJ9BkU4z1upjQ6wY
	sZ0hPOoVrl045TWU9XqDY3x8u0iHq0oWnb5SjnWKWyF7/gIrfbCk2IFvF3alndOm1c8Xs+oGYbL
	gp5v1rekxfDZ5MYZwSMQ2C3J9xA5RsFjVJxA9cg==
X-Google-Smtp-Source: AGHT+IHGIsrqaQ/7HUksQWKQu+JFY6k3cD9zvm7NsmQfaV2x40ET3jcwxFaCHaKIFyRB5Uq3hXr7QboUps1FaB+xBco=
X-Received: by 2002:a05:6512:110e:b0:539:fbba:db71 with SMTP id
 2adb3069b0e04-53b23752862mr1167501e87.26.1729808421764; Thu, 24 Oct 2024
 15:20:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022155658.1647350-1-antonio.borneo@foss.st.com>
In-Reply-To: <20241022155658.1647350-1-antonio.borneo@foss.st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 25 Oct 2024 00:20:10 +0200
Message-ID: <CACRpkdb=-gw0ryP1H+K9BQS_kUrQG9STLQMSrVWs8BZ=QejV5g@mail.gmail.com>
Subject: Re: [PATCH 00/14] pinctrl: stm32: Add new features and support for
 more SoC
To: Antonio Borneo <antonio.borneo@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>, 
	Stephane Danieau <stephane.danieau@foss.st.com>, 
	Amelie Delaunay <amelie.delaunay@foss.st.com>, Fabien Dessenne <fabien.dessenne@foss.st.com>, 
	Valentin Caron <valentin.caron@foss.st.com>, 
	Gatien Chevallier <gatien.chevallier@foss.st.com>, Cheick Traore <cheick.traore@foss.st.com>, 
	linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 5:59=E2=80=AFPM Antonio Borneo
<antonio.borneo@foss.st.com> wrote:

> This series introduces the support for the new SoC
> - STM32MP215,
> - STM32MP235,
>
> by adding the support for the new functionalities
> - irq affinity,
> - Resource Isolation Framework (RIF),
> - Reserved (RSVD) pinmux function,
> - IO synchronization parameters,
> - compile the driver as module.
>
> Some minor code reorganization is also introduced.

Overallt the code looks good to me (I see bindings are being discussed
and I might have some comment on that as well.)

I wonder if Maxime can look over the code as well? He's the only
STM32 maintainer who hasn't written any of the patches and I think
he knows the driver pretty well.

Yours,
Linus Walleij

