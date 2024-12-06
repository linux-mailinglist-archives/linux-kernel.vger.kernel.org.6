Return-Path: <linux-kernel+bounces-435651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 625ED9E7A95
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127E71887A3D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00808204576;
	Fri,  6 Dec 2024 21:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErRn66Lr"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8F0213E98;
	Fri,  6 Dec 2024 21:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733519924; cv=none; b=c6ORLnjCLliByQwYmCaSAJHQevKFDMj5YeXHqycLlXIKoB/YnwsgCylsxpVREjHMIhQxbUQaoINSD1d2LTG6Dv3PCKsr7D1OglD2/8qCO0mYo9UYqppCAJRwl/C5/rGS23Z5rZfC2IPh/jOtG2CvClrCdym9KVHck3BEIj++j+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733519924; c=relaxed/simple;
	bh=+G0VUTcrCnTC5rX+UjcLwTptgU7q/HBq1U1Y2xggPl4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=kfYLXXXBgqgq2MExoMacXHPp0Jkt3sAREyIBdcAXd/BUvsIZfHTdCjaPDF3abojW0/kdaop+5lOmv0/IGdLcjkPKm/N6Rko9AKmVBHhDPjwRAZ13rOKtfAQVJwAI81BNQ1fBalKK7BFCmLRORRztBsmjTEA7d51pVqN+hPe1mfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErRn66Lr; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa503cced42so352623966b.3;
        Fri, 06 Dec 2024 13:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733519920; x=1734124720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+G0VUTcrCnTC5rX+UjcLwTptgU7q/HBq1U1Y2xggPl4=;
        b=ErRn66Lrkd1BRffrmAYPHrDaLy5hWARwN2D9uoGlVn+pDFc6WFqFv4NbbtIhS+wP3p
         RshhR5Jyn7pwA+HrWwEQjr3AugfLn7hedCHJ/ucCRaf/ndovoLEXH4feaRBzDRxMPM9H
         gW9ZNDDyegCUam/o57mDkc04xtoO6bQsBZ0clgFJJt9CRtAKsh/BhEEB0f+RGumi9tjk
         6u2WqRykdzxzJx323s8q5izOrwN52xYxcvUfZXAsTTyNRb6f2Oaqc+W3z8dQWf2VhuUR
         InkJC0OwrqmpxTYFvj/eR3Gu1Ayva0K/sL8v80GJHR+XZS76y35rR9tMlTC5ctPODLvl
         lB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733519920; x=1734124720;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+G0VUTcrCnTC5rX+UjcLwTptgU7q/HBq1U1Y2xggPl4=;
        b=WtXH9HR5OphZ7fQuB42Oy1MNN+4aQwvE/zZ1VgaWoBpKxMvaBYibewsNQsBLoXcyUH
         L7/RBcII/J6rVqi6We+LV5qV7Sfn744cj/mg9P+THa0kw88hEzHhLQRpVoj6mkwxqvPr
         K8Tf9b62EicNilT20UOLt/SZChjij29hWIzZdoJlcZns11n2Zw8Ge4wKvojSn1HX0yEf
         6W1hzo3a/gBS+BIXMbk2CeNPI/vcrtBhsXUnNuIkq6sBUiNpFTOdnf/nFxHeJsq+nDrp
         g7NLQlh6YNh4WXDGhem8Qp07vv/xvRKH9NdO8gTig+DKdl2JP1ENYA/ipszdOCZaNQO6
         ZEaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr3gQqhHZ0C9s446uvZAo2Dy6yWQQxQNqZBzDEBXFt7V3B1eWOvt0EzpkeJ2KD4M2O6rjofPwoX8iFfsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbE/S7NhjO9GXPJ/czDzL9cjBLU24RekQtLoZoTHISh5cnEa7J
	eqrzrqTI5NjKLFId8YnKhKSeoPk5u7S+CLGHmxAIyUestS+IC0x8
X-Gm-Gg: ASbGnct0iK24QoXmvpf7+9gQ0fwZRfQX/W71zwQwWumziPGKyTmW43o/8MJFF1GBFBL
	bRSPyh5KEqEwkCq59jcwd7ZWElP52jk0V2q6oUaE+hx3nKSbJLSNQEvP+RX3pbRnguQKdoGI7Da
	u16x39EZeZ3jJuo1uDK1vxUmo9wMBYe1s4ppJV4IawJdN+zAictPfKWRB0A+r0ybwipLf7j9Tf/
	y2fnDaSbFDYfk7Du5Y6wVAkDUC5A3i5QbfjeGWI5GN45g==
X-Google-Smtp-Source: AGHT+IGcoxybZrhqT6jfLtgMG6i7/mc41GHYgMF8CO/3DtZQeH/elgJdfj7dasDNeMyogMXK8EXInA==
X-Received: by 2002:a17:907:7714:b0:aa6:3418:d9d4 with SMTP id a640c23a62f3a-aa63a073aa6mr302410166b.17.1733519919441;
        Fri, 06 Dec 2024 13:18:39 -0800 (PST)
