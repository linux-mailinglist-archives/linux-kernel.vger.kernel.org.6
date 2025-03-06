Return-Path: <linux-kernel+bounces-549767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2323A55711
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36AB2169DE2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E89727426C;
	Thu,  6 Mar 2025 19:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X8icVlPx"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F7A271833
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 19:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741290414; cv=none; b=n6htS/PoBqfujLIWOdU847nW5Yp4E/8kgZZwEZBPcOS5dWxgCcc1XLZkzdzvWykmoVRtxy74Npuld5sZET8XYq1OrQqaSgKfDhgl+dr+d19CqxT0Y82S1LeexFzFCQYopImxfs0ROX0cfe/W4/cYsM0I8Db5r6nsre6AuvXlo+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741290414; c=relaxed/simple;
	bh=Qy7zGsJTaXY4YvT3V6KgAR44azxYg0LCKGz4DciGpLw=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To:Cc; b=RDeireccJRkHKdy53sa5WembaZrZ6jSehitTEesaR/DH9YB9mX9zKKvOi1qvgTi8lWr8FWRq6Pg8N4O5mINWS6ZxHLzdTKJpuYsZL4i9qwUICrqf2zyRGe3aw9RzldMZkkZ25PExGg5Oxa3wJYCHhcROTGvXWmQt5en3RmwVMWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X8icVlPx; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-854a68f5afcso27674339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 11:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741290412; x=1741895212; darn=vger.kernel.org;
        h=cc:to:subject:from:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vAZsrQ5pHfKfGgxDS14zPnvQCXj7F1Vy1cfr1GUo/8Q=;
        b=X8icVlPxEPYrMHLFFVZ8vqVsvKbTOHHHtSW6jsCeDfgwViL9cu06PeZ8ykuy9Mge8Y
         dLIrvIcDzUvzJI87Fz8+Ou8dgGQU5Qp8so5UgEzCMOpxAfTRwccSKP8NFGAIxEbbfTzp
         h52bz4mr7j5YZ8VDMRfgQ76XlIREM/0/4kS58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741290412; x=1741895212;
        h=cc:to:subject:from:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vAZsrQ5pHfKfGgxDS14zPnvQCXj7F1Vy1cfr1GUo/8Q=;
        b=n7c/by8ei4pN/otskJQ0v2iipHewvaQhgEnCqkmYcVre0QoBntMsrxcnyoEXC/F2WA
         qPG8ZM8x1Y8Cf1nE2qUcR1vbL9Dj0tHF02ChgrA0MQvVkl/Hui0ew6nCKexGm4I3KJd4
         N5iJLOZxEEregAqbq8J7WFqpHeeCeGLWdWu+1BEH/8FWPnt7lIEOxbi8axEDh2tHvZ9w
         sj35H6F4/ZqsZantzoVFxybaLIGeYS4cwpZAzFTkq3Ycf/0wzWtP+sbR2Kv2gaUcek9l
         yy5bj+58YM8E3/l2z0ZSvkl9sOFm8c3yPsSRClHW5d+gkfF075M4HtAXBAo+AzzwX812
         TcHw==
X-Forwarded-Encrypted: i=1; AJvYcCUdevZttigSzsKTUUfbpx/yJ14Ryz97rBD+iDUGOc0LNQSHtGEsKPvn3M7h3bymRXtClK3YNkgA9RqgjoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzJhE3RadCxwuH52AibkyhQuVdtIFKbMzYOpDrEi1xUS5VocdJ
	XY16S+s6jclUhjjWZW1MGUs42iLcACwhXjaRBz1gbgfpWuFQF7LVsDr78+ElrfU=
X-Gm-Gg: ASbGnctA3vbm7y9nTiUi6ooo8TQMAeD8mzfQ42FFAis/Q2RGhCFBanO4fxz60g5lr45
	KhOGF/uvNr/Yq9Ar1G4TImHg8oiWdByK8B9e+fNNExmt7bg6F0FKObj4XMBTUJPNSfg1B1GVSK+
	w81xRzlVvxPSj6aLkZXrhwlPnGYswN+sP+P3MchRMsL/os4absMfwvvKR6tAzW2AysZGYOREeYW
	xOBDIRigWifWwqfJyZ2VTONwEcA9Ni0Ho4L6PqvyKZIFhfculgpbHJ1mVAYtqGiBG3nJuGQ6ZT9
	I+a7n+tqHMj6WUof6FhPG8i6bCB1NMa6ON/lEY1sphw1nLMUckNHt+8=
