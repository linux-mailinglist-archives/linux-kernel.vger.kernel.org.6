Return-Path: <linux-kernel+bounces-448106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30019F3B5E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D759816DE3B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150AA1DDA34;
	Mon, 16 Dec 2024 20:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S2psUm5a"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316EE1DC759
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 20:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381753; cv=none; b=fiA7CDA8h5cgpK7Wvxo+MMzaL0BmvkPmbmiREFkMMoYJONl5Ec2akv+ck4LTL+e7dNosncDoGzfh0aUg+vRTLIHO66c7Kp4EfXCsSfcbLaxl/nRFA7RngaObyv0TjnCGa2CUM8y25FgwDxGtHnA5HrP9bjDIqL2TPCzmK89ivJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381753; c=relaxed/simple;
	bh=9QjWQ7WcKGFYlJPwxvTynGyVMoiDED/7I9tp5nVgQz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMSbRT7zzw9F/gCTXLC7Ihn4MGXyedbfwJWM2KON3B3dAAFSKTLcKRKrt41liAG9Z58SB0QBnRx0VzbwqM0Mlph+OyFJ/I4jOyjnZJslJDD26qK5aMr+Ed4EGiRJs8VTtfnLqtpbtsj2hexvPfyqXdsuJcOL49DMNSrjuwOKUrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S2psUm5a; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21636268e43so55902615ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734381750; x=1734986550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2NwUtcfc/2jNCrLFAC1JPgfazwYnhzpPLv20A5ylj4=;
        b=S2psUm5aXXqAdbZPuuk/1Xn3/k51NKenPIRkmDZ6tMfC1GfLjQQMtooLCGi8ossZta
         KeTpx2tib12CV7JQWaXywEwfuhUixtL/gxQoQHvnfuFEiWs4ZAD1sAyy+1P3XpxBaC22
         8h0rWFGuS/83oQfQfF42RdVruwDeBMizg5BI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734381750; x=1734986550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2NwUtcfc/2jNCrLFAC1JPgfazwYnhzpPLv20A5ylj4=;
        b=jPejB3RLbL+IkeuFwwpJ/If8Xci+kBl8UUVye7Z3hRtKCHH8ltHviqcnkLc39Wjvrd
         PMWA5x364Qtpczyp8rBH2DtWGhtD3YiHs7XqVwN4DQjxmWoMuaQWFUgDJCMlyL3h5BtG
         GI06cRz1IHARS3TgcsILfwQfGhmrXhB0FBvFh0tlnzYo7ZUA91wYqUj7g+EnpuDuTITr
         1mi0cRvVeW0V6nbgT52REGvN2FlwlTfh6BXPKuu0bnGYLBWKk4xHXfpbc7De8bNbjxbd
         s3/S56/4C/muDXFspGwz6+Gw+tHgmwIS6rodNp3th5leqZNqSsgqZD5e7qPGu3jFS53G
         a1fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBMQZbBuVD6Kw0zCAUUjkEG4uc3N9hvIkwEksE1O08YkAdc75tS/fvYyHqMqyiUStJqdcyWlqzNzK/y1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0heLqLmgK29BjOL6kX0EEQdKBsyZVfSnJJDSuf1Tpbsjpg6DH
	johqjuu4y3Dbm7l28YGAFoed3CzhCzCAAGJJ4Kf9QA3q5iHVOP8dfF+Z/RmhNqIOYknDjFer424
	=
X-Gm-Gg: ASbGncujpMdMZIbpaj2oc84n5oXII/o0Op9SrjLzXI7QG2gRC/iGoYJoll7IbtuZ4mm
	MLIo5G2WYRYW+t+AZMO8WVSMq8+DrDx97XEFwadBYHYY1bQ/Lu3w245F7Cpuks8wCxycybhCzQQ
	1QwxLSeUZjpZNLPXQo1eEXJdFrOOS32iuXqqSMYkjkeG6N/zBuhjkbxtdnnAYnP6g9oE/hvm31J
	x9+aoPsSeuuFrjsxaBstSfcFp0eYh1iG6qy/D/IeslCOS9ADIZZuH3qWiGao1DzAkDFndeTMGSK
	BxexeeLCDQ3XIdfXfZ0EBtE=
