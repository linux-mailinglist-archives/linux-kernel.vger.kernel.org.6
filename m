Return-Path: <linux-kernel+bounces-186926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 940828CCAD8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 04:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25F22B21116
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 02:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB6412B151;
	Thu, 23 May 2024 02:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/1kQTgp"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D91E1852
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 02:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716432687; cv=none; b=M3fJMBgTNT4jtQgGA9B5ij2NSnLCS7pgAIH267HCGD/ViA+kKOmTfPujTG2Z1Dyg4cTAYviP/bbWrW58MtNna8o3LI78F4GW4sOUSuF6Z0zJRjCZM/oI09F5+BjXw9bA54o7ofMpGZ5D7YkzfYBnjgPSMmIv1gx1/GqYKuF6/4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716432687; c=relaxed/simple;
	bh=v5LuDwEZakdwbwY0ym0Hwpmt3ZIkNDD5vuPYxuRQOvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lrccdwKHUQivsGatovCNOufFcD1FQCicKtSLYM92uYXG0j3jk8SV/MNLrbHYyMYaqDeTnToDH0HkwwtmrIjRq5pqnnT8zRxjZt74EgaEO3Hz8CItfNPUMxhVIdxoTiex3TZ9AD/d0KDaKyMPcK2gNeetfR+OXu5hxP6DMsawOCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/1kQTgp; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-df4d7babf3bso101199276.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 19:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716432685; x=1717037485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5LuDwEZakdwbwY0ym0Hwpmt3ZIkNDD5vuPYxuRQOvQ=;
        b=Z/1kQTgp4buk9ivXL+KOzisMJeJHSA187sva6E3IpFspqBjbyyDmGZDmBPZD/rQh4K
         hRs3Ty35ftpTx976fvOvEahOXbDA4cpZQkf/GUFXK15hJIQezLg90YW5tqoAttjf149+
         F2VaxH/cQ/3AocUGGT1oOsk5xtZN/xYa4rJc315cQVVyzLWdXPVv+x/8UkBxJT8A4Lv1
         Hxsb0kcWOsX8gGSNyrg6UDIvbREzwry3XnMzxgUPIgukfC+hlT992tw0WwsBT3W41Oq8
         IIa2jrDq+3NqreTLLWciE3pTjVnkhudzAiDfZOnbyd+w+KRP+f4RlElVXuCEDw8s0Gay
         GhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716432685; x=1717037485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5LuDwEZakdwbwY0ym0Hwpmt3ZIkNDD5vuPYxuRQOvQ=;
        b=SjID9ttE6cN+zjqbvI5BSNpJCfG5sP+Ou+8fat/gx3+IuQoumSwhtm+2KEizz9Smul
         FmxtzR1qJXkyX1XV/eNo9k67UedPas8M/3lEfRZED4eeURTuR/r/Azwe6f3ze6aIYAhQ
         8wWB4vxR6rjFL6CoO7EZH5SJasLzxAteIFxLscy700OHKU2Gi6gKx5h4Vms0FW0Dqu1B
         HpF0VNS+hDlbwu4zbJUMwzPV6uRz66Z/g0UrR0wghoPwcOmNqa7yh4eK4HhsNVIigJCO
         ocs8q3CMvbbIJ2j5tKsnu9l81JEFAYztjwE7V8nFSumkZeErwKjT2Ug881ixFzzGGQjw
         SuCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy74m8lz7JS0VXv4lvf1Lpwt7WA9+UrAfoyqln+HXdPah5PhCenYB9lmK5Gfi2XrL+Mej8YrLIrkvwuNQ0ksRZjsDz7wDSg0cmpLOH
X-Gm-Message-State: AOJu0YwkYO9fRsNLu2zIhAIXGf3ARvdmdb0p6JfIiF6/gGu5ec3ApkNO
	DhcErehMmHDqAzikGCUcpu65/uQnqQtexoYOUf3VnEvv/fbKVsVirZCt+oOcmgamZg/r2pMCnWR
	GkHd8bLPuMUyINFMeOGddJYs8hKE=
