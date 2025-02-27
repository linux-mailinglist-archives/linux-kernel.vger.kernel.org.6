Return-Path: <linux-kernel+bounces-536321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 884FBA47E25
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0CA1885C1D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EDB46BF;
	Thu, 27 Feb 2025 12:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXG4h6oE"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4030C1EB44;
	Thu, 27 Feb 2025 12:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740660364; cv=none; b=DREX822QfhF8495bKbbM4se1oV0ziOg40NPs+sP5pYJVRbUFCT9oDAD4NYhBq3NxaRKEF6RGqXgSBHOBVg+Xjz3jJKfRe8z/gUAX5svirIEN1CD0vVdGTFjVDgYvst/YpBcRQkrMNG3moWc8/jJscQosIFsKQMaqgSFtlH5hNBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740660364; c=relaxed/simple;
	bh=2R1ArvdS0h8l8zo3YCZDPPAlsJYlWBPeKYKdGwtp4kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0eN1uxmrcXyDzFPVM6smb4mPxWpcNDq1x2T5HB15r/jLFms2Cosex3cY31aNl4BYbrxciwOVnUjGFX1+SHTnXF2+B3zQJb56NzlW63vA3hkb2JVTQpJe2zYvnSBqO9iQfpXYHc63yg9+yd97I7o1qyeYrBSHneDcLA+dcaQRP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXG4h6oE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22359001f1aso9902265ad.3;
        Thu, 27 Feb 2025 04:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740660362; x=1741265162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pK2On+0ohRUybB6w7VUTkwNoS6ta8OxzQyip+fzxa6Q=;
        b=FXG4h6oEW4YI1YdQ1qFN5evhFjW3jQ52fjYTu6jfjdDx5+tFlZzQR+mDStwKQhFWg5
         uEaBzjF4kxmma2gZSZ3QQlkulEXT3yHngaICaQ7gUMJODSCDuBcuS/VmhGSFqQCyw8Ah
         vyXtwl4KVXe1cEEl33mWxIt88b0cUqPpARbRbWmxqF9B5Du5zRHR/ajyLp/HKvKDU3UU
         TZfd1A95OM/GFr4DAFq/kZPzn//Pdqb6IVFIR3MxStHljtdMZoG+96tcsOw1rQqyIPnm
         4r3e1f+GbkGYDMw0M1LRCphqtdQYPX7I3027PX2gXhgSSan9nktwJZpv/jW7OyY52ioc
         4BmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740660362; x=1741265162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pK2On+0ohRUybB6w7VUTkwNoS6ta8OxzQyip+fzxa6Q=;
        b=Ezw2+cW6aTqZ8dQr4RCGrKFQSVuZDot4m1Km+qEMto7wtE5kf8KMTrvGLsCmOs6s6c
         yKltC4gFYeFa+JJKTpo3k+/UyjWp7g6f0/TY9jvczSTaG0jZVWdTqJb7+TqZh+wl2bAr
         /3MdHapPzq7kThg9lEmCAhZNLOTZWbA1gQVzyuPz7dqFzlH9Y/DQ1lzBwbC+gwtOXb18
         xRliFABFk6y4o186MF1EEoHv4L49keAKef7+HraPPLb7QEGuC2/nZZtPvX2hYHP/9T5n
         70r+VpXlfNLbjFZfUmPiTu4GhAL7F2Fk8PlisyGGGx/Oh/UIz86e1nbT8nDJoul5d1+c
         9hiw==
X-Forwarded-Encrypted: i=1; AJvYcCVuIfi7SL3fuqHB54vXbEr8Y6Q3vGhKSSrfGGfvuyLdQAQdt0OsImk3GBpMrd7unZfTJY1fuiLYmKk/4ZA=@vger.kernel.org, AJvYcCXxlI+xxvOxpKNR1rTk3P7E5SBaQ7xVbkNyU5AQln2NNJqqMoG3X0yJ7kZ9r/V1Dfn2GeAakyG28ecfAig=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaLON1OzZ+PlkWOCKi8ECc9fZAVcMEAR2xmvVSNecbYmNTiQ0A
	vtMKsweMd9m6KMWJVlvHdEoPVCPVT3wONAHuNs6+WDLDYg4NN6bv
