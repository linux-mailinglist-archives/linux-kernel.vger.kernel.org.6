Return-Path: <linux-kernel+bounces-206729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 959D1900D15
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464FF1F23114
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576AE153BF6;
	Fri,  7 Jun 2024 20:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hCpc/3j3"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1695479DC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 20:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717792697; cv=none; b=aYhHHU3LHBubfIZr8l3Nwf8/bjaFueWcxnQhYc9eUILSpMykL3daJx1jXQKYsrNyFsPpwAOJ1FgtdTkxW87Jvex2Eki9G3N9zd838IM8alj1CCLg0va6j/cWN2eLHTMl4Bypkuh9bAFGNTE3OU5nyF7CNWDAi8eWBXrhkYkSU9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717792697; c=relaxed/simple;
	bh=aPBnfdpHuugcMMux2VsK2N47w1DvhnhhGjc/ykm5Dm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OOTp6uhNYP9L+pep7HYE+LDUlyKcW+IpPW7tTmSl1AtODM4i2HcLHqvOkzr6bOM0+iAYD++xDkHE9CCTZrgWtVbycgedmWP1B6iby5WREPnSIPbeedZAPlISdFD/zp/JFIx4Ad6E3l1Ft0KMiPzMxZSHZnCVqw5JK3K9PjO8cik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hCpc/3j3; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52962423ed8so3001907e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 13:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717792694; x=1718397494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPBnfdpHuugcMMux2VsK2N47w1DvhnhhGjc/ykm5Dm0=;
        b=hCpc/3j3Y81tXVqst8WPs+LcBwL2QEj0oqdkQgRLKAOOAxF+VN3N1kX28IYEkMJsV5
         lYIvpasSfJJ3t1WwntNdvoR2V0wxm2teZTC1OL4mydNGpQrhtsloMdSiot1K1TqmI10f
         hHTDRRKTFc0jOkHSrzfY8BPWI69q/GJzlSTCu2HNDG0dNr2lzRp+Y/0xhnCRXovltZum
         pWsxSj5EmEcAmKLGQ6eMoznltC6xsFL4UVViv0zL+wVRAn7l6AphRgWzVdu/Rab/ER7G
         hwwxYmqTo0b3EaMPqMeqSNZEUkYb3DoJggCHnLJqN551hp4Sh72riaBVTAHKkcQKOm98
         wvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717792694; x=1718397494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aPBnfdpHuugcMMux2VsK2N47w1DvhnhhGjc/ykm5Dm0=;
        b=OD9/rY825swl+O2zq/ZhNw3c7qsuWiKJTSMyhfhzV91F+KmebKZ2wRzf5NZ/Ai2gWt
         xUCbkr3hfXBRtzcPMlLmPeeuQYJWFEZz1QbrVsVvkXd2VWoQSzeEjQ4d845S8aP/AQzz
         iTBvMJtw746+STtllDSQpIHMBunoiuyZwSvf1MApTVtMdPXVxg541ckwCf5TqqHakW4I
         hNFf7j/mTivJCI/Zbrz21Qv//uQTIJ/GQfSr/xPAeNNddoyEgjkZHWmmbPATzwm9MblA
         mrnE4j3rzD2ynSYojmbatU5TbRnh7LRgh/g4B/7KJB1ZNWKzbFH1veH07um8Cd+D0Xmh
         WT/w==
X-Forwarded-Encrypted: i=1; AJvYcCXRm/vVxFejUH75jHAnLyHRvS8ZcpNAhTRLba7MY2ylYxS1aILZAbOJf+xeHunF8SNCc7Ovt8+5SVADrDErtMw1ACCg7VY20hwPxBcK
X-Gm-Message-State: AOJu0YzpjWnpu3DMZPjHE8BUv8B9q1hGyuGj4TP9eOJSq3m0FV/r6Ygm
	6F/g/NOJeC1P0xTNr1zcco5ebrP3lrkrwJ6JB8JL1lgzpGa8lSesZj2PlzOaMTpAW85bltQjTP8
	kVKhRcJ8njrqPjHzDVLSSIZ98vZWnqtw2NBLsfM47zrvrVrpr
X-Google-Smtp-Source: AGHT+IELMizzwHCbea/o8vQcZT7SdjmJqfcXHq/L7pUA7OdY8fK+DRlYXVEgOA9aViZ0Mim4G1boeQa3cLx5DJkptco=
X-Received: by 2002:ac2:523b:0:b0:51d:3b87:70a4 with SMTP id
 2adb3069b0e04-52bb9f913e8mr2357387e87.36.1717792693887; Fri, 07 Jun 2024
 13:38:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521152602.1097764-1-patrick.rudolph@9elements.com>
In-Reply-To: <20240521152602.1097764-1-patrick.rudolph@9elements.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 7 Jun 2024 22:38:03 +0200
Message-ID: <CACRpkdaxz2A42V2+oQT9CGGdPmenLj5pvZKzVmnrVkDy8jJQSw@mail.gmail.com>
Subject: Re: [PATCH 1/3] pinctrl: cy8c95x0: Use single I2C lock
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: naresh.solanki@9elements.com, andy.shevchenko@gmail.com, 
	broonie@kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 5:26=E2=80=AFPM Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:

> Currently there are 3 locks being used when accessing the chip, one
> in the driver and one in each regmap. Reduce that to one driver only
> lock that protects all regmap and regcache accesses.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>

All three patches applied, thanks!

(Looking forward to a <linux/cleanup.h> patch!)

Yours,
Linus Walleij

