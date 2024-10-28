Return-Path: <linux-kernel+bounces-385208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 005299B33FC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D642809D9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC811DE2B6;
	Mon, 28 Oct 2024 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jvxL9o2g"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5E91DDC11
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730126959; cv=none; b=mi3tnK2UPXO7zldHQ/tZEQ4jMZ1OshGKOeBhWqztx9sIMCOS26GzFc1DsKzGjkyiQSFlNqbXnlCOZbazll9ES+5Dw0Ujmbzr6QSfo6RqSHnVYeC8aMcnbuM2UXedwGbfTLb+UqusfiUqElUyupAtndE/SovhFH5p+Sgc8vTAr4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730126959; c=relaxed/simple;
	bh=Lj5qeQvfVSYPijoJ8KXf22qOzE58rJTQ+nvgoPDQIa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrJOlcoZMK1IXaIEILF89d2eTIO7uDBKlAO2aCKd96gmGvn9gctTBKPgfuDhOxseqwlh1o4zYdOaCI1Js1v9ziHqXgUp/FwBTfuZ9Hz+Z1tZrBWGX+qOUMy+c//lwLc532QrpQgevHgfuR9qI5Po0wy3Ujm45wOEHoG1CG59FIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jvxL9o2g; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43161e7bb25so42811435e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730126955; x=1730731755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CaPYz53ew2gx95k4ULY/j8X206olAgthkt9FCNBp5/o=;
        b=jvxL9o2g2pABUkfB4f9ynx2fp+wRALi7GdU3tQojGKoJ+vAnbnHQLFkXmoXMBS8Sic
         DEiE2lIE0Zt1FODRMwyvJleyNDuZkWQrpH1MoUYcrQWmdfn4Gr0qdBVKjvF85SntRkJn
         lrWcRabN3h1OSUJBKRfhfjFHo+Pi3neODDXtRSt51IqQ3UCJXdKxlXnNMup9rEDKOlqf
         3/PBidkYI2y3J/ITUY/aaC8UKvgUKAQraA+3D/SPdrXeOhpJV/aGZ9evmn4j4Ox1c1vP
         IofesmOcLvi1kCc3w3mIWrzwz93OVbKWt2tbourwe0Q+BGlpw+DpcJ4Edu+Oe9eK5fdF
         NOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730126955; x=1730731755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CaPYz53ew2gx95k4ULY/j8X206olAgthkt9FCNBp5/o=;
        b=UzWIUv/6MRNJU83MeD4DarVcYVleK+5Eg5hLACgH0rivPodPVQWuEj44PDkq28Wb2l
         fKt6FqkTn3hOAqDdHY6TTVjrKAjl7tP2U60gxyMzJP5c0KW2DZgMxgxATl3ZXLtT8c9Y
         DXSRNqPqw5eGpL5iDPEp9RFdtf/uPSmepmjJ++bfdHBLZnGGSQmXjZrhf2rXSGXNGV6E
         BsTO/4RvmxtFinrBHqyEhMlx5+3H8buFkXDO8GLeuazTv/f4whAHp3kuVnVbNwCEjFzn
         0Hee8S54meokgWVu49hDKDSniYAdBgwqNbNI2ccKZsn4C63Hmm+uV5oWRw50p3Con2Nw
         Q0Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXpBGET7zdym2wAAx3QaUHFM/eGjNV2zvvdzJQzg2dAPPWK5+bMINNLCJ6a/CjLS5Ydm17leQPOIxIjauI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyef7dv8JFvFkX7L98TrUsIwKkAHle4VUx9pGlCeJh30BOhrXI8
	QIN5CiotCf+duno/nJLd1OW+wSKSe1Tkhfo/cxPupZB/HH8C1vJmNHpjOztJhYk=
X-Google-Smtp-Source: AGHT+IFxXNoJjvvEWI7EdoBlBRxvjVqId7VO2o8bkZtwJXZ2oUgS7llQBk2awnVf3u386gmvAmYDFA==
X-Received: by 2002:a05:600c:4ec7:b0:431:5459:33c2 with SMTP id 5b1f17b1804b1-4319acacb31mr91712715e9.17.1730126955302;
        Mon, 28 Oct 2024 07:49:15 -0700 (PDT)
