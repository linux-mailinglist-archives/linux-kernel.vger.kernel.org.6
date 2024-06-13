Return-Path: <linux-kernel+bounces-213972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3884907D35
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 22:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 672F32863B2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 20:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB72A137921;
	Thu, 13 Jun 2024 20:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.de header.i=@yahoo.de header.b="L/lp1159"
Received: from sonic307-54.consmr.mail.ir2.yahoo.com (sonic307-54.consmr.mail.ir2.yahoo.com [87.248.110.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244B96E5ED
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 20:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.248.110.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718309649; cv=none; b=MSHAfu+GzpyxqEk8HoE7lxMU87EmUG3EFMuOeXS9TA3t9NRnCHRTaFSeI5AhDkOnXKiOp2QvbchPJM6YLmIUrP4psPGT+eMcgetpxNm6nTyO+Iji8MMkUVDeZX1qmjwKz37Odb/TRLDsMtFJzAr0PmM9dl9TeDzpCY2yWCXCepo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718309649; c=relaxed/simple;
	bh=1hZ/k1GsSmYPFuV9nBpgP4qq5xk3DIIP9DSfMBFEVls=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=QwPekmcYVw0uRABoF4hvjNAjz2fQGQtfd4HHIAYP3asH5iVUOQ1bDvjWHFDAiilw5GvvQuUn8gM/lS+gPZiVjXFtPW98R1uSiL6/Ajk9yjB7hPUoqk9clmjtVJ4+5A5dP+KgmcfUo5aYif39hYDXpsb8sXjT+ZS2mJ16+DdHVt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.de; spf=pass smtp.mailfrom=yahoo.de; dkim=pass (2048-bit key) header.d=yahoo.de header.i=@yahoo.de header.b=L/lp1159; arc=none smtp.client-ip=87.248.110.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s2048; t=1718309645; bh=RrGCnTSyPJKlQ5Ei6xJl/7RvkmYAdFmjwFsA5A5Jnpg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=L/lp11599e/flzSxf7UlYq0bmP6yGD/DUtrfk7nCdbksODH7s42lvyNeT9RQlgRwcg2hRIJbPcgvfdmjI/4XAjujlh8sCwhMZEMlvgYsxefNF4gJaFT2EQGKpxYbmOCulnOeaNWnHSuWtp4JoebtZbE+ZaA1H8olNHIHyyvaVEkdFjk/lM8XihiIhv9ZexPBtbbF7bHljtcM50XJUVdGN7Ee2SrTeNqXFhQ5aRQyN8NdyIblEZqV6zpuoPvROUkOsLyXSGp1TlxU7cRCKgQwEqzF6ruq68UrhHu1oDSljq3opAMHXIRn4tsFpTPyRbQzoBGXsg3ZV33xEz9AAVifww==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1718309645; bh=2SE7wgYJ/EoPN1XfEziXo3LyJ8DLYMBJulfjDLk9bGi=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=QYtqANUJISCC7/8xOBzHkVlYXVZzCR3hENeOIfzHdUSmnmsUTSo0Ccdx5o5Pi+eZHIX45bAOe93yRD6yZZdNvZGDv01bfz12AQ9+CW93buTQiduM+TuhhKhgYOyYtGpdTwtxV5SqUFBOPbKQX2qlkUrMDgenUr9BJwcAlMiOJzMFMJgf5OuMN8IJ/aHcxOLUNKDX6HFn0EBYDrEIoOO1vPhNTU9mkAJ0K6IvI2IyGP0xHXHOvxq/gIzcq/MkuB/FJYX1KydIRIoXdP3iVVJhTTzgR9imC9udcg2b8xElfoKGjeXz8X4EM181xK+J4U9CWUhbTtrZXigVwyUtW5OhCg==
X-YMail-OSG: Q5sqHj4VM1lLvfRqOVDFzzZADWUDlfJMIXZ8_9ebJq5e4vFrIZ9BPEBozyiNz2Z
 dMHFS4Jb_wp1YIVqeTIfi9sVQGgYXb0exXJbSndhMHiFwhJWw.6wrY7tlsKuhiSaI6Pw0EPsHB4r
 jJCGXMK4uXIPixidEbjacd1f9_w.OHSNiOsqC7wvTbbyPGho5iDZrwhb_32RLbR6j1RJ9G0oVnSM
 vdSY1hG_QfDHrGxQfLsrrXz_XP5XYWSr6C8HCITH5OF.StWzpxAzb11Ct9EqE9VFHOvSWYehXO5Y
 KQUN.LZQSPoYWmXxwhYK2ofr7DLtsZzKRvnShWZWLCcwesWY3ky28OF._Ad9GsLN0fnIHvsnsADs
 TnNBTTFz8wwUPVH.8g3S8dtOm5cRg102ij27whQcPDlnFaXHmX02afibGJifZDZ6sdH58xWtMSU7
 a.1KKxDrPgUurfOgJYogFwBBT7XzXdxCjouu9f6v5ymi_4Yekr.Gt4MvWPDVuC_OXQh532jBBJSX
 _1lTtb800ShZLDLWht3Gmg_Y4dRNNkBz7KALaR4re8QCkm2Y6Sd1hGwqGb2jc_sHZCZW_3uyIbYn
 OxO2QFRqUBNW5FyAXsbfq6TbVITd0yRrvuDHXas_5ZubwE2mlcB4ziKW9Gpx9J6GZYAgTSZBpAwg
 hdeoaNoO.bmfWLfQs_fMvKBMgu0Eu4gGyPtBbO_Ue_nrDutNtkRb1rrzCg.S0Q7S4JLeT02AnHn5
 1vi5odfEcGPYGYLerOp7NyrzK4lRDLWjMKpgWjG0fBzalqJmJL7m6NTx.bfRV1i3cBMcfy8Y8zvj
 d6Qmf9wTl7khsjfwlLz3MEKVx38p9HruxQpSHgVIUHv0KwquFGh48bIjOaWxjmf6s1MeLRVR6pur
 lp_11gGy54szSIIMOr.YKEbwsvPwSnNKtbT90K5qPl9xrV.bazoPE8v64is1HjNgqz7vgyo5UYDs
 EBP.jA0zctXtPaMUB5FsjzS4Wuu41RVP5T9cT4cYT1kpfnvKkpa3LbPOe2ZoWSxHm76ILdmFLpaE
 VT0qPGohMXUjFngttoN9oseq65a1G38DWp2n2wpYKZvSGAXb9tGYQ6k5xvWNIL3Oib6PntVeGQtV
 0uHXFcGCgobJyEeBAbS3OJzCvmkG8xLp3u_MG4hrKzNru8MAYH9i7Mbjl5YTNNfJbovIKkrF5mJU
 V93FUyZAj7QlNA.SKctvp0ter6Rxn3bPVNWEGFyEMy7lEvU0N7dkVUsqADY3J1V3T2QKPX.G1E0a
 iNyg0mmzYZve2YGpBfUgVwx657FnsP1usIHGACNlI6NzReD0KgAFITjNuVZRHcdz6pg2QAEpsxN_
 DWQcduSVeAC41faF48GnPzoqMSOPwbe3YxRAY0J6epd3SDf3BUU5P0qa2.Plj5OJpmJmFqf7BoCv
 k9lXZY9JGKK9BEDlGwuBHX_Ajx3ewioaxy2pjyU3LGcQUaKDMBgBO2hq7TpxA1iupsrzXNR1RXtv
 lXGwQudr_SBtiX9z1fMiH3g1TCuS.3Sf4FADPh.9AcaqWoK66F9qoEwmWv5sMo__LSHjR_i.CXSF
 noTgWTxm3UUh4rwUlXzfNVM8jFkwx1QH5TIR7VW1kDquzfpo.vhqHeRLc_wmBkLB34XTRAExQHg5
 I98N8016m5YEgdkPf2ckoOH_xf3K0cmcwHRKBF52lpuAgNWqmm_39ty8Zc5gRCVkefH9jA53DjCA
 E2DD3EA7jvZxHE_hpewxhjaUexIirYG5V2wvXN_S5a0.9GhnW6gezTsl_aeh8bvCUXrCieuy2ohC
 qmy6DrDjT_GaQHhDR0YX682x88PPaVAOq6OURXPhdN5N5Lr.OXP4x2uQlB5zFLd2Rj2PEkg9Nas0
 lQRlIPvd7jv9rPYfRwRm1nDBcjafE_eLmxOnoYoDfR1L_Vc5KmyXwl9DwPgv7s1Oyvx16Zx8uIMq
 3rbkf9Hj9n8fkUPhkqE24ZrK8cfomaBAjYVV22PG2QZFzTr7G9fKExbfIzzcMSOKMdX1TsewdXVw
 NPWjiOVSbAyt7xGv0BCAEpWBwidk8HQsghoAkWTZqDGzjlsSSbJwGl9n1FO01PF9d2q6CeEKwl_4
 rTECRvpFtZcCLZzFK8pmRiHHuT4ptJNIu0KmWjf6QEx2Qm7P8U4QGFi5DuxuaIvbOzWgw64OX.9v
 7gpM1HuV3VyCsyAKQ961YzvYw0o8eRT1ifcAWpV2mWu_cD9p5OAkaJ1rIK1zmk9QUiXiGSpTYHN0
 vI2K3oxLa0cF6IEudH_dZwFZJuClGvk2m63XvxNMo5VmPAIPWburaiG3NWPQcovGFG9k-
X-Sonic-MF: <fhortner@yahoo.de>
X-Sonic-ID: 16f09d6c-0795-4889-a723-5da85de7c3d3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ir2.yahoo.com with HTTP; Thu, 13 Jun 2024 20:14:05 +0000
Received: by hermes--production-ir2-7b99fc9bb6-59h69 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6721293c68aa91051547e4090cd55186;
          Thu, 13 Jun 2024 19:43:37 +0000 (UTC)
Content-Type: multipart/mixed; boundary="------------B8gwyOIJ0CHKwuoyRbyBF0PX"
Message-ID: <bcac5925-fe2b-4570-83b6-182f4a301721@yahoo.de>
Date: Thu, 13 Jun 2024 21:43:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression, thermal: core: battery reading wrong after wake from
 S3 [Was: Bug Report according to thermal_core.c]
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <1051df4c-067f-455e-8c7f-9dc47dc8ed00@yahoo.de>
 <435867b5-029b-419f-bb7f-2d4902c62556@leemhuis.info>
 <a97f9f4d-17f1-44cf-a0f4-634fd38aba2a@yahoo.de>
 <CAJZ5v0jwvq6W0u7Zx4GzQxJOnrF4KvN1RHtqqDcaMvN6yp0hDg@mail.gmail.com>
 <312649b1-eea9-4346-af93-76a821e88eb7@yahoo.de>
 <CAJZ5v0jfvRWK0M3Xf=36e74cVQ9rN5T1WdZZVnuk1XmZ=xu==g@mail.gmail.com>
 <78549853-1763-40cf-9974-3fc737fad093@yahoo.de>
 <CAJZ5v0h5pQDaA-bEOmcz_TpE87kFqWLFLJC+=OLjg5ZtF3hxpQ@mail.gmail.com>
 <91d94429-fc7e-4828-914d-1a251ee1ba99@yahoo.de>
 <CAJZ5v0gPZHDfuK1FRdTAG8Eqjf0NWUQdf-_GCWsWf6dCBE=1dg@mail.gmail.com>
 <543787c3-db5b-4f63-b5e0-df508300db73@yahoo.de>
 <CAJZ5v0h7jDw3yX689nZdB+YeJbCk0vFoUgVb4Yi0cqDxjL5chQ@mail.gmail.com>
 <40ec1e53-2bc8-48aa-9909-fac9072adb57@yahoo.de>
 <CAJZ5v0jtjXfvr4GXukjyO9XsEO6K2Nfux3otpFPP4vWS_9_qEQ@mail.gmail.com>
 <CAJZ5v0hcX0JAMBA+EVZURDH1BTQ2zL-W_4BjSx0a=1oRaR90ug@mail.gmail.com>
 <CAJZ5v0jGGV=i8Swu=c8f9bwo--AckUfqZrt0zeqDWKBijG+Z3A@mail.gmail.com>
Content-Language: en-US
From: "fhortner@yahoo.de" <fhortner@yahoo.de>
In-Reply-To: <CAJZ5v0jGGV=i8Swu=c8f9bwo--AckUfqZrt0zeqDWKBijG+Z3A@mail.gmail.com>
X-Mailer: WebService/1.1.22407 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

This is a multi-part message in MIME format.
--------------B8gwyOIJ0CHKwuoyRbyBF0PX
Content-Type: multipart/alternative;
 boundary="------------5ZpLFfO1efKRbJpC0x2K4SPs"

--------------5ZpLFfO1efKRbJpC0x2K4SPs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 13.06.24 um 17:14 schrieb Rafael J. Wysocki:
> Let's see if the ACPI thermal zone is the real culprit.
>
> The attached patch only adds the delay for thermal zone 0 which is the
> ACPI thermal zone.  It also prints the ID and type for all of the
> resuming thermal zones.
>
> Please test it (removing all of the test changes/patches tried so far)
> and let me know what happens to the battery readings.
Patch

thermal-delay-resume.patch

does not work. Output according to dmesg.txt
> Attached is a slightly modified version of the last patch I sent.
> Please test it and let me know if it addresses the problem you are
> seeing.
>
> If it helps, I think we are done with this at least for now.
patch thermal-core-resume-prio.patch with .priority = -1 does work
> One more thing to try is the attached patch (independent of the
> previous one) to lower the priority of the thermal PM notifier to make
> it run always after the ACPI battery one.
>
> Please test this one too and let me know if it works for you.
patch thermal-core-resume-prio.patch

with .priority = INT_MIN does also work.

If you need any further tests, please don't hesitate to tell me so.

Thank you for your help!


--------------5ZpLFfO1efKRbJpC0x2K4SPs
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Am 13.06.24 um 17:14 schrieb Rafael J. Wysocki:<span
    style="white-space: pre-wrap">
</span><br>
    <blockquote type="cite">
      <pre class="moz-quote-pre" wrap="">Let's see if the ACPI thermal zone is the real culprit.

The attached patch only adds the delay for thermal zone 0 which is the
ACPI thermal zone.  It also prints the ID and type for all of the
resuming thermal zones.

Please test it (removing all of the test changes/patches tried so far)
and let me know what happens to the battery readings.</pre>
    </blockquote>
    Patch<br>
    <p
style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">thermal-delay-resume.patch</p>
    <span style="white-space: pre-wrap">does not work. Output according to dmesg.txt

<blockquote type="cite"><pre class="moz-quote-pre" wrap="">Attached is a slightly modified version of the last patch I sent.
Please test it and let me know if it addresses the problem you are
seeing.

If it helps, I think we are done with this at least for now.</pre>
</blockquote>patch thermal-core-resume-prio.patch
with .priority = -1 does work
<blockquote type="cite"><pre class="moz-quote-pre" wrap="">One more thing to try is the attached patch (independent of the
previous one) to lower the priority of the thermal PM notifier to make
it run always after the ACPI battery one.

Please test this one too and let me know if it works for you.
</pre></blockquote>patch </span><span style="white-space: pre-wrap">thermal-core-resume-prio.patch</span>
    <p
style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">with .priority = INT_MIN does also work.</p>
    <p
style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">
</p>
    <p
style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">If you need any further tests, please don't hesitate to tell me so.</p>
    <p
style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">
</p>
    <p
style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">Thank you for your help!
</p>
    <style type="text/css">p, li { white-space: pre-wrap; }hr { height: 1px; border-width: 0; }li.unchecked::marker { content: "\2610"; }li.checked::marker { content: "\2612"; }</style><br>
    <style type="text/css">p, li { white-space: pre-wrap; }hr { height: 1px; border-width: 0; }li.unchecked::marker { content: "\2610"; }li.checked::marker { content: "\2612"; }</style>
  </body>
</html>

--------------5ZpLFfO1efKRbJpC0x2K4SPs--
--------------B8gwyOIJ0CHKwuoyRbyBF0PX
Content-Type: text/plain; charset=UTF-8; name="dmesg.txt"
Content-Disposition: attachment; filename="dmesg.txt"
Content-Transfer-Encoding: base64

WyAgIDk2LjIxMjA0NV0gZTEwMDBlIDAwMDA6MDA6MWYuNiBlbnAwczMxZjY6IE5JQyBMaW5r
IGlzIERvd24KWyAgIDk2LjIzOTU5OV0gd2xwODJzMDogZGVhdXRoZW50aWNhdGluZyBmcm9t
IGU0OmY0OmM2OjBmOmJlOmFkIGJ5IGxvY2FsIGNob2ljZSAoUmVhc29uOiAzPURFQVVUSF9M
RUFWSU5HKQpbICAgOTYuNjc0NDcyXSBQTTogc3VzcGVuZCBlbnRyeSAoZGVlcCkKWyAgIDk2
LjY4NzQzMF0gRmlsZXN5c3RlbXMgc3luYzogMC4wMTIgc2Vjb25kcwpbICAgOTYuNzI5NTc3
XSBGcmVlemluZyB1c2VyIHNwYWNlIHByb2Nlc3NlcwpbICAgOTYuNzMwODc0XSBGcmVlemlu
ZyB1c2VyIHNwYWNlIHByb2Nlc3NlcyBjb21wbGV0ZWQgKGVsYXBzZWQgMC4wMDEgc2Vjb25k
cykKWyAgIDk2LjczMDg3N10gT09NIGtpbGxlciBkaXNhYmxlZC4KWyAgIDk2LjczMDg3OF0g
RnJlZXppbmcgcmVtYWluaW5nIGZyZWV6YWJsZSB0YXNrcwpbICAgOTYuNzMxODM2XSBGcmVl
emluZyByZW1haW5pbmcgZnJlZXphYmxlIHRhc2tzIGNvbXBsZXRlZCAoZWxhcHNlZCAwLjAw
MCBzZWNvbmRzKQpbICAgOTYuNzMxODc2XSBwcmludGs6IFN1c3BlbmRpbmcgY29uc29sZShz
KSAodXNlIG5vX2NvbnNvbGVfc3VzcGVuZCB0byBkZWJ1ZykKWyAgIDk2Ljg5Njg4M10gZTEw
MDBlOiBFRUUgVFggTFBJIFRJTUVSOiAwMDAwMDAxMQpbICAgOTcuODQ3OTgwXSBQTTogc3Vz
cGVuZCBkZXZpY2VzIHRvb2sgMS4xMTYgc2Vjb25kcwpbICAgOTcuODc5NjU2XSBBQ1BJOiBF
QzogaW50ZXJydXB0IGJsb2NrZWQKWyAgIDk3Ljk1OTA3M10gQUNQSTogUE06IFByZXBhcmlu
ZyB0byBlbnRlciBzeXN0ZW0gc2xlZXAgc3RhdGUgUzMKWyAgIDk3Ljk2NDk5OF0gQUNQSTog
RUM6IGV2ZW50IGJsb2NrZWQKWyAgIDk3Ljk2NTAwMV0gQUNQSTogRUM6IEVDIHN0b3BwZWQK
WyAgIDk3Ljk2NTAwM10gQUNQSTogUE06IFNhdmluZyBwbGF0Zm9ybSBOVlMgbWVtb3J5Clsg
ICA5Ny45NjUxNDNdIERpc2FibGluZyBub24tYm9vdCBDUFVzIC4uLgpbICAgOTcuOTY4MDA2
XSBzbXBib290OiBDUFUgMSBpcyBub3cgb2ZmbGluZQpbICAgOTcuOTczMTk4XSBzbXBib290
OiBDUFUgMiBpcyBub3cgb2ZmbGluZQpbICAgOTcuOTc3Mjg3XSBzbXBib290OiBDUFUgMyBp
cyBub3cgb2ZmbGluZQpbICAgOTcuOTgyNzA4XSBzbXBib290OiBDUFUgNCBpcyBub3cgb2Zm
bGluZQpbICAgOTcuOTg2NjY5XSBzbXBib290OiBDUFUgNSBpcyBub3cgb2ZmbGluZQpbICAg
OTcuOTkyMjYwXSBzbXBib290OiBDUFUgNiBpcyBub3cgb2ZmbGluZQpbICAgOTcuOTk1NzQ5
XSBzbXBib290OiBDUFUgNyBpcyBub3cgb2ZmbGluZQpbICAgOTguMDAwMjU1XSBzbXBib290
OiBDUFUgOCBpcyBub3cgb2ZmbGluZQpbICAgOTguMDAzOTY5XSBzbXBib290OiBDUFUgOSBp
cyBub3cgb2ZmbGluZQpbICAgOTguMDA4NDYwXSBzbXBib290OiBDUFUgMTAgaXMgbm93IG9m
ZmxpbmUKWyAgIDk4LjAxMTU4N10gc21wYm9vdDogQ1BVIDExIGlzIG5vdyBvZmZsaW5lClsg
ICA5OC4wMTUyNTZdIEFDUEk6IFBNOiBMb3ctbGV2ZWwgcmVzdW1lIGNvbXBsZXRlClsgICA5
OC4wMTUzMDJdIEFDUEk6IEVDOiBFQyBzdGFydGVkClsgICA5OC4wMTUzMDJdIEFDUEk6IFBN
OiBSZXN0b3JpbmcgcGxhdGZvcm0gTlZTIG1lbW9yeQpbICAgOTguMDE2MDcyXSBFbmFibGlu
ZyBub24tYm9vdCBDUFVzIC4uLgpbICAgOTguMDE2MTIzXSBzbXBib290OiBCb290aW5nIE5v
ZGUgMCBQcm9jZXNzb3IgMSBBUElDIDB4MgpbICAgOTguMDE2OTU5XSBDUFUxIGlzIHVwClsg
ICA5OC4wMTY5OTFdIHNtcGJvb3Q6IEJvb3RpbmcgTm9kZSAwIFByb2Nlc3NvciAyIEFQSUMg
MHg0ClsgICA5OC4wMTc3MzJdIENQVTIgaXMgdXAKWyAgIDk4LjAxNzc1OV0gc21wYm9vdDog
Qm9vdGluZyBOb2RlIDAgUHJvY2Vzc29yIDMgQVBJQyAweDYKWyAgIDk4LjAxODUxNl0gQ1BV
MyBpcyB1cApbICAgOTguMDE4NTQyXSBzbXBib290OiBCb290aW5nIE5vZGUgMCBQcm9jZXNz
b3IgNCBBUElDIDB4OApbICAgOTguMDE5MzMzXSBDUFU0IGlzIHVwClsgICA5OC4wMTkzNjRd
IHNtcGJvb3Q6IEJvb3RpbmcgTm9kZSAwIFByb2Nlc3NvciA1IEFQSUMgMHhhClsgICA5OC4w
MjAxNzhdIENQVTUgaXMgdXAKWyAgIDk4LjAyMDIwM10gc21wYm9vdDogQm9vdGluZyBOb2Rl
IDAgUHJvY2Vzc29yIDYgQVBJQyAweDEKWyAgIDk4LjAyMTE4MV0gQ1BVNiBpcyB1cApbICAg
OTguMDIxMjExXSBzbXBib290OiBCb290aW5nIE5vZGUgMCBQcm9jZXNzb3IgNyBBUElDIDB4
MwpbICAgOTguMDIyMDQ0XSBDUFU3IGlzIHVwClsgICA5OC4wMjIwNzBdIHNtcGJvb3Q6IEJv
b3RpbmcgTm9kZSAwIFByb2Nlc3NvciA4IEFQSUMgMHg1ClsgICA5OC4wMjI5MjFdIENQVTgg
aXMgdXAKWyAgIDk4LjAyMjk0OF0gc21wYm9vdDogQm9vdGluZyBOb2RlIDAgUHJvY2Vzc29y
IDkgQVBJQyAweDcKWyAgIDk4LjAyMzgyNV0gQ1BVOSBpcyB1cApbICAgOTguMDIzODUxXSBz
bXBib290OiBCb290aW5nIE5vZGUgMCBQcm9jZXNzb3IgMTAgQVBJQyAweDkKWyAgIDk4LjAy
NDc0N10gQ1BVMTAgaXMgdXAKWyAgIDk4LjAyNDc3Ml0gc21wYm9vdDogQm9vdGluZyBOb2Rl
IDAgUHJvY2Vzc29yIDExIEFQSUMgMHhiClsgICA5OC4wMjU2OTVdIENQVTExIGlzIHVwClsg
ICA5OC4wMzAzOTJdIEFDUEk6IFBNOiBXYWtpbmcgdXAgZnJvbSBzeXN0ZW0gc2xlZXAgc3Rh
dGUgUzMKWyAgIDk4LjEwNzU4Ml0gQUNQSTogRUM6IGludGVycnVwdCB1bmJsb2NrZWQKWyAg
IDk5LjM2NzgzMV0gQUNQSTogRUM6IGV2ZW50IHVuYmxvY2tlZApbICAgOTkuMzczOTA3XSBp
OTE1IDAwMDA6MDA6MDIuMDogW2RybV0gW0VOQ09ERVI6OTg6RERJIEEvUEhZIEFdIGlzIGRp
c2FibGVkL2luIERTSSBtb2RlIHdpdGggYW4gdW5nYXRlZCBEREkgY2xvY2ssIGdhdGUgaXQK
WyAgIDk5LjM4MzUyNF0gbnZtZSBudm1lMDogMTIvMC8wIGRlZmF1bHQvcmVhZC9wb2xsIHF1
ZXVlcwpbICAgOTkuMzg3NTI5XSBudm1lIG52bWUxOiBEMyBlbnRyeSBsYXRlbmN5IHNldCB0
byA4IHNlY29uZHMKWyAgIDk5LjQwNTg4OF0gbnZtZSBudm1lMTogMTIvMC8wIGRlZmF1bHQv
cmVhZC9wb2xsIHF1ZXVlcwpbICAgOTkuNjU4NTc1XSB1c2IgMS04OiByZXNldCBoaWdoLXNw
ZWVkIFVTQiBkZXZpY2UgbnVtYmVyIDMgdXNpbmcgeGhjaV9oY2QKWyAgIDk5Ljg0OTg5MF0g
UE06IHJlc3VtZSBkZXZpY2VzIHRvb2sgMC40ODIgc2Vjb25kcwpbICAgOTkuODUwNDYzXSBt
ZWlfaGRjcCAwMDAwOjAwOjE2LjAtYjYzOGFiN2UtOTRlMi00ZWEyLWE1NTItZDFjNTRiNjI3
ZjA0OiBib3VuZCAwMDAwOjAwOjAyLjAgKG9wcyBpOTE1X2hkY3Bfb3BzIFtpOTE1XSkKWyAg
IDk5Ljg1MTk2NF0gT09NIGtpbGxlciBlbmFibGVkLgpbICAgOTkuODUxOTY5XSBSZXN0YXJ0
aW5nIHRhc2tzIC4uLgpbICAgOTkuODUyMDc1XSBwY2lfYnVzIDAwMDA6MDY6IEFsbG9jYXRp
bmcgcmVzb3VyY2VzClsgICA5OS44NTIxMzBdIHBjaV9idXMgMDAwMDoyYzogQWxsb2NhdGlu
ZyByZXNvdXJjZXMKWyAgIDk5Ljg1MjIzN10gcGNpX2J1cyAwMDAwOjA2OiBBbGxvY2F0aW5n
IHJlc291cmNlcwpbICAgOTkuODUyMjY2XSBwY2lfYnVzIDAwMDA6MmM6IEFsbG9jYXRpbmcg
cmVzb3VyY2VzClsgICA5OS44NTIzNjRdIHVzYiAxLTk6IFVTQiBkaXNjb25uZWN0LCBkZXZp
Y2UgbnVtYmVyIDQKWyAgIDk5Ljg1NTQzNl0gZG9uZS4KWyAgIDk5Ljg1NTQ2MV0gcmFuZG9t
OiBjcm5nIHJlc2VlZGVkIG9uIHN5c3RlbSByZXN1bXB0aW9uClsgICA5OS44NTU1ODNdIHRo
ZXJtYWwgdGhlcm1hbF96b25lMDogW2FjcGl0el06IHRoZXJtYWxfem9uZV9kZXZpY2VfcmVz
dW1lClsgICA5OS44NTU1ODddIHRoZXJtYWwgdGhlcm1hbF96b25lMDogW2FjcGl0el06IFNs
ZWVwaW5nClsgICA5OS44NTU1OTZdIHRoZXJtYWwgdGhlcm1hbF96b25lMTogW0lOVDM0MDAg
VGhlcm1hbF06IHRoZXJtYWxfem9uZV9kZXZpY2VfcmVzdW1lClsgICA5OS44NTU1OTldIHRo
ZXJtYWwgdGhlcm1hbF96b25lMjogW1NFTjFdOiB0aGVybWFsX3pvbmVfZGV2aWNlX3Jlc3Vt
ZQpbICAgOTkuODU2MDcxXSB0aGVybWFsIHRoZXJtYWxfem9uZTM6IFtTRU4yXTogdGhlcm1h
bF96b25lX2RldmljZV9yZXN1bWUKWyAgIDk5Ljg1NjUzMl0gdGhlcm1hbCB0aGVybWFsX3pv
bmU0OiBbcGNoX2Nhbm5vbmxha2VdOiB0aGVybWFsX3pvbmVfZGV2aWNlX3Jlc3VtZQpbICAg
OTkuODU2NTQyXSB0aGVybWFsIHRoZXJtYWxfem9uZTU6IFtTRU4zXTogdGhlcm1hbF96b25l
X2RldmljZV9yZXN1bWUKWyAgIDk5Ljg1NjYzOF0gdGhlcm1hbCB0aGVybWFsX3pvbmU2OiBb
U0VOMF06IHRoZXJtYWxfem9uZV9kZXZpY2VfcmVzdW1lClsgICA5OS44NTY3MjldIHRoZXJt
YWwgdGhlcm1hbF96b25lNzogW0IwRDRdOiB0aGVybWFsX3pvbmVfZGV2aWNlX3Jlc3VtZQpb
ICAgOTkuODU2ODQ1XSB0aGVybWFsIHRoZXJtYWxfem9uZTg6IFtTRU40XTogdGhlcm1hbF96
b25lX2RldmljZV9yZXN1bWUKWyAgIDk5Ljg1NjkzOV0gdGhlcm1hbCB0aGVybWFsX3pvbmU5
OiBbU0VONV06IHRoZXJtYWxfem9uZV9kZXZpY2VfcmVzdW1lClsgICA5OS44NTcwNThdIHRo
ZXJtYWwgdGhlcm1hbF96b25lMTA6IFtTRU42XTogdGhlcm1hbF96b25lX2RldmljZV9yZXN1
bWUKWyAgIDk5Ljg1NzYzM10gdGhlcm1hbCB0aGVybWFsX3pvbmUxMTogW1NFTjddOiB0aGVy
bWFsX3pvbmVfZGV2aWNlX3Jlc3VtZQpbICAgOTkuODYxNTE5XSB0aGVybWFsIHRoZXJtYWxf
em9uZTEyOiBbU0VOOF06IHRoZXJtYWxfem9uZV9kZXZpY2VfcmVzdW1lClsgICA5OS44NjIw
NjZdIHRoZXJtYWwgdGhlcm1hbF96b25lMTM6IFtTRU45XTogdGhlcm1hbF96b25lX2Rldmlj
ZV9yZXN1bWUKWyAgIDk5Ljg2MjE4MV0gdGhlcm1hbCB0aGVybWFsX3pvbmUxNDogW1NFTkFd
OiB0aGVybWFsX3pvbmVfZGV2aWNlX3Jlc3VtZQpbICAgOTkuODY0NjcxXSB0aGVybWFsIHRo
ZXJtYWxfem9uZTE1OiBbU0VOQl06IHRoZXJtYWxfem9uZV9kZXZpY2VfcmVzdW1lClsgICA5
OS44Njc1NzVdIHRoZXJtYWwgdGhlcm1hbF96b25lMTY6IFtTRU5DXTogdGhlcm1hbF96b25l
X2RldmljZV9yZXN1bWUKWyAgIDk5Ljg2NzgwNF0gdGhlcm1hbCB0aGVybWFsX3pvbmUxNzog
W1NFTkRdOiB0aGVybWFsX3pvbmVfZGV2aWNlX3Jlc3VtZQpbICAgOTkuODcyMzAxXSB0aGVy
bWFsIHRoZXJtYWxfem9uZTE4OiBbeDg2X3BrZ190ZW1wXTogdGhlcm1hbF96b25lX2Rldmlj
ZV9yZXN1bWUKWyAgIDk5Ljg3MjY2M10gdGhlcm1hbCB0aGVybWFsX3pvbmUxOTogW2l3bHdp
ZmlfMV06IHRoZXJtYWxfem9uZV9kZXZpY2VfcmVzdW1lClsgICA5OS45MjkyMTJdIHRoaW5r
cGFkX2FjcGk6IGJhdHRlcnkgMSByZWdpc3RlcmVkIChzdGFydCAwLCBzdG9wIDgwLCBiZWhh
dmlvdXJzOiAweDcpClsgICA5OS45NTQ1MDBdIFBNOiBzdXNwZW5kIGV4aXQKWyAgIDk5Ljk3
MDExNl0gdXNiIDEtOTogbmV3IGZ1bGwtc3BlZWQgVVNCIGRldmljZSBudW1iZXIgNiB1c2lu
ZyB4aGNpX2hjZApbICAxMDAuMDk5NDE4XSB1c2IgMS05OiBOZXcgVVNCIGRldmljZSBmb3Vu
ZCwgaWRWZW5kb3I9MDZjYiwgaWRQcm9kdWN0PTAwYmQsIGJjZERldmljZT0gMC4wMApbICAx
MDAuMDk5NDIyXSB1c2IgMS05OiBOZXcgVVNCIGRldmljZSBzdHJpbmdzOiBNZnI9MCwgUHJv
ZHVjdD0wLCBTZXJpYWxOdW1iZXI9MQpbICAxMDAuMDk5NDI0XSB1c2IgMS05OiBTZXJpYWxO
dW1iZXI6IDY3Yjc1NDZhZDc0NQpbICAxMDQuMDQ0MTg2XSB3bHA4MnMwOiBhdXRoZW50aWNh
dGUgd2l0aCBlNDpmNDpjNjowZjpiZTphZCAobG9jYWwgYWRkcmVzcz1mNjphNTphMDplNDo2
NjoxNikKWyAgMTA0LjA0NjUwM10gd2xwODJzMDogc2VuZCBhdXRoIHRvIGU0OmY0OmM2OjBm
OmJlOmFkICh0cnkgMS8zKQpbICAxMDQuMDc3NDYyXSB3bHA4MnMwOiBhdXRoZW50aWNhdGVk
ClsgIDEwNC4wNzgxODRdIHdscDgyczA6IGFzc29jaWF0ZSB3aXRoIGU0OmY0OmM2OjBmOmJl
OmFkICh0cnkgMS8zKQpbICAxMDQuMDg0OTI0XSB3bHA4MnMwOiBSWCBBc3NvY1Jlc3AgZnJv
bSBlNDpmNDpjNjowZjpiZTphZCAoY2FwYWI9MHgxNDExIHN0YXR1cz0wIGFpZD01KQpbICAx
MDQuMTMxNjU5XSB3bHA4MnMwOiBhc3NvY2lhdGVkCgo=

--------------B8gwyOIJ0CHKwuoyRbyBF0PX--

