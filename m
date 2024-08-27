Return-Path: <linux-kernel+bounces-303353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87188960B1B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146BF1F21182
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760CC1BD011;
	Tue, 27 Aug 2024 12:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="G1giUSWT"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2189B1BAED5
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724763110; cv=none; b=SGYawthjJ0HGAQZ/FK9zzqumGWe3CYSQwqzU2/BY4uzFCZ2bOmjirRPBl7cxdC0abKMstThgmTCTH29kT/FN+5qPbzO8aNdht0AV8V3sR9odYyuK623NaTJE+Qszp0Owu17wYMDGhVsI+ydnzFykjSJSyoGYmaipxijQHtpHSQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724763110; c=relaxed/simple;
	bh=pIZ/9NAl6sknpOSyqXJf5pTwFKUE753sOw+rcvyB6VU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=G/TWsynNUnfF7u6cdciecicQ79sVPadXX97Mk1hNI5Hh6TdQM5Qu1Muj8NSZM9/tLP/nAghlYSunXglsoUQXk51ezAiDcU3bRZwhxXUnWw+dvLoRhZv+IKNu+CZHrNbHZ8oT8D6yE+iM76NwB8cUL8G2oKlsCNm+cq37ikImafo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=G1giUSWT; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5bec50de77fso753438a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 05:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1724763107; x=1725367907; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIZ/9NAl6sknpOSyqXJf5pTwFKUE753sOw+rcvyB6VU=;
        b=G1giUSWTLUShSyezgmAP5WTfaGBx/tLINNFnvAOp9ueN22h2VimoNhyMaip/SfsEft
         zze4dh1+xorUmC20Z7ipZm9EKBL4nP6eOMVU6Y1ZYfl35qZGhxvf5U5XunkwJpYD0UQL
         Ns7/qTTLiLy38nLKAQ/WUWW8QpdXf9NqA6NXuxnijOmti3G2W3JGr1e541DtqyWy7SRk
         qSqarZ44xodpwv2Fg0YDyOmjeOSHJxHtPXSAcM7FjHejC7gA5mc21S6hZAnmLv/PlXUF
         SC67/xI1xUZEtLmnhivMGH3DJjqKIzDT8HERVe9QJ37XBSzwGc1HoAZtiUHQFO6+0j1o
         sQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724763107; x=1725367907;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIZ/9NAl6sknpOSyqXJf5pTwFKUE753sOw+rcvyB6VU=;
        b=V4IE0zdpN2+UJFALn1Zuaw597Ui7IuiehobjAI9/0kZe6yKXoQmkRkNzDtPj9lPw+m
         RP3SskgFbPQTxCbJnohPmojALDv0j0yuhkuUB9dtj0NIuur6XPt0k1+iaCFTsYgxAMIF
         k9JzSgURPwLIFu7fdt5JKBEOC8ZRmB9sz3bIRIkBrcx4agMfVsYOOyor121bqhD9zgzL
         QzadBIYts9Lg6VgsFbmMKkrMIDYwDMmIWcDM8A78/s2DwQ3uvYnhIK3b3MdxU2VdO/IH
         vKi0BtjLo5WPWzGgNrGdkfe8OWouePEl4EOaOmZ4FbwLti14WSOmQPXlNVJFnLuiXuAY
         ugsw==
X-Forwarded-Encrypted: i=1; AJvYcCViuTfciiNVk8ATiPCYPxiZC7wvjbHI7lEcKATX5F5Ew5KjDGx+Yt7la9/ZFd+GyXJItPOROUDbAA7WZus=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEup2pKUUueJtI4XcL++FYLeeyWBGxaJuJPB9gac8ii9PSsGIl
	XDTiWTtds3di5h2xQnXVA1HdBaocyRhZEsXZUkWqS1Z8Ka2q/KIiizPZkcEiJ+A=
X-Google-Smtp-Source: AGHT+IGI/KqUx0O1B5OMUKooRpbtrwcBTIHeYmCBtCsBzSzU5pJS6J8O88BgzLYlgAW1IzGiJylzZw==
X-Received: by 2002:a05:6402:51c7:b0:5a0:d706:c1fe with SMTP id 4fb4d7f45d1cf-5c0891f071fmr4899966a12.6.1724763107214;
        Tue, 27 Aug 2024 05:51:47 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:1050:bb01:8cae:d35d:b93e:b368])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb1c5b39sm985401a12.20.2024.08.27.05.51.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2024 05:51:46 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH] affs: Remove unused struct members in affs_root_head
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <9EB1D6D7-DD1F-433D-BF6D-7DAC53EE4BAF@toblux.com>
Date: Tue, 27 Aug 2024 14:51:35 +0200
Cc: dsterba@suse.com,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-fsdevel@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <761C500D-3075-4958-9011-DEE38B235A39@toblux.com>
References: <20240826142735.64490-2-thorsten.blum@toblux.com>
 <202408261307.F7D2AD650@keescook>
 <9EB1D6D7-DD1F-433D-BF6D-7DAC53EE4BAF@toblux.com>
To: Kees Cook <kees@kernel.org>
X-Mailer: Apple Mail (2.3776.700.51)

On 26. Aug 2024, at 22:48, Thorsten Blum <thorsten.blum@toblux.com> =
wrote:
> On 26. Aug 2024, at 22:08, Kees Cook <kees@kernel.org> wrote:
>> On Mon, Aug 26, 2024 at 04:27:36PM +0200, Thorsten Blum wrote:
>>> Only ptype is actually used. Remove the other struct members.
>>>=20
>>> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
>>> ---
>>> fs/affs/amigaffs.h | 6 ------
>>> 1 file changed, 6 deletions(-)
>>>=20
>>> diff --git a/fs/affs/amigaffs.h b/fs/affs/amigaffs.h
>>> index 1b973a669d23..9b40ae618852 100644
>>> --- a/fs/affs/amigaffs.h
>>> +++ b/fs/affs/amigaffs.h
>>> @@ -49,12 +49,6 @@ struct affs_short_date {
>>>=20
>>> struct affs_root_head {
>>> __be32 ptype;
>>> - __be32 spare1;
>>> - __be32 spare2;
>>> - __be32 hash_size;
>>> - __be32 spare3;
>>> - __be32 checksum;
>>> - __be32 hashtable[1];
>>> };
>>=20
>> This is removing documentation, in a way. Since I suspect you were
>> looking at this due to hashtable, maybe just change that to [] and =
note
>> that it (and the other fields) aren't used, but they're kept around =
to
>> help document the format.
>=20
> Yes, I was looking at hashtable. I'll submit a v2.

I submitted a new patch instead of a v2.

Link: =
https://lore.kernel.org/linux-kernel/20240827124839.81288-2-thorsten.blum@=
toblux.com/