X-Google-Smtp-Source: AGHT+IGoGrlyVl36Z3U/uNce2TSp6L62rcU3gkTHLc+sbhgiwRZ9seU1gNOO89339GRoQiUoYwsYHFD13z2NjWmF818=
X-Received: by 2002:a05:6902:2003:b0:df4:d863:93f1 with SMTP id
 3f1490d57ef6-df4e092c8acmr3589932276.0.1716432684934; Wed, 22 May 2024
 19:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fa885eca-d7e6-415a-8a08-9103b002c6bb@amd.com> <20240521051140.30509-1-rinoandrejohnsen@gmail.com>
 <17782a6e-db84-4c20-874a-342b9655ffc5@amd.com> <CAACkh=-B-jH6g7KY7Nn_7Y_+gHPQ7G5Z5AZ0=a=_ifjcmsorcw@mail.gmail.com>
 <86410711-9b88-448c-9148-109f81b1ca55@amd.com> <CAACkh=9hY7eg_uuH7Psm=XJfSzwQTvzs8bvOXQ=wwkMPrC44SA@mail.gmail.com>
 <666e36b7-5379-46ef-a16b-00ec499fb42c@amd.com> <1XiLpoWd2E_COrHNl9BYkmCXkUKK6Bv1wibdFxiw3Vi6AQOPAIhrIMPNEZmmKAp9yxC8Er4DEMqOqjshMgRqtpV3UkS7MN2OjCsDjllvdRE=@emersion.fr>
In-Reply-To: <1XiLpoWd2E_COrHNl9BYkmCXkUKK6Bv1wibdFxiw3Vi6AQOPAIhrIMPNEZmmKAp9yxC8Er4DEMqOqjshMgRqtpV3UkS7MN2OjCsDjllvdRE=@emersion.fr>
From: =?UTF-8?Q?Rino_Andr=C3=A9_Johnsen?= <rinoandrejohnsen@gmail.com>
Date: Thu, 23 May 2024 04:51:13 +0200
Message-ID: <CAACkh=9RBVwX1-ENki9XiscH3XYzw8buab8ZFTyicTn8Yc84oQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: Add pixel encoding info to debugfs
To: Simon Ser <contact@emersion.fr>
Cc: Mario Limonciello <mario.limonciello@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	alexander.deucher@amd.com, Harry Wentland <harry.wentland@amd.com>, 
	Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
	"Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Hersen Wu <hersenxs.wu@amd.com>, 
	Hamza Mahfooz <hamza.mahfooz@amd.com>, Wayne Lin <wayne.lin@amd.com>, 
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, 
	Tom Chung <chiahsuan.chung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looked through the patch series from Andri Yngvason and that does
exactly what I wanted in the first place. I think that the patch
series should be encouraged to be merged in as fast as possible.

For the patch I have submitted, it stands on its own, since the patch
series from Andri Yngvason does not include anything in the debugfs.
This means whenever or not the patch series gets merged, at least
those with an AMD gpu can figure out which pixel encoding that is
used.

Rino

On Wed, May 22, 2024 at 3:40=E2=80=AFPM Simon Ser <contact@emersion.fr> wro=
te:
>
> On Wednesday, May 22nd, 2024 at 15:36, Mario Limonciello <mario.limonciel=
lo@amd.com> wrote:
>
> > > To be perfectly honest with you, I haven't given that much though. I
> > > used the 'bpc' and 'colorspace' property in debugfs, since I could no=
t
> > > find that information anywhere else. And since I also needed to verif=
y
> > > the pixel encoding being used, I added it where those other values
> > > were. That made for a simple and easy addition for this property.
> > >
> > > If you want me to do this differently, let me know. And please point
> > > me to the standardized DRM property where I should expose the values.
>
> FWIW, there is a patch from Andri to add a similar (?) property:
> https://lore.kernel.org/dri-devel/20240115160554.720247-1-andri@yngvason.=
is/
>
> The patch also allows user-space to set the "pixel encoding".

