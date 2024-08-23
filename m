Return-Path: <linux-kernel+bounces-299326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF5195D302
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B3F5B22599
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE1F191F85;
	Fri, 23 Aug 2024 16:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mYch5VwA"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129C2189500
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429848; cv=none; b=Rmu/mgYkGj5kwDGq5J63ffEHcuusYA0SjgkDTK+oncjk6flgWie8gRh5o47iANBmFAjZ9sWOe1mtm/I+asJrZZvsSh/VNx9O58XiiDLooWNGBWNubF1d6pZmEmnTenftn85WT17GNcu9oUPeE0saNzWAZMbDVjKI2IQzvWT7YNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429848; c=relaxed/simple;
	bh=/1JOykmGcfsMrRKEjdQMplOXVRMYxg8kAzDE2g75ZxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QRkSzuHZ5NoZyxGcXwK5BLM8wYtwsuU2PZrKqNQoJ/m22U4mONcaLKM37ld7IRdkblO04stMey0xa38U08xFsGS5xF2C1MZXy9MSI0c9Ir60fCBy/rhdTct77erIWQT2XI4g+d8CH/C4X3Q99GL3OXEqA5lBxiiA5uKPulJmLPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mYch5VwA; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-533488ffaebso2376681e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724429844; x=1725034644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1JOykmGcfsMrRKEjdQMplOXVRMYxg8kAzDE2g75ZxA=;
        b=mYch5VwACiWu0+mGTMVSGmyAGPeYlVwpPtVahWXYB5rotYQMFt3ySo17ngOgUMEXoJ
         3OEIo/Ko/wU0YAJYKuNz+VsWDpu3O+Pmx2gGNzs3Uxf0VkRNnYpSHviAQWARtDjOHR7N
         XHqPm6pYHhz8NBPG1feN3QxzNsKnoFlaxqq20dPLoDfILIBQ2AJXhuLrVEcPfwnk4Y0W
         KETT3EZpo1GjzcIm8WngFvWiprYIqdZ27COghW5z9FRQgy9b94UunqiRZ2pGhEe4P+OX
         AvLyCmuB16J8zC61dAEtJ0v2KiaIZ49ipNqbBBSOwcTnp6jCY0ySRBo531bV6FVp8oLC
         w5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724429844; x=1725034644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/1JOykmGcfsMrRKEjdQMplOXVRMYxg8kAzDE2g75ZxA=;
        b=W1XNlncb/CoWSW5+0GmQKcPt3XkgQE0K3mbOhneElAii7NIdw/hfzqEBBQ2Im5AxTQ
         8fUgXeeawTcTdDZYO0jjqk0TcMn4Tkqm6kwkeARLFBYLG6vAwzpsyBdbT98RNr7Yqu9F
         OGIlLK+tC3b71UeoidoPe2ZjucYHXkqop9R/ziR2YnrVIlStYAa8kKERXFjdmb4QgoMs
         qS8bk2hrFv0O5xC0mIbIGIKhSjwzKft8zs9TYNWkXTiTFksZlZu2vVkLcXEbP7OI+nH8
         VPz3mPRJQKFqJGr2/H8VFjlwbUcq2peoX4f3eNRPSsJp/7KEAYYpsIAIowPhlF4wUMU1
         5q/w==
X-Forwarded-Encrypted: i=1; AJvYcCXdnTf/HOcgNXy16uUSM5sN9QLiPLQPYpNIECtSfX9ZJQUD1C3k+/1SrY96QxGLgyzbPv/Y38ZrQu+8bx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjAqjrJ72bqkSk/MbUZSjsEnUR+5VvAQh3CLr8OLZDzq9t4AFk
	FC2wvXcPPWRGwY26qCfrv8kOlkl3ikRS+UofjQ3LowHcDMcyz0+uMvx85kuDjGSUQMc6/nY0q7G
	SMgo319NYtrk3s+xgCJiQH9xifnO2jDHLet3RtA==
X-Google-Smtp-Source: AGHT+IHLTFfhA6TdgZm/KA1Q+nJVzjfMKVt+DdJhoOP99yU6MeYeiEX9vrhl+Fo+VgEsy05TJol7hRdrCPfbxc+wBDI=
X-Received: by 2002:a05:6512:3ba3:b0:52c:e01f:3665 with SMTP id
 2adb3069b0e04-53438783dd9mr2043263e87.25.1724429843683; Fri, 23 Aug 2024
 09:17:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528191510.1444068-1-robh@kernel.org> <172345744173.104566.7784022936514071509.b4-ty@linaro.org>
In-Reply-To: <172345744173.104566.7784022936514071509.b4-ty@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 23 Aug 2024 18:17:11 +0200
Message-ID: <CACRpkdaFMv6udzNdmb+VKG4epxvsDwWsNhX3=LZmJnw3NJowZw@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: realview: Add/drop missing/spurious unit-addreses
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Rob Herring (Arm)" <robh@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 12:11=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On Tue, 28 May 2024 14:15:09 -0500, Rob Herring (Arm) wrote:

> > Various nodes on the Arm Realview boards have missing or spurious
> > unit-addresses.
>
> No one took this patch and it waits on the list for very long.
>
> Applied, thanks!

Should have been me, I was too busy/lazy.
Thanks a lot for stepping in!

Yours,
Linus Walleij