X-Gm-Gg: ASbGncs7M09C+cFeqyxYeIv2XK0N+KTqpge/wHWOIWyRqEfW/qVX+navXogE5DrmvWo
	Qhy6G0t6BUgvEJPVnWUzv0+ld4Y4RgjAxIlQ9Mq/kpckAyYagkpMs5BW9GqRmKg5dU3r11F+5js
	PSaDIGpsv2swEvTwAjL8kVSPC2WU9oo2C3HIl9CuRBrK0E1y2oYVN1hR1m5UTNAHyexExJjBw5n
	QaroURB8xWcv+XUXhKxZqW8hyzS+32RDSEpj0ZdNy55G/PY+odEPO6CSguKhCv4/VWTmvJ59Eoa
	nP3/AApdX4nXAsn+By8kyF67qw==
X-Google-Smtp-Source: AGHT+IHSSKkoAsjkbekJk5vRDfWSXmQM3fU+iFlT0ssIUYLbYp6ud93c7nnj9VVygOLhEfA7S8p/gw==
X-Received: by 2002:a05:6a00:2d07:b0:730:8a0a:9ef9 with SMTP id d2e1a72fcca58-73426da560fmr34484049b3a.22.1740660362450;
        Thu, 27 Feb 2025 04:46:02 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe4811fsm1452732b3a.43.2025.02.27.04.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:46:01 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id EE04C41296D8; Thu, 27 Feb 2025 19:45:56 +0700 (WIB)
Date: Thu, 27 Feb 2025 19:45:56 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Bard Liao <yung-chuan.liao@linux.intel.com>,
	linux-sound@vger.kernel.org, broonie@kernel.org, tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev, bard.liao@intel.com
Subject: Re: [PATCH v3 01/16] Documentation: driver: add SoundWire BRA
 description
Message-ID: <Z8BehLc-D8-dKbe7@archie.me>
References: <20250227111130.272698-1-yung-chuan.liao@linux.intel.com>
 <20250227111130.272698-2-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tORgUmXapR+Hkdsk"
Content-Disposition: inline
In-Reply-To: <20250227111130.272698-2-yung-chuan.liao@linux.intel.com>


--tORgUmXapR+Hkdsk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 07:11:14PM +0800, Bard Liao wrote:
> +  (2) A CRC on the data block (header excluded). This CRC is
> +      transmitted as the last-but-one byte in the packet, prior to the
                            penultimate byte?
> +      footer response.
> +
> +The header response can be one of
                             "one of:"
> +  (a) Ack
> +  (b) Nak
> +  (c) Not Ready
> +
> +The footer response can be one of
Ditto.
> +  (1) Ack
> +  (2) Nak  (CRC failure)
> +  (3) Good (operation completed)
> +  (4) Bad  (operation failed)
> +
> <snipped>...
> +      ::
> +
> +	+---+--------------------------------------------+
> +	+   |                                            |
> +	+   |             BRA HEADER                     |
> +        +   |	                                         |
Nit: this line is indented with spaces instead of tabs, but the table still
renders perfectly in htmldocs output (no warnings).
> +	+   +--------------------------------------------+
> +	+ C |             HEADER CRC                     |
> +	+ O +--------------------------------------------+
> +	+ M | 	          HEADER RESPONSE                |
> +	+ M +--------------------------------------------+
> +	+ A |                                            |
> +	+ N |                                            |
> +	+ D |                 DATA                       |
> +	+   |                                            |
> +	+   |                                            |
> +	+   |                                            |
> +	+   +--------------------------------------------+
> +	+   |             DATA CRC                       |
> +	+   +--------------------------------------------+
> +	+   | 	          FOOTER RESPONSE                |
> +	+---+--------------------------------------------+
> +
> <snipped>...
> +Each packet will typically have
                             "have:"
> +One possible strategy to speed-up all initialization tasks would be to
> +start a BRA transfer for firmware download, then deal with all the
> +"regular" read/writes in parallel with the command channel, and last
> +to wait for the BRA transfers to complete. This would allow for a
> +degree of overlap instead of a purely sequential solution. As a
> +results, the BRA API must support async transfers and expose a
"As such, ..."
> +separate wait function.
> <snipped>...
> +The bus interface for BPT/BRA is made of two functions
                                           "two functions:"

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--tORgUmXapR+Hkdsk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ8BefQAKCRD2uYlJVVFO
o+QBAPwMMA/rLAzqMENvsFlNk6I1zWt7Wow/BWp58VHeNLRTJgD/W2XrK3cGyasw
RabU+5m3DDEwlgfGciPRg0b58bNomgU=
=7wAk
-----END PGP SIGNATURE-----

--tORgUmXapR+Hkdsk--

