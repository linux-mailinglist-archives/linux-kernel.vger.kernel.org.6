Return-Path: <linux-kernel+bounces-184918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D3D8CADC5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B4B11F20F33
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FFA76C76;
	Tue, 21 May 2024 11:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WqDMMX7J"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E458763E2
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 11:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716292674; cv=none; b=YSLssouUxXX7xgLozen/87zg9MRznZ2Yj5XhpGMWaHFwBmU0m5i6jVUPM4+At8krFix/p1g00vSCQFn9iCeF7MyaRSFy/wpHTkspaNu/HRfLW6j+G78cvQrB7lClzEdLV86PGPmBjA8yLs40PJM/3j/iq7MZS6kXTltCs7AVZYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716292674; c=relaxed/simple;
	bh=q9fIW/kokRy/aqoKrTmpSlBLPOxD6/t6kfcGLcryXr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7iIriq04xPvIbJlfLQAkRCSqIhVeBOhEIh3LMo0xyMSAoRIlauu+7m2cAWmFZJRV6xBY/K78fnS8hUl4+5alQntORvDMaqiuPK+Gj2quRyJHmeYiE3fxKemqKwwIGbununZH0K5O5oT4OvLyDRKbFXtTNRBI9D/RVydBengYzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WqDMMX7J; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5206a5854adso4341553e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 04:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716292670; x=1716897470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Md6P1tR1u5fc1z/ZbkZnU+iRNw88rkv2FOhweb3h/ZA=;
        b=WqDMMX7JyoXxig871PgfKzwjhu8LeEIg8tBUq5kK9MuHzstczsirhuahm2NgWH+nR5
         WtS73pdIN0796DFRjuLY6KVQnmoVeVEEbjzxw6kDXa7Nsut+pDcGRI3LwNQhQN9h9A/8
         Tn3hBPjsEHIouWgCmgt/1Pdgf3GmQuijdYs1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716292670; x=1716897470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Md6P1tR1u5fc1z/ZbkZnU+iRNw88rkv2FOhweb3h/ZA=;
        b=m2gx59pdHR1OFWMRr/vMn+zE/779hjQfrzoelvOHePryWitRHZKWcppKJkLq2fBh6W
         /VXwNnoaHEU8Hlju8V/fLxtIiFlkPdLjamDUro2cR25yGWD2HHxn8ssPzIwwom0QB2jx
         i9cAYu/BvHIFTVI860X4vhV8EylhDCfpeYaMBFi6ER685xJZqpo3B+0+9aP52Ok1uqx5
         eljPoPkib2EkjUrYRLZa0HK5f2eD2wO3wVFaTmOQMVh/HgBiYuOe6QIhLHmFk7qB1MS3
         fcsjN/NbVF+oAr9Jicn2bRhgGGESEebojA1kkQGb+WL+2WPmHVaZqr7M8HnJF2MNQFa6
         ZXCA==
X-Forwarded-Encrypted: i=1; AJvYcCV1O8sHXJm1lMi1l9S4M9X7nCZ2PiiPIIh/HvDwmYVAlpvw/VYg3b9koyLvn2/iZ7dtHXVNwGQlrzo3CS8nZHdkmb6lJznG2LjHa5Ya
X-Gm-Message-State: AOJu0Yy51BjGiw0zhxGXxlnFDBaJ4fqEbWpKS4fSWpxKNmkl/aOPzwbD
	aDeRzcVzWi7QxIdSxz8Lr5Cgn0Yox2jdBUEu2fdOTmSd8DJsMNaKKO/UqVegcptb3b01c9xUpvO
	Jivg5D3nYIECZQ4V5PZrvtPc5eNFbmUeAFqM=
X-Google-Smtp-Source: AGHT+IF8gWYCjzK4VBQThJnN/naCIuZULqmffSLif/Bdak01khAvPP2yw/yX4C7oyauFBTx6Y1In2u4yiOm9RZxiHiM=
X-Received: by 2002:a19:641c:0:b0:517:87ba:aff3 with SMTP id
 2adb3069b0e04-523573cfdd1mr14170012e87.43.1716292670481; Tue, 21 May 2024
 04:57:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516174357.26755-1-jim.cromie@gmail.com> <20240516174357.26755-20-jim.cromie@gmail.com>
In-Reply-To: <20240516174357.26755-20-jim.cromie@gmail.com>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Date: Tue, 21 May 2024 13:57:38 +0200
Message-ID: <CALwA+NYNPfpyM8ZH3L-fbrqSpzKw61gZU+u_uxP6tjnFe7UJ-w@mail.gmail.com>
Subject: Re: [PATCH v8-RESEND 19/33] dyndbg-doc: add classmap info to howto
To: Jim Cromie <jim.cromie@gmail.com>
Cc: jbaron@akamai.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, joe@perches.com, 
	mcgrof@kernel.org, daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com, 
	jani.nikula@intel.com, ville.syrjala@linux.intel.com, seanpaul@chromium.org, 
	robdclark@gmail.com, groeck@google.com, yanivt@google.com, bleung@google.com, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 7:45=E2=80=AFPM Jim Cromie <jim.cromie@gmail.com> w=
