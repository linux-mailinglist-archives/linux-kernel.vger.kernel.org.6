Return-Path: <linux-kernel+bounces-238378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF21924998
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C6DE1C22A8A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 20:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE3520124F;
	Tue,  2 Jul 2024 20:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WoAbay4A"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5891BD513
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 20:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719953361; cv=none; b=rBfykMJDB1r5tIzr5GsELiR2TGSYSIjtnxDRcvnPby80K/HJ+6cDRFp2bXOO+YJraYEG5WSWE/xFW6nIV64V44E5sHmF4Yel/nRQW3EJwoFJ6bVF37xInTek7gXJnoJouBiD0osUt7Fzb6uj2ZwcCW36lyfdtBwqEdoOBbngWwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719953361; c=relaxed/simple;
	bh=MgR0RZP1WxJDF9dnlMLkpmneg2DO1jzVQiIEhyW6oas=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=cAPZ3ec5X212zhG2YvJ14rdm2TbdPsmplpF/Qcpcd4DcBzbDERaWamXmPviIkkmOUHrC578Wct9J4VN9O5d5DjU4mknxW6n7JittWbngLgs6sTFyrtu7L2h6Jj/Lr8WBjohsZqQgQxRGoomUWI651muBcar/pVtRLtCdu6klAO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WoAbay4A; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7f3d2f12d26so13050239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 13:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719953357; x=1720558157; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iLLKSn27p2evVRjhLNa5UY8CKY/YLlnkCm8VanWlXPM=;
        b=WoAbay4AkwFQnzsAYW/5xcmLN/fljL4a1Wn/VP9rabI/YOAeye7LI84Jtaf1T5mxnP
         rW6FXB40rj+qHRk95bICc5qH+H0fZwBvmSGrIUoB2jbgU52SlK2xm8NGQIiK8e/yI/Vo
         E9zn6dcILcX8W00QihlP3doZqFMshs3kSdShA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719953357; x=1720558157;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iLLKSn27p2evVRjhLNa5UY8CKY/YLlnkCm8VanWlXPM=;
        b=NGG+P93uQw8BgI5ws+UDQvVs0sOJ4mwbksXwzj3MCNUUo5lRpNS+uPVtT+4Q+4XpMp
         1ULB+1zLlhouTeE51Ijwbfz+HoiUmLy6n6os0zAFmjS3b5QKlPPKzx5JdZvksdRu/mWd
         Wkpbo9HAbKrVPCHHoUuRZk9VnzfD/AIg+kYmJEEmByae0hKlEaUvjK17DtkNZWn3/euL
         b8cOaBgdcxXu30kbM0ii+6xcBRwLviUXbCDWbeA2JQWxbqs4izPK58RaEjOXuNnVOm9V
         C/BPFS34KJf+yXm69ejhhJMuiZVOoO0eiBF4vLiazrH+wz1hIDhC1o9ia6WboAdg8A9f
         KdnA==
X-Forwarded-Encrypted: i=1; AJvYcCUeUEFjSOc0bRKRDS7nt7+IE9q65rVRoMrvyHX9yVgVjoVF6/Mjk1cowGl7B/Ht064s5NHqSs3NNY3+JATpGPq58OYxEIRFX2Rl2E6w
X-Gm-Message-State: AOJu0YwW+0tSlRDiraH2TAwGxtOD6mmd51PtaBdgpgezgloTLP2y+tv2
	//a2ik98C+PhwPjAYzqdkYenRq1EC4XdJiJFGHwA00zp0x94g/w1wzIwgPwgkF1wUZ6pCNFVXRC
	m
