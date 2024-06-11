Return-Path: <linux-kernel+bounces-209308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1600890324A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8650E283783
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 06:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13AB171084;
	Tue, 11 Jun 2024 06:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z2jDl8Yj"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF61171079
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 06:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718086464; cv=none; b=XlmIthmsa82PS/Vgo3Qv1Eor9fv0GK+VU59qRbeAfDOBKViyOh5ak7/I3wXV0KdVG3H8wz0M+PjuVwJNNdxKuPH4gmqdCa/4w9wr/DfrSpS8KuR/ceKSXGZdLoDjaECnLVoinQgX6DHEIxhhw448F1WImHAbdS6C3MB9BNfN8zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718086464; c=relaxed/simple;
	bh=uzYvnZSrEDJuKRKlcwf09iqGICWoeHIo9Fu+ra0uNRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WIysDNEEHItbhKzk5rW9igFnbfNSik+MUWVWJWKuOdT7qXhV/ucqAXzuwrBMAy95eD7SHhhH8tzj4n4i+3tuJhL8idAvi+pgOFiUIJ/Q0Ml3u4UpgccrXqOaDS2Irr29O4ftZFub7xsYWJDiOXnJDeWK+KYXypikRJJMAtdBm5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z2jDl8Yj; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44056f72257so219491cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 23:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718086461; x=1718691261; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rw0yEybA58oGSenY87FDfNFGMr2HbsNIld+JH0QGeGY=;
        b=z2jDl8Yjuamq7PN7jLw4fIY+w/5loCb3UGjR0NSNZAqKdlnpDZOZ4aHnjzhmCGUI8j
         EWdtJnyJrVOg8FHzykY5FsJmrCaQ9xitOfSWwsoIWTU/V1NG85T0gIKZH+ItfRv4s88k
         dJ43apTwiN2M4hcGdRgyML14oFuqeoMD/5ruIa2WWHDUsnRUikgikQ2AjyZ0vbwZiyj+
         ZbZzCWSXcsy5+ooh9trEneXMEhtPDaO4DAVgNE8xA6miLLddyCEhSbvNpGyHko/rIqZ7
         Eos0dQ3IboQ8KnqaqAWffYDqTfyK5TOykiv2EqESyG7CcGyOmyfz7Ei9UbZQW6BSLSJK
         M17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718086461; x=1718691261;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rw0yEybA58oGSenY87FDfNFGMr2HbsNIld+JH0QGeGY=;
        b=N8RFUpDKWc1/xwdfv1ldwZ7bw55UuPfb8j9Mr0MRlyny7gtOoga855EUBZJzria01C
         NEathqxLpJMzac1JIyZL2anWpeOmhqoi7ngNL/Bb9d7EEeD6X0M9HKoz3LlUk41xZVYG
         11mkegC9QSoHm9MSeuvIDtAxY3p+Yxqr7uXF578jdPrzvT1WR5BF+yzyWDBSNq2dWg6z
         7XWwo72tBRsDqSp9EvBwF8+/vkTk5e5/m26ComZ6NihFDcFZ9iamsa4JWJ/n6OJXMBfq
         2q9Uw8oNnR9JAk7lbRbPSV2IPTYlTGISm1byD2fyKW+UycqH0GlBY0bwoyCpplZPs9Me
         jkvg==
X-Forwarded-Encrypted: i=1; AJvYcCXjG48faw2JrdPum6t+GsDoQWmbDpYO4vWQsK7rb7Rgao8TXz1IvjpVt/2I1wVnLpR6/q/HwexfR3wMp0eVSk+EIzJ+g1T9+TzNLrEQ
X-Gm-Message-State: AOJu0Yyl19VTbYzeLszOz0mRqh9ZTFzjvBpovlxeQMMxNosQoSAJAaV2
	pBV28YYj7RDIuiEf4lVaTTy+lNDLZmPqOoHrHRFMx4BKTdusR65PHwzVof+ag36UZ08TWwzHRWy
	8FsPtn2PRUSBbV3aMULhQfhmwSVZRjZd1ReR6PBfw2S9EGWGtp8p/
