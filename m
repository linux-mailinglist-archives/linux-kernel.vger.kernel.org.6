Return-Path: <linux-kernel+bounces-266786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED37494079B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B2EF28440C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 05:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A10190462;
	Tue, 30 Jul 2024 05:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="07NTlR+q"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D819117D2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 05:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722317000; cv=none; b=tjOWuOQttcAjl7lkRZwLmxVWfbiVkp6O3mFhEwiJLktX4zB/cmYuaojEsPIinJEcRJfd4uquPX+rr3pU+L6BZDY9mzWLtkaDl5BTM8FQyt+aW0wjkOYUxO4A0mvtGxFf/eNW8WT4jTt6QM/S+x0RZeJFZ/yHf6/tb6cPxqTZjy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722317000; c=relaxed/simple;
	bh=T+FyUMHiOZJFhT60GlKcaTuHMcgludQS/EnEleBI4C8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n7ASu+zsB8438IU2OwIf/QeREV1wXQcV3Bw61//JQE3BT7l2FH3XJQNEDxehzJP++gf7sDH4gxb+j9o8MfZTzatQEV4rw17tS3dhYzZNUUJ5ZC3l8nm5bFtrkUfX9DUklUtF9wMWvihnR1P1cWjA9RCA8VJ1fBJPAINMJQHIxiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=07NTlR+q; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-44fee2bfd28so136291cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 22:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722316998; x=1722921798; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Coz1csmF77us6xKfcpD2gpkrV6Kf7inC4WpphcqH++Y=;
        b=07NTlR+qXXdgg47M2D6b/PGXPaNIpFoy5aQapqbKYn0/Cwuujbe7YPTIIxlaClwMii
         g53iE4s73aIVd/TWW/XZCjtRpBSTFdkGxEHzDorrdQxyjaJLnkJtbtWf7LEl+qgrW4pb
         IruBatG8eQXArIhhx47jCxxTgEdqxufebnUZA49Om900rxK/dhWq7W/Nzab8pkGHBlt7
         HXrg35Nwz7EZS61q7MIFahf7/WeSuwUb8/eckYcVzx/ruNN5CoPnQd7Zv3pTQw0l5GT4
         Zz+jwGckLgKLHJdXB2hiPKDRwnvS7PFbKE40DS/Rb5NtDdWKs274OnaTBXwONE5H0igx
         dYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722316998; x=1722921798;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Coz1csmF77us6xKfcpD2gpkrV6Kf7inC4WpphcqH++Y=;
        b=PCf5ASfxEnXicCVNtZB3xHAXZl965lSzN0+aY/B9s3dh1jSKYsZodRLdJMFHHslIKc
         WuVd/FGVZREA/jNkVC3rdpyBKzplQCBRxZWH+6Gaad4oxBWDviHd4UWk0DrrqrMEWRG8
         bWT8OPMnMJIDRZu+dAu95++P3A9i9BQWSpLVFmoAJKJr+WTR9Jk9SMZP7dfjASxZaJZR
         u82Sqg4F8UMCHdmrFtdHOBxHIAaH2eiMOvmNTKd7TWamV6aNcCSSGqEX6/IBzL+jYrHA
         Pzk5O7TkOlTV6zro57w3JHWHX/PHI64aiWcR3TaAyNb6FjVGiFrdJYhj/EAM7e6AGIrV
         i6Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVMGJezw3DqblUJb3Kva7p+Dske0i9RO4jB/SXB3+N06u+sC0Otb1HZoTI/OeHRih8FiX43xMU9wv6Iz52ByaLivOUGBz8ICwkcHKPs
X-Gm-Message-State: AOJu0Yw6ZN4H+vNxy9SjEXMAtJTH+ybW/tYmtQ9R+CKDBD/ysQTgMkfk
	xeMYO9A9tFoNVtyKNs7xU1rsliO8PpEw5PUrf+G8IL2zYIQOfZQSXV944KT1agJrNPoHq+ifW8F
	IDd4NzF8xH3bDCzX/IubegHENVjsE03nz4tUg7ZHg6GgJpNcClzAm
X-Google-Smtp-Source: AGHT+IElpPRe8SgchCiezfuucf26I4rgumMhV0xEdbJTa+5e3LtaGXHksb3Vq8x5FWP1LBeWSmrfdurhBDIoJwQqhDA=
X-Received: by 2002:ac8:5786:0:b0:447:e423:a463 with SMTP id
 d75a77b69052e-450387b759dmr761811cf.3.1722316997557; Mon, 29 Jul 2024
 22:23:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <327831fb-47ab-4555-8f0b-19a8dbcaacd7@collabora.com> <533826b3-8bc4-40f8-a491-5bb5614469c3@linuxfoundation.org>
