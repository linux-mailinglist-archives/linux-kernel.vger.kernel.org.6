Return-Path: <linux-kernel+bounces-309496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA91966B5C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 23:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50CBE1C21D47
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 21:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD1D1B5304;
	Fri, 30 Aug 2024 21:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EKgzM6KY"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C5615C153
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 21:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725053946; cv=none; b=LrXYyZ6X8KQdnsIkCHfU1t11ps3gaHrmNFbFmzhKEaq8vnjbcxD1u5QvWJgMM+JoZnqqdpCr6QQsF8jDUEMy2yU4GpAfYpX+P0TYAobOa2478VNQwkTZ1CAPM/oJ4zHGhlcizZPbpJY0O66oHp/0zXdrPagdc4HlvLoW/v9PuIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725053946; c=relaxed/simple;
	bh=tx3NN9PBaIcoL5lmof5VxsRYvG5MOAlKaCOGs63C74g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kinzz7NTllIiNaqUv+nd90pjmk5iWm/YnUtF2UTC7K7reXo2ufQugf5vbydPs5pu/VpxUFKoTc9+zE4rLBzIQmrDtbhI/2AhTxzPmx1m2lvD2eczrk6mi0TLDQq3R4J4lfSNgJjsCXshQWJl2GevUZ82lWuwn9yCZuw3pyFezN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EKgzM6KY; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-533488ffaddso2939741e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 14:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725053942; x=1725658742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tx3NN9PBaIcoL5lmof5VxsRYvG5MOAlKaCOGs63C74g=;
        b=EKgzM6KYjqZY16hYGtOuJFYBJZA0cyVA28rGkOp4p3XsjCErzXDb154mLzDLRTiEAS
         vNfkbG6D1JTni0ULEYrgRIUY+i2WuIlJRfjjaa6kBftPBHS94dsrlp94JSFLN6WzWkmu
         xEZS9nEdkW9z/E8cAkPr7HhCH/RoE3wifOrASemh1uyXzS/+wYT/3v+/RSZ1WsIKBpOI
         KsR3Dq/qHS10cMT+CRtiT0rCxnNKIPAj8iZ4r0u9DLhXlaUDcUcTNgcoD3mmD4W98WGC
         GpdChc38w2NfJ4CVlqaW5gSM9UdsEK/bIxTKgAykTrduL9+Spipp0nQdrD+mFkhdL+bc
         fmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725053942; x=1725658742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tx3NN9PBaIcoL5lmof5VxsRYvG5MOAlKaCOGs63C74g=;
        b=h7Z4kMjr5qc6SuFDI4PZUrT2sWTXBcNqefEOAnx5+50vG/qfdPnDSgWM0kb6d1QHIt
         /GbiNPft9p5umBEyScv7VxVotvrilxtBB+5GpUfMVCzGPCm/3CAUZt10fofRFrbpfe3I
         gYR80FnQiNu2Trv2mGFTfe818Xh/q20WZbk6jo4DGv+Cx5PCa4wObfmZ47hF3Pds3/Xh
         ltlvm4caIUTfTuKHPNSFiyCfBYJKhUZuifBJTBRujJ/4NXq7m6CGJSOTVbryP6Qnesun
         yEZdOy2Mmr9ao4ks9kYELJgJk60lC9PKvHYR2lUCyAijgIhKhwjheDKahylQUYmLz1OP
         Y1tA==
X-Forwarded-Encrypted: i=1; AJvYcCU2p0i+IndbuIm42bQjd+oVeBX0G98prOAoMLc10O6w3T55TWZB0bX6p5xGBcXh2Ybt3TteiLZbD/IChx4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+uAsV9ftqQi0kyq29E3WfOj/rwvuiPAJEdD8P7+A+gUbTE5Kp
	dHn3KpT1ay8O2ryjj8jomyXkvknpKsa6JsfL9uvjr8jdWkAk6s56DNPWbhWLFhLErc1fVx3LCHm
	6Zzg8P9/HpIym1mE6eHy3wMwbvj97G12sXo+4/82bFoX2BaQU
X-Google-Smtp-Source: AGHT+IH+OfB/0bzliYjBTxa8MrImYSIVc+pu90B1XIZlcVmzyb5T1KIfQWW8TrCgOUK7OQkUdelaSDD6+CDq0Tcfi5c=
X-Received: by 2002:a05:6512:ba4:b0:533:4722:ebb0 with SMTP id
 2adb3069b0e04-53546afa222mr2795357e87.6.1725053941197; Fri, 30 Aug 2024
 14:39:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826074037.2313468-1-yujiaoliang@vivo.com>
In-Reply-To: <20240826074037.2313468-1-yujiaoliang@vivo.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 30 Aug 2024 23:38:50 +0200
Message-ID: <CACRpkdZL1LFQApoQweA4-KuaDXX9CUirLNViwNHMjZmnW6EGeA@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: nomadik: Use kmemdup_array instead of kmemdup
 for multiple allocation
To: Yu Jiaoliang <yujiaoliang@vivo.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 9:40=E2=80=AFAM Yu Jiaoliang <yujiaoliang@vivo.com>=
 wrote:

> Let the kememdup_array() take care about multiplication and possible
> overflows.
>
> Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>

Patch applied!

Yours,
Linus Walleij

