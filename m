Return-Path: <linux-kernel+bounces-275504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8016948698
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8805B1C21E1B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 00:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FF31FA5;
	Tue,  6 Aug 2024 00:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gTnRKQfc"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AB610E5
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 00:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722903665; cv=none; b=dcWYVNy3/qiq30N5kJ3CT8QA0+0KMG58I46qPVnsUOp65kHHwZVzY9V7aYn6r4mvRYg6B6/e2+YNo+irxKTDF0s1KjG3UF6pwtM4qQOYtCev8GhtD2Yeo24rtIpKQH1sGvoxFV1OW2IYNkrleG/n3deb3at5RXSC3yqm+Cj8EPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722903665; c=relaxed/simple;
	bh=QTEiV5EySissS04Imas0Yboxis6sc2aPpwvyAWuEF+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UPgqakBQmzq2IXfBteLvWyBAcXH33vt/5JtIwY/Bk7LUIIMloiTtlLuUS2vyfjxZEdJzyy9Y+1KbNfNyPN8nc046M5cKoz4d9G+jJkNVPKX4cBYmc6IAbYGpRN482Se0PndxfSGyGiK91jLYXkhw0CXK6+7QKW7gC4PGVuHlpwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gTnRKQfc; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fd7509397bso105175ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 17:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722903662; x=1723508462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Qs2/y9HQ/jrUn+UzFcaZ4VwrttaCo8JvTXd23mb+HQ=;
        b=gTnRKQfcWa59Kh8bDiDE0LeTteE6o1kuLjJIrj3eBBq5S/TLpYWXRvK8AJeU1xy7Kk
         RBiuY15FCWutJtaHZNYa2jq0HJaA2qBbUwmGRt1kiYLtb0BsuMxOy8PlE4Ak8c/v+xH+
         oGzETuSeQ9WfBRwc3yZm7LU8o0CUIfZ0ylHg/TKDqXVX2LW7HV4K8BZ4kJD2qMuWY0tk
         73gdiis1r84w+9ouwHCUQ36NSGRKKQ+aJ+sk69Kxgp0gGgTI0A/qGpig8P/SqoUwqYVM
         QOmEtSjZSbTE2dm1sAWuuG2DBZl/kqqCV34x+/SOmPRbpgY3vRxj/ECktDAW3dITpgFI
         6/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722903662; x=1723508462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Qs2/y9HQ/jrUn+UzFcaZ4VwrttaCo8JvTXd23mb+HQ=;
        b=KP66OQYdQ0dIA/MxmPkM72Yem3nEpx241cc5MQMu9MNGsXss+CeFCLph6CqjcAIOkZ
         dnRgv7RFSFOQVuqe+AfoNbXwCQz6NPl9KAKeKi0cRx+Vh1jJ05BDOQgi7ignV9l7+tNg
         d/67c0Fvdespf4JAJdwoZL4DzNSaZf8x7Jvgq8tBnrR1lb8ZPt9TCPaihaCwejQCXaB3
         8egkpAy3G4kCENSQTtIE5UtlPY3g5VauMpeWKC3vWwy7Bv1KlimD/4hqx+wv1B+4goo8
         ZLpEU8Z73px4DsOaPY8bdIaQf3iiRgmTOUrFxMnIoghBh3wGqbCZwEaYByvCKs+04P+a
         neoA==
X-Forwarded-Encrypted: i=1; AJvYcCUzpRI5LIJmEmi8rZQUr8WSRQ+pVFkXR3JKF2CwMajMKtM1djoiazpGwIfilPUwdrT7YZvqJV33SPxZFA8tctzBxj6xQ0GIjdpWagtk
X-Gm-Message-State: AOJu0Yzf+UUxTQ7sTvwguQ9603rUiLO2B1aThsN60hDM9OAHw7CSl+OH
	j/h84/+1SuFOEozsNPazgSvW/JkNAvJh3c8SJxQnItRz09AxEMzvJ8f72z2d+g849UtiRlG/eW2
	jW5FNmDPcUyReJ/Nc48tX/6vtKTDEt6F21C3u
