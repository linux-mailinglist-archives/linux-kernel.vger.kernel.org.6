Return-Path: <linux-kernel+bounces-544243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC2AA4DF3C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 380093A6205
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A2D204C22;
	Tue,  4 Mar 2025 13:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WUp5C892"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB042046A7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741094770; cv=none; b=p54hK29cu3XY1uf3f1NQ+kuIuw2/B0tu0ajGFZWWvgJYEV8VRv0KvQn34PkPZWibV/vCWca1tlcCobe59Pp5x71cBgzzQUqsash5sXF88LDPaRNC4QiwNLvrMB6qNYvDX647m2ILpQhVFKV4RLfonuRBBZS8kxwVmXvRmgb3ROs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741094770; c=relaxed/simple;
	bh=HBaI4AQKfIhj3hYsM8gpqFECgxkX1bbwaujHiYq/TAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p1co7N6vjL/1cAFvHPqUh5U3f2vw35Zamg98Y2gxHaLxNVz/WRTeMtxD6HtWLwALEG5zNfQiEWhYAo+FXXT+819DTjiA2oaAkDXr+P8Z481hb7KpZKLhDz3Jb8bhQDg6tPjqfS98YXm8ZeMLZ1Hvhpu92WBKt5r4F241XBRqLPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WUp5C892; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30762598511so60190351fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 05:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741094767; x=1741699567; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JtOKkHl1iiOm30LH4mkCfSdNp2xpawwM4XCaKG03x2w=;
        b=WUp5C892hPw4IJsacGagGgsk2vwbNc4sKrWcdWHV396cgadc7HlVP0cCiAvszbU2ia
         mQmMN0+r/pOrgSQvYpHRI49rfgNE/mavbTVKfz+VcEWnfrJv/YEZj8jZ4nxqylapJz8L
         aG/9Z+CrstydypIQArMFaNSocWan6RK7ns/VA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741094767; x=1741699567;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JtOKkHl1iiOm30LH4mkCfSdNp2xpawwM4XCaKG03x2w=;
        b=auFPTfVzwmL3WXFb74YwYIRDBhAWaGWcFyeZ8gArpGevO4cH/hxuiZ3UAmSVIlzZFo
         MvxBG/eEqOX8Y9VfzJHSUQB3fJVuEVE8Kw6soYtA4+Zsm+Y2NOOVPhRo4zm8jPMJv3iJ
         2dvhylmOuBU+zPxziVIo5IR9cXb7DJru4ilTDtA3HpGsrfVAV8/nBLcZNKET79E5bvsJ
         A66LaXPzsyTYoVGlgkj+UkYiG/K1/UoSQT9g3Yjx5or0IqkSxjSpZE9SHDLZCOsL/DKR
         viFQlIngcrH5PRGzrWBg0ZcWHmdZyZMipCwAGNmoO9bIgXwk23UTkO18i9p3J/h470JV
         3dDw==
X-Forwarded-Encrypted: i=1; AJvYcCUujfcTOmk6Z3kZmiBMSJd9QHyv+iRyk2Q/++pHV1bQ54jEP0c17pvW08wNaCZ0KlOHVlU0eU4Kz4rj66A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsNESirNC01oIMHmWNVwjKH9JyyVPNQT6qpv7dwMOZLqeJPADt
	XktExJJMKz4GvM3YR3zRTlaGgfIPIztWubTVaP64dyihsQvhSeha6/s92bumgHyFcQN8mjb8mb6
	Wz/ZKF1EKvS2d1vuWELOoJLFEEOdXiruhFbZa
X-Gm-Gg: ASbGncv6qAH+kB0PmGHtbfSrH2Ksd9VC6MDlguy0r/wJserWPKesB1wgWbKLuvcujfJ
	BhmtN8R600Vu1Q0m5A7Z8KK5/+jVRRsIWtXmQur4tI981ERhfXj+s3BBps7LrGPeDiMCf5mcfHT
	DMxEkwOcVbWCo8hNNBFvASBjf0J1E=
