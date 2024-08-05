Return-Path: <linux-kernel+bounces-275357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5FA9483D5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6BF81F220A0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 21:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAC216B741;
	Mon,  5 Aug 2024 21:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CCOp4SjD"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE7816B388
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 21:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722892094; cv=none; b=oG5o2yzN6cn6tYSCbbtm+P/+HXuAuAMmbJ0p6MRLLeSwJsVC116SYdxGOkVLcnU4yVGjFhoBExn6AA+1l+RvmZ+LyVZvz+VrZiX0R4PR3MGqoxExHH2+IKuv4EC+Kx9oTD8w3nQjLSY19Awybd9L9SktyddQD/RlvTXLEkoybi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722892094; c=relaxed/simple;
	bh=1hgE1tHYTzoNT4ZaVAJ9uX7zwlujJ5HbNKj22V8PvTg=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=D6f0RVrW5ey/MB4pO9kTFLmi4DU3806VIiEX1QcrdhCc7INwaCpuW0iCpnVkzyvEMg5M9aEx6OBaix8KqJb/r6ZmyxeEX9eEZSNCRa/HfCm/LGCHPGeNpbmvSRPz8mdRpYToq3n1iz3v1dZt10oOo+YxUOQNT7uLntIbIrG2wFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CCOp4SjD; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-38252b3a90eso221615ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 14:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722892091; x=1723496891; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RoZN9WiORe0ITjlZlmSzWf3fhNCsHe6Tv0uWDr+78DY=;
        b=CCOp4SjDrTb9uWQitAer6R3CNc17jeUszVR3sXWB0cnxT0zba7Jjj0s87FJ65y3jYH
         vvew9mFtNWURCfXuy0qNaEI4VX2t3jmK9z80LCl5R/0//5UkWQ7tCYqNyP5730aBkCtK
         dziEunfYEHrYOKp1Wrqyr5QRyy9u1SDbhxiRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722892091; x=1723496891;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RoZN9WiORe0ITjlZlmSzWf3fhNCsHe6Tv0uWDr+78DY=;
        b=xJa1N/IkSxKGbZaz2lKCeeUq/v0xISeITJOM3Cl6xA6L1XSbp5y2ZXMCnMJPXBSV5u
         d2ILnWcXqhd0Y5GBNYEeBVD4o2QFZvbAU4lkT74IAoZ7Pjd30lWAPd7r6QV2jM9PW0ps
         KcpxJNgt2Cbk9ywSXXHGJtofE8630QO300BiMrVvceg2gMd91He3X8oqz7jSdSaSPyJF
         7gDk5P5ytmVSs1mkKu9/JEyIEL0H1mCSYxIA31CqiZoFz6KhjawcKkIDamaN4hXIrTUt
         m6Awwlw8v/20fsnk+e4YqO0x5RDU16k6khaw3kaKbEfq/+StBkRUKXK6yJk02x5gmRu8
         6Q5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBkxwoR7kYgXMzvp5cxxUfKdMk0aW/d/HGGbQGAtZqqBDd2UQy7X6eD6jTZRD2l82dQKERHZtBT6hj1N/NfpUFrimKO4lb+aWEpxjy
X-Gm-Message-State: AOJu0YytCI4YOE9xyfOu2cm7gvM0veXW48NNxDIAVWenb/Ub0T4AAC6X
	AMZMlomAfKUR1g/r2PD9buTEnXpQIUVWlO2/qeG890KOHpYMY4u2Ur79JRWp7ls=
X-Google-Smtp-Source: AGHT+IG06IJu0JjiFmVnxTP6Y8qg0xKaMfM6fJWXNb6BQKehWJuVWwjXR3HnoavVyGtfFIUnPoP4fA==
X-Received: by 2002:a5d:8b0a:0:b0:81f:dccd:844e with SMTP id ca18e2360f4ac-81fdccd8609mr580759839f.0.1722892091241;
        Mon, 05 Aug 2024 14:08:11 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d6a5ad04sm1907722173.178.2024.08.05.14.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 14:08:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------LlER0KbKGvSKZ6L4wyCWLfpp"
Message-ID: <732e15a1-f219-45b1-8836-ebd5ca3101cf@linuxfoundation.org>
Date: Mon, 5 Aug 2024 15:08:10 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 6.11-rc3

This is a multi-part message in MIME format.
--------------LlER0KbKGvSKZ6L4wyCWLfpp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the kselftest fixes update for Linux 6.11-rc3.

This kselftest fixes update consists of a single fix to the conditional
in ksft.py script which incorrectly flags a test suite failed when there
are skipped tests in the mix. The logic is fixed to take skipped tests
into account and report the test as passed.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

   Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.11-rc3

for you to fetch changes up to 170c966cbe274e664288cfc12ee919d5e706dc50:

   selftests: ksft: Fix finished() helper exit code on skipped tests (2024-07-31 11:38:56 -0600)

----------------------------------------------------------------
linux_kselftest-fixes-6.11-rc3

This kselftest fixes update consists of a single fix to the conditional
in ksft.py script which incorrectly flags a test suite failed when there
are skipped tests in the mix. The logic is fixed to take skipped tests
into account and report the test as passed.

----------------------------------------------------------------
Laura Nao (1):
       selftests: ksft: Fix finished() helper exit code on skipped tests

  tools/testing/selftests/kselftest/ksft.py | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)
----------------------------------------------------------------
--------------LlER0KbKGvSKZ6L4wyCWLfpp
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-fixes-6.11-rc3.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-fixes-6.11-rc3.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2tzZWxmdGVzdC9rc2Z0LnB5
IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3NlbGZ0ZXN0L2tzZnQucHkKaW5kZXggY2Q4
OWZiMmJjMTBlLi5iZjIxNTc5MGE4OWQgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2tzZWxmdGVzdC9rc2Z0LnB5CisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2tzZWxmdGVzdC9rc2Z0LnB5CkBAIC03MCw3ICs3MCw3IEBAIGRlZiB0ZXN0X3Jlc3VsdChj
b25kaXRpb24sIGRlc2NyaXB0aW9uPSIiKToKIAogCiBkZWYgZmluaXNoZWQoKToKLSAgICBp
ZiBrc2Z0X2NudFsicGFzcyJdID09IGtzZnRfbnVtX3Rlc3RzOgorICAgIGlmIGtzZnRfY250
WyJwYXNzIl0gKyBrc2Z0X2NudFsic2tpcCJdID09IGtzZnRfbnVtX3Rlc3RzOgogICAgICAg
ICBleGl0X2NvZGUgPSBLU0ZUX1BBU1MKICAgICBlbHNlOgogICAgICAgICBleGl0X2NvZGUg
PSBLU0ZUX0ZBSUwK

--------------LlER0KbKGvSKZ6L4wyCWLfpp--

