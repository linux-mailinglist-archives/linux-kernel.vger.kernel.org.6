Return-Path: <linux-kernel+bounces-400039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CE79C081A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F2D7B222A3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6649621262F;
	Thu,  7 Nov 2024 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dWYuPazp"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF70212D0E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987478; cv=none; b=GDtby06zDp9mEYT9kufzvrNlT5Yp55plfqhTDf95wV8Qyf31UvVQftTY2kpyrXW4tj5eVA50qeZf2RvOUXo5Rig3cxGvBYyd7MExUyDIl1nZeaeCzgad36q99f1QLVMrSybj4u+T66bVBuyTqd1d00t+wonx4wlkQMnbaBJB1Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987478; c=relaxed/simple;
	bh=NcVjILp/caZepFFB60+3XLNmk+XNW05BoJNj51Dg95o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b6BXCPnnVrH2eM7r2LWSu11zKOM01qtDglPuBeqKqihnSgzFRG1vYUgoPeWIcr+Z3Bso8SYraO48iu5CgTJ7kg7lIql4zWXbTCChtfBmz3cUnfAUFC6+Hdt5BmndU5MMPlFS7NP5WnoZ/c++YHeiZX5gZ0lpivMWsKPUQZHZCIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dWYuPazp; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb5a9c7420so8995381fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 05:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730987474; x=1731592274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NcVjILp/caZepFFB60+3XLNmk+XNW05BoJNj51Dg95o=;
        b=dWYuPazp9WM/9vSSOM4D3EsSjWlJhI0SMs7FoOP5jm9yR4CWngxyCWOwYzy7RcP+X0
         QUipNMMuUFOq73NTu7IrUOa9gXvShW91Y99VNupmDZ6GX0DCRGUA6F6H4iIClU+soubf
         B+tJYfjToPeIvtqaoETJuO2xOQl6vaVxFtbwnrpwJo5lSTcmimu6F1zJRmDn+521mJUY
         A1KxpZ3A860jwm5j0ZzE3OlDlftdswJfEUTU6cpwOolZbhujR0GBMiStNEYXNCPPX7Ok
         K4IMqkSCOUTGwoWvayYcX0c1CUsKNYjO/ekW55yY9HLT1jb9XkSo0gRGjzr5LfzEogAF
         2fvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730987474; x=1731592274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcVjILp/caZepFFB60+3XLNmk+XNW05BoJNj51Dg95o=;
        b=PuOQB9b67FgNCMSp5PodRqD28OZN90j0Y6Of0xRulrKfQUwryDg72Fk1yBuAPfZ/KT
         7m+TA4A8UMQiqBSZ2cKMxZsMyh+Mqy7xMTfRV3VaCxl+5YKyHMf//ehctnbyxlYq29H2
         P0PlcutLYoOj44xT4HK4yci9YewasP5zpV+R2LSjqSY3OccQ+taHE/fnR2qj5+B0iA/K
         aN/N7SGLs76SF2Zv0DpNkBM6A/cQ6lsYnLY6ENLtC9CH7t7VgVQt+fvMo2E7ocrLZc7c
         CBo1QbqNTeiYHV8M6pQIAQicOpanaQq1urLVZdf8EDW70i3Kk3dSzvdlOWNlCRkIg+tF
         wr+g==
X-Forwarded-Encrypted: i=1; AJvYcCXLvH3dYrumHnBvw9knMAWlZffL5Vtphj0MjUVR+Vf3Kc5rvFxG+CSfhgwvwQFjAwrjrJgU6lwCvSlGNno=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaWXa7iEloDHLCM2um5NMYbvqPzxblpiH9FWHQCG3JJ+ebmiXm
	Tc+jf1ufr2lbDSPhP+oY3to1UXea+N80mzXB1I86VXS1tHfSCcwmCI4QOvESPvIZ/3dHDl7FpJ3
	7TiiUUEAR1RIdTngiVZN2jp9jPh1g0Ije5dBYAw==
X-Google-Smtp-Source: AGHT+IGiWq7PtiVgzCFFWXw5DpnT7owotNtkDOgrZOKmEF+j8eLRrqW6X8/sDWUO8xLANvzfCAOHbn0yaa5j804ukJc=
X-Received: by 2002:a05:651c:1596:b0:2fc:ba7a:c97a with SMTP id
 38308e7fff4ca-2fedb83155emr127846251fa.39.1730987473829; Thu, 07 Nov 2024
 05:51:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014-armv7-cacheinfo-v2-0-38ab76d2b7fa@linaro.org> <20241014-armv7-cacheinfo-v2-1-38ab76d2b7fa@linaro.org>
In-Reply-To: <20241014-armv7-cacheinfo-v2-1-38ab76d2b7fa@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 7 Nov 2024 14:51:02 +0100
Message-ID: <CACRpkdZ8--4fKxT6+AbYSvTbA7-7EM_HutNVPT7yS90NN1r5nw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ARM: add CLIDR accessor functions
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 3:55=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:

> Add functions to read the CLIDR, Cache Level ID Register.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

