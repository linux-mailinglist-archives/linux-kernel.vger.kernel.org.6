Return-Path: <linux-kernel+bounces-220576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28D590E3E6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C78A01C20BC6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5C671743;
	Wed, 19 Jun 2024 06:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="elpDwQWs"
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D966BB58
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 06:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718780359; cv=none; b=s7qJHHPuE8BYNgo5dizcltpMzi0of6D7+cQwrL0W14UxtwVZV7uCJl3/flWh9rkLeQw5KrOIYCTtWN3f4NJYogGmxPTdT5D7uv5GF3bGrBWJLzbhcadKUdl07jA56EGDFDqhegfBmOkHi5q9dfUNz4ZvyVVxrFbQkVzG4qasKS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718780359; c=relaxed/simple;
	bh=Ex8XoHz2m30DmPv+kgvdAZKlewAU12uHOkN9ftTBENU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PDPdnjOYJOnPypZh0l64DD8wUysz7qCh6dTxdV11IxJPB8F0zn45LJbaVc8F0g97Oo4NiHF2/Ql1aYHeqPKLgCUoE5Q+yOBcP0DgfrwH03Is3K1f43qAP6BLbgweXovFrFek3mX7h7q9o+h03gnK/frOw9MMMJth8duCp6T3vhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=elpDwQWs; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-1f717ee193fso45871665ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 23:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1718780357; x=1719385157; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzjGU5wIa+JU8cPwc97EJTnBpHZIpaLeV58Ad7PrW+0=;
        b=elpDwQWsb7PjGQPlB9td6H3/T/5ZuTyu8wEmyKzMS8S5xc0CSeIlIPGLt5RJZJTWur
         PWH50a4YBiPXNaBhxFO4t3gys/UyHxDPpSmeIE5N7X7q4tpE9jsUynziavYtiKCoK3Zb
         UD8SB66wB39H5cnpRttoQfa8B0RzLAOJtSRH8AifI1xMk1qAejpUo6sWf/Qi61SEf5Z0
         1cic+xqt5ibEWdkjuqQ23cWHBCv4boI3cRAUF6N0W8KpBKk0TX5lKUg4LrLNbNzgS9pX
         acWBb4OBv6GSEOjugjORNWhdIiRTxQuzCKj71lVvtpXLuxYBmCR9xTdYzhj2vzDDfbMo
         r6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718780357; x=1719385157;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzjGU5wIa+JU8cPwc97EJTnBpHZIpaLeV58Ad7PrW+0=;
        b=SnjVlx/1KMJVIYibyXWrCqbsZ/3KtEvjuqAM+LGktKhd2SKmR4wjL/VVjjAm0uGFTx
         SGYFzyEudIzVxFeJUkdcbOqrxJ9P3eRB0n9KHcnknlMTEiZ+MVzLuYj4QsCaMWz9gLnw
         XlhxO+1/R26X8kvRtoqrUTJJRMs9eLfVjOE0ldQfC3XIJUlQV9ZPmGuj2DGZ0Zkrydwg
         zSULER6ZjOEfLZhl/OqlHpyvq/wn/z8kL3duTq5lfSdjHffrxMihyqaL5J4BeBK3qDrJ
         JS0lFcK9TOwZYTH/F9ILhoMgZ19M8pw2GYh/rgJx2MJ5fgcKBPwp67L+W1WmEly2qygC
         puYg==
X-Forwarded-Encrypted: i=1; AJvYcCVVQjbxP61NMpIeooWNREhMO6q7BmHpv28O38+jwyewEK9hXJCXhozB+/f4DZB1u16T8jf3JuGrL15W7KgUf7M6GzmBgk7YP/QaNwBV
X-Gm-Message-State: AOJu0YzzwH48zRCCPjxxouDThFqQOCd3FDN4GLBzQhnZZD5wyEKilupo
	IlolgzIuXnfLfG5T5vE6mUD/Z1qJwPBKv/zLoE1hzLfi294NAN/SvWJnxKPCNg4=
