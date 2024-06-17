Return-Path: <linux-kernel+bounces-216614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA65990A245
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 04:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A24BD281B87
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 02:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B51C161310;
	Mon, 17 Jun 2024 02:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="HLH4wQDU"
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E29214292;
	Mon, 17 Jun 2024 02:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718589654; cv=none; b=Qv6SgrLJH8NN44ke2bNYkgU/achstb49SZnSZqhGOULrFMlHAJVsxN5fO+1nLZAghtFdUdrK6JT/ufvmux4pAYP+3XYrGrtBWp9b2dy4nc7+Zm8Ldb/Ugci0qlzG6rw+1AZlxUa/C6YNYyKafoS+ulh7E2L9y2DrlNuWaqhKRgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718589654; c=relaxed/simple;
	bh=xY6EdERcFdzyNAMKkFcyvUjxYXnOp6YVs3LCpTmmsFg=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=J70F/q7Gd8HgltDG0EAM8wqQ8mX77aeGBt1WS1RrAz514FNasG4gMfaf+RtGPinXd4Vee89H/YwrTHrVoZ0BeF7jiHCz6ehtaGh7Aw1bhlSKtvIVIAjXZEyti6l5DVG99qOckAW5BpF/4491jzuGs+4nQZz1eQUOwXk7VLr/WIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=HLH4wQDU; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718589647; bh=dmN8w5lvDABL/jRmeeyfuJVRMrvYcjC38E/Re9ZnOA0=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=HLH4wQDUDrmaZV+RlUwByqgqN6frxhjCKmEgFfhT7NTHpgdwqXUngDnOgfcJPp00o
	 FXQ3Z39aS+3WVAMNV7rMtvQiBgXxdi2mAr1jYVZM+2g6Oo5QKLUcwpqIBjDHzfZsRn
	 LBrJAnU2+d6SnO//2QNqM9WMZCA8TN5CePcjCWdg=
Received: from smtpclient.apple ([2409:8929:843:88d1:dc81:b668:28ec:a360])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 2B1D8F3; Mon, 17 Jun 2024 10:00:43 +0800
X-QQ-mid: xmsmtpt1718589643tpc4joxcu
Message-ID: <tencent_2ABAC5E885F8354EF1F9084A6B5B398EE00A@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25Gg9vSwwFthgrvTbwpz3NxSuSAGiSJ0OsHx1aEr6wSqGtvRecWDU
	 96gAAjThu0UmEyWsk89edyCwqWJ/4OuSmvSDIQNZ7NXeJHSqelrTi4Cf0iPIB2EF1ic4mjqGdvyh
	 Kj/i2ugDtcScxhgVY9+8WCpMsGOH83aqjXbtdw2nqIfJQqPR5ob+dzhk1ubQr9hmhadjSFFF05Wg
	 q2mtwSiHxung2k4oYGP0iyZYOD5mv6J/qPNRMLXD298cig/c1H4LGWBTLgvBdWz2EmphmQOkMgnX
	 bAzvR99/kz7ORtPKTZ4N8vyjRZdDDSHsci2s1UyuX7DgD4cNNV3PdYs+KqclMS7Aysm2ilz/ZO3n
	 cGq7Nxq2s67YfBcs8I5vXYT2O4foKJZhMKF9NQ8+CPx3V5a+WWvyyWPlaP+0JkLnYbWvhhg0pZBQ
	 iSP0b3QKkGAS06K14joB9xfuZc55O+izvCdzR9pVduxPfkHHlTHZK7Dxi0b1bkBK85RP0wSgnH2Q
	 iJGlskwBfGs+wyoGLSqhtjjH8RXkwfOCwcxZ53R9wsNnbb0/yp16K834PiMt4D2a+tTJaU9Xg5jE
	 bb7kRe8ePuyLPdMPwWipS5MA1lSmFkZ81iaHRgpFV5zz9GFMAXJ2UZSeGqkrS6Q24Y657Bt7jmAg
	 N51Sa/KS1PMu1hfkO0TN3PM5dmdn8PPUjmdo9RoFTUVvnHi8jqw+liyO0wkoNum08SftpViIeO03
	 +IqRjByS7S0q4kU9jnJ/4bbCrxYUeqYsMYF7p08zxCWIOrBC1hybPTGtlk4hv1SxzweMGZPvA7/4
	 9yy61W5vVKcVi23wJ2p+txavTBl2GY2jJsmhdwbRF3mh4ISjwQDnBRrHyDhKpgWw4Vj1xq8MxjLf
	 jhK77dAShBadVwola43ibQfafTW7fOYZ4KoCzZ7OdoEIVM1yfpbRfaOc70RXYkuZCitGXyMzEV96
	 piNn5kbPN01ZwOAbOWG1crsUvCm8zqU4/WYr3AJ0AsHIN1/a/JiS+FmUSWFKOGYi9xQOv4Xa8Mms
	 HQ3Q1/IqQ4XOYbmUTrdfxGwF4wPA0=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v1 0/9] riscv: add initial support for SpacemiT K1
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <20240616224811.GC3983622@ofsar>
Date: Mon, 17 Jun 2024 10:00:32 +0800
Cc: Yixun Lan <dlan@gentoo.org>,
 linux-riscv@lists.infradead.org,
 Conor Dooley <conor+dt@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Anup Patel <anup.patel@wdc.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 devicetree@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jesse Taube <jesse@rivosinc.com>
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <B3951194-7F51-4D44-A643-FB29533119E4@cyyself.name>
References: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
 <20240616-exorcism-computing-e11e26084a62@spud>
 <20240616224811.GC3983622@ofsar>
