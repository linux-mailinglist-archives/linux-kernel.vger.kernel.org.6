Return-Path: <linux-kernel+bounces-247553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA1992D11F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09501C21425
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628DE190488;
	Wed, 10 Jul 2024 11:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="LYEP9dBq"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65CC128369
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 11:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720612549; cv=none; b=B9ekilv7beK41k4VJtv/naA+7+lIVxzgnCIahi34qB/t5l9nJRnXXT9tnr1SWFSZEiXVPtvn5RI/qEZDEro8UaiYxaSCO1w1cS8Ki0YxoWQquiycuTq9OK99NZNN+LDAba9kKkKRXaGGe3/WfoAteP1uwJUNzWo7m/YoprMjZqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720612549; c=relaxed/simple;
	bh=MqlEv1joaxZu8mPFSuOPK7nh07xOXqF37viVEtgOAh0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pFe0CL6lY10tpmqeCMx2RWwonBmkEX2AAfwNps2wI/58gqViW0/d+Cbg2+bfVD4mRkjh5sHBWe3TGgyGUDT+Hrn1uIEnRD3i8NZr7eaas6giKTF+SR4ZlaIDhtDlxol3NcouY0+tuc75oipTVESIcvwttX+rRyGMWuvNjN6JoDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=LYEP9dBq; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52e94eaf5efso7405345e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 04:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1720612546; x=1721217346; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghyI4s6HTXWaB6sUZPzsUjuCWRGkdOO7Zqu/uA2Ql5s=;
        b=LYEP9dBq3h39Fgr+B4HsQENkD8iamdEAI8eMjwzysUAbn9EgZ48ustSHfj1g3jRhiZ
         Od/ayD+TrcMNOdFp0spqlwXqLSCmIq7pvziYasrFfL6wg4ZxLz958oreImbfK3mPQ7T9
         X77tF8FFnyP+/N4KdqYN2WC5BIB4dUtkL9tqb8tmSv4PRKTPosVGV2sed6gja8WJ6Q9Q
         EDITSJtdL0Km79LffdvyfYv4bfTOr5S5E0Ol20DHggb72AZDky0a2tNX4X7Y+S3o5vCZ
         yjOg44eqbGmIEpA/7HtTSBHK4MLrEe1es8fS8rxRy5lStIVfN+5Nu7TEnUTkLEB4a3C4
         bK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720612546; x=1721217346;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ghyI4s6HTXWaB6sUZPzsUjuCWRGkdOO7Zqu/uA2Ql5s=;
        b=pFzzwQhcn9DjN+6PhkkUvNGaCOop/W2QOSYmVj/NTi0tfv6I19t6v4fTmauIFBolhi
         YTavCRQhwoJMUw7fUWi3vTy72A+Tc7bAt+Lc1t9CYk/ccfrJQch8khFnFEwQSSSBNrJZ
         7YID6COESX87/1RXlTbECMZj4UMUtrHL5Ewha9a+NhuVhzdYLXg1SQoZjqhiiEdFxim9
         xOrL6dTB/jeBLoZTFhTNPin3Q9D4FlPqNbGKnOfEerHQQRi9VLgHSbFIh0+02ZypUMQC
         F11E61O4wvZeIvd2xf/pdtL+j5kBM8i5Y1EZVXYFssfXsZjT2BdFZgT3BI/CxfCsEMSr
         2kzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+UEj94OEYj71cmJIRlVU147qcqmSWmTWVRp6bNqPS4FAOgxrgcsRraUduBPsrbCo2/bNfx8ulJ02d19o3W45E0h33lYen9lFIf1Gx
X-Gm-Message-State: AOJu0YwPSXL7wjW0AxWketN+AoHUNw9685teksri0j9J4zQxynjwk2KT
	nTFwpJkdFCaj8iDpzl5Td9SL1vcu2aVgjkUBn19JBRlbRPB9WjIhak+mNtd/eZo=
X-Google-Smtp-Source: AGHT+IHPdeBfsmIONeQn0bTeJbnTXUm5Q4clpV0sJ9YPMBD7uOMdhJufA1MZEWrigkt6wt/ISI9GPg==
X-Received: by 2002:a19:5f4d:0:b0:52c:99c9:bef6 with SMTP id 2adb3069b0e04-52eb999132emr2837911e87.7.1720612545729;
        Wed, 10 Jul 2024 04:55:45 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:10b5:fc01:cdb7:e0f1:ad3d:8e34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d1668sm247496925e9.1.2024.07.10.04.55.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2024 04:55:45 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] drm/i915: Explicitly cast divisor to fix Coccinelle
 warning
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <Zo5yvk69FB-jEgd8@intel.com>
Date: Wed, 10 Jul 2024 13:55:32 +0200
Cc: jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com,
 tursulin@ursulin.net,
 airlied@gmail.com,
 daniel@ffwll.ch,
 intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <77194DC0-AA53-4CF9-8BDB-93E212B9FA72@toblux.com>
References: <20240710074650.419902-2-thorsten.blum@toblux.com>
 <Zo5yvk69FB-jEgd8@intel.com>
To: =?utf-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
X-Mailer: Apple Mail (2.3774.600.62)

On 10. Jul 2024, at 13:38, Ville Syrj=C3=A4l=C3=A4 =
<ville.syrjala@linux.intel.com> wrote:
> On Wed, Jul 10, 2024 at 09:46:51AM +0200, Thorsten Blum wrote:
>> As the comment explains, the if check ensures that the divisor =
oa_period
>> is a u32. Explicitly cast oa_period to u32 to remove the following
>> Coccinelle/coccicheck warning reported by do_div.cocci:
>>=20
>>  WARNING: do_div() does a 64-by-32 division, please consider using =
div64_u64 instead
>>=20
>> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
>> ---
>> drivers/gpu/drm/i915/i915_perf.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/gpu/drm/i915/i915_perf.c =
b/drivers/gpu/drm/i915/i915_perf.c
>> index 0b1cd4c7a525..24722e758aaf 100644
>> --- a/drivers/gpu/drm/i915/i915_perf.c
>> +++ b/drivers/gpu/drm/i915/i915_perf.c
>> @@ -4103,7 +4103,7 @@ static int read_properties_unlocked(struct =
i915_perf *perf,
>>  */
>> if (oa_period <=3D NSEC_PER_SEC) {
>> u64 tmp =3D NSEC_PER_SEC;
>> - do_div(tmp, oa_period);
>> + do_div(tmp, (u32)oa_period);
>=20
> Why is this code even using do_div() when it doesn't need the
> remainder?

do_div() is an optimized 64-by-32 division and the compiler should
automatically remove the remainder if it's not used.=

