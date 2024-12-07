Return-Path: <linux-kernel+bounces-436130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB20D9E8196
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 19:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D005D165592
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 18:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73B22E822;
	Sat,  7 Dec 2024 18:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RbEvdJT3"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FFF1448E4
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 18:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733596289; cv=none; b=PyEoYzRJBIV9INAmJ0i1cKQB7eo8/M0bIfkqFIcqMMIsjG3prYg1NzYM6+fZdWOc3ZGQz++km5TVmMXSAe661+GLEx4ZHBpZi75hKLhkBQeV4jjRLiZUI+6kA0H0EVlOFYHsLameJTdpNL8kX07KA3zSCtwGmT5WxrmMshDq9qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733596289; c=relaxed/simple;
	bh=pCyqxQB1wqSB6HSVhdTXB/6ltiXA8UsqI4BL9ES1zGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PYob0CaYaQrIZ1cLKjC6tqGmg1HsnKmJDSoNcypSwHpGzBGEdBrWkV13tETB3TvGozWoN784aoQTd1EoGydWV4SxyfEyBXfZHEacTsrunGcjMbqQx77oBsdO6EJS+gWJHd2WAOudkCYt1OaQmF4Su87dD2GiMxEexGIQfv8oMqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RbEvdJT3; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cf9ef18ae9so7324894a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 10:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733596285; x=1734201085; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V/vNc5nALUWVUmfD8b/aC22BtPTbXjUkByw6MJHP530=;
        b=RbEvdJT3JIZNs/PCvCg/fAj0fxcBUFoehpw3bJVyi1ddMI9CbBBGPLT1lKuRCLVNit
         JdarUD4QMCVzHnoUyb8VdwsgLz5F2sz48A0S7AYtMwYEiuVIV8rdFXffYwx/knCwLbyz
         PKFHx9syTCtRlHuHyIeJLkf7KrDRdxagg7NYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733596285; x=1734201085;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V/vNc5nALUWVUmfD8b/aC22BtPTbXjUkByw6MJHP530=;
        b=qYgVVQkzAyBC38emFAnn/VSyPBWhKRos0ivZS/0DFofwY1e5tls1YOEk8FVqjbq+1f
         NIcnzR8s54e7MFfuiKx4mbLnDKH8Dp+KrrdBvbgMhVP6Ns3rxt6IZfdeGjzj3I/5Jf5B
         rz8ftZJTa3gIsCoOEJb1g78yR7e6Y1JLbyiZDZfyUj8dGvEaBZFP7h6UObcDHVBTKkTV
         gEjSWlVApIiKWCUgaY1w7mH1zsyAPIncnJu4U9UT5YFUh94Yu04SS9rfQmMMrvJ96hiz
         k7oEDRI4fIRactxnltNgSVGRphHTMIEJQPzo7TeniNzPPA+IMnjh5HHoN+TRnXiiYGc9
         YQVg==
X-Forwarded-Encrypted: i=1; AJvYcCXUPLZSFXm7jkCex1Qp3zMO+Jn3Q6W/1uTQzmtOIEbcsUFSDJaPZ4/UNMw8bQWOSC4W68YjszoZlguOT30=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYzJXTsTdula06MPAM2sclvBMiutIcPDyYM+acU3IZK2GQAa26
	EtaJvj2cls+zG7eP+80E04fVCAKPgX08i1K0CwL0hjTruZYOfzwSvicHeshDC/sRpWXVfp/d+JB
	IK0sFrg==
X-Gm-Gg: ASbGnct8MvkvymC88HV2zlAcFgDrV3bCq5uhdqqqGC5NwBPFrhJEkC7lhpv+GMpw2oQ
	pNG+5jfx0PC3osSxcNEYFm8YpsioslWCEOBF8Ymd9YWzJeQQtkcSARqWpWRcwYrX5vj6QFm9Eaj
	qMfLanv+RurlB3Nq3S6EtrN7tjgwsGWVpQfI9CJWwoYq7LvckQjbMgjy6gixc9NWkB9NZ5JB56b
	xTKeT3dl9fDtDGrYYxk0Q7UA/qMquGEwqlvVzChc+OuDeuh4u0l3vJIpd1mx0fSwpPAb7sbfY/7
	4TuILJgkrQte8AbLmho6/1lz