X-Google-Smtp-Source: AGHT+IE1fnmaGTtyXaw7/d7C9go4wrsIqUzlwKMfbYL4hkHb1EFadcc7K9+23gbqCV1n5NJPFqM8+LXdIaOOkUO2l3Q=
X-Received: by 2002:a05:651c:198f:b0:30b:ca0e:e44b with SMTP id
 38308e7fff4ca-30bca0ef27dmr11607361fa.31.1741094766721; Tue, 04 Mar 2025
 05:26:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z8TWF6coBUF3l_jk@gallifrey> <20250303182629.GV5011@ziepe.ca> <Z8X4Ax5UCerz9lP8@gallifrey>
In-Reply-To: <Z8X4Ax5UCerz9lP8@gallifrey>
From: Bryan Tan <bryan-bt.tan@broadcom.com>
Date: Tue, 4 Mar 2025 13:25:55 +0000
X-Gm-Features: AQ5f1Jq8atYz5IidmM6PHJd10QJlM7atnIVUN9cDk3zl51sJIJsRs6HYHqrGp2Y
Message-ID: <CAOuBmuZdG7SWWmmhtEF09B5A4O-s+_h_uZnmTOPyKtQJGM9=wA@mail.gmail.com>
Subject: Re: Unwired pvrdma_modify_device ?
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, vishnu.dasa@broadcom.com, leon@kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001cebd0062f843766"

--0000000000001cebd0062f843766
Content-Type: multipart/alternative; boundary="000000000000176cd8062f843726"

