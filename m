Return-Path: <linux-kernel+bounces-387177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E999B4D1C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 544051C2264D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F258C192D75;
	Tue, 29 Oct 2024 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="utgnz4zF"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466911885BD
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214648; cv=none; b=nG0Yn6zCoxh2WUDzuIwSt5zUPEaIdeUEoPCWQ4Rm7Z0vFL4pD2VlYdhA9FJjEtKB5RC7TGDGjVr+NCg6iLBScK1knZ95vYULyY3QMK2Uh20MFZgfE5oG32w2NnuKCW7/CN9jHy/GlR3vqI6h3XDi1y3SFnWX/GIwSdBrmxnPvJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214648; c=relaxed/simple;
	bh=pClzO/h/JROTqlyb6Hk2ZQp5fgFIM9FnfxbvzImRHqc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ryt5g++I8VcMGWA4BmQPWJkAw8C4AdqFp42p0i9bBADcE36PP7nl02El1H/ppV+VsP7j8Qae5HAD7fcQaW8czYC8EptRNnzRjCoWJC9Z/JnTR3noPoO9UtubngrYlyZbJNAM6uTFIjtbRQBaYxLRk3YLOPQqhs/dzcdzP6wmiQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=utgnz4zF; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d4eac48d8so506905f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1730214645; x=1730819445; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pClzO/h/JROTqlyb6Hk2ZQp5fgFIM9FnfxbvzImRHqc=;
        b=utgnz4zFdhOy+7YMXbpmLXje74h8m4lx6u2cnRXuc5S/at09whA4C9h2KfYMSv1JD9
         juWl5Pjp680KnOnpL68XpitftNI24T3uHHls3B6h8LS6+4jOYJhRQG6LghZqE5vofUcx
         QYKmbFMV273ySUzS8eRqM6w0RGwzVk0pirsZamw+23DTNK7+xYE4rIfP3kWowGS5ZNxA
         RkN5LeevWUDzCbTB12hmkt6Cr1vKvfRSpWIeVx02CP9WxlkfjJKZLlT4lEemTONphmFn
         EguMZ5QUpGQtQcHsLIxOvIzRgJg1/76kVc08+ckJ/jnnM+ZZIrXcXqLf0cihOaQMlqmb
         bRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730214645; x=1730819445;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pClzO/h/JROTqlyb6Hk2ZQp5fgFIM9FnfxbvzImRHqc=;
        b=pg74+MGUUDXLgw/5yEo19GLfv85XFd9AqaMagMrJYQWB3VZxO5ARBn8VpWjl5bz92T
         UUDD0HpPaYBBZm3NU8VtZIqaIAjMU/uNlOjASlUgtC8LFOblTLI6S4/rCAswXf/vLNJ/
         b6eo8rru9P2RY7gbgrB3IVR1yUhcJkntBvgsaEQ6dCrntg3ZrNl0MLMzet+gnHKVfkta
         eQMBl/p3t34Dvj5vJ2/rtgZYuQh8PMs5SwgW3Lmko4dCDHuWECpKlaiZYzGX+BOm7QzS
         l4GPrc6aoZ0UBloVC5pONpm3dZOiwil89OuSAsTkyWCXDkh/L51OuAJBmC/8JcdrZYIt
         TTow==
X-Forwarded-Encrypted: i=1; AJvYcCVR4u7QxTX91TDEayKJOUAeuqWS1CPS1J8sYVrakZacDLRufxQAFD0isazi4i2rg0C//saiXhdCmYSF/rI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZuEkM7ON7mndsitQ8ZOpyBm6UPByS+4Vsl1PfHAbWPxfWKwWl
	lBXRuSTM1dLkt5233P62ZpV+kl9PNfY5gAuNcUNf7y+cj6pNMbXlcFPV+kxUBZs=
X-Google-Smtp-Source: AGHT+IHpB0gsXiLgIYq0IllOpj0RLaS+RFkgWPXNM/xk1DTGgHY978z6z+pWhDKYuiUIrS2oulAcag==
X-Received: by 2002:a5d:6d86:0:b0:374:cd01:8b72 with SMTP id ffacd0b85a97d-380611fe6dcmr4253149f8f.9.1730214644521;
        Tue, 29 Oct 2024 08:10:44 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:a4f:301:c1bf:2b25:a6db:6ae3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b713fbsm12813482f8f.88.2024.10.29.08.10.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2024 08:10:44 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH 1/1] Compiler Attributes: disable __counted_by for clang <
 19.1.3
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <20241029140036.577804-2-kernel@jfarr.cc>
Date: Tue, 29 Oct 2024 16:10:32 +0100
Cc: kees@kernel.org,
 nathan@kernel.org,
 ojeda@kernel.org,
 ndesaulniers@google.com,
 morbo@google.com,
 justinstitt@google.com,
 ardb@kernel.org,
 oliver.sang@intel.com,
 gustavoars@kernel.org,
 kent.overstreet@linux.dev,
 arnd@arndb.de,
 gregkh@linuxfoundation.org,
 akpm@linux-foundation.org,
 tavianator@tavianator.com,
 linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3ADD56B1-9BBF-48CD-81C7-53E10675F566@toblux.com>
References: <20241029140036.577804-1-kernel@jfarr.cc>
 <20241029140036.577804-2-kernel@jfarr.cc>
To: Jan Hendrik Farr <kernel@jfarr.cc>
X-Mailer: Apple Mail (2.3776.700.51.11.1)

On 29. Oct 2024, at 15:00, Jan Hendrik Farr wrote:
>=20
> This patch disables __counted_by for clang versions < 19.1.3 because
> of the two issues listed below. It does this by introducing
> CONFIG_CC_HAS_COUNTED_BY.
>=20
> 1. clang < 19.1.2 has a bug that can lead to __bdos returning 0:
> https://github.com/llvm/llvm-project/pull/110497
>=20
> 2. clang < 19.1.3 has a bug that can lead to __bdos being off by 4:
> https://github.com/llvm/llvm-project/pull/112636
>=20
> Fixes: c8248faf3ca2 ("Compiler Attributes: counted_by: Adjust name and =
identifier expansion")
> Cc: stable@vger.kernel.org # 6.6.x: 16c31dd7fdf6: Compiler Attributes: =
counted_by: bump min gcc version
> Cc: stable@vger.kernel.org # 6.6.x: 2993eb7a8d34: Compiler Attributes: =
counted_by: fixup clang URL
> Cc: stable@vger.kernel.org # 6.6.x: 231dc3f0c936: lkdtm/bugs: Improve =
warning message for compilers without counted_by support
> Cc: stable@vger.kernel.org # 6.6.x
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: =
https://lore.kernel.org/all/20240913164630.GA4091534@thelio-3990X/
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: =
https://lore.kernel.org/oe-lkp/202409260949.a1254989-oliver.sang@intel.com=

> Link: =
https://lore.kernel.org/all/Zw8iawAF5W2uzGuh@archlinux/T/#m204c09f63c07658=
6a02d194b87dffc7e81b8de7b
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Jan Hendrik Farr <kernel@jfarr.cc>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Thanks for fixing this and your work on the Clang issues. Feel free to =
add:

Reviewed-by: Thorsten Blum <thorsten.blum@linux.dev>


