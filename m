Return-Path: <linux-kernel+bounces-231827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC95919EDC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15524B22342
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 05:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27A41CF92;
	Thu, 27 Jun 2024 05:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEfCV4wJ"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C5C1CA80
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 05:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719467001; cv=none; b=NJ4U0UsnZ2kPVuvbKS/bKHlhNB1ObGYWfw1if/wqIY/fZnNu/ujt26sTGHEN5g/UMooG2YbBIFOUy9djlCIx6TTBneRcO5TL9FFT+1MkuDp/JH3dEujp6T7WPYbWiZDxbgmtBSiY+KJ3CuCqRhXtmthh1yonrw8d91VnuntcfqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719467001; c=relaxed/simple;
	bh=nEnNoZD/xbPYCt/p8kb6fwuRGuVw3yx7KTtbVfKRLyY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DjNg3IAJ6bz6y+FOKGtxUNTRpsiJFhP6URHjvNnstUwtrebaY798ZHic0IsL4ZX3NtdPP49P9ihVTxjgUe/4+GsMdRdlJ2ygWFkFNuXz4FLEY9rVYEZnvAYJFh2xzCamDWcIcipx0CT3ROqxKQ56F3Y0My7cLVrvy5xqoFsfEJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEfCV4wJ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-425624255f3so5103195e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 22:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719466998; x=1720071798; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEnNoZD/xbPYCt/p8kb6fwuRGuVw3yx7KTtbVfKRLyY=;
        b=CEfCV4wJzfTfkV0XK5giRUpR9/fueEYFAoCjc5m3qQi8/YkSthd63qBq5+2o/RO9rh
         G6O/yrLDdL/YB36Wed/iQn6fRtGLUoda8Vl5y8kRCt4lrT5vVkpmIwgo5D1BCh6y/zL7
         cjiPpcASdkbnZEoqVz9u0TiI2xmGomQmj+DMeXCofsV0viUIBtH6QKtbCvtLCjiIZpCB
         LibbfutO5PCO3fNM5VpFQxpff5RYGQ+egWmglBh9OSZoIPYxVfZbi9eY+I0VzMtcusJs
         CU4YS/FidL+tbsGgQWH7HN7woeKHimnlfaiG3CRIdF6EmdqNpB245755PG8VWVVND0lU
         HCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719466998; x=1720071798;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nEnNoZD/xbPYCt/p8kb6fwuRGuVw3yx7KTtbVfKRLyY=;
        b=K9bAEMq7hq2ATLgqc2RYtFQYNjJjT9EY+JLACErqCxiS3bR3SsNF0q4XDyfpkIVg9D
         cDAC1R2NRMqKvZoUHhJk/Z17ManQ3hoh4QnZeEDfkAI5m1cYqlx2tOj4AYIyMj4xW6qQ
         KAa5HrCrnSQcV72frySDilJSUDINnGMRBOAU0EBDfjp0BTKHk4Yqy/5gPECU8/MLrGjN
         UUHC2ms0H3qlO5CJx1TsWpqz1zTue2jAB7dk+r1RT6bqLto447UV4jGr/1AMqXeSaovF
         UGwQ91MkEGAUHV7qbi1sEkxrVLlrvTd5EhWyutfZX/StT8+aHwa4jZvlVDk4Tuu0aWr2
         D6Hg==
X-Forwarded-Encrypted: i=1; AJvYcCWMd38DJ8F9I2WYfhnJmerGcIgQrSS7ilqQ7xzqgGDFfz0YdhrPryyxsIkMvbEw/hFvmU8ANI7sxhUkmVLAzRtvooXtJyT7P1LV21Rv
X-Gm-Message-State: AOJu0YxUs25l4/iFWKNeIf5lN0H5pdbj7e3yTnKajbNgGe7AaJp/3f9C
	99JhGEBKLDSL7SQd9VLXL2DRsqDmyvKElcrqKX6aca0KjQ4P0K0RJ5I+/FxjL3c=
X-Google-Smtp-Source: AGHT+IElihtCwhtC2YyIbh1bFQqDm3x/kQDetaAGUB85To2vJEdORMNNmhZl0LPvMS9rfC0RTss5Fg==
X-Received: by 2002:a05:600c:548c:b0:421:b906:8088 with SMTP id 5b1f17b1804b1-42564292285mr7220435e9.0.1719466997633;
        Wed, 26 Jun 2024 22:43:17 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:359b:e801:d44:32b3:6924:10d1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c8285f5csm47444375e9.25.2024.06.26.22.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 22:43:17 -0700 (PDT)
Message-ID: <8a3ac03fcdc5c2c6401d0a990af5d6e9f6c6670d.camel@gmail.com>
Subject: Re: [PATCH] mux: MAINTAINERS: drop ADGS1408 driver entry
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Peter Rosin
	 <peda@axentia.se>, linux-kernel@vger.kernel.org
Date: Thu, 27 Jun 2024 07:43:17 +0200
In-Reply-To: <20240626140343.145440-1-krzysztof.kozlowski@linaro.org>
References: <20240626140343.145440-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-26 at 16:03 +0200, Krzysztof Kozlowski wrote:
> Emails to Mircea Caprioru bounce:
>=20
> =C2=A0 Remote Server returned '550 5.1.10 RESOLVER.ADR.RecipientNotFound;=
 Recipient not
> found by SMTP address lookup'
>=20
> so clearly this driver is not supported anymore.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Hi Krzysztof,

Mircea is no longer with us and often we just forget to update these entrie=
s until
someone yells. But we still want to support this. Can you send a v2 putting=
 me as
maintainer or should I send a patch myself?

Thanks!
- Nuno S=C3=A1