X-Google-Smtp-Source: AGHT+IE4jehB2r0k/L1GncTFMRlZv1hWZJcvcV/y63BhnbuVN9R9itnxTvtsR2t8iDnag8rzRyLbxQ==
X-Received: by 2002:a05:6602:3818:b0:85a:fd12:9270 with SMTP id ca18e2360f4ac-85b1d05d2e3mr108030739f.10.1741290411723;
        Thu, 06 Mar 2025 11:46:51 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f209dee919sm518783173.15.2025.03.06.11.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 11:46:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------w78nUxmUbzxQVn2eMG0M3ZMu"
Message-ID: <a3344fc3-c7ea-44ae-8fc8-86184315a58f@linuxfoundation.org>
Date: Thu, 6 Mar 2025 12:46:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Linux Media vimc update for Linux 6.15-rc1
To: Mauro Carvalho Chehab <mchehab@kernel.org>, hverkuil@xs4all.nl
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>

This is a multi-part message in MIME format.
--------------w78nUxmUbzxQVn2eMG0M3ZMu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mauro,

Please pull the following vimc update for Linux 6.15-rc1.

Fixes a bug in vimc streamer pipeline init code found by syzbot.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

   Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-vimc-6.15-rc1

for you to fetch changes up to d6813eb9c3de01307801f253d89d777b4669a0d0:

   media: vimc: skip .s_stream() for stopped entities (2025-03-06 09:11:39 -0700)

----------------------------------------------------------------
linux-vimc-6.15-rc1

Fixes a bug in vimc streamer pipeline init code found by syzbot.

----------------------------------------------------------------
Nikita Zhandarovich (1):
       media: vimc: skip .s_stream() for stopped entities

  drivers/media/test-drivers/vimc/vimc-streamer.c | 6 ++++++
  1 file changed, 6 insertions(+)
----------------------------------------------------------------
--------------w78nUxmUbzxQVn2eMG0M3ZMu
Content-Type: text/x-patch; charset=UTF-8; name="linux-vimc-6.15-rc1.diff"
Content-Disposition: attachment; filename="linux-vimc-6.15-rc1.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvdGVzdC1kcml2ZXJzL3ZpbWMvdmltYy1zdHJl
YW1lci5jIGIvZHJpdmVycy9tZWRpYS90ZXN0LWRyaXZlcnMvdmltYy92aW1jLXN0cmVhbWVy
LmMKaW5kZXggODA3NTUxYTUxNDNiLi4xNWQ4NjNmOTdjYmYgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvbWVkaWEvdGVzdC1kcml2ZXJzL3ZpbWMvdmltYy1zdHJlYW1lci5jCisrKyBiL2RyaXZl
cnMvbWVkaWEvdGVzdC1kcml2ZXJzL3ZpbWMvdmltYy1zdHJlYW1lci5jCkBAIC01OSw2ICs1
OSwxMiBAQCBzdGF0aWMgdm9pZCB2aW1jX3N0cmVhbWVyX3BpcGVsaW5lX3Rlcm1pbmF0ZShz
dHJ1Y3QgdmltY19zdHJlYW0gKnN0cmVhbSkKIAkJCWNvbnRpbnVlOwogCiAJCXNkID0gbWVk
aWFfZW50aXR5X3RvX3Y0bDJfc3ViZGV2KHZlZC0+ZW50KTsKKwkJLyoKKwkJICogRG8gbm90
IGNhbGwgLnNfc3RyZWFtKCkgdG8gc3RvcCBhbiBhbHJlYWR5CisJCSAqIHN0b3BwZWQvdW5z
dGFydGVkIHN1YmRldi4KKwkJICovCisJCWlmICghdjRsMl9zdWJkZXZfaXNfc3RyZWFtaW5n
KHNkKSkKKwkJCWNvbnRpbnVlOwogCQl2NGwyX3N1YmRldl9jYWxsKHNkLCB2aWRlbywgc19z
dHJlYW0sIDApOwogCX0KIH0K

--------------w78nUxmUbzxQVn2eMG0M3ZMu--

