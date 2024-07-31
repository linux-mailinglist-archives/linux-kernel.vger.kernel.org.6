Return-Path: <linux-kernel+bounces-268449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2609424BE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 05:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 602C6285FB8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 03:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DF117BB6;
	Wed, 31 Jul 2024 03:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YacyLwr+"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B321818C08
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 03:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722395151; cv=none; b=YYkGx4hDYOeFd8Q2SQAjkIX7MI/Z0q8LUFv7fQGAfT7CCHq9iaDDtRsE4LBLPQ7LVljG9wo6UjR2tc7wgKGEYCnoFtX5q8Za/MmX2W0DEpy6TPr6IeqkQf0hil6vnvR5E+jwJd22BKrKiExPDyXwVU+mzD10UgjjQlbL4lc4F84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722395151; c=relaxed/simple;
	bh=m26nOcjYikqjb0AEPz3w7yoShwzT8zJx4NBuE+DnrPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ii5daSJp/6nSUzT6KdCEo731igLs2CQvRYs5H0j1dtJbWExMbankIc/4XzYCfE1LWe/6WFZN1bPLb4LZTU1Lyw4pT6oR+k8sktF7bAwXhN5HaaxHcY4E6Njdsof9Sw37MD2UUTsEaiwGcAda+AlkjDyQNSH39eg7OXV/g/ghHSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YacyLwr+; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44fe76fa0b8so175921cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 20:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722395148; x=1722999948; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hl2iSYfZNTZ+d28saBb7Y2iAIr6rEQb9fWQ4VzERXhk=;
        b=YacyLwr+AVLEPK+BRYXGmM5QFRCTP6vWB80j1JSnY1wl+zQAihLvC38nDki2cUrLwn
         wP7pVtl41rdJhCZlbxmRY8QrOHqGuUsGzKt4xJLxS0O0Jon0JXhYPWfSsX1WeaJFVxus
         /fDH9/35mXGX+Wfv1Ojccb+4eQYP7ZogKSl3cAy6UU/iMqVATHdV3hm+0rsemKmSTWzH
         +oYOtZhgnuYnCDvJ8XqNUz/bNWCcv9oDiMyXyGjEJ/DBX9qCBqjvVokV+bJknlR3/y4W
         iJrFlMvDBM078Ju+41pJub3J8Q0BEI+EjtnHs5ay9NI8YLJKjqkN8ljxX+2AO87DWkZo
         Fc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722395148; x=1722999948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hl2iSYfZNTZ+d28saBb7Y2iAIr6rEQb9fWQ4VzERXhk=;
        b=BzA0gOV3fuabPQVTcLTYZd8tv+tNUBcLlqaswTFfbboIkVPLhUWwjkk0/ssE6xbPew
         7d5zMm8cvjAQ/JBSrXEyk23TOqtlq4pR/1glPZcm+UVhSB85vonJ8psjycZ29W1VmiO3
         nokxcAyLgGst1jY7EXaUyybjI/uys/B1dS0F+ONJjK7fCfXXPtFwDswi/YXofNJuEIpe
         VNkAEdwSxoHmCpBHIsjCjHktEC0LJQHVeHgrtqQjwxEHASaprn5w/EHMv9IC6mrL1hFo
         AfY9CQXbwVwWQmoCOPdyvjDlkSyM2OFWFRD8wzNb5RNWNtU+yxmr27JuA3NHwKxfv/ZA
         hsJA==
X-Forwarded-Encrypted: i=1; AJvYcCUn4PpU1H4k9V7SnZFXVI1VXxy5E8Mk8usI5QUrBo6c7LPsX6DinXo+6J2hxV9dp+pIfvLwhx5GLhPWbo0aTpyCYTuqebXo44HQ+eTR
X-Gm-Message-State: AOJu0YwNw0a79qjaR3dHBCORRBc8TKCTqTGXCIOeOrFy+lPqPW1xrtVH
	/FYEjdDWDKLTmDR24oWlok4ZTWtgCCjSe9DPhe6X/PvAZ8rNXijtYV74PEaNjppduAcTBUC7yca
	hS85pYpOS0nmIEii7sczRMYUnrqEkzeRv+0L9
