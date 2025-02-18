Return-Path: <linux-kernel+bounces-519476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 518D8A39D40
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BDAA188391A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6DA268682;
	Tue, 18 Feb 2025 13:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHwnMVDY"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773B026770F;
	Tue, 18 Feb 2025 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739884864; cv=none; b=AgR16W7Um0eaM20cH+n5M5hldIFAfHLsb2z9QwiQi6dw+3Fh1ScZ5cM4J61WHKd+5svjU02cRCEZcjad+7sUV+ns1iKN3CmRscTRpsbTPs1qc0P22IIH0Exjgpea2bcHEZDQ1Ou+T7/wT5/7K8csuikIKuxtUSaJ7Nrchy1mdms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739884864; c=relaxed/simple;
	bh=pXw/VUZk2/2TbrEzlxvJbX2hPbKCJ0toaMiiUQlOMPE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=okrMzQViv95MZOmx6Tw6ctJVYvG2OC+hhCJgIXoE+9/sXn0L17/eIQeyeXOay82oOkSh1RcpprA56yCm8nrmWYnE3Y/uG/LUS2ienIuypnPus3LYq5nB2QnOEq7lgEx+NO/VdaNAyFpAfak8joTYkqdwdU+aX11+sw+rBXrjvGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHwnMVDY; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso819826066b.3;
        Tue, 18 Feb 2025 05:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739884861; x=1740489661; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXw/VUZk2/2TbrEzlxvJbX2hPbKCJ0toaMiiUQlOMPE=;
        b=SHwnMVDYOCe5t2OwaQtkqMWgOCu5ipFFxkBzVfpQ4aABypu1LtuATA7lL6EYpZZM+J
         VJTv3FV/VCExsWP1KcyYAsX3ec7viaPTJLpFggYmNQO4W9M04k5Io98BFg57OAWGNykO
         jFRCeB6+CnW3RhQAiEeTyyYW+4FpI4aIyz76aiOWDGAVZRhYUakSoxkwnz1uv6nw9Wo6
         8i2qEMy6ZXauHncDAOdUGVPh/AZIVTKDBbVC5Cd6e3mYmww7GrxmhHz7ECVsLkO+3L3A
         CzhtqqDv7/v92MzTSPatzU99pHPhisD2zjybrchthKBAr2OuKk2lcRAwJX6MQk46WpFJ
         DBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739884861; x=1740489661;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXw/VUZk2/2TbrEzlxvJbX2hPbKCJ0toaMiiUQlOMPE=;
        b=kHX2hVA+ap0h40e/rKy659EErxPrd0j0NLVM1eilgWBCO100oqzG6wBLjnNISrJBxq
         7t8I2CGijsQrQ94lB7kiagESwytTqekwpbPnQUsg8pjsdDC5ewhDfr1qU2vsEY9jghhb
         uHnshmnhfy6fCZfGkIACLvZe0AXjcTGc8h0uoZ4jF3PT5iv5/xUalMEDJqZ94N6oeTuD
         PUwzbm0eVcy1K3wcZb8iEsFFiMy/Bgn1oJB0IBeMkryUmwifFiwNFuBD4UKpVQhsrJyr
         s+fT173kd+Yc6OXwhG3XlcvwLhXwO/dl2Yj4iVRfsIT/f0FBLrLkrOQD8KR2lNZEqi8A
         r+6g==
X-Forwarded-Encrypted: i=1; AJvYcCXLffcEOTMEWUy6ZymMVeWqL49AsIKmeDFFCB98r809o264qjsN3nknAgwlQpUodyR0+IzQZGtHVEAL@vger.kernel.org, AJvYcCXSAKJamFbMTn0vNmPfFD9wTCvSQlHoxexZPeKvW840Z5CzcD+OtWbR8/ZYzlrWL9SFlp8dq/cw0vI15hel@vger.kernel.org
X-Gm-Message-State: AOJu0YxOlMsAQmsUCxB0LvlnuNNmlDglbOWdsUTcQgJ3NVrM6UfPY3wN
	B9A8yH+WfaYOuYT70kMTOIKYIcONsJnzR0ShcbIYcLCDVv7k0/HX
X-Gm-Gg: ASbGnctpYmOtSZufMTkMrotSiB2Y9+b4N2LcO+9Zop0UFxwnRd/baEe9byYaxYb0eRM
	+sqOHLBQsmk5C/1MwxoTNYIa34nWUcp84GcRYFdHMdJFwQz+tV+V2U9oruHd7goNuaRx/TeVvnj
	kPIS8k3KRr3+PDl/aoAaYj5Y02Bv1G5ICXGwGhRv+kqzmh5VOVkuK3RpBLEEvFyho2dCgCcXxMd
	bgnWjv6K5JpAUts0wUDb9VA/PV0qsPkmb6QPI+q14XEucB4qRqLFTQStnPqau2Z/OiCmIbZvYKy
	S+ZxWWwHfAcgkwzfAPDpcu2YEc9ian0sTJMivfZ7xDjEdiLozFhREMy3H1nExH3F+vYHwUZF
X-Google-Smtp-Source: AGHT+IGfAz1/Ln9aF9MylRqFz1gstkfkLiDTO4oAQvkajZW5cUBk1t7bUxgvzU80gmDZNx8cT63axw==
X-Received: by 2002:a17:906:1757:b0:abb:b136:a402 with SMTP id a640c23a62f3a-abbb136a75amr388377666b.18.1739884860519;
        Tue, 18 Feb 2025 05:21:00 -0800 (PST)
Received: from smtpclient.apple (89-66-237-154.dynamic.chello.pl. [89.66.237.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb4d3ef3c0sm714890366b.41.2025.02.18.05.20.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2025 05:21:00 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH] arm64: dts: rockchip: add hdmi1 support to ROCK 5 ITX
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <20250217132146.604090-1-liujianfeng1994@gmail.com>
Date: Tue, 18 Feb 2025 14:20:48 +0100
Cc: conor+dt@kernel.org,
 devicetree@vger.kernel.org,
 heiko@sntech.de,
 krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org,
 robh@kernel.org,
 sfr@canb.auug.org.au
Content-Transfer-Encoding: quoted-printable
Message-Id: <AEAB639A-1EA6-4FA1-AAC6-C382FB280487@gmail.com>
References: <975CFBEF-4E37-41E4-BE3F-7294FE7E4D3F@gmail.com>
 <20250217132146.604090-1-liujianfeng1994@gmail.com>
To: Jianfeng Liu <liujianfeng1994@gmail.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)



> Wiadomo=C5=9B=C4=87 napisana przez Jianfeng Liu =
<liujianfeng1994@gmail.com> w dniu 17 lut 2025, o godz. 14:21:
>=20
> Hi,
>=20
> On Mon, 17 Feb 2025 10:48:00 +0100, Piotr Oniszczuk wrote:
>> I manually installed it on my sd card and sill getting:
>=20
> I have built a armbian bookworm minimal image, you can test it in case
> there are hardware related issues:
> =
http://cdn.haguro.top/share/Armbian-unofficial_25.02.0-trunk_Rock-5-itx_bo=
okworm_edge_6.14.0-rc2_minimal.img.xz
>=20
> Best regards,
> Jianfeng

Many thx!
This is very kind!

I flashed, booted =E2=80=A6. and have exactly the same symptoms & logs =
like on my previous email :-(

Being desperate I reflowed hdmi ports board area and - believe or not - =
this seems to help (albeit don=E2=80=99t know for how long :-)
Now hdmi1 works nicely.

Jianfeng, many thx for your persistence with my hw mess=E2=80=A6. =20






