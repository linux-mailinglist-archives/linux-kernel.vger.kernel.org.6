Return-Path: <linux-kernel+bounces-396452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7A89BCD3C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6C88B21E96
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD61B1D54F7;
	Tue,  5 Nov 2024 13:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pMfwgyvr"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1EA1AA785
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730811666; cv=none; b=hkis4+/76I60tozNkzOR1UqWYRJF/9KUSOuYlsdydegyEZo3S9Lf8tfnCJzTJCSD+pTn4HhW4h+AQPCibNlDMvSOvQWd9L2/GqMmC+L/xkb6NVzRoD13L9IyvNbo1pnBNnUUICMgFy8SrdnlnbzBg1iJVagm2dvLjrznIEz38kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730811666; c=relaxed/simple;
	bh=D0WTw+MUtdg41qhocX1Oe1iRLsKsP8vyHesg6BiksAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMGRL2DLkTusUyMOA7ecS94knb8CsGq7i9ThGqC8KkvhVG/mjX1cC11Q7lXKDzv+hvhq02S2t29eCVvEvgXW659QOts9g74104agO/gMkctg06ZmPAlkIhJgnkHSZu6yQWkHyWZ1S/BRQ2rnalxllISvSWP6q0os85BtKH+3QS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pMfwgyvr; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cecbddb574so3463049a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 05:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730811663; x=1731416463; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D0WTw+MUtdg41qhocX1Oe1iRLsKsP8vyHesg6BiksAA=;
        b=pMfwgyvr9BHIvYoDsMTV8qvik4euwFpld8TvEJQAbogrITOmthop4cO78gqWWhcymj
         ZbYGMEuUQqIl/biCagL4GOSavABXbj+JnQWGRuzLNIiQHH2gR73cCB5hjTNtmhx4AO1R
         3aDT8XzQ5CLZZXKEHP+z+w1lrNTFB2jvokBlLbwg7miir+5o2Ypax9uN7EMeSNP50GFw
         zq2nU8Aefh6jbF7r556J2jTdI2ESJVvsK/H3EUh3ZugjQruC3jvmTWubzzL9jlytO8ZY
         L3RrM0d6cL+/s8PhlUYkTJ7rILagsxJwPObDun5A+fjc3iDo4+eYzQPjEY9dq+gzAyJ7
         ZwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730811663; x=1731416463;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D0WTw+MUtdg41qhocX1Oe1iRLsKsP8vyHesg6BiksAA=;
        b=AbdxQxvsYg4rHvX76F0WAEoOvsqjl6L/BZOZe/FudoHcUlvtOAZCMrZfXbmlrNXvL1
         D9t7QKN9XjvDEYroLjAAJ3yy2Kas7SjASUg3Ms9Kaq5x98D0TJP2fCiiXZha1MaumB/y
         mqiqkmufS73miNhiJ+Npht6BLbpsaPn290aJdCkpPZQgNE0/zu2Tx7806K82EY+nH3jX
         qf24KPMiWJXpJ8+bPyTg0rxQ6iMM8Itub5Iakem/T/1DiWwrbB1nyCn26c6JTZSKJzIz
         DdLtJJh3Yj7lX55T0eZXzMb7xzB+rpwYcLKSc7uuEhQhYwZsCkiI4j+UfuCfbW4nA1gy
         iVIg==
X-Forwarded-Encrypted: i=1; AJvYcCWYLGGtnPgIaF9Wlw/gfThXOkBLYqSeZilWNPRgZSQoFIO1BSbvCMazdLfgqz0w6BWYuukUrOYQTOLHMN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym5r9l45QeHDiyOlhIV1NO+TzzHpGdAVxTYN4MxmIW7x83Vxpc
	jxN50Yl7i99nFFyhHTg5BIXFywu8qLVY9fCimtE76NDI4r7ROFgRuah2q1YUFZjGUvFEE0AEsSN
	mEaEl9tmxfM0iIvdMBtSX2D1tYj2XPM6JYMPLhQ==
X-Google-Smtp-Source: AGHT+IGdKsOe4uUI+pQsDjBeFjVYPEKnH5Eo7FvRYwbGqpXjSLbX+ykZRbMa+upNnN9HPEwQU7Vdq7xJqtyj1W3FckE=
X-Received: by 2002:a05:6402:3508:b0:5ce:ddd6:d100 with SMTP id
 4fb4d7f45d1cf-5ceddd6d143mr3955032a12.32.1730811661239; Tue, 05 Nov 2024
 05:01:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105004749.83424-1-yesanishhere@gmail.com>
In-Reply-To: <20241105004749.83424-1-yesanishhere@gmail.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Tue, 5 Nov 2024 06:00:48 -0700
Message-ID: <CANLsYkxKteXHMvG3GfPOKz1G_NfQV8D0D4JxYeF0ZmiYv=Mviw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Documentation: remoteproc: update various sections
To: anish kumar <yesanishhere@gmail.com>
Cc: andersson@kernel.org, corbet@lwn.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Nov 2024 at 17:47, anish kumar <yesanishhere@gmail.com> wrote:
>
> V6:
> divided the patches for each section as suggested by mathieu.
> First patch is updating introduction section
> second patch is for new overview section as suggested
> third patch is for devm version of rprod_add
>
> V5:
> based on comment from mathieu poirier, remove all files
> and combined that in the original file and as he adviced
> nothing with respect to old documentation was changed.
>
> V4:
> Fixed compilation errors and moved documentation to
> driver-api directory.
>
> V3:
> Seperated out the patches further to make the intention
> clear for each patch.
>
> V2:
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410161444.jOKMsoGS-lkp@intel.com/
>
> Hi Mathieu,
>
> Hopefully this time around, I have not messed up
> patches. I have created three patches.

And the patchset version?

> Thanks,
> anish

