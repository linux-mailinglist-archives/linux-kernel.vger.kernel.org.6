Return-Path: <linux-kernel+bounces-559370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1193A5F2D8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC433B37B1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE2B2686AD;
	Thu, 13 Mar 2025 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T99lbSzY"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB2D266EFF;
	Thu, 13 Mar 2025 11:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866094; cv=none; b=NsQ41sScqXDrNwGmi4odPoTkmUjW3wPVomDQ4AJ6it9C+pmiHl4ll5qSJ4+BEzlRhnEeMKbB0VihCAd+YkGPzPwQBWtkYr0ulR/VsOqYVHl+MhFFv56Saw2cXxp0BlVSQg2FJchi9de/sl6V9wrzFvHncn7MQFM7I8FCWZTmUP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866094; c=relaxed/simple;
	bh=HRCaxP9OwMy5ychW2YYKHQ4giguO9PcYbfBZH86NUNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eefc4HmTO5J4lHKCJC14a4xYOO0cGMIidvJSCSeAHrQboHBvwUKwnsfX4mEJ8q/CJ6tzZmQZJShd/p14UC6/2gVmtKSsrNXtpSSypUxkHw7WTqK06HCxoWZm/QqAgP4bAxPJpll+bClS7G099/pp8MQgP7RM1cmlWGERXsLhPoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T99lbSzY; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30bf1d48843so7611751fa.2;
        Thu, 13 Mar 2025 04:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741866089; x=1742470889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V4C5hXr4srfV+Mz6+xfVq0WcJJ/Qc3VuAB0uJHkG5fY=;
        b=T99lbSzYy8YzdhEoi0fRDzvLj4dT/wsWprZF7lkP3s6uvLZOjyeUPH9w7C2qwdM3C0
         lzKHumpua3JAgbFuolC0ztjX6LPB4nvIzdk0cylkP58YfJfkBjBaOKJBRCVuNqvgxPBn
         csJFj46xjBhk4s6o43YKHybuSKGRYjQvsPHmO9nd4KKbTG7D9eGUV/dtE4MWdmfDJM3I
         3bEvs02azZg8SoAn3AHftgqJZ/HWy+LAbeZYZ3i2CwVbWtLmnT/gL6me0cWE5VjM4Fhp
         0tjEdOZuQY9p/Zl934uok9Av+4P7ndYOPolLR5UsTk+61kDJ8a5GmPthD2cjHbirU/Tu
         LfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866089; x=1742470889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4C5hXr4srfV+Mz6+xfVq0WcJJ/Qc3VuAB0uJHkG5fY=;
        b=sGe4v3U0C66tHc2FTYNizeWFCFPQunU91vGQyCrBIp3ZfDOho6YO9MGRPsufQDjY94
         CmHAL1rlz+rmP1atkSSB1aJAVBgiHD4KAZWmSGzUKOjknsOE4UIpyR5WFo0irKPbmgU8
         ipsExyIfVDplGRjaTJOfJpphNKH930gD1VIdSLbWXNRGH3CegVOcsilU1y/VXcpZM1Om
         eYUdCaxSZGdWGf6onnmYrAK0xow14DXRuhuRTIw9GiWwv8iLwJMGahVFSm3NzTL27qbL
         Xv/cYHdt9XDSF9Nyz967RHvAW5obH/Ny5nK0qNYFXKyDJT2aDm4AMBgloC7Q6isiwJVU
         5oOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHilNg+x6ux5lENlOo4w30pjdZ4OAHdzJkjVxCSzYJpApWFLVaho6Ls2AVwSGnR5IF6i7WkktPCSDQONjy@vger.kernel.org, AJvYcCXO0YTncb2rhy16NbNmpRoBPzMqktF1Q/FSzLDvmBhZABcXchPGhhU4oZTY2fTe/HCl6sdiH/cL3klq@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9/4XMV7YLpyh0bpMYboMZkW5DpzrEhXrg+jCKP8poYHaOj+rv
	K2RWnn6sbxIILPFnrv9aIYn3r3KedsOIhdxHv40YKaUgbKSOFH2Z
