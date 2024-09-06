Return-Path: <linux-kernel+bounces-319023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A6C96F69C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26F12855CF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3781CEAC9;
	Fri,  6 Sep 2024 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Yj6CScOJ"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA9D1CDA1B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725632683; cv=none; b=jFC96BSM2AktVxhpVfrRiKjibyJlRGcZvqj2hOr5zkBT5JEJnh+UkSaK4RBrm9vUf5RB2ExsTCruZe2vGXDFHRIM6S15zlnxJO+TnYoEGDdSXU+0wW1YSxUCRgwhS1f3Ewf1PwMrSCJIjizT7r4NDV6r2b+FyDT0G5h75Sbf/ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725632683; c=relaxed/simple;
	bh=wv6kJxYCqCengvLTHChe0c4KVEVeRveBWFTYnyGvtSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lF8XICyMbhngqlEMPBPzl2Q4acbZqGb5r2sCGg6uTODUlwziimnyY5N/t//T1jarjo4Fqp8eMcmlytEJgPlmrfLxApSxEzGJBjiT5xRSaLWSVVkTlbCCXtJ4cviWFEmpEf8xaSxTMvkCP+wXJumu1X2+8XKhsL29SX9tdivvYSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Yj6CScOJ; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6c3f1939d12so18618817b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 07:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725632681; x=1726237481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNbaUU5vwP/wbzjKIGwlz0vt3Em9od+pl2HUlcVAsXU=;
        b=Yj6CScOJz17tA7YwqspISU2T+w/zx3UzhDhQTd5RTp5Xk/lZC0KGpkIaqJeDJUREUz
         bMYBhallnnSR61nMBttbYWPfY49hgeoK+k3/teTlY88Bt90G7dyUHZ6UEi6wDawO7hCp
         XYXxS8rX3QKFZCACHpBNS0QnqHmurPRa3yJkjHIya2B3/Cx17P4hK5oA6I2p3l4zo+9o
         B3wuyiA7ZxZucGUGd/ze0Lx2gPf8fWaifP49S6ZUQjrChkWaJBDtr6CjtHX3BTd+xvka
         svBPpnh+38xV2fQs9jWm5OhI+lO4FG+TLk/Fjk6fmQLYp2zDtH+BAmfvruUjCf+BFWct
         Dt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725632681; x=1726237481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNbaUU5vwP/wbzjKIGwlz0vt3Em9od+pl2HUlcVAsXU=;
        b=WFzJE3s7YsELMi3RHSUoPMpEbAzcdmEShlvRSN9CxZJ0BL5HokyBlTAO0Ou88762xn
         DVSVHPpfi10p714UUWyc2rg7oSbQE3YIIyKLZ+pcr/GBQV89ZC66bQVLGiTBSY6w8Ymx
         P/NfBkdYyfKg0eQKndgmxV4WuwHiLCDDk/BhcWFHILEmfGA3stBrhhAtqm2cZkSu/XX8
         xhNuitlD2Kse15sHZIQ4da3fqY+GtONJ4LRRySBlYbEzgIjPKLbRkVjNZbBhOcNzUk0+
         tpMRX4BuF8fiDitcKFWhejbWrNZCXB6k4NP5wBYNJ4sDSvGeTqA953/J0EK25h9lrEvb
         /4jA==
X-Forwarded-Encrypted: i=1; AJvYcCUVaf497T3XbjrrmkLPz6PrkNXnQHCJGOOsQtcJaykaCbwe2nnnPjWHKxGuh0pqGhj17x+onfv6x0FLDX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbZY0L3Xrzz8PC9XPJ+sknlU8jMBxLASU5ipLkQtXYnc5c974/
	akOIc5T5otcnn8w1Q4IHI7PhkXbDwl92d93LFngKrKVPyQrf6yS1pmnKzg968k8HFBN6zWi8oE6
	P+0AthQx94hTEgZ5hdoQTV7wx8cppM3DZPAYo
X-Google-Smtp-Source: AGHT+IHkwUfgBd2GCUq4Ewk11aR7nvtoUcy0CcLvqAJSfxsI0EpdJKKQsnFEMsEDRxPJNpbCavId6DYQUks2DIdCYS4=
X-Received: by 2002:a05:690c:4604:b0:6ae:2f25:8bc4 with SMTP id
 00721157ae682-6db44f2c242mr27205497b3.16.1725632680764; Fri, 06 Sep 2024
 07:24:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <caafb609-8bef-4840-a080-81537356fc60@I-love.SAKURA.ne.jp>
 <CAHC9VhT_eBGJq5viU8R_HVWT=BTcxesWAi3nLcMgG8NfswKesA@mail.gmail.com> <d16cd3d1-4b32-487e-b116-419c19941472@I-love.SAKURA.ne.jp>
In-Reply-To: <d16cd3d1-4b32-487e-b116-419c19941472@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 6 Sep 2024 10:24:30 -0400
Message-ID: <CAHC9VhRdQAoiKMVVUiDyCbEd4EDL9ppH3V4xRGhoOoFmHFy8nQ@mail.gmail.com>
Subject: Re: [PATCH] LSM: allow loadable kernel module based LSM modules
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-security-module <linux-security-module@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, tomoyo-dev-en@lists.osdn.me, 
	tomoyo-users-en@lists.osdn.me, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 3:43=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2024/09/04 23:23, Paul Moore wrote:
> > On Wed, Sep 4, 2024 at 3:10=E2=80=AFAM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:

...

> If you ignore my concern, I have to NACK the static call changes you are
> going to send in the upcoming merge window.

I'm not ignoring your concern, I've responded to your emails and
patches on the topic over, and over, and over, and over again by
trying to explain to you that your goal of supporting out-of-tree LSMs
regardless of the impact to the upstream LSM effort is not something
that is acceptable to the upstream LSM effort, or the Linux kernel in
general.

I've already recorded your NACK on several patches on two of the four
static call commits, if you like I can add it to the other two please
let me know and I'll be sure to do that.  I've recorded your NACKs on
other patches in the past and mentioned those NACKs to Linus when
sending the pull request, and I will do so again during this upcoming
merge window.

--=20
paul-moore.com

