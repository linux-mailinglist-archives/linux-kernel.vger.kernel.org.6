Return-Path: <linux-kernel+bounces-206214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 944089005DD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C1D5286C8C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E458194AD6;
	Fri,  7 Jun 2024 14:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DdGtdU4x"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3891953AA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717769010; cv=none; b=KiJo1yAUFUc+dRx+PXxvTWeLRDMraJQSemJaWSL0/LbN72JD9KIuDTYmkH54ZnmyHS95FjC2AEy71pEUYIHMjoynFum+GdrZyj1W6RrlpeSGKBOuHQfXCR4TL3k24M2Sjjgib1GA/mQL5eJSopIDjQvtDlLJ2tMvVZ9s4hpF3Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717769010; c=relaxed/simple;
	bh=SQ1O9XTD1oakgVp3AgIq/B4Ze3w840vYeY7AB003klM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ggbpGzwQu06pcm2OwL4ITCN0JNuoUPtK6NbmbH7b8giKeE5NQeKaBpkieCn3UrbrmX+KvqA9onNSoSkx/DawwqdnNkG5h2lJdHswON4s9tiGm6SrHyvPNuRd8gG5u5Ez7/a8TaXCDfV5U3K2CDPsugrrB+O5ZOwhicbqDiANTII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DdGtdU4x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717769007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SQ1O9XTD1oakgVp3AgIq/B4Ze3w840vYeY7AB003klM=;
	b=DdGtdU4xGL1bHma5C4VEb5xTNKgev/f0xv4v+0fSo+3TAVGtFk0tHB5O/Y+nFUQpB/w54y
	BTRL2gVZ+kh+Y64iUENwy0LrAeM/pYULZEPhSJqhURwYwi2e1XSfdSgqEq9nNRdisgz+fg
	PtarOKgUkZ/dUOWlfMl/wekhvnxO3VQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-sBMDZOBRPhaV_RZ_8tAxiA-1; Fri, 07 Jun 2024 10:03:26 -0400
X-MC-Unique: sBMDZOBRPhaV_RZ_8tAxiA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4211239ed3dso2396025e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 07:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769005; x=1718373805;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SQ1O9XTD1oakgVp3AgIq/B4Ze3w840vYeY7AB003klM=;
        b=WewGqNFFXe24wPMadslqoh9nXZUY1tEeJU9xNuENEMj39nqJMLU3ZbQgkiIxKLvXtr
         SCQKTYMOF/RaGIj2i9PdddQeNwiE9xv5Zjzg1eQRaboRipPYJKBVLrXScB3BkVtgHYXf
         aTSrAYv8F63ceybz6X6b6U79Y+6Zc6k5N9IzkN1irxYO2NtyuH4jcnM88WOIMSZJi4zN
         QriUqA6SMh/1qAdQi9keAekWQMk8YhUrB50L2Oz/kEOlnaq/xlZkYcN5PeMxYXe/bIZ5
         Q42qJWzYgDqSkq6m88XnHHJwscEkJh6MvqjHYLrPp0vPBAQpw36Me26LxIdO2GKM7hDu
         1DkA==
X-Forwarded-Encrypted: i=1; AJvYcCVZHjinCXIlrK5Nb8rTMHJJlk9h8ZYtMj/4iDi+AFhdPnU9IrJiviHSLyps4SZFlUGzJl6Q7bAENGe06rZlR6v+OqlLuO6LCXu6bfDC
X-Gm-Message-State: AOJu0YyQSOFNR0JqM02Yf7AYTJP5ziIZkqN58Qd+TeBF3uep6TelgnyK
	GbFxcaKIqjMHavqEKw4n8ANmTrulbar/YjUi/3pHqY4o1MrAKaLuDIiQVV35/m6xqg0UzpUkmpB
	MD7KOK5SifEm0a0RX/epto9quRj+5xL3ifGDymc+bJjmA2mLRejN8rlcSKpSCO5Su0EjaKQ==
X-Received: by 2002:a05:600c:3b8c:b0:41f:9c43:574f with SMTP id 5b1f17b1804b1-42164a44b26mr19995035e9.3.1717769005280;
        Fri, 07 Jun 2024 07:03:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVUs13wUZpjESXe0Z+dnuQxbqmAlpn493FLvEkczfieTdNDL0r/Azq6jmHt6LLgxggsLb/9w==
X-Received: by 2002:a05:600c:3b8c:b0:41f:9c43:574f with SMTP id 5b1f17b1804b1-42164a44b26mr19994855e9.3.1717769004904;
        Fri, 07 Jun 2024 07:03:24 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1b74:3a10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215814f141sm87852125e9.42.2024.06.07.07.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:03:24 -0700 (PDT)
Message-ID: <2cac4cf68304e81abffbd9ff0387ee100323c2b7.camel@redhat.com>
Subject: Re: [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64
From: Paolo Abeni <pabeni@redhat.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>, 
	=?UTF-8?Q?Ar=C4=B1n=C3=A7_=C3=9CNAL?=
	 <arinc.unal@arinc9.com>, Linux regressions mailing list
	 <regressions@lists.linux.dev>, Frank Wunderlich <linux@fw-web.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Daniel Golle <daniel@makrotopia.org>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, frank-w@public-files.de, Rob Herring
 <robh@kernel.org>
Date: Fri, 07 Jun 2024 16:03:22 +0200
In-Reply-To: <714da201-654b-4183-8e5e-8ff0b64fe621@leemhuis.info>
References: <20240516204847.171029-1-linux@fw-web.de>
	 <a29dd7d1-40a8-4c88-99aa-651a3305b640@arinc9.com>
	 <5AEE5668-0C8E-4EE4-A398-66CB99DF5650@public-files.de>
	 <43aacd9d-b851-4100-8ccc-878ac6ae10f8@leemhuis.info>
	 <698cf562-1ca9-4aa3-be7e-a1474b612c5b@leemhuis.info>
	 <0cba095c-3d55-416a-a7ad-b359129731cf@arinc9.com>
	 <714da201-654b-4183-8e5e-8ff0b64fe621@leemhuis.info>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-06 at 10:26 +0200, Thorsten Leemhuis wrote:
> On 31.05.24 08:10, Ar=C4=B1n=C3=A7 =C3=9CNAL wrote:
> > On 31/05/2024 08.40, Thorsten Leemhuis wrote:
> > > [adding Paolo, who committed the culprit]
>=20
> /me slowly wonders if the culprit should be reverted for now (see below)
> and should be reapplied later together with the matching changes from
> Ar=C4=B1n=C3=A7 =C3=9CNAL.

FWIS I think a revert should be avoided, given that a fix is available
and nicely small.

Thanks,

Paolo


