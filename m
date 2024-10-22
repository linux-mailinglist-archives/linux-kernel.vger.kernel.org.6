Return-Path: <linux-kernel+bounces-376088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D066B9A9FE1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91298284157
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F4119A281;
	Tue, 22 Oct 2024 10:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crawford.emu.id.au header.i=@crawford.emu.id.au header.b="Xy87yng0"
Received: from bits.crawford.emu.id.au (bits.crawford.emu.id.au [116.255.43.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FCB18E02D;
	Tue, 22 Oct 2024 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.255.43.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729592638; cv=none; b=LCtLKV/Y05coCQ+SbbbL2WrCxw/2aLojWqIYS5QqaFwA5w1e90j6kl5fPVvRI0boB1n7i/PqRPlawMzBnIupJZoIhsVIix7UqOgFDVIe6Efrcw6NuhtoZ9GoEUs1n1pKPaJ+PVhK6BEGwilJSSi0CD/RHsm6wcxNu5RpEJZONHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729592638; c=relaxed/simple;
	bh=SRqzvbaoKeZkrjxlkdfsxvkrPl82yGUEMUAs26nt2sg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eASd/NUDR4n9sHWAWdj7/up22t2q+IR6urcTZGEidwStg+E6IL2s3w1f84kW1xz0BGM3xonqVtdIypEhmB+v2UwxZ2D3Le7hD8XwFwGjPAwfGVaaovMkz5HnF/7A1xHQ638Tbg5lhu7SXqaxlKP114PJriDdsYBgEZAUZaoi+sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crawford.emu.id.au; spf=pass smtp.mailfrom=crawford.emu.id.au; dkim=pass (2048-bit key) header.d=crawford.emu.id.au header.i=@crawford.emu.id.au header.b=Xy87yng0; arc=none smtp.client-ip=116.255.43.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crawford.emu.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crawford.emu.id.au
Received: from agc.crawford.emu.id.au (agc.crawford.emu.id.au [IPv6:fdd2:7aad:d478:1:0:0:cb10:cc07])
	(authenticated bits=0)
	by bits.crawford.emu.id.au (8.18.1/8.17.2) with ESMTPSA id 49MADgsv3932404
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 22 Oct 2024 21:13:42 +1100
Authentication-Results: bits.crawford.emu.id.au; arc=none smtp.remote-ip=fdd2:7aad:d478:1::cb10:cc07
DKIM-Filter: OpenDKIM Filter v2.11.0 bits.crawford.emu.id.au 49MADgsv3932404
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crawford.emu.id.au;
	s=s1; t=1729592022; bh=o7T3ggDWd/F5kuHCX1ncp7Ta/8DpEI2p5RILtO4r0ng=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=Xy87yng0Uz7jalo2f6F+D5NxY//edtgRdctpwbYtg3cMsAsBk+HluLYwAZQ1lN1kG
	 N7vQJlq5rBIW/swBjC4WiRG+yG0dGtfIgRoq7Zc17KDEug85a9LfotFZBRxJVeeA/A
	 S91fw9vJ0hP3+m9uktPOkOUu+cCPwhqYJu7X1uGCkZGfX0rVtGPPOdi+GJMGnzZsy3
	 7K/WW/S5z7e4KzpRU3GB3XqA67/HdQ3JCVO7fseqeWDPl+JoGb0N3KwumDoGoPWpbS
	 o9JfrPNZPnEd7vhm30tHhClZpNAfvQJEVCpCyqyiklmo98WIeIzgnr0+lKiv5M9J3/
	 EH7Tmnkur5tgw==
Message-ID: <6cab565f05820eb2e1a1c55644be057427ecdf2e.camel@crawford.emu.id.au>
Subject: Re: [PATCH v2] hwmon: (it87) Add support for IT8625E
From: Frank Crawford <frank@crawford.emu.id.au>
To: Ai Chao <aichao@kylinos.cn>, jdelvare@suse.com, linux@roeck-us.net,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 22 Oct 2024 21:13:42 +1100
In-Reply-To: <20241022091319.82503-1-aichao@kylinos.cn>
References: <20241022091319.82503-1-aichao@kylinos.cn>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.4 (bits.crawford.emu.id.au [IPv6:fdd2:7aad:d478:1:0:0:cb10:cc01]); Tue, 22 Oct 2024 21:13:42 +1100 (AEDT)
X-Virus-Scanned: clamav-milter 1.0.7 at bits.crawford.emu.id.au
X-Virus-Status: Clean

On Tue, 2024-10-22 at 17:13 +0800, Ai Chao wrote:
> Add support for IT8625E on Centerm P410.
>=20
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
> ---
> change for v2
> =A0- Move IT8625E_DEVID after IT8623E_DEVID
> ---
> =A0drivers/hwmon/it87.c | 3 +++
> =A01 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
> index e233aafa8856..4aeb09f3bfdf 100644
> --- a/drivers/hwmon/it87.c
> +++ b/drivers/hwmon/it87.c
> @@ -15,6 +15,7 @@
> =A0 *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IT8620E=A0 Super I/O chip w/LPC in=
terface
> =A0 *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IT8622E=A0 Super I/O chip w/LPC in=
terface
> =A0 *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IT8623E=A0 Super I/O chip w/LPC in=
terface
> + *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IT8625E=A0 Super I/O chip w/LPC inte=
rface
> =A0 *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IT8628E=A0 Super I/O chip w/LPC in=
terface
> =A0 *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IT8705F=A0 Super I/O chip w/LPC in=
terface
> =A0 *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IT8712F=A0 Super I/O chip w/LPC in=
terface
> @@ -161,6 +162,7 @@ static inline void superio_exit(int ioreg, bool noexi=
t)
> =A0#define IT8620E_DEVID 0x8620
> =A0#define IT8622E_DEVID 0x8622
> =A0#define IT8623E_DEVID 0x8623
> +#define IT8625E_DEVID 0x8625
> =A0#define IT8628E_DEVID 0x8628
> =A0#define IT87952E_DEVID 0x8695
> =A0
> @@ -2782,6 +2784,7 @@ static int __init it87_find(int sioaddr, unsigned s=
hort *address,
> =A0 case IT8622E_DEVID:
> =A0 sio_data->type =3D it8622;
> =A0 break;
> + case IT8625E_DEVID:
> =A0 case IT8628E_DEVID:
> =A0 sio_data->type =3D it8628;
> =A0 break;

Can I just add that it isn't a good idea to use the same type for
different chips.  There are some specific differences between the
chips, which mean that it should have its own entry in

static const struct it87_devices it87_devices[]

even if currently they are very similar.

Even one of the most basic items is that it will report the wrong
chipID in the logs.

Regards
Frank

