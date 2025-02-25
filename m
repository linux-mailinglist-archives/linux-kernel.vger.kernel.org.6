Return-Path: <linux-kernel+bounces-531884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCF6A44661
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C19F7865615
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE7F17E015;
	Tue, 25 Feb 2025 16:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=diehl.com header.i=@diehl.com header.b="dva6NsuN"
Received: from enterprise01.smtp.diehl.com (enterprise01.smtp.diehl.com [193.201.238.219])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3496D12F5A5
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.201.238.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501253; cv=none; b=tuv1A8mKZlO9Pkr3GeGVngSwVZfvKeYHTyiwqOCkYjCiWW8WhTY/V/1EkbDgN2C/lnJlrMt8y0JDAQ2U2E18WH16S9mqBczRSL4zCKIpYJTyy3N/i6NIFZheUmW4u6PwZ7V4P3Xl2JMpZA+W6gK7EOKyVTT9AJob6JwLeNomMwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501253; c=relaxed/simple;
	bh=50sXLHawH3rGetdlxG+bUe2WvOqzC4hYfiOT/x1E63I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hn50Jg/+8ek8eimq42XjVembp4K1OYgvuis7QvPSXCGD4S7nImXaCZTL2cxkM4RfRfGXSzO6xjDnWxZYymKHgLvK608rowU4hpNmFweu9/ezQ3EuXIGmPr1xwnJ9COH6loPhQhCRUQwQ385mLdWuQ3uwcs7qAvoRVs8CvBw81fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=diehl.com; spf=pass smtp.mailfrom=diehl.com; dkim=pass (2048-bit key) header.d=diehl.com header.i=@diehl.com header.b=dva6NsuN; arc=none smtp.client-ip=193.201.238.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=diehl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diehl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=diehl.com; i=@diehl.com; q=dns/txt; s=default;
  t=1740501250; x=1772037250;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=ZTFzxPdx9GClcEdV4vhr5m8ywOOrRO6fRHjjSTgaRJ8=;
  b=dva6NsuNp58DfJC8F1cG+uQ59nKhckz9YSbVW4RSCYMwwG7GZ+HBgqql
   8e0bofeS1vL2d8VSuaPKayZxOxew7JVe/wxOKMPiGYtKi4VKfFn9weEW7
   ViZjvImjSMYIy6QBVE4bfPPGazDDAWc6heTmy0Rt9a6AeMe293bWE34px
   Zz60xx7nMG/6kpUOnr2ewtZgiBhYWWksDzfvR/0SzW8ReU/QBeaNm04zO
   M3O/7aNvwQzLBULpgOzaa5c+edIJNMZlMezw6/TinKTzao6AseAiBlAcE
   GLN8K/yW46rEJBDwiIyRoUqV7k8mJoMEWI0z/upKgpvKahafNOIADu3y0
   Q==;