X-Google-Smtp-Source: AGHT+IFECJja6NxCCL6J4A1MZdG/03Or7ewdZVOXkjvQVibqjal5y478g7LHRBCBMXRPL4Ey2/0Dvcg036xTCAskfn0=
X-Received: by 2002:a17:903:1107:b0:1f6:8836:e43f with SMTP id
 d9443c01a7336-20077fedf2amr669875ad.17.1722903661410; Mon, 05 Aug 2024
 17:21:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPhsuW4nem9XZP+b=sJJ7kqXG-cafz0djZf51HsgjCiwkGBA+A@mail.gmail.com>
 <26fb7054-f877-496f-b23a-9b6a3d752595@linux.intel.com> <CAPhsuW6+7ULMQFLbmOsBzYAdd8LMV54h_ynfkGDxd_oH6O8cww@mail.gmail.com>
 <CAP-5=fVNfGT+a1RG9-ugKWjQR-83vLdHo-6vCVz=N=CBF4_7ug@mail.gmail.com>
 <CO6PR11MB5635E5844F7C8CB1277C1DF4EEAB2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAPhsuW6Hq4qno1=K9-q17TsNO7S4-dQMCfo_nAQZ7EMdcuP6NQ@mail.gmail.com>
 <CO6PR11MB563550B4AB0D89D6DAC39CBAEEBE2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAPhsuW76F2PkpSpB+V039_0orX9aRwj=++XzM7k1omGVZY-uEw@mail.gmail.com> <CO6PR11MB5635775FADE3BBECD551A7A6EEBE2@CO6PR11MB5635.namprd11.prod.outlook.com>
In-Reply-To: <CO6PR11MB5635775FADE3BBECD551A7A6EEBE2@CO6PR11MB5635.namprd11.prod.outlook.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 5 Aug 2024 17:20:49 -0700
Message-ID: <CAP-5=fVf0K6RtLv-oGMbgr4uGE5hqBT5=EqArZF+_X0Sx3YhPA@mail.gmail.com>
Subject: Re: Some unc_cha_tor_* events appear to be "not supported"?
To: "Wang, Weilin" <weilin.wang@intel.com>
Cc: Song Liu <song@kernel.org>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	"Taylor, Perry" <perry.taylor@intel.com>, "Baker, Edward" <edward.baker@intel.com>, 
	"Daneti, Venkata Naga Sai Dilip" <venkata.naga.sai.dilip.daneti@intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	"jonesz@meta.com" <jonesz@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 1:26=E2=80=AFPM Wang, Weilin <weilin.wang@intel.com>=
 wrote:
>
>
>
> > -----Original Message-----
> > From: Song Liu <song@kernel.org>
> > Sent: Monday, August 5, 2024 12:15 PM
> > To: Wang, Weilin <weilin.wang@intel.com>
> > Cc: Liang, Kan <kan.liang@linux.intel.com>; Ian Rogers <irogers@google.=
com>;
> > Taylor, Perry <perry.taylor@intel.com>; Baker, Edward
> > <edward.baker@intel.com>; Daneti, Venkata Naga Sai Dilip
> > <venkata.naga.sai.dilip.daneti@intel.com>; Arnaldo Carvalho de Melo
> > <acme@kernel.org>; Hunter, Adrian <adrian.hunter@intel.com>; linux-perf=
-
> > users@vger.kernel.org; open list <linux-kernel@vger.kernel.org>; Namhyu=
ng
> > Kim <namhyung@kernel.org>; Jiri Olsa <jolsa@kernel.org>; jonesz@meta.co=
m
> > Subject: Re: Some unc_cha_tor_* events appear to be "not supported"?
> >
> > Hi Weilin,
> >
> > On Mon, Aug 5, 2024 at 11:34=E2=80=AFAM Wang, Weilin <weilin.wang@intel=
.com>
> > wrote:
> > [...]
> > > > > > > >
> > > > > > > > The value '4b433' is for the 'Filter1', according to the or=
iginal event
> > > > > > > > list.
> > > > > > > >
> > > > > > > >
> > >
> > > @Song Liu, do you see different output from some other
> > unc_cha_tor_occupancy
> > > and unc_cha_tor_inserts events. Or, are all of them report the same w=
arning
> > like this
> > > example here?
> > >
> > > Could you please try UNC_CHA_TOR_OCCUPANCY.IA_MISS and share the
> > output?
> > > Please also specify the platform you tested on. Thanks!
> >
> > This event is working, I guess. Though the output is zero on the host.
> >
> > [root@ ~]# perf stat -e  UNC_CHA_TOR_OCCUPANCY.IA_MISS -a -- sleep 1
> >
> >  Performance counter stats for 'system wide':
> >
> >                  0      UNC_CHA_TOR_OCCUPANCY.IA_MISS
> >
> >        1.002497126 seconds time elapsed
> >
> > For this one, I am testing on Intel(R) Xeon(R) D-2191A CPU @ 1.60GHz.
> > I think the issue happens on all skylake and copperlake CPUs.
>
> This looks correct. I thinks some of this type of events are supposed to =
be always
> return 0.
>
> >
> > >
> > > > > >
> > > >
> > https://github.com/intel/perfmon/blob/main/SKX/events/skylakex_uncore.j=
s
> > > > > > on#L4634
> > > > > > > >
> > > > > > > >       "EventName":
> > "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
> > > > > > > >       "BriefDescription":
> > > > > > "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
> > > > > > > >       "PublicDescription":
> > > > > > "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
> > > > > > > >       "Counter": "0",
> > > > > > > >       "MSRValue": "0x00",
> > > > > > > >       "ELLC": "0",
> > > > > > > >       "Filter": "Filter1",
> > > > > > > >       "ExtSel": "0",
> > > > > > > >       "Deprecated": "0",
> > > > > > > >       "FILTER_VALUE": "0x4b433"
> > > > > > > >
> > > > > > > > There are two filters for CHA on SKX. Each filter is 32 bit=
s wide.
> > > > > > > > So the Linux kernel driver uses config1 (64 bits wide) to r=
epresent
> > both
> > > > > > > > of them. The low 32 bits are for filter0 and high 32 bits a=
re for
> > filter1.
> > > > > > > >
> > > > > > > > It should be an issue of the convert script, which set the =
filter1 value
> > > > > > > > to the low 32 bits.
> > >
> > > @Liang, Kan, the following is the converted
> > "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD"
> > > in perf JSON. The "Filter" filed has value "config1=3D0x4b433", which=
 looks
