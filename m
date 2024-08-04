Return-Path: <linux-kernel+bounces-273948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0D694700A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 19:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C9E01C20B43
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 17:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E51132464;
	Sun,  4 Aug 2024 17:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="HSp+gB8E"
Received: from mail-40141.protonmail.ch (mail-40141.protonmail.ch [185.70.40.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB011DFF7
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722792659; cv=none; b=hsD0PqExn/AT0vyKiJksnzaa9JQc1WUhvLv8rkyxE7QOwaZqkImD6L4HZ0+ZkXOCiFky/ER/SADGgKdkFa/Xj24AvVNdwQ5E0RShoUB/jVF9pqd9g59o3/E+auPgnixp3Er4OazRnS/+cb8DXmEKav+2giDv62T5XyNblTqb1xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722792659; c=relaxed/simple;
	bh=NrpE9A7s9hUHaKVHxLNhBiSSsIr6DckW22aA06zNK4E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JB/i68ipBWe7cpY8j1iyv+65G6r1xGacD3YeVbTsE5wfhKmjoTT1AnyvDeA5lrHbuO56TLssfzHVpYhvUZcCcjJwwQYkr7xuC+U/qCQZKT2KnL358uwR+aC6zWUlWcePs1cIujjI9e3stxNfouU0RjYjew8CT9CAyeYoZ6HiXxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=HSp+gB8E; arc=none smtp.client-ip=185.70.40.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1722792649; x=1723051849;
	bh=NrpE9A7s9hUHaKVHxLNhBiSSsIr6DckW22aA06zNK4E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=HSp+gB8EyU82Vk117gQTbwX170moY/ocnxm6lT38LWWGvn/bSeax7qjo0mweBAQYv
	 ZFZD9dIV2xtDesQrPDXeHOgVp7tIZXXz2Q1US9h7uF9hD+t3L/UN0F4qVW3pEH43Nb
	 2AGUEzhDj18YjnaiaME6NyjKVKUc70jE5U7iUgVQY0vxT8g9S7h9/YCqoONNuwdFio
	 pgHsf5LxyJCR37BLs6fxAhj29bpxzD2Y1rf3tlEqHgxp+UDUSSQuFbI2AVlO2OuUbU
	 j9oOlrsFHZEK9MTVfflTswur62aBQlsWiLu33ZZY1XAgxSd2uaAcZKQ9+yYbSYV5Xn
	 MFw8YzxsoZwGw==
Date: Sun, 04 Aug 2024 17:30:43 +0000
To: Thomas Gleixner <tglx@linutronix.de>
From: Koakuma <koachan@protonmail.com>
Cc: Koakuma via B4 Relay <devnull+koachan.protonmail.com@kernel.org>, "David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] sparc/vdso: Add helper function for 64-bit right shift on 32-bit target
Message-ID: <Y5IejvnMTMbzucl5EK4C9ptWTnkPJlPJVKyCj1L1o2_2GPbmY5GZ55bKckWzKATaZcFF9SLCcvI4EMOhG3sifxCgEtkSdV2KDhv5jRBy9wk=@protonmail.com>
In-Reply-To: <871q3470nn.ffs@tglx>
References: <20240804-sparc-shr64-v1-1-25050968339a@protonmail.com> <871q3470nn.ffs@tglx>
Feedback-ID: 6608610:user:proton
X-Pm-Message-ID: 9858cf0fcd665db6b35828cfbd1ff9a85c1f0d11
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Gleixner <tglx@linutronix.de> wrote:
> Why does this sparc'ism need to be in generic code?

Doesn't x86 also have a couple functions that live in math64.h anyway?
That's why I thought it is fine to put it in there...

In any case, though, I am open to moving the function to sparc directory,
if that is indeed the proper place for that function.