Received: from localhost ([2001:4091:a245:81f4:9c1b:19fb:62cb:cfc9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55f689sm142187985e9.16.2024.10.28.07.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 07:49:14 -0700 (PDT)
Date: Mon, 28 Oct 2024 15:49:13 +0100
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Nishanth Menon <nm@ti.com>
Cc: Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Anand Gadiyar <gadiyar@ti.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH v3 2/6] firmware: ti_sci: Partial-IO support
Message-ID: <7l5ok4bufvewoimrecm5pajlqqmqg75rjthivdufoqhphfgiy5@xo7f3rrdr3zs>
References: <20241012-topic-am62-partialio-v6-12-b4-v3-0-f7c6c2739681@baylibre.com>
 <20241012-topic-am62-partialio-v6-12-b4-v3-2-f7c6c2739681@baylibre.com>
 <20241025174204.xwmsn2arcy4q63xu@reaction>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xq2jo632shlb63xp"
Content-Disposition: inline
In-Reply-To: <20241025174204.xwmsn2arcy4q63xu@reaction>


--xq2jo632shlb63xp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nishanth,

On Fri, Oct 25, 2024 at 12:42:04PM GMT, Nishanth Menon wrote:
> On 16:39-20241012, Markus Schneider-Pargmann wrote:
> [...]
> >=20
> > The possible wakeup devices are found by checking which devices are
> > powered by the regulator supplying the "vddshv_canuart" line. These are
> > considered possible wakeup sources. Only wakeup sources that are
> > actually enabled by the user will be considered as a an active wakeup
> > source. If none of the wakeup sources are enabled the system will do a
> > normal poweroff. If at least one wakeup source is enabled it will
> > instead send a TI_SCI_MSG_PREPARE_SLEEP message from the sys_off
> > handler. Sending this message will result in an immediate shutdown of
> > the system. No execution is expected after this point. The code will
> > wait for 5s and do an emergency_restart afterwards if Partial-IO wasn't
> > entered at that point.
> >=20
> [...]
>=20
> > +static bool tisci_canuart_wakeup_enabled(struct ti_sci_info *info)
> > +{
> > +	static const char canuart_name[] =3D "vddshv_canuart";
> > +	struct device_node *wakeup_node =3D NULL;
> > +
> > +	for (wakeup_node =3D of_find_node_with_property(NULL, "vio-supply");
> > +	     wakeup_node;
> > +	     wakeup_node =3D of_find_node_with_property(wakeup_node, "vio-sup=
ply")) {
> > +		struct device_node *supply_node;
> > +		const char *supply_name;
> > +		struct platform_device *pdev;
> > +		int ret;
> > +
> > +		supply_node =3D of_parse_phandle(wakeup_node, "vio-supply", 0);
> > +		if (!supply_node)
> > +			continue;
> > +
> > +		ret =3D of_property_read_string(supply_node, "regulator-name", &supp=
ly_name);
> > +		of_node_put(supply_node);
> > +		if (ret) {
> > +			dev_warn(info->dev, "Failed to parse vio-supply phandle at %pOF %d\=
n",
> > +				 wakeup_node, ret);
> > +			continue;
> > +		}
> > +
> > +		if (strncmp(canuart_name, supply_name, strlen(canuart_name)))
> > +			continue;
> > +
> > +		pdev =3D of_find_device_by_node(wakeup_node);
> > +		if (!pdev)
> > +			continue;
> > +
> > +		if (device_may_wakeup(&pdev->dev)) {
> > +			dev_dbg(info->dev, "%pOF identified as wakeup source for Partial-IO=
\n",
> > +				wakeup_node);
> > +			put_device(&pdev->dev);
> > +			of_node_put(wakeup_node);
> > +			return true;
> > +		}
> > +		put_device(&pdev->dev);
> > +	}
> > +
> > +	return false;
> > +}
> > +
>=20
> What is the binding that supports this? I just do not think that
> scanning the entire tree for vio-supply implies you will get thr right
> property here.
>=20
> Just giving an example to illustrate this point:
> Documentation/devicetree/bindings/net/wireless/ti,wl1251.txt says it
> needs vio-supply -> so i have a node with the wireless supply as
> vio-supply -> Since we are scanning from NULL for vio-supply, we hit
> that, that is a bad choice for enabling io-retention.

There is no bining that specifically supports this as I think it is not
needed. The devices that are capable to wakeup the system from
Partial-IO are all powered through one supply line that is always-on. It
is called 'vddshv_canuart' and the name of this supply is checked
in the above code as well. Yes I am using 'vio-supply', but only to
search for the potential consumers of this supply.
So wl1251 will be skipped in above code at

  if (strncmp(canuart_name, supply_name, strlen(canuart_name)))

Best
Markus

--xq2jo632shlb63xp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd8KHufh7XoFiu4kEkjLTi1BWuPwUCZx+kYwAKCRAkjLTi1BWu
P5akAPkBBA8XP72OHJ8p/zMDU3gXL2huEO4vEwmxe1IyxQoJxgD+JMD6nnbu+xSY
BpaZm8rb1PNiiWmGX4Nzl30WM0rIrQM=
=ak4k
-----END PGP SIGNATURE-----

--xq2jo632shlb63xp--

