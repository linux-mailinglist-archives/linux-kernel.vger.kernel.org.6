Return-Path: <linux-kernel+bounces-425435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6553D9DC205
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29D4D2827D5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682F2156C72;
	Fri, 29 Nov 2024 10:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B0XRLVeq"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF89158538
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 10:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732875436; cv=none; b=Z6yY+RmptzdQ2QUXMwBIeYQiHbOd7RFISmMTpXR2SLtVhq7ccHIYS4EB1GGzISNhUW2yBwVySqiZmf2u8XEvJLiD4pvzAAuRqGzeNRwqTBRL5u5atdU8z+xxX9pBnyXorsA63W/gl8uSLLHBktr7qYs8o2J4cYpkVvh17m/ny1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732875436; c=relaxed/simple;
	bh=M71k6fppN6xV463i5xMitlihv2EHMbPQd8qlsiqHBYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ue2RURSrg9PyvRMK7ULcpbLlfVvNBxOIHBKbfL22say6p05jrCZcne063MpkhwyHeIsxbDleH5IGdvOZRtcaA0A3JPYFAoE0o/w6qMy9STUYiBXy55qX0vIMYkxij5u9mGcSWSBYuKTAms3MPtHlr9DRS+0sQ2ZCQKFoBwPGQQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B0XRLVeq; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ffb5b131d0so16212731fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 02:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732875433; x=1733480233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M71k6fppN6xV463i5xMitlihv2EHMbPQd8qlsiqHBYg=;
        b=B0XRLVequSnqWRjkWtcLtPf1NdDFbNIWNT/55UQ/mER/7wt2cGSVQfpPGop3zCqyCy
         TMKxx7U7EUordvMkq8zPHiW3lUmGHc2qWOT/DVLOl/5SNQ+j4INfT/TPKSJIEn8zQitp
         azgcRHscyizQBPsXmqb9f8lHWGo2UKtUuJLwLOer5cn67PO+7oTS8pPiFhFs8TeCP1tk
         +vTmjphQbUuGJsml6P1LBDwpCFTwj4Nq0T8+P3di1jFYZRTUKmtGUnFAgHmimk8G9IdI
         HY0ptc45dQAFS8iff/KAHNqfJZYycuIpV7HMg7LSIcz75sckk4dDzceV100N0ewo/qio
         1znQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732875433; x=1733480233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M71k6fppN6xV463i5xMitlihv2EHMbPQd8qlsiqHBYg=;
        b=Xfo1Zxwurdgt/j0Dxj0RG5ySi0J9oWz9qgYg8ETWkna81DSUUWaQRAt0LuTQU8CXwV
         lXOoCb1Jq1XhfTtCZryzCdEF7jlqLaDzezOfwWOuUhryh9iwYqQAReEbBbbsvVw72UqI
         Knz2Av5+Q2rF4tyYG32pwLqiQc4Ro8bw3AuafvGt5D8v0DLgdBLPS8X8RFY+9JuVCZfp
         zebptnD17MfObV9uzZhY3ZBvURc9/1ozDswNDYKkG9xk+Uh1j0UZ2uP/+sDW8408hgyE
         v8/l7CQThipacbR2RIVsI2U0IJG6x3Pj/InqHMOOYoeJXX8WwSzz/9C5/9fyKAR+vxK+
         T88A==
X-Forwarded-Encrypted: i=1; AJvYcCUCn0jOfxPBojgNfcmzk/kPZknYiFcQcKUDIOzenXIAZWIclZn66I5IedBt68OeDc9T73MKwqUN0EUbhN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGihxhQ+oqF+U6OWFr0ygB/cB1xasJ0zfTKtD93nineeXGOrTt
	HiHVamHC+BPU5TKY2Lnr3q7V7v9zW8TiF39VsY73ab0IEqjdnAdBOHaGpStBbbn4WBdSuq0ZinN
	7g7URV6xEc76o4f04ejXwAXbKfHFGWsrp3kpI3w==
X-Gm-Gg: ASbGncsOOlV+5K9T7JwdaoN0vrJjiOH/01XJmuwuDDEhTKR80l7YWL8JW0BTT4tKAjD
	lrQMxP79w4fCCCof/OB7wHq9qgh0lNJ0=
X-Google-Smtp-Source: AGHT+IHsgFbzClrBYfEFLufjcHJSY9BVx1yMAHpzLueAWoM1d4Mtai5958T8vHB4BDFRgLnlbKD/8tkWebNyM9HrsEE=
X-Received: by 2002:a05:6512:3d88:b0:53d:ed6d:71cc with SMTP id
 2adb3069b0e04-53df00c645cmr3259605e87.8.1732875433264; Fri, 29 Nov 2024
 02:17:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126172240.6044-1-raag.jadav@intel.com>
In-Reply-To: <20241126172240.6044-1-raag.jadav@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 29 Nov 2024 11:17:02 +0100
Message-ID: <CACRpkdZqdE8gQCre=zR2cN17oKfwBSnWuVwzQsbRO7-ENVnPNg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Introduce devm_kmemdup_array() helper
To: Raag Jadav <raag.jadav@intel.com>
Cc: gregkh@linuxfoundation.org, mika.westerberg@linux.intel.com, 
	andriy.shevchenko@linux.intel.com, dmitry.torokhov@gmail.com, 
	broonie@kernel.org, pierre-louis.bossart@linux.dev, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 6:22=E2=80=AFPM Raag Jadav <raag.jadav@intel.com> w=
rote:

> This series introduces a more robust and cleaner devm_kmemdup_array()
> helper and uses it across drivers.

For the series:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

It seems like Andy will push it to me which is excellent.

Yours,
Linus Walleij