X-CSE-ConnectionGUID: /iqEv2HRRJaJDC7K1GI1yw==
X-CSE-MsgGUID: Dz4gHaQZR4ypNn6Ta5JuVQ==
X-ThreatScanner-Verdict: Negative
IronPort-Data: A9a23:lVyEk6kTbSYMC2Nkdh8LPAro5gyvIURdPkR7XQ2eYbSJt16W5kVWj
 iJDADrXfqbVPH29ZpktO86x6Alf7siEipMhHTLYn1l2SnNPpIzdWs/xwizYZn7DJcTPRxhrs
 p0QY9eRd5luQiOG+RryaeO/9nAsjfrVS+X2UeSUN3AhTFdqQS56gxw9kLMwj9Jj0Im0CF6E6
 Lsez+XWIEeh2jV9LmMT7eWbqxh047HpuTwet0Ajf/0jUHr2zhH5W7pBffrhR5eBfqFUAvKiF
 aGExbCwuHjG/gw2EdKqlPDwcgoDQ6SXZ1aH1SNdA/nn3kdPrGluj/sycasWMxcS1z+FwIp9x
 o0c78y8ET1qZickUModTwVAQWY5OqZd4PncPnmkqteSwEuAeHur2PRhCgYxNpZd8+98CmpD+
 aFddm4APlXf37znheOxE+MpiMh5fcDhY9gStHxrlSvkZcrKOqsvNZgmn/cDmm9Yu+hOAerGN
 Y1eYDtmKg/fYgZUIVYYDtQ1nKChh2O6LzQHpgvK9fpyuTbZkUktgLXmddOIJoPPTpxekh6Sq
 DuZ9D/1WixyCDDk8tbzz57WrrSJxUvGcIIOCKXqsblhmlnV3XMSEwYNVFS95/K5zUWyQ5cEJ
 kFJpyQi8e1vpRf7C4WkUhD98CSItFtHAYALGuY35lyGkPGM3m6l6hM/okh8hKYO74luLQEC1
 kOVh4GuQjd1tPuOVnOG7ayVojX0MihSJmMaICJVEgVdvNK/5Yxt1U6KEt1uG+vlg4f8XGmsy
 WrSpXc33O0Y0JY2v5lXhmsr9Q9A3LCSCFZd2zjqY46F0u9YTN70OdKhtVaA5PoYINzBFgPb5
 iYOx5DPvL1SVcvUmCfdHLxdTbqk2a2IYWbW6bJN8zvN1BzwoSL5LdAIiN1aDB00WirRUWaxO
 Cc/gSsIutkLeiPsNfIrC26II5xC5bD6Etj4XezjYNNLY5xgHCeK5ygGiXS4hggBq2By1/hkU
 XunWZz0VytCU/46lGDeq9o1itfH+AhvnAs/erirl3xL4ZLGDFaJRLEMNke5b+xRxMusvAXP/
 t9DANCBwhNZXfeWSnG/HVk7dA1iwdATXPgamuQPHgKxClMO9FIJUpc99Ygcl7lNxMy5oAtqE
 kaVASe0wHKn7ZHOxJ7jhnpLMNsDVr4nxZ430LBF0f9FFBHPbK72hJrzeafbcpFg9fVO06RUd
 cMncuesKatsExvmoiUCOMyVQIxKLHxHhCqCOjiubydnJdhrQBbRvNPlcwvrsiIJC0Jbt+Nn+
 /vwjEWCEdxaHF4K4MX+MZpDy3u9sH4cg6R1RFfFON1afknE/IlnKyi3hfgySy0JAUyammfAi
 lvHUH/0o8HhsdM60NDwt5rYvp+PFbVCFxd4AlfiuOPe2S7yuzDLLZV7eOmJejXQSH/10KikY
 +hYyffxdvYAmT5it4t6DqYuzq8k4dbrj6FVwx4iH3jRaVmvTLR6LRG7MdJn7/ULluUf4FvwA
 xnVkjVHBYi01AreOAZ5DGIYgi6rjKl8duX6hRjtHHjH2Q==
IronPort-HdrOrdr: A9a23:nGsIB6CPC03rcWHlHekT55DYdb4zR+YMi2TDtnoBMyC9F/byqy
 nApoV86faZskdyZJhCo6HmBEDjewKkyXcd2+B4AV7FZniDhILCFvAA0WKN+UyEJwTz7fVazr
 0lbq4WMrfN5RoWt6fHyQy5Cctl3N6c7Kuzj/zfxHsFd21XQqRh9Ro8FgGADkZtThJHDpZ8DZ
 yH+6N8yAaIYngLct+9QmQCNtKvm/Tb0Jj9aVoNARo/7QGPii6zgYSbLzGImg0VVHdKybcmtW
 XClwT44cyYwoqG4w6ZzWXVq5BfmN6kytYrPr31tuEFbi/njUKwbJlhMoftgAwI
