Return-Path: <linux-kernel+bounces-248950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5479992E450
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12F5F28232F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA1E1586F5;
	Thu, 11 Jul 2024 10:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPbXmwf+"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689064779E;
	Thu, 11 Jul 2024 10:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693040; cv=none; b=Y74QxowV/CtG+eHjtSsyKcgqxXFwo9XgnDkqspN10OFNoTG2P6jQGTRQWzOFcx7w01sRLTj89ff5VZwOywsnVXw4XvEqNq38rbSktiZ1RynP8xekMqOXa/ThnTcUtsFm/WLrNnxoT+OTS+R1MRhpzK47HTfNSP8GCS3FkHIVbIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693040; c=relaxed/simple;
	bh=/SH2t526dhX39mtIBzC9dl7zRsTEaWsVBT9qJQAA7Pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pj8luQcfnKexplDVsyH17v58AXVT3bnT6WuVCVeRGtnhCkzHBmBHYWGnFwMugGPRdEqUCDeDZm/rzVmDZWPcymN8HsfsGZJISwaOoemjieLA1k7a5zZ8jEWEUcECzwbYOTTz+D8pOhcdGjrxW0wfT54CDBy93dQXr3NO181P2OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPbXmwf+; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5c66b53232aso332412eaf.1;
        Thu, 11 Jul 2024 03:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720693038; x=1721297838; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/SH2t526dhX39mtIBzC9dl7zRsTEaWsVBT9qJQAA7Pg=;
        b=fPbXmwf+yxxnhW6apUj8r8AwhaVAe4lmwovYpyt89dMK6NofKIZvaZY54unTWOJ6+d
         rAU5NjzfAX1cs+U0umN5w+ZVWQWKY4Y0ApagyhyPWEKtsZZKCProb4hDCo3EKY78AiON
         Doci3h4fioEcwtRJr5AXZSs2n95m8LwFLYIMPcntEEUHviZQVrJ5xxTSKLsPeNfEIQuE
         ibtx/Ea6mRS6PDNAT0YIZOAS01z4VT9HrPEF2HMIvKHpTjkUwW85Ys2brR4ptTwrZ6ft
         nF7kcwqNvVWzIcw9u59kbnwSMZe1msb5hwg3+NI6LRaVptpvvsz4s1NweUbPXvcgWuyr
         FP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720693038; x=1721297838;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/SH2t526dhX39mtIBzC9dl7zRsTEaWsVBT9qJQAA7Pg=;
        b=Lm7b8D6lsYEvPBR/+A6l6VQjxzL9W2YnhxK4Ky4u3DNyqLzUhY8NY4McahDMlA54o7
         wHhuScBXsGcp3rScOkuiAW1Waw+20vt0YT6uuvUJv2RipOoknBOBDntDx55aBAcVRo9t
         NsiwbQH8FqTcodcat6Sox3xuJucOdIwGgInZbexHp5X9CEpSwkInonL6GbfhiobjPVPj
         UCKZn7h8L+nv7SjlQ52vTE171mGKdCS57OCwxYbUhNy/CDCFTVn3V/0EObOuw6dXHI/h
         99xZsbEruAJyARCW/tfqmJXi14dMxao2H7+djeyrl7ilUNeA/KbVKJLhedB/ql2ZDPWl
         I06g==
X-Forwarded-Encrypted: i=1; AJvYcCVbCDvojo2LKncRy3XOMDb7mpKHhs8dBFwrLTflvd6JI/PH8jFCb01esuU4IJI0kvf1fggmkQTFhtwgfu2CO4tyWfqHPhamWNpa6FrEK7l0rcgz4LRGwJeKGYnHODq8lOTR0was0xSQwA==
X-Gm-Message-State: AOJu0YwIi+1LZAj8AHX98FLCwIGVSVW8MYdCldI4ZRBaCk08VrIuhEGs
	q9vwUv9cx35eMUR7ALlR7c+Ek8NgC/O78Jy+1j7sMBh2U3J7IkN/9+p/oA2qd5ti+8jNMf0xVb/
	hPPPtsdyIlNU197b+bizy3slnOys=
X-Google-Smtp-Source: AGHT+IHE0CUu5uCHf8wuz70NvrhLwZ46PB/m2KnHmeab6LkAZaTxoQqnxGgC50x0jjH9cWOx4W08eoAx0h6xKooKYdU=
X-Received: by 2002:a4a:1d02:0:b0:5c4:10df:c479 with SMTP id
 006d021491bc7-5c68e0a1392mr8324798eaf.2.1720693038361; Thu, 11 Jul 2024
 03:17:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711060939.1128-1-linux.amoon@gmail.com> <a8c1f49e-bf25-4fd3-a16f-13088f75767f@kwiboo.se>
 <CANAwSgQCn3jgiruiLs0cu-C+DguLtnk=msboAh8jNSF4P28gjA@mail.gmail.com> <2017670.43MJ0K8Myn@bagend>
In-Reply-To: <2017670.43MJ0K8Myn@bagend>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 11 Jul 2024 15:47:02 +0530
Message-ID: <CANAwSgQjTc7_DFyTSx8VSMmr69tYM=iSVc51RxgRoasj8Stgrg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add missing pinctrl for PCIe30x4 node
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, linux-rockchip@lists.infradead.org, 
	Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Diederik,

On Thu, 11 Jul 2024 at 15:35, Diederik de Haas <didi.debian@cknow.org> wrote:
>
> On Thursday, 11 July 2024 11:09:48 CEST Anand Moon wrote:
> > Ok but it is better to update this in rk3588s-pinctrl.dtsi
>
> It's probably better to base your patch(es) on Heiko's 'for-next' (or 'v6.11-
> armsoc/dts64') branch as that file no longer exists there

Ok.

Thanks
-Anand

