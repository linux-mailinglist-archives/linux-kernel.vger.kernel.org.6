Return-Path: <linux-kernel+bounces-442044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666239ED74E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2497E163C8A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E416420B810;
	Wed, 11 Dec 2024 20:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RjHgHMd0"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B00A209695
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 20:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733949467; cv=none; b=eFAKlu5ECG1QAAwRPNG6jc0s+G6MGil7uHb0H9a02RcYfRL7pNuVSgLEhtyGvwjihZjkk6TsIJZ00u15jACZoOecctw1kCiC+k3jodYfQjZqtv9gS1AZU8a4Hi/dqDV+9ZnbOgkRBgJJW6THIT/Y7db51nlIFaJKNqwwcdGnOk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733949467; c=relaxed/simple;
	bh=9YSjFkd0Ikd+gYJR9d1ukXVWZnbDGV+dFE1EVawD6Bg=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=RsyjQlvO6wEgPEv2D11GV0W5D8vfHG4R663IfuamjMi+JNJkP5EHZxSy+1CRjgVE1ze6MO/oYG+sJx0NF+imZ+XlaQZnSXF2w3fB164yd18EFZOiiO8L7EBhjbX+uk87XGxuDKBE0w5l2woIfRPSF9AKfZb7P21ZvWpDYKzFMWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RjHgHMd0; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-844ba46e0e4so176753939f.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 12:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733949463; x=1734554263; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SxohKwxXt9yfnit8Y5nOLuGD3ESesQ489Y5a7mGse+U=;
        b=RjHgHMd0+Kgs6uvj26+3ydKZq1uc/w/dPVsc8YWu05HNV3AYTSMPMpQuclGTcYkfhl
         lBP2o3L/MtApTBSmRomGMQwGkWSKeWREj1LM/SrEkOQTtRnp7agcZqMyhshPH5m0IHnb
         JgMV5R76kMpOhwhDC4KY8+VE1rbhOmeHPGchw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733949463; x=1734554263;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SxohKwxXt9yfnit8Y5nOLuGD3ESesQ489Y5a7mGse+U=;
        b=ZTZpDocl8+7ySgpNXBEIkodew1QkIX7BiqCTURv2VB7FZkCo68hwP3F0TJB712i+/n
         YvNDzbfJTsc5MDq9iO2Gk58RhCeP2HZtqEDG35ly7dQW9hs6sQTGMeirmdxC5d3DlZYO
         tEvdZgzr381xyQ1JBDPk7jXmeT+VUlc2snyuggcbcIYN9CDzXlivkS5RqTE+S0mhrWfm
         Qx3JLdV/A8q2lJekAidsrXvTaT4VL0vMCyj+kSuqvkQ1YGDsOYIYTE6gvA1nZVbUBXDh
         FVK1yskgxS+e2Cmmuv4jIxzQ2OfHWBr+6M2haGPcBw2zOIgeyAELkXS43gJ5t4bRMJ6y
         uHig==
X-Forwarded-Encrypted: i=1; AJvYcCU5J8C3iO4tCu+5JiAM39iRzOhjqDrZAYqlqrn/faVJubfjnAAxUScFQ7O/98B9LndoCQnKNWkxVn5oBWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTkfaHyOdtnaVwAa4nuyZGNq+5UweVOKhthruEe9gd8QxLxeii
	GpZFP9WDxMKpJWrmYto2LpItepy1JJWRg2NOsyltK4pT+WDWlQP54W7ypdW+SC0=
X-Gm-Gg: ASbGnctatCkr1sPUZbLbsZAqwSOfuIqmCwTDQOExk4RQx1Eq47hSPHtI5Bqhubgg52u
	YJS5QobPNqh4AaGeBq0OgLSiTYj0FPTsvksDHUmmUn4DEYt1iuVycFFLx7TVTLIN/1FooCOoXU0
	uklQK7msv+UOJUYZkORAD5VEprN47u1GrHabAqzesCOYf5JVNe0evbkWj/DdbFMYAtQEBVPX9A+
	xkWflxAHQoTEvBvixQ9Pt03nNRKj8EdcQCfbBJayHlfMT/bBOb3U9tjH3YSsuH3JA==
