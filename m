Return-Path: <linux-kernel+bounces-294322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E256E958C3C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0777283519
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC0818CC1D;
	Tue, 20 Aug 2024 16:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="e/BZaEaf"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5EB4409
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171623; cv=none; b=Tx6hBd3PIw1sO0hMvI38UywVC05e70IWxSkOzYCqquWvz/oGIyFJvlc6K7Vmg2hqsprmOGkxenBIcQ0/LZ/OKjh5UHA9Osl/xRyC2nmSmvvNoXYuGB06NVPkt6Crhle52QhKYci9Q6K3wvzYfaQXcYx4G4lS5SE1Yra831irlEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171623; c=relaxed/simple;
	bh=8IUmNoZ2LJs/D02xDzhAIKyPjOG9w7KqiGiDPMEZnb0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XnZiGNBAvf4Yq/DQcpQFRn876BdhOB3TtcZrLWA+CNGbSRlf82Qdsif+3xaWxpnOkzzCygsDcUeEZDi0X7xZPuDT39M4kEvT4Hov/de9c6JZH2HjWxNcim+QTnKDZNUI6G/wYaa1M1mUpe5hNPvPTZKZSaXyecGQVahX29PRqNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=e/BZaEaf; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-530ad984f2dso953043e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1724171620; x=1724776420; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=biPyWwHKsPSI9hwI1NGCkM/td/JJyPTqnLUN9w0DGw0=;
        b=e/BZaEafvmEuRz4bgLthW+pm5Bkkfnk2ekujPQCNsDr0RSHgygBQpMVf4WJlmraQco
         nCIh9JkWIoEqCltzWne6tJxEmddGbTyelV8MTjQr6ZkgzAt9NqnEBi/BIgREoCE8srQ/
         C4zBwcp4pFNLTHe0FbqkQJzWi0rcNgGhTh4kwqScgUd8Kbb5f17q3tPlSDuTgGp/qXBh
         m0CWuxav/4nP6Gg2+nuha0i9eJ2Jt+fya6pYUjzM8vGxO8ZFmwUK7YnkRQQqprwdCqlU
         VDAnrDReBwrn0s1Q5w2CZK4nTKgeSHy4zz8ihIx+jhYdZNvvtBINrbfLbjyyCpp6V/Hf
         p1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724171620; x=1724776420;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=biPyWwHKsPSI9hwI1NGCkM/td/JJyPTqnLUN9w0DGw0=;
        b=TYywIdOKFAVfvLh+BEi0iagw0zbgaVnEBL2hiHSayraxPBCHJVgkhqZreyJZnJ9TfJ
         OjJXvfkVbJzCvf+/+/qX579Lrv5lbMlTj/mjetFP0wVQVVynuJ0rSPoJnhTZWDXGd69O
         lv8w9TMF3WdqdVnthsgoE0CU7PlLxRL+44GljprhgmTgx4FOCf7HoA0NSmOJCUY9AtdN
         wcgUyiIjBBjh5mA/wCKbBqdG4uXnt/IFc+OIyQG3/jO1RPEuBEnooA7dGAp/dxNyJJCf
         8JEVTDcP4+YU+oqiTpgNDynXMyf0shes9w4JDNTEg7XOe/TMT32qOy0psWR+HiRgWVzm
         agGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvAgZ3vYXVZFOsas9F1iHEBmRD+l8DjrLc4P2VsBtiEU90u4ovMAsbc6W8nZnJGa7P/1fK8RnD6Ym/QI8Ja2R2wlt+7vBYkQRQLrqB
X-Gm-Message-State: AOJu0YwP6Y/PGZFrPBsAXe1chbiQXNW2q2uidyDxxYr5nPSa4erS4EJy
	t6pG16gH0LG7YKu89Tztg34QWMU05nVN3xM4vMIjU+IxImEiG20AtNlIV83QXPE=
