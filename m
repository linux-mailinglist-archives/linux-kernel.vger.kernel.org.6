Return-Path: <linux-kernel+bounces-253429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B91A6932145
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 535F8B2208D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 07:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ABE2BAEE;
	Tue, 16 Jul 2024 07:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D7fOWWej"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486C525624
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 07:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721115246; cv=none; b=aTsqkitKU00ZrKCvNiDwENAeG9tWX+/AobXzMTI/8AnBGtwwaQB8ZAfydaADctdOsSwthxwWuMqQgmJAMBmDoENpbLm1CNdr+RFcG/3HqKVg0H3+fBxKokm/mFL2jo6fIbpplGCY5pzMKYqkDcD/et2q25Zh/qRV+40NWaCSs2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721115246; c=relaxed/simple;
	bh=BTacLskCH14XcCXvhLDUIBRZOXIHQzogwbNba+MUl7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FRvUdBI4UREJQpBsUU8cg+p3ciaPsqt9VywXQ9Em6cI99K+7tjtoLDEk8BidGk/fX5OCrVDNnTTi5j8/Dd/gIkkmTzfcQwHvLzXESS1xDJiRcqXBFeAPdBvuK4n8xKJttz+T5mAaD4gF1DnL8et2OXwKpGy1FNFJliVzvC4bnx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D7fOWWej; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-44a8b140a1bso219821cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 00:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721115244; x=1721720044; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eEtIcH1ftETz8QyvEUNylrm2XRbpDKmVG486tWU4Xs4=;
        b=D7fOWWejEgArFKvmwYjHCHQxYDhjQjK1uNjRrK+1HEetXK/kmE6Aun+00AUJplrYRf
         eVO2ql7ZFUkpgEoYJQZ7exnlvcdJio9YD74KKG0Xrd3PHdI6nfd3w8UqkP4K6eRRGryX
         Sr3kAFuYjsUvSqGWCd+/hT4s+pCIxrnxQ++b0wfMkmYwDryj5Ye3vdzRupHJbVq9LttM
         zHYRQbwYepy7cALUhqKc7K7/kOH0X3ytC6sU3wDuDs9Z28DYsrO7GK61EK0n0dhBrDNl
         gSO7edYsVyGlpchLEb8H3EC5hYPeS1N0J01RrlSrf1jkE3J/E/R3eUQYBE6QfVNZwOlH
         zo3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721115244; x=1721720044;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eEtIcH1ftETz8QyvEUNylrm2XRbpDKmVG486tWU4Xs4=;
        b=sPhUDoVMwy9BG1WdZd8/3zpysertG0KzNmIlzz+9q9JbwmXNRwT4gaY4kry6vDFHuF
         3NyVa4+/eusqDPz0CAMq0PNUmbomu/PLrLXi6wTVN6X1qyhcKoHsvN9rVJ15d5pjEYqV
         9TnuA3mIAGUWPhASAonBCMdxNIHmibi6fgJnWOmqkJc/E0NcHySur/Rrr2SOlhON4dN7
         zeEfquLfx0k1KxuxyTeuXelGFxXucyYKQGHusm9noyEXfL7o07kv+upAri70VIHp/oec
         JNysU+l0rosghApzPsRgWiLUkCPWnQ4YrOFyH7ir2h44IahIwaPfqbz1F0PvvX6N50+n
         3wsA==
X-Forwarded-Encrypted: i=1; AJvYcCXY4Xu2wa0Dfc25G+LxXOvBX1nfHoQDdaWqpITu3JB+cDzPkZ1dUIwbtSS1U+trmDD5MMmpClVQmmOsca+g08zqf6qi+d+Fz/UvI0Ws
X-Gm-Message-State: AOJu0YzATLDMSkn2mF+HEuBcjWnlfxE3V6d+yIoLxcS/dRONFg89oNWm
	xntKc/BH8TjaHt7C+Ne3b1ye/E+F/lfzF2yIURtHWk9RSNMb+a9SPmzeonHrCqIwQAsaKTnnnCs
	bZG5WsRiD7zbgjR7xXdu3D7180cyWm28a0boF
X-Google-Smtp-Source: AGHT+IGqxpZmEXOddM1Q63KeBboY5Q9LT5fSf2IW6tOCtV3JAPLJwJpwrGDohGXQVTyYoxlcZ1iEfQtSsNn3tQ2Ky0c=
X-Received: by 2002:a05:622a:1e8b:b0:447:d78d:773b with SMTP id
 d75a77b69052e-44f7a6265d2mr2787961cf.6.1721115244084; Tue, 16 Jul 2024
 00:34:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <327831fb-47ab-4555-8f0b-19a8dbcaacd7@collabora.com>
