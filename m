Return-Path: <linux-kernel+bounces-242943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BFB928F61
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 00:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE411F23131
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 22:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A1D146A71;
	Fri,  5 Jul 2024 22:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OLFzEhrT"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8921C693
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 22:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720219543; cv=none; b=rj0/xDs3/xejV4mr7Asojh1mo7BbI7uYw8ak4nylbYL8DCwKDk1qLRnFnzp/GufnpVGnTwSMFJsPr1Tc9vCqbNZMcZ2omRGuyioeXbvA1DA1uVoN+SY5CrBIvncyd2trQKoI5zk+0BMeZ37i2fNIWj9x/Yt6TQisYShAX9EneLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720219543; c=relaxed/simple;
	bh=J2u1qHCiKCA3RfsyCI2pggoYFpbeaiFVXegTV/9f4hI=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=WQVADvOooi5Vn4gvzBU/b0GVNHEu/ysfoXFZ9n+5tFq1E3n/eP5CccsxI/WV4c/9W/+KmHUNhJ2oJpoaHJ/vnIgF5lFeH1y/ZLkMtQb7Nj6XZd5250pSguwSCjvJm3+5nA2WzQOv6VJ4aoiCRNGwGl56ToRqabQ7nK+y7Nm0SZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OLFzEhrT; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7f653005b54so4628539f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 15:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720219540; x=1720824340; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XPMYfJWmf3WNCz84K05Te7W0yqGn9oyU7AN35KIwYek=;
        b=OLFzEhrTE6L9HUJZfU0NgoXaZ9Pa7O0tEZjN/ttgVEdvpijgDuFM3euIpEprE/+m02
         9f8B5CZX6iHygVjZMPKV9xYCHcK9JGZR/9K7ohuO2cg4ZKICOzQKp7lUwMN66cFxNhiD
         gTJjqntesu7eGpm69lU1JrEaz+hoaobehuy+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720219540; x=1720824340;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XPMYfJWmf3WNCz84K05Te7W0yqGn9oyU7AN35KIwYek=;
        b=CXRCwLgrklMndDDuFN3Y4WH0XXvrB/r3skldaMNdCB/ovkl6LdLSogv7pksSOAzYI9
         HuTCscii26rsBAciytjGKWwJOqIcLlRasXBUNG//FOLJ2AB9sZlkrjoIiCSyi6caIXvy
         t6jIyDSYV4i0VMEDoOrTNxWfs+HuveF5hWEme7BkfNX967nNt0nR7pMvqEI7tcPqawNr
         AQPZcu2oFSWDWRaQOGyGUB2Jz08GrpzOOFWjxIFCqEkVGKZhuxiVIB6mI3CUT0k0lkt0
         zXTSi5LrOHBbz/ncyt2GzRcWMnBgEMhjlC8PqdBpoANVF34c6ZmVKoMjw812tzMMIfL7
         74Iw==
X-Forwarded-Encrypted: i=1; AJvYcCXrVE0lJ1wDeiYU9KuSKNM03r3pfv0B611zjIZfmo9sW4XMkZePi5amVyUQoxLhtpeSYdZz5ZrkqTpzzs9apc1s9CTzsvTsLeXCfvXq
X-Gm-Message-State: AOJu0YwXc9kq4ciIJB9a9kUf3IhQkyRMOXQVz+3LxjjOaoKMBcJEwwKp
	Gh8BjpLJCaoADlUOIjV5ahKxjb3x3dyP5ItWMIpcljcwGr/c1kbvgGh5AnJGBT8=
X-Google-Smtp-Source: AGHT+IFiOtWsyaxb1z0ZzXLScuB6n4UhuXRTJth4ktjjKG0Ac43ITwVD9tXgNdHw5GjyVxL8f3BU/A==
X-Received: by 2002:a05:6602:6183:b0:7f8:bfcd:db3e with SMTP id ca18e2360f4ac-7f8bfcddd04mr3425139f.0.1720219540586;
        Fri, 05 Jul 2024 15:45:40 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73bb374dsm4604825173.36.2024.07.05.15.45.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 15:45:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------boPeTQlb4MMG8ACs0OicDOlH"
Message-ID: <00aaf29c-e638-4161-90fa-49eff270598e@linuxfoundation.org>
Date: Fri, 5 Jul 2024 16:45:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thomas Renninger <trenn@suse.de>, Shuah Khan <skhan@linuxfoundation.org>,
 shuah <shuah@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower second update for Linux 6.11-rc1

This is a multi-part message in MIME format.
--------------boPeTQlb4MMG8ACs0OicDOlH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following cpupower second update for Linux 6.11-rc1.

This cpupower second update for Linux 6.11-rc1 consists of

-- fix to install cpupower library in standard librray intall
    location - /usr/lib
