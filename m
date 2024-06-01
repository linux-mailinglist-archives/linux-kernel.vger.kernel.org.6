Return-Path: <linux-kernel+bounces-197646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8DF8D6D76
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 04:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4A21F23F34
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 02:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5786FC5;
	Sat,  1 Jun 2024 02:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xoyE4+Vf"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080936FB6
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 02:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717207679; cv=none; b=Ot7iAkiq515XO4aH9H6wPosrppvITkjMjdoMTj058HxFu0zZdQh+pNy/B3andwUcsJ62bxLIHMuTBt4eSHNk/e3YO9cWVKTgfoFnmijMHT8mra0RNKnAk0PA7fpp4qSchBYBbN5WVaGtD17rfjeJ5BhHZJnLIc7aGyJKLXz91ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717207679; c=relaxed/simple;
	bh=cu0KRwCC76b3lbx/OOXUmqHF8NyAmoRtlegITKeKeZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KKUM6Hf18AKHU8xREOwq3MfMSQJ2Bdr7VFlNWNPKJlahP+9CGpfw+I7Z/47HiieK2oK3evCxAyrhUvyzcGpIQ73Nw7H7cDAkOGqkU0EQWOQw2sLm5UPhNLkMy8oIZtDcGd7WfgNmDErOVE1ydsC0M5eiPCf0SxjShN9ifF60QcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xoyE4+Vf; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43f87dd6866so110081cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 19:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717207677; x=1717812477; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8jRBK72dniQ0ChtQMjZPfDzwWgKhJelKnV30WK36yLI=;
        b=xoyE4+VfyprQKJxp/z/o/ppU64cpILujSNIXMRjDs54u7/Oc9KrC3PCfN8ntoxibsk
         C7gowtgarITybqrReHnZyOUgMiVnr2csyRhGOe6jwJ/SLo6QNJ2nTh17+iu/Br3yClQH
         C1q7azXbUO7lnQDkrBJNxBPUvLo3ebIz3UDHuAgQO+xvDITqqOy871NMj8siG07jZHHP
         SQvIdqzlSpQNGU//CbICN/2kcstJ6AwIW9hOLjIf73XwMezmo6jm6mn1Mea4zVBv8CBv
         HxzXXJQCp10M3pFKmXaBASEWfAIHYXr+Qfp4l2oG2SYK0fq1nfwpVLvdvw3SMbs8kGq2
         EWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717207677; x=1717812477;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8jRBK72dniQ0ChtQMjZPfDzwWgKhJelKnV30WK36yLI=;
        b=AsDBI9elAJfL5HqID4Qsy5OaR9Y1a7gP8g0HzobKRZM5vLxeQlWt4jVSH9J3SrttGD
         Gp20zXs9riiwPvgpICV54rR8xgH3f232SEIs2f/JG+HzC+Pe4dH/D3BuqY9ZzWpeEQnI
         WelhRgQtivxFgjC26mopiz9CxKmSHbBPlf1mzqM3HGH/DtOpoUhhrBhEl7DlLyg8bI0P
         PP+lG18tk4ZiZWWMMopPMf9+2fxDQfADE+m93mLvOeX88U7WJK0wF2ScmLiow3tMdD33
         tTz2TZXuG1BnRCPWRPgXb/K1LoIU5akdFGLFxBYQDZ+7nXLVY+9f5Pk93IlcdfAzfxJ1
         BNpw==
X-Forwarded-Encrypted: i=1; AJvYcCUGWpG5kmutmVKcWjKk41jcTPSsT+w4pVZrRJkvpCmUVur8ojr/YcRZkzRYo/kOsZQGPvM37EgfyZgCjZduS4A0uoDvUz+jVPiNqW5W
X-Gm-Message-State: AOJu0YyPL8l5s+TsxS9oVkRuKr/+O40NXUWKs8pbojtqI1E6m9+QvFxd
	+sOMqtReYJgjaNSh2dvIhLLa8SXnY02IdshR8AtpR3Dc/9uZZIm4PpYKuPauNp/wsbliPLO1jtC
	m5eMqnUNWEtrYmB5TKmY7yZ2iObqwPgEfx7Mg
X-Google-Smtp-Source: AGHT+IFyURzpZOeX1JNndNfINIWG9Lns7mgHr/ER9jSjznjLFE8yeIlpLyM5wdd4Fbe50htU/NlxZWwXyOyZR5bB06M=
X-Received: by 2002:a05:622a:5814:b0:43f:ec8f:71f4 with SMTP id
 d75a77b69052e-43fff313d20mr846421cf.5.1717207676348; Fri, 31 May 2024
 19:07:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531151801.128792-1-linux@treblig.org>
In-Reply-To: <20240531151801.128792-1-linux@treblig.org>
From: David Gow <davidgow@google.com>
Date: Sat, 1 Jun 2024 10:07:43 +0800
Message-ID: <CABVgOSk2xPmgYPEoRwqWW0YJx8oU-Z2UOX=8iWtiod6FFposPQ@mail.gmail.com>
Subject: Re: [PATCH] list: test: remove unused struct 'klist_test_struct'
To: linux@treblig.org
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000009abd060619ca912a"

--0000000000009abd060619ca912a
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 May 2024 at 23:18, <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> 'klist_test_struct' has been unused since the original
> commit 57b4f760f94d ("list: test: Test the klist structure").
>
> Remove it.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---

Nice catch, thanks! That's what I get for copy-patste, I guess! :-)

(I agree that this is better without the Fixes tag, too.)

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/list-test.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/lib/list-test.c b/lib/list-test.c
> index 0cc27de9cec8..383ee0ad582e 100644
> --- a/lib/list-test.c
> +++ b/lib/list-test.c
> @@ -1201,12 +1201,6 @@ static struct kunit_suite hlist_test_module = {
>  };
>
>
> -struct klist_test_struct {
> -       int data;
> -       struct klist klist;
> -       struct klist_node klist_node;
> -};
> -
>  static int node_count;
>  static struct klist_node *last_node;
>
> --
> 2.45.1
>

--0000000000009abd060619ca912a
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
hvcNAQkEMSIEIBVDleRvytmS+NCbsZN7a7LVOlev631SpoJc+BqP/uKyMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYwMTAyMDc1N1owaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAilGkR
p+Ktw1+uiPHCPBQkEvhmtSctbxPS+s28q+34USWN/9lOhl+FWrIl2hOmbcSlMAAUzbOrnVOY3zK2
7RbRGz1rQ+xGr15QU/FjwVi2Ytx9hThnSuP75Fpb3N0mk/K722/g4JtA49d6VLaxKj/WYZ7LXL0e
NvFWJfCkrdZMzWftpB3xY7kUJBiImRjMoJcvO8Iq9pJazwWvW6M6ev4O2Sx0JHmuemFWkjMK2p0U
73Fb1LU5Y5vNl5lal4YkeA0ePocDRrrwpetU81mc1w1s7m99ihz31pZFsFYdtBuFY0Xb3tz2OA2Z
PzQhoZNnd78tlQyIunuEP76IViW6J6FS
--0000000000009abd060619ca912a--

