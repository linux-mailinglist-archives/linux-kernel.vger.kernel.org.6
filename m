Return-Path: <linux-kernel+bounces-188015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1898CDBD8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 23:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F81D1C22F3A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 21:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3AF127E1F;
	Thu, 23 May 2024 21:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mwkCorZZ"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412B484D06
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 21:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499283; cv=none; b=DKe4rRZuZR/It+U+gh97+N9EBT7b6Igt0x+v89xUcIpcjOshe7ireY0o4K72JoA9xBjjXC2U9L82ub9majs/TKrx29bd9flp6JOrqtGKrF+ptw2Zznxn0dzQWREdX2p3e6yAsDiCVfCYAF3WQQNChutrwIszBsw0SjZxpLjXyvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499283; c=relaxed/simple;
	bh=vZ83DITT8+71M9hZZLFbFwj221tiAKCa3CoSsZtHtG0=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q7T9uPuqrcoRoPNdHHNuyF/04HRnogKEktE8d3WjR9Kij9sm+9e24gayJkT7dvyZkS3GaM5HU99PJNsJN1btbrTlJucOt2nqJzE4+Vy9HYQgVsF4hdBNmUr2+6yKufO30oXbtpmJNTy+TVfTyjwhj2cPeBkzf8E71XlZhn1CEnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mwkCorZZ; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-794ab20699cso8884385a.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 14:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716499280; x=1717104080; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vZ83DITT8+71M9hZZLFbFwj221tiAKCa3CoSsZtHtG0=;
        b=mwkCorZZFgx1BxAueNuTcBOSggPKz0OYGo33ul3jWegyIJkWO8rYWFmX9pss/0dD79
         VfgpcaJjz3NGxOS7+Ho4rFwwo5WwvvFklSHlGMl6Ew8ZeiFFGTXhQfNcBqKTYOq31a/5
         +6YZtrq24JAan4OhhoH0JTKn6noel/VkkV0fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716499280; x=1717104080;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZ83DITT8+71M9hZZLFbFwj221tiAKCa3CoSsZtHtG0=;
        b=O5NfIt1mMiHZizGbFZlq3RZL+6sZ5VN/u0/8SomnOO+L9lIP2D5AgNXqQ0c1T3MWcq
         bMtr54vmYNBa4Cy7tGlF/7//mM+yb4SQu5ZTYYausbrVWx7Pae9aOrOrzsiQjdYyiA5J
         g4H10WZEWTXFLXwbSFZeHrUaGkzrdeC+fQFymVtZyGcgNFseMcA11/SlC6NC0Wa0ZOTL
         4lNiIxfNtPSArPlCmtCrc+Qeye4RfopcnrYJ9nqJhEs/4GIc6Ve1NSIfZeKykDV12MxX
         YZTyGeedhOJ8p6iVh8laMfdsw1RnDlGL1YtWZPDOG+iAnUP5W9UVJiGEzQuhL2mIxeQu
         uzoA==
X-Forwarded-Encrypted: i=1; AJvYcCVtS1f0IzECKCT+m5kE0mJToATzGpR4n2FVy45D4DSr73aXyzW81QOtcqy9eMnyusLPynnvENNsiAHoWjm+WBC+ushwgWkGrMavsME5
X-Gm-Message-State: AOJu0YyFL+6cM5hQIB4uLdVgceJlSVQ9zxWmWXw+B+wTN9QfQfw0wDQy
	u3BauWifU2hh/1AQYd/PhB31xIjU9f8S3bo+i8XulpVgz0i7ojhpHTxRlcizmzkFd6jDpIk4xzf
	hGa+msA0+burRPS1lH9ZJMjo93UW29TOj2k7f
X-Google-Smtp-Source: AGHT+IFjL+VWQfPxSqxR4aZu/onNvALWc1WiN/6Uf4tzU7N3k9tqKuSjNUhBCdKJsEsHttt47nWNY6CUCfaDhionSzs=
X-Received: by 2002:a05:620a:268f:b0:790:b192:3b9d with SMTP id
 af79cd13be357-794ab0f8350mr45174985a.58.1716499280217; Thu, 23 May 2024
 14:21:20 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 23 May 2024 17:21:19 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240523194500.2958192-1-robh@kernel.org>
References: <20240523194500.2958192-1-robh@kernel.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Thu, 23 May 2024 17:21:19 -0400
Message-ID: <CAE-0n52UhgxauMgctx903UW=smEiYQSoRWdym2kkKGvODvztQA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: usb: realtek,rts5411: Add missing
 "additionalProperties" on child nodes
To: Conor Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Matthias Kaehlcke <mka@chromium.org>, Rob Herring <robh@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Rob Herring (Arm) (2024-05-23 12:44:59)
> All nodes need an explicit additionalProperties or unevaluatedProperties
> unless a $ref has one that's false. As that is not the case with
> usb-device.yaml, "additionalProperties" is needed here.
>
> Fixes: c44d9dab31d6 ("dt-bindings: usb: Add downstream facing ports to realtek binding")
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