X-Google-Smtp-Source: AGHT+IGoamVC7yUj/wm+rd9r+5CC1jn1ABv+VOHDyGmteGriIkIhYfOPUvW5NbRU+eJF7FeAaEUPJg==
X-Received: by 2002:a05:6602:42c5:b0:7eb:69ec:43f2 with SMTP id ca18e2360f4ac-7f62ee5deaemr910660839f.1.1719953357391;
        Tue, 02 Jul 2024 13:49:17 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73bbdafdsm3040707173.24.2024.07.02.13.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 13:49:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------vKec7RVSzFt68m7lUfQmMBOZ"
Message-ID: <457af485-777d-4675-aea5-e3b77ccb8246@linuxfoundation.org>
Date: Tue, 2 Jul 2024 14:49:16 -0600
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
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes for Linux 6.10-rc7

This is a multi-part message in MIME format.
--------------vKec7RVSzFt68m7lUfQmMBOZ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull this kselftest fixes update for Linux 6.10-rc7.

This kselftest fixes update for Linux 6.10-rc7 consists of one single
patch to fix the non-contiguous CBM resctrl:

- AMD supports non-contiguous CBM but does not report it via CPUID. This
   test should not use CPUID on AMD to detect non-contiguous CBM support.
   Fix the problem so the test uses CPUID to discover non-contiguous CBM
   support only on Intel.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------

