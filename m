Return-Path: <linux-kernel+bounces-575955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A605FA70940
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E10D43AB7C2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B731F3B96;
	Tue, 25 Mar 2025 18:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkDQYww2"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AB31F2C3B;
	Tue, 25 Mar 2025 18:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742928155; cv=none; b=WCz6X+N40y0Rh/0MjNe2V6n8yypFnX2rv/bL424br3WLVcz8vOxCJs+N6ifSl0f+xafIjJr5dJKdtF3jmDPjUtc4JY7MlXAk+ByEHs9StLb9lSiDlDzhqD5nqnLfY9mYSx3UahE9N2mKbiygzm2ULwdTvlzEW9OAw4H71lNZvq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742928155; c=relaxed/simple;
	bh=vhVAOzv5qjTv3qc4CBpptkbK8G9euFvMmiNYu0HhVoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HucRzWZi2Nzcnl2Z1BPTLpLIpQno+ns4EOM05zGVOHHg09oB/8gK8RP28kgaqP67gGKMh44J2SujAYuScsEZepDVx63cjx9CC6D5GG869hc2beLiviudB2txpvkWIgRV+ZisD8aE0/pWd6bmZAG+HELL0vK3Z3lnKuDWTmV6PEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkDQYww2; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6febf391132so52576467b3.1;
        Tue, 25 Mar 2025 11:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742928152; x=1743532952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeUoecMq8P9nHeIOh/xIrCNU1yJBHCZceaN06+7PEC4=;
        b=WkDQYww226C0NUhBhiDm919zqbUdSQT9kNxFmKQ05rYE7zfNA5O+PND2Nwu7F3dQKk
         GBXi1DIW/43BRo7OR2lYdSCjPx/GwCq3z1xl5Z90fBbrFdX57Lb7G4Lqpdjqwrwx5PVx
         ToKXFDkEbWrSRq2BAbo1A1y0q4T3QsQ3TUnSoR3t4uBzH5wlomCnKp65vtfz+ORMwEQM
         dgvH5PENSg2z9Qk/q2X3qruBEtYT/S/4uFqznfOR+8EW+qoEBYqA1GzT6fzW1AudpOGL
         X7IPLBW7a9r1iZNylpyHJDFXHxWQv3jMshf34oPJvyVSf8rLQt9NCMd2aXJoIphr9XMf
         o/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742928152; x=1743532952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PeUoecMq8P9nHeIOh/xIrCNU1yJBHCZceaN06+7PEC4=;
        b=JQdVWD954MKGhHgE1qinAwARxji9umLUYWWu/QQX0fPplTW/kLdfwGa4r3xvT7DyRv
         nA62SqbOQKj3iW8OBK5p+XvNv4ckTZkAoMiesquy/1vzhuo3gUVxW4a6ASM/vuEzcDbI
         pyuqhtXVzbwxRmZMY9QBebNabB84/tCqyBxLt+iCHyUa7dALfOhiYk6dAv9gTAbTmloJ
         bsEc9UrEc5xAC8U6BTAFDlnI2XSQhl+Ot7VEMMw+LS3ClxjEgYk/Eq9kzGQ7vSnTG1rW
         9hOptJXwDVsmJZZmP6s8j7u3W3tMUekGskoC5L+ljPgGNm3+cHjO9XwhxfSEv7XB89xf
         z46g==
X-Forwarded-Encrypted: i=1; AJvYcCWEiAW93jNEAuWLQZ+82Zn3wIIH0xCLEcFy2uCH+RWkexB6Sf/mLBGgl0Wu8eurNl1EH94X09QDtqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YywBtckcHpJiHwH/Rz2cdb9VLbTXuU9mtuIOSTVSZQha7mXr/QI
	JBKo5B4TjgiRbyh1E57wLd002f8VosZevcewukeLQ8b6UPLxWfHy5doWe+sKNZYxmTCTBKSUiZt
	R5jw1UTGSxI/KIlY3YAxszf0+TnQ=
X-Gm-Gg: ASbGncvfWaK5aZN1vXKOGShZjlE0mKSSCDUTUAEdcmdfMh1CpjxuA4ISUrf4jz971py
	h/vP62mX8xC0b/+NVFrEKhrgBHforVGQ4Vg2cbBL+HOE5atxbdmKXGUl68E2N7ri5Orz0iu0l1s
	r9zC70XNOAUM+AQGKIR+rYLZbS
X-Google-Smtp-Source: AGHT+IEYJVEdhxBYqC+vn+T0V878WmSY+Hkd8JEVzl5vnSfQjiTFWsv1pJ/9u3CtXGZJrGgT7+9EyoeQDEqXNs0ITcY=
X-Received: by 2002:a05:690c:4d49:b0:6f9:aecf:ab34 with SMTP id
 00721157ae682-700bad42af9mr237984777b3.38.1742928151983; Tue, 25 Mar 2025
 11:42:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320185238.447458-1-jim.cromie@gmail.com> <20250320185238.447458-34-jim.cromie@gmail.com>
 <2dffcb05-1c31-4704-9081-91107b3ce165@bootlin.com>