X-Gm-Gg: ASbGncskFDH6ymDccr1n457oMab/9Bw8Ai/prd6n3Kl3lnrMQL8eagUEHy+8WPQYO30
	+OnGjeUktcz+Oq2jsRYeGgoa2vBz21InVidMbxdel2pYiJiE+TvL7iB8i6EUe6uEEx4QnVeXcD8
	+wZN2/InxPUHPHiuyYrNyJ183gQ3dTY1NPTG54wMRMDCXt8aS5TQiHPUACN/tyibFHyK1beWLz1
	i4IIcvHN68P6oAb17EW5rgzsYlC6d8kDr+NtPGIhliNHdIGaQ1eFSVY+ANCB1ONUkscA+giMo7s
	iOtD6X/YXUuKe63oRax+7m5AFOVcJE0iIx/dHwfIAsqGLgHgG1k=
X-Google-Smtp-Source: AGHT+IHYAcTVEobSZWd5fHdw5v945/PoxdrCLrjNE/olbQ6QBMCp6/3RYUvND1KJ5SK+C5OwAxFWhA==
X-Received: by 2002:a05:651c:221e:b0:30b:badf:75f0 with SMTP id 38308e7fff4ca-30bf44edb16mr91777711fa.2.1741866089262;
        Thu, 13 Mar 2025 04:41:29 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f10ab4bsm1824541fa.50.2025.03.13.04.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:41:28 -0700 (PDT)
Date: Thu, 13 Mar 2025 13:41:23 +0200
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
Subject: [PATCH 03/14] dt-bindings: mfd: bd96801: Add ROHM BD96805
Message-ID: <a73964fea0627b3c6da3679c71e611464273517b.1741864404.git.mazziesaccount@gmail.com>
References: <cover.1741864404.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OkcJcVLHHY7swm7U"
Content-Disposition: inline
In-Reply-To: <cover.1741864404.git.mazziesaccount@gmail.com>


--OkcJcVLHHY7swm7U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD96805 is very similar to the BD96801. The differences visible
to the drivers is different tune voltage ranges.

Add compatible for the ROHM BD96805 PMIC.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 .../devicetree/bindings/mfd/rohm,bd96801-pmic.yaml     | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml b=
/Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml
index efee3de0d9ad..0e06570483ae 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml
@@ -4,19 +4,21 @@
 $id: http://devicetree.org/schemas/mfd/rohm,bd96801-pmic.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
=20
-title: ROHM BD96801 Scalable Power Management Integrated Circuit
+title: ROHM BD96801/BD96805 Scalable Power Management Integrated Circuit
=20
 maintainers:
   - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
=20
 description:
-  BD96801 is an automotive grade single-chip power management IC.
-  It integrates 4 buck converters and 3 LDOs with safety features like
+  BD96801 and BD96805 are automotive grade, single-chip power management I=
Cs.
+  They both integrate 4 buck converters and 3 LDOs with safety features li=
ke
   over-/under voltage and over current detection and a watchdog.
=20
 properties:
   compatible:
-    const: rohm,bd96801
+    enum:
+      - rohm,bd96801
+      - rohm,bd96805
=20
   reg:
     maxItems: 1
--=20
2.48.1


--OkcJcVLHHY7swm7U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfSxGMACgkQeFA3/03a
ocUQWQgAm9YUGczN6CgacCSZnErjSgQCYuK/y9OV4FfBqpphkWPt56mjXc3cHVjZ
shaTupSyJX9M2Dsfw1oNBhXkGNHS63nXRps9HK6ijMX2jQHYsZe9VPDp+gjH6Pck
MgE2Fd66DCEiDPWS0rCkup/nOfuoZS8yoE14JY6g6ML05QT8//3Ew/h9+4Ydteup
Nw5irTyt22kux/J7NbDN0Aj/JTTlTH9xUJ50QRCS60t+fCOr9aiuOskLx6wn4sYG
LcFNF/vXB+ngsO9tucwx1ZZZ/KzmdjraksLDuQaSIzH6NcQJBostQOcpAu/yX0Fc
2uTcO6mJetgEr62/NK5NJgi16Wepsw==
=YxSx
-----END PGP SIGNATURE-----

--OkcJcVLHHY7swm7U--

