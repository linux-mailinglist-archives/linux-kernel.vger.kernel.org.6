Return-Path: <linux-kernel+bounces-180498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FB28C6F4E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 01:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 259BF1F22F4D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 23:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7795F50278;
	Wed, 15 May 2024 23:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIf8pvQM"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1980741A88
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 23:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715817024; cv=none; b=lYMmyfeUbwXZerRew55BPit5mT3C9HB5awxlzVsFLwE8tgjKKcTCuzTNFeLkETOpyGkU2cucxFIZ4t4kMTrY1s32VXNrLxDAZKt8SlPx1ZuwnyNoOgmTE8xEAUoYnnfSM/Jy/cSD5oPd95VLZelHW+tKE2nZ1SPsiUn+05nBC68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715817024; c=relaxed/simple;
	bh=oylzj6SjvpmY5iNFCzRc4G3GwUloQDD3HJG22qtSAtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFp/XTP/dYaps2kcqxXL/2t7HMu/NjKXDcZeO2AcARKbE9aPwkjHwztLLPM7ML8Iea0Yvm2t+00r8xV2cPpJAUTINGSYw8fd6xkuV2UF7mzre34yusPZh569d62QOhsrGLc1Mf6Jwk7HOjv2n+hZQOHLCXAeSYvvcr/FOBNEhOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIf8pvQM; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51f99f9e0faso136521e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 16:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715817021; x=1716421821; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M2DfTJMriRJWzY3I1fpbPSjPaLFHGawiOuysTImuRHI=;
        b=gIf8pvQMYtGWiappwTAkGUDu4Xy5odML29mixawGXoNVw0TFiIN+iKqgM4ipgYA/P/
         bTYC/HRgEZs5amfZR5ewVu2LAdVC2L9PyhyCiBOz9vfwWRJ/bj68AUf4w0Dc6VWiYt50
         s9NDsDwuyjiW/54zfXUfz7eaV8Z/jb6SSuJZyFYFVXBYsF7FJFwTecpqweCtCW5mqhCP
         2d5XNsuFRdcHaPaIDD7vKhsBp9kHOLoMLkEXXD9hFh7Le490zwQvVoKAg+/hL/s37IWJ
         9dD+q07Z36AJXp4TWuzUnMedGmEU/bl7PZQL62eunkfoQK3N/KqR5WF7lBjVOP3vBk7f
         Vxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715817021; x=1716421821;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M2DfTJMriRJWzY3I1fpbPSjPaLFHGawiOuysTImuRHI=;
        b=DsJwXAZLz9E5Li8P6xZe2tWgXa/uGCxCEMYEj3fP9b0HrvBBY/fcCkauSKouOX9ZH0
         zmdi603vShL4EKuuF+KHLwAHOCy1FWKpf68grU1djc0DcgDUaABLUGSKjpS2lUsjk5AS
         gZ4GIN4CoRMZwxXgT+5TquBW1Ft7tCbfaJqk0o5JX9zHAoyNbU877G2CBnf6Jh93nnQT
         TNSS69OoLPmF5D55BTLLns7WKGgZ9Q9nARzULf7aksB8w4nqVM5SpYHyDMDJqD9MCq+d
         y1rCUSxKMZMzdCekp9EvfNNCAv+jmhjf4TqsB7+aMoG/CRBW7rEG1t4twcHfHFkdpO7c
         Tqaw==
X-Forwarded-Encrypted: i=1; AJvYcCXphedaekZYv+v76sD1T8ONxBQRKDtCcoC0E1FQYP3gA9873skWETv+xKagikZmOAOz1wBArF3urcSTqeAIB7HUC1D5N33WJl6ZqKz2
X-Gm-Message-State: AOJu0YxZq2aelCecG0fSlEfyW8D80SLsd/w+3XhXg4diYcL0MDRnEA2T
	aRjrizq9SPpyZ63XvrOyhZvjB9gCsBWVdDQuRpigqiYAzIze+qnobMCcxkTx2cdC4Xv3FciUKrN
	bZDgLWiLodrTLizXb4Sadjjh9OJ0=
X-Google-Smtp-Source: AGHT+IEoFONe5600wbwpUr+t64TDVQ+GOCxXQFXKsCmO7k2TGzH3IpwLNHqr9mmoL9/Fry8O0asu6LZWp2AxedCnnNo=
X-Received: by 2002:a05:6512:234a:b0:523:b261:3dde with SMTP id
 2adb3069b0e04-523b2613eb1mr654437e87.41.1715817021013; Wed, 15 May 2024
 16:50:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tw-53PCvveRcdLUUQ+mjq2X2er5zp6n1KeE8Nu8x=VP2g@mail.gmail.com>
 <CAHk-=wge0et+3PP47OBnNx66Q=i_XgqfGfrSmDGHSyp=Jn-CgQ@mail.gmail.com>
 <CAHk-=whTqHgXZ4Aj8dNO3Peg9Rf0sh2F7zGWRUOmBwfMDxgvbQ@mail.gmail.com>
 <CAHk-=wgWJCcJRLBZ1xoAATFyvp6YKN+qzrePhxQbN1SFrno7pQ@mail.gmail.com> <CAHk-=wjm4BcsMrvgXocATBVvZ7N6LAjSvLTzTXWg9EFzyip_cA@mail.gmail.com>