In-Reply-To: <2dffcb05-1c31-4704-9081-91107b3ce165@bootlin.com>
From: jim.cromie@gmail.com
Date: Tue, 25 Mar 2025 12:42:05 -0600
X-Gm-Features: AQ5f1JonfOJIFA8uirzWISL6HB1CZ8tZUdwOAeNYz4kp6Txu9CT7sVkQi1xw55c
Message-ID: <CAJfuBxwHQOqDobL-FZiMA81OaccWw9RRJp2gL__CrQVnM+z33w@mail.gmail.com>
Subject: Re: [PATCH v2 33/59] docs/dyndbg: add classmap info to howto (TBD)
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, intel-gfx-trybot@lists.freedesktop.org, 
	jbaron@akamai.com, gregkh@linuxfoundation.org, ukaszb@chromium.org, 
	daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com, 
	ville.syrjala@linux.intel.com, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 9:23=E2=80=AFAM Louis Chauvet <louis.chauvet@bootli=
n.com> wrote:
>
>
>
> Le 20/03/2025 =C3=A0 19:52, Jim Cromie a =C3=A9crit :
> > Describe the 3 API macros providing dynamic_debug's classmaps
> >
> > DYNDBG_CLASSMAP_DEFINE - create & export a classmap
...
> > +Dynamic Debug classmaps
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The "class" keyword selects prdbgs based on author supplied,
> > +domain-oriented names.  This complements the nested-scope keywords:
> > +module, file, function, line.
> > +
> > +The main difference from the others: class'd prdbgs must be named to
> > +be changed.  This protects them from generic overwrite:
> > +
> > +  # IOW this cannot undo any DRM.debug settings
> > +  :#> ddcmd -p
>
> Patch 30/59 just dropped this behavior no?

Yes, that chunk is obsolete, given my capitulation :-/


>
> > +So each class must be enabled individually (no wildcards):
> > +
> > +  :#> ddcmd class DRM_UT_CORE +p
> > +  :#> ddcmd class DRM_UT_KMS +p
> > +  # or more selectively
> > +  :#> ddcmd class DRM_UT_CORE module drm +p
> > +
> > +Or the legacy/normal (more convenient) way:
> > +
> > +  :#> echo 0x1ff > /sys/module/drm/parameters/debug
> > +
> > +Dynamic Debug Classmap API
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > +
> > +DRM.debug is built upon:
> > +  ~23 macros, all passing a DRM_UT_* constant as arg-1.
> > +  ~5000 calls to them, across drivers/gpu/drm/*
> > +  bits in /sys/module/drm/parameters/debug control all DRM_UT_* togeth=
er
> > +
> > +The const short ints are good for optimizing compilers; a classmaps
> > +design goal was to keep that.  So basically .classid =3D=3D=3D categor=
y.
> > +
> > +And since prdbgs are cataloged with just a DRM_UT_* to identify them,
> > +the "class" keyword maps known classnames to those reserved IDs, and
> > +by explicitly requiring "class FOO" in queries, we protect FOO class'd
> > +debugs from overwrite by generic queries.
> > +
> > +Its expected that other classmap users will also provide debug-macros
> > +using an enum-defined categorization scheme like DRM's, and dyndbg can
> > +be adapted under them similarly.
> > +
> > +DYNAMIC_DEBUG_CLASSMAP_DEFINE(var,type,_base,classnames) - this maps
> > +classnames onto class-ids consecutively, starting at _base, it also
> > +maps the names onto CLASSMAP_PARAM bits 0..N.
> > +
> > +DYNAMIC_DEBUG_CLASSMAP_USE(var) - modules call this to refer to the
> > +var _DEFINEd elsewhere (and exported).
> > +
> > +Classmaps are opt-in: modules invoke _DEFINE or _USE to authorize
> > +dyndbg to update those classes.  "class FOO" queries are validated
> > +against the classes, this finds the classid to alter; classes are not
> > +directly selectable by their classid.
> > +
> > +There are 2 types of classmaps:
> > +
> > + DD_CLASS_TYPE_DISJOINT_BITS: classes are independent, like DRM.debug
> > + DD_CLASS_TYPE_LEVEL_NUM: classes are relative, ordered (V3 > V2)
> > +
> > +DYNAMIC_DEBUG_CLASSMAP_PARAM - modelled after module_param_cb, it
> > +refers to a DEFINEd classmap, and associates it to the param's
> > +data-store.  This state is then applied to DEFINEr and USEr modules
> > +when they're modprobed.
> > +
> > +The PARAM interface also enforces the DD_CLASS_TYPE_LEVEL_NUM relation
> > +amongst the contained classnames; all classes are independent in the
> > +control parser itself; there is no implied meaning in names like "V4".
> > +
> > +Modules or module-groups (drm & drivers) can define multiple
> > +classmaps, as long as they share the limited 0..62 per-module-group
> > +_class_id range, without overlap.
>
> Maybe clarify that a driver using _USE macro should take care that he
> only use distinct non-overlaping classmaps?

ack

>
> > +``#define DEBUG`` will enable all pr_debugs in scope, including any
> > +class'd ones.  This won't be reflected in the PARAM readback value,
> > +but the class'd pr_debug callsites can be forced off by toggling the
> > +classmap-kparam all-on then all-off.
>
> --
> Louis Chauvet, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
>

