Return-Path: <linux-kernel+bounces-401223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9129C175C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B52C2831C1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 07:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E666E1D12F1;
	Fri,  8 Nov 2024 07:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b="StQyBq7Y"
Received: from smtp0.epfl.ch (smtp0.epfl.ch [128.178.224.218])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D799519413C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 07:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.178.224.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731052772; cv=none; b=W2kFbVFe3ukU2mAM1/fSBMNDm8huLW8nncWp8oIRuAwkX5yXnF2LZnXsTPLLNigyPC+h141xBp9Bqlad6rFe8PLkZJBF9ZYIuc5yhYDyiiuhR8olMa/lz0f5AfYi8YO61drj+DHo1t2ocCcacbU5qVKWzMtAeXXqRCTRsnyXX+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731052772; c=relaxed/simple;
	bh=ri2nOwTYUqh4oklxANVHiw6oIUKbG3m1JOOGXTf1BpM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NbSEmqRocdP/8aXlcUC0QvcO45fVG4Py1mQWJdbL6Dmt053q1foV3hir+Th2R8l/I1qltOw7smqbz6gspefTMtONZao3bAl30G2xwLCIxGXk+PVRaUQr6TK2/1oLO1OCcbm5oaWgy8E+wTi2UDz0EMBbngLtiajwWV11Fme3NI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epfl.ch; spf=pass smtp.mailfrom=epfl.ch; dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b=StQyBq7Y; arc=none smtp.client-ip=128.178.224.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epfl.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epfl.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epfl.ch;
      s=epfl; t=1731052763;
      h=From:To:CC:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
      bh=ri2nOwTYUqh4oklxANVHiw6oIUKbG3m1JOOGXTf1BpM=;
      b=StQyBq7YwJ1LBAg1ybxZwQyeWtub39PsdENbLX02C7Wtxy5XDlElV/+ioroc123bi
        taC+MmqQpSG0ac2mXesJHS96CSuxP7rahq16JOW8p4kUl4g1QTkpF/C3/v4f8CvXZ
        UCYer/4RDE6cmV2hUW3hLfYA4S6IY8fZ/mjy89TNI=
Received: (qmail 22906 invoked by uid 107); 8 Nov 2024 07:59:23 -0000
Received: from ax-snat-224-187.epfl.ch (HELO ewa12.intranet.epfl.ch) (192.168.224.187) (TLS, ECDHE-RSA-AES256-GCM-SHA384 (P-256 curve) cipher)
  by mail.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPS; Fri, 08 Nov 2024 08:59:23 +0100
X-EPFL-Auth: twM+TWPuYRYped7sEKtSAnqyK7XV+082YyUzkMNNuyG3Z0t55Eo=
Received: from ewa07.intranet.epfl.ch (128.178.224.178) by
 ewa12.intranet.epfl.ch (128.178.224.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 8 Nov 2024 08:59:23 +0100
Received: from ewa07.intranet.epfl.ch ([fe80::f470:9b62:7382:7f3a]) by
 ewa07.intranet.epfl.ch ([fe80::f470:9b62:7382:7f3a%4]) with mapi id
 15.01.2507.039; Fri, 8 Nov 2024 08:59:22 +0100
From: Tao Lyu <tao.lyu@epfl.ch>
To: "eddyz87@gmail.com" <eddyz87@gmail.com>, Shung-Hsi Yu
	<shung-hsi.yu@suse.com>, Andrii Nakryiko <andrii@kernel.org>,
	"cve@kernel.org" <cve@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: CVE-2023-52920: bpf: support non-r10 register spill/fill to/from
 stack in precision tracking
Thread-Topic: CVE-2023-52920: bpf: support non-r10 register spill/fill to/from
 stack in precision tracking
Thread-Index: AQHbMZi2KI47VbLtG0qMIgWsD/qxprKsxusAgAA8uqw=
Date: Fri, 8 Nov 2024 07:59:22 +0000
Message-ID: <6ff5182d2cdc4601834bfaa1e3cd1db3@epfl.ch>
References: <2024110518-CVE-2023-52920-17f6@gregkh>
	 <emjjveewgoegvinmjmba4ys34vbmb3sp6r6qefv77i5mtettmj@hsvm5vm3qivd>,<961720ed43b3df26042efc260d433fb6ddf5c44e.camel@gmail.com>
In-Reply-To: <961720ed43b3df26042efc260d433fb6ddf5c44e.camel@gmail.com>
Accept-Language: en-US, fr-CH
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>> Hi Andrii and Eduard,
>
> Hi Shung-Hsi,
>
>> I'm trying to determine the security implication of CVE-2023-52920, or
>> more specifically, what does commit 41f6f64e6999 ("bpf: support non-r10
>> register spill/fill to/from stack in precision tracking") fix.
>> Superficially this looks more like an improvement to the verifier.
>
> It is my understanding as well, that this commit is an optimization to
> avoid some precision marks. I do not see any security implications.
>
> Thanks,
> Eduard
>=20
> [...]

Hi Andrii, Eduard, and Shung-Hsi,

The previous discussion is here: https://lore.kernel.org/bpf/20231020155842=
.130257-1-tao.lyu@epfl.ch/=20

In short, without this patch, the verifier will miss checking an execution =
path that can have out-of-bound access,
which eventually leads to privilege escalation, like obtaining the root pri=
vilege.

Best,
Tao=