rote:
>
> Describe the 3 API macros providing dynamic_debug's classmaps
>
> DYNDBG_CLASSMAP_DEFINE - create, exports a module's classmap

create, exports a module's classmap - > creates and exports a module's clas=
smap

> DYNDBG_CLASSMAP_USE    - refer to exported map

DYNDBG_CLASSMAP_USE - refers to exported map

> DYNDBG_CLASSMAP_PARAM  - bind control param to the classmap

bind -> binds

> DYNDBG_CLASSMAP_PARAM_REF + use module's storage - __drm_debug
>

+ use module's storage - __drm_debug -> - uses module's storage (for
example __drm_debug)

> cc: linux-doc@vger.kernel.org
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
> v5 adjustments per Randy Dunlap
> v7 checkpatch fixes
> v8 more
> ---
>  .../admin-guide/dynamic-debug-howto.rst       | 63 ++++++++++++++++++-
>  1 file changed, 62 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Document=
ation/admin-guide/dynamic-debug-howto.rst
> index 6a8ce5a34382..742eb4230c6e 100644
> --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> @@ -225,7 +225,6 @@ the ``p`` flag has meaning, other flags are ignored.
>  Note the regexp ``^[-+=3D][fslmpt_]+$`` matches a flags specification.
>  To clear all flags at once, use ``=3D_`` or ``-fslmpt``.
>
> -
>  Debug messages during Boot Process
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> @@ -375,3 +374,65 @@ just a shortcut for ``print_hex_dump(KERN_DEBUG)``.
>  For ``print_hex_dump_debug()``/``print_hex_dump_bytes()``, format string=
 is
>  its ``prefix_str`` argument, if it is constant string; or ``hexdump``
>  in case ``prefix_str`` is built dynamically.
> +
> +Dynamic Debug classmaps
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Dyndbg allows selection/grouping of *prdbg* callsites using structural
> +info: module, file, function, line.  Classmaps allow authors to add
> +their own domain-oriented groupings using class-names.  Classmaps are
> +exported, so they referencable from other modules.

Typo referencable -> are referenceable



> +
> +  # enable classes individually
> +  :#> ddcmd class DRM_UT_CORE +p
> +  :#> ddcmd class DRM_UT_KMS +p
> +  # or more selectively
> +  :#> ddcmd class DRM_UT_CORE module drm +p
> +
> +The "class FOO" syntax protects class'd prdbgs from generic overwrite::
> +
> +  # IOW this doesn't wipe any DRM.debug settings
> +  :#> ddcmd -p
> +
> +To support the DRM.debug parameter, DYNDBG_CLASSMAP_PARAM* updates all
> +classes in a classmap, mapping param-bits 0..N onto the classes:
> +DRM_UT_<*> for the DRM use-case.
> +
> +Dynamic Debug Classmap API
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +
> +DYNDBG_CLASSMAP_DEFINE - modules use this to create classmaps, naming
> +each of the classes (stringified enum-symbols: "DRM_UT_<*>"), and
> +type, and mapping the class-names to consecutive _class_ids.
> +
> +By doing so, modules tell dyndbg that they have prdbgs with those
> +class_ids, and they authorize dyndbg to accept "class FOO" for the
> +module defining the classmap, and its contained classnames.
> +
> +DYNDBG_CLASSMAP_USE - drm drivers invoke this to ref the CLASSMAP that
> +drm DEFINEs.  This shares the classmap definition, and authorizes
> +dyndbg to apply changes to the user module's class'd pr_debugs.  It
> +also tells dyndbg how to initialize the user's prdbgs at modprobe,
> +based upon the current setting of the parent's controlling param.
> +
> +There are 2 types of classmaps:
> +
> + DD_CLASS_TYPE_DISJOINT_BITS: classes are independent, like DRM.debug
> + DD_CLASS_TYPE_LEVEL_NUM: classes are relative, ordered (V3 > V2)
> +
> +DYNDBG_CLASSMAP_PARAM - modelled after module_param_cb, it refers to a
> +DEFINEd classmap, and associates it to the param's data-store.  This
> +state is then applied to DEFINEr and USEr modules when they're modprobed=
.
> +
> +This interface also enforces the DD_CLASS_TYPE_LEVEL_NUM relation
> +amongst the contained classnames; all classes are independent in the
> +control parser itself.
> +
> +Modules or module-groups (drm & drivers) can define multiple
> +classmaps, as long as they share the limited 0..62 per-module-group
> +_class_id range, without overlap.
> +
> +``#define DEBUG`` will enable all pr_debugs in scope, including any
> +class'd ones.  This won't be reflected in the PARAM readback value,
> +but the class'd pr_debug callsites can be forced off by toggling the
> +classmap-kparam all-on then all-off.
> --
> 2.45.0
>

