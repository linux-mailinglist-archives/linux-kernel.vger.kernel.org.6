Return-Path: <linux-kernel+bounces-379673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E349AE220
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51F641C21788
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0BA1BFE0D;
	Thu, 24 Oct 2024 10:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbstBG1s"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EAA1B6D1E;
	Thu, 24 Oct 2024 10:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729764487; cv=none; b=Alyn9iB8rcLd9jIbm41AITTJV9ew+38XSJgCBkePmgy65wPB+3En98iBpo2gczzxbsjSllf6FXrl7/s91R/luH0fmlcj/FbK+ahQQ3aBZNHuiPOw4AzG/9ZPsFQNMyK1xszGI87/L1vadkoVGIyUJ0vs3VqWo1RtIqWPttCcGG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729764487; c=relaxed/simple;
	bh=hzlha0IEaW1Nx07frspuKMArgqXO8ig0pKR+3Pn/nj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVb3DBf7IP8+K4sf6uP6vX/Lh4VRdLjunKcxIeV/zKn71m54GndqTPtKNuQ4Dh/XlEF4Bjhg1uu8K4suE6PtkIoVzbauRrdJAgAUeXhegYQciaMlXsQ8Nuw0Be0o85AqHCe4a0E6aNKtcTSIuzHTx4dsAtQZplndtk8YQ5AQgmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbstBG1s; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ea76a12c32so458002a12.1;
        Thu, 24 Oct 2024 03:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729764480; x=1730369280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tSl+Y/rK+HFIRKJaawKLaFo3CLHgtxZ0KrIp9WaYT1A=;
        b=bbstBG1sQM83+ASYIQ3hUKUE+NeEznf3D/G2a11NHPT4v/dzb54g+i1lb0yOeh95db
         bJk4wVvhpQLDqiezWNqt2v2y5/NFN0y5msEKmzTFipiIFYCvddjGaG10YgQWvu6Yl+KQ
         n3d5MRPHY7C/ezUrK6oPp71xmHtPPsvPrzP6g+kSKtxEpgRJu9kAiWNifQrotqj0dJeW
         XdBacPW590C3jmxdnd91p3iqQ85+xpmnNt40wCHjiEeTuH/05Z09PdnGiobVnAoqduHk
         /H2hHsih9F2EmTrhavJ48MYeP2UI3KnDXlhrTPAljNm3MrZZcI2QAfDy0dJ5SMtiazgL
         2vjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729764480; x=1730369280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSl+Y/rK+HFIRKJaawKLaFo3CLHgtxZ0KrIp9WaYT1A=;
        b=T3sProSrNylF9WAfGmBhnFl0Hc2m+JzL9luPoHlKYhIAg5GwBoufpY8m7hW2InaKlQ
         MNmW/mgAWysQOxR+skIYuxm+O4esKZAcB/aVvcxFHnV/gkjCEMG2SgmmtW/anKKbKTf8
         MBdZXC2xXLqpsak3Px9EKfbUWlYElUKdzkphbC3u93Hp3+jO+ZhexeL0n1KsQmZGZcGf
         kVkkIB/atkYAoLNWX5WQRDv6Os57FGcq3/CYN0GyH/T+13s5u/lb0y1vpjzWYkI2uhAw
         SupUwkAqN1F0zcybXKLPIfB11x7xW1FEmeTZ5vpBHMMU2LeMVx7RIAKR0jtizIyVTYMg
         5KcA==
X-Forwarded-Encrypted: i=1; AJvYcCUIRJqEa8xOMMzUalfmNzlpgHYnOO3+F8gZDSagCUZa0DtK2WNDOTbwH3DaLHXXva9FvTtVVV36gH7ADoPE@vger.kernel.org, AJvYcCWMWNmp0Iw2e799TsgeG1qbVVLAj8jfR9K7AE3mOjMIfoHBs4sfKIddLU/++yZDaUBHTPI9rFgGyBJH0GA=@vger.kernel.org, AJvYcCWpU6FWFkEe1FCxWD6I5gGAmiLEtAxSVTQHIlXIIVoDi01Iw2IwItXcZ6X1osei2+xBNrrwr7gIixY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHYVjkxv5NikFXZeqMW4d4TwhX7FQsixa7WgxTBqbnUxaW4pek
	201KuvYa/98myXXoEFA4gVBcMSD77nW3H1srTXgsmxoqV0wXClgu
X-Google-Smtp-Source: AGHT+IEB9Eh77+qjn5J4ABuZNPPubVEc2kP8N6TL294hUl8jqM7yDg8rRISlCNZ0vvpfDh3ja8ecfg==
X-Received: by 2002:a05:6a20:cf83:b0:1d9:275b:4ef0 with SMTP id adf61e73a8af0-1d978af8305mr6277577637.17.1729764479999;
        Thu, 24 Oct 2024 03:07:59 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1313fc1sm7683411b3a.41.2024.10.24.03.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 03:07:58 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id C4C9E4416BFE; Thu, 24 Oct 2024 17:07:54 +0700 (WIB)
Date: Thu, 24 Oct 2024 17:07:54 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	anish kumar <yesanishhere@gmail.com>
Cc: perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Docs/sound: Update codec-to-codec documentation
Message-ID: <ZxocelppgHf8D9vk@archie.me>
References: <20241020163706.87123-1-yesanishhere@gmail.com>
 <ZxkgCL2/JtDDJ9N1@opensource.cirrus.com>
 <87sesmn6cz.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IF221fyQHMbx+axn"
Content-Disposition: inline
In-Reply-To: <87sesmn6cz.fsf@trenco.lwn.net>


--IF221fyQHMbx+axn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 10:15:08AM -0600, Jonathan Corbet wrote:
> Charles Keepax <ckeepax@opensource.cirrus.com> writes:
>=20
> > On Sun, Oct 20, 2024 at 09:37:06AM -0700, anish kumar wrote:
> >> Updated documentation to provide more details
> >> for codec-to-codec connection.
> >>=20
> >> Signed-off-by: anish kumar <yesanishhere@gmail.com>
> >> ---
> >
> > The patch doesn't seem to apply cleanly for me, my system doesn't
> > seem to like:
> >
> > Content-Type: text/plain; charset=3D"y"
> >
> > Not sure if that is a problem on my end or yours, but I am not
> > familiar with that encoding.
>=20
> That's something that "git send-email" does occasionally.  At some point
> I remember that somebody figured out why that was, but it escapes me
> now...

AFAIK in this case, when sending patches with non-ASCII characters in them,
git-send-email(1) will try figuring out the encoding, which will often
assumed to be UTF-8. You can simply hit Enter when it asks the correct
encoding.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--IF221fyQHMbx+axn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZxocegAKCRD2uYlJVVFO
o8iwAQCJY7CupaHZovKYAKkFPAzNzysO/MqYPuobRtOUNdqg5QEAsbllnZk7+v9y
+puGMiTFfZ8Fb0O9DxNos1Cy/1KpyQQ=
=hAak
-----END PGP SIGNATURE-----

--IF221fyQHMbx+axn--