To: Conor Dooley <conor@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)


> On Jun 17, 2024, at 06:48, Yixun Lan <dlan@gentoo.org> wrote:
>=20
> Hi Conor
> Thanks for bringing this up
>=20
> On 19:35 Sun 16 Jun     , Conor Dooley wrote:
>> On Mon, Jun 17, 2024 at 01:18:52AM +0800, Yangyu Chen wrote:
>>=20
>> No MAINTAINERS update, so I figure that means you don't want to =
maintain
>> it going forwards? If there's someone out that that does care about =
the
>> spacemit k1 (Jesse maybe?), then I'd be more than happy to have them
>> look after it.

Actually, I don=E2=80=99t know how to be a maintainer. Should I have to
provide a new git tree and all the new patches merged to my tree
and then submit a git pull? Or reuse the RISC-V mailing list and
just give a review, and the patches come to soc misc tree? I would
like the latter one.

> Yangyu kind of has limited time, too many stuff for him..
>=20

True. Maybe I can have a review and test the patch in one week.
However, providing a review and test in 2-3 days is sometimes hard
for me.

> I'd volunteered to help on this if it can fill the gap
> Also I'd be more than happy if anyone willing step forward to =
co-maintain..
>=20

Thanks. Really appreciate it.

Should I provide a diff like this:

diff --git a/MAINTAINERS b/MAINTAINERS
index d6c90161c7bf..718d30996f12 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19306,6 +19306,7 @@ F:      arch/riscv/boot/dts/
 X:     arch/riscv/boot/dts/allwinner/
 X:     arch/riscv/boot/dts/renesas/
 X:     arch/riscv/boot/dts/sophgo/
+X:     arch/riscv/boot/dts/spacemit/
=20
 RISC-V PMU DRIVERS
 M:     Atish Patra <atishp@atishpatra.org>
@@ -21004,6 +21005,13 @@ W:     https://linuxtv.org
 Q:     http://patchwork.linuxtv.org/project/linux-media/list/
 F:     drivers/media/dvb-frontends/sp2*
=20
+SPACEMIT DEVICETREES and DRIVERS
+M:     Yangyu Chen <cyy@cyyself.name>
+M:     Yixun Lan <dlan@gentoo.org>
+S:     Maintained
+F:     Documentation/devicetree/bindings/riscv/spacemit.yaml
+F:     arch/riscv/boot/dts/spacemit/
+
 SPANISH DOCUMENTATION
 M:     Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 R:     Avadhut Naik <avadhut.naik@amd.com>

Thanks,
Yangyu Chen

> --=20
> Yixun Lan (dlan)
> Gentoo Linux Developer
> GPG Key ID AABEFD55


