Return-Path: <linux-kernel+bounces-212553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB9990631A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 06:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBA591C21CD2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 04:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F99132811;
	Thu, 13 Jun 2024 04:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uGzQaPiO"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF38131736
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 04:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718253718; cv=none; b=TmzFNLX+MzdAAtVYZS1H4vAKPwupjxxUqn+vbsbeQiSLwSAiYKGD5pYxz9ofFFqc0hkYn/mD1bwjuzF6t/fJ948pJNjcqrk+8APmruSywbJHycYcZHRVYT7YVly5/VmPaR8qtRtkg4eBTgvX03HooHMg+rwsBn/zChtUwRG8H8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718253718; c=relaxed/simple;
	bh=4KrH0WAn2TdleyEyNSIokL+V6M++d5QJg3EdRu7q5kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qf5eDcMHBw7Jtm8ddTCv1+8joZ7qjB2IsCYVV3OthwmBi5jpQpYxs1NoU6Gfb8v5/YUGf6Zs3DtIpVWDto6N7gxyypjznEFQ+Rl2Gq6QIBf6Gz4REijhhxzxh8yaKVh3OZqoFoazupc4PbdLrLg4EHHKXNY90EMGfYAo6ggfW5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uGzQaPiO; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4405dffca81so96161cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 21:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718253715; x=1718858515; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0Bq/d6FdwdCzy4ie/WBS3CFI0UjPff6aKFW1RcOr6iU=;
        b=uGzQaPiOCWjaE2KeAqLlghK/ioSon3O9t0QCzR2dg5esCMarij5VnUyd/FNa9miw0c
         9/1JD7WPk/1qTOzDIcmG5mqXjMLm9HGvRIE8S4/oSkuI2pjzuJC6Dfg3JUYKzyf0BxWH
         TfZL9snRXnA/kKAaQxLlmZpVBaMt+4NeJtLAYLcJnXZu8cSB43wkHOkA04J9iyiXc5Ip
         y12vQZUf7NezY20CgJ4TkS+cWjmXHrQTDbBDYAOz1v1RQJLXlgdepXPHDrh7vpiH1RsD
         a5m5uV4s2AI3dhFjXrhv9LQZ0yaJHjkKEYXWa9Qwl/gjDw88iW+DBNF6WbNu1kkkk3Gz
         7Efw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718253715; x=1718858515;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Bq/d6FdwdCzy4ie/WBS3CFI0UjPff6aKFW1RcOr6iU=;
        b=Af0ZOfFp+6YxOtAUGt+diVZiEXgG7rKhiDIeusrC/4iCE/a9ItBPYhU6uoVxCZyJQJ
         d0jcl9Lh6/Gni6eUL905Rwy6GaAE8nFEn5dpUK2J/IU7TiEpEX90FMETVfhLvIhaqBGx
         PC2QiZpUT1MEahRqSinCPDxpucrEh/d3IHzY9kifltPRPG2VdY4hL3gxO8sp99wLfLoF
         x5Fow4NKas09QpMtelGSpD+ZUK77Z5K1kvR0O7NsZKBc7RE5SWa81/Cc5uM/fw43fCmH
         0nHEENvxAN+cQOMcDn0el1hdkbIuk1gVXmhsajZpJFcMyYfVy5PLNEE5pUhtFl4U07re
         4GVw==
X-Forwarded-Encrypted: i=1; AJvYcCXmrw3LmRnDuZuddxuOBuhUDd7hLG71M35dOsE+3VD6wk8LqNX+37DJhIsq5A6zyGDJM2qPdG0jICm1rnLciCLGQdsI64tkF31fEfBN
X-Gm-Message-State: AOJu0YzZ6/kAKRyjAfW/Dda/6JjhD0DEWd7wzxDdXlrpLua4srYM6Nq5
	wYx6eQ8inpuCPWL6r+B5DvvNLjJ/YPcN+LrtKIahZ6JvGbe4sYbR5osshpkKd8py42t1Jt8eLT9
	wJgjNMcKjWRo7GFLZ5rC96kIS6MIjJWk1wXia
X-Google-Smtp-Source: AGHT+IFOeD2lEDrAC9SmGhHIQT3OetKm369fvbmb+I0GGZ1L4wD4tqk4b1rkJ3p+KRy11Yqi49TIr0u1Z7qaEH3UQfU=
X-Received: by 2002:a05:622a:2996:b0:442:1115:8c68 with SMTP id
 d75a77b69052e-4421115a23dmr170761cf.18.1718253715478; Wed, 12 Jun 2024
 21:41:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612195412.make.760-kees@kernel.org>
In-Reply-To: <20240612195412.make.760-kees@kernel.org>
From: David Gow <davidgow@google.com>
Date: Thu, 13 Jun 2024 12:41:43 +0800
Message-ID: <CABVgOSn+ApgyT0imi9cNLz2ojRoSE08H6Z8iYNhxXiKmG=FGzg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] usercopy: Convert test_user_copy to KUnit test
To: Kees Cook <kees@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Vitor Massaru Iha <vitor@massaru.org>, 
	Ivan Orlov <ivan.orlov0322@gmail.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <rmoar@google.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005f7ba5061abe1e39"

--0000000000005f7ba5061abe1e39
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 03:59, Kees Cook <kees@kernel.org> wrote:
>
> Hi,
>
> This builds on the proposal[1] from Mark and lets me convert the
> existing usercopy selftest to KUnit. Besides adding this basic test to
> the KUnit collection, it also opens the door for execve testing (which
> depends on having a functional current->mm), and should provide the
> basic infrastructure for adding Mark's much more complete usercopy tests.
>
>  v3:
>   - use MEMEQ KUnit helper (David)
>   - exclude pathological address confusion test for systems with separate
>     address spaces, noticed by David
>   - add KUnit-conditional exports for alloc_mm() and arch_pick_mmap_layout()
>     noticed by 0day
>  v2: https://lore.kernel.org/lkml/20240610213055.it.075-kees@kernel.org/
>  v1: https://lore.kernel.org/lkml/20240519190422.work.715-kees@kernel.org/
>
> -Kees
>
> [1] https://lore.kernel.org/lkml/20230321122514.1743889-2-mark.rutland@arm.com/

Thanks! This looks good to me (and passes everything here). Unless
there's a compelling reason not to, I think we can take this via the
KUnit tree.

Cheers,
-- David

--0000000000005f7ba5061abe1e39
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
hvcNAQkEMSIEIJYtGkrVsgks7lglUsdqY4JLHn7HxvPa6tpf+po/mcWhMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYxMzA0NDE1NVowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAPCAJE
LNFejvNIXL0WkbnttVtfjKPAJjRjXMFLFiexyjLzCkKgkwq/VoBuLHwJLh20cxS91ms/6iN3iEcA
dFAJZuSy1npZGi6IX4jHFzwetK1sYv8izl8xw+U9xlOttQKvSNFAYFCcjaUQh0QZcZ+EnZ6JGBBo
6iU7HtmI/ulJW9iUboRUOE/hFOeCQrOZBCjLe91JfwYUjeEuXG4odszz0i9gGLt+26Y6sxH3T3bF
nJuDwZRRwNZrcZUZLWyFAyEZCEpH5Aql7dNU8NVHlVNoqQx7AiAXBRhoKc6m0rQusdenKh1TahPS
EBApliwaCe+a+jBmzuh2SfVF1dMDSDUd
--0000000000005f7ba5061abe1e39--

