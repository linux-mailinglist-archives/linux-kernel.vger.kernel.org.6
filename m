Return-Path: <linux-kernel+bounces-273405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C809468DA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 11:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A556281F42
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 09:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1176C14D703;
	Sat,  3 Aug 2024 09:34:03 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2DA14D71D;
	Sat,  3 Aug 2024 09:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722677642; cv=none; b=S6eYirl5+n1hJZJKQRxFUZkRuOQ3UH0QlBMqGfT5QkmVggn4VFmsUeXjeOcSzr+zqXRqD8BiitwfL2rGjFyvTuV46HUGcMVftK9BMH5z//x7irpJ2KfQTLEIKnrChdQE9TRLtKxDIJTsfAGv+Gk70JhCx4uwP7DCli2FnsdoS1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722677642; c=relaxed/simple;
	bh=t8jFB3MlH1ttBJTsGsXDawHxlfg8fXyGs1RYvm8Cv0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDocq7QJA9qmA+lq10sTxOSEouAZBclPwqSLt3pdLAaI9+RsOm5mfzOxhlbITJT27tTJbQztw09ctgnlykUZe0YodnLyS4eaDsS+o0GviG3Bg0/uksuygmYyb4MFVIhBAjjN07G3the2XNbymkZvtMYiTl6wqFVKXSry5YbksJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 4739Xts0029246;
	Sat, 3 Aug 2024 11:33:55 +0200
Date: Sat, 3 Aug 2024 11:33:55 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 06/12] selftests/nolibc: avoid passing NULL to
 printf("%s")
Message-ID: <20240803093355.GC29127@1wt.eu>
References: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
 <20240728-nolibc-llvm-v1-6-bc384269bc35@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240728-nolibc-llvm-v1-6-bc384269bc35@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Jul 28, 2024 at 12:10:00PM +0200, Thomas Weißschuh wrote:
> Clang on higher optimization levels detects that NULL is passed to
> printf("%s") and warns about it.
> Avoid the warning.

I don't see why this would be a problem, we do explicitly check for
NULL in our printf implementation and print "(null)". Or maybe it is
upset due to the attribute(printf) ? I don't know what the standard
says regarding %s and NULL, though. If it says that NULL is forbidden
then I can understand the warning and your fix is indeed correct. In
any case it's not worth fighting with a compiler for nolibc-test, but
it's probably worth mentioning in the commit message that it warns
despite the check being already done.

Willy