In-Reply-To: <533826b3-8bc4-40f8-a491-5bb5614469c3@linuxfoundation.org>
From: David Gow <davidgow@google.com>
Date: Tue, 30 Jul 2024 13:23:05 +0800
Message-ID: <CABVgOSkbOr28j7yD-M0Lk3G6sJHey_QjpGdLZWBise1Tbeumkg@mail.gmail.com>
Subject: Re: Converting kselftest test modules to kunit
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, Kees Cook <keescook@chromium.org>, 
	Shuah Khan <shuah@kernel.org>, 
	"open list : KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	kunit-dev@googlegroups.com, "kernel@collabora.com" <kernel@collabora.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000dd0932061e702c85"

--000000000000dd0932061e702c85
Content-Type: text/plain; charset="UTF-8"

On Sat, 27 Jul 2024 at 03:35, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 7/15/24 04:09, Muhammad Usama Anjum wrote:
> > Hi Kees and All,
> >
> > There are several tests in kselftest subsystem which load modules to tests
> > the internals of the kernel. Most of these test modules are just loaded by
> > the kselftest, their status isn't read and reported to the user logs. Hence
> > they don't provide benefit of executing those tests.
> >
> > I've found patches from Kees where he has been converting such kselftests
> > to kunit tests [1]. The probable motivation is to move tests output of
> > kselftest subsystem which only triggers tests without correctly reporting
> > the results. On the other hand, kunit is there to test the kernel's
> > internal functions which can't be done by userspace.
> >
> > Kselftest:    Test user facing APIs from userspace
> > Kunit:                Test kernel's internal functions from kernelspace
> >
> > This brings me to conclusion that kselftest which are loading modules to
> > test kernelspace should be converted to kunit tests. I've noted several
> > such kselftests.
> >
> > This is just my understanding. Please mention if I'm correct above or more
> > reasons to support kselftest test modules transformation into kunit test.
> >
> > [1] https://lore.kernel.org/all/20221018082824.never.845-kees@kernel.org/
> >
>
> Please make sure you aren't taking away the ability to run these tests during
> boot. It doesn't make sense to convert every single test especially when it
> is intended to be run during boot without dependencies - not as a kunit test
> but a regression test during boot.

Given KUnit tests can run at boot (and, indeed, do by default if
enabled), I'd've assumed that this would be a good candidate for such
a conversion. It does add the KUnit 'dependency', but I can't think of
how that could be a problem. Is there a specific situation where
enabling CONFIG_KUNIT would cause problems?

> bitmap is one example - pay attention to the config help test - bitmap
> one clearly states it runs regression testing during boot. Any test that
> says that isn't a candidate for conversion.

Again, most KUnit tests are effectively regression tests at boot, so I
don't really understand what makes bitmap different. If it's just a
matter of there being a different interface to it, that's surely
something that we'll either be able to adapt to, or to have some
wrapper/shim to maintain compatibility. I agree that having needless
churn in formats is bad, but KUnit does seem the proper place for
these sorts of tests.

If this isn't the case, do we need to modify the testing guide to
mention this, as it definitely suggests KUnit for tests of in-kernel
functionality like this.

Cheers,
-- David

--000000000000dd0932061e702c85
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
hvcNAQkEMSIEIP+B2EQ8P1ZwU5EPpXUdlIxL846EV6PaUo54vo5dDUxzMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDczMDA1MjMxOFowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAa8xBm
vTlcPOv71Qg8KsL0Z6mGFz46tcOr05Ii7maHhSnX65PTwARD2CP5TUOzJxkZPpfPGBJgwPUp26Vc
TYTKQFvwWE8xxKNCcS52imgiEp8fLI6O7x7Vkk2TBC0bZ1r5m3UdO3jNZPY2ceKgGfJgMIVm1Z2f
9Jm4MPfuJflL/Yln+vfQ8WX4ohWHBh51B10nxqQ1iKim/wIaybDjn5d2tbe0ZVbkI49LDlj3Ch3f
bKofGpOm5ZSNagvJsZr87/2hTeiGnRhfRTBjS2oMbr4iAYLXQcK5/Isi/ynk9awj77sBUDTmwecX
gPliUG2nyyTYPgH6lZPviCq94wmmqFnz
--000000000000dd0932061e702c85--