Received: from [127.0.0.1] ([45.152.72.7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e96a3esm291696566b.59.2024.12.06.13.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 13:18:39 -0800 (PST)
Date: Fri, 6 Dec 2024 23:18:36 +0200 (GMT+02:00)
From: Yurii Strilets <yurastr100@gmail.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Message-ID: <78eb0efb-bbaf-4cba-840a-9aa507798075@gmail.com>
In-Reply-To: <bf3b9efd-6700-485a-bd0e-f81de1e11fcf@gmx.de>
References: <33bfcda8-3d3d-46b9-84f0-44e0e9f44230@gmail.com> <bf3b9efd-6700-485a-bd0e-f81de1e11fcf@gmx.de>
Subject: Re: [REGRESSION][BISECTED] asus-wmi driver fails on my laptop
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <78eb0efb-bbaf-4cba-840a-9aa507798075@gmail.com>

Thank you very much for the fix!
I am terribly sorry about a faulty report, I did just find out I had an iss=
ue during the mainline build.

Dec 6, 2024 20:15:05 Armin Wolf <W_Armin@gmx.de>:

> Am 06.12.24 um 14:33 schrieb Yura Strilets:
>=20
>> Hello,
>>=20
>> After upgrading from 6.11 to 6.12 a bunch of Fn+Fx buttons(touchpad,
>> mic, kb backlight, my asus) stopped working and the
>> /sys/(...)/asus::kbd_backlight interface is missing, which,
>> considering the dmesg, looks like an asus-wmi driver issue.
>>=20
>> I've been able to bisect the issue to the commit
>> [b012170fed282151f7ba8988a347670c299f5ab3] "platform/x86: asus-wmi:
>> Fix thermal profile initialization"
>>=20
>> Additionally, here's some maybe-helpful information:
>> my laptop's model -- ASUS Zenbook UX3402VA
>> linux distro -- Arch Linux
>> .config for bisection -- was taken from /proc/config.gz at 6.12.1 arch
>> kernel(attached in [1]) and missing options are default
>> dmesg logs -- The "grep asus" parts of both good and bad scenarios can
>> be seen below and full logs are at [2] and [3]
>>=20
>> =3D=3D bad.log =3D=3D
>> [=C2=A0=C2=A0=C2=A0 3.664546] asus_wmi: ASUS WMI generic driver loaded
>> [=C2=A0=C2=A0=C2=A0 3.713358] asus_wmi: Initialization: 0x1
>> [=C2=A0=C2=A0=C2=A0 3.714126] asus_wmi: SFUN value: 0x21
>> [=C2=A0=C2=A0=C2=A0 3.714131] asus-nb-wmi asus-nb-wmi: Detected ATK, not=
 ASUSWMI, use
>> DSTS
>> [=C2=A0=C2=A0=C2=A0 3.757420] asus_wmi: Failed to set throttle thermal p=
olicy
>> (retval): 0x0
>> [=C2=A0=C2=A0=C2=A0 3.757425] asus_wmi: Failed to set default thermal pr=
ofile
>> [=C2=A0=C2=A0=C2=A0 3.757429] asus-nb-wmi asus-nb-wmi: probe with driver=
 asus-nb-wmi
>> failed with error -5
>> =3D=3D end =3D=3D
>>=20
>> =3D=3D good.log =3D=3D
>> [=C2=A0=C2=A0=C2=A0 4.557898] asus_wmi: ASUS WMI generic driver loaded
>> [=C2=A0=C2=A0=C2=A0 4.776587] asus_wmi: Initialization: 0x1
>> [=C2=A0=C2=A0=C2=A0 4.777253] asus_wmi: SFUN value: 0x21
>> [=C2=A0=C2=A0=C2=A0 4.777256] asus-nb-wmi asus-nb-wmi: Detected ATK, not=
 ASUSWMI, use
>> DSTS
>> [=C2=A0=C2=A0=C2=A0 4.777258] asus-nb-wmi asus-nb-wmi: Detected ATK, ena=
ble event queue
>> [=C2=A0=C2=A0=C2=A0 4.805497] input: Asus WMI hotkeys as
>> /devices/platform/asus-nb-wmi/input/input15
>> =3D=3D end =3D=3D
>>=20
>> [1] .config - https://pastebin.com/raw/3nDSV8Sm
>> [2] bad.log - https://pastebin.com/raw/fvR5Sjzt
>> [3] good.log - https://pastebin.com/raw/EazfLAWA
>>=20
>> Thanks,
>> Yurii
>>=20
> I am aware of this issue, the necessary fix (commit 25fb5f47f34d) was alr=
eady submitted upstream and will likely
> show up in the stable kernels soon.
>=20
> Thanks,
> Armin Wolf

