Return-Path: <linux-kernel+bounces-372356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA639A479E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0FAB1F248DD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FD520010F;
	Fri, 18 Oct 2024 20:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nw3GzzIm"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDA576C61
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729281909; cv=none; b=EC30oo/6S5qI5M5UZsOyjD6H0iMXN2o3N13XXch/UrT2B3tfd8/uN0Npz/80qh8a5z4BaY09LSHBE54cipl7f2PYeXA/f4z27swH+DxHHoXgdYvVO7MMOKJemMYRJK/Kuc/oH5osU8rqNIO424ymTLX39L+WzjuEq9heYrWI++s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729281909; c=relaxed/simple;
	bh=mkaOtpb3HNeDJA0nxy7+7OowOpaC33RcU/eLe93HduA=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To:Cc; b=E9dqLIyVRF8WN4OEcoAEo2fn+urLnXxkxByxmhjAP6R/CeRzqFf2CyP9uAqAN2tj9OVXhjXsADc1iKZnTdhLdDKfqfirMED1/OKCnscyRpUBejBnw57/xElie2IzJmT2fDTMKB1IJlzpEqHnAqZM1wMOgVFrySS9vQHTy8alN6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nw3GzzIm; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a3b6b281d4so10174585ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729281906; x=1729886706; darn=vger.kernel.org;
        h=cc:to:subject:from:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rPxHTXyKrbypbqAH2vVCeHWTcQMbDX/8MEJl9C0+I7A=;
        b=Nw3GzzImwuXW6o4JIZyRY2qF3ItNh//irPkZRJVBtit/njkavAkjK1c/AlZN3ikdiT
         g8z3SUhiWEpUUv2Si6ebGA43LhGhicS6wDqL0BAbLtBa9+62o1njXiGFTtznNx3Oa+wh
         VM+hqR+c/kwA8tbOPCa98CEl0zM+yB0sgJyDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729281906; x=1729886706;
        h=cc:to:subject:from:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rPxHTXyKrbypbqAH2vVCeHWTcQMbDX/8MEJl9C0+I7A=;
        b=deJHbCVciozA10njjAhjYZBB8NVseso6ikHnfZB+ylBOKfWiktgZLX5nd7ttNk7bxU
         wBnPUE6Q5rxO0eR200nxpx/HrzVOdJ0/c21LdVx45VoS8V2GTiyBB2FG0vHiLry5TWZN
         J+rTa6XK32xU2GnRvZK1rikmSDbbGAjyI2aoScgcGEXjvsjDfD6K6UiCH/OFTzIldy73
         yQVtpC/Ql9X70BKNNTCvMco2LW0XpI1sXsdUir/YttrhfQhgkOE3zADoGqn10EI9LJ9s
         kC8EMWJfcqFIccOJ6jxWHtCr2PtpLlfaOKEIiPFhQt11ZNIbB583t1aQmvXbOIrOWNhJ
         ua9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8eMDGi585WlZiDZIesuW1/KCUkFiOcHfLL/ScKtL7SWIHIaeQifTFOFHOq78OdhuNkWKOc9g1eyajZI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOS5o8gaN5Rk13mRttJthM1icComrx5IdeyEWDhx7eA77ADx7d
	iUNyi+iJp4iTPOrZNxcuCyFlxbPrFKbVidJrsLEUENLPnp8YUjQnY6zI1qnMSLYIPM4m5z1HFE7
	V
X-Google-Smtp-Source: AGHT+IFoS8dBAqr9LnFIvB1nC4+F22eafH96GYg4T3IeiyRLXhgA3mdRdXgQaRAS8j+4rtJWvCQXZw==
X-Received: by 2002:a92:190d:0:b0:3a3:f860:9c79 with SMTP id e9e14a558f8ab-3a3f860c229mr13965005ab.18.1729281906207;
        Fri, 18 Oct 2024 13:05:06 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc10c67f35sm574680173.158.2024.10.18.13.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 13:05:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------ZlneuxfJq1Xpvfa6ANCD9Syw"
Message-ID: <399ec96b-1d84-4aa0-9030-0e42282a6d4a@linuxfoundation.org>
Date: Fri, 18 Oct 2024 14:05:04 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 6.12-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------ZlneuxfJq1Xpvfa6ANCD9Syw
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following kselftest fixes update for Linux 6.12-rc4.

-- fixes test makefile to install tests directory without which
    the test fails with errors.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 4ee5ca9a29384fcf3f18232fdf8474166dea8dca:

   ftrace/selftest: Test combination of function_graph tracer and function profiler

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.12-rc4

for you to fetch changes up to fe05c40ca9c18cfdb003f639a30fc78a7ab49519:

   selftest: hid: add the missing tests directory (2024-10-16 15:55:14 -0600)

----------------------------------------------------------------
linux_kselftest-fixes-6.12-rc4

kselftest fixes for Linux 6.12-rc4

-- fixes test makefile to install tests directory without which
    the test fails with errors.

----------------------------------------------------------------
Yun Lu (1):
       selftest: hid: add the missing tests directory

  tools/testing/selftests/hid/Makefile | 1 +
  1 file changed, 1 insertion(+)
----------------------------------------------------------------
--------------ZlneuxfJq1Xpvfa6ANCD9Syw
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-fixes-6.12-rc4.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-fixes-6.12-rc4.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2hpZC9NYWtlZmlsZSBiL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2hpZC9NYWtlZmlsZQppbmRleCAzOGFlMzFiYjA3YjUu
LjY2MjIwOWY1ZmFiYyAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvaGlk
L01ha2VmaWxlCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2hpZC9NYWtlZmlsZQpA
QCAtMTgsNiArMTgsNyBAQCBURVNUX1BST0dTICs9IGhpZC11c2JfY3Jhc2guc2gKIFRFU1Rf
UFJPR1MgKz0gaGlkLXdhY29tLnNoCiAKIFRFU1RfRklMRVMgOj0gcnVuLWhpZC10b29scy10
ZXN0cy5zaAorVEVTVF9GSUxFUyArPSB0ZXN0cwogCiBDWFggPz0gJChDUk9TU19DT01QSUxF
KWcrKwogCg==

--------------ZlneuxfJq1Xpvfa6ANCD9Syw--