The following changes since commit ed3994ac847e0d6605f248e7f6776b1d4f445f4b:

   selftests/fchmodat2: fix clang build failure due to -static-libasan (2024-06-11 15:05:05 -0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.10-rc7

for you to fetch changes up to 48236960c06d32370bfa6f2cc408e786873262c8:

   selftests/resctrl: Fix non-contiguous CBM for AMD (2024-06-26 13:22:34 -0600)

----------------------------------------------------------------
linux_kselftest-fixes-6.10-rc7

This kselftest fixes update for Linux 6.10-rc7 consists of one single
patch to fix the non-contiguous CBM resctrl:

- AMD supports non-contiguous CBM but does not report it via CPUID. This
   test should not use CPUID on AMD to detect non-contiguous CBM support.
   Fix the problem so the test uses CPUID to discover non-contiguous CBM
   support only on Intel.

----------------------------------------------------------------
Babu Moger (1):
       selftests/resctrl: Fix non-contiguous CBM for AMD

  tools/testing/selftests/resctrl/cat_test.c | 32 ++++++++++++++++++++----------
  1 file changed, 22 insertions(+), 10 deletions(-)

----------------------------------------------------------------
--------------vKec7RVSzFt68m7lUfQmMBOZ
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-fixes-6.10-rc7.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-fixes-6.10-rc7.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvY2F0X3Rlc3Qu
YyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvY2F0X3Rlc3QuYwppbmRleCBj
NzY4NmZiNjY0MWEuLjU1MzE1ZWQ2OTVmNCAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvcmVzY3RybC9jYXRfdGVzdC5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL3Jlc2N0cmwvY2F0X3Rlc3QuYwpAQCAtMjkxLDExICsyOTEsMzAgQEAgc3RhdGljIGlu
dCBjYXRfcnVuX3Rlc3QoY29uc3Qgc3RydWN0IHJlc2N0cmxfdGVzdCAqdGVzdCwgY29uc3Qg
c3RydWN0IHVzZXJfcGFyYW0KIAlyZXR1cm4gcmV0OwogfQogCitzdGF0aWMgYm9vbCBhcmNo
X3N1cHBvcnRzX25vbmNvbnRfY2F0KGNvbnN0IHN0cnVjdCByZXNjdHJsX3Rlc3QgKnRlc3Qp
Cit7CisJdW5zaWduZWQgaW50IGVheCwgZWJ4LCBlY3gsIGVkeDsKKworCS8qIEFNRCBhbHdh
eXMgc3VwcG9ydHMgbm9uLWNvbnRpZ3VvdXMgQ0JNLiAqLworCWlmIChnZXRfdmVuZG9yKCkg
PT0gQVJDSF9BTUQpCisJCXJldHVybiB0cnVlOworCisJLyogSW50ZWwgc3VwcG9ydCBmb3Ig
bm9uLWNvbnRpZ3VvdXMgQ0JNIG5lZWRzIHRvIGJlIGRpc2NvdmVyZWQuICovCisJaWYgKCFz
dHJjbXAodGVzdC0+cmVzb3VyY2UsICJMMyIpKQorCQlfX2NwdWlkX2NvdW50KDB4MTAsIDEs
IGVheCwgZWJ4LCBlY3gsIGVkeCk7CisJZWxzZSBpZiAoIXN0cmNtcCh0ZXN0LT5yZXNvdXJj
ZSwgIkwyIikpCisJCV9fY3B1aWRfY291bnQoMHgxMCwgMiwgZWF4LCBlYngsIGVjeCwgZWR4
KTsKKwllbHNlCisJCXJldHVybiBmYWxzZTsKKworCXJldHVybiAoKGVjeCA+PiAzKSAmIDEp
OworfQorCiBzdGF0aWMgaW50IG5vbmNvbnRfY2F0X3J1bl90ZXN0KGNvbnN0IHN0cnVjdCBy
ZXNjdHJsX3Rlc3QgKnRlc3QsCiAJCQkJY29uc3Qgc3RydWN0IHVzZXJfcGFyYW1zICp1cGFy
YW1zKQogewogCXVuc2lnbmVkIGxvbmcgZnVsbF9jYWNoZV9tYXNrLCBjb250X21hc2ssIG5v
bmNvbnRfbWFzazsKLQl1bnNpZ25lZCBpbnQgZWF4LCBlYngsIGVjeCwgZWR4LCBzcGFyc2Vf
bWFza3M7CisJdW5zaWduZWQgaW50IHNwYXJzZV9tYXNrczsKIAlpbnQgYml0X2NlbnRlciwg
cmV0OwogCWNoYXIgc2NoZW1hdGFbNjRdOwogCkBAIC0zMDQsMTUgKzMyMyw4IEBAIHN0YXRp
YyBpbnQgbm9uY29udF9jYXRfcnVuX3Rlc3QoY29uc3Qgc3RydWN0IHJlc2N0cmxfdGVzdCAq
dGVzdCwKIAlpZiAocmV0KQogCQlyZXR1cm4gcmV0OwogCi0JaWYgKCFzdHJjbXAodGVzdC0+
cmVzb3VyY2UsICJMMyIpKQotCQlfX2NwdWlkX2NvdW50KDB4MTAsIDEsIGVheCwgZWJ4LCBl
Y3gsIGVkeCk7Ci0JZWxzZSBpZiAoIXN0cmNtcCh0ZXN0LT5yZXNvdXJjZSwgIkwyIikpCi0J
CV9fY3B1aWRfY291bnQoMHgxMCwgMiwgZWF4LCBlYngsIGVjeCwgZWR4KTsKLQllbHNlCi0J
CXJldHVybiAtRUlOVkFMOwotCi0JaWYgKHNwYXJzZV9tYXNrcyAhPSAoKGVjeCA+PiAzKSAm
IDEpKSB7Ci0JCWtzZnRfcHJpbnRfbXNnKCJDUFVJRCBvdXRwdXQgZG9lc24ndCBtYXRjaCAn
c3BhcnNlX21hc2tzJyBmaWxlIGNvbnRlbnQhXG4iKTsKKwlpZiAoYXJjaF9zdXBwb3J0c19u
b25jb250X2NhdCh0ZXN0KSAhPSBzcGFyc2VfbWFza3MpIHsKKwkJa3NmdF9wcmludF9tc2co
IkhhcmR3YXJlIGFuZCBrZXJuZWwgZGlmZmVyIG9uIG5vbi1jb250aWd1b3VzIENCTSBzdXBw
b3J0IVxuIik7CiAJCXJldHVybiAxOwogCX0KIAo=

--------------vKec7RVSzFt68m7lUfQmMBOZ--