-- disable direct build of cpupower bench as it can only be
    built from the cpupower main makefile.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 3e1f12c26646eb0ad67d3eaefd32f765997da6a8:

   cpupower: Change the var type of the 'monitor' subcommand display mode (2024-06-20 10:08:08 -0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-6.11-rc1-2

for you to fetch changes up to 3a5bb5066f4c7170e850b930e84b1075e25f8e90:

   cpupower: fix lib default installation path (2024-07-02 15:30:32 -0600)

----------------------------------------------------------------
linux-cpupower-6.11-rc1-2

This cpupower second update for Linux 6.11-rc1 consists of

-- fix to install cpupower library in standard librray intall
    location - /usr/lib
-- disable direct build of cpupower bench as it can only be
   built from the cpupower main makefile.

----------------------------------------------------------------
Roman Storozhenko (2):
       cpupower: Disable direct build of the 'bench' subproject
       cpupower: fix lib default installation path

  tools/power/cpupower/Makefile       | 10 +---------
  tools/power/cpupower/bench/Makefile |  5 +++++
  2 files changed, 6 insertions(+), 9 deletions(-)
----------------------------------------------------------------
--------------boPeTQlb4MMG8ACs0OicDOlH
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-cpupower-6.11-rc1-2.diff"
Content-Disposition: attachment; filename="linux-cpupower-6.11-rc1-2.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL01ha2VmaWxlIGIvdG9vbHMvcG93
ZXIvY3B1cG93ZXIvTWFrZWZpbGUKaW5kZXggY2QwMjI1YTMxMmI0Li42YzAyZjQwMTA2OWUg
MTAwNjQ0Ci0tLSBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL01ha2VmaWxlCisrKyBiL3Rvb2xz
L3Bvd2VyL2NwdXBvd2VyL01ha2VmaWxlCkBAIC02Nyw2ICs2Nyw3IEBAIExBTkdVQUdFUyA9
IAkJCWRlIGZyIGl0IGNzIHB0IGthCiBiaW5kaXIgPz0JL3Vzci9iaW4KIHNiaW5kaXIgPz0J
L3Vzci9zYmluCiBtYW5kaXIgPz0JL3Vzci9tYW4KK2xpYmRpciA/PQkvdXNyL2xpYgogaW5j
bHVkZWRpciA/PQkvdXNyL2luY2x1ZGUKIGxvY2FsZWRpciA/PQkvdXNyL3NoYXJlL2xvY2Fs
ZQogZG9jZGlyID89ICAgICAgIC91c3Ivc2hhcmUvZG9jL3BhY2thZ2VzL2NwdXBvd2VyCkBA
IC05NCwxNSArOTUsNiBAQCBSQU5MSUIgPSAkKENST1NTKXJhbmxpYgogSE9TVENDID0gZ2Nj
CiBNS0RJUiA9IG1rZGlyCiAKLSMgNjRiaXQgbGlicmFyeSBkZXRlY3Rpb24KLWluY2x1ZGUg
Li4vLi4vc2NyaXB0cy9NYWtlZmlsZS5hcmNoCi0KLWlmZXEgKCQoSVNfNjRfQklUKSwgMSkK
LWxpYmRpciA/PQkvdXNyL2xpYjY0Ci1lbHNlCi1saWJkaXIgPz0JL3Vzci9saWIKLWVuZGlm
Ci0KICMgTm93IHdlIHNldCB1cCB0aGUgYnVpbGQgc3lzdGVtCiAjCiAKZGlmZiAtLWdpdCBh
L3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2JlbmNoL01ha2VmaWxlIGIvdG9vbHMvcG93ZXIvY3B1
cG93ZXIvYmVuY2gvTWFrZWZpbGUKaW5kZXggYTRiOTAyZjllMWM0Li4zNGU1ODk0NDc2ZWIg
MTAwNjQ0Ci0tLSBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2JlbmNoL01ha2VmaWxlCisrKyBi
L3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2JlbmNoL01ha2VmaWxlCkBAIC0xLDQgKzEsOSBAQAog
IyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMAoraWZlcSAoJChNQUtFTEVWRUwp
LDApCiskKGVycm9yIFRoaXMgTWFrZWZpbGUgaXMgbm90IGludGVuZGVkIHRvIGJlIHJ1biBz
dGFuZGFsb25lLCBidXQgb25seSBhcyBhIHBhcnQgXAorb2YgdGhlICBtYWluIG9uZSBpbiB0
aGUgcGFyZW50IGRpcikKK2VuZGlmCisKIE9VVFBVVCA6PSAuLwogaWZlcSAoIiQob3JpZ2lu
IE8pIiwgImNvbW1hbmQgbGluZSIpCiBpZm5lcSAoJChPKSwpCg==

--------------boPeTQlb4MMG8ACs0OicDOlH--

