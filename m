Return-Path: <linux-kernel+bounces-346132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 326BC98C008
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19871F27A1C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AF01C9EC6;
	Tue,  1 Oct 2024 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Djk3UDNe"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AC61C9B63
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 14:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727793045; cv=none; b=i9etcpZs60JIE6iFxLqmnlQyWxInZGRYW90HxvCxMr2Tl6UrQ6EiL1ZRl07rdo1ZEx3Z6mZ9nlUIQwMcqEJYt4zUQyhBBIQe0UdoIlYOcd/BCvma0wYyAWLQ5CZKDtcm8DCl18GNDgmfeTzL/SdNgW7plUtqoXoR3YWlJOo+Cew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727793045; c=relaxed/simple;
	bh=cvgFpm4rDeWEyMMdQ20T3EGJ3qMtaD8+usSEuEvv7iY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Be0MkBebi2dC6yZD+IuMWlCIHhgCzgbUBHBO6bZ+LX4sAc4mR071NVzbOAXuRcXURAUwuqgih3tjGvCQoztyW42CMY/mz4NL7KzIQXBwoTLaOIU8sTSYeHBVZh9gUgxtU8G2xmHvGwL7QBNd/rj/aYexRkqZiZwCasrqNYeid4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Djk3UDNe; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5398c1bd0b8so3003897e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 07:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727793042; x=1728397842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvgFpm4rDeWEyMMdQ20T3EGJ3qMtaD8+usSEuEvv7iY=;
        b=Djk3UDNePe1ykftJ6p60lF9NHA+VmFLqQFXL32D0QtjVRdqM1tOpPlhBTSR1aNyYVe
         BEixgLxTxQof45PAn53N9XuCkgzqZ0o1fBzcZb0s406NQ6K07Y0j3xiamJaIsbfJe8mu
         PACEirwPQ9ofatVw2VnFbhTbL4AIaaCZDGfWCzNSUuK7wzbyzh5/cjdSePBWIgt7inzJ
         c8jup5zFgIyEBeDEqiOWnRF11t2rZg2eQqp3pxHINixwP3+3C0OV8ja2Ho+e7LNHkVaV
         L6II5bYebZaWQBxqQL2FS6Frwk0dY0/+nR9mc4TJNLjyK70GXDDDnZ+QdSlasAAUCB62
         tCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727793042; x=1728397842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvgFpm4rDeWEyMMdQ20T3EGJ3qMtaD8+usSEuEvv7iY=;
        b=YGZiKjvoQKL73IhnbZVUEjCTA2rP/9MJN9SQzAX7hfk6AS/nPhED/xE3AwwjJfW+Bj
         aZkN9UtOuU2oX9qAzX4HoCctDrT9jEfs1zsOQ6DFzueg+S3lwR6qTXYZ9Ufex4+P2Iih
         O81KmGJVl/44IqiFu+2R5QrXUHLV4AdBL56BDlBoVG6pZEtbYNHAqiuIuQyLfYCdDGve
         Ypjtm6zCNOMYbGsnI4GNXNF4/6zA0rhtq3UYNDuIWvw7RQvUmpCPxcfvKXYxUXEa31WD
         /I8LKe0VEjZuKJw2qFV+jQujNRhC23w6ShqfPfctg1GI8yexpgxX09TAM/oxI5R7tS3q
         z/gw==
X-Forwarded-Encrypted: i=1; AJvYcCUYM5Sg9KGsCtawCxyY2pVR1v5Fq0j0CtjK+C624ulgYsjCiwc6z1z05ghjfLhULtPJM6azLssvr8UU69Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwioTtAwoSVSpRmfUzh+j0TvhUMMi9Peqw+q4Xf3P/hUhsj+SPz
	C3SpiSNzzoLGgKsO8DpM+M6MGuApniABOtOKCdhAIKDesK2KYGfMelIwy2uw62TJabxPvCUVqi/
	dg2GaR42sCC0FqeapmYDDBNu7DXaFAtnCMBr/PQ==
X-Google-Smtp-Source: AGHT+IG+Cj9uBDgQqk2xEbqNSYpxfJ50Q7PX8br+Y8B2wdH7MgvZc5ZjKVzSuVxtvai2dvhR6L28NSaVg6WFiSGR/BQ=
X-Received: by 2002:a05:6512:138c:b0:52f:c398:8780 with SMTP id
 2adb3069b0e04-5399a25697amr1158445e87.18.1727793041967; Tue, 01 Oct 2024
 07:30:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924-pinctl-sx150x-maple-v1-1-17dcfefefd17@kernel.org>
In-Reply-To: <20240924-pinctl-sx150x-maple-v1-1-17dcfefefd17@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 1 Oct 2024 16:30:31 +0200
Message-ID: <CACRpkdYLkUhK5Q4b5ckAY1F-uuoc3C+XYW42W=_NKxp7hfzf-g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sx150x: Use maple tree register cache
To: Mark Brown <broonie@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 5:39=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:

> The sx150x driver uses a rbtree register cache with no obvious reason for
> specifically preferring it. The maple tree register cache is based on a
> more modern data structure and makes implementation decisions more suitab=
le
> for modern systems so let's switch the driver to use that. No functional
> change.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Patch applied!

Yours,
Linus Walleij

