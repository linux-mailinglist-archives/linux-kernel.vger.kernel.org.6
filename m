Return-Path: <linux-kernel+bounces-239492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3CD9260DE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD3628865B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6438B179954;
	Wed,  3 Jul 2024 12:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FtTaelz4"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31714176ADB
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720011018; cv=none; b=MERZM6sUw9lkJpVEdI5RxQQsnwHnEIId3TYmVbT9wCMXScGypGnAGpsl/XieZLyEPt4tWUaIlsH59Mjv2adEqnx8A+6CLDQSIKtvJ/j3BE0E6+Xlzfc2xHOj3DgBZQYNPAgdCHpXDZafr2LWIR8CJc51BEMAtxL338H0KjkrAYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720011018; c=relaxed/simple;
	bh=Ay2o4WtDijauKlhrR6+yTpXR47/mNk6cJuyin80HfuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCtUkhbBhQnPuUMTlhUnHkc42ay4f2O4Eq+bgCz33Upaz+caX1PwpKVdC6QhBPnOO8J1HdpqRKqqqps2Pu1vjH3I85Epo5AJ/yc7yt8vj42ak3hv8fV1wxqwmm8jWpKdrFybS0LHGkPFd5ElzCFICNnF6+imNpokBE8rq9A8mDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FtTaelz4; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e03b0e73f14so481628276.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 05:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720011015; x=1720615815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ay2o4WtDijauKlhrR6+yTpXR47/mNk6cJuyin80HfuI=;
        b=FtTaelz4YRB+f5hz7MIj/9z4epvBEFucKwjJTikZ6npevnUBcMv1E0CxmUTxUoZTO/
         ansuLhPpS5zrNSFcwlEImOFCUQ2ubEViDgS/xHJeNlYyFYx3izv8/0J76C/UuIayQYFy
         ebJ5Ir5D8+dmAAnFG6LPauiVMFppsfrV5eoKaYfvk60XFGnMIYSU4gf7q1dSzCwZwxAA
         wCFuZcQb/bi7AKBJvvbkGfapcxUUfiIAJTI9clWvcJ+n38b+ktktOnSugKSYIpWbUSAb
         XYOUMNqsig5gN53jyJ6Q/+usQjmpBdPehsHVnKNRCbG8JBFH/9yoY+BPo9dIUTGLOP9+
         yh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720011015; x=1720615815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ay2o4WtDijauKlhrR6+yTpXR47/mNk6cJuyin80HfuI=;
        b=B9YDPcuEp/2cp0BGfHvjHcsOMntYb9X0ZLBRQCb+oY9pxgbhfOO06wpWDibQNdk7W3
         eYXfOzr3fxXb9QdKajwGaY49AQiDie9LaxUCGFSMGyQSsrGmFYvoJMPby3BNg9YBht9+
         E4Uu9aozfn9mjjZK50mmFlVbYA9od1XorzCPt54qmpNxHdd19D9rGCgNs+ajKE55zG5G
         EvG2NjB4YhmztxtxA+7zQr5+EEa7uq8hGTJguk0l5yaaqs5IIXqc7shrwTvd4GWomX58
         Mu4DwU6ym1dXqSAh0k8CAk/6qMRK0HzRL0aTxy1esevQRqNDyBzeK5SgYVEkxErlNnbB
         J2Mw==
X-Forwarded-Encrypted: i=1; AJvYcCU7qvAvGSUKeYwqBPDCO8+U4xkc/oLn4n1rqAaMuNDdW2q8o4N4UJY0eCDIJ/S2syC5aTlTk+Jjz6NKJ23dG1XZ1Eh9CKDnUTMNGNJ1
X-Gm-Message-State: AOJu0YzCMkQROsAcOOfRl2E5x/QYqH9rZqxF/UHYpW38OFeWMWog//Fh
	OPBpl4HkNeQ3GBODcH8cDsYxHqcQLaxsnITdOUjFBo5U7LyEOl7AeYiEGaBPOC7Sz8lm9fJcqIY
	iNK0Gq2te7v8eHxU6Iul7WOfsk9SaD75xX96fbg==
X-Google-Smtp-Source: AGHT+IFV7ffdIp7JTsaJwTFxWYFq9NuhbSHtLDocDtRDoyzt9ojWdD5kwz70sA2j6Gk3nNxPEzRj0IyN26XVuILWwJY=
X-Received: by 2002:a5b:f09:0:b0:e02:c70d:d292 with SMTP id
 3f1490d57ef6-e036eb6e1b9mr12602914276.33.1720011015300; Wed, 03 Jul 2024
 05:50:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240630090104.565779-1-tmaimon77@gmail.com>
In-Reply-To: <20240630090104.565779-1-tmaimon77@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 3 Jul 2024 14:50:03 +0200
Message-ID: <CACRpkdajqsFdqdJHx8EshL1Caew_7RZdun2poY2HceptozNg7g@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: pinctrl: npcm8xx: add missing pin group
 and mux function
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	tali.perry1@gmail.com, joel@jms.id.au, venture@google.com, yuenn@google.com, 
	benjaminfair@google.com, openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 30, 2024 at 11:01=E2=80=AFAM Tomer Maimon <tmaimon77@gmail.com>=
 wrote:

> Add the following missing pin group and mux function:
> smb6b, smb6c, smb6d, smb7b, smb7c, smb7d, bu4, bu4b, bu5, bu5b, bu6,
> gpo187.
>
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
> V1 -> V2: clean tabs.

Patch applied!

Yours,
Linus Walleij

