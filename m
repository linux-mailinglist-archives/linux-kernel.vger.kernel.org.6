Return-Path: <linux-kernel+bounces-347554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0650C98D47A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E461C219E4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA79D1D049C;
	Wed,  2 Oct 2024 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B499W58P"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAB51D0480
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 13:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875240; cv=none; b=TddWtu+t1R+ezpg3S8JDcig4flUX5VBm8O0ntUS5V9S2M1s8IBRacOh7JRgNHVZojRmdykYfspForMG28cH9Z7JiG2UIg9j/sXPJYgPASPd2JDphSd9HGCXFSRYZVmGndyJzEMcsFJKL2C8zA1C89PQcfaLPyS/sU9z0zHKDU9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875240; c=relaxed/simple;
	bh=LKLmKgBeEsOhEbbI+yF44RBUXhPJBUhhrepWasj3bJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mm5AF0CIm+V8t+wO5mkc1DcoFUPicBvIiJ9ctVGSiWdbZiqUPCXkMYKqlweEm95CXfZSiuk5gni2SSxqE2cxbc0H5iXbgnSl+NroVtGTH8hDy0IsPEBPLro5WZOrSeeCubiFqi1Cdo4t5HyyS9jXB2RAyxnUJ0WnQvC/yKYi2tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B499W58P; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e26290a13d5so2526915276.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 06:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727875237; x=1728480037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKLmKgBeEsOhEbbI+yF44RBUXhPJBUhhrepWasj3bJE=;
        b=B499W58PeWCWGgEoLljJnKiEjz96jlr1MvyIaZOSQvA32/ojYRf36NZ9ubjNBEmcIl
         Cjql4oNmgKv5W+OH8za4ZSK4bYeD5Uhg6e+uuAGmLxW0CkjKnZvX1Rtyu+/Fn0RDrupJ
         jeg02Qk3AECpqnMn3Fgp+hB6WG25cJoTa0+fAzUXP0Ft2YU79EVeuD33LhYwIoyDlCKO
         H0+ECArBTf5xzVFAUqptSA7xO295f7kO1e23hHCDCekqtCPAWJ8kCZ5bNR07xn3A5vMb
         e/rgEnig45AGbIIm0LbpkWk4yPDJgO4rearqER4bd/lll5gNe8y6cTYtX3LDEii7Tuv4
         fsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727875237; x=1728480037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKLmKgBeEsOhEbbI+yF44RBUXhPJBUhhrepWasj3bJE=;
        b=kCDolQr6uI9u57qUWUgPUcI33SFLILsuMqvAuCvQ49rRramzq8V1atb8VZ2cDDOC8y
         saxnHLeGbv6+NOPvhZizLrjHtBvJFHt7VlU325fbAQ4gGyIDsuYtuTqijtON4eEpjMTl
         kVMFeNWN/HAEgJglQO8iihPfF3Y5mYDM47HnMUCFiAjoUH0v1G9crMrdEPs9g58GTttW
         HqkaitwoTD/DcWV8ITRr7kYVWQjyLbyLW7Ath0y4Fz+DWLwigzZEWmyZcoa4vWXZsKWM
         avV/VVznxp8+6O5do6fhNnGnUl9chQs5Rc8u2advnRAX6wpRnDz/rFkedRcuNUXc9BlV
         8WyA==
X-Forwarded-Encrypted: i=1; AJvYcCVXTKN6SDOpMO/rz4w393TRHauuzvWKz4xVsKb9b87G2RmwGu6wt4G6xNgRW9rMeavr8XmILlr9cLwcSww=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBcpnGD2qfEVSCcH415S4u71C4vtYIUsWP03BJiCxSogVZocuU
	mdH/xST3SiOqo+OgOD+hQ4aMdQq0whpJEpW658KXMr5Jue2OssoPydo5Wir9HUlJeCUBLddMYBR
	5YSLFbhtZfMU3iBFg2TwlnIFhA7Do+qHq9UTlWg==
X-Google-Smtp-Source: AGHT+IFYH3REGo48+Y/fX4gu188AKxY9QApKlczmFVXC9j8AP4zqDdguIRuAvaEXvNk65bYYP0wTWILjBGoh4oX3wwE=
X-Received: by 2002:a05:6902:908:b0:e11:7250:4f9e with SMTP id
 3f1490d57ef6-e263843c9cemr2816091276.54.1727875235922; Wed, 02 Oct 2024
 06:20:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930144804.75068-1-brgl@bgdev.pl> <20240930144804.75068-3-brgl@bgdev.pl>
In-Reply-To: <20240930144804.75068-3-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 Oct 2024 15:20:17 +0200
Message-ID: <CACRpkdYt6iA7d0gthm2zc4JZONQ1sg_Y0-7M6=rthXzo1s+MyA@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpio: xilinx: use generic device properties
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, Srinivas Neeli <srinivas.neeli@amd.com>, 
	Michal Simek <michal.simek@amd.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 4:48=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> OF-specific routines should not be used unless necessary. Generic device
> properties are preferred so switch to using them in the driver code.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