X-Google-Smtp-Source: AGHT+IHoAk7B41qZbjVarLikf0ZqBqVnq2YdkOLYq7x+DEJ0U/xRqrSpMRnWPYu8VKhzGEQRtvjz8w==
X-Received: by 2002:a05:6402:5388:b0:5d0:ee81:f4f2 with SMTP id 4fb4d7f45d1cf-5d3bdccdd70mr7270997a12.16.1733596285075;
        Sat, 07 Dec 2024 10:31:25 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3c270ccdasm2477974a12.63.2024.12.07.10.31.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2024 10:31:24 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa647af6804so187740766b.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 10:31:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVXPaN3okP9tmlHmouCHXesCFv4CZi91kyrEhn8CFrfYtel3BP9xFOL+PQGnBRL+Wk5+gBhhGOcy1t1bzA=@vger.kernel.org
X-Received: by 2002:a17:906:32c2:b0:a9e:85f8:2a3a with SMTP id
 a640c23a62f3a-aa6373494a2mr765427966b.2.1733595978237; Sat, 07 Dec 2024
 10:26:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-2-4e4cbaecc216@wanadoo.fr>
 <1d807c7471b9434aa8807e6e86c964ec@AcuMS.aculab.com> <CAMZ6RqLJLP+4d8f5gLfBdFeDVgqy23O+Eo8HRgKCthqBjSHaaw@mail.gmail.com>
 <9ef03cebb4dd406885d8fdf79aaef043@AcuMS.aculab.com> <abdd7862f136aa676b2d2c324369f4a43ff9909c.camel@gwdg.de>
 <CAMZ6RqKzGiRNMeLsQKRNrxvW_bXB-kEi11udQ82kKX6tGCrqcg@mail.gmail.com>
 <9607300dfca5d71ca9570b1e1de0864e524f356b.camel@gwdg.de> <344b4cf41a474377b3d2cbf6302de703@AcuMS.aculab.com>
 <9a0c041b6143ba07c2b3e524572fccd841f5374b.camel@gwdg.de>
In-Reply-To: <9a0c041b6143ba07c2b3e524572fccd841f5374b.camel@gwdg.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 7 Dec 2024 10:26:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjpVXEjX16PP=-hi4CgLqEGJ_U-WvKWq+J3C+FW-hSSfg@mail.gmail.com>
Message-ID: <CAHk-=wjpVXEjX16PP=-hi4CgLqEGJ_U-WvKWq+J3C+FW-hSSfg@mail.gmail.com>
Subject: Re: [PATCH 02/10] compiler.h: add is_const() as a replacement of __is_constexpr()
To: Martin Uecker <muecker@gwdg.de>
Cc: David Laight <David.Laight@aculab.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Rikard Falkeborn <rikard.falkeborn@gmail.com>, 
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"coresight@lists.linaro.org" <coresight@lists.linaro.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 7 Dec 2024 at 05:07, Martin Uecker <muecker@gwdg.de> wrote:
>
> VLA use *less* stack than a fixed size arrays with fixed bound.

Not really. You end up with tons of problems, not the least of which
is how to actually analyze the stack size. It also gets *very* nasty
to have code that declares the VLA size using an argument that is then
checked afterwards - and if you have a strong preference for
"declarations before code", you end up with *horrific* issues.

And even if you are super-careful, and you solved the analysis
problem, in practice VLAs will cause huge stack issues simply due to
code generation issues.  The compiler will end up doing extra
alignment and extra frame handling and saving, to the point where any
advantages the VLA would bring is completely dwarfed by all the
disadvantages.

We went through this. We are so *much* better off without VLAs that
it's not even funny.

Now when the compiler says "your stack size is big", you just look
"Oh, that struct should be allocated with kmalloc, not on the stack".
Boom. Done.

            Linus