X-Google-Smtp-Source: AGHT+IF4nrP6uOB7D9St9sGyXDen0FmRdSnwBPYzsYZtu3mEju6hHsK1e2qtOYto+i96nw4fapmlq1HF5GiHrQB0Fws=
X-Received: by 2002:a05:622a:4cd:b0:44f:ee20:d189 with SMTP id
 d75a77b69052e-4504199fe9emr2196951cf.8.1722395148321; Tue, 30 Jul 2024
 20:05:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726110658.2281070-1-usama.anjum@collabora.com>
 <27b91030-b01f-44e4-82f7-93b3e11e8d74@linuxfoundation.org>
 <ZqU4FANdHOvpGc5t@yury-ThinkPad> <5d5b2042-f006-4c9b-b8a5-a28cbc3c7f5e@collabora.com>
 <38f98707-3317-47f6-97f6-ef1f80bfeadd@linuxfoundation.org>
In-Reply-To: <38f98707-3317-47f6-97f6-ef1f80bfeadd@linuxfoundation.org>
From: David Gow <davidgow@google.com>
Date: Wed, 31 Jul 2024 11:05:36 +0800
Message-ID: <CABVgOSmMoPD3JfzVd4VTkzGL2fZCo8LfwzaVSzeFimPrhgLa5w@mail.gmail.com>
Subject: Re: [PATCH 0/3] bitmap: Convert test_bitmap to kunit test
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, Yury Norov <yury.norov@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kees@kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, kernel@collabora.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000004224f061e825f28"

--00000000000004224f061e825f28
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jul 2024 at 23:39, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 7/29/24 02:15, Muhammad Usama Anjum wrote:
> > On 7/27/24 11:10 PM, Yury Norov wrote:
> >> On Fri, Jul 26, 2024 at 01:26:48PM -0600, Shuah Khan wrote:
> >>> On 7/26/24 05:06, Muhammad Usama Anjum wrote:
> >>>> In this series, test_bitmap is being converted to kunit test. Multiple
> >>>> patches will make the review process smooth.
> >>>>
> >>>> - Patch-1: Convert the tests in lib/test_bitmap.c to kunit
> >>>> - Patch-2: Rename the lib/test_bitmap.c to lib/bitmap_kunit.c and other
> >>>>              configuration options
> >>>> - Patch-3: Remove the bitmap.sh selftest
> >>>>
> >>>> Muhammad Usama Anjum (3):
> >>>>     bitmap: convert test_bitmap to KUnit test
> >>>>     bitmap: Rename module
> >>>>     selftests: lib: remove test_bitmap
> >>>>
> >>>>    MAINTAINERS                           |   2 +-
> >>>>    lib/Kconfig.debug                     |  15 +-
> >>>>    lib/Makefile                          |   2 +-
> >>>>    lib/{test_bitmap.c => bitmap_kunit.c} | 624 ++++++++++++--------------
> >>>>    tools/testing/selftests/lib/Makefile  |   2 +-
> >>>>    tools/testing/selftests/lib/bitmap.sh |   3 -
> >>>>    tools/testing/selftests/lib/config    |   1 -
> >>>>    7 files changed, 295 insertions(+), 354 deletions(-)
> >>>>    rename lib/{test_bitmap.c => bitmap_kunit.c} (70%)
> >>>>    delete mode 100755 tools/testing/selftests/lib/bitmap.sh
> >>>>
> >>>
> >>> Can you tell me how this conversion helps?
> >>>
> >>> It is removing the ability to run bitmap tests during boot.
> >>> It doesn't make sense to blindly convert all test under lib
> >>> to kunit - Nack on this change or any change that takes away
> >>> the ability to run tests and makes them dependent on kunit.
> >>
> >> Hi Muhammad,
> >>
> >> In addition to Shuah's and John's reasoning. This patch wipes the
> >> test history (git blame will point on you for most of the test),
> > When files are renamed, their history isn't lost. We just need to use
> > --follow option with git log to get complete history[1].
> >
> >> breaks boot-time testing support, messes with config names and
> >> usability, and drops kselftest support for ... exactly, what?
> > AFAIU the kselftest wasn't detected the test results that's why I started
> > thinking on which could be best way to detect if any failure happens in
> > this test. Triggering the test from kselftest doesn't grantee the test it
> > would pass every time until we check results. For this kind of in-kernel
> > testing, kunit is best suites. Please find earlier discussion [2].
> >
>
> KUnit isn't idea for cases where people would want to check a subsystem
> on a running kernel - KUnit covers some use-cases and kselftest covers
> others.