X-Google-Smtp-Source: AGHT+IEfF1ceGCvUIqpRgpGywpoFdhCEjJQ5SBrVnyTH7zFD7fIjC3mxz+EhRnvKT70AxygSJIfPcxTkh+gSBAi2+hs=
X-Received: by 2002:ac8:6f10:0:b0:43e:cb4:1d10 with SMTP id
 d75a77b69052e-44140140f5bmr2611541cf.14.1718086461364; Mon, 10 Jun 2024
 23:14:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610210213.work.143-kees@kernel.org>
In-Reply-To: <20240610210213.work.143-kees@kernel.org>
From: David Gow <davidgow@google.com>
Date: Tue, 11 Jun 2024 14:14:07 +0800
Message-ID: <CABVgOSnk3Uq1HjNgV=ATjO455PDv-W6-hDjqGyscp=ybc7U3Qg@mail.gmail.com>
Subject: Re: [PATCH] x86/uaccess: Fix missed zeroing of ia32 u64 get_user()
 range checking
To: Kees Cook <kees@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Sean Christopherson <seanjc@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Arnd Bergmann <arnd@arndb.de>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Nadav Amit <nadav.amit@gmail.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	David Howells <dhowells@redhat.com>, Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000404af3061a972dc4"

--000000000000404af3061a972dc4
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Jun 2024 at 05:02, Kees Cook <kees@kernel.org> wrote:
>
> When reworking the range checking for get_user(), the get_user_8() case
> on 32-bit wasn't zeroing the high register. (The jump to bad_get_user_8
> was accidentally dropped.) Restore the correct error handling
> destination (and rename the jump to using the expected ".L" prefix).
>
> While here, switch to using a named argument ("size") for the call
> template ("%c4" to "%c[size]") as already used in the other call
> templates in this file.
>
> Found after moving the usercopy selftests to KUnit:
>
>       # usercopy_test_invalid: EXPECTATION FAILED at
>       lib/usercopy_kunit.c:278
>       Expected val_u64 == 0, but
>           val_u64 == -60129542144 (0xfffffff200000000)
>
> Reported-by: David Gow <davidgow@google.com>
> Closes: https://lore.kernel.org/all/CABVgOSn=tb=Lj9SxHuT4_9MTjjKVxsq-ikdXC4kGHO4CfKVmGQ@mail.gmail.com
> Fixes: b19b74bc99b1 ("x86/mm: Rework address range check in get_user() and put_user()")
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Cc: Nadav Amit <nadav.amit@gmail.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> ---

Thanks: this fixes it here, both under qemu and on real hardware.

Tested-by: David Gow <davidgow@google.com>

-- David

--000000000000404af3061a972dc4
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
hvcNAQkEMSIEIGGf0FbWQBXElxXhKcACOdaBZboCNMX8T93QLr1mK4jiMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYxMTA2MTQyMVowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAq9IW1
PsS5RyRm+2iPrCTuWhSycsSm08uCE+WwPo47gYpNjU01ypNIjFGlm/VNmP6qGRAQmM+sUcQ4SoFm
/3elrTkmEbGd5NuUgqKSxt1Ohl9sMMjnK/ENFHY45ucSjeUdRT6ZqvMXdxMyZx41xjggXW+FS95k
u/F9B9KBhZe9ZOmVkn97jXJoxqdmqScXNUD02xBE0WxbEwxMLfO7RbEXSPWxUCb1oUDj6yhRkYWx
4+1SY2sHyF/4LA9lyx0B31Dl9nZw2uvQ47LPoUYdbFGdmp5rzsFbcWSofvCcjcbNOJ+QtxRqyicy
Axhwp8FbT34Snz4/XeHUv15qaA71XviC
--000000000000404af3061a972dc4--

