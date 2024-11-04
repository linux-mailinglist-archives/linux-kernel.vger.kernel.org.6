Return-Path: <linux-kernel+bounces-395293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFFA9BBBCC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC6B31C22809
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9F71C4A30;
	Mon,  4 Nov 2024 17:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Az/41v10"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6591C4A13
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 17:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730740932; cv=none; b=G4wbo7qSS5lEKnP6XIbj7QcHJkiFoZRsewEPRDHxhi5Oi+lhC9Q4iFXcinPgw/Z56eId0UkxCV9pRGiCY/ZlvQoWctPpadWgkppMd+n/ciIxMVkCYMJnbut06hcvgkYzeb6ymGAvbXhrmDk5OC/BKzZToJK4RlCGBXXz2Zm5mMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730740932; c=relaxed/simple;
	bh=oERjB3cstIzkBtxUYOAxFlXTIF2C8tk3pOfT/YQis3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWpgzTdtrZ+9rumAecjjbQ9HTURAmHMrITAsyIqzVSq/npKaIRbUI/7KsnYLgvt95wuP4zBSYoLkAMBjlbFODyvEDRVCcmiEXMfzLieu5Ant+nzkdqi99/cxa0lTxx7pCty9L1KsiRECpWF9oDCQXIu8IPB8aJXCCMGRkxAJGy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Az/41v10; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d47eff9acso2879534f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 09:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730740929; x=1731345729; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7vuS2C31zgd4NT1oK/IqNI/PqlfFz81BFM3bm0W9rko=;
        b=Az/41v10mwizrBTxvw+7zHgN8wfK3jiVYMBEvUAG72pPbUc1xFb0Ukv6wm8v1Efk7I
         gSEjJiqx7LUmUUcei4b+FJ7OnnulROp7Nqsnb9itd5NGVUR8TR68QXb8eRhQWUt2qstl
         8Y5VL4n0YO4ZMUv8qUoAssJSqE2ikEWP7ysso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730740929; x=1731345729;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7vuS2C31zgd4NT1oK/IqNI/PqlfFz81BFM3bm0W9rko=;
        b=bm7wQHHB5xgpryL3FBOEfmNbaQVajPHeAM9VzQwGhPIMCa7vzewdePQmg9RBexEY/x
         I5wKxVbQegEzTN5UWEB+KZYHJZD4J14qj0yqQwEdmBVIesKZ3nspUfTlMGdKgRbcas7L
         ssQK+fTIa1FgU4TT9iEtgdnh8+E0HuICiRJOkNSHATrRKF8xAPtjHOaHgf793zlF1Aoi
         /xC21ysYUOuGgT+YUebICJhjwEdZ8QvRUteR11ng5bgeLfhzh996RRfMgUXDiWG+jEug
         4i1BhxfLAfwFG4iccfu2/7Isw4dKq8jdlpotDBQ3BH6Ltv6uFtBG+PrXHi7rc+PyBhG3
         TsDA==
X-Forwarded-Encrypted: i=1; AJvYcCWi61AleCLTqLtT2KzvGRSeLAhR7/X6pPBEReLnjZP6djU09WWbF2bQCgzmh/QkWPGNgX1UAZnFDVMmixc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyvS+xiMSaMJi8q7fPOpgesnbfrMLzBfiTUTmOqZsdRutplDkC
	7CM6KLq4Lq/aw3J75eYyAbcRH2keZfo0dcleeTXjfyM6L+g7fkiPfC5ZztzIJql8gXm7D6JG/1T
	y42XrkdcfvmCBNzITc4iK6b9cIHhhIKxuc1EG
X-Google-Smtp-Source: AGHT+IH6kQDuoQzLeOBrQCc+dLm9LWdCGi+7y2nxk2UoUIPdPETZ28/lyLSM2SeUVhkmGPZBjNiw9bJ9ygrqKS4/TTg=
X-Received: by 2002:a05:6000:2109:b0:381:df72:8678 with SMTP id
 ffacd0b85a97d-381df7286c3mr559176f8f.16.1730740929309; Mon, 04 Nov 2024
 09:22:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <219859e674ef7a9d8af9ab4f64a9095580f04bcc.1730436983.git.dxu@dxuuu.xyz>
 <CACKFLim3y5-XMBCpCMA-XnLe6yho6fY0Hbcu_1jbf5JKrhCH9w@mail.gmail.com> <zdshp6klnjjexwxpx6e5k62jej6xmxiubmkegkk3tixt2jk5t2@poolzxiibn3n>
In-Reply-To: <zdshp6klnjjexwxpx6e5k62jej6xmxiubmkegkk3tixt2jk5t2@poolzxiibn3n>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 4 Nov 2024 09:21:57 -0800
Message-ID: <CACKFLik=SE4p9gq8BZJY68W_9QB=szU6cAwd-UgsvnCxQ6yu4Q@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: ethtool: Fix ip[6] ntuple rule verification
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch, 
	kuba@kernel.org, vikas.gupta@broadcom.com, andrew.gospodarek@broadcom.com, 
	pabeni@redhat.com, pavan.chebbi@broadcom.com, martin.lau@linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005141fe0626198626"

--0000000000005141fe0626198626
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 3:42=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
> On Fri, Nov 01, 2024 at 12:20:44PM GMT, Michael Chan wrote:
> > Thanks for the patch.  I think the original author Vikas intended the
> > user to do this for ip only filters:
> >
> > ethtool -N eth0 flow-type ip6 dst-ip $IP6 l4_proto 0xff context 1
> >
> > But your patch makes sense and simplifies the usage for the user.  I
> > just need to check that FW can accept 0 for the ip_protocol field to
> > mean wildcard when it receives the FW message to create the filter.
> >
> > I will reply when I get the answer from the FW team.  If FW requires
> > 0xff, then we just need to make a small change to your patch.
>
> FWIW at least my HW/FW seems to behave correctly with my patch. I did
> some quick tracing last night w/ a UDP traffic generator running to
> confirm redirection occurs.
>
The FW team has confirmed that ip_protocol 0 will work as a wild card
on all FW supporting this feature.  So the patch will work.

But I think I want to eliminate the l4_proto 0xff usage.  It is
non-standard and non-intuitive.  So we should only support l4_proto to
be TCP, UDP, ICMP, or unspecified for any protocol.  Thanks.

--0000000000005141fe0626198626
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKQh/PwI35698dGnO6nKC0nApfj2AjcE
Ww+86L1eVMdQMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTEw
NDE3MjIwOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBPK1S2q7DKEa7a7EoZVWB0zO1r7rfaySnF4aABXNixFSsjDMHZ
zA3bj/d+wKM68wh9ei/dw7PgmvNZDDdlvTGlXm2xyh4/cvctD3nCUe2tBoNxBJuwD//MuSSLAr9g
XWOWomaxAHbhhBSkAmT/QpfVpEp6WS5lWSE3B0ENMHZI236XrjFuNtARZ0sLDgK8FsWNjl5orMw9
wYdpAF49Z5CpKkx73ckxvovyvVisGRQSVA3GfRQ5ByBK19n79xmy6mGpVDKt/BtVHWIW3BxXVUj6
nTarTzxVFbdgoj3doHQ/IlgSV8q52qvPm5xjA8VhbWjgBAoNTO3MsWqC7BRyj4qv
--0000000000005141fe0626198626--

