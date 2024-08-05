Return-Path: <linux-kernel+bounces-274959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16559947EC5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 478761C21141
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9E715AD9C;
	Mon,  5 Aug 2024 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jv3c2KKs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D583CF5E
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722873362; cv=none; b=o0zAsA2vYpCNsNAsTIxMsjly/Xa3Mi8Rpz7h7UwHfTKAEVcT4sFqpu3B4HU0f8oOVRzxRJ/uSjFeN0haOjGTsiYY3XSlF4yf020mY/3BFE8NCpeAyQJ4IS6bGcdL/rxOIVasbhTFV1nqAMX/OaWAeljhEmx0yXYAQxXxMUMsQv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722873362; c=relaxed/simple;
	bh=O64NYu880rqL2vAe5DF2UI4nW5Vor48k2+RqN8IruA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qRtPUikY/qomhk1cu4+HWQLDVM4yRd6qOySxP1ZDdIH150ICggSW8cVnhcB5Mkm+e4exclpIVCyPWMgQ+QY+BhIOr+GGYEXKL4gXBiTOc0d1agxX54DMRHfBSoWL21FLrEe7CA+TDvKBDAbHXKuwyDKpi0q8UPdOFNi152ZcCQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jv3c2KKs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27536C4AF0E
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 15:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722873362;
	bh=O64NYu880rqL2vAe5DF2UI4nW5Vor48k2+RqN8IruA0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Jv3c2KKsPC6IBcIZ183Z4DuUuGtTgFi60WgbAsT31qQ+WqoDc4rsGT23F63teohMo
	 XpavfzKUCJhiKO5nCGect3NHv2MfhuF7jIWz5tdD77MmWab1NsM4PRNxFom6vac6AC
	 /7HWjc1iKW7ClYCdcFNe/fZ5j4pZusTbWG9sHG2mVG8xasTYWDNkWtHKzED8rwFoPg
	 V2b6u0vHAzIQH2Db2X7i1I18vjHFixdFYNrFFYkjn7Q3BT/VEObVzuwgF7h9mOhag7
	 qtff5UefW1RuzTPm9MYy4e21I3AfM8NhFvbnKcDOQLlG/ywpnnp6IAbMBhAomIUZOm
	 l/0XK7vx3cDnA==
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e0bf677e0feso2217868276.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 08:56:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXhhj8pABe9CfEo3al773fedJsUEPk2qfcLn/8xBn7mXLDlPMHLkCgSxzK9bcdTTRE7waB2jpCg1aOy+RE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA8oAuECN8Q+F7+sJYQi4yeIus5weMJlilr3KeNVrxPOH4iM4D
	EsVBRN26WUeNtYE+IMegwCJNnV2PYb4erxgg8AUnjkNvHfLOIQPJEPe+WQqs7eCFYx6SeJEGPZh
	4A/Mc1hjZqPG3k36JRuWTuORDNwHyK4Wfxl+eSg==
X-Google-Smtp-Source: AGHT+IFhVEa97W19iJiU4YfGPEHP0NCg+Vunle/l1WsPpRgiBJMInv5bwTpraA29Ri76riqt83eESbiXfRb2/Rp2cf0=
X-Received: by 2002:a05:6902:1003:b0:e0b:fa84:5839 with SMTP id
 3f1490d57ef6-e0bfa845b3dmr9644580276.8.1722873361325; Mon, 05 Aug 2024
 08:56:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711-bridge-connector-fix-dbl-free-v1-1-d558b2d0eb93@collabora.com>
 <172130413876.532897.864210015976659933.b4-ty@kernel.org> <8d9e8947-5d13-40eb-a887-06a809174fc6@collabora.com>
In-Reply-To: <8d9e8947-5d13-40eb-a887-06a809174fc6@collabora.com>
From: Robert Foss <rfoss@kernel.org>
Date: Mon, 5 Aug 2024 17:55:50 +0200
X-Gmail-Original-Message-ID: <CAN6tsi6Jz0S=B7yzokb5oHmRt1jYot91bMTrBbVBqdjTG88MBA@mail.gmail.com>
Message-ID: <CAN6tsi6Jz0S=B7yzokb5oHmRt1jYot91bMTrBbVBqdjTG88MBA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge-connector: Fix double free in error handling paths
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 10:03=E2=80=AFPM Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
>
> Hi Robert,
>
> On 7/18/24 3:02 PM, Robert Foss wrote:
> > On Thu, 11 Jul 2024 14:26:55 +0300, Cristian Ciocaltea wrote:
> >> The recent switch to drmm allocation in drm_bridge_connector_init() ma=
y
> >> cause double free on bridge_connector in some of the error handling
> >> paths.
> >>
> >> Drop the explicit kfree() calls on bridge_connector.
> >>
> >>
> >> [...]
> >
> > Applied, thanks!
> >
> > [1/1] drm/bridge-connector: Fix double free in error handling paths
> >       https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3Dca5442ed8f=
53
>
> The fix is supposed to reach v6.11 tree, hence wondering if this fall
> through the cracks as it haven't shown up in -rc1, neither in linux-next
> - should have been applied to drm-misc-fixes instead of drm-misc?!

I'm seeing the commit in linux-next.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?qt=
=3Dgrep&q=3Ddrm/bridge-connector:+Fix+double+free+in+error+handling+paths

It was probably submitted to drm-misc-next, and not drm-misc-fixes and
thereby missed 6.11 inclusion. Let me push it to drm-misc-fixes too.


>
> Sorry for the noise if this already follows the regular DRM workflow and
> just needs more time to get picked into the target branches.
>
> Thanks,
> Cristian
>