> > correct to
> > > me according to your description above.
> > >
> > > Please let me know your thoughts.
> > >
> > >     {
> > >         "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD=
",
> > >         "Counter": "0",
> > >         "EventCode": "0x36",
> > >         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
> > >         "Filter": "config1=3D0x4b433",
> > >         "PerPkg": "1",
> > >         "UMask": "0x21",
> > >         "Unit": "CHA"
> > >     },
> >
> > I think we need config1 to be 0x4b43300000000?
>
> If this is the value required, @Liang, Kan and @Ian Rogers, should we upd=
ate the
> converter script to set 0x4b43300000000 or let kernel to pad the zeros? I=
 want to
> ensure that we won't break other platforms if change this in the converte=
r script.

I think updating the converter script to do this would be good.
Generally it is a bad idea in an event to use config, config1, etc.
the reason being that the driver may decide to move the meaning of
bits around and then that breaks the event if the bit positions in
config are hard coded. This is skylakex and so rewriting the driver is
unlikely to happen, but the fix would apply to cascadelakex and
snowridgex too, so maybe..

From:
```
$ grep -r config1 /sys/devices/uncore_cha_0/format/
/sys/devices/uncore_cha_0/format/filter_rem:config1:32
/sys/devices/uncore_cha_0/format/filter_opc0:config1:41-50
/sys/devices/uncore_cha_0/format/filter_isoc:config1:63
/sys/devices/uncore_cha_0/format/filter_tid:config1:0-8
/sys/devices/uncore_cha_0/format/filter_loc:config1:33
/sys/devices/uncore_cha_0/format/filter_nc:config1:62
/sys/devices/uncore_cha_0/format/filter_opc1:config1:51-60
/sys/devices/uncore_cha_0/format/filter_all_op:config1:35
/sys/devices/uncore_cha_0/format/filter_not_nm:config1:37
/sys/devices/uncore_cha_0/format/filter_state:config1:17-26
/sys/devices/uncore_cha_0/format/filter_nm:config1:36
```
we can see the meanings of the bit positions. So the best encoding of
0x4b433 in the event I think would be:
cha/event=3D0x36,umask=3D0x21,filter_rem=3D1,filter_loc=3D1,filter_nm=3D1,f=
ilter_not_nm=3D1,filter_opc0=3D0x5a,filter_opc1=3D1/

I wonder in the perfmon json, could we instead of:
 "FILTER_VALUE": "0x4b433"
have individual values for each of the filter values? So something like:

Before:
    {
      "Unit": "CHA",
      "EventCode": "0x36",
      "UMask": "0x21",
      "PortMask": "0x00",
      "FCMask": "0x00",
      "UMaskExt": "0x00",
      "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
      "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
      "PublicDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
      "Counter": "0",
      "MSRValue": "0x00",
      "ELLC": "0",
      "Filter": "Filter1",
      "ExtSel": "0",
      "Deprecated": "0",
      "FILTER_VALUE": "0x4b433"
    },

After:
    {
      "Unit": "CHA",
      "EventCode": "0x36",
      "UMask": "0x21",
      "PortMask": "0x00",
      "FCMask": "0x00",
      "UMaskExt": "0x00",
      "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
      "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
      "PublicDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
      "Counter": "0",
      "MSRValue": "0x00",
      "ELLC": "0",
      "FilterLoc": "1",
      "FilterRem": "1",
      "FilterNm": "1",
      "FilterNotNm": "1",
      "FilterOpc0": "0x5a",
      "FilterOpc1": "1",
      "ExtSel": "0",
      "Deprecated": "0",
    },

Then in the converter script we can just read and concatenate the values.

Thanks,
Ian

