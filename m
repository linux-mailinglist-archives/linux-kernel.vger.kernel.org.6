Return-Path: <linux-kernel+bounces-323225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE3D9739BA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C89AB22C01
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26751922DC;
	Tue, 10 Sep 2024 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pBoESgvX"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A310918FDBD
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725978002; cv=none; b=hf4d2H1JrZq4DuffHTyM4bBiRm+GKhB24iLJCGDlgC35BczlkTNTCePBgohPOusjTTlzbiXJ4+SrD9NXgOiTDMEwUFEUs3PacugQW1yiwxUpHqKGy80FSp95xsBR8rhXoNNFwKPmSC9M++dmPqztzKvLdJNe7nEbAoBjxbFPorc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725978002; c=relaxed/simple;
	bh=Jx0Skg+LeZzo5wW4Rr/X6Np29gcXKRlYjoaHnTmyULQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iq0hWaBZFVoF6ShgjhElsOSsyIJEBee/sGCk2dHCplu2emAjalrPKLgjxfqtEBoepo198vzF8PCFcYnBn5OQ346IxP4HR9AKrYqusl0TsUTqLSX1iTLTk4WtLoji+0W8e/JycUPVF7nBGztadQzi7K8noFFcPvQYrnsSLo/eXik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pBoESgvX; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6c354091616so33559076d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725977999; x=1726582799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jx0Skg+LeZzo5wW4Rr/X6Np29gcXKRlYjoaHnTmyULQ=;
        b=pBoESgvXp43pYGmmyd7sJhRm80uwhPsOdHmglYOlE9/dXNeTE2YiagxeK6HqEC0Dwz
         I0LSEcE/0OyIXpF0nMOQ3Y3almFc4YqtdYtUMfUYF0ygy9T2mFh3RBEvxFJEneaMM3+r
         2LiECtQo4uWh0Nr2PcfrSDtm8uHeZoyIywO1Ls9NMJ6oRSlfv7YVQCPnxewB1Aae3ee2
         udj+NawDyJfep/NrwGnET26snooS9CCgE2PDsCLIp4v3CDfsHHthU3NWDmeHnpDrQFyj
         NdcbEonEMo9qhDdbv669GEQB6sEP9JXw5f4tn63MfQhCd/qDPI2aqSEt6UckLlf3JqNO
         5fgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725977999; x=1726582799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jx0Skg+LeZzo5wW4Rr/X6Np29gcXKRlYjoaHnTmyULQ=;
        b=CyWfFWcv7GOBuvaC5qI4+oBlbzVLSKbNROOr4splB9Gi8oE+ylhEnjv1e5U05K2JMy
         hIZzzhbHsKex8aJHOkvUxhca8zpiE0ngot+vU4apl/PCk/zrPVGgRl05EJv0DiTQE0L7
         lqO7WYuk2kw4CPr9HOtQcAK/938FEPDdj0XNn2L/E9Fho+FDSeQ+93awR9qqKIc0h4Z+
         xtkS8T7/7+W1pY1laiogkjNXJgLGSs0/gfIOzPCcsofqRLwbF96Cmy0cchlV5pMP07rU
         mgpC4lTXOsraHjSb1pX7k64+kLkJZr9K66Wf2fHcCPoqV1Vkpi+JxHYkko7oXAqMYfVe
         U+XA==
X-Forwarded-Encrypted: i=1; AJvYcCV0z+4wee2NmorB/IqUiqZjk84Y5Kjbq/fpcJttzYU5Yja63p7+s7E+LbJlLet6WPfWerCVx9FKp2aoBws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdMZGcZ8IAXXAeWNjRs7+/fBtsMrI0SgbLhh+kItvGAZcEoxW2
	u79fCxKIx9Jcu+mDITU+y8yhV4v9hthdamjXHgtmK0lt2chvocqAEVjeeYBr/syALgxsIJ8z9M4
	FgLhfHF+EDYjWNM/elnH3ub+o4FY8uwf/1tzR
X-Google-Smtp-Source: AGHT+IEFPlMt5kT5UTCLOf0JwDS+yAZDFrJv1Y62btlwDn2VXfwiZA5HOr49XasWew8S7WJWF530fCjb+v9YXOAF6aA=
X-Received: by 2002:a05:6214:390e:b0:6bf:7d3c:a64d with SMTP id
 6a1803df08f44-6c52850ddcdmr172364426d6.32.1725977999107; Tue, 10 Sep 2024
 07:19:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909012958.913438-1-feng.tang@intel.com> <20240909012958.913438-5-feng.tang@intel.com>
 <4b7670e1-072a-46e6-bfd7-0937cdc7d329@suse.cz> <ZuBURfScdtDbSBeo@feng-clx.sh.intel.com>
In-Reply-To: <ZuBURfScdtDbSBeo@feng-clx.sh.intel.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 10 Sep 2024 16:19:19 +0200
Message-ID: <CAG_fn=U=tkh-mLThLsupNRsKRHkxPL__U_eFSCCbmeHTdoA6Hg@mail.gmail.com>
Subject: Re: [PATCH 4/5] kunit: kfence: Make KFENCE_TEST_REQUIRES macro
 available for all kunit case
To: Feng Tang <feng.tang@intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Marco Elver <elver@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	David Gow <davidgow@google.com>, Danilo Krummrich <dakr@kernel.org>, linux-mm@kvack.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 4:14=E2=80=AFPM Feng Tang <feng.tang@intel.com> wro=
te:
>
> On Tue, Sep 10, 2024 at 03:17:10PM +0200, Vlastimil Babka wrote:
> > On 9/9/24 03:29, Feng Tang wrote:
> > > KFENCE_TEST_REQUIRES macro is convenient for judging if a prerequisit=
e of a
> > > test case exists. Lift it into kunit/test.h so that all kunit test ca=
ses
> > > can benefit from it.
> > >
> > > Signed-off-by: Feng Tang <feng.tang@intel.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

(assuming KUNIT maintainers are fine with the change)