In-Reply-To: <CAHk-=wjm4BcsMrvgXocATBVvZ7N6LAjSvLTzTXWg9EFzyip_cA@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 16 May 2024 09:50:09 +1000
Message-ID: <CAPM=9twOiwquA7Zi_mr1vKFV4RQqhnbHv+c9Xz6BadF3tGEegw@mail.gmail.com>
Subject: Re: [git pull] drm for 6.10-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>, 
	"Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Matthew Auld <matthew.auld@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, 
	dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000000a2d5c061886c829"

--0000000000000a2d5c061886c829
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 May 2024 at 06:29, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 15 May 2024 at 13:24, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I have to revert both
> >
> >   a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
> >   e362b7c8f8c7 ("drm/amdgpu: Modify the contiguous flags behaviour")
> >
> > to make things build cleanly. Next step: see if it boots and fixes the
> > problem for me.
>
> Well, perhaps not surprisingly, the WARN_ON() no longer triggers with
> this, and everything looks fine.
>
> Let's see if the machine ends up being stable now. It took several
> hours for the "scary messages" state to turn into the "hung machine"
> state, so they *could* have been independent issues, but it seems a
> bit unlikely.

I think that should be fine to do for now.

I think it is also fine to do like I've attached, but I'm not sure if
I'd take that chance.

Two questions for Arunpravin (and Alex):

Is this fix correct, and can we get a good explanation of it?

Where did this error sneak in? Is the problem in the amdgpu tree, or
was it a drm-next only problem? If so perhaps we need to discuss
moving amdgpu more into drm-tip to catch this sort of problem.

Dave.

--0000000000000a2d5c061886c829
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-buddy-convert-WARN_ON-to-an-if-continue.patch"
Content-Disposition: attachment; 
	filename="0001-drm-buddy-convert-WARN_ON-to-an-if-continue.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lw8h2ndb0>
X-Attachment-Id: f_lw8h2ndb0

RnJvbSAwODViODkyNzhmMjk2YzQwZTg2ZjVkMWUxYmNjMTAxN2MzOWY0MDAyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZlIEFpcmxpZSA8YWlybGllZEByZWRoYXQuY29tPgpEYXRl
OiBUaHUsIDE2IE1heSAyMDI0IDA5OjQ2OjM3ICsxMDAwClN1YmplY3Q6IFtQQVRDSF0gZHJtL2J1
ZGR5OiBjb252ZXJ0IFdBUk5fT04gdG8gYW4gaWYgKyBjb250aW51ZQoKVGhpcyBXQVJOX09OIHRy
aWdnZXJzIGEgbG90LCBidXQgSSBkb24ndCB0aGluayB0aGUgX19mb3JjZV9tZXJnZQpwYXRoIGFs
d2F5cyBoYXMgdG8gc3VjY2VlZCwgc28ganVzdCByZXR1cm4gYSBmYWlsdXJlIGhlcmUgaW5zdGVh
ZApvZiB3YXJuIG9uIHRvIGxldCBvdGhlciBwYXRocyBoYW5kbGUgdGhlIGFsbG9jYXRpb24uCgoo
Tm90IDEwMCUgc3VyZSBvbiB0aGlzIHBhdGNoIC0gYWlybGllZCkuCi0tLQogZHJpdmVycy9ncHUv
ZHJtL2RybV9idWRkeS5jIHwgNSArKystLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2J1ZGR5
LmMgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2J1ZGR5LmMKaW5kZXggMjg0ZWJhZTcxY2M0Li42Yjkw
ZWM2ZWVmYTggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fYnVkZHkuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vZHJtX2J1ZGR5LmMKQEAgLTE5NSw4ICsxOTUsOSBAQCBzdGF0aWMgaW50
IF9fZm9yY2VfbWVyZ2Uoc3RydWN0IGRybV9idWRkeSAqbW0sCiAJCQlpZiAoIWRybV9idWRkeV9i
bG9ja19pc19mcmVlKGJ1ZGR5KSkKIAkJCQljb250aW51ZTsKIAotCQkJV0FSTl9PTihkcm1fYnVk
ZHlfYmxvY2tfaXNfY2xlYXIoYmxvY2spID09Ci0JCQkJZHJtX2J1ZGR5X2Jsb2NrX2lzX2NsZWFy
KGJ1ZGR5KSk7CisJCQlpZiAoZHJtX2J1ZGR5X2Jsb2NrX2lzX2NsZWFyKGJsb2NrKSAhPQorCQkJ
ICAgIGRybV9idWRkeV9ibG9ja19pc19jbGVhcihidWRkeSkpCisJCQkJY29udGludWU7CiAKIAkJ
CS8qCiAJCQkgKiBJZiB0aGUgcHJldiBibG9jayBpcyBzYW1lIGFzIGJ1ZGR5LCBkb24ndCBhY2Nl
c3MgdGhlCi0tIAoyLjQ0LjAKCg==
--0000000000000a2d5c061886c829--

