Return-Path: <linux-kernel+bounces-391602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E2A9B8926
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 03:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DB8B1F22E12
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 02:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258B6136349;
	Fri,  1 Nov 2024 02:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieDfyz1B"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E2F17C91;
	Fri,  1 Nov 2024 02:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730427206; cv=none; b=ptrOFAE3ugInowDHmdajOhic3tjwmGtdjM64xRvTgwvn3AjDZSrv5QM4CYUusFbKL3e8lBYM4CKI3rlaQEgVH+Wyorce1wpDT7Ehsu8oc5HYqapBZ3fTJN/Gc+bluyRzSK5r0htXxUR2+58ndPMi2jdXCvstESeds12TZnoSidY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730427206; c=relaxed/simple;
	bh=VmJYV41tllW25FZf3Oc/NCLhuoIMwX9svmMOiic3T7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHn6Kv8dcLEPnJDffizZop4jyrwLTgPxfy6QzNDTp0OdpPF23XMXda3HIJzSl5FEzkwEWp29fmSLooIr5/1aIC+p42UPYd9/YgjqCrgOVGNPMVMdzqSzO7bm6gYq23gbeUYY25CGbV8MfrLVOHVonQCDuYo3Pjxhq4A5tmDn6TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieDfyz1B; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7db54269325so1130042a12.2;
        Thu, 31 Oct 2024 19:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730427200; x=1731032000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rZOZuucoarJhPdgJIizqCWGGAjPi/UbhCrvv3LalGO0=;
        b=ieDfyz1BlsSJSIsmJskkz9pKXaZbAXzsBzf4HohxG1rygzXNK603ohMHrFzXL49q8r
         lpjwv2TfHE4puxvOzPEhWHYxFGdIGu6dwgMdvBYv8CguDZx0PO6fMeMBPM0GtZdBqIC+
         TBK2mgjxyJB8Hj7Ee7cptQRfRWnlWQdbdOi+Mld+gxA+LLlN3VlG2O1SlyZ3lRYR6H6n
         uTIlMdJhpCkbzwwhLO8kUVmh3qdDTWowcxYCmPwrPmj5J1Fa1RqKNgGcNM1N45CPiwS/
         0t/Tn3efsK1socgerQ2TEL4fT9Q692v2IRYXII+XpzuM6Nrs0652nMb4qRv/w7Mlrj7G
         HEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730427200; x=1731032000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZOZuucoarJhPdgJIizqCWGGAjPi/UbhCrvv3LalGO0=;
        b=cocCuKpgceFY/ysbU9Exi7V7Yaqh3rBDnNUkg58MNPnaWIRGwVtnsOFkTRKiSf0ioH
         4bQWkRi64WMnmBX5NpKNTHL/4A+CRSU0KtvwcAObysA2N4cD8JDW4O9Y2bfH+/DPdJTu
         iI320GPahk/iAGp1/sS3T6frVxPdcvqT4e3noUcWAn45svYEFresNAE9ngz5CBbhBbdk
         Dgdt38ZqIP8HDXyrsmGjBMQNcoGJyuDhjYvfW+S6XdIIN/EfSSggWkVLWhHOLzJQaTeQ
         n8NUXUUlazq9m8uubPeuoKbaYJdEU2s2qmpS1OapydD24iyRMG6CkxC8/vToQbOS46hN
         yo/A==
X-Forwarded-Encrypted: i=1; AJvYcCU/oW2bdvCV1uwvhzXUXkaqPYeTi4HZa+wVuGuhyhcBuW5MAcoiPyUN2wleTgwBwH18qDUqMccAo0o=@vger.kernel.org, AJvYcCWt79oCXEvKQHg3HadQrru/7iDivL7+5s92ktRzghS9zimseHZpuqBs4uCzCeSHlho9201Bxf7G5VroJe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRvlBh/2rjBmKERmA/Z5B5QimQkSWgvyJERKTkUir460AWubs6
	vnz7oJG8BIHJr8bH2BOfQzGMUw0G0MnaJxG3Bu2eIHE4G7xjG+yguHIBfg==
X-Google-Smtp-Source: AGHT+IHFxRwrAmlWQSawoDRQWB12YXIyMpZvpxkaSI7FwbamgT8XpysSwshg5o2vXRwnXDG+toxcWw==
X-Received: by 2002:a05:6a20:e605:b0:1d9:dfd:93c0 with SMTP id adf61e73a8af0-1dba556fdc2mr1893780637.49.1730427200136;
        Thu, 31 Oct 2024 19:13:20 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fbfb05asm4067002a91.48.2024.10.31.19.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 19:13:18 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id DA1AA422298D; Fri, 01 Nov 2024 09:13:12 +0700 (WIB)
Date: Fri, 1 Nov 2024 09:13:12 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: anish kumar <yesanishhere@gmail.com>, lgirdwood@gmail.com,
	broonie@kernel.org, perex@perex.cz, tiwai@suse.com, corbet@lwn.net
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH V4] Docs/sound: Update codec-to-codec documentation
Message-ID: <ZyQ5OJM8k1rGog2R@archie.me>
References: <20241031211411.58726-1-yesanishhere@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LF52oUGBAhFpI3TC"
Content-Disposition: inline
In-Reply-To: <20241031211411.58726-1-yesanishhere@gmail.com>


--LF52oUGBAhFpI3TC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 02:14:11PM -0700, anish kumar wrote:
> Updated documentation to provide more details
> for codec-to-codec connection especially around
> the scenarios and DAPM core details for C2C
> creation.
"Describe in more detail codec-to-codec connection, especially on
use cases and DAPM core details for C2C creation."
> +An ALSA-based audio system typically involves playback and capture
> +functionality, where users may require audio file playback through
> +speakers or recording from microphones. However, certain systems
> +necessitate audio data routing directly between components, such as FM
> +radio to speakers, without CPU involvement. For such scenarios, ASoC(
> +ALSA system on chip) provides a mechanism known as codec-to-codec (C2C)
"For such scenarios, ASoC (ALSA system on chip) ..."
> +connections, leveraging the Dynamic Audio Power Management (DAPM)
> +framework to facilitate direct data transfers between codecs.
> <snipped>...
> +To better understand the configuration inspired by the setup found in
> +``sound/soc/samsung/speyside.c``, here are several key points:
> +
> +1. The presence of ``c2c_params`` informs the DAPM core that the DAI link
> +   represents a C2C connection.
> +
> +2. ``c2c_params`` can be an array, and ``num_c2c_params`` defines the si=
ze
> +   of this array.
> +
> +3. If ``num_c2c_params`` is 1:
> +
> +   - The C2C DAI is configured with the provided ``snd_soc_pcm_stream``
> +     parameters.
> +
> +4. If ``num_c2c_params`` is greater than 1:
> +
> +   - A kcontrol is created, allowing the user to select the index of the
> +     ``c2c_params`` array to be used.

I guess #3 and #4 can be combined, i.e. "If ``num_c2c_params`` is 1, ...;
otherwise if ``num_c2c_params`` is greater than 1, ...".

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--LF52oUGBAhFpI3TC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZyQ5NAAKCRD2uYlJVVFO
o5xQAP4j3eAqx7gX+rsm+lIePL79OVwhm3ezNuXCEqibAGrMcQEAilp7lgEL9fP0
L9V8spKCrUVJCs5OPOedR9G3AdRMsw8=
=sXwv
-----END PGP SIGNATURE-----

--LF52oUGBAhFpI3TC--