X-Google-Smtp-Source: AGHT+IF0QuYNMormgx3auX8/Izc4u+XSl3cTe8yCrtE7iOzIASVVYL+Eeg/BX/XzR5adzYxi97hmXA==
X-Received: by 2002:a17:903:32d2:b0:1f4:b9d3:adce with SMTP id d9443c01a7336-1f9aa3ec015mr20708695ad.27.1718780356839;
        Tue, 18 Jun 2024 23:59:16 -0700 (PDT)
Received: from smtpclient.apple ([103.172.41.206])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9b97ab2d6sm2332845ad.56.2024.06.18.23.59.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2024 23:59:16 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH] scsi: sd: Keep the discard mode stable
From: Li Feng <fengli@smartx.com>
In-Reply-To: <20240618084706.GB843635@p1gen4-pw042f0m.fritz.box>
Date: Wed, 19 Jun 2024 14:58:59 +0800
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3F36E434-F2D4-457C-860C-4CA31EAE99DC@smartx.com>
References: <20240614160350.180490-1-fengli@smartx.com>
 <20240617162657.GA843635@p1gen4-pw042f0m.fritz.box>
 <DBAA6B83-E60A-437C-A8D8-B854E625F6CD@smartx.com>
 <20240618084706.GB843635@p1gen4-pw042f0m.fritz.box>
To: Benjamin Block <bblock@linux.ibm.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)



> 2024=E5=B9=B46=E6=9C=8818=E6=97=A5 16:47=EF=BC=8CBenjamin Block =
<bblock@linux.ibm.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Tue, Jun 18, 2024 at 11:06:13AM +0800, Li Feng wrote:
>>> 2024=E5=B9=B46=E6=9C=8818=E6=97=A5 00:26=EF=BC=8CBenjamin Block =
<bblock@linux.ibm.com> =E5=86=99=E9=81=93=EF=BC=9A
>>> On Sat, Jun 15, 2024 at 12:03:47AM +0800, Li Feng wrote:
>>>> There is a scenario where a large number of discard commands
>>>> are issued when the iscsi initiator connects to the target
>>>> and then performs a session rescan operation.=20
>>>=20
>>> Is this with just one specific target implementation? This sounds =
like a
>>> broken/buggy target, or is there a reason why this happens in =
general?
>>>=20
>>> And broken target sounds like device quirk, rather than impacting =
every
>>> possible target.
>>=20
>> This is a common problem. Before sending a rescan, discard has been=20=

>> negotiated to UNMAP. After the rescan, there will be a short window =
for=20
>> it to become WS16, and then it will immediately become UNMAP.=20
>> However, during this period, a small amount of discard commands=20
>> may become WS16, resulting in a strange problem.
>=20
> Ok, interesting. Do you know why this short window happens?=20

I have explained it in other emails, you can read them.

Thanks,
Li

>=20
>>>> There is a time
>>>> window, most of the commands are in UNMAP mode, and some
>>>> discard commands become WRITE SAME with UNMAP.
>>>>=20
>>>> The discard mode has been negotiated during the SCSI probe. If
>>>> the mode is temporarily changed from UNMAP to WRITE SAME with
>>>> UNMAP, IO ERROR may occur because the target may not implement
>>>> WRITE SAME with UNMAP. Keep the discard mode stable to fix this
>>>> issue.
>>>>=20
>>>> Signed-off-by: Li Feng <fengli@smartx.com>
>>>> ---
>=20
> --=20
> Best Regards, Benjamin Block        /        Linux on IBM Z Kernel =
Development
> IBM Deutschland Research & Development GmbH    /   =
https://www.ibm.com/privacy
> Vors. Aufs.-R.: Wolfgang Wendt         /        Gesch=C3=A4ftsf=C3=BChru=
ng: David Faller
> Sitz der Ges.: B=C3=B6blingen     /    Registergericht: AmtsG =
Stuttgart, HRB 243294


