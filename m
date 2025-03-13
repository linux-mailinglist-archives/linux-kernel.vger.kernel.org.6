Return-Path: <linux-kernel+bounces-559384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF60A5F30A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54AC53B7ED1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43003267B6D;
	Thu, 13 Mar 2025 11:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCEAfC91"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10685266B68;
	Thu, 13 Mar 2025 11:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866231; cv=none; b=SA2TXkH9038ce2WL7Jqmx2LA7oHoRpREhZX+ultX7lVgAhmqwa5RepdgxHXZm3/YVsABEJIadmWg8sG/wiCxlhlLuykFVW5wmm1PSBJ9UyaOJ5s+MbT88nW+segxz1rHNouuzT3SjgjuC9p+YkA+a4tu7iiocp7kezmt4k/kybc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866231; c=relaxed/simple;
	bh=ZNYfQ19vTBnzE/WTi8zkxA5G+AFtaPRYdNhwWvpmJFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LyrdWoxJA+6vqBw3/GFWHfeTxKOAvs8PHiNZXwa421brpYJngolPN+V8idvQM5OfmGcyNC45vWzjfJ4qFq6/59bZZizl5USCuWzcG3rMff7iKTMjclMU9GHQsE8MHU9nA+iKVCba1UNabZtWv/PMZGBsYA+HchjztTDQWQg1/H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCEAfC91; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5499c8fa0f3so977023e87.2;
        Thu, 13 Mar 2025 04:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741866228; x=1742471028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mkBnt/ne9ku5/pujbDTO098FWRUmVkIywxFkO8c7LN0=;
        b=XCEAfC91ByBbA5iqtwHc/nOEFVf1jw//yeyiFEAJXr5fCYRWVCFuS5IGRi3Tdmh+o4
         z8rxnqEysx1Nc1JLcM+vQ4oNhvGPddvTYT5UspbYFhh+gdnNZhqR1OlHk4Q/FAZE7WBy
         m5gpgHF3mXcTrj4I6sM0Eg9ANCqB70o9l0OGOGVW4wujAYgn+31m13jIIfgzAAIO2srM
         qDZZQhwVRrn4cOvFJomz1LXCjVh84ehvat0FFrzLDWRHQRzdFi/CJ7r2RnuDMctM5ojX
         FCPOk8RoQXqVmmg1ZzMuyf1ll0Dn97NsJR9nncRIEJKxjvYBFaSzRrgECU8BvdUJ/4Ed
         6wOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866228; x=1742471028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkBnt/ne9ku5/pujbDTO098FWRUmVkIywxFkO8c7LN0=;
        b=KUkzOmYhT7yV8236ExnC1q4ehHqhPLsbk56SWTsYbeXTjiF28BR6KJO/wUmvI+NX6t
         B8QzhV05/p1kJjJOOPFCRI/nUE6L+ICe7dFDojSoXVhNbrutUQddz2O9ll0b/Q/zL5ZM
         SAS+U8455FeQadXYRLm7w/hLw7cI52muYvUHCOr0KnijA2o5vBJH7E+cpaDVxGhWXfzk
         IsBTD8vBAtJZ0QoLuhf/05fSV5YAYdAIco1HvGPWIBoMox26QGT8IUFTj0+fq/tA1imy
         Pxedkys9zyTzs9yYQY0MkRCAQhFHYV3NFazO3DOT27Sl3LKxMgXH9v/aTbAXIC/PdzmM
         s0sw==
X-Forwarded-Encrypted: i=1; AJvYcCWSisToZ/m1c7QJpn64GUeFLin34AOfTV1b8UujSby3VeAK1tuW/1Q6wXglhJhqslcCMGY2jpa3Fe+J@vger.kernel.org, AJvYcCWrcE/SYTrMbaTuvkXGEOirwWUwduss4a70ocqd3901j35Y0mX/P3ZHDBt5bxbanMeAUOoOrDWcfvdYsTDi@vger.kernel.org
X-Gm-Message-State: AOJu0YybX3cjywbPT39WvK7wuWiCm633alnb55RHtOk609U4/5eaAECO
	K/GfOzby9dWIHO79hBRCpQoTwqERf61dpDCIEfg7BPGt5tfwPMSXs2YlkA==
