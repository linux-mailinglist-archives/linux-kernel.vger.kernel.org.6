Return-Path: <linux-kernel+bounces-413503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7AC9D19F5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 21:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B21281118
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A4F1E5020;
	Mon, 18 Nov 2024 20:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B0EgTl3q"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3FD1E1311
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 20:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731963384; cv=none; b=FicKKyXVKR7YndB8NYYOLJe3D0y/NGda6vfWt+KRG+sSkTJKomsF3XtFkTUKLSPTP+c/L5Imimk9EPV0AOvjh15CeSwS4MKM5+yLCQgmo03BH9tZrnU/wSAy8mYFrOF/z9lD5V5v1JRMbIiBX7I5MBHLn/CDNTHVJ42vd4VtERA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731963384; c=relaxed/simple;
	bh=ungsn3f8/dGSKSyUBpjU3yOgOagSqTfbI/z8PJup3NI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZkE16J9TC24Qij1k2eYDf49s1n5+LZ4no5jjeu+tGcDviapacG/mJGWvQ43BJw3Mc9Ied2EzDYnszFboXdU3Z7w5i9ho3a5owZjcWtUjNgjJfAUYgqATql5rtdenspfiCjbxHaT8L9A4MrCHrfL48wJdZ6rKJJTl121jERTDymM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B0EgTl3q; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb518014b9so2112231fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 12:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731963381; x=1732568181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ungsn3f8/dGSKSyUBpjU3yOgOagSqTfbI/z8PJup3NI=;
        b=B0EgTl3qbS7cuYWbgybOgxl1Rb2LJyAccQeryYHbjAtNHsr1UwdQUWQbVpONPmabN9
         Zn2S3vdFWP/jqjFCBJR7zhlyiVdz19q8CxzI6wcZ3o9H+vwXYPlBzdVMq1nlSIjw8iTw
         fjk9s7WbCMHfXif2Y63ejBWs0lFeeMcbs636uDqcddtcBbyK7vYwBMFKDiSCw7xn25ey
         7QUynhpx7060U5EguPdOw8SM80oin7bZNha3V88u+ZUe/w+JvXFOrARjZq84a4mLjVPx
         aqkqkyjEPlw92gCb1AFEdNFJkLhF9AVR1dxc2Mc+piBwvLWYrCRzaxKvx3CvRJ+vgdHv
         vqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731963381; x=1732568181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ungsn3f8/dGSKSyUBpjU3yOgOagSqTfbI/z8PJup3NI=;
        b=GcwesXkrame7u+QY/04aJ7dQUDa8YOr6FJB8SrgNyxfPSKZ6xRjpDZF4Dcks/5D1WD
         Nx3vvBZ+B3vZhKJyg8k0kQdPmTL5Ok3negqR+z1g5gMkndm7Ija0OrEzhlA2Qtiwcp4U
         EtHElYtkKxOrsmn0W6SVQlx44c5gJiC7E/g8UfqilSTXvrHjkkiKUTZ0q5c039cZQntm
         UKAaq7IaiU2BOh6kWX1msofJJ51AgaEOelKhheUmHTuOlI76u13hEOgIsSEL+/7coFW5
         EMvt/PUCBxwzY/lYbqGaBnJb0a+vjXjvBQLdsRJ2k/IRk6DQhA1dDu614jAo9nP770bd
         hblQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmhkbKJBbyx+7zBwi7ZSgb17g9mUfK30YleVNCVYDA6D2jskay1FOJJpKddt8hOQauYEIsUt3Bjx1e1I4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLkZKmxasVgNLb7CUSCLj6keL3o+GNOJ1+Og0h/vQF5L29SI50
	9q2nH+nptROyqoWx7m1Eqrox8YYt0mCQE5nZ0ssaq5aUtH4Li9iCY9wjsB/pZI6lyTc+isdTHtS
	TtuD09g8JjRynDAqqU8uQMubbBcQRtSaCQUvOJA==
X-Google-Smtp-Source: AGHT+IE5OdhKXuCh58Mqv4p1qJzmEnzQXakg8UJU6KGo30C3j9D1Doc5fsgG1JzjlFj3maLKmuS7KbwwvmXI9w/Max8=
X-Received: by 2002:a05:651c:1543:b0:2fc:b10c:df4 with SMTP id
 38308e7fff4ca-2ff6093369fmr56865951fa.20.1731963381090; Mon, 18 Nov 2024
 12:56:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113-ramble-blaspheme-b303dbf37271@spud> <20241113-jovial-atlantic-cd07f05eb2e5@spud>
In-Reply-To: <20241113-jovial-atlantic-cd07f05eb2e5@spud>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 18 Nov 2024 21:56:10 +0100
Message-ID: <CACRpkdbF0sqg1Q_qxFn5zz1rFn7VN9x_mmpMPt=YS81vazJe1g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gpio: mpfs: add CoreGPIO support
To: Conor Dooley <conor@kernel.org>
Cc: linux-gpio@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 1:01=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:

> From: Conor Dooley <conor.dooley@microchip.com>
>
> coreGPIO, which the "hard" core in PolarFire SoC is based on, has
> different offsets for inp/outp. Add some match_data handling to account
> for the differences.
>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Looks like a solid patch to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

