Return-Path: <linux-kernel+bounces-234938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDB091CD03
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 15:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3168A1F23374
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 13:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1564780045;
	Sat, 29 Jun 2024 13:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b="U9DMQV1c"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3867AE5D
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719666590; cv=none; b=fsDsgd5T8TB9RO8UvPF0f7VtYERd7184jT2MIEpgWYd1TFWZkCuaEwwVTFLkzN7mOuoqolDLsAc8Fg999QJSGD5Lw34KPZUrZWyo8eVMG8rLo3bGWP5RSGUv2hsZUW7alecdQ2yelWMxCeBFVcTL9Srxe4aGsYl9CdXZmn2LmCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719666590; c=relaxed/simple;
	bh=NvBk/VJxXOr5vFerYzQwfjs4hGoztKHZX8kVmrHJLPs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Ij07eDPQGzDCLtZi0gp2/kQyt+Laz4n4m+40fSRVW9fP/hf+Z0jypO7ATl4Vn9QK4KpPI1cUyzcEGVz6iGX0zns6/LdDHTcUwh4A06WPFnPKh2RwhhbfaS+zmO3nQHVL/qJS8SySn/xYndpenqssobpkW8+q++Fl+mNxOTWwdAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com; spf=pass smtp.mailfrom=jrtc27.com; dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b=U9DMQV1c; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jrtc27.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42578fe58a6so2671875e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 06:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1719666586; x=1720271386; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBPHRag8qAvETotyyrYSH4FuLSJO/hkfmF+D7/kiato=;
        b=U9DMQV1cv7Q5XiWXPHIdMH0xoEM42GeRKK1SJsCblg8mtgC7sAksvlRS4K/EloCYGZ
         OtR4rFs2cDjbjn4Fbmm66vNcdQm3YZJFiBXNVd1U80MjVz2wP+QGyWOobJVy57lrCqMQ
         /ZKdkY+IB5cH3e3KllHwEFkvEHwEQfVxoPjDY3aHx+3XEs6+5iEMcHm79HlfG318XaCG
         BzfjMT+ixbLWdyI4tQbGIGGF9shUo+tldwBJ589yJpXeMAH7nfqtQ/COinQG7ggwT3lH
         t49j4cx7KWg1ra35L9vQfkl1pdW4W7eY8+HNi2KYAzYFvHLBJv6BJuuWnjVE4qlW+81Q
         tYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719666586; x=1720271386;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBPHRag8qAvETotyyrYSH4FuLSJO/hkfmF+D7/kiato=;
        b=a0dr249MEvINvxjn4QagjF+5bCYN6x/d4Bwg+BqNFmOZvRLt0KJTokpmgPXm5ze0wO
         qYYVq6krvHF5kxmuNnU/xcP4yUFtqRcEeK5tjBjsEuEIDLBc0yyWsEZHOZZcD55Z2XbR
         Qhx1EMd6Dwsj4VE4mgcW+jNumU0RntDoIOO2tkk9eSZqSSLoNFzUIymoxYf9492GYaTa
         dxBGc71gMIrxBF8hSQJrZcH2z+pIr1+nkCn7WBFGROnxJVpiFf8OgrZSQCmVRTtZJpS+
         bsP3y8JqgMNjMG+UmZ/SWyQ2KyA+4Wl2IiEUMEa8mDVRwnWI6AoLSBRIHLUvW6JROus5
         vxEg==
X-Forwarded-Encrypted: i=1; AJvYcCXJQ9052iyUlr+F1B8M0X6g6NED2iZqo+hEUfGub8zfk3iVC+8TFrSr/lXSCCV6++qeXTWESwyVUVkI5YSiDawV/8PEgqiAAxGuQL6z
X-Gm-Message-State: AOJu0YxbZ6nLoF4yMo4oK6XF/tfLCbYanAs29+8DCYX7VbYwkx46GHUC
	J2P2V3G+OKNI2/71ZdpLxoJ6eDw00X3Vc9i8k53QDHsiqgWdEy3MnGTOvRZ5mAs=
X-Google-Smtp-Source: AGHT+IEKNKvTpdSb4CrQTKZ+nBdE/Hft6em8KkuURlNseRT5rthITeiMfEC+Py4YC1wcYfQMxgbr6w==
X-Received: by 2002:a05:600c:3595:b0:425:5e8b:679f with SMTP id 5b1f17b1804b1-4257a02d4ddmr7277755e9.6.1719666585438;
        Sat, 29 Jun 2024 06:09:45 -0700 (PDT)
Received: from smtpclient.apple ([84.207.206.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0cee27sm76231655e9.48.2024.06.29.06.09.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2024 06:09:44 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v6 2/4] dt-bindings: riscv: Add Svade and Svadu Entries
From: Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20240628-clamp-vineyard-c7cdd40a6d50@spud>
Date: Sat, 29 Jun 2024 14:09:34 +0100
Cc: Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 kvm-riscv@lists.infradead.org,
 kvm@vger.kernel.org,
 Greentime Hu <greentime.hu@sifive.com>,
 Vincent Chen <vincent.chen@sifive.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <402C3422-0248-4C0F-991E-C0C4BBB0FA72@jrtc27.com>
References: <20240628093711.11716-1-yongxuan.wang@sifive.com>
 <20240628093711.11716-3-yongxuan.wang@sifive.com>
 <20240628-clamp-vineyard-c7cdd40a6d50@spud>
To: Conor Dooley <conor@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)

On 28 Jun 2024, at 17:19, Conor Dooley <conor@kernel.org> wrote:
>=20
> On Fri, Jun 28, 2024 at 05:37:06PM +0800, Yong-Xuan Wang wrote:
>> Add entries for the Svade and Svadu extensions to the =
riscv,isa-extensions
>> property.
>>=20
>> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
>> ---
>> .../devicetree/bindings/riscv/extensions.yaml | 28 =
+++++++++++++++++++
>> 1 file changed, 28 insertions(+)
>>=20
>> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml =
b/Documentation/devicetree/bindings/riscv/extensions.yaml
>> index 468c646247aa..c3d053ce7783 100644
>> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
>> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
>> @@ -153,6 +153,34 @@ properties:
>>             ratified at commit 3f9ed34 ("Add ability to manually =
trigger
>>             workflow. (#2)") of riscv-time-compare.
>>=20
>> +        - const: svade
>> +          description: |
>> +            The standard Svade supervisor-level extension for =
SW-managed PTE A/D
>> +            bit updates as ratified in the 20240213 version of the =
privileged
>> +            ISA specification.
>> +
>> +            Both Svade and Svadu extensions control the hardware =
behavior when
>> +            the PTE A/D bits need to be set. The default behavior =
for the four
>> +            possible combinations of these extensions in the device =
tree are:
>> +            1) Neither Svade nor Svadu present in DT =3D>
>=20
>>                It is technically
>> +               unknown whether the platform uses Svade or Svadu. =
Supervisor may
>> +               assume Svade to be present and enabled or it can =
discover based
>> +               on mvendorid, marchid, and mimpid.
>=20
> I would just write "for backwards compatibility, if neither Svade nor
> Svadu appear in the devicetree the supervisor may assume Svade to be
> present and enabled". If there are systems that this behaviour causes
> problems for, we can deal with them iff they appear. I don't think
> looking at m*id would be sufficient here anyway, since the firmware =
can
> have an impact. I'd just drop that part entirely.

Older QEMU falls into that category, as do Bluespec=E2=80=99s soft-cores =
(which
ours are derived from at Cambridge). I feel that, in reality, one
should be prepared to handle both trapping and atomic updates if
writing an OS that aims to support case 1.

Jess