In-Reply-To: <327831fb-47ab-4555-8f0b-19a8dbcaacd7@collabora.com>
From: David Gow <davidgow@google.com>
Date: Tue, 16 Jul 2024 15:33:51 +0800
Message-ID: <CABVgOSmD6j2OK1WXXcO+fTRN7PSpMFph8BT3Unko0c+Bv+3bjA@mail.gmail.com>
Subject: Re: Converting kselftest test modules to kunit
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>, 
	"open list : KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	kunit-dev@googlegroups.com, "kernel@collabora.com" <kernel@collabora.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c4d75a061d585ebe"

--000000000000c4d75a061d585ebe
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jul 2024 at 18:09, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> Hi Kees and All,
>
> There are several tests in kselftest subsystem which load modules to tests
> the internals of the kernel. Most of these test modules are just loaded by
> the kselftest, their status isn't read and reported to the user logs. Hence
> they don't provide benefit of executing those tests.
>
> I've found patches from Kees where he has been converting such kselftests
> to kunit tests [1]. The probable motivation is to move tests output of
> kselftest subsystem which only triggers tests without correctly reporting
> the results. On the other hand, kunit is there to test the kernel's
> internal functions which can't be done by userspace.
>
> Kselftest:      Test user facing APIs from userspace
> Kunit:          Test kernel's internal functions from kernelspace

Yes: this is how we'd like to split things up. There are still a few
cases where you might want to use kselftest to test something other
than a user-facing API (if you needed to set up some complicated
userspace structures, etc), or cases where KUnit might be used to test
something other than individual pieces of functionality, but that
categorisation is a good start.

The Documentation/dev-tools/testing-overview.rst page has a more
detailed look at when to use which test framework (which basically
just repeats those rules):
https://docs.kernel.org/dev-tools/testing-overview.html

Cheers,
-- David

--000000000000c4d75a061d585ebe
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPqgYJKoZIhvcNAQcCoIIPmzCCD5cCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg0EMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
JEfDtvHU6wy3MSBE3/TrMFcGA1UdIARQME4wCQYHZ4EMAQUBATBBBgkrBgEEAaAyASgwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgw
FoAUfMwKaNei6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEB
AGwXYwvLVjByVooZ+uKzQVW2nnClCIizd0jfARuMRTPNAWI2uOBSKoR0T6XWsGsVvX1vBF0FA+a9
DQOd8GYqzEaKOiHDIjq/o455YXkiKhPpxDSIM+7st/OZnlkRbgAyq4rAhAjbZlceKp+1vj0wIvCa
4evQZvJNnJvTb4Vcnqf4Xg2Pl57hSUAgejWvIGAxfiAKG8Zk09I9DNd84hucIS2UIgoRGGWw3eIg
GQs0EfiilyTgsH8iMOPqUJ1h4oX9z1FpaiJzfxcvcGG46SCieSFP0USs9aMl7GeERue37kBf14Pd
kOYIfx09Pcv/N6lHV6kXlzG0xeUuV3RxtLtszQgxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIz
IFNNSU1FIENBIDIwMjACEAFsPHWl8lqMEwx3lAnpufYwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZI
hvcNAQkEMSIEIA2h/OLLwGYwbijJW0TsFshx9rmrDuL+LJUnk0lMqgqhMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDcxNjA3MzQwNFowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA0Zsna
j1I85VQ9xrta3mHGPVFz1KA8YDyIBp5y3sr4c4FgS03DmNj3TR6F18HWRKw0IQiUPBj8RQjOh8Xv
24gxIc61xEUfJUjTpay9p74Y5AEeSsvBOX8urLn0W+Z0fonYvyaRclQjUisBKbFYwwIYmBVczpHY
RpRxb05sjlQpktjcKCWYTSCUbODiMDfyY2A1LOdpQk8u1ZiM7jnBaIUVpC200McdOUdT3gzyDGEK
TA0k6mDx9AgROjJjWhC67iz8ge77JWxEUEQfwOxCh0i3vfqoX7Hnjz/HTBCMIMdey+AmKWbohYw+
9TeUXAQ+cgT7S8pUWBVafcV5OhuVgYH4
--000000000000c4d75a061d585ebe--