Thanks, Shuah. That clarifies a lot. So the use-case we're concerned about is:
- We have an existing running kernel, which has CONFIG_KUNIT=n.
- Something breaks, and we want to check (for example) test_bitmap.
- We can modprobe test_bitmap on the current kernel.

That's definitely something KUnit can't do at the moment (though the
workaround of always building with CONFIG_KUNIT=m is working for Red
Hat and Android, and seems the closest equivalent). Maybe we need to
work out a way for KUnit tests to handle this case more smoothly.
Because I don't think there's anything special about this test which
makes this use-case more likely than any of the other KUnit tests we
have.

> What happens if we are debugging a problem that requires us to debug on
> a running system? Please don't go converting kselftest into kunit without
> understanding how these are intended to be used.

I don't think it's clear that this _is_ how the test is intended to be
used: the config help text (and earlier messages in this thread) were
all about running tests at boot, which is distinct from "debugging a
problem on a running system". I think this is where I've been most
confused. We've been happy to assume the "testing at runtime" case is
against a kernel with test configs enabled, too.

When it comes to test_bitmap specifically, I can't find any difference
(save possibly for a couple of performance test functions) between it
and any of the other tests we've converted to or written with KUnit in
the past. I'd imagine (and correct me if I'm wrong) that it's pretty
rare for there to be an issue which will be caught by test_bitmap on a
running kernel, but not on a fresh boot / in a kernel with KUnit
enabled. So the "debug a running system" situation seems to me only
decrease coverage of some very rare situations. (Of course, that's
ignoring that running the module against the current kernel might be
most convenient, but that's a separate issue from coverage.)

> Yes kselftest results need to be looked at. Write a parser which can
> be improved. What you are doing is reducing the coverage and talking
> away the ability to debug and test on running system.
>
> Fix what needs to be fixed instead of deleting tests.
>
> >>
> >> KUNIT engine here doesn't improve on readability, neither shorten
> >> the test length, to my taste.
> >>
> >> If you'd like to contribute to bitmaps testing - I'm all for that.
> >> This is the very core and performance-sensitive piece of kernel,
> >> and any extra-coverage is always welcome.
> >>
>
> +1 on this. Add new tests and look at the reports.
>
> >> But I think the best way would be either adding new cases to the
> >> existing test, or writing a new test, KUNIT-based, if you like.
> >>
> >
>
> +1
>
> As I mentioned in my earlier message, I am going to nack all patches
> that convert existing selftests to kunit such as this one.

I should point out that we've already been porting a lot of tests in
lib/ to KUnit for years, sometimes with the help of the test author,
sometimes by encouraging it as a task for new contributors. And while
most of those are not actually selftests (though we may have ported
one or two), they differ from test_bitmap only in that there's a
selftest wrapper script. The authors and users of those tests have
thus far found this a worthwhile trade -- I've not heard any
complaints -- so I'd rather we leave this as a "pause" on new
conversions while we sort this out, rather than do something drastic
like revert existing conversion.

Personally, I'd still prefer these sorts of conversions to go ahead --
I think the benefits outweightthe costs -- but I can totally get
behind doing it on a case-per-case basis. I'd be disappointed if we
NACKed changes like this in the case where the authors and users of
that individual test would like it to be converted, though.

Regardless, I think there's more discussion to be had here, and I'll
look into what changes we can make either to KUnit or to the testing
documentation to make sure we're all on the same page.

-- David

--00000000000004224f061e825f28
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
hvcNAQkEMSIEIPw4oQwsrOvn2oz9lJO9kLpqcmt7BOJPM2fjYfz8b6ORMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDczMTAzMDU0OFowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAJQDtB
BvWlBUkal5TW6FpXl3awIJH6sawDLMsFZvOzT6v9i5PYsL1ZCcvADiYdK/Gj+ZLKXj+N2ELC1576
FLFahM8CSTWfle5KwekgwCEK7uQbj3x/FYgKjVRpvfkDfZffVd60BbuqEy1rcZruWfe4vDJY1Al9
W8LU02hmzl5QawZGk8SKBcEjKopecqOYP0BAu81Jl8hTGalPeffC7xV6iClatEpQF4Fj2QpgLw74
V7RwFNuqr7gHRPh8fOALRPnH3n6ii3SOjARvQ0wL6si1tGT4IGG1EMSJCrJB3DnmAMkBBpNpclDX
TRKvP/rP9Kdf+847hgw170XaKL3K5+WH
--00000000000004224f061e825f28--

