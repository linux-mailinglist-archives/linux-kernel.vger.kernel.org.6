Return-Path: <linux-kernel+bounces-198483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8D98D7923
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 01:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0FFE1C20CC5
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 23:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8D17CF34;
	Sun,  2 Jun 2024 23:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howett-net.20230601.gappssmtp.com header.i=@howett-net.20230601.gappssmtp.com header.b="sNF2t+UK"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B7F3FBAD
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 23:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717371019; cv=none; b=bfOj753dPF9f7q6WO5A55TTdlXrtcn2CKv6SZ5r7zbByCOeJoblzEEaE5/82bAcUyDo9vBtOkpp98hSALr9SVqrzYL9Dm1N1yDDeSQhA56IWQbaWK+s6SFeTU0POJIKKnA41W2LFCyHqbVcqGKDeQYXOzsJH+fJyTpkCPfl9h6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717371019; c=relaxed/simple;
	bh=pMhsyKu03RmnmNJkv3yey1MD984VPwGhQB3gl4lX4tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PLPOs5VkUufRYKsihiBA0y0mNW1fAxqmZ1agZP84cL2JvrcC+0XE6kPR9VTDE8dcL/cZtKroq4zR6Qj/DSw+akBllmd4eYTnAwlpytKF/E4w1xKBAYp+A9/up4By5dVfXjfDggvDzBOiUYusIkC1YftWfsSDcykgoSPQwvwCFkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howett.net; spf=none smtp.mailfrom=howett.net; dkim=pass (2048-bit key) header.d=howett-net.20230601.gappssmtp.com header.i=@howett-net.20230601.gappssmtp.com header.b=sNF2t+UK; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howett.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=howett.net
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dfa8427f22dso1658203276.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 16:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=howett-net.20230601.gappssmtp.com; s=20230601; t=1717371017; x=1717975817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mA62qSvfUgabP8dHNNLvavVQ1hj8KoRhl88lff9+uKA=;
        b=sNF2t+UKeuOoaLrKZGUybsg96BQzBdLaUvP3d4w3TMdefvNj6Q1qQA0L78p2hw7/Z0
         0E/JLE0laQb1qmA6URiPh/zQMjXz6ODMGqcT//Nx7Y96voC/eNsytF5GaEm2Mc3SgN0R
         JELByR6bWq26dFyy7QJCPr/7FIBV35xdL7iUVCdPGYfNhlmlXVD9kIooek7/ldFZ2/PR
         DzWsLSboSjnnA7nBHsTp7BWasT1RmlFWQn1nwWVGTy7t10YOvNI2bKjPmho7a5VQmlEF
         xvy+mFz+aVfC1+RITc4s9PoRuRZkxtqvFmUrShslguCaxEC7I8HvUbV0m1WBtL+XhxuW
         PLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717371017; x=1717975817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mA62qSvfUgabP8dHNNLvavVQ1hj8KoRhl88lff9+uKA=;
        b=w4jYYvG19uFxhIfAVz93mK+QiUgO4N4A3/PhnKPPeQcGcLK3kGBWt7nUvTWLBAsXIc
         JK0LgZwbGWgntwvgwvCTECRO9jeFVQZ/R0va2UT/6PXeHlbc9MjfUE9PIW26bRbkyH62
         A72E8HKFY1lLhe8w+Si2b4JLR2UznrEFtavcffMNrEm0iCEEOayATHTcPkdFy7/ozewA
         HxmDELYoPyVr/1Jz97F3g/NZY2tHmt0dHjX06c7By9XvBoivvqVQKLq6OUOr+TlwOwgO
         claT1rMEDYiTYLRNmbK6pXQYPmpZmw3AWELuVqvToRvP55ruGNxwWY21QQrEAWd01Cqg
         0hoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMJLgmVziUdW1/AXoKbtFlRN//IXY0n1ANQUjqUzdSarflqXQC/QUzMoisqh7H/FDBHhcQPEis/Ov5m4qBrMG2715v8PTnYv9Ml7EI
X-Gm-Message-State: AOJu0Yzmw42+tY4qKT3Ozu6e11z37YqbKGTCRNoi2ftEDZqyDtH9VHvf
	zb06QX96xTwbqtfDwsYNVR6pF5LTcCoHzgaYj9gI0wCK8zQAnB453DERGL0krNBOlxmJYPg2N9I
	g8ncHg7j+Jp7144DGXXkG98wscZSLXlUzCtCo3WQyI2ZxV4SNW2Yi
X-Google-Smtp-Source: AGHT+IH2wwVcPgtl3GNQdMf+HzL/lgwUkqm8BGFm5dIJFA3xpzq6zxsZqPM2NhtHVxlko5L+l8gNF8Ck50mvlyjfVRI=
X-Received: by 2002:a25:bc08:0:b0:df7:978a:73de with SMTP id
 3f1490d57ef6-dfa73c1da12mr7346043276.19.1717371017435; Sun, 02 Jun 2024
 16:30:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531-cros_ec-led-v2-0-6cc34408b40d@weissschuh.net>
In-Reply-To: <20240531-cros_ec-led-v2-0-6cc34408b40d@weissschuh.net>
From: Dustin Howett <dustin@howett.net>
Date: Sun, 2 Jun 2024 18:30:06 -0500
Message-ID: <CA+BfgNJf1Av7fRVUjpU3r6aRw6DWTHfkCuOYXP2ykhPzGTVzfw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] ChromeOS Embedded Controller LED driver
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, linux-leds@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 11:33=E2=80=AFAM Thomas Wei=C3=9Fschuh <linux@weiss=
schuh.net> wrote:
>
> Add a LED driver that supports the LED devices exposed by the
> ChromeOS Embedded Controller.

I've tested this out on the Framework Laptop 13, 11th gen intel core
and AMD Ryzen 7040 editions.

It works fairly well! I found a couple minor issues in day-to-day use:

- Restoring the trigger to chromeos-auto does not always put the EC
back in control, e.g. the side lights no longer return to reporting
charge status.
  I believe this happens when you move from any trigger except "none"
to chromeos-auto, without first setting "none".
- The multicolor intensities report 6x 100 by default; if you set the
brightness with the intensities set as such, it becomes only red. I
would have
  expected intensities of 100 0 0 0 0 0 if that were the case

Thomas, I apologize for the duplicate message; my mail client config
here defaults to "reply" rather than "reply all."

Thanks,
Dustin

>
> Best regards,
> --
> Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>

