Return-Path: <linux-kernel+bounces-182609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7691E8C8D3D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 22:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312D9286977
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 20:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B14513DDB0;
	Fri, 17 May 2024 20:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HulzHGIQ"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FDD65C
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 20:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715976939; cv=none; b=GKc1OFD7PfZULcEC9vEOkDk/i6QqIuPSemyZ6bKRauWKWQY+dxd5xlRQsee3DnWSmWF2QMDxIJJ+zcIDFChaKZluNdfLH0tT8/rDwZTa562mlAVSl6qaLF3bBPQ49azBBMjMmhwlP/KXtlVh0OWnGsUmJU7WNXCZLZL7YLx2EFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715976939; c=relaxed/simple;
	bh=ykUDFqsAIBfRfyHN4MK+4Q/IxocT8Qko8p26kQ1V0o0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rYXBTk/W5niAI1Db6rG8sqbzzN/rBYrtB7fiMAHqxz++HaMu5Iq4BQb3TQF1144lzRYXHJqKdK2zrqqncgXpr2yXXl1y3WGRdjDSzI20i1fnZmG6gRroJoOOZk0Zl/O4mZIxjcD5Fl95nDBPF2jxUfrhcQ3TW82un0hztZwyuqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HulzHGIQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ed835f3c3cso22320735ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 13:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715976938; x=1716581738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfVKM6yCHTHqqF0MjeIKbFzobNgOfi1RcCAO0pIjbd4=;
        b=HulzHGIQVr9Shw//WVOJPJPMj6Bq0aCU+UQf6mkIQ2aAF/tiezpofo4RrUgolpbdc9
         oXiJqf9kwfIfauxkqMWlrgvmjHjrS5M23g6rArjQfrIPJAaq/dJhJC4inlpI7ifr+zu5
         fgt6uk1Fc1WmToxNR6eWVehKGAm3YYgt63yyReAvEBdlE2uk19tOVP/3oPX88nAyQtKK
         6hgNq8XSqK9RJeB7BUCEpqULsO2eDyTwyT8wN1TUz/7/wKUQhOdIq7dzzP2alEDfdVoi
         zHffs/R77aievs2P9LYOtVxBgDuMLZ1bzBaOoJJK3T5kjV+kiZMKiwWL6n7Y8x6lH2ie
         a9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715976938; x=1716581738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfVKM6yCHTHqqF0MjeIKbFzobNgOfi1RcCAO0pIjbd4=;
        b=MfgX8ahm7Wz2E3DzBIXp0WFQIdFE2F2uk8p3t+a1L1m7Bb2nXNVycD5R9dC95dyEC5
         4/0D66ODWr9ct10x4t01NAWt0A7SUg7l9Ue5FIDoQubq3WwfGV0lRkC/mOwNXbY3uvRD
         TnaJCUaPwXbke8wyUN00hU+kAubIsGcUKPx//v3hdTNWimm0DMF1C27+Y8AuE3gNnRWt
         v+jCb5tKZhbqwhfKaAIaQf24yYiEdwhJ1KZsl8ekZ+UVW0vZ5vntQ1ie1GCNrPfnSlWw
         AvkoBLLAraDvJ7o4lsl/l86oh92gLD78ZETuRFgO1HyTWTFn59R1oOG6y2UjhOkEXqaB
         CVmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUITSZPAqZig8qqNur4qBtys3TJE53QivjK7ZvQ7oelG/sN/J8rSw3+ivqpBR38PKHG2uh7M71pua/nTisuy9xsPsUMbk1t5oq7WmWL
X-Gm-Message-State: AOJu0Yz0uhLDtFYnZ83vCmyyhVlnmTSDSJ2xJnAxnGEVPa/kgxMpKb55
	1SCuqUugFbKUVvYvaUgclLEozgSRsPOy2PH3DsKPfO0Z7w0HGRa1T/5en8hmVTYTXJ2rnDIY7ZO
	mmm6nZQsJ5bE4Dd+eTWckHwv6sJDY/g==
X-Google-Smtp-Source: AGHT+IFZwP6rWy44FU4rq3UxXiUaAdkE55laBfEUdUNPOu8ek1f785nnafJHyUKHdP0NMIfhhm7Dg4hKjJktCEChsrs=
X-Received: by 2002:a17:90a:7d0e:b0:2a2:ba9:ba61 with SMTP id
 98e67ed59e1d1-2b6ccc72e91mr23681441a91.34.1715976937752; Fri, 17 May 2024
 13:15:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516115721.1.I8d413e641239c059d018d46cc569048b813a5d9b@changeid>
 <9dd1cfd1-fe13-4434-a7cc-e14113dcaf53@amd.com> <CADnq5_NGLrrFmFHFX2bC7naByJGofEiYQyWvRP6CO4BDFo52TQ@mail.gmail.com>
 <CAMaBtwFQxeARGyhVxo+WsYCHgmJNJ7ThjtPcFv=LZqRNJtVxsw@mail.gmail.com>
In-Reply-To: <CAMaBtwFQxeARGyhVxo+WsYCHgmJNJ7ThjtPcFv=LZqRNJtVxsw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 17 May 2024 16:15:26 -0400
Message-ID: <CADnq5_MnsAEk_YsyMjaDH6G406E4=hQvMtOTU5xh5JeZJE7kqw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove GC HW IP 9.3.0 from noretry=1
To: Tim Van Patten <timvp@chromium.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	LKML <linux-kernel@vger.kernel.org>, alexander.deucher@amd.com, 
	prathyushi.nangia@amd.com, Tim Van Patten <timvp@google.com>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Ikshwaku Chauhan <ikshwaku.chauhan@amd.com>, Le Ma <le.ma@amd.com>, 
	Lijo Lazar <lijo.lazar@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	"Pan, Xinhui" <Xinhui.Pan@amd.com>, "Shaoyun.liu" <Shaoyun.liu@amd.com>, 
	Shiwu Zhang <shiwu.zhang@amd.com>, Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 1:27=E2=80=AFPM Tim Van Patten <timvp@chromium.org>=
 wrote:
>
> > Fair enough, but this is also the only gfx9 APU which defaults to
> > noretry=3D1, all of the rest are dGPUs.  I'd argue it should align with
> > the other GFX9 APUs or they should all enable noretry=3D1.
>
> Do you mean we should remove all IP_VERSION(9, X, X) entries from
> amdgpu_gmc_noretry_set(), leaving just >=3D IP_VERSION(10, 3, 0)?

No, just take your patch as is.  All of the other 9.x IP versions in
that check are dGPUs.  9.3.0 was the only APU in that list.

Alex