X-Gm-Gg: ASbGncuPJn9HVuFODDcoy+gobWgi69rZ8SZU/n1TNtKjlDBzmxp3J/fKmpLStyl+D2t
	GAMnSOvmQ+FQgeihkgWSGgZRvLsgiNQqGFLCch4/xx3NeX4gt2NQGK0pjohY39ZbWyXa6SnV1X+
	+8+7tM42RCrJaTYgPTBlEQ5WAFKiaQmeug0BBPBpQulNNOAxMTNb6V5xYF3qrTKtnaJVRED1lgB
	oWXLkHqKsC2DRDe7O7HgX+GwC8mkNvq9eSM43LGebyosf8o4NholIBEzcX7ZFXN+pBktocTVNuJ
	KKjZ3IuN4fI671ApscLvkKtENkFdFndmoWrHSPc90amMY+YFxY0=
X-Google-Smtp-Source: AGHT+IFjF6jMeRcFwO9EaoNUJajlCeOmUBQB+l0pW+KI3fwSSrR9kFoKUAJEF4qUiNYTDeVYZZPT0A==
X-Received: by 2002:a05:6512:b84:b0:545:f1d:6f2c with SMTP id 2adb3069b0e04-54990e5d4c2mr8714760e87.18.1741866227946;
        Thu, 13 Mar 2025 04:43:47 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7a81afsm189440e87.24.2025.03.13.04.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:43:47 -0700 (PDT)
Date: Thu, 13 Mar 2025 13:43:43 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/14] MAINTAINERS: Add BD96802 specific header
Message-ID: <cd62e85b2d7e7c8ad36edca0229019d6e6bc262e.1741864404.git.mazziesaccount@gmail.com>
References: <cover.1741864404.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zUuIGOnMsVdPAjjC"
Content-Disposition: inline
In-Reply-To: <cover.1741864404.git.mazziesaccount@gmail.com>


--zUuIGOnMsVdPAjjC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add the include/linux/mfd/rohm-bd96802.h to the list of the ROHM PMIC
specific files maintained by the undersigned.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e0736dc2ee0..973f0e06b2a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20599,6 +20599,7 @@ F:	include/linux/mfd/rohm-bd71828.h
 F:	include/linux/mfd/rohm-bd718x7.h
 F:	include/linux/mfd/rohm-bd957x.h
 F:	include/linux/mfd/rohm-bd96801.h
+F:	include/linux/mfd/rohm-bd96802.h
 F:	include/linux/mfd/rohm-generic.h
 F:	include/linux/mfd/rohm-shared.h
=20
--=20
2.48.1


--zUuIGOnMsVdPAjjC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfSxO8ACgkQeFA3/03a
ocURBwgAkj3dFZmJd2ZcP//BK+LRtwLqsF0IPSjWhqShDei/H658nfs2nIPLIFVl
dhx3nEFecntFIMWlmkSQb4aVrHbcyuPIUDPrhXyAp8zeVZZ0oj2aQfULOMrRt0RC
bMvyvWL+r3Fm5zN4AUsfURpewlpjK0HzW2/Go9HOIYU94/BCZPUFeTDAgPhf1YXA
W4S2jhnVbzkeRLWMj4i905S5zoP8/5YQDvBoX5uC8zExhepNzxuZh6+qjC50xCg2
LPcwVcdUDLkPht+REZpsOh7xj7dUYpkP6VLvfp1WCp2WwG0PeP6dsBujcA+zSa9N
s/bdAEtUQNbgpaP6mE0WVZrWxvEvRQ==
=W6Me
-----END PGP SIGNATURE-----

--zUuIGOnMsVdPAjjC--