X-Talos-CUID: =?us-ascii?q?9a23=3AWLCv9miICrQgIRRms+KK8CFRRTJuNXzE4WmKA3W?=
 =?us-ascii?q?CK29LZJbKaga/2fp1jJ87?=
X-Talos-MUID: 9a23:Q0B00gR3SntpyYd0RXTAlm1tFM5R0Z7yGVgrl8s6spSmKBJJbmI=
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="p7s'346?scan'346,208,346";a="114425599"
From: Denis OSTERLAND-HEIM <denis.osterland@diehl.com>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Re: [PATCH] pps: add epoll support
Date: Tue, 25 Feb 2025 17:34:04 +0100 (CET)
Message-ID: <11965b8b6101487996df902d35ba2ea3@diehl.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----24E62C479B8321CC29114B2B62BA6879"

This is an S/MIME signed message

------24E62C479B8321CC29114B2B62BA6879
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi,

> -----Original Message-----
> From: Rodolfo Giometti <giometti@enneenne.com> 
> Sent: Tuesday, February 25, 2025 3:24 PM
> To: Denis OSTERLAND-HEIM <denis.osterland@diehl.com>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] pps: add epoll support
>  
[snip]
> 
> > If I start multiple user space programs data races are visible.
> > 
> > ```
> > # for i in 0 1 2 3 4 5 6; do PpsPollTest /dev/pps1 > log$i & done
> > # sleep 6
> > # tail log*
> > ==> log0 <==
> > timeout
> > assert: 196
> > time: 1520599554.276752928
> > assert: 197
> > time: 1520599555.300692704
> 
> This is the same behavior we have when working with a serial port: if more than 
> one process gets access to it, data is stolen.
Okay, then lets choose your suggestion.

> 
> >>From my point of view it would be great to fix this bug without such an limitation.
> 
> I disagree, it is not a limitation! It is like a normal char device work.
> 
> What we have to test now is if your initial goal has been addressed! That is, in 
> an application that has more to do than just dealing with one PPS device, we can 
> use poll()/select() in order to avoid using threads.
I will do the final test.
I expect that it works with your patch.

Shall I prepare the patch?
Shall I add you as Co-author?
Or do you want to send your patch with me in reported-by and tested-by?

Fixes: eae9d2ba0cfc ("LinuxPPS: core support")?

CC stable?

Regards, Denis

> 
> Ciao,
> 
> Rodolfo
> 
> -- 
> GNU/Linux Solutions                  e-mail: giometti@enneenne.com
> Linux Device Driver                          giometti@linux.it
> Embedded Systems                     phone:  +39 349 2432127
> UNIX programming
>

------24E62C479B8321CC29114B2B62BA6879
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIXkgYJKoZIhvcNAQcCoIIXgzCCF38CAQExDzANBglghkgBZQMEAgEFADALBgkq
hkiG9w0BBwGgghPaMIIGpTCCBI2gAwIBAgIUPseeE9qJ+oSdbny5LvEHTpzUCAIw
DQYJKoZIhvcNAQELBQAwUzELMAkGA1UEBhMCQ0gxFTATBgNVBAoTDFN3aXNzU2ln
biBBRzEtMCsGA1UEAxMkU3dpc3NTaWduIFJTQSBTTUlNRSBSb290IENBIDIwMjIg
LSAxMB4XDTI0MDUyODA4NDExMFoXDTM2MDUyODA4NDExMFowUjELMAkGA1UEBhMC
Q0gxFTATBgNVBAoTDFN3aXNzU2lnbiBBRzEsMCoGA1UEAwwjU3dpc3NTaWduIFJT
QSBTTUlNRSBNViBJQ0EgMjAyNCAtIDEwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAw
ggIKAoICAQC6Dz+IfbUsaCl0cWcbnNS1BIaKrdka8ev1Kc1G6OCYH4PMtkZmC6Zo
nnh/Dl5bOuiH+pMq1fj4BSEkRYTuOGtsWelcf6UNA11KL//zh1enaaNayqqRaCSE
JTZH+JFb0UJWwO+qGVb1RfHnPXYrI6n8w1chCxL9AibzvsDPR6I37iUwiNo4p6Uo
aPNAmIncpDIGgTGodkOjjPPbGwYjg58eINT63rqMQASJxUnPPIa0gZRix0NY7A6U
z8Iv98RbbQy7ZEDvHdLFeVmzl/5TXKbQExfnEpyOjjifWoJ+FeKkEj4O9Ohd/2fg
HQ6Y+DYwLFbHZPTmDvHQoOSS//V2NBkdnGTsfIcziIH1hypFxR/hqexJ+Da7Z7uN
jBh2ligdXNHDGMeq640X2WVx0sfSZljxbeknrr3KFfzqfealPps1UI68Q+1iBLl/
Ep8aZeRmzwCK+ibAPQpKfbxsjd8cBe8FcXaOWU4DjP6YmYy0xMC4vHXr3ZgrHqL9
8D56InfiYbrBMZp1UKDSzlz/rjXWRmrXnsY5gFU705KWrJu2guSYCrc4InG3Pj+E
mPmE6Eosikk2wg90nYFxJDM/9dPJnyIw6IdkV6qdrv9h7VKrpLrl22qETWC4/Xfi
JU7YsY6HFKnpAElKu8t6rUnU5GcwgWjcB+zBfQD1Kt59jlLob2PcDwIDAQABo4IB
cDCCAWwwXAYIKwYBBQUHAQEEUDBOMEwGCCsGAQUFBzAChkBodHRwOi8vYWlhLnN3
aXNzc2lnbi5jaC9haXItNGE3ZjE3ODgtMjZiNS00OGVjLWE1NDctYzFjZDBiZjE3
YzNkMBIGA1UdEwEB/wQIMAYBAf8CAQAwQAYDVR0gBDkwNzAJBgdngQwBBQEBMAkG
B2eBDAEFAQIwCQYHZ4EMAQUBAzAIBgYEAI96AQMwCgYIYIV0AVkCAQswUQYDVR0f
BEowSDBGoESgQoZAaHR0cDovL2NybC5zd2lzc3NpZ24uY2gvY2RwLTNlZTU1ZmQ0
LTU5MzgtNDFlZS04MmRiLTMyMjNhY2VmNWMyMzATBgNVHSUEDDAKBggrBgEFBQcD
BDAOBgNVHQ8BAf8EBAMCAQYwHQYDVR0OBBYEFL+0FkGip5/XTYUBCqFcvtvF0uWU
MB8GA1UdIwQYMBaAFMwurYmMg+NAoyVppeqSfdI3OsfGMA0GCSqGSIb3DQEBCwUA
A4ICAQBGpYYvkjNsVP7geKv1jY+KtUNmyx8vlCoOo8tZ5Cc76175ocrVs50lZit+
nHWXe9Lqnuu1fMo+0jEpgC9dqy6cCxAEgNH5kwbFxXFPHOB/kxMdWubZ1xwcOP2l
B4ns7Ps9RUGOIcpfuAp2KLYwavjO58g+6FVGhY3R6VAhmNRO6bHhz0wQRwKAZNo2
GMwYMmxW63mI4bz1JYvCSeZtqZhyxTMDOwEUDdYkxrz3g5gQUoMnrrak1kGRdpFB
Eefok8aK8ngfwwIgefNBF9BnzoRhlIVrm3//zboqShj4IXqMEUgScWNz2WTjqKaU
uhLk+MyynNqrbp6EeFZ0BPgA7AfVWevRf4OOCxrH6S4FJtMKmuczZ0wqebTML7Ax
VtkSqeT7/NBDTh8D8j+HVvHwMi4s+cunS3DMdXE9yzuixlcjfsD/2aS17quE23Qf
nNESdDy5TUs5Wlm1ClYQ+L1cZGwSwAyqMs9RNg57+gtJu5Uhjn+FGVLndGQgzIor
/+ynq6KEzN2rhGzLpPHpwUdDoX+YnNlrZpdx/IOgknaSGznJ/mQzA6PjffNS0Fx3
pqd41QO0uX5HWDFEa/gG0Uo7faymzXFcFb9AKCrKR5Xrd0W+f2U2z/hvC843i9q2
8CoJ7xRMt0wF8Sun9U278iaLgPNNyCNDJorz9NmIomvT45XK7jCCBe4wggPWoAMC
AQICEACzBRGxFrSgVlEdfGgfh30wDQYJKoZIhvcNAQELBQAwRTELMAkGA1UEBhMC
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
bIRutw/gmkT7b9aP2Wmm3PtjnasrM+RdDlfGKqHkeCR2zkeRDDP2BE2LKc9CFGJB
PysNjZSVlp5/fxb8atVwVk+TphIHuHjeP+3z/ykiDr64Yq2yjyNlXrWVg2yxju4M
LdX8wfkCx/uAIlYLACinK+/RATAYz1f3Y+kJ81CQbfFpnFZBRhxjDfj65zxMrWsJ
ydnoGsZUHt7zXFOQvw7JrFL/X5s7hBv/3uy107vBwcA8Hyw9m3DH/ChBMen6gyy+
CkNXalP9AOZ66CoEgIE8PfsrzfBVjVxQq2+iQLNlJ8a1r6URPNd5h1YZILBy6yTK
8tUs5MbM2CjbXAylEC1P02GFKhh/aN0gW5RTRk3vpA64KPQ/ckvUTmHVWONUE9cj
iE1/MVDuc+tMfQus2HBQ0LH+EKaVZmsA1OEKujelRFleMEpBBWS0fQ+zT2Y4bfPZ
RB5iQLGLf9hSacG+ib5cid44OL6s9kjzE5+Yy70LNcoHwIaQzqoc6t7sFNVDecMc
tTbrs+raTu/cOMSc45aEDKXjhYw46cyuLwnY9DauweK3K89jUrCNqNqPwQke6QID
AQABo4ICCzCCAgcwgbIGCCsGAQUFBwEBBIGlMIGiMEwGCCsGAQUFBzAChkBodHRw
Oi8vYWlhLnN3aXNzc2lnbi5jaC9haXItMjZhNzFjMDktNDdlYi00NTVhLTliMjgt
NGJkNzJkZjA5MjhkMFIGCCsGAQUFBzABhkZodHRwOi8vb2NzcC5zd2lzc3NpZ24u
Y2gvc2lnbi9vY3MtYWFjY2NlZDUtNjZlOC00MDY5LTliMWItZmQyOWFiNzNlZmVj
MHIGA1UdIARrMGkwCQYHZ4EMAQUBATAIBgYEAI96AQMwUgYIYIV0AVkCAQswRjBE
BggrBgEFBQcCARY4aHR0cHM6Ly9yZXBvc2l0b3J5LnN3aXNzc2lnbi5jb20vU3dp
c3NTaWduX0NQU19TTUlNRS5wZGYwUQYDVR0fBEowSDBGoESgQoZAaHR0cDovL2Ny
bC5zd2lzc3NpZ24uY2gvY2RwLWU5N2YwN2M0LWU2MzQtNGNlYy04ZTJhLTA0YjIw
YTdhMzBjNTATBgNVHSUEDDAKBggrBgEFBQcDBDAOBgNVHQ8BAf8EBAMCBaAwJAYD
VR0RBB0wG4EZZGVuaXMub3N0ZXJsYW5kQGRpZWhsLmNvbTAdBgNVHQ4EFgQUcDNC
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

------24E62C479B8321CC29114B2B62BA6879--