X-Google-Smtp-Source: AGHT+IEH9KP8TuTjT3ooJ31tzOfp1bm4HNfvmKjAV4SJkku1z7V05AGcge2bgaF/S3IvcPbuKN4PIw==
X-Received: by 2002:a17:902:c951:b0:216:2bd7:1c4a with SMTP id d9443c01a7336-218929ce33cmr190736955ad.26.1734381750174;
        Mon, 16 Dec 2024 12:42:30 -0800 (PST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com. [209.85.215.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1db86e9sm47018055ad.2.2024.12.16.12.42.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 12:42:28 -0800 (PST)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so3393620a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:42:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVTKkev1oePPvJoTeNFDEItsLdqtgCqXTeqheWKvkQDZuRvpTsv4LAwTDUmpa5Z59Az5Qm/j3LeExMW2n8=@vger.kernel.org
X-Received: by 2002:a17:90b:4a50:b0:2ee:bc7b:924a with SMTP id
 98e67ed59e1d1-2f2901a266bmr17302745a91.28.1734381747835; Mon, 16 Dec 2024
 12:42:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211-fix-ipu-v4-0-4102e97aceb6@chromium.org>
 <20241211-fix-ipu-v4-2-4102e97aceb6@chromium.org> <CAJZ5v0gmN6+y2DveaBjSqWpTRWqm9zo2t0uDdvGwnVXcdQ777A@mail.gmail.com>
In-Reply-To: <CAJZ5v0gmN6+y2DveaBjSqWpTRWqm9zo2t0uDdvGwnVXcdQ777A@mail.gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 16 Dec 2024 21:42:16 +0100
X-Gmail-Original-Message-ID: <CANiDSCtF6XoAK6t0XNcT1KjGKHJMMFw8oKr1OSS0jkLuwgL8Og@mail.gmail.com>
X-Gm-Features: AbW1kvaPH50jQcGdHOPoZpEMapRhVX_TvQ-lMubFrgv6_CrphG6dWrwQxfPN8to
Message-ID: <CANiDSCtF6XoAK6t0XNcT1KjGKHJMMFw8oKr1OSS0jkLuwgL8Og@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] ACPI: bus: implement acpi_get_physical_device_location
 when !ACPI
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rafael

On Mon, 16 Dec 2024 at 21:17, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Dec 11, 2024 at 5:07=E2=80=AFPM Ricardo Ribalda <ribalda@chromium=
.org> wrote:
> >
> > Provide an implementation of acpi_get_physical_device_location that can
> > be used when CONFIG_ACPI is not set.
> >
> > Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  include/acpi/acpi_bus.h | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index 2b09e513ecf3..b312a72f48ad 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -43,9 +43,6 @@ acpi_status
> >  acpi_evaluate_ost(acpi_handle handle, u32 source_event, u32 status_cod=
e,
> >                   struct acpi_buffer *status_buf);
> >
> > -acpi_status
> > -acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_=
info **pld);
> > -
> >  bool acpi_has_method(acpi_handle handle, char *name);
> >  acpi_status acpi_execute_simple_method(acpi_handle handle, char *metho=
d,
> >                                        u64 arg);
> > @@ -60,6 +57,9 @@ bool acpi_check_dsm(acpi_handle handle, const guid_t =
*guid, u64 rev, u64 funcs);
> >  union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const guid_t =
*guid,
> >                         u64 rev, u64 func, union acpi_object *argv4);
> >  #ifdef CONFIG_ACPI
> > +acpi_status
> > +acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_=
info **pld);
> > +
> >  static inline union acpi_object *
> >  acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid, u64 re=
v,
> >                         u64 func, union acpi_object *argv4,
> > @@ -1003,6 +1003,12 @@ static inline int unregister_acpi_bus_type(void =
*bus) { return 0; }
> >
> >  static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
> >
> > +static inline acpi_status
> > +acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_=
info **pld)
> > +{
> > +       return AE_ERROR;
> > +}
>
> I overlooked this before, sorry.
>
> It generally is not OK to use acpi_status and/or AE_ error codes
> without CONFIG_ACPI and they really only should be used in
> drivers/acpi/ (and not everywhere in there for that matter).
>
> So acpi_get_physical_device_location() needs to be redefined to return
> something different from acpi_status (preferably bool) in order to be
> used in !CONFIG_ACPI code.

Shall I redefine it to
bool acpi_get_physical_device_location(acpi_handle handle, struct
acpi_pld_info **pld)/

For both the ACPI and !ACPI cases? or just for the !ACPI?

Regards!

>
> > +
> >  #define for_each_acpi_dev_match(adev, hid, uid, hrv)                  =
 \
> >         for (adev =3D NULL; false && (hid) && (uid) && (hrv); )
> >
> >
> > --



--=20
Ricardo Ribalda

