Return-Path: <linux-kernel+bounces-316013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EB496C9D8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 23:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94B92B24D75
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43ADA1714B0;
	Wed,  4 Sep 2024 21:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEtsSElq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DA182863;
	Wed,  4 Sep 2024 21:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725486845; cv=none; b=QLEsjFqdRabpuavbTfjjCAL69O8ZVjj0X6awCMge4AoN40DMvcZHrCXoYUuqVWHYNNlhHilCguNRtEHwZnXnTP3yjnGumWHZoihMge1VZFpiA4+S7LXviwqEVnn51X6wRj6EDfppYGiolXzvdYXzLq/E3Z5GQDOUUtHDdDsZXjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725486845; c=relaxed/simple;
	bh=WQGT0az1UtZKAyjocEFQySCC7X1+6XVscg88QX6JZ8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T1SWynVtGGG3RjdLi0mX6omhoESyLnQKb8BqvjTQf2Qhn3U/Hhq0wLsd8AK6WF/UEd5N61PBG/K+bZwfgoYTuA4TwuJxZTtCwAA7FefD3Va4YcmR/SFFjrtJKDLT+CbKwfq493JRzhGGdwu16BuF3yZcIGQS3spgexcLE5MDPsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEtsSElq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136EFC4CEC8;
	Wed,  4 Sep 2024 21:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725486845;
	bh=WQGT0az1UtZKAyjocEFQySCC7X1+6XVscg88QX6JZ8M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dEtsSElqvByjkylxgPzazxqhN8tsXyMVOFGXXHfAPJxFtbk2XVY9iIjgucmt2a4uE
	 Xbz8gT38JFVfidveqF55iCLxRDJ+nRr8wmmKe6tKJQ6CAWItxqURLFwGfDcvgZCxS2
	 k9JAdIfCWVIR8UNtujg5lYdEYWtGsYIT8a3+oNXQyYuDzCInDWbn6dIcvANMl7cu5I
	 wXDlfFM7OugLzF+VaOVzrg+6X78R0JVl2cXHHMn4RdysWTVZPHMdAbQcQpHZSSFWBe
	 SMPXI1oPt2fkpcCscDyxFeHzwbrM6GDionvFfu7uzHf7VGU3FLJOcPemkh/tUm4NdI
	 Dnpt2P+WO4lJg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5353cd18c20so24250e87.0;
        Wed, 04 Sep 2024 14:54:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVP++Xm42u0OXxd6bixvfUp7k7XMglyw06FK2qZzljD8M1Cw8y+ivoL74Wg/L7jYGI02CBop9LI1ZJz@vger.kernel.org, AJvYcCWLQWe8BN+nGyP90PPRXMXPPzbY/Di5wSV70f6DQ1FuCuTvSoDhXozgqWqQ7mUHR7A2nx71/cuo8e08WcXO@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr0F80MiXxM20MR5vERGkDpQU3QnHyAsJ0DDH1Q6wNSOKXagD3
	6a66CvCdydgR/y2xuttrbf1+tSXS7G57fyW6HalhkSPuzJQZzQ5XT8ZAiV135W9CnfGGU87iC/q
	dVo2fCBmYGWyhbom0ns0Wn4yGxw==
X-Google-Smtp-Source: AGHT+IENGdReI5cWKKwzXWhbizx0hjjMopi4qZGvc7fRxu4fg2NwtVwFHhDDdUthpBGWdIbju6x3EhNVQMf0ANFHUrI=
X-Received: by 2002:a05:6512:3e17:b0:52e:fefe:49c9 with SMTP id
 2adb3069b0e04-53565f23a97mr3005490e87.36.1725486843420; Wed, 04 Sep 2024
 14:54:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903200753.2097911-1-robh@kernel.org> <80c61f1d-5bae-4288-b868-b25d48d679a6@notapiano>
In-Reply-To: <80c61f1d-5bae-4288-b868-b25d48d679a6@notapiano>
From: Rob Herring <robh@kernel.org>
Date: Wed, 4 Sep 2024 16:53:50 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKxafEK8K7pmqyqdyRUQ53WRdJBsmcDXRtaU7JfkjNgCA@mail.gmail.com>
Message-ID: <CAL_JsqKxafEK8K7pmqyqdyRUQ53WRdJBsmcDXRtaU7JfkjNgCA@mail.gmail.com>
Subject: Re: [PATCH] dt: dt-extract-compatibles: Extract compatibles from
 function parameters
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 3:42=E2=80=AFPM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> On Tue, Sep 03, 2024 at 03:07:52PM -0500, Rob Herring (Arm) wrote:
> > Various DT and fwnode functions take a compatible string as a parameter=
.
> > These are often used in cases which don't have a driver, so they've bee=
n
> > missed.
> >
> > The additional checks add about 400 more undocumented compatible
> > strings.
> >
> > Cc: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> >  scripts/dtc/dt-extract-compatibles | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/scripts/dtc/dt-extract-compatibles b/scripts/dtc/dt-extrac=
t-compatibles
> > index 5ffb2364409b..13ea66d49e6c 100755
> > --- a/scripts/dtc/dt-extract-compatibles
> > +++ b/scripts/dtc/dt-extract-compatibles
> > @@ -46,6 +46,15 @@ def parse_of_match_table(data):
> >       return match_table_list
> >
> >
> > +def parse_of_functions(data, func_name):
> > +     """ Find all (device|machine)_is_compatible() arguments """
>
> This comment looks outdated.

Indeed...

>
> "Find all compatibles in the last argument of a given function"?
>
> > +     match_table_list =3D []
>
> A better name would be compat_list like in the other functions that retur=
n lists
> of compatibles.
>
> > +     for m in re.finditer(rf'{func_name}\(([a-zA-Z0-9_>\(\)"\-]+,\s)*"=
([a-zA-Z0-9_,-]+)"\)', data):
> > +             match_table_list.append(m[2])
> > +
> > +     return match_table_list
> > +
> > +
> >  def parse_compatibles(file, compat_ignore_list):
> >       with open(file, 'r', encoding=3D'utf-8') as f:
> >               data =3D f.read().replace('\n', '')
> > @@ -60,6 +69,10 @@ def parse_compatibles(file, compat_ignore_list):
> >       else:
> >               compat_list =3D parse_of_declare_macros(data)
> >               compat_list +=3D parse_of_device_id(data)
> > +             compat_list +=3D parse_of_functions(data, "_is_compatible=
")
>
> This pattern seems very broad and bound to generate false-positives. That=
 said,
> I glanced over the results and didn't see any string clearly wrong, so I =
guess
> it's fine. There were a couple suspicious strings like "B5221" but they w=
ere
> indeed used in the of functions, so it's working correctly.

Originally I had it more specific, but ended up here. I even found one
I didn't know about. It matches of_flat_dt_is_compatible,
of_machine_is_compatible, (of_)?device_is_compatible, and
dt_is_compatible.
>
> > +             compat_list +=3D parse_of_functions(data, "of_find_compat=
ible_node")
> > +             compat_list +=3D parse_of_functions(data, "for_each_compa=
tible_node")
> > +             compat_list +=3D parse_of_functions(data, "of_get_compati=
ble_child")
> >
> >       return compat_list
> >
> > --
> > 2.45.2
> >
>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>

Thanks.

>
> On a related note, I'm wondering if you haven't had time to see
> https://lore.kernel.org/all/20240729-dt-kselftest-parent-disabled-v2-1-d7=
a001c4930d@collabora.com
> or if that patch didn't make it to you somehow.

Sorry, it's outside what patchwork catches and I tend to miss those.

Rob

