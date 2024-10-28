Return-Path: <linux-kernel+bounces-385959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EB69B3D85
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D66B1F224C6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1B21E0B80;
	Mon, 28 Oct 2024 22:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="itz2U7Yf"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FDF19005F
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 22:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730153445; cv=none; b=FeT0HS1mVItCaqHEWd084rOhxWEPhm5u3ea1fuIpShNH9qOV/rePfFdbF/trmI5zBvk7OQUBIwZIvXlaxJW7djoU2iabIdva8fHKlErYrT+5xmHSJ8ATybQYOEXhbiwSm1ErnkFYPne0tuPRD9JL6Ij/LCNnVoRgC7T8huAI8RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730153445; c=relaxed/simple;
	bh=0joOEVfGJ/pb/7rS6z916+AKetXgpvSwhXyT9bKzZ+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GgB68NCF+Cb6wS0MAN/sLUGf2U7zsS6t1UhIwLdNKyqzMm5BdagZu9KNuExZbkNdUFx1bbOCR6TeaxIEV2JSvjl0WOKNBbJBDyRXA5mHIuPQWBcU/X9QZ7UeaS1/5tmmJPNKZLzr2yirk5omW1LM7CnMzmIMoL1JLDhVLu2QRD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=itz2U7Yf; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539f2b95775so5629981e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730153441; x=1730758241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0joOEVfGJ/pb/7rS6z916+AKetXgpvSwhXyT9bKzZ+Y=;
        b=itz2U7Yf1+UO4995azvKeikePT2h8l/CNdCRiU53oe0bi5rpIA8MAnNYxyGSFPeIEE
         uLDHr1L9abNldkzfPBRN3GxmJcHtdxG4dSm+euWYw3qtHw7PskCHd2t9fQVlAQFc9ysw
         hYCeDBXiws4d6o3RRuQzf33GHFtCzDe43CRUoVxFYnao6cE3cFUxSnQpCoeeBD7oM8FA
         MAAJ8sxmEtWqvvZhkHq8Lx8PHHLcazBDi0lFInydun4/xB15jjBsWq4vV6fqk0lPbkpV
         YTU99DdzMatCBiOsenA9M0nM/01GNSZeksbDQ66ix7KsbnTCuXS0TUcehf7alfEJsTu6
         Q+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730153441; x=1730758241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0joOEVfGJ/pb/7rS6z916+AKetXgpvSwhXyT9bKzZ+Y=;
        b=DpsJFEZ3+K8v5VSACOf0p7UjIDlLl+XtLW8NhqDdtrJo1kJ9DnTEK438SAB1awskTf
         tdBth9GI4PjhF6d6slTXNp0iRwCMoiK4dgd/tzmP9UJfNpjQCV8mIemqS4luTLq7ve3l
         exfIQnQPCmFoOzVAkj4UiCFijWad6WSlP3J0UCgpkU+9armolEi/DBIG9y7VP7vom4Dq
         yv8cGJKGBYniAwHDtnzpaOpAXRRUMF7Lli1Ww0yfNvcPutQ5d8kChTByIdeKxJTkmx2s
         nem7jdZMM55Ac1hfCFRsnxNRv0JlBTYzaWnAOELz9D15GS76tamXM5exlkbvblnPsG0Z
         PghQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4Ye5SsBf1tJJx4mkHy8MaCBlwH8mwFV0N3qYIdYZ6imw3pvUOZoSv1tS5AFPKzeP7zR9Y68FJnsksavo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaohaFx09TVzahXT7mZ5m9LWclhDTCXZIIqFtkKZKSYW04qGFv
	FJUa4p7hvLKoTT029rLPr7iA+Z1WGZW2QLBEF2aRl6j13XYE2FLwT/nUyUTM95/4aKQlv8KUNDm
	YWX1JjCR+kVQXoePa7LMxEFRZ8vHjXCIujDOpzA==
X-Google-Smtp-Source: AGHT+IFgBM2WuTO54JNNNG7YiNFv9JtCLOpE6gjQUKOR7JSJXSgnKxtnYKZNWV39C8PMPul2AFWeNCFHJt3Grqjuw1Q=
X-Received: by 2002:a05:6512:3a96:b0:539:9720:99dc with SMTP id
 2adb3069b0e04-53b3491e09dmr6272347e87.46.1730153440986; Mon, 28 Oct 2024
 15:10:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028134454.1156852-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241028134454.1156852-1-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 28 Oct 2024 23:10:29 +0100
Message-ID: <CACRpkdbfhbtUmmE9M3qLuM8LmPDYKvZL_znVnvGqGZwSB0=Nbw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: Use traditional pattern when checking error codes
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 2:44=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Instead of 'if (ret =3D=3D 0)' switch to "check for the error first" rule=
.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This makes a lot of sense.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