X-Google-Smtp-Source: AGHT+IFakvpKG+9hRpBEPAnACboJindxqb6rGLetngrQQzz2gzfaNZLtJ0K6Ssj2ijKWbbPgS6FmwA==
X-Received: by 2002:a05:6602:1612:b0:843:ea96:f707 with SMTP id ca18e2360f4ac-844d7472524mr106813539f.8.1733949463429;
        Wed, 11 Dec 2024 12:37:43 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844d3f37f77sm25248039f.46.2024.12.11.12.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 12:37:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------LuOvLp4AF8WW5w5iynxNMIZU"
Message-ID: <e3c2e67e-c80f-417c-a44f-e2f568e90d44@linuxfoundation.org>
Date: Wed, 11 Dec 2024 13:37:41 -0700
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
Subject: [GIT PULL] Kselftest fixes for Linux 6.13-rc3

This is a multi-part message in MIME format.
--------------LuOvLp4AF8WW5w5iynxNMIZU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following fixes update for Linux 6.13-rc3.

linux_kselftest-fixes-6.13-rc3

-- fixes the offset for kprobe syntax error test case when checking the
    BTF arguments on 64-bit powerpc.

Note: This fix has been in linux-next since last week. I had to drop
a patch and rebase this morning.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

   Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.13-rc3

for you to fetch changes up to 777f290ab328de333b85558bb6807a69a59b36ba:

   selftests/ftrace: adjust offset for kprobe syntax error test (2024-12-11 10:08:04 -0700)

----------------------------------------------------------------
linux_kselftest-fixes-6.13-rc3

-- fixes the offset for kprobe syntax error test case when checking the
    BTF arguments on 64-bit powerpc.

----------------------------------------------------------------
Hari Bathini (1):
       selftests/ftrace: adjust offset for kprobe syntax error test

  tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

----------------------------------------------------------------
--------------LuOvLp4AF8WW5w5iynxNMIZU
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-fixes-6.13-rc3.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-fixes-6.13-rc3.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQva3By
b2JlL2twcm9iZV9zeW50YXhfZXJyb3JzLnRjIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
ZnRyYWNlL3Rlc3QuZC9rcHJvYmUva3Byb2JlX3N5bnRheF9lcnJvcnMudGMKaW5kZXggYTE2
YzZhNmY2MDU1Li44ZjFjNThmMGMyMzkgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2Z0cmFjZS90ZXN0LmQva3Byb2JlL2twcm9iZV9zeW50YXhfZXJyb3JzLnRjCisr
KyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQva3Byb2JlL2twcm9i
ZV9zeW50YXhfZXJyb3JzLnRjCkBAIC0xMTEsNyArMTExLDcgQEAgY2hlY2tfZXJyb3IgJ3Ag
dmZzX3JlYWQgJGFyZyogXiRhcmcqJwkJIyBET1VCTEVfQVJHUwogaWYgIWdyZXAgLXEgJ2tl
cm5lbCByZXR1cm4gcHJvYmVzIHN1cHBvcnQ6JyBSRUFETUU7IHRoZW4KIGNoZWNrX2Vycm9y
ICdyIHZmc19yZWFkIF4kYXJnKicJCQkjIE5PRkVOVFJZX0FSR1MKIGZpCi1jaGVja19lcnJv
ciAncCB2ZnNfcmVhZCs4IF4kYXJnKicJCSMgTk9GRU5UUllfQVJHUworY2hlY2tfZXJyb3Ig
J3AgdmZzX3JlYWQrMjAgXiRhcmcqJwkJIyBOT0ZFTlRSWV9BUkdTCiBjaGVja19lcnJvciAn
cCB2ZnNfcmVhZCBeaG9nZScJCQkjIE5PX0JURkFSRwogY2hlY2tfZXJyb3IgJ3Aga2ZyZWUg
XiRhcmcxMCcJCQkjIE5PX0JURkFSRyAoZXhjZWVkIHRoZSBudW1iZXIgb2YgcGFyYW1ldGVy
cykKIGNoZWNrX2Vycm9yICdyIGtmcmVlIF4kcmV0dmFsJwkJCSMgTk9fUkVUVkFMCg==

--------------LuOvLp4AF8WW5w5iynxNMIZU--

