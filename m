Return-Path: <linux-kernel+bounces-392805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E699B9853
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2161F22454
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1BA1CF2BC;
	Fri,  1 Nov 2024 19:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C8GQQeC2"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23A81CF29A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 19:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730488860; cv=none; b=Pxnncv/zB5aXFA/6+TsvkMJn8GlgoMIfkTb+JwP/7fxCJZoWaRUJhRJLt8tPAk7v5ZeVRlLu4exyRO1pizyqCOvJSME39ztSOMlfqRaefphSSJTpyM4l5Sr91mI10tM7CVPRrp26HaUX2fTDGHOQ9bJE7vgvNbaPnMrl7B8y9kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730488860; c=relaxed/simple;
	bh=i1Qh/rovIHVYYdyiuRH43nx0aEooiaB/Bx/bkmP5HtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5lPHaCFgNufhWjRyxThv9gz0g5wi8/UN9OxZ3DaFXRqYqrGsdE1a8ZxHoNovxvRR3TBlYCcMbhCGPELFpczzyDcxZwjRhDABCZ4tLDPt0Uz+H+RnkgHw3cP+/lFUtR+QHxqKWqmleoHuP2sy3KQjDiBPd8efQU5Swd+3ENG3uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=C8GQQeC2; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1ecbso3002986a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 12:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730488856; x=1731093656; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uvYlMBtl+F5FON3Q1xVKWLAUxRKsapdQmwjuy8Eun3s=;
        b=C8GQQeC2n6co1+wLTJgff+Jo8gJaoKdSYt2ZbwGhnPelrZcwMPpt1tYx972S0I/27F
         FtOBZHPFPDD6OZlNO6e9qE+cXlPEOCwzpD/N3AfSAQVeIxAxu6ObUL7al48fKMWkyRVU
         Tqs7eaXztfdon72u2ZnyRc4atrT4PN1TADmOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730488856; x=1731093656;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uvYlMBtl+F5FON3Q1xVKWLAUxRKsapdQmwjuy8Eun3s=;
        b=ihbSbP1WZB5XhS9e+qFGfwcbP1ZJauNG/imYVyvBM8Yx6/wWFHDpB6csp0TJblVYjO
         G/Wo/Ejb30fMKrXbhYl1PyMSTeAAEMW2Xbq6VXbk3tzxUzup6S0Kqdl9yzEwTcKMzNux
         5Q/YjphaWQOhuPCzQGSz/L//gL/cpaB9NPAP67LpqkOi6enMuXMHtHH0SZ45KqEyIHQh
         Qr3gQDZNGrJoP/IOXV3TAx4ep8E6wQUEd3MGMk+Xm0vfUQAqtAZGmLJxa1xChIMY2ZMw
         Y066ztTxjThezIw2CGYoze5F0W6Fp+X8Q6av5/stsrLns2VyLnfKDyntm+cGFh48vKpa
         cpQA==
X-Forwarded-Encrypted: i=1; AJvYcCU4Bc1SRuPaSPFesxMeQyorrqspKTanO7UD5q0ME1jPgguArUo7c7YaRLdgHPt11zXDK52VlQb8XHIGwcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLLFItim+5+004FAPhm7qijWjd9o4SUmIge1hGSbINloC0wZck
	CzWmZmhCVGqAv/52st36uOV2T6NddaI9C+94/jz5TkuY5y4juYiPRWZz0yn44sC6qONDyKvJ+bc
	UdodTOpWYWxzzWnXjXbvQJqEiy19RVWKTwa3L
X-Google-Smtp-Source: AGHT+IE6ANt3DIHYtH1bjPYYj6YGv/SmmYQGidOOBCs2UqhP5MxDKfJyU1wl7hC3eUG5N7rQA4/g1z/ix1ZL5Mg8LzM=
X-Received: by 2002:a05:6402:4011:b0:5ca:18bb:6ad4 with SMTP id
 4fb4d7f45d1cf-5cbbf9208cfmr18907980a12.27.1730488856115; Fri, 01 Nov 2024
 12:20:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <219859e674ef7a9d8af9ab4f64a9095580f04bcc.1730436983.git.dxu@dxuuu.xyz>
In-Reply-To: <219859e674ef7a9d8af9ab4f64a9095580f04bcc.1730436983.git.dxu@dxuuu.xyz>
From: Michael Chan <michael.chan@broadcom.com>
Date: Fri, 1 Nov 2024 12:20:44 -0700
Message-ID: <CACKFLim3y5-XMBCpCMA-XnLe6yho6fY0Hbcu_1jbf5JKrhCH9w@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: ethtool: Fix ip[6] ntuple rule verification
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch, 
	kuba@kernel.org, vikas.gupta@broadcom.com, andrew.gospodarek@broadcom.com, 
	pabeni@redhat.com, pavan.chebbi@broadcom.com, martin.lau@linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000094c6a60625ded5f2"

--00000000000094c6a60625ded5f2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 9:59=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Previously, trying to insert an ip or ip6 only rule would get rejected
> with -EOPNOTSUPP. For example, the following would fail:
>
>     ethtool -N eth0 flow-type ip6 dst-ip $IP6 context 1
>
> The reason was that all the l4proto validation was being run despite the
> l4proto mask being set to 0x0.  Fix by only running l4proto validation
> when mask is set.
>
> Fixes: 9ba0e56199e3 ("bnxt_en: Enhance ethtool ntuple support for ip flow=
s besides TCP/UDP")
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

Thanks for the patch.  I think the original author Vikas intended the
user to do this for ip only filters:

ethtool -N eth0 flow-type ip6 dst-ip $IP6 l4_proto 0xff context 1

But your patch makes sense and simplifies the usage for the user.  I
just need to check that FW can accept 0 for the ip_protocol field to
mean wildcard when it receives the FW message to create the filter.

I will reply when I get the answer from the FW team.  If FW requires
0xff, then we just need to make a small change to your patch.

--00000000000094c6a60625ded5f2
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIALYqcBRuoLJps5d0vLdqqhKoGz+4wb+
7QjPcMGmIxL1MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTEw
MTE5MjA1NlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQChNrhgXNYbiWn9ppeZ73q8N356xZTMnykpNt7wzqAENjnfjWhB
/o38qVIW5w4EkG0shPhC/5WiDZEhO5rkw5XwnrPU8MJ5xgZVOPGTSNZ4EuimbRNcbUxlipDIh6s7
I8loLy5ERmx8ievW/JNhEP7bze9OFdHDUJ9TQjOxw3qlVfE6B8afjCGktDhrxbCkS+RBmNL4T25V
jVCv4kNbYi6FjkhYcy5CoRAgX2Wn2tRDT2dgZOrQq8ZfYtnrw8PMQGMSZhyDSa/zAI0ne+JQSARh
Z7sl6uVkPApbvkPjhB23Jlcy0gpcRHrgXPWtLH6Mv8dZ4bcNqEcrQGQIXdpqeJbA
--00000000000094c6a60625ded5f2--

