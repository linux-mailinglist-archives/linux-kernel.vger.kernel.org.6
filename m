Return-Path: <linux-kernel+bounces-510173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9BDA3194C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B72FC166773
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4955D268FC4;
	Tue, 11 Feb 2025 23:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcW1HqYk"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D69B27293C;
	Tue, 11 Feb 2025 23:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739315236; cv=none; b=VLYYpjbPYRIp/KGNT5u0Ux0aghi2sVMvWS7crTUcX74rWW+HkONuX3bhk6J0+So4J+2H3/H2z/LAiD3qwaUfb7jjifGLc2dK67AT3Xd2ot0PXWL6JjvJsHmHClLP+2oopJ37OwTxK8jZbcajwegyBm8v/lC8VIK281Xwy7G+PEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739315236; c=relaxed/simple;
	bh=1KmHuJvJglTZaEI1I7tdb97fgzeM4K4tUbmOUv77ww4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kn806+tSscnN+Ew1STqJkNHZ22yLepmeKQKeeaK82upAnaXrqNFl4fITKY1Kl7SVrWQjrkt5SpjLsLr/wMso8YYRj59HgNItQNZXxVWTLCAvWvjY8yNfHBhRBCvWNDMvdGZtmspuCp9eE6ZJoWj6ezTyyhhuUatk5k4vMBSzQoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcW1HqYk; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6efe4e3d698so57055357b3.0;
        Tue, 11 Feb 2025 15:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739315234; x=1739920034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjUlPt7fQIbCG9HRI9aLi8iTstRFShKsOWhK8luHgiY=;
        b=mcW1HqYkbuoOh0G32GaWA49dsH3rSp9SVRQlxmUBhejQbIT0gzy2S2F/ju/qOSZxQu
         hMN5P1RbSF2aB7h2cbjCMUmN9pZLHMKQ2SY2qNBMHW8XJzzQ3vhW3rOIuY4TynoG+4KD
         yQzwA5GwNcLdOoGYDOMpdIkXhFLwL5eCH42wR3o70QHLDC/ZjZX9DkYHpSA83wmryO3U
         G45G9/V4RLOi5zkckOwGkXwnnZThOdiv7V0GXfyPc/4MJj/UXM/fKud/h42E6QTymacy
         F6GoYj7ty8HT27KW+51Nm8T9H0Cp1dZ2YfdXXWzCqfIMb1B6MfLHKpEJ+8zXVztOeY6+
         yKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739315234; x=1739920034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CjUlPt7fQIbCG9HRI9aLi8iTstRFShKsOWhK8luHgiY=;
        b=e0WjFmlcCk2y/1+MLpHFIcrtEorq4uQ81JSe7yZFm/03vUg6JpC8ccdXOp+DB8jEfo
         bAJGizDMdgto/Oq7c0j2TZSMP4OFBkBaNz7s1t9A0kp+wzUA3B13w2/5CuHx0a53DD4s
         2vyNDNKZpJaDNU1wQdx6oQpArNxloCIFgmRBaN74RNYAK3mM+Bc/Yvat/vF0cHBbT3K1
         PjFZ9/uOleG82n51FdfeBb72F3vg0PVXQCK6nOc9FFvkgHTucI7ByyLDZeNXnpXvJV5h
         f7fOxlUojnlRzgPfpvLIW9tqcI0aRf4GHQGMQYp+NZgu0ZXflTSdkK3aR3bTau6P39cx
         QRLg==
X-Forwarded-Encrypted: i=1; AJvYcCV3lYbsxYwmqhKyPmDnJSJlYZvEs+ZqK9nYGRm88C4CNfquZwcJQHkrycI9M8hTwOskQcjotKBn5Ksj@vger.kernel.org, AJvYcCXp65yDgQNMvdsrFtUKqFWqwwdtoEhEJORbb7zmjxRix0ZCi7nyd/C7iSq/9NdENwJHVCpmWrdyjFX9hPw9@vger.kernel.org
X-Gm-Message-State: AOJu0YwYV//1JxEOyp7P3bedUXwT21dRFBO1/5p3ocdo/FjFxa3CVnbi
	UP1Q7esTrcHO8PCHtsY0JXj8nx0AIV62QTIW+V0/EiMdRvfy41pfgEL4gCg6yjKvz1MLmfnbK4j
	HmWQazBG8fPkIpu0Dfy+8azcd5aQ=
X-Gm-Gg: ASbGncsk71L/+iSHTFPJ4z66+4k3I/bXAf8MOy63yrq6olyhicgdZAuJdgvzX/eXgzF
	+jNe0DcBB3bktpp9wHnq08H9Ge1/sEXr40+Fw7zsgRtH/VlTNQiHzVReqeSbuQiXm6AIvRnKkRg
	==
X-Google-Smtp-Source: AGHT+IGXt31L2dPfJdVvqFBxiTcALOlz9ju4ydo5Tk9yYDo/4DuIc6WAoXrf+LCnTVdr88ds23cuOt9d7uq2eXMLJ/c=
X-Received: by 2002:a05:690c:6911:b0:6f9:ad48:a3c7 with SMTP id
 00721157ae682-6fb1f1e5e09mr12938727b3.21.1739315234067; Tue, 11 Feb 2025
 15:07:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211181839.1575497-1-robertcnelson@gmail.com> <20250211181839.1575497-2-robertcnelson@gmail.com>
In-Reply-To: <20250211181839.1575497-2-robertcnelson@gmail.com>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Tue, 11 Feb 2025 17:06:47 -0600
X-Gm-Features: AWEUYZnnrz1uhSEz7DwUdf6zeY2QTmIpy4WAgTlvlUWiFBO6xPeRHOiXv3ja3Iw
Message-ID: <CAOCHtYhpvt1_jBqJGRsX3BO_jnn_cqemY+jgVTObUg2pKQ3Sdw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: ti: Add k3-am62-pocketbeagle2
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
	Andrew Davis <afd@ti.com>, Roger Quadros <rogerq@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Judith Mendez <jm@ti.com>, Andrei Aldea <a-aldea@ti.com>, Jason Kridner <jkridner@beagleboard.org>, 
	Deepak Khatri <lorforlinux@beagleboard.org>, Ayush Singh <ayush@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 12:18=E2=80=AFPM Robert Nelson <robertcnelson@gmail=
.com> wrote:
>
> BeagleBoard.org PocketBeagle 2 is an upgraded version of the popular
> PocketBeagle.  It is based on Texas Instruments AM6232 SoC. Its dual
> A53 cores can provide higher performance than classic PocketBeagle.
> The new design comes with pre-soldered headers, a 3-pin JST-SH 1.00mm
> UART debug port, a USB-C port, Texas Instruments MSPM0L1105 Cortex-M0+
> MCU for ADC, 512MB RAM, and a LiPo Battery charger.
>
> https://www.beagleboard.org/boards/pocketbeagle-2
> https://openbeagle.org/pocketbeagle/pocketbeagle-

Broken copy/paste by me, this is:
https://openbeagle.org/pocketbeagle/pocketbeagle-2

Regards,

--=20
Robert Nelson
https://rcn-ee.com/

