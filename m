Return-Path: <linux-kernel+bounces-525129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF8FA3EB2A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 04:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC6A19C5D33
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 03:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D071F7075;
	Fri, 21 Feb 2025 03:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="a4RAVbIO"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B431F3FC0
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 03:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740107803; cv=none; b=l7qNq/5Bq/55iKQC4IPMXpL28RAosyaz8iPK0EqTaRVtPAcdX3T8fVVm6Mehl8eyAROaQkSswIssMYtkQXZyDJPywJjgoT5JplgexAoR55KVyZ6yJJsoygpfxI2FWNHnMGRQsjxRL/BlwQM0HSLeOxOJAahr0WJ24tlEPG2VSmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740107803; c=relaxed/simple;
	bh=kdrOUzgVVdFR3sHFxXYQEjkbdG9MBlaaptabQxv0kQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/yhH0jUGhJUAu3yqg79OVVrDdPps63rH4Q8AFZjXSJyBESOltYlvygcFqvXZ6WNFIa1XLHgOI1Dol5VPItp8QVstCNEeI1eWImeWolaecTkBjiag3F3Z+T0qaJZ41Uxol8TfkLsQkMEwm95oRLNkcG3t6lWfFKj01etreXQFcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=a4RAVbIO; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-52099627b5aso1113066e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 19:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740107801; x=1740712601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkwUVxurgul/K7FCcMY+3Tk9R0xuunIgonMxNv/xP3Q=;
        b=a4RAVbIOfJ9x4isztn4snzAIQkKsa2B4Ev/2g9k8qeTpj9xGOAW87HuLHh5HVLExoX
         lzAadz9B0iCjyj/k2wlypSEkZdlaov3Kur7BqYAC/qDAmeXIfHGOeyp6HJAe5/dT1+qR
         +Q5bAVtg/QIEE+y+DUnyABwyURrH2xk3DqWvEwbSjsO8HgBmu5JYgMxYfgKXFlYKfA+K
         h+YHXjAZ/MOqhqi3GJLJOUw7hn1WZZtlMLmy1iAss+p4Q6wEke2fx08JzXfhveqn9TWY
         R0UaJaovVuhL6I5AXhPbom6thjGdPXeGd+8Yq354mUBhZTB4FO7GDPvrGbHvAUu2V+77
         3icg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740107801; x=1740712601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DkwUVxurgul/K7FCcMY+3Tk9R0xuunIgonMxNv/xP3Q=;
        b=HsOIf8E3h4aDNZfqauEgbCdhCSc1ruHvf9tNPRpjdSsmb24oNadSSAVSxETmhpN/dy
         +s/RmP3+RDKRGGQt7YMl9abbJNCMFFo6W/HyJS/H+KgDGIj2dAwo9gWk9Q1NyD1Ivzxa
         pfJn4TdZ2OSkoFRFcxiZhG1VQiTj0iZ4rWxUQE4V/Fv1ABgaqugMii5pvEkOgnq7Aivl
         ig71khjXJPq6ResIzSyaeO4DWxfMjHw/ZQR4tY5xxon4vBY4Y/KsV+0VzEZAZ7MYEzfa
         kEiM211oQfc8UamhB3g1GMzQAu/4CDfTT1x8fJaspDCLNKY67o8mha35mOJcJvvZfrTF
         RSLA==
X-Forwarded-Encrypted: i=1; AJvYcCVjZTxo1P6bhnLA6mi8f+h5rSkEzvfoMxyCqZp2kdu42k/vlja4sYC9LN535EwJSR/K/SRNL2IRG/QQjzU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd53bDYrYvWM2jYpc5ZygX4nNg3PjGezZzy4aSMDhxKhtM5oi9
	jNHm9FBOHRRhYVHFxrj8k5h99od1Ox93gmugXcfoLuDZSPYQgdTO2863i55gnJZFjDZHKoESW1c
	dG7r20vmBQpKLpxGebmYTCUoV2C2ZhIsU4iMp
X-Gm-Gg: ASbGnctB/Uc7PqBUjhcms5t5jz3Q1U0P+LAr2fqebYImStpo7m7mns89ne6tj4XlZaz
	a5lHAsyhkQ73Yq7+o4yCobIOH3x7y48y70Y5e9iwAzoH9no89KDd29tZuIVuPOWo0DrbNhq8iD2
	QlMD6id5k=
X-Google-Smtp-Source: AGHT+IH4wi2+Fbki2I5z7rt08OZ60QpOG7qQiecIvmmUTNGESL+MgXrnaybH2kx63UDin7eeHdz7nGr7qRecyFqb7AQ=
X-Received: by 2002:a05:6122:1789:b0:520:a84c:1b59 with SMTP id
 71dfb90a1353d-521dcfc0dd1mr3393922e0c.5.1740107801011; Thu, 20 Feb 2025
 19:16:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023212158.18718-1-casey@schaufler-ca.com>
 <20241023212158.18718-5-casey@schaufler-ca.com> <CAEjxPJ56H_Y-ObgNHrCggDK28NOARZ0CDmLDRvY5qgzu=YgE=A@mail.gmail.com>
 <CAHC9VhSSpLx=ku7ZJ7qVxHHyOZZPQWs_hoxVRZpTfhOJ=T2X9w@mail.gmail.com>
 <CAHC9VhQUUOqh3j9mK5eaVOc6H7JXsjH8vajgrDOoOGOBTszWQw@mail.gmail.com>
 <CAEjxPJ6-jL=h-Djxp5MGRbTexQF1vRDPNcwpxCZwFM22Gja0dg@mail.gmail.com>
 <CAEjxPJ5KTJ1DDaAJ89sSdxUetbP_5nHB5OZ0qL18m4b_5N10-w@mail.gmail.com>
 <1b6af217-a84e-4445-a856-3c69222bf0ed@schaufler-ca.com> <CAEjxPJ44NNZU7u7vLN_Oj4jeptZ=Mb9RkKvJtL=xGciXOWDmKA@mail.gmail.com>
 <eba48af3-a8ef-4220-87a1-c86b96bcdad8@schaufler-ca.com> <CAEjxPJ7aXgOCP4+1Lbfe2b5fjB9Mu1n2h2juDY1RjPgP10PUxQ@mail.gmail.com>
 <784b9c6d-22e1-44d0-86f8-d2b13c4b0e11@schaufler-ca.com>
In-Reply-To: <784b9c6d-22e1-44d0-86f8-d2b13c4b0e11@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 20 Feb 2025 22:16:30 -0500
X-Gm-Features: AWEUYZmAClGRobwy2rc6ntcXOfyVW75ozxug9Z5R0cdhhnSfjf0Qve2WSPi3N4M
Message-ID: <CAHC9VhT968J3zBxtzJcnW+6AKzDKA4MzBgMYoHHXsEaREAe=ww@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] LSM: lsm_context in security_dentry_init_security
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, 
	ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 4:08=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> Adding the lsm_context was cleaner. Not worth yet another roadblock.
> I will have a patch asap. I'm dealing with a facilities issue at
> Smack Labs (whole site being painted, everything in disarray) that
> is slowing things down.

Sorry for the delay today, I was distracted by some meetings and
wrestling with gcc v15 on my Fedora Rawhide dev/test system while I
try to test the LSM init patchset.  Anyway, I'll add my comments to
Stephen's formal patch posting.

--=20
paul-moore.com