--000000000000176cd8062f843726
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 6:42=E2=80=AFPM Dr. David Alan Gilbert <linux@trebli=
g.org>
wrote:
> * Jason Gunthorpe (jgg@ziepe.ca) wrote:
> > On Sun, Mar 02, 2025 at 10:05:11PM +0000, Dr. David Alan Gilbert wrote:
> > > Hi,
> > >   I noticed that pvrdma_modify_device() in
> > >    drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
> > > isn't called anywhere; shouldn't it be wired up in pvrdma_dev_ops ?
> > >
> > > (I've not got VMWare anywhere to try it on, and don't know the innard=
s
> > > of RDMA drivers; so can't really test it).
>
> Hi Jason,
>   Thanks for the reply,
>
> > Seems probably right
> >
> > But at this point I'd just delete it unless pvrdma maintainers say
> > otherwise in the next week
>
> OK, lets see if they wake up.
>
> Dave

Thanks David for bringing this up. You're right, it looks like we
never wired it up to pvrdma_dev_ops. Feel free to remove it.

--000000000000176cd8062f843726
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Mon, Mar 3, 2025 at 6:42=E2=80=AFPM Dr. David Alan Gilb=
ert &lt;<a href=3D"mailto:linux@treblig.org">linux@treblig.org</a>&gt; wrot=
e:<br>&gt; * Jason Gunthorpe (<a href=3D"mailto:jgg@ziepe.ca">jgg@ziepe.ca<=
/a>) wrote:<br>&gt; &gt; On Sun, Mar 02, 2025 at 10:05:11PM +0000, Dr. Davi=
d Alan Gilbert wrote:<br>&gt; &gt; &gt; Hi,<br>&gt; &gt; &gt; =C2=A0 I noti=
ced that pvrdma_modify_device() in<br>&gt; &gt; &gt; =C2=A0 =C2=A0drivers/i=
nfiniband/hw/vmw_pvrdma/pvrdma_verbs.c<br>&gt; &gt; &gt; isn&#39;t called a=
nywhere; shouldn&#39;t it be wired up in pvrdma_dev_ops ?<br>&gt; &gt; &gt;=
<br>&gt; &gt; &gt; (I&#39;ve not got VMWare anywhere to try it on, and don&=
#39;t know the innards<br>&gt; &gt; &gt; of RDMA drivers; so can&#39;t real=
ly test it).<br>&gt;<br>&gt; Hi Jason,<br>&gt; =C2=A0 Thanks for the reply,=
<br>&gt;<br>&gt; &gt; Seems probably right<br>&gt; &gt;<br>&gt; &gt; But at=
 this point I&#39;d just delete it unless pvrdma maintainers say<br>&gt; &g=
t; otherwise in the next week<br>&gt;<br>&gt; OK, lets see if they wake up.=
<br>&gt;<br><div>&gt; Dave</div><div><br></div><div>Thanks David for bringi=
ng this up. You&#39;re right, it looks like we<br>never wired it up to pvrd=
ma_dev_ops. Feel free to remove it.</div><br></div>

--000000000000176cd8062f843726--

--0000000000001cebd0062f843766
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
kKXUf8BmgVwrm4J21BIjpK/E9/meSALtIG7FIMpiIKpgHf1MRTzmYywQIWohaXxPRAEIYZK2DSMY
n+fDChhou4ePAtzo6/x8PTSWPrJbH05U1DQt9FRG7+xcvkNqnjJq+XZK0kiDDFD8BzIKO/cq3ziS
50EhbzFKXPpa46ztpJqQ+UJTJod2dB7SexAYJlBkjKlGc+niNQIDAQABo4IB2jCCAdYwDgYDVR0P
AQH/BAQDAgWgMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYt
aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFww
CQYHZ4EMAQUDATALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRw
czovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEEGA1UdHwQ6MDgw
NqA0oDKGMGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzLmNybDAk
BgNVHREEHTAbgRlicnlhbi1idC50YW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwME
MB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQWxgja/oUqPdrOSir6
U+YDJVND/DANBgkqhkiG9w0BAQsFAAOCAgEAIL+CGrIYdRkQ80Psq9FtFG65/EZQH8dFSXv3AJTk
220m3Q98q4NHh+AkBRw/pvzVQMJlRKEBKgM1qYw5FYYoC3IRpeqQ9NqnJHsEAHX2p7Hfkt3l8zd7
rT9DuQ4Tws1Fjxo4L7OcRz8NDD9f0Y+LHADvcMUHoex2PldpXkGuWd4K1eMjga8xPOrKKYYdvWYw
cX/rc+AYfo3B0OnjSWXjdsufMPVDDK23uGYfti1djyVhYG7hOCKjW3fg9QdDcVjVa4q7spoCPGnQ
HGghAH5+ZauOJU1r26oGjwR/73xvsig9pX887/zvEM5WdbTXK82mciLRR4iQB0UlV+8UxxpJzfGd
j/6onem1o3e1fTH0owcQEn59i7Ygo5cWJm0qnT7zPTS6pgkXJ4xmskj6Dcqi/hRkMlxovq3K05uN
+lgAFg6F7ugpiGTUcxngHsGMRlj8cXIhg8KZO0gBU5KthBSvioQgN2JpAyE5gUV7stnVCu8l+SAr
Oo+OqcCeAc14zE+TlRnoQVn/xF+q0zAyONDNmQO4uyl0EyLpTIYLK7wFxC6IDrz2FsEzlioH2cBJ
lUyNMZuhR7c1KUj3dr4qBG1506iDiJ5qqn2rBKJAvk0ph2Irlh+82seX1iL/wX+M+Wwkzoo34GGq
6CGv4ffBr8W+eQ2/QT4X10tgfAgSZ+Sag3gxggJkMIICYAIBATBiMFIxCzAJBgNVBAYTAkJFMRkw
FwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlN
RSBDQSAyMDIzAgx+bIvtS2ArBR9RakkwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIE
IHO/NaNsMo8QupLzakrHB6dn0t41He3UJRhH3NTNkn72MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDMwNDEzMjYwN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQow
CwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBHACgKX4vOT/lNO8/H
j/or80XMRuw9SjMyWB2+q3idyrLLgisOXFvenS/eZMnif0FawfdLv14OLkAULCq/PxElTisK25nL
II8Tp6PAxVJnjsCulsatwhXtKqKrcEZXrL36C2dQOAb2vMWP+P4Mdk42AiVj10CeDbBSwUOFWDfg
a7oOG3XfsBMx9W2sMPqlfX6B1H4cCJpQP74np1YDP68gUeB1PvcFs9TwN7bRlwGoRcT+TfRkTnwF
Xri6lq1N8ROz77aqERWm1dgck+Azbqk3TwBzGsGYCt1BWPjsZ6d6Sq6B8tFI3uy+p1pydiLWYDWz
1bqle9ty1OM7umWOeHSk
--0000000000001cebd0062f843766--

