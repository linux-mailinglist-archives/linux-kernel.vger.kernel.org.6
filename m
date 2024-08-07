Return-Path: <linux-kernel+bounces-277692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0956194A4DC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E822816C4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDFB175D2C;
	Wed,  7 Aug 2024 10:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9kj3NBk"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F87156222
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 10:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723024816; cv=none; b=Hz1XC1chi61Zj3TDKqvHFRY+ZpRvr/aDVkn2ZvPygUy4mlJgsmRbLDHTZJtLf3A24OcRcYbxPJNqm/ari+yS68+AjQcIVVXvLX2xy6OfTtBTCl0HBXnUT44x4R5hX6kvIMXOyA5K4zrK0SLfsERnlbzcHlO1TwIpQM1Q7KZgyhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723024816; c=relaxed/simple;
	bh=GqvsbHVEaAB9Mf7/CvfjwhNaqZb/jsQ0OdiRt74ABkA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=M7/uMYzwAeQ7LkMw6/GpuC2CEWn7AFY3hG86JY9425j6MYJANuxqgAS8lPNqV+7USaY04vMTsi37HTWCW+Rweldzspzq0NH2zipWBMtZSFxkcN4d4o7Qd9ufn0q/Dcr64lSkVNGSsnJGUSPnH1nVIV2Bex4NwerTqzpv/Kn0mws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9kj3NBk; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-65fe1239f12so14489447b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 03:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723024814; x=1723629614; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GqvsbHVEaAB9Mf7/CvfjwhNaqZb/jsQ0OdiRt74ABkA=;
        b=J9kj3NBkNCayNLQfPHx7a9ehFOaCNXx7jnG0LOb180KF/aga9CzR3HTgPkLkPHeQ3L
         nsFv3j4npgBr+CDTaPhE58rzpQl+c7Ql0lt2k8GnAglOrcxX4nrc+VP0kzk7drRzJkKd
         jxB6xaXRfV3wMrsekYeZTAzbVTBAkO0VrdV13glFT0wLlYpAcaYI3eSyM/kB+jQVMvT0
         sWNRRBVzV8ozF0fmGlXT2JLGmuWbjUMFSzwIzu2DdR++JXZgtl6BwA8SgAzxRRBwANJ2
         CH/vVcy/sImfl0R8KrAZnYLhGJRtvULAnnAmvnmmT98F1C+LqdLununAYH7XYdMTJppO
         kxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723024814; x=1723629614;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GqvsbHVEaAB9Mf7/CvfjwhNaqZb/jsQ0OdiRt74ABkA=;
        b=as6tswe+YVN1MgDAUDuMnwwL0FYUAFaZBkIVBWizu/yo33rxRZhnOGYEwDJYYmtEnz
         8N6v+X+V3/wOQVtUD7lTFwhMWTDjf7C/jvcIwlVvqus7qSfbMnLD6e0KNvFvOR1tGZHi
         h9RpWRMwsMMtBjbKsoVMMBLTJ9M4tULF6a5FRxVcEio9PAzfGZDz/rZIelgsl1noHvly
         X9sHRsEhpYI0Y+DVJOAm+e+ii3Wpd1+cxTf8sjTGu8mfTYEPYyPwcXBsEdKncU3TIlC5
         1qVtW7J23Zr2Uak4B+VK9+udK5bwQxY8PgJ8+b9K7ECxqR7RXNVhT80oTxUx6iWlrR1w
         12Ew==
X-Gm-Message-State: AOJu0Ywmxh3kQTqlPbrtT0QKTXDoNGn84wEkqZipwv8QNUgRB5vOnpFZ
	ThB3cIZ2LgXMn+NQwF6ib5ypdVGGARDDystWleIQEr/ROQFgzvZmXX7OkdTYUjz3RGBtZTHCgpZ
	XeO1M2psiuxk4FBAORH7bn82jzCO+za+rnAs=
X-Google-Smtp-Source: AGHT+IFGhGWkz7og2AY4zDC9aAdvurcqZu/CuMr/x0iYxvBURSpPHz3XYxYCZb56UM2miT0Tjr+Ibwv/Id06JuI4Ftg=
X-Received: by 2002:a0d:c9c6:0:b0:627:de5d:cf36 with SMTP id
 00721157ae682-689645923ebmr173542237b3.39.1723024813745; Wed, 07 Aug 2024
 03:00:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dileep Sankhla <dileepsankhla.ds@gmail.com>
Date: Wed, 7 Aug 2024 21:04:39 +0530
Message-ID: <CAHxc4bv79yDMbMo+nUYWK+QwGgoQhRGJTsV_fzqRfrbd4moBbg@mail.gmail.com>
Subject: new Contributors in the Raam Computer Software System Core are welcome
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Raam Raam sa everyone (greeting with God's name :) ),

I am Dileep Sankhla from Bhilwara, Rajasthan, India. I am a software
engineer and I've been creating Raam Computer Software System and its
Core since February. Both the Computer Software System and its Core
are different from the (Unix) operating system and its kernel.

You can find the project repository at [1].

There are many errors in the drivers that need to be corrected and new
concepts are needed to be discussed before being implemented. You can
solve the issue(s) and make Raam Core work on your laptop/desktop PCs.
It will be the best hack for you and thus your contributions will help
others too.


Regards,
Dileep

[1]: https://github.com/robstat7/Raam

