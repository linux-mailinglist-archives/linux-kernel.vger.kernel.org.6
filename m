Return-Path: <linux-kernel+bounces-300590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 053BC95E58F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 00:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D72C01C2099E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 22:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D4B76F17;
	Sun, 25 Aug 2024 22:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZY3Ay+Yt"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D722729CEC;
	Sun, 25 Aug 2024 22:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724625561; cv=none; b=WNIXBezbO+7i/UnIEPZsSRsLWS0VMl4UrUpWWUUohuvx9OolX2vwedMVC9L3H9v9E6r2z4B7XhS1CnzVfbUEc0VmwN2G7hqt3Wi2MnS5QDt3pdVipIudO4lmPJNHdRMRvaMtB/ZhA5NxpffT84MWxqn+EDpaNvHDgwVyGx9lfuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724625561; c=relaxed/simple;
	bh=A8yKiAJiZ9+dK8Dac3BbyPZjFgAcyrIfwBNuirmo8W0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BIzTmo1BW5/BRBSyhWMLjIb2f+h9hFDmLIZThZj2LR0q/gcm6s1t59UDtjJBjuxWejX6CSw1KJBQy0a5PvIureMEJIxRXJzTn6eGAXp5+xiRuFKKMhuxC8NGYaNEONrlnlRS/YR6YdMU8OGe8PXMkulVRVEgzW5NWz09SsrIT8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZY3Ay+Yt; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7143185edf2so3057189b3a.0;
        Sun, 25 Aug 2024 15:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724625559; x=1725230359; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A8yKiAJiZ9+dK8Dac3BbyPZjFgAcyrIfwBNuirmo8W0=;
        b=ZY3Ay+YtpytYB4dZnEDSoi2Y+iYPlnWFe4QlVDtuqLYdRh3aLd9CtNaAh7z+OGny64
         OmkYgRDjxaR3bW+glc9XRGmUJuesdTI2AcFx7JUElvV3yu5P5H5PhRCJu8btSzcqxWY4
         qtIuC+vIsJorKWJxvThbR+u1csVp49as7T8EYnk5oQcgSN7GxnAQxZ9I3HjPcpDzWepX
         epEToudj1LEoVXvl5yWbqH1ALu3JjOKIS6C0d+PTpeyEkvEBky5qRLAUlxAbmiq7VClg
         pT9YkB0Oi74CIe/hiN6nzPGmwo0lXSwtD3c8FK7ajLGBXxdc28tMjqAmmFDoFF0wMVCO
         5Pjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724625559; x=1725230359;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A8yKiAJiZ9+dK8Dac3BbyPZjFgAcyrIfwBNuirmo8W0=;
        b=WltiCaAPqkhtAKGL2IzREx93CrK8g5JbAV+Oul9mE7EaI0c0cdbtIxgf/UuVRhExpU
         Le1ZVpfx66Vmmx8hja6kHTErQ2iFtGj92S+P+c0Mt/PQNjf1uwiBTLqGmuXzvJUd8Oty
         W0tiKYuzAHtT8zLKkGMVPPicQfNrvuk7X3Le7M+XhhJ8CsWufM4ipqBSyjtUfWmIn3Rg
         BMoGNhTfGtY6+Jjkf9PeqTOYXGepNFtP0sF8M1hDlmSyWeQNw62r9sgbSaYLZReH6suy
         Mg5YYdWTCoxqY+6XKozLud8x2N9X2+PA/JEftsuxr3tlz7W4+Bhn+0nsglnZnXk/VXRE
         gsCw==
X-Forwarded-Encrypted: i=1; AJvYcCXT7SDtS7htOr7dlTIuVkSBor3er+90j52nd/qclt6PeQC47ivV8qVx8YFr18tWTputLnpINP3nKaraHa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YziPLPJFnjlJKe5vy2lJUgkFDU3AvI4t2s3V6uFMFq82Np39tEN
	ED1k4lP0aclWrMfQmVnTNMlA5A4Eh1LSYFcYsL8tfWBHuPhLCQQH
X-Google-Smtp-Source: AGHT+IGTR0K3SMhIGJvKAdRaKXp+kAHK75mt1qIKKM9G1s0y55MvSX5N3pASe3f8SLFYYgEOoJzmxA==
X-Received: by 2002:a05:6a00:1805:b0:714:3325:d8e9 with SMTP id d2e1a72fcca58-71445e1153fmr10855368b3a.22.1724625559079;
        Sun, 25 Aug 2024 15:39:19 -0700 (PDT)
Received: from ?IPv6:2405:201:f022:f804:2fa2:fde0:4987:3a52? ([2405:201:f022:f804:2fa2:fde0:4987:3a52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143430a260sm6016675b3a.157.2024.08.25.15.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 15:39:18 -0700 (PDT)
Message-ID: <2ff61088a046d49d8afa708f2a5da024604b823a.camel@gmail.com>
Subject: Re: [PATCH] scripts/checkpatch.pl: check for non-permalinks to Zulip
From: BiscuitBobby <simeddon@gmail.com>
To: Joe Perches <joe@perches.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, apw@canonical.com, 
	ojeda@kernel.org
Date: Mon, 26 Aug 2024 04:09:13 +0530
In-Reply-To: <f53fa069b9cc24a9552d54c7a004fe6d@perches.com>
References: <20240825221806.253575-1-simeddon@gmail.com>
	 <f53fa069b9cc24a9552d54c7a004fe6d@perches.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-08-25 at 15:23 -0700, Joe Perches wrote:
> On 2024-08-25 15:18, Siddharth Menon wrote:
> > Zulip links to https://rust-for-linux.zulipchat.com=C2=A0can break in
> > case of renaming the topic or channel if they are not a message
> > links (which are permalinks).
>=20
> Why should these links be used in the kernel at all?

To my understanding, most of the discussion around the=C2=A0
development of the Rust subsystem takes place here, and is
frequently referenced in the mailing list.