X-Google-Smtp-Source: AGHT+IFJ0EkS4Si8mnRKbGimFnHHXb9uxbbTNcEVpKkFeoNxOaYbItrqrNcNmDbkUzRLo8NcVRHEUw==
X-Received: by 2002:a05:6512:401c:b0:52c:ce28:82bf with SMTP id 2adb3069b0e04-5331c6d4bcfmr6106461e87.5.1724171619972;
        Tue, 20 Aug 2024 09:33:39 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:1050:bb01:8164:778c:a10:dcfc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c65e7sm781546266b.20.2024.08.20.09.33.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2024 09:33:39 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH] ksmbd: Replace one-element arrays with flexible-array
 members
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <d7a30cff-e08f-453e-84f2-4584031e3d29@talpey.com>
Date: Tue, 20 Aug 2024 18:33:28 +0200
Cc: Namjae Jeon <linkinjeon@kernel.org>,
 sfrench@samba.org,
 senozhatsky@chromium.org,
 linux-cifs@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <05A23230-C800-4693-AB69-273A0B10C822@toblux.com>
References: <20240818162136.268325-2-thorsten.blum@toblux.com>
 <CAKYAXd-pm01ietA1+Z4J8tDcLM6fUkAwQ69j9XZs9uhrBbdDQQ@mail.gmail.com>
 <d7a30cff-e08f-453e-84f2-4584031e3d29@talpey.com>
To: Tom Talpey <tom@talpey.com>
X-Mailer: Apple Mail (2.3776.700.51)

On 20. Aug 2024, at 16:52, Tom Talpey <tom@talpey.com> wrote:
> On 8/20/2024 10:11 AM, Namjae Jeon wrote:
>> On Mon, Aug 19, 2024 at 1:22=E2=80=AFAM Thorsten Blum =
<thorsten.blum@toblux.com> wrote:
>>>=20
>>> Replace the deprecated one-element arrays with flexible-array =
members
>>> in the structs copychunk_ioctl_req and smb2_ea_info_req.
>>>=20
>>> There are no binary differences after this conversion.
>>>=20
>>> Link: https://github.com/KSPP/linux/issues/79
>>> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
>>> ---
>>>  fs/smb/server/smb2pdu.c | 4 ++--
>>>  fs/smb/server/smb2pdu.h | 4 ++--
>>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>>=20
>>> diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
>>> index 2df1354288e6..83667cb78fa6 100644
>>> --- a/fs/smb/server/smb2pdu.c
>>> +++ b/fs/smb/server/smb2pdu.c
>>> @@ -4580,7 +4580,7 @@ static int smb2_get_ea(struct ksmbd_work =
*work, struct ksmbd_file *fp,
>>>         /* single EA entry is requested with given user.* name */
>>>         if (req->InputBufferLength) {
>>>                 if (le32_to_cpu(req->InputBufferLength) <
>>> -                   sizeof(struct smb2_ea_info_req))
>>> +                   sizeof(struct smb2_ea_info_req) + 1)
>> We can use <=3D instead of +1.
>=20
> This is better, but maybe this test was actually not right in
> the first place.
>=20
> I think a strict "<" is correct here, because the ea name
> field is a counted array of length EaNameLength. So, it's
> a layering issue to fail with EINVAL this early in the
> processing. All that should be checked up front is
> that a complete smb2_ea_info_req header is present.

Just to clarify before I submit a v2: Is a strict "<" and without "+1"=20=

correct?

>>>                         return -EINVAL;
>>>=20
>>>                 ea_req =3D (struct smb2_ea_info_req *)((char *)req +
>>> @@ -8083,7 +8083,7 @@ int smb2_ioctl(struct ksmbd_work *work)
>>>                         goto out;
>>>                 }
>>>=20
>>> -               if (in_buf_len < sizeof(struct copychunk_ioctl_req)) =
{
>>> +               if (in_buf_len < sizeof(struct copychunk_ioctl_req) =
+ 1) {
>> Ditto.
>=20
> And ditto.

Same here, strict "<" and without "+ 1"? Or just a refactor to "<=3D"=20
without changing the condition?

Thanks,
Thorsten=

